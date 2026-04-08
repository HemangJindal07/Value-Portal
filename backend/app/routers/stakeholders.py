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
from app.services.account_stakeholders_sync import ensure_du_dh_if_no_stakeholders
from postgrest.exceptions import APIError

router = APIRouter(prefix="/stakeholders", tags=["Stakeholders"])

def _extract_postgrest_error_code(exc: Exception) -> str | None:
    """
    PostgREST errors are inconsistent across versions:
    - sometimes APIError.args[0] is a dict (preferred)
    - sometimes it can be a string
    - occasionally we see wrapped exceptions
    We detect the code defensively so we don't return 500s.
    """
    payload = None
    args = getattr(exc, "args", None)
    if isinstance(args, tuple) and args:
        payload = args[0]
    if isinstance(payload, dict):
        code = payload.get("code")
        return code if isinstance(code, str) else None
    # fall back: look for the code in the string representation
    s = str(exc)
    return "PGRST205" if "PGRST205" in s else None


def _handle_missing_table(exc: Exception) -> None:
    """
    PostgREST returns PGRST205 when a table isn't visible in schema cache.
    In our env this almost always means the migration that creates the table
    hasn't been applied to the Supabase project yet.
    """
    code = _extract_postgrest_error_code(exc)
    if code == "PGRST205":
        raise HTTPException(
            status_code=503,
            detail=(
                "Stakeholder mapping is not configured in the database yet. "
                "Missing table `public.account_stakeholders`. "
                "Apply migration `backend/supabase/migrations/011_account_stakeholders.sql` "
                "to your Supabase project, then retry."
            ),
        )


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
    try:
        # Seed DU → DH from the account record when the chain was never persisted
        # (legacy accounts or account created before migration 011).
        ensure_du_dh_if_no_stakeholders(supabase, str(account_id))
        result = (
            supabase.table("account_stakeholders")
            .select("*, user:profiles!user_id(id, full_name, email, role)")
            .eq("account_id", str(account_id))
            .order("step_order")
            .execute()
        )
        return result.data or []
    except Exception as exc:
        _handle_missing_table(exc)
        raise


@router.post("", status_code=status.HTTP_201_CREATED)
async def add_stakeholder(
    payload: StakeholderCreate,
    current_user: dict = Depends(require_role("admin")),
):
    """Add a reviewer to an account's routing chain."""
    supabase = get_supabase_admin()
    data = payload.model_dump(mode="json")
    try:
        ensure_du_dh_if_no_stakeholders(supabase, str(payload.account_id))
        max_res = (
            supabase.table("account_stakeholders")
            .select("step_order")
            .eq("account_id", str(payload.account_id))
            .order("step_order", desc=True)
            .limit(1)
            .execute()
        )
        max_step = 0
        if max_res.data:
            max_step = int(max_res.data[0].get("step_order") or 0)
        data["step_order"] = max_step + 1
        result = supabase.table("account_stakeholders").insert(data).execute()
        return result.data[0]
    except Exception as exc:
        _handle_missing_table(exc)
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

    try:
        result = (
            supabase.table("account_stakeholders")
            .update(update_data)
            .eq("id", str(stakeholder_id))
            .execute()
        )
    except Exception as exc:
        _handle_missing_table(exc)
        raise
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
    try:
        supabase.table("account_stakeholders").delete().eq("id", str(stakeholder_id)).execute()
    except Exception as exc:
        _handle_missing_table(exc)
        raise


@router.post("/reorder", status_code=status.HTTP_200_OK)
async def reorder_stakeholders(
    payload: BulkReorder,
    current_user: dict = Depends(require_role("admin")),
):
    """Bulk-update step_order for multiple stakeholders at once."""
    supabase = get_supabase_admin()
    try:
        for item in payload.items:
            supabase.table("account_stakeholders").update(
                {"step_order": item.step_order}
            ).eq("id", str(item.id)).execute()
    except Exception as exc:
        _handle_missing_table(exc)
        raise
    return {"updated": len(payload.items)}
