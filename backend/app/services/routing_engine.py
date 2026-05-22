"""
Sequential routing engine powered by the dynamic account_stakeholders table.

On submission:  start_routing() queries account_stakeholders ordered by step_order
                and creates an assignment for the first reviewer.
                If the table has no rows for the account the submission is put into
                "routing_pending" status so an admin can add stakeholders later.

On approval:    advance_routing() finds the current reviewer's position in the chain
                (by matching assigned_to user_id), creates an assignment for the next
                reviewer, and notifies the submitter of each step.
                When the last reviewer approves the submission status is set to "approved".

On rejection:   the submission status is set to "rejected" and the submitter is notified.
"""

import logging
from datetime import datetime, timedelta, timezone
from uuid import UUID
from app.database.supabase import get_supabase_admin
from app.services.email_service import (
    send_submission_email,
    send_reviewer_assignment_email,
    send_submitter_status_email,
    send_new_lead_under_review_email,
)

logger = logging.getLogger("routing_engine")


# ── Internal helpers ─────────────────────────────────────────────────────────

def _uuid_key(value) -> str:
    """Normalize UUID values from PostgREST / drivers so assignment ↔ stakeholder joins match."""
    if value is None:
        return ""
    s = str(value).strip()
    if not s:
        return ""
    try:
        return str(UUID(s)).lower()
    except (ValueError, TypeError):
        return s.lower()


def _due_date() -> str:
    return (datetime.now(timezone.utc) + timedelta(days=7)).isoformat()


def _get_stakeholders(supabase, account_id: str) -> list[dict]:
    """Return stakeholders for an account ordered by step_order, ascending."""
    aid = _uuid_key(account_id) or str(account_id or "").strip()
    if not aid:
        return []
    result = (
        supabase.table("account_stakeholders")
        .select("id, user_id, role_label, step_order")
        .eq("account_id", aid)
        .order("step_order")
        .execute()
    )
    return result.data or []


def _get_vertical_stakeholders(supabase, account_id: str) -> list[dict]:
    """
    Build a synthetic stakeholder chain from org-level vertical/region config.
    Chain order: DU (step 1) → DH (step 2) → regional Sales (step 3+) → copy-all (last).
    If a valid chain is resolved it is also persisted into account_stakeholders so
    advance_routing() can step through it normally using the existing mechanism.
    Returns an empty list if vertical routing is not configured for this account.
    """
    # Fetch account's industry (= vertical) and region
    acct_res = (
        supabase.table("accounts")
        .select("industry, region")
        .eq("account_id", account_id)
        .single()
        .execute()
    )
    acct = acct_res.data or {}
    industry = acct.get("industry")
    region   = acct.get("region")

    if not industry:
        logger.warning("[ROUTE] Account %s has no industry — cannot resolve vertical routing", account_id)
        return []

    # Look up vertical → DU + DH
    vr_res = (
        supabase.table("vertical_routing")
        .select("du_user_id, dh_user_id")
        .eq("vertical_name", industry)
        .execute()
    )
    vr = (vr_res.data or [None])[0]
    if not vr:
        logger.warning("[ROUTE] No vertical routing entry for industry '%s'", industry)
        return []

    # Look up region → sales + copy-all contacts
    rsm_res = (
        supabase.table("region_sales_mapping")
        .select("sales_user_id, copy_all, region_name")
        .execute()
    )
    all_sales = rsm_res.data or []

    regional_sales = [
        s["sales_user_id"] for s in all_sales
        if not s.get("copy_all") and s.get("region_name") == region
    ]
    copy_all_users = [
        s["sales_user_id"] for s in all_sales
        if s.get("copy_all")
    ]

    # Build ordered chain (skip None user ids)
    chain: list[tuple[str, str]] = []   # (user_id, role_label)
    if vr.get("du_user_id"):
        chain.append((vr["du_user_id"], "Delivery Unit"))
    if vr.get("dh_user_id"):
        chain.append((vr["dh_user_id"], "Delivery Head"))
    for uid in regional_sales:
        chain.append((uid, "Sales"))
    for uid in copy_all_users:
        chain.append((uid, "Copy"))

    if not chain:
        logger.warning("[ROUTE] Vertical routing resolved an empty chain for account %s", account_id)
        return []

    # Persist chain into account_stakeholders so advance_routing works normally
    try:
        rows = [
            {
                "account_id": account_id,
                "user_id":    uid,
                "role_label": label,
                "step_order": idx + 1,
            }
            for idx, (uid, label) in enumerate(chain)
        ]
        # upsert — if rows already exist (duplicate user) skip them gracefully
        supabase.table("account_stakeholders").upsert(
            rows, on_conflict="account_id,user_id"
        ).execute()
        logger.info(
            "[ROUTE] Auto-populated %d stakeholder(s) for account %s from vertical routing",
            len(rows), account_id,
        )
    except Exception as exc:
        logger.exception("[ROUTE] Failed to persist vertical stakeholders: %s", exc)

    # Return in the same shape _get_stakeholders() returns
    return [
        {"user_id": uid, "role_label": label, "step_order": idx + 1}
        for idx, (uid, label) in enumerate(chain)
    ]


