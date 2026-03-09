from fastapi import APIRouter, Depends
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user

router = APIRouter(prefix="/scores", tags=["Scoring"])


@router.get("/me")
async def my_score(current_user: dict = Depends(get_current_user)):
    supabase = get_supabase_admin()
    result = (
        supabase.table("user_scores")
        .select("*")
        .eq("user_id", current_user["id"])
        .eq("period", "all_time")
        .single()
        .execute()
    )
    if not result.data:
        return {
            "total_points": 0,
            "leads_submitted": 0,
            "ideas_submitted": 0,
            "deals_won": 0,
            "ideas_implemented": 0,
            "rank": 0,
        }
    return result.data


@router.get("/events")
async def my_events(
    limit: int = 20,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    result = (
        supabase.table("score_events")
        .select("*")
        .eq("user_id", current_user["id"])
        .order("awarded_at", desc=True)
        .limit(limit)
        .execute()
    )
    return result.data or []


@router.get("/leaderboard")
async def leaderboard(
    limit: int = 20,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    result = (
        supabase.table("user_scores")
        .select("*, user:profiles(id, full_name, email, role, department)")
        .eq("period", "all_time")
        .order("total_points", desc=True)
        .limit(limit)
        .execute()
    )
    return result.data or []
