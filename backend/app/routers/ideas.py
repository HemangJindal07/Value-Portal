from fastapi import APIRouter, Depends, HTTPException, status, Query
from uuid import UUID
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user
from app.schemas.idea import IdeaCreate, IdeaUpdate, IdeaResponse

router = APIRouter(prefix="/ideas", tags=["Value Ideas"])


@router.get("")
async def list_ideas(
    status_filter: str | None = Query(None, alias="status"),
    idea_category: str | None = None,
    account_id: str | None = None,
    search: str | None = None,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    query = supabase.table("value_ideas").select(
        "*, account:accounts(account_id, account_name), submitter:profiles!submitted_by(id, full_name, email)"
    )

    if status_filter:
        query = query.eq("status", status_filter)
    if idea_category:
        query = query.eq("idea_category", idea_category)
    if account_id:
        query = query.eq("account_id", account_id)
    if search:
        query = query.ilike("title", f"%{search}%")

    query = query.order("created_at", desc=True)
    result = query.execute()
    return result.data


@router.get("/{idea_id}")
async def get_idea(
    idea_id: UUID,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    result = (
        supabase.table("value_ideas")
        .select(
            "*, account:accounts(account_id, account_name, industry, region), submitter:profiles!submitted_by(id, full_name, email, role)"
        )
        .eq("idea_id", str(idea_id))
        .single()
        .execute()
    )

    if not result.data:
        raise HTTPException(status_code=404, detail="Idea not found")
    return result.data


@router.post("", status_code=status.HTTP_201_CREATED)
async def create_idea(
    payload: IdeaCreate,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    data = payload.model_dump(mode="json")
    data["submitted_by"] = current_user["id"]
    data["status"] = "submitted"

    result = supabase.table("value_ideas").insert(data).execute()
    return result.data[0]


@router.patch("/{idea_id}")
async def update_idea(
    idea_id: UUID,
    payload: IdeaUpdate,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()

    existing = (
        supabase.table("value_ideas")
        .select("*")
        .eq("idea_id", str(idea_id))
        .single()
        .execute()
    )
    if not existing.data:
        raise HTTPException(status_code=404, detail="Idea not found")

    user_role = current_user["role"]
    user_id = current_user["id"]
    is_submitter = existing.data["submitted_by"] == user_id
    is_privileged = user_role in ("admin", "executive", "practice_lead")

    if not is_submitter and not is_privileged:
        raise HTTPException(status_code=403, detail="Not authorized")

    update_data = payload.model_dump(exclude_unset=True, mode="json")
    if not update_data:
        return existing.data

    result = (
        supabase.table("value_ideas")
        .update(update_data)
        .eq("idea_id", str(idea_id))
        .execute()
    )
    return result.data[0]


@router.delete("/{idea_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_idea(
    idea_id: UUID,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    existing = (
        supabase.table("value_ideas")
        .select("submitted_by, status")
        .eq("idea_id", str(idea_id))
        .single()
        .execute()
    )

    if not existing.data:
        raise HTTPException(status_code=404, detail="Idea not found")

    is_submitter = existing.data["submitted_by"] == current_user["id"]
    is_draft = existing.data["status"] == "draft"
    is_admin = current_user["role"] == "admin"

    if not is_admin and not (is_submitter and is_draft):
        raise HTTPException(status_code=403, detail="Can only delete own drafts")

    supabase.table("value_ideas").delete().eq("idea_id", str(idea_id)).execute()