def _create_assignment(
    supabase,
    submission_type: str,
    submission_id: str,
    assigned_to: str,
    role_label: str,
    assigned_by: str,
) -> None:
    # assignments.assigned_by is constrained to ('system', 'manual') in migration 005_assignments.sql.
    # Keep the value within that constraint to avoid breaking routing advancement.
    if assigned_by not in ("system", "manual"):
        assigned_by = "manual"
    supabase.table("assignments").insert({
        "submission_type": submission_type,
        "submission_id":   submission_id,
        "assigned_to":     assigned_to,
        "assigned_role":   role_label,
        "assigned_by":     assigned_by,
        "due_date":        _due_date(),
        "action_taken":    "pending",
    }).execute()


def _update_submission_status(supabase, submission_type: str, submission_id: str, new_status: str) -> None:
    if submission_type == "lead":
        supabase.table("leads").update({"status": new_status}).eq("lead_id", submission_id).execute()
    else:
        supabase.table("value_ideas").update({"status": new_status}).eq("idea_id", submission_id).execute()


def _get_submission(supabase, submission_type: str, submission_id: str) -> dict:
    if submission_type == "lead":
        res = supabase.table("leads").select("title, description, submitted_by, account_id, service, contact_details, lead_type").eq("lead_id", submission_id).single().execute()
    else:
        res = supabase.table("value_ideas").select("title, problem_statement, submitted_by, account_id").eq("idea_id", submission_id).single().execute()
    return res.data or {}


def _get_service_stakeholders(supabase, service: str, account_id: str) -> list[dict]:
    """
    Resolve a DU from service_routing (service_name → du_user_id) and persist the
    result into account_stakeholders so advance_routing can walk the chain normally.
    Used as a last-resort fallback when neither per-account nor vertical routing resolves.
    """
    if not service:
        return []
    result = (
        supabase.table("service_routing")
        .select("du_user_id")
        .eq("service_name", service)
        .limit(1)
        .execute()
    )
    row = (result.data or [None])[0]
    if not row or not row.get("du_user_id"):
        logger.warning("[ROUTE] No service_routing entry for service '%s'", service)
        return []

    du_user_id = row["du_user_id"]
    role_label = f"Delivery Unit ({service})"

    # Persist into account_stakeholders so advance_routing works normally
    try:
        supabase.table("account_stakeholders").upsert(
            [{
                "account_id": account_id,
                "user_id":    du_user_id,
                "role_label": role_label,
                "step_order": 1,
            }],
            on_conflict="account_id,user_id",
        ).execute()
        logger.info(
            "[ROUTE] Auto-populated service stakeholder (%s → %s) for account %s",
            service, du_user_id, account_id,
        )
    except Exception as exc:
        logger.exception("[ROUTE] Failed to persist service stakeholder: %s", exc)

    return [{"user_id": du_user_id, "role_label": role_label, "step_order": 1}]


def _get_profile(supabase, user_id: str) -> dict:
    """Return {'full_name': ..., 'email': ...} for a user, or empty dict."""
    if not user_id:
        return {}
    try:
        res = (
            supabase.table("profiles")
            .select("full_name, email")
            .eq("id", user_id)
            .single()
            .execute()
        )
        return res.data or {}
    except Exception as exc:
        logger.warning("_get_profile: failed to fetch profile for user %s: %s", user_id, exc)
        return {}


