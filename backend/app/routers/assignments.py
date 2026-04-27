import logging
from datetime import datetime, timezone
from fastapi import APIRouter, BackgroundTasks, Depends, HTTPException, status
from uuid import UUID
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user, require_role
from app.schemas.assignment import AssignmentUpdate
from app.services.routing_engine import advance_routing
from app.services.scoring import award_points
from app.services.notification_service import send_notification

logger = logging.getLogger("assignments")
router = APIRouter(prefix="/assignments", tags=["Assignments"])


def _enrich_assignments(assignments: list[dict]) -> list[dict]:
    """
    Joins submission title, status, and account_name onto each assignment row.
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
            .select("lead_id, title, status, account:accounts(account_name)")
            .in_("lead_id", lead_ids)
            .execute()
        )
        leads_map = {r["lead_id"]: r for r in (result.data or [])}

    if idea_ids:
        result = (
            supabase.table("value_ideas")
            .select("idea_id, title, status, account:accounts(account_name)")
            .in_("idea_id", idea_ids)
            .execute()
        )
        ideas_map = {r["idea_id"]: r for r in (result.data or [])}

    for a in assignments:
        sid = a["submission_id"]
        if a["submission_type"] == "lead":
            sub = leads_map.get(sid, {})
        else:
            sub = ideas_map.get(sid, {})

        a["submission_title"] = sub.get("title")
        a["submission_status"] = sub.get("status")
        a["account_name"] = (sub.get("account") or {}).get("account_name")

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

    update_data: dict = {"action_taken": payload.action_taken}
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

    logger.info("[ASSIGN] Assignment %s action_taken=%s by %s", assignment_id, payload.action_taken, current_user.get("full_name"))

    # Advance the routing chain when the reviewer approves or rejects
    if payload.action_taken in ("approved", "rejected"):
        background_tasks.add_task(
            advance_routing,
            assignment_id=str(assignment_id),
            action=payload.action_taken,
            actor_id=current_user["id"],
        )

    # Opportunity created / won / lost — reviewer-only post-qualified actions
    if payload.action_taken in ("opportunity_created", "won", "lost"):
        background_tasks.add_task(
            _handle_post_qualified_action,
            assignment_id=str(assignment_id),
            action=payload.action_taken,
            actor_id=current_user["id"],
            notes=payload.notes or "",
        )

    return result.data[0]


async def _handle_post_qualified_action(
    assignment_id: str,
    action: str,
    actor_id: str,
    notes: str,
) -> None:
    """
    Handles opportunity_created / won / lost transitions after a lead is qualified.
    Updates lead status, awards points, sends in-app notification + email to submitter.
    """
    from app.services.email_service import send_submitter_status_email
    from app.services.routing_engine import _get_profile, _send_notification

    supabase = get_supabase_admin()

    # Fetch the assignment to get lead info
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

    # Fetch the lead
    lead_res = (
        supabase.table("leads")
        .select("title, submitted_by, status, account_id")
        .eq("lead_id", lead_id)
        .single()
        .execute()
    )
    if not lead_res.data:
        return

    lead       = lead_res.data
    title      = lead["title"]
    submitter_id = lead["submitted_by"]
    account_id = lead["account_id"]

    # Map action → lead status
    status_map = {
        "opportunity_created": "opportunity_created",
        "won":  "won",
        "lost": "lost",
    }
    new_status = status_map[action]

    # Guard: only allow these transitions from valid prior states
    valid_prior = {
        "opportunity_created": {"qualified"},
        "won":  {"opportunity_created"},
        "lost": {"opportunity_created", "qualified"},
    }
    if lead["status"] not in valid_prior[action]:
        logger.warning(
            "[ASSIGN] Cannot set %s on lead %s — current status is %s",
            action, lead_id, lead["status"],
        )
        return

    # Update lead status
    supabase.table("leads").update({"status": new_status}).eq("lead_id", lead_id).execute()
    logger.info("[ASSIGN] Lead %s → %s by actor %s", lead_id, new_status, actor_id)

    # Award points to submitter
    points_event = {"opportunity_created": "opportunity_created", "won": "deal_won", "lost": "deal_lost"}.get(action)
    if points_event and submitter_id:
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

    # Actor profile
    actor_profile = _get_profile(supabase, actor_id)
    actor_name = actor_profile.get("full_name", "Reviewer")

    # Notification messages
    msg_map = {
        "opportunity_created": f'Your lead "{title}" has been moved to Opportunity Created — the team is now actively working on it.',
        "won":  f'Congratulations! Your lead "{title}" has been marked as Won. Great work!',
        "lost": f'Your lead "{title}" has been marked as Lost.',
    }
    if submitter_id:
        send_notification(
            recipient_id=submitter_id,
            submission_type="lead",
            submission_id=lead_id,
            notification_type="status_update",
            message=msg_map[action],
        )

    # Email to submitter
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
