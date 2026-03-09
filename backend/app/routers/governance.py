from fastapi import APIRouter, Depends, HTTPException
from uuid import UUID
from pydantic import BaseModel
from datetime import date
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user, require_role

router = APIRouter(prefix="/governance", tags=["Governance"])


class ReviewCycleCreate(BaseModel):
    cycle_type: str
    period_label: str
    start_date: date
    end_date: date
    notes: str | None = None


class ReviewCycleUpdate(BaseModel):
    status: str | None = None
    submissions_reviewed: int | None = None
    notes: str | None = None


class ImpactCreate(BaseModel):
    submission_type: str
    submission_id: UUID
    revenue_influenced: float | None = None
    cost_saved: float | None = None
    efficiency_gain: str | None = None


class ImpactUpdate(BaseModel):
    revenue_influenced: float | None = None
    cost_saved: float | None = None
    efficiency_gain: str | None = None
    verified: bool | None = None


@router.get("/review-cycles")
async def list_review_cycles(current_user: dict = Depends(get_current_user)):
    supabase = get_supabase_admin()
    result = (
        supabase.table("review_cycles")
        .select("*, facilitator:profiles!facilitator_id(id, full_name)")
        .order("start_date", desc=True)
        .execute()
    )
    return result.data or []


@router.post("/review-cycles", status_code=201)
async def create_review_cycle(
    payload: ReviewCycleCreate,
    current_user: dict = Depends(require_role("admin", "executive")),
):
    supabase = get_supabase_admin()
    data = payload.model_dump(mode="json")
    data["facilitator_id"] = current_user["id"]
    result = supabase.table("review_cycles").insert(data).execute()
    return result.data[0]


@router.patch("/review-cycles/{cycle_id}")
async def update_review_cycle(
    cycle_id: UUID,
    payload: ReviewCycleUpdate,
    current_user: dict = Depends(require_role("admin", "executive")),
):
    supabase = get_supabase_admin()
    update_data = payload.model_dump(exclude_unset=True, mode="json")
    if not update_data:
        raise HTTPException(status_code=400, detail="No fields to update")

    result = (
        supabase.table("review_cycles")
        .update(update_data)
        .eq("cycle_id", str(cycle_id))
        .execute()
    )
    if not result.data:
        raise HTTPException(status_code=404, detail="Review cycle not found")
    return result.data[0]


@router.get("/impact")
async def list_impact_measurements(
    submission_type: str | None = None,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    query = supabase.table("impact_measurements").select(
        "*, measurer:profiles!measured_by(id, full_name)"
    ).order("measurement_date", desc=True)

    if submission_type:
        query = query.eq("submission_type", submission_type)

    result = query.execute()
    return result.data or []


@router.post("/impact", status_code=201)
async def create_impact_measurement(
    payload: ImpactCreate,
    current_user: dict = Depends(require_role("admin", "executive", "practice_lead")),
):
    supabase = get_supabase_admin()
    data = payload.model_dump(mode="json")
    data["measured_by"] = current_user["id"]
    result = supabase.table("impact_measurements").insert(data).execute()
    return result.data[0]


@router.patch("/impact/{impact_id}")
async def update_impact(
    impact_id: UUID,
    payload: ImpactUpdate,
    current_user: dict = Depends(require_role("admin", "executive")),
):
    supabase = get_supabase_admin()
    update_data = payload.model_dump(exclude_unset=True, mode="json")
    if not update_data:
        raise HTTPException(status_code=400, detail="No fields to update")

    result = (
        supabase.table("impact_measurements")
        .update(update_data)
        .eq("impact_id", str(impact_id))
        .execute()
    )
    if not result.data:
        raise HTTPException(status_code=404, detail="Impact measurement not found")
    return result.data[0]