def _dispatch_submission_email(
    supabase,
    submission_type: str,
    submission_id: str,
    title: str,
    description: str,
    account_id: str,
    submitter_id: str,
    stakeholders: list[dict],
    contact_region: str | None = None,
) -> None:
    """
    Fire-and-forget: gather all required data and call send_submission_email.
    Failures are logged but never raise so they don't break the routing flow.

    contact_region is the region the submitter entered under "Client Contact
    Details" on the lead form. Only this value drives UK/US extra recipients
    (sahil/joe). The account's own region is shown in the email body for
    context but is NOT used for routing.
    """
    try:
        # Account details (name + region — region only used for display)
        acct_res = (
            supabase.table("accounts")
            .select("account_name, region")
            .eq("account_id", account_id)
            .single()
            .execute()
        )
        acct = acct_res.data or {}
        account_name = acct.get("account_name", "Unknown Account")
        display_region = acct.get("region")

        # Submitter profile
        sub_res = (
            supabase.table("profiles")
            .select("full_name, email")
            .eq("id", submitter_id)
            .single()
            .execute()
        )
        sub_profile    = sub_res.data or {}
        submitter_name  = sub_profile.get("full_name", "Unknown")
        submitter_email = sub_profile.get("email", "")

        # Collect stakeholder emails (resolve each user_id → email)
        stakeholder_ids = [s["user_id"] for s in stakeholders]
        stakeholder_emails: list[str] = []
        if stakeholder_ids:
            users_res = (
                supabase.table("profiles")
                .select("id, email")
                .in_("id", stakeholder_ids)
                .execute()
            )
            stakeholder_emails = [u["email"] for u in (users_res.data or []) if u.get("email")]

        send_submission_email(
            submission_type=submission_type,
            submission_id=submission_id,
            title=title,
            description=description,
            account_name=account_name,
            region=display_region,
            routing_region=contact_region,
            submitter_name=submitter_name,
            submitter_email=submitter_email,
            stakeholder_emails=stakeholder_emails,
        )
    except Exception as exc:
        logger.exception("[ROUTE] Email dispatch failed for %s %s: %s", submission_type, submission_id, exc)


def _send_notification(
    supabase,
    recipient_id: str,
    submission_type: str,
    submission_id: str,
    notification_type: str,
    message: str,
) -> None:
    try:
        supabase.table("notifications").insert({
            "recipient_id":    recipient_id,
            "submission_type": submission_type,
            "submission_id":   submission_id,
            "type":            notification_type,
            "message":         message,
            "channel":         "in_app",
        }).execute()
    except Exception as exc:
        logger.exception("Failed to send notification: %s", exc)


# ── Public API ───────────────────────────────────────────────────────────────

