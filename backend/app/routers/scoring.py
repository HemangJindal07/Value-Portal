from fastapi import APIRouter, Depends
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user

router = APIRouter(prefix="/scores", tags=["Scoring"])


@router.get("/me")
async def my_score(current_user: dict = Depends(get_current_user)):
    supabase = get_supabase_admin()

    # Do NOT use `.single()` here — for users with no scores yet,
    # PostgREST returns 0 rows and `.single()` raises PGRST116.
    result = (
        supabase.table("user_scores")
        .select("*")
        .eq("user_id", current_user["id"])
        .eq("period", "all_time")
        .limit(1)
        .execute()
    )

    row = (result.data or [None])[0]
    if not row:
        return {
            "total_points": 0,
            "leads_submitted": 0,
            "ideas_submitted": 0,
            "deals_won": 0,
            "ideas_implemented": 0,
            "rank": 0,
        }

    return row


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
    """
    Return leaderboard entries for *all* active users, not only those
    who already have score_events/user_scores rows.

    This ensures new users (including new admins) still see themselves
    on the leaderboard with 0 points.
    """
    supabase = get_supabase_admin()

    # Fetch all-time scores (may be empty for new users)
    scores = (
        supabase.table("user_scores")
        .select("*")
        .eq("period", "all_time")
        .execute()
    )

    # Fetch all active users
    profiles = (
        supabase.table("profiles")
        .select("id, full_name, email, role, department, is_active")
        .eq("is_active", True)
        .execute()
    )

    score_by_user = {row["user_id"]: row for row in (scores.data or [])}

    entries: list[dict] = []
    for user in profiles.data or []:
        uid = user["id"]
        score = score_by_user.get(uid, {})

        entry = {
            "score_id": score.get("score_id") or f"no-score-{uid}",
            "user_id": uid,
            "total_points": score.get("total_points", 0),
            "leads_submitted": score.get("leads_submitted", 0),
            "ideas_submitted": score.get("ideas_submitted", 0),
            "deals_won": score.get("deals_won", 0),
            "ideas_implemented": score.get("ideas_implemented", 0),
            # Rank will be recomputed below
            "rank": 0,
            "user": {
                "id": uid,
                "full_name": user.get("full_name") or user.get("email"),
                "email": user.get("email"),
                "role": user.get("role"),
                "department": user.get("department"),
            },
        }
        entries.append(entry)

    # Sort by points and assign ranks so users with 0 points still appear.
    entries.sort(key=lambda e: e["total_points"], reverse=True)
    for idx, entry in enumerate(entries, start=1):
        entry["rank"] = idx

    return entries[:limit]
