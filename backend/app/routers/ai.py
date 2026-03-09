from fastapi import APIRouter, BackgroundTasks, Depends, HTTPException
from uuid import UUID
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user, require_role
from app.services.ai_classifier import classify_idea
from app.services.lead_classifier import classify_lead

router = APIRouter(prefix="/ai", tags=["AI Classification"])


@router.post("/classify/idea/{idea_id}")
async def trigger_idea_classification(
    idea_id: UUID,
    background_tasks: BackgroundTasks,
    current_user: dict = Depends(require_role("admin", "executive", "delivery_manager")),
):
    supabase = get_supabase_admin()
    result = (
        supabase.table("value_ideas")
        .select("idea_id")
        .eq("idea_id", str(idea_id))
        .single()
        .execute()
    )
    if not result.data:
        raise HTTPException(status_code=404, detail="Idea not found")

    background_tasks.add_task(classify_idea, str(idea_id))
    return {"status": "classification_queued", "idea_id": str(idea_id)}


@router.post("/classify/lead/{lead_id}")
async def trigger_lead_classification(
    lead_id: UUID,
    background_tasks: BackgroundTasks,
    current_user: dict = Depends(require_role("admin", "executive", "sales")),
):
    supabase = get_supabase_admin()
    result = (
        supabase.table("leads")
        .select("lead_id")
        .eq("lead_id", str(lead_id))
        .single()
        .execute()
    )
    if not result.data:
        raise HTTPException(status_code=404, detail="Lead not found")

    background_tasks.add_task(classify_lead, str(lead_id))
    return {"status": "classification_queued", "lead_id": str(lead_id)}


@router.get("/status/idea/{idea_id}")
async def idea_classification_status(
    idea_id: UUID,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    result = (
        supabase.table("value_ideas")
        .select("idea_id, ai_category, ai_summary, ai_confidence")
        .eq("idea_id", str(idea_id))
        .single()
        .execute()
    )
    if not result.data:
        raise HTTPException(status_code=404, detail="Idea not found")

    data = result.data
    classified = data.get("ai_category") is not None
    return {
        "classified": classified,
        "ai_category": data.get("ai_category"),
        "ai_summary": data.get("ai_summary"),
        "ai_confidence": data.get("ai_confidence"),
    }


@router.get("/status/lead/{lead_id}")
async def lead_classification_status(
    lead_id: UUID,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    result = (
        supabase.table("leads")
        .select("lead_id, ai_category, ai_confidence")
        .eq("lead_id", str(lead_id))
        .single()
        .execute()
    )
    if not result.data:
        raise HTTPException(status_code=404, detail="Lead not found")

    data = result.data
    classified = data.get("ai_category") is not None
    return {
        "classified": classified,
        "ai_category": data.get("ai_category"),
        "ai_confidence": data.get("ai_confidence"),
    }