async def start_routing(
    submission_type: str,
    submission_id: str,
    account_id: str,
    submitter_id: str,
) -> None:
    """
    Called right after a lead or idea is created. Starts the routing chain.
    Points are awarded here (inside the background task) so they only fire
    when routing actually succeeds — not on routing_pending submissions.
    """
    from app.services.scoring import award_points

    aid = (_uuid_key(account_id) or str(account_id or "").strip()) if account_id else ""
    if not aid:
        logger.error("[ROUTE] start_routing called without account_id for %s %s", submission_type, submission_id)
        return
    account_id = aid

    logger.info("[ROUTE] Starting for %s %s (account %s)", submission_type, submission_id, account_id)
    supabase = get_supabase_admin()

    stakeholders = _get_stakeholders(supabase, account_id)

    if not stakeholders:
        logger.info("[ROUTE] No per-account stakeholders for %s — trying vertical routing", account_id)
        stakeholders = _get_vertical_stakeholders(supabase, account_id)

    sub_early: dict = {}
    if not stakeholders and submission_type == "lead":
        # Final fallback: use the lead's service field to resolve a DU
        sub_early = _get_submission(supabase, "lead", submission_id)
        service = sub_early.get("service")
        if service:
            logger.info("[ROUTE] No vertical routing for account %s — trying service routing (service=%s)", account_id, service)
            stakeholders = _get_service_stakeholders(supabase, service, account_id)

    if not stakeholders:
        logger.warning("[ROUTE] No stakeholders resolved for account %s — routing_pending", account_id)
        _update_submission_status(supabase, submission_type, submission_id, "routing_pending")

        # In-app submission confirmation to submitter even when routing is pending
        if not sub_early:
            sub_early = _get_submission(supabase, submission_type, submission_id)
        _submitter_id_rp = sub_early.get("submitted_by") or submitter_id
        _title_rp = sub_early.get("title", "")
        if _submitter_id_rp:
            _send_notification(
                supabase, _submitter_id_rp, submission_type, submission_id,
                "info",
                f'Your {submission_type} "{_title_rp}" was submitted. Routing is pending — '
                f'an admin will assign a reviewer shortly.',
            )

        # Audit: submitted → routing_pending (AC-15)
        if submission_type == "lead" and _submitter_id_rp:
            try:
                from app.services.tracking import record_status_change
                record_status_change(
                    submission_type="lead",
                    submission_id=submission_id,
                    from_status="submitted",
                    to_status="routing_pending",
                    changed_by=_submitter_id_rp,
                    reason="No stakeholders configured for account",
                )
            except Exception as exc:
                logger.exception("[ROUTE] Failed to record routing_pending audit entry: %s", exc)

        # For new-account leads with no service line: assign Adeesh Jain as reviewer
        # and notify her, but keep the status as routing_pending.
        if submission_type == "lead":
            if not sub_early:
                sub_early = _get_submission(supabase, "lead", submission_id)
            if sub_early.get("lead_type") == "new_lead" and not sub_early.get("service"):
                try:
                    adeesh_res = (
                        supabase.table("profiles")
                        .select("id, full_name, email")
                        .eq("email", "adeesh.jain@testingxperts.com")
                        .limit(1)
                        .execute()
                    )
                    adeesh_rows = adeesh_res.data or []
                    if adeesh_rows:
                        adeesh = adeesh_rows[0]
                        adeesh_uid = adeesh["id"]

                        # Create an assignment so Adeesh sees it in her review queue
                        _create_assignment(
                            supabase,
                            "lead", submission_id,
                            adeesh_uid,
                            "New Account Review",
                            "system",
                        )

                        lead_title = sub_early.get("title", "")

                        # In-app notification to Adeesh
                        _send_notification(
                            supabase, adeesh_uid, "lead", submission_id,
                            "approval",
                            f'A new-account lead "{lead_title}" has been submitted without a service line '
                            f'and requires your review.',
                        )

                        # Email Adeesh
                        from app.config import get_settings as _gs
                        sub_profile = _get_profile(supabase, sub_early.get("submitted_by", ""))
                        acct_res = (
                            supabase.table("accounts")
                            .select("account_name")
                            .eq("account_id", account_id)
                            .single()
                            .execute()
                        )
                        acct_name = (acct_res.data or {}).get("account_name", "Unknown Account")

                        send_new_lead_under_review_email(
                            title=lead_title,
                            account_name=acct_name,
                            submitter_name=sub_profile.get("full_name", "Unknown"),
                            submitter_email=sub_profile.get("email", ""),
                            submission_id=submission_id,
                            portal_url=_gs().portal_url,
                            to_email=adeesh.get("email", "adeesh.jain@testingxperts.com"),
                        )
                        logger.info(
                            "[ROUTE] New-account lead %s (no service) assigned to Adeesh for review; status stays routing_pending",
                            submission_id,
                        )
                    else:
                        logger.warning("[ROUTE] Adeesh profile not found — cannot assign new-account lead %s", submission_id)
                except Exception as exc:
                    logger.exception("[ROUTE] Failed to assign Adeesh for new-account lead %s: %s", submission_id, exc)
            else:
                # Notify admins for other unroutable leads
                admins_res = (
                    supabase.table("profiles")
                    .select("id")
                    .eq("role", "admin")
                    .execute()
                )
                for admin in (admins_res.data or []):
                    _send_notification(
                        supabase, admin["id"], submission_type, submission_id,
                        "info",
                        f"A new {submission_type} was submitted but could not be routed — "
                        f"no stakeholder or vertical routing config found for account {account_id}. "
                        "Please configure stakeholders or vertical routing.",
                    )
        else:
            # Non-lead submissions: notify admins
            admins_res = (
                supabase.table("profiles")
                .select("id")
                .eq("role", "admin")
                .execute()
            )
            for admin in (admins_res.data or []):
                _send_notification(
                    supabase, admin["id"], submission_type, submission_id,
                    "info",
                    f"A new {submission_type} was submitted but could not be routed — "
                    f"no stakeholder or vertical routing config found for account {account_id}. "
                    "Please configure stakeholders or vertical routing.",
                )

        # No points awarded — submission is stuck in routing_pending
        return

    first = stakeholders[0]
    _create_assignment(
        supabase,
        submission_type,
        submission_id,
        first["user_id"],
        first["role_label"],
        "system",
    )

    if submission_type == "lead":
        _update_submission_status(supabase, "lead", submission_id, "under_review")

    # Fetch full submission details for notifications + email
    sub = _get_submission(supabase, submission_type, submission_id)
    title       = sub.get("title", "")
    description = sub.get("description") or sub.get("problem_statement") or ""
    actual_submitter_id = sub.get("submitted_by", submitter_id)

    # Audit trail entry: submitted → under_review (AC-15)
    if submission_type == "lead":
        try:
            from app.services.tracking import record_status_change
            record_status_change(
                submission_type="lead",
                submission_id=submission_id,
                from_status="submitted",
                to_status="under_review",
                changed_by=actual_submitter_id,
                reason=f'Auto-routed to {first["role_label"]}',
            )
        except Exception as exc:
            logger.exception("[ROUTE] Failed to record under_review audit entry: %s", exc)

    # ── Notify Adeesh when a new-account lead goes under review ──────────────
    if submission_type == "lead" and sub.get("lead_type") == "new_lead":
        try:
            acct_res = (
                supabase.table("accounts")
                .select("account_name")
                .eq("account_id", account_id)
                .single()
                .execute()
            )
            acct_name = (acct_res.data or {}).get("account_name", "Unknown Account")

            sub_profile = _get_profile(supabase, actual_submitter_id)
            sub_name    = sub_profile.get("full_name", "Unknown")
            sub_email   = sub_profile.get("email", "")

            # In-app notification to Adeesh (lookup by email)
            adeesh_res = (
                supabase.table("profiles")
                .select("id")
                .eq("email", "adeesh.jain@testingxperts.com")
                .limit(1)
                .execute()
            )
            adeesh_rows = adeesh_res.data or []
            if adeesh_rows:
                _send_notification(
                    supabase, adeesh_rows[0]["id"], "lead", submission_id,
                    "info",
                    f'New account lead "{title}" for "{acct_name}" is now under review. Submitted by {sub_name}.',
                )

            # Email Adeesh
            from app.config import get_settings as _gs
            _portal_url = _gs().portal_url
            send_new_lead_under_review_email(
                title=title,
                account_name=acct_name,
                submitter_name=sub_name,
                submitter_email=sub_email,
                submission_id=submission_id,
                portal_url=_portal_url,
            )
            logger.info("[ROUTE] Adeesh notified of new-account lead %s under review", submission_id)
        except Exception as exc:
            logger.exception("[ROUTE] Failed to notify Adeesh for new-account lead %s: %s", submission_id, exc)

    # Routing label for notifications. Prefer the lead's own service field so the
    # message names the service the user actually picked — `first["role_label"]`
    # is derived from the resolved stakeholder/service_routing row, which can
    # mismatch the lead's service if that table has stale data.
    lead_service = sub.get("service")
    routing_label = (
        f"Delivery Unit ({lead_service})" if lead_service else first["role_label"]
    )

    # In-app notification to the first reviewer
    _send_notification(
        supabase, first["user_id"], submission_type, submission_id,
        "approval",
        f'You have a new {submission_type} awaiting your review as {routing_label}: "{title}".',
    )

    # In-app submission confirmation to submitter (BRD §5.3.2 / §6.1 stage 1 / AC-04)
    if actual_submitter_id:
        _send_notification(
            supabase, actual_submitter_id, submission_type, submission_id,
            "info",
            f'Your {submission_type} "{title}" was submitted and routed to {routing_label} for review.',
        )

    # ── Oversight notification: Adeesh Jain + all admins ────────────────────────
    # Every new lead notifies Adeesh and every admin so leadership has visibility
    # of submissions regardless of who routing assigned the lead to.
    try:
        sub_profile = _get_profile(supabase, actual_submitter_id)
        sub_name = sub_profile.get("full_name") or "a user"

        oversight_ids: set[str] = set()

        admin_res = (
            supabase.table("profiles")
            .select("id")
            .eq("role", "admin")
            .execute()
        )
        for row in (admin_res.data or []):
            if row.get("id"):
                oversight_ids.add(row["id"])

        adeesh_res = (
            supabase.table("profiles")
            .select("id")
            .eq("email", "adeesh.jain@testingxperts.com")
            .limit(1)
            .execute()
        )
        for row in (adeesh_res.data or []):
            if row.get("id"):
                oversight_ids.add(row["id"])

        # Don't double-notify the submitter or the assigned reviewer.
        oversight_ids.discard(actual_submitter_id)
        oversight_ids.discard(first["user_id"])

        for recipient_id in oversight_ids:
            _send_notification(
                supabase, recipient_id, submission_type, submission_id,
                "info",
                f'New {submission_type} "{title}" was submitted by {sub_name} '
                f'and routed to {routing_label}.',
            )
    except Exception as exc:
        logger.exception("[ROUTE] Failed to send oversight notifications for %s: %s", submission_id, exc)

    contact_region: str | None = None

    # ── Trigger email to ALL stakeholders + (UK/US extras only if user-entered) ──
    _dispatch_submission_email(
        supabase=supabase,
        submission_type=submission_type,
        submission_id=submission_id,
        title=title,
        description=description,
        account_id=account_id,
        submitter_id=actual_submitter_id,
        stakeholders=stakeholders,
        contact_region=contact_region,
    )

    # ── Award submission points only after successful routing ─────────────────
    event = "submitted"
    try:
        award_points(actual_submitter_id, submission_type, submission_id, event)
        logger.info("[ROUTE] Points awarded to %s for %s %s", actual_submitter_id, submission_type, submission_id)
    except Exception as exc:
        logger.exception("[ROUTE] Failed to award points for %s %s: %s", submission_type, submission_id, exc)

    logger.info(
        "[ROUTE] Routed %s %s → step %s (%s / %s)",
        submission_type, submission_id,
        first["step_order"], first["role_label"], first["user_id"],
    )


