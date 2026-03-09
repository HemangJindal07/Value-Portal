from fastapi import APIRouter, Depends, HTTPException
from uuid import UUID
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user
from app.schemas.tracking import CommentCreate

router = APIRouter(prefix="/tracking", tags=["Tracking"])

VALID_TYPES = {"lead", "idea"}


def _validate_type(submission_type: str) -> None:
    if submission_type not in VALID_TYPES:
        raise HTTPException(status_code=400, detail=f"submission_type must be 'lead' or 'idea'")


@router.get("/{submission_type}/{submission_id}/history")
async def get_status_history(
    submission_type: str,
    submission_id: UUID,
    current_user: dict = Depends(get_current_user),
):
    """Full status change timeline for a lead or idea."""
    _validate_type(submission_type)
    supabase = get_supabase_admin()
    result = (
        supabase.table("status_history")
        .select("*, changed_by_profile:profiles!changed_by(id, full_name, role)")
        .eq("submission_type", submission_type)
        .eq("submission_id", str(submission_id))
        .order("changed_at", desc=False)
        .execute()
    )
    return result.data or []


@router.get("/{submission_type}/{submission_id}/comments")
async def get_comments(
    submission_type: str,
    submission_id: UUID,
    current_user: dict = Depends(get_current_user),
):
    """All comments on a lead or idea, with author profile."""
    _validate_type(submission_type)
    supabase = get_supabase_admin()
    result = (
        supabase.table("comments")
        .select("*, author:profiles!author_id(id, full_name, role)")
        .eq("submission_type", submission_type)
        .eq("submission_id", str(submission_id))
        .order("created_at", desc=False)
        .execute()
    )
    return result.data or []


@router.post("/{submission_type}/{submission_id}/comments", status_code=201)
async def add_comment(
    submission_type: str,
    submission_id: UUID,
    payload: CommentCreate,
    current_user: dict = Depends(get_current_user),
):
    """Add a comment to a lead or idea."""
    _validate_type(submission_type)

    if not payload.content.strip():
        raise HTTPException(status_code=400, detail="Comment content cannot be empty")

    supabase = get_supabase_admin()
    result = (
        supabase.table("comments")
        .insert({
            "submission_type": submission_type,
            "submission_id": str(submission_id),
            "author_id": current_user["id"],
            "content": payload.content.strip(),
            "is_internal": payload.is_internal,
        })
        .execute()
    )
    return result.data[0]


@router.delete("/{submission_type}/{submission_id}/comments/{comment_id}", status_code=204)
async def delete_comment(
    submission_type: str,
    submission_id: UUID,
    comment_id: UUID,
    current_user: dict = Depends(get_current_user),
):
    """Delete a comment. Only the author or an admin can delete."""
    _validate_type(submission_type)
    supabase = get_supabase_admin()

    existing = (
        supabase.table("comments")
        .select("author_id")
        .eq("comment_id", str(comment_id))
        .single()
        .execute()
    )

    if not existing.data:
        raise HTTPException(status_code=404, detail="Comment not found")

    is_author = existing.data["author_id"] == current_user["id"]
    is_admin = current_user["role"] == "admin"

    if not is_author and not is_admin:
        raise HTTPException(status_code=403, detail="Not authorized to delete this comment")

    supabase.table("comments").delete().eq("comment_id", str(comment_id)).execute()
