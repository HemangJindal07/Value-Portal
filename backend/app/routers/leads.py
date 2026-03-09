from fastapi import APIRouter, BackgroundTasks, Depends, HTTPException, status, Query
from uuid import UUID
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user
from app.schemas.lead import LeadCreate, LeadUpdate, LeadResponse
from app.services.assignment_engine import auto_assign
from app.services.tracking import record_status_change

router = APIRouter(prefix="/leads", tags=["Leads"])


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
    return result.data


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
        auto_assign, "lead", str(lead["lead_id"]), str(lead["account_id"])
    )

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
        return existing.data

    old_status = existing.data.get("status")
    new_status = update_data.get("status")

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

    return result.data[0]


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
