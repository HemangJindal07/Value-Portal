from datetime import datetime, timezone
from fastapi import APIRouter, Depends, HTTPException
from uuid import UUID
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user
from app.schemas.notification import MarkReadRequest

router = APIRouter(prefix="/notifications", tags=["Notifications"])


@router.get("")
async def list_notifications(
    unread_only: bool = False,
    limit: int = 50,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    query = (
        supabase.table("notifications")
        .select("*")
        .eq("recipient_id", current_user["id"])
        .order("sent_at", desc=True)
        .limit(limit)
    )

    if unread_only:
        query = query.eq("is_read", False)

    result = query.execute()
    return result.data or []


@router.get("/count")
async def unread_count(
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    result = (
        supabase.table("notifications")
        .select("notification_id", count="exact")
        .eq("recipient_id", current_user["id"])
        .eq("is_read", False)
        .execute()
    )
    return {"unread": result.count or 0}


@router.patch("/read")
async def mark_as_read(
    payload: MarkReadRequest,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    ids = [str(nid) for nid in payload.notification_ids]

    supabase.table("notifications").update(
        {"is_read": True, "read_at": datetime.now(timezone.utc).isoformat()}
    ).in_("notification_id", ids).eq("recipient_id", current_user["id"]).execute()

    return {"marked": len(ids)}


@router.patch("/read-all")
async def mark_all_read(
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    supabase.table("notifications").update(
        {"is_read": True, "read_at": datetime.now(timezone.utc).isoformat()}
    ).eq("recipient_id", current_user["id"]).eq("is_read", False).execute()

    return {"status": "ok"}
