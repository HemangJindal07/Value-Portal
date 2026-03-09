from datetime import datetime, timezone
from fastapi import APIRouter, Depends, HTTPException, status
from uuid import UUID
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user, require_role
from app.schemas.assignment import AssignmentUpdate

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
    current_user: dict = Depends(get_current_user),
):
    """Update action_taken and notes. Only the assigned user or admin/executive can act."""
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

    print(f"[ASSIGN] ✏️  Assignment {assignment_id} updated → action_taken={payload.action_taken} by {current_user['full_name']}")
    return result.data[0]