async def advance_routing(
    assignment_id: str,
    action: str,
    actor_id: str,
    rejection_remarks: str | None = None,
) -> None:
    """Called after an assignment is marked approved or rejected.

    rejection_remarks: optional free-text reviewer remarks captured when the
    assignment is rejected. Persisted on the lead row and surfaced in the
    submitter notification + email (BRD AC-06).
    """
    supabase = get_supabase_admin()

    asgn_res = (
        supabase.table("assignments")
        .select("submission_type, submission_id, assigned_to, assigned_role")
        .eq("assignment_id", assignment_id)
        .single()
        .execute()
    )
    if not asgn_res.data:
        return

    asgn       = asgn_res.data
    sub_type   = asgn["submission_type"]
    sub_id     = asgn["submission_id"]
    current_user_id = asgn["assigned_to"]
    current_label   = asgn["assigned_role"]

    sub = _get_submission(supabase, sub_type, sub_id)
    submitter_id = sub.get("submitted_by", "")
    account_raw = sub.get("account_id")
    account_id = (_uuid_key(account_raw) or str(account_raw or "").strip()) if account_raw else ""
    title = sub.get("title", "")

    # Fetch account name for email templates
    try:
        acct_res = supabase.table("accounts").select("account_name").eq("account_id", account_id).single().execute()
        account_name = (acct_res.data or {}).get("account_name", "Unknown Account")
    except Exception:
        account_name = "Unknown Account"

    actor_profile  = _get_profile(supabase, actor_id)
    actor_name     = actor_profile.get("full_name", "Reviewer")

    submitter_profile = _get_profile(supabase, submitter_id) if submitter_id else {}
    submitter_name    = submitter_profile.get("full_name", "")
    submitter_email   = submitter_profile.get("email", "")

    # ── Rejection ───────────────────────────────────────────────────────────
    if action == "rejected":
        remarks = (rejection_remarks or "").strip() or None

        # Persist rejection_remarks on the lead row (leads-only; ideas have their own flow)
        if sub_type == "lead":
            update_payload: dict = {"status": "rejected"}
            if remarks is not None:
                update_payload["rejection_remarks"] = remarks
            supabase.table("leads").update(update_payload).eq("lead_id", sub_id).execute()
        else:
            _update_submission_status(supabase, sub_type, sub_id, "rejected")

        # Audit-trail entry for the rejection (AC-15)
        try:
            from app.services.tracking import record_status_change
            record_status_change(
                submission_type=sub_type,
                submission_id=sub_id,
                from_status="under_review",
                to_status="rejected",
                changed_by=actor_id,
                reason=remarks,
            )
        except Exception as exc:
            logger.exception("[ROUTE] Failed to record rejection audit entry: %s", exc)

        if submitter_id:
            remarks_suffix = f' Reviewer remarks: "{remarks}"' if remarks else ""
            _send_notification(
                supabase, submitter_id, sub_type, sub_id,
                "status_update",
                f'Your {sub_type} "{title}" was rejected by {actor_name} ({current_label}).{remarks_suffix}',
            )
            # Email submitter about rejection
            if submitter_email:
                try:
                    send_submitter_status_email(
                        submitter_email=submitter_email,
                        submitter_name=submitter_name or submitter_email,
                        submission_type=sub_type,
                        submission_id=sub_id,
                        title=title,
                        account_name=account_name,
                        new_status="rejected",
                        actor_name=actor_name,
                        actor_role=current_label,
                        rejection_remarks=remarks,
                    )
                except Exception as exc:
                    logger.exception("[ROUTE] Email failed on rejection: %s", exc)
        logger.info("[ROUTE] %s %s rejected by %s (%s)", sub_type, sub_id, actor_name, current_label)
        return

    # ── Approval ────────────────────────────────────────────────────────────
    if action == "approved":
        # Check current lead status to determine which stage this approval is for.
        # Stages 2 and 3 are handled here before the normal stakeholder-chain logic.
        if sub_type == "lead":
            lead_status_res = supabase.table("leads").select("status").eq("lead_id", sub_id).single().execute()
            current_lead_status = (lead_status_res.data or {}).get("status", "")

            # ── Stage 2: Opportunity approval (qualified → opportunity_created) ──
            if current_lead_status == "qualified":
                from app.services.scoring import award_points as _award
                _update_submission_status(supabase, "lead", sub_id, "opportunity_created")
                # Audit: qualified → opportunity_created (AC-15)
                try:
                    from app.services.tracking import record_status_change
                    record_status_change(
                        submission_type="lead",
                        submission_id=sub_id,
                        from_status="qualified",
                        to_status="opportunity_created",
                        changed_by=actor_id,
                        reason=f"Opportunity created by {actor_name} ({current_label})",
                    )
                except Exception as exc:
                    logger.exception("[ROUTE] Failed to record opportunity_created audit entry: %s", exc)
                if submitter_id:
                    try:
                        _award(submitter_id, "lead", sub_id, "opportunity_created")
                    except Exception as exc:
                        logger.exception("[ROUTE] Failed to award opportunity_created points: %s", exc)
                # Create Won/Lost stage assignment for same reviewer
                _create_assignment(supabase, "lead", sub_id, actor_id, current_label, "system")
                _send_notification(
                    supabase, actor_id, "lead", sub_id,
                    "approval",
                    f'Lead "{title}" is now an Opportunity. Please mark it as Won or Lost.',
                )
                if submitter_id:
                    _send_notification(
                        supabase, submitter_id, "lead", sub_id,
                        "status_update",
                        f'Your lead "{title}" has been moved to Opportunity Created. The team is actively working on it.',
                    )
                logger.info("[ROUTE] Lead %s → opportunity_created, Won/Lost assignment → %s", sub_id, actor_id)
                return

            # ── Stage 3: Won/Lost approval (opportunity_created → won) ──
            # Won/Lost is dispatched via _handle_post_qualified_action with action="won"/"lost",
            # not via advance_routing — so if we somehow land here, skip silently.
            if current_lead_status == "opportunity_created":
                logger.warning(
                    "[ROUTE] advance_routing(approved) called on opportunity_created lead %s — "
                    "won/lost should use action='won'/'lost', not 'approved'. Ignoring.",
                    sub_id,
                )
                return

        # In-app + email to submitter about this step's approval (Stage 1 only)
        if submitter_id:
            _send_notification(
                supabase, submitter_id, sub_type, sub_id,
                "status_update",
                f'Your {sub_type} "{title}" was approved by {actor_name} ({current_label}).',
            )

        # Find the current reviewer's index in the dynamic chain
        if not account_id:
            logger.error(
                "[ROUTE] advance_routing: missing account_id on %s %s; cannot route to next reviewer",
                sub_type,
                sub_id,
            )
            return

        stakeholders = _get_stakeholders(supabase, account_id)
        assignee_key = _uuid_key(current_user_id)

        current_idx = next(
            (i for i, s in enumerate(stakeholders) if _uuid_key(s.get("user_id")) == assignee_key),
            None,
        )

        if current_idx is None and stakeholders:
            current_idx = next(
                (
                    i
                    for i, s in enumerate(stakeholders)
                    if str(s.get("user_id", "")).strip() == str(current_user_id).strip()
                ),
                None,
            )

        if current_idx is None:
            # Reviewer was assigned manually (e.g. via new-account "Assign Reviewer" flow)
            # and is not in the account_stakeholders chain. Treat as a single-step final approval.
            if sub_type == "lead":
                lead_status_res2 = supabase.table("leads").select("status").eq("lead_id", sub_id).single().execute()
                if (lead_status_res2.data or {}).get("status") == "under_review":
                    logger.info(
                        "[ROUTE] Reviewer %s not in stakeholder chain for account %s — "
                        "treating as single-step final approval for lead %s",
                        assignee_key, account_id, sub_id,
                    )
                    # Jump to the final-approval block by setting current_idx to last position
                    current_idx = len(stakeholders) - 1 if stakeholders else -1
                    # Fall through to final approval below (current_idx + 1 >= len means no next step)
                else:
                    logger.error(
                        "[ROUTE] Approved reviewer %s not found in account %s chain and lead is not under_review. "
                        "Chain length=%s steps=%s.",
                        assignee_key, account_id, len(stakeholders),
                        [(s.get("step_order"), _uuid_key(s.get("user_id")), s.get("role_label")) for s in stakeholders],
                    )
                    return
            else:
                logger.error(
                    "[ROUTE] Approved reviewer %s not found in account %s chain. "
                    "Chain length=%s steps=%s.",
                    assignee_key, account_id, len(stakeholders),
                    [(s.get("step_order"), _uuid_key(s.get("user_id")), s.get("role_label")) for s in stakeholders],
                )
                return

        # Intermediate step approval — email submitter that it's progressing
        if submitter_email:
            try:
                send_submitter_status_email(
                    submitter_email=submitter_email,
                    submitter_name=submitter_name or submitter_email,
                    submission_type=sub_type,
                    submission_id=sub_id,
                    title=title,
                    account_name=account_name,
                    new_status="step_approved",
                    actor_name=actor_name,
                    actor_role=current_label,
                )
            except Exception as exc:
                logger.exception("[ROUTE] Email failed on step approval: %s", exc)

        # Walk forward to find the next unactioned reviewer
        if current_idx + 1 < len(stakeholders):
            next_step = stakeholders[current_idx + 1]
            _create_assignment(
                supabase,
                sub_type, sub_id,
                next_step["user_id"],
                next_step["role_label"],
                "manual",
            )
            _send_notification(
                supabase, next_step["user_id"], sub_type, sub_id,
                "approval",
                f'A {sub_type} requires your review as {next_step["role_label"]}: "{title}".',
            )
            # Email the next reviewer
            next_profile = _get_profile(supabase, next_step["user_id"])
            if next_profile.get("email"):
                try:
                    send_reviewer_assignment_email(
                        reviewer_email=next_profile["email"],
                        reviewer_name=next_profile.get("full_name") or next_profile["email"],
                        role_label=next_step["role_label"],
                        submission_type=sub_type,
                        submission_id=sub_id,
                        title=title,
                        account_name=account_name,
                    )
                except Exception as exc:
                    logger.exception("[ROUTE] Email failed for next reviewer: %s", exc)
            logger.info(
                "[ROUTE] Advanced %s %s → step %s (%s / %s)",
                sub_type, sub_id,
                next_step["step_order"], next_step["role_label"], next_step["user_id"],
            )
            return

        # No further steps — final approval
        # For leads: status becomes "qualified" (reviewer has qualified it).
        # For ideas: keep "approved".
        final_status = "qualified" if sub_type == "lead" else "approved"
        prev_status = "under_review" if sub_type == "lead" else "under_review"
        _update_submission_status(supabase, sub_type, sub_id, final_status)

        # Audit: under_review → qualified (AC-15)
        try:
            from app.services.tracking import record_status_change
            record_status_change(
                submission_type=sub_type,
                submission_id=sub_id,
                from_status=prev_status,
                to_status=final_status,
                changed_by=actor_id,
                reason=f"Qualified by {actor_name} ({current_label})",
            )
        except Exception as exc:
            logger.exception("[ROUTE] Failed to record qualified audit entry: %s", exc)

        # Award qualified points (20 pts) to submitter
        if sub_type == "lead" and submitter_id:
            try:
                from app.services.scoring import award_points
                award_points(submitter_id, "lead", sub_id, "qualified")
                logger.info("[ROUTE] Awarded qualified points to %s for lead %s", submitter_id, sub_id)
            except Exception as exc:
                logger.exception("[ROUTE] Failed to award qualified points: %s", exc)

        if submitter_id:
            if sub_type == "lead":
                final_msg = f'Great news! Your lead "{title}" has been qualified by {actor_name}. It will now move to Opportunity review.'
            else:
                final_msg = f'Congratulations! Your {sub_type} "{title}" has been fully approved.'
            _send_notification(
                supabase, submitter_id, sub_type, sub_id,
                "status_update",
                final_msg,
            )
            # Email submitter — qualified/approved
            if submitter_email:
                try:
                    send_submitter_status_email(
                        submitter_email=submitter_email,
                        submitter_name=submitter_name or submitter_email,
                        submission_type=sub_type,
                        submission_id=sub_id,
                        title=title,
                        account_name=account_name,
                        new_status=final_status,
                        actor_name=actor_name,
                        actor_role=current_label,
                    )
                except Exception as exc:
                    logger.exception("[ROUTE] Email failed on final approval: %s", exc)

        logger.info("[ROUTE] Final approval → %s for %s %s", final_status, sub_type, sub_id)

        # ── Auto-create Stage 2 assignment: Opportunity review ────────────────
        # The same reviewer now sees this lead in the Opportunity Created tab
        # and must approve (→ opportunity_created) or reject it.
        if sub_type == "lead":
            try:
                _create_assignment(supabase, "lead", sub_id, actor_id, current_label, "system")
                _send_notification(
                    supabase, actor_id, "lead", sub_id,
                    "approval",
                    f'Lead "{title}" is now Qualified. Please decide whether to create an Opportunity.',
                )
                logger.info("[ROUTE] Stage-2 Opportunity assignment created for lead %s → reviewer %s", sub_id, actor_id)
            except Exception as exc:
                logger.exception("[ROUTE] Failed to create Stage-2 assignment for lead %s: %s", sub_id, exc)
