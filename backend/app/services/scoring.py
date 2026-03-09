"""
Points engine: awards points for key actions and maintains running totals.
"""

import logging
from app.database.supabase import get_supabase_admin

logger = logging.getLogger("scoring")

POINTS_MAP = {
    "submitted": 10,
    "qualified": 20,
    "approved": 25,
    "implemented": 50,
    "deal_won": 100,
}


def award_points(
    user_id: str,
    submission_type: str,
    submission_id: str,
    event_type: str,
) -> int | None:
    points = POINTS_MAP.get(event_type)
    if not points:
        return None

    try:
        supabase = get_supabase_admin()

        existing = (
            supabase.table("score_events")
            .select("event_id", count="exact")
            .eq("user_id", user_id)
            .eq("submission_id", submission_id)
            .eq("event_type", event_type)
            .execute()
        )
        if existing.count and existing.count > 0:
            return None

        supabase.table("score_events").insert(
            {
                "user_id": user_id,
                "submission_type": submission_type,
                "submission_id": submission_id,
                "event_type": event_type,
                "points_awarded": points,
            }
        ).execute()

        _update_user_score(user_id)

        logger.info(
            "Awarded %d pts to %s for %s on %s %s",
            points, user_id, event_type, submission_type, submission_id,
        )
        return points

    except Exception as exc:
        logger.exception("Failed to award points: %s", exc)
        return None


def _update_user_score(user_id: str) -> None:
    supabase = get_supabase_admin()

    events = (
        supabase.table("score_events")
        .select("event_type, points_awarded, submission_type")
        .eq("user_id", user_id)
        .execute()
    )

    total = 0
    leads = 0
    ideas = 0
    won = 0
    implemented = 0

    for e in events.data or []:
        total += e["points_awarded"]
        if e["event_type"] == "submitted":
            if e["submission_type"] == "lead":
                leads += 1
            else:
                ideas += 1
        elif e["event_type"] == "deal_won":
            won += 1
        elif e["event_type"] == "implemented":
            implemented += 1

    score_data = {
        "user_id": user_id,
        "total_points": total,
        "leads_submitted": leads,
        "ideas_submitted": ideas,
        "deals_won": won,
        "ideas_implemented": implemented,
        "period": "all_time",
    }

    existing = (
        supabase.table("user_scores")
        .select("score_id")
        .eq("user_id", user_id)
        .eq("period", "all_time")
        .execute()
    )

    if existing.data:
        supabase.table("user_scores").update(score_data).eq(
            "score_id", existing.data[0]["score_id"]
        ).execute()
    else:
        supabase.table("user_scores").insert(score_data).execute()

    _recompute_ranks()


def _recompute_ranks() -> None:
    supabase = get_supabase_admin()
    scores = (
        supabase.table("user_scores")
        .select("score_id, total_points")
        .eq("period", "all_time")
        .order("total_points", desc=True)
        .execute()
    )

    for idx, row in enumerate(scores.data or [], start=1):
        supabase.table("user_scores").update({"rank": idx}).eq(
            "score_id", row["score_id"]
        ).execute()
