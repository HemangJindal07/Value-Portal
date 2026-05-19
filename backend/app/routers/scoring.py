from fastapi import APIRouter, Depends
from collections import Counter
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user, require_role

router = APIRouter(prefix="/scores", tags=["Scoring"])

# Roles excluded from the public leaderboard ranking. Kept here as the single
# source of truth so /scores/me and /scores/leaderboard rank the SAME population
# the SAME way (previously /scores/me used a stale stored rank computed over all
# users, which disagreed with the displayed list — see Catalyst issue #13).
LEADERBOARD_EXCLUDED_ROLES = {"admin", "executive"}


def _build_ranked_entries(supabase) -> list[dict]:
    """
    Build the ranked leaderboard entry list (all active, non-excluded users),
    sorted by total_points desc with ranks 1..N assigned. This is the single
    ranking computation shared by /scores/leaderboard and /scores/me.
    """
    scores = (
        supabase.table("user_scores")
        .select("*")
        .eq("period", "all_time")
        .execute()
    )

    profiles = (
        supabase.table("profiles")
        .select("id, full_name, email, role, department, is_active")
        .eq("is_active", True)
        .execute()
    )

    score_by_user = {row["user_id"]: row for row in (scores.data or [])}

    leads_res = supabase.table("leads").select("submitted_by").execute()
    leads_count_by_user = Counter(
        l["submitted_by"] for l in (leads_res.data or [])
    )

    won_res = (
        supabase.table("leads")
        .select("submitted_by")
        .eq("status", "won")
        .execute()
    )
    won_count_by_user = Counter(
        l["submitted_by"] for l in (won_res.data or [])
    )

    entries: list[dict] = []
    for user in profiles.data or []:
        if user.get("role") in LEADERBOARD_EXCLUDED_ROLES:
            continue
        uid = user["id"]
        score = score_by_user.get(uid, {})

        entries.append({
            "score_id": score.get("score_id") or f"no-score-{uid}",
            "user_id": uid,
            "total_points": score.get("total_points", 0),
            "leads_submitted": leads_count_by_user.get(uid, 0),
            "ideas_submitted": score.get("ideas_submitted", 0),
            "deals_won": won_count_by_user.get(uid, 0),
            "ideas_implemented": score.get("ideas_implemented", 0),
            "rank": 0,
            "user": {
                "id": uid,
                "full_name": user.get("full_name") or user.get("email"),
                "email": user.get("email"),
                "role": user.get("role"),
                "department": user.get("department"),
            },
        })

    # Sort by points and assign ranks so users with 0 points still appear.
    entries.sort(key=lambda e: e["total_points"], reverse=True)
    for idx, entry in enumerate(entries, start=1):
        entry["rank"] = idx
    return entries


@router.get("/me")
async def my_score(current_user: dict = Depends(get_current_user)):
    supabase = get_supabase_admin()
    uid = current_user["id"]

    result = (
        supabase.table("user_scores")
        .select("*")
        .eq("user_id", uid)
        .eq("period", "all_time")
        .limit(1)
        .execute()
    )

    row = (result.data or [None])[0] or {}

    # Real-time lead count from leads table (not stale score_events)
    leads_res = (
        supabase.table("leads")
        .select("lead_id", count="exact")
        .eq("submitted_by", uid)
        .execute()
    )
    live_leads = leads_res.count or 0

    # Real-time won count
    won_res = (
        supabase.table("leads")
        .select("lead_id", count="exact")
        .eq("submitted_by", uid)
        .eq("status", "won")
        .execute()
    )
    live_won = won_res.count or 0

    # Derive rank from the SAME ranked list the leaderboard shows, so the
    # "Your Rank" tile always agrees with the user's position in the list
    # (Catalyst issue #13). Excluded-role users (admin/executive) aren't in
    # the ranked set → rank 0 (frontend renders 0 as "—").
    ranked = _build_ranked_entries(supabase)
    my_rank = next((e["rank"] for e in ranked if e["user_id"] == uid), 0)

    return {
        "total_points":    row.get("total_points", 0),
        "leads_submitted": live_leads,
        "ideas_submitted": row.get("ideas_submitted", 0),
        "deals_won":       live_won,
        "ideas_implemented": row.get("ideas_implemented", 0),
        "rank":            my_rank,
    }


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
    entries = _build_ranked_entries(supabase)
    return entries[:limit]


@router.post("/recalculate")
async def recalculate_all_scores(
    current_user: dict = Depends(require_role("admin")),
):
    """
    Admin: recompute user_scores for every user that has score_events.
    Safe to call any time — scores are derived from score_events, which is the
    source of truth. Use this after manually inserting/deleting score_events rows.
    """
    from app.services.scoring import _update_user_score, _recompute_ranks

    supabase = get_supabase_admin()
    users_res = (
        supabase.table("score_events")
        .select("user_id")
        .execute()
    )
    user_ids = list({r["user_id"] for r in (users_res.data or [])})

    for uid in user_ids:
        _update_user_score(uid)

    _recompute_ranks()
    return {"recalculated": len(user_ids), "user_ids": user_ids}
