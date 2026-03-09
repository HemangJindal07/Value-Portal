from fastapi import APIRouter, Depends, HTTPException
from uuid import UUID
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user, require_role
from app.schemas.user import ProfileUpdate

router = APIRouter(prefix="/users", tags=["Users"])


@router.get("")
async def list_users(
    role: str | None = None,
    active_only: bool = True,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    query = supabase.table("profiles").select("*")

    if active_only:
        query = query.eq("is_active", True)
    if role:
        query = query.eq("role", role)

    query = query.order("full_name")
    result = query.execute()
    return result.data


@router.get("/{user_id}")
async def get_user(
    user_id: UUID,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    result = (
        supabase.table("profiles")
        .select("*")
        .eq("id", str(user_id))
        .single()
        .execute()
    )
    if not result.data:
        raise HTTPException(status_code=404, detail="User not found")
    return result.data


@router.patch("/{user_id}")
async def update_user(
    user_id: UUID,
    payload: ProfileUpdate,
    current_user: dict = Depends(require_role("admin")),
):
    supabase = get_supabase_admin()
    update_data = payload.model_dump(exclude_unset=True, mode="json")
    if not update_data:
        raise HTTPException(status_code=400, detail="No fields to update")

    result = (
        supabase.table("profiles")
        .update(update_data)
        .eq("id", str(user_id))
        .execute()
    )

    if not result.data:
        raise HTTPException(status_code=404, detail="User not found")
    return result.data[0]
