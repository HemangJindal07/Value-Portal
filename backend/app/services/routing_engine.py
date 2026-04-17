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
        res = supabase.table("leads").select("title, description, submitted_by, account_id").eq("lead_id", submission_id).single().execute()
    else:
        res = supabase.table("value_ideas").select("title, problem_statement, submitted_by, account_id").eq("idea_id", submission_id).single().execute()
    return res.data or {}


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
    except Exception:
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
) -> None:
    """
    Fire-and-forget: gather all required data and call send_submission_email.
    Failures are logged but never raise so they don't break the routing flow.
    """
    try:
        # Account details (name + region)
        acct_res = (
            supabase.table("accounts")
            .select("account_name, region")
            .eq("account_id", account_id)
            .single()
            .execute()
        )
        acct = acct_res.data or {}
        account_name = acct.get("account_name", "Unknown Account")
        region       = acct.get("region")

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

        # ── TEST MODE: redirect stakeholder emails to override address ──────────
        # Before go-live: delete these 6 lines (keep the real stakeholder_emails as-is)
        from app.services.email_service import TEST_OVERRIDE_EMAIL
        if stakeholder_emails:
            logger.info("[ROUTE][TEST] Redirecting %s → %s", stakeholder_emails, TEST_OVERRIDE_EMAIL)
            stakeholder_emails = [TEST_OVERRIDE_EMAIL]
        # ── END TEST MODE ─────────────────────────────────────────────────────

        send_submission_email(
            submission_type=submission_type,
            submission_id=submission_id,
            title=title,
            description=description,
            account_name=account_name,
            region=region,
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

    if not stakeholders:
        logger.warning("[ROUTE] No stakeholders resolved for account %s — routing_pending", account_id)
        _update_submission_status(supabase, submission_type, submission_id, "routing_pending")
        # Notify admins so they can add stakeholder mappings
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

    # In-app notification to the first reviewer
    _send_notification(
        supabase, first["user_id"], submission_type, submission_id,
        "approval",
        f'You have a new {submission_type} awaiting your review as {first["role_label"]}: "{title}".',
    )

    # ── Trigger email to ALL stakeholders + region contacts ──────────────────
    _dispatch_submission_email(
        supabase=supabase,
        submission_type=submission_type,
        submission_id=submission_id,
        title=title,
        description=description,
        account_id=account_id,
        submitter_id=actual_submitter_id,
        stakeholders=stakeholders,
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
) -> None:
    """Called after an assignment is marked approved or rejected."""
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
        _update_submission_status(supabase, sub_type, sub_id, "rejected")
        if submitter_id:
            _send_notification(
                supabase, submitter_id, sub_type, sub_id,
                "status_update",
                f'Your {sub_type} "{title}" was rejected by {actor_name} ({current_label}).',
            )
            # Email submitter about rejection
            if submitter_email:
                try:
                    from app.services.email_service import TEST_OVERRIDE_EMAIL  # TEST: delete before go-live
                    send_submitter_status_email(
                        submitter_email=TEST_OVERRIDE_EMAIL,  # TEST: replace with submitter_email
                        submitter_name=submitter_name or submitter_email,
                        submission_type=sub_type,
                        submission_id=sub_id,
                        title=title,
                        account_name=account_name,
                        new_status="rejected",
                        actor_name=actor_name,
                        actor_role=current_label,
                    )
                except Exception as exc:
                    logger.exception("[ROUTE] Email failed on rejection: %s", exc)
        logger.info("[ROUTE] %s %s rejected by %s (%s)", sub_type, sub_id, actor_name, current_label)
        return

    # ── Approval ────────────────────────────────────────────────────────────
    if action == "approved":
        # In-app + email to submitter about this step's approval
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
            logger.error(
                "[ROUTE] Approved reviewer %s (assignment assignee) not found in account %s chain. "
                "Chain length=%s steps=%s. Will not create next assignment or spuriously finalize — "
                "check account_stakeholders.user_id matches assignments.assigned_to.",
                assignee_key,
                account_id,
                len(stakeholders),
                [
                    (s.get("step_order"), _uuid_key(s.get("user_id")), s.get("role_label"))
                    for s in stakeholders
                ],
            )
            return

        # Intermediate step approval — email submitter that it's progressing
        if submitter_email:
            try:
                from app.services.email_service import TEST_OVERRIDE_EMAIL  # TEST: delete before go-live
                send_submitter_status_email(
                    submitter_email=TEST_OVERRIDE_EMAIL,  # TEST: replace with submitter_email
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
                    from app.services.email_service import TEST_OVERRIDE_EMAIL  # TEST: delete before go-live
                    send_reviewer_assignment_email(
                        reviewer_email=TEST_OVERRIDE_EMAIL,  # TEST: replace with next_profile["email"]
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
        _update_submission_status(supabase, sub_type, sub_id, "approved")
        if submitter_id:
            if sub_type == "lead":
                final_msg = f'Your lead "{title}" has been fully approved through the review chain.'
            else:
                final_msg = f'Congratulations! Your {sub_type} "{title}" has been fully approved.'
            _send_notification(
                supabase, submitter_id, sub_type, sub_id,
                "status_update",
                final_msg,
            )
            # Email submitter final approval
            if submitter_email:
                try:
                    from app.services.email_service import TEST_OVERRIDE_EMAIL  # TEST: delete before go-live
                    send_submitter_status_email(
                        submitter_email=TEST_OVERRIDE_EMAIL,  # TEST: replace with submitter_email
                        submitter_name=submitter_name or submitter_email,
                        submission_type=sub_type,
                        submission_id=sub_id,
                        title=title,
                        account_name=account_name,
                        new_status="approved",
                        actor_name=actor_name,
                        actor_role=current_label,
                    )
                except Exception as exc:
                    logger.exception("[ROUTE] Email failed on final approval: %s", exc)
        logger.info("[ROUTE] Final approval for %s %s", sub_type, sub_id)
