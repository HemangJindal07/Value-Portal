from fastapi import APIRouter, BackgroundTasks, Depends, HTTPException, status, Query
from uuid import UUID
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user
from app.schemas.lead import LeadCreate, LeadUpdate, LeadResponse
from app.services.routing_engine import start_routing
from app.services.lead_classifier import classify_lead
from app.services.tracking import record_status_change
from app.services.notification_service import notify_status_change
from app.services.scoring import award_points

router = APIRouter(prefix="/leads", tags=["Leads"])


def _user_can_update_lead_status(supabase, lead: dict, current_user: dict) -> bool:
    """Who may use PATCH to change lead.status (UI: Change Status)."""
    uid = current_user["id"]
    role = current_user["role"]
    if role in ("admin", "executive"):
        return True
    if lead.get("submitted_by") == uid:
        return False
    if role == "sales" and lead.get("status") in ("approved", "qualified"):
        return True
    pending = (
        supabase.table("assignments")
        .select("assignment_id")
        .eq("submission_type", "lead")
        .eq("submission_id", str(lead["lead_id"]))
        .eq("assigned_to", uid)
        .eq("action_taken", "pending")
        .limit(1)
        .execute()
    )
    return bool(pending.data)


@router.get("")
async def list_leads(
    status_filter: str | None = Query(None, alias="status"),
    lead_type: str | None = None,
    account_id: str | None = None,
    priority: str | None = None,
    search: str | None = None,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    query = supabase.table("leads").select(
        "*, account:accounts(account_id, account_name), submitter:profiles!submitted_by(id, full_name, email)"
    )

    if status_filter:
        query = query.eq("status", status_filter)
    if lead_type:
        query = query.eq("lead_type", lead_type)
    if account_id:
        query = query.eq("account_id", account_id)
    if priority:
        query = query.eq("priority", priority)
    if search:
        query = query.ilike("title", f"%{search}%")

    query = query.order("created_at", desc=True)
    result = query.execute()
    return result.data


@router.get("/{lead_id}")
async def get_lead(
    lead_id: UUID,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    result = (
        supabase.table("leads")
        .select(
            "*, account:accounts(account_id, account_name, industry, region), submitter:profiles!submitted_by(id, full_name, email, role)"
        )
        .eq("lead_id", str(lead_id))
        .single()
        .execute()
    )

    if not result.data:
        raise HTTPException(status_code=404, detail="Lead not found")

    row = result.data
    row["can_update_status"] = _user_can_update_lead_status(
        supabase, row, current_user
    )
    return row


@router.post("", status_code=status.HTTP_201_CREATED)
async def create_lead(
    payload: LeadCreate,
    background_tasks: BackgroundTasks,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    data = payload.model_dump(mode="json")
    data["submitted_by"] = current_user["id"]
    data["status"] = "submitted"

    result = supabase.table("leads").insert(data).execute()
    lead = result.data[0]

    background_tasks.add_task(
        start_routing, "lead", str(lead["lead_id"]), str(lead["account_id"]), current_user["id"]
    )
    background_tasks.add_task(classify_lead, str(lead["lead_id"]))

    award_points(current_user["id"], "lead", str(lead["lead_id"]), "submitted")

    return lead


@router.patch("/{lead_id}")
async def update_lead(
    lead_id: UUID,
    payload: LeadUpdate,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()

    existing = (
        supabase.table("leads")
        .select("*")
        .eq("lead_id", str(lead_id))
        .single()
        .execute()
    )
    if not existing.data:
        raise HTTPException(status_code=404, detail="Lead not found")

    user_role = current_user["role"]
    user_id = current_user["id"]
    is_submitter = existing.data["submitted_by"] == user_id
    is_privileged = user_role in ("admin", "executive", "sales")

    if not is_submitter and not is_privileged:
        raise HTTPException(status_code=403, detail="Not authorized")

    update_data = payload.model_dump(exclude_unset=True, mode="json")
    if not update_data:
        out = existing.data.copy()
        out["can_update_status"] = _user_can_update_lead_status(
            supabase, existing.data, current_user
        )
        return out

    old_status = existing.data.get("status")
    new_status = update_data.get("status")

    if new_status is not None and new_status != old_status:
        if is_submitter and user_role not in ("admin", "executive"):
            raise HTTPException(
                status_code=403,
                detail="Submitters cannot change lead status; use My Assignments to track review progress",
            )
        if user_role not in ("admin", "executive"):
            allowed = False
            if (
                user_role == "sales"
                and old_status in ("approved", "qualified")
                and new_status
                in ("qualified", "won", "lost", "dropped")
            ):
                allowed = True
            if not allowed:
                pending = (
                    supabase.table("assignments")
                    .select("assignment_id")
                    .eq("submission_type", "lead")
                    .eq("submission_id", str(lead_id))
                    .eq("assigned_to", user_id)
                    .eq("action_taken", "pending")
                    .limit(1)
                    .execute()
                )
                if pending.data:
                    allowed = True
            if not allowed:
                raise HTTPException(
                    status_code=403,
                    detail="Only assigned reviewers or sales (after approval) can change status",
                )

    result = (
        supabase.table("leads")
        .update(update_data)
        .eq("lead_id", str(lead_id))
        .execute()
    )

    if new_status and new_status != old_status:
        record_status_change(
            submission_type="lead",
            submission_id=str(lead_id),
            from_status=old_status,
            to_status=new_status,
            changed_by=current_user["id"],
        )
        notify_status_change(
            submission_type="lead",
            submission_id=str(lead_id),
            submission_title=existing.data.get("title", ""),
            submitter_id=existing.data["submitted_by"],
            old_status=old_status,
            new_status=new_status,
        )

        scoreable = {"qualified", "won"}
        event_map = {"qualified": "qualified", "won": "deal_won"}
        if new_status in scoreable:
            award_points(
                existing.data["submitted_by"],
                "lead",
                str(lead_id),
                event_map[new_status],
            )

    updated_row = result.data[0]
    updated_row["can_update_status"] = _user_can_update_lead_status(
        supabase, updated_row, current_user
    )
    return updated_row


@router.delete("/{lead_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_lead(
    lead_id: UUID,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    existing = (
        supabase.table("leads")
        .select("submitted_by, status")
        .eq("lead_id", str(lead_id))
        .single()
        .execute()
    )

    if not existing.data:
        raise HTTPException(status_code=404, detail="Lead not found")

    is_submitter = existing.data["submitted_by"] == current_user["id"]
    is_draft = existing.data["status"] == "draft"
    is_admin = current_user["role"] == "admin"

    if not is_admin and not (is_submitter and is_draft):
        raise HTTPException(status_code=403, detail="Can only delete own drafts")

    supabase.table("leads").delete().eq("lead_id", str(lead_id)).execute()
