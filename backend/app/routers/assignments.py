import logging
from datetime import datetime, timezone
from fastapi import APIRouter, BackgroundTasks, Depends, HTTPException, status
from uuid import UUID
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user, require_role
from app.schemas.assignment import AssignmentUpdate, AssignReviewerRequest
from app.services.routing_engine import advance_routing
from app.services.scoring import award_points
from app.services.notification_service import send_notification
from app.services.email_service import send_reviewer_assignment_email
from app.config import get_settings

logger = logging.getLogger("assignments")
router = APIRouter(prefix="/assignments", tags=["Assignments"])


def _enrich_assignments(assignments: list[dict]) -> list[dict]:
    """
    Joins submission title, status, account_name, and submitter_name onto each assignment row.
    Handles mixed lead/idea assignment lists in a single batch.
    """
    if not assignments:
        return assignments

    supabase = get_supabase_admin()

    lead_ids = [a["submission_id"] for a in assignments if a["submission_type"] == "lead"]
    idea_ids = [a["submission_id"] for a in assignments if a["submission_type"] == "idea"]

    leads_map: dict = {}
    ideas_map: dict = {}

    if lead_ids:
        result = (
            supabase.table("leads")
            .select("lead_id, title, status, submitted_by, account:accounts(account_name)")
            .in_("lead_id", lead_ids)
            .execute()
        )
        leads_map = {r["lead_id"]: r for r in (result.data or [])}

    if idea_ids:
        result = (
            supabase.table("value_ideas")
            .select("idea_id, title, status, submitted_by, account:accounts(account_name)")
            .in_("idea_id", idea_ids)
            .execute()
        )
        ideas_map = {r["idea_id"]: r for r in (result.data or [])}

    # Collect all unique submitter IDs to fetch in one batch
    submitter_ids: set[str] = set()
    for a in assignments:
        sid = a["submission_id"]
        sub = leads_map.get(sid) if a["submission_type"] == "lead" else ideas_map.get(sid)
        if sub and sub.get("submitted_by"):
            submitter_ids.add(sub["submitted_by"])

    profiles_map: dict = {}
    if submitter_ids:
        profiles_result = (
            supabase.table("profiles")
            .select("id, full_name")
            .in_("id", list(submitter_ids))
            .execute()
        )
        profiles_map = {r["id"]: r for r in (profiles_result.data or [])}

    for a in assignments:
        sid = a["submission_id"]
        if a["submission_type"] == "lead":
            sub = leads_map.get(sid, {})
        else:
            sub = ideas_map.get(sid, {})

        a["submission_title"] = sub.get("title")
        a["submission_status"] = sub.get("status")
        a["account_name"] = (sub.get("account") or {}).get("account_name")

        submitter_id = sub.get("submitted_by")
        profile = profiles_map.get(submitter_id, {}) if submitter_id else {}
        a["submitter_name"] = profile.get("full_name") or None

    return assignments


@router.get("/mine")
async def get_my_assignments(
    action_filter: str | None = None,
    current_user: dict = Depends(get_current_user),
):
    """Return all assignments for the current user, enriched with submission details."""
    supabase = get_supabase_admin()

    query = (
        supabase.table("assignments")
        .select("*, assignee:profiles!assigned_to(id, full_name, email, role)")
        .eq("assigned_to", current_user["id"])
        .order("due_date", desc=False)
    )

    if action_filter:
        query = query.eq("action_taken", action_filter)

    result = query.execute()
    return _enrich_assignments(result.data or [])


@router.get("/all")
async def get_all_assignments(
    action_filter: str | None = None,
    submission_type: str | None = None,
    current_user: dict = Depends(require_role("admin", "executive")),
):
    """Admin/Executive: view all assignments across the organisation."""
    supabase = get_supabase_admin()

    query = (
        supabase.table("assignments")
        .select("*, assignee:profiles!assigned_to(id, full_name, email, role)")
        .order("due_date", desc=False)
    )

    if action_filter:
        query = query.eq("action_taken", action_filter)
    if submission_type:
        query = query.eq("submission_type", submission_type)

    result = query.execute()
    return _enrich_assignments(result.data or [])


