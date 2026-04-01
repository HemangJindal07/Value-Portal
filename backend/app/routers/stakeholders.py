"""
Dynamic stakeholder mapping for accounts.
Admins can add, update, remove, and reorder reviewers for any account.
The routing engine reads from this table to determine the approval chain.
"""

from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel
from uuid import UUID
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user, require_role

router = APIRouter(prefix="/stakeholders", tags=["Stakeholders"])


# ── Schemas ──────────────────────────────────────────────────────────────────

class StakeholderCreate(BaseModel):
    account_id: UUID
    user_id: UUID
    role_label: str = "Reviewer"
    step_order: int = 1


class StakeholderUpdate(BaseModel):
    user_id: UUID | None = None
    role_label: str | None = None
    step_order: int | None = None


class ReorderItem(BaseModel):
    id: UUID
    step_order: int


class BulkReorder(BaseModel):
    items: list[ReorderItem]


# ── Endpoints ─────────────────────────────────────────────────────────────────

@router.get("")
async def list_stakeholders(
    account_id: UUID,
    current_user: dict = Depends(get_current_user),
):
    """Return all stakeholders for an account, ordered by step_order."""
    supabase = get_supabase_admin()
    result = (
        supabase.table("account_stakeholders")
        .select("*, user:profiles!user_id(id, full_name, email, role)")
        .eq("account_id", str(account_id))
        .order("step_order")
        .execute()
    )
    return result.data or []


@router.post("", status_code=status.HTTP_201_CREATED)
async def add_stakeholder(
    payload: StakeholderCreate,
    current_user: dict = Depends(require_role("admin")),
):
    """Add a reviewer to an account's routing chain."""
    supabase = get_supabase_admin()
    data = payload.model_dump(mode="json")
    try:
        result = supabase.table("account_stakeholders").insert(data).execute()
        return result.data[0]
    except Exception as exc:
        detail = str(exc)
        if "unique" in detail.lower():
            raise HTTPException(
                status_code=409,
                detail="This user is already a stakeholder for this account.",
            )
        raise HTTPException(status_code=400, detail=detail)


@router.patch("/{stakeholder_id}")
async def update_stakeholder(
    stakeholder_id: UUID,
    payload: StakeholderUpdate,
    current_user: dict = Depends(require_role("admin")),
):
    """Update a stakeholder's user, label, or step order."""
    supabase = get_supabase_admin()
    update_data = payload.model_dump(exclude_unset=True, mode="json")
    if not update_data:
        raise HTTPException(status_code=400, detail="Nothing to update.")

    result = (
        supabase.table("account_stakeholders")
        .update(update_data)
        .eq("id", str(stakeholder_id))
        .execute()
    )
    if not result.data:
        raise HTTPException(status_code=404, detail="Stakeholder not found.")
    return result.data[0]


@router.delete("/{stakeholder_id}", status_code=status.HTTP_204_NO_CONTENT)
async def remove_stakeholder(
    stakeholder_id: UUID,
    current_user: dict = Depends(require_role("admin")),
):
    """Remove a reviewer from an account's routing chain."""
    supabase = get_supabase_admin()
    supabase.table("account_stakeholders").delete().eq("id", str(stakeholder_id)).execute()


@router.post("/reorder", status_code=status.HTTP_200_OK)
async def reorder_stakeholders(
    payload: BulkReorder,
    current_user: dict = Depends(require_role("admin")),
):
    """Bulk-update step_order for multiple stakeholders at once."""
    supabase = get_supabase_admin()
    for item in payload.items:
        supabase.table("account_stakeholders").update(
            {"step_order": item.step_order}
        ).eq("id", str(item.id)).execute()
    return {"updated": len(payload.items)}
