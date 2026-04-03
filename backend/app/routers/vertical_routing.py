"""
Org-level routing configuration: vertical → DU/DH and region → Sales.
BRD §8.6 — these tables are used by the routing engine as a fallback when
no per-account stakeholders are configured in account_stakeholders.
"""

from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel
from uuid import UUID
from typing import Optional
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user, require_role

router = APIRouter(tags=["Routing Config"])


# ── Schemas ───────────────────────────────────────────────────────────────────

class VerticalRoutingCreate(BaseModel):
    vertical_name: str
    du_user_id: Optional[UUID] = None
    dh_user_id: Optional[UUID] = None


class VerticalRoutingUpdate(BaseModel):
    vertical_name: Optional[str] = None
    du_user_id: Optional[UUID] = None
    dh_user_id: Optional[UUID] = None


class RegionSalesCreate(BaseModel):
    region_name: str
    sales_user_id: UUID
    copy_all: bool = False


class RegionSalesUpdate(BaseModel):
    region_name: Optional[str] = None
    sales_user_id: Optional[UUID] = None
    copy_all: Optional[bool] = None


# ── Vertical Routing endpoints ────────────────────────────────────────────────

@router.get("/vertical-routing")
async def list_vertical_routing(
    current_user: dict = Depends(get_current_user),
):
    """List all vertical → DU/DH routing entries."""
    supabase = get_supabase_admin()
    result = (
        supabase.table("vertical_routing")
        .select(
            "*, "
            "du:profiles!du_user_id(id, full_name, email, role), "
            "dh:profiles!dh_user_id(id, full_name, email, role), "
            "creator:profiles!created_by(id, full_name)"
        )
        .order("vertical_name")
        .execute()
    )
    return result.data or []


@router.post("/vertical-routing", status_code=status.HTTP_201_CREATED)
async def create_vertical_routing(
    payload: VerticalRoutingCreate,
    current_user: dict = Depends(require_role("admin")),
):
    """Create a vertical → DU/DH routing entry."""
    supabase = get_supabase_admin()
    data = payload.model_dump(mode="json", exclude_none=True)
    data["created_by"] = current_user["id"]
    try:
        result = supabase.table("vertical_routing").insert(data).execute()
        return result.data[0]
    except Exception as exc:
        detail = str(exc)
        if "unique" in detail.lower():
            raise HTTPException(
                status_code=409,
                detail=f"A routing entry for vertical '{payload.vertical_name}' already exists.",
            )
        raise HTTPException(status_code=400, detail=detail)


@router.patch("/vertical-routing/{entry_id}")
async def update_vertical_routing(
    entry_id: UUID,
    payload: VerticalRoutingUpdate,
    current_user: dict = Depends(require_role("admin")),
):
    """Update a vertical routing entry."""
    supabase = get_supabase_admin()
    update_data = payload.model_dump(exclude_unset=True, mode="json")
    if not update_data:
        raise HTTPException(status_code=400, detail="Nothing to update.")
    result = (
        supabase.table("vertical_routing")
        .update(update_data)
        .eq("id", str(entry_id))
        .execute()
    )
    if not result.data:
        raise HTTPException(status_code=404, detail="Vertical routing entry not found.")
    return result.data[0]


@router.delete("/vertical-routing/{entry_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_vertical_routing(
    entry_id: UUID,
    current_user: dict = Depends(require_role("admin")),
):
    """Delete a vertical routing entry."""
    supabase = get_supabase_admin()
    supabase.table("vertical_routing").delete().eq("id", str(entry_id)).execute()


# ── Region Sales Mapping endpoints ───────────────────────────────────────────

@router.get("/region-sales")
async def list_region_sales(
    current_user: dict = Depends(get_current_user),
):
    """List all region → sales person mapping entries."""
    supabase = get_supabase_admin()
    result = (
        supabase.table("region_sales_mapping")
        .select("*, sales:profiles!sales_user_id(id, full_name, email, role)")
        .order("copy_all", desc=True)
        .order("region_name")
        .execute()
    )
    return result.data or []


@router.post("/region-sales", status_code=status.HTTP_201_CREATED)
async def create_region_sales(
    payload: RegionSalesCreate,
    current_user: dict = Depends(require_role("admin")),
):
    """Create a region → sales person mapping."""
    supabase = get_supabase_admin()
    data = payload.model_dump(mode="json")
    try:
        result = supabase.table("region_sales_mapping").insert(data).execute()
        return result.data[0]
    except Exception as exc:
        detail = str(exc)
        if "unique" in detail.lower():
            raise HTTPException(
                status_code=409,
                detail="This user is already mapped to this region.",
            )
        raise HTTPException(status_code=400, detail=detail)


@router.patch("/region-sales/{entry_id}")
async def update_region_sales(
    entry_id: UUID,
    payload: RegionSalesUpdate,
    current_user: dict = Depends(require_role("admin")),
):
    """Update a region sales mapping entry."""
    supabase = get_supabase_admin()
    update_data = payload.model_dump(exclude_unset=True, mode="json")
    if not update_data:
        raise HTTPException(status_code=400, detail="Nothing to update.")
    result = (
        supabase.table("region_sales_mapping")
        .update(update_data)
        .eq("id", str(entry_id))
        .execute()
    )
    if not result.data:
        raise HTTPException(status_code=404, detail="Region sales entry not found.")
    return result.data[0]


@router.delete("/region-sales/{entry_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_region_sales(
    entry_id: UUID,
    current_user: dict = Depends(require_role("admin")),
):
    """Delete a region sales mapping entry."""
    supabase = get_supabase_admin()
    supabase.table("region_sales_mapping").delete().eq("id", str(entry_id)).execute()