@router.get("/{assignment_id}")
async def get_assignment(
    assignment_id: UUID,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    result = (
        supabase.table("assignments")
        .select("*, assignee:profiles!assigned_to(id, full_name, email, role)")
        .eq("assignment_id", str(assignment_id))
        .single()
        .execute()
    )

    if not result.data:
        raise HTTPException(status_code=404, detail="Assignment not found")

    assignment = result.data
    is_assigned = assignment["assigned_to"] == current_user["id"]
    is_privileged = current_user["role"] in ("admin", "executive")

    if not is_assigned and not is_privileged:
        raise HTTPException(status_code=403, detail="Not authorized to view this assignment")

    return _enrich_assignments([assignment])[0]


@router.patch("/{assignment_id}")
async def update_assignment(
    assignment_id: UUID,
    payload: AssignmentUpdate,
    background_tasks: BackgroundTasks,
    current_user: dict = Depends(get_current_user),
):
    """Update action_taken and notes. Triggers routing advancement on approve/reject."""
    supabase = get_supabase_admin()

    existing = (
        supabase.table("assignments")
        .select("assigned_to, action_taken")
        .eq("assignment_id", str(assignment_id))
        .single()
        .execute()
    )

    if not existing.data:
        raise HTTPException(status_code=404, detail="Assignment not found")

    is_assigned = existing.data["assigned_to"] == current_user["id"]
    is_privileged = current_user["role"] in ("admin", "executive")

    if not is_assigned and not is_privileged:
        raise HTTPException(status_code=403, detail="Not authorized to update this assignment")

    # The DB constraint on action_taken only allows:
    # pending, reviewed, approved, rejected, escalated
    # "won" and "lost" are semantic actions — we close the assignment as "approved"
    # and handle the lead status update in the background task.
    db_action = "approved" if payload.action_taken in ("won", "lost") else payload.action_taken

    update_data: dict = {"action_taken": db_action}
    if payload.notes is not None:
        update_data["notes"] = payload.notes
    if payload.action_taken != "pending":
        update_data["action_date"] = datetime.now(timezone.utc).isoformat()

    result = (
        supabase.table("assignments")
        .update(update_data)
        .eq("assignment_id", str(assignment_id))
        .execute()
    )

    logger.info(
        "[ASSIGN] Assignment %s action=%s (db=%s) by %s",
        assignment_id, payload.action_taken, db_action, current_user.get("full_name"),
    )

    # Stage 1 (under_review) and Stage 2 (qualified) approvals/rejections go through advance_routing
    if payload.action_taken in ("approved", "rejected"):
        background_tasks.add_task(
            advance_routing,
            assignment_id=str(assignment_id),
            action=payload.action_taken,
            actor_id=current_user["id"],
            rejection_remarks=payload.rejection_remarks,
        )

    # Stage 3 (opportunity_created): won / lost — update lead status, award points, notify
    if payload.action_taken in ("won", "lost"):
        background_tasks.add_task(
            _handle_post_qualified_action,
            assignment_id=str(assignment_id),
            action=payload.action_taken,
            actor_id=current_user["id"],
            notes=payload.notes or "",
        )

    return result.data[0]


@router.post("/{assignment_id}/assign-reviewer")
async def assign_reviewer(
    assignment_id: UUID,
    payload: AssignReviewerRequest,
    current_user: dict = Depends(get_current_user),
):
    """
    For a 'New Account Review' assignment (status routing_pending), let the holder
    pick a reviewer from the executive pool. This:
      - Updates the lead to 'under_review'
      - Creates a new pending assignment for the chosen reviewer (role='Reviewer')
      - Closes the current assignment as 'reviewed' with notes "Routed to <Name>"
      - Sends an in-app notification + email to the new reviewer
    """
    supabase = get_supabase_admin()
    reviewer_id = str(payload.reviewer_id)

    asgn_res = (
        supabase.table("assignments")
        .select("assignment_id, submission_type, submission_id, assigned_to, assigned_role, action_taken")
        .eq("assignment_id", str(assignment_id))
        .single()
        .execute()
    )
    if not asgn_res.data:
        raise HTTPException(status_code=404, detail="Assignment not found")
    asgn = asgn_res.data

    is_assigned = asgn["assigned_to"] == current_user["id"]
    is_privileged = current_user["role"] in ("admin", "executive")
    if not is_assigned and not is_privileged:
        raise HTTPException(status_code=403, detail="Not authorized to assign reviewer for this assignment")

    if asgn["assigned_role"] != "New Account Review" or asgn["action_taken"] != "pending":
        raise HTTPException(
            status_code=400,
            detail="Not a routable new-account assignment (must be 'New Account Review' and pending)",
        )

    if asgn["submission_type"] != "lead":
        raise HTTPException(status_code=400, detail="Only lead assignments can be routed to a reviewer")

    if reviewer_id == asgn["assigned_to"]:
        raise HTTPException(status_code=400, detail="Cannot assign the lead to yourself")

    # Validate reviewer profile
    reviewer_res = (
        supabase.table("profiles")
        .select("id, full_name, email, role, is_active")
        .eq("id", reviewer_id)
        .single()
        .execute()
    )
    if not reviewer_res.data:
        raise HTTPException(status_code=404, detail="Reviewer profile not found")
    reviewer = reviewer_res.data
    if reviewer.get("role") != "executive" or not reviewer.get("is_active", False):
        raise HTTPException(status_code=400, detail="Reviewer must be an active executive")

    lead_id = asgn["submission_id"]

    # Load lead for status/title/account
    lead_res = (
        supabase.table("leads")
        .select("title, status, account_id")
        .eq("lead_id", lead_id)
        .single()
        .execute()
    )
    if not lead_res.data:
        raise HTTPException(status_code=404, detail="Lead not found")
    lead = lead_res.data

    account_name = "Unknown Account"
    if lead.get("account_id"):
        try:
            acct = (
                supabase.table("accounts")
                .select("account_name")
                .eq("account_id", lead["account_id"])
                .single()
                .execute()
            )
            account_name = (acct.data or {}).get("account_name", account_name)
        except Exception:
            pass

    # 1) Lead → under_review
    supabase.table("leads").update({"status": "under_review"}).eq("lead_id", lead_id).execute()

    # 2) Create new reviewer assignment
    now = datetime.now(timezone.utc)
    due = now.replace(microsecond=0)
    from datetime import timedelta
    due = now + timedelta(days=7)
    new_asgn_payload = {
        "submission_type": "lead",
        "submission_id": lead_id,
        "assigned_to": reviewer_id,
        "assigned_role": "Reviewer",
        "assigned_by": "manual",
        "due_date": due.isoformat(),
        "action_taken": "pending",
    }
    new_asgn_res = supabase.table("assignments").insert(new_asgn_payload).execute()
    new_assignment = (new_asgn_res.data or [{}])[0]

    # 3) Close original assignment
    routing_note = f"Routed to {reviewer.get('full_name') or reviewer.get('email')}"
    if payload.notes:
        routing_note += f" — {payload.notes.strip()}"
    supabase.table("assignments").update(
        {
            "action_taken": "reviewed",
            "action_date": now.isoformat(),
            "notes": routing_note,
        }
    ).eq("assignment_id", str(assignment_id)).execute()

    # 4) In-app notification to new reviewer
    try:
        send_notification(
            recipient_id=reviewer_id,
            submission_type="lead",
            submission_id=lead_id,
            notification_type="approval",
            message=(
                f'You have been assigned to review the new-account lead "{lead.get("title", "")}" '
                f'by {current_user.get("full_name") or current_user.get("email")}.'
            ),
        )
    except Exception as exc:
        logger.exception("[ASSIGN] Notification to reviewer %s failed: %s", reviewer_id, exc)

    # 5) Email to new reviewer
    try:
        send_reviewer_assignment_email(
            reviewer_email=reviewer.get("email", ""),
            reviewer_name=reviewer.get("full_name") or reviewer.get("email", ""),
            role_label="Reviewer",
            submission_type="lead",
            submission_id=lead_id,
            title=lead.get("title", ""),
            account_name=account_name,
        )
    except Exception as exc:
        logger.exception("[ASSIGN] Email to reviewer %s failed: %s", reviewer.get("email"), exc)

    logger.info(
        "[ASSIGN] Lead %s routed: %s -> %s by actor %s",
        lead_id, current_user.get("full_name"), reviewer.get("full_name"), current_user["id"],
    )

    return new_assignment


async def _handle_post_qualified_action(
    assignment_id: str,
    action: str,
    actor_id: str,
    notes: str,
) -> None:
    """
    Handles Stage 3: won / lost decision on a lead that is opportunity_created.
    Updates lead status, awards points, sends notification + email to submitter.
    opportunity_created transition is handled by routing_engine.advance_routing (Stage 2).
    """
    from app.services.email_service import send_submitter_status_email
    from app.services.routing_engine import _get_profile, _send_notification

    if action not in ("won", "lost"):
        logger.warning("[ASSIGN] _handle_post_qualified_action called with unsupported action=%s", action)
        return

    supabase = get_supabase_admin()

    asgn_res = (
        supabase.table("assignments")
        .select("submission_type, submission_id, assigned_to")
        .eq("assignment_id", assignment_id)
        .single()
        .execute()
    )
    if not asgn_res.data or asgn_res.data["submission_type"] != "lead":
        return

    lead_id = asgn_res.data["submission_id"]

    lead_res = (
        supabase.table("leads")
        .select("title, submitted_by, status, account_id")
        .eq("lead_id", lead_id)
        .single()
        .execute()
    )
    if not lead_res.data:
        return

    lead         = lead_res.data
    title        = lead["title"]
    submitter_id = lead["submitted_by"]
    account_id   = lead["account_id"]

    # Guard: won/lost only valid from opportunity_created
    if lead["status"] != "opportunity_created":
        logger.warning(
            "[ASSIGN] Cannot set %s on lead %s — current status is %s (expected opportunity_created)",
            action, lead_id, lead["status"],
        )
        return

    new_status = action  # "won" or "lost"
    supabase.table("leads").update({"status": new_status}).eq("lead_id", lead_id).execute()
    logger.info("[ASSIGN] Lead %s → %s by actor %s", lead_id, new_status, actor_id)

    # Audit: opportunity_created → won/lost (AC-15)
    try:
        from app.services.tracking import record_status_change
        record_status_change(
            submission_type="lead",
            submission_id=lead_id,
            from_status="opportunity_created",
            to_status=new_status,
            changed_by=actor_id,
            reason=(notes.strip() or None) if isinstance(notes, str) else None,
        )
    except Exception as exc:
        logger.exception("[ASSIGN] Failed to record %s audit entry: %s", action, exc)

    # Award points
    points_event = "deal_won" if action == "won" else "deal_lost"
    if submitter_id:
        try:
            award_points(submitter_id, "lead", lead_id, points_event)
        except Exception as exc:
            logger.exception("[ASSIGN] Points award failed: %s", exc)

    # Fetch account name
    account_name = "Unknown Account"
    if account_id:
        try:
            acct = supabase.table("accounts").select("account_name").eq("account_id", account_id).single().execute()
            account_name = (acct.data or {}).get("account_name", account_name)
        except Exception:
            pass

    actor_profile = _get_profile(supabase, actor_id)
    actor_name = actor_profile.get("full_name", "Reviewer")

    msg = (
        f'Congratulations! Your lead "{title}" has been marked as Won. Great work!'
        if action == "won"
        else f'Your lead "{title}" has been marked as Lost.'
    )
    if submitter_id:
        send_notification(
            recipient_id=submitter_id,
            submission_type="lead",
            submission_id=lead_id,
            notification_type="status_update",
            message=msg,
        )

    submitter_profile = _get_profile(supabase, submitter_id) if submitter_id else {}
    submitter_email = submitter_profile.get("email", "")
    submitter_name  = submitter_profile.get("full_name", "")
    if submitter_email:
        try:
            send_submitter_status_email(
                submitter_email=submitter_email,
                submitter_name=submitter_name or submitter_email,
                submission_type="lead",
                submission_id=lead_id,
                title=title,
                account_name=account_name,
                new_status=new_status,
                actor_name=actor_name,
                actor_role="Reviewer",
            )
        except Exception as exc:
            logger.exception("[ASSIGN] Email failed for %s: %s", action, exc)
