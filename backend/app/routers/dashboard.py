from fastapi import APIRouter, Depends
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user

router = APIRouter(prefix="/dashboard", tags=["Dashboard"])


@router.get("/stats")
async def dashboard_stats(current_user: dict = Depends(get_current_user)):
    """Aggregate live stats from actual data tables."""
    supabase = get_supabase_admin()

    leads = supabase.table("leads").select("lead_id", count="exact").execute()
    ideas = supabase.table("value_ideas").select("idea_id", count="exact").execute()
    accounts = supabase.table("accounts").select("account_id", count="exact").execute()
    users = supabase.table("profiles").select("id", count="exact").eq("is_active", True).execute()

    leads_by_status = {}
    for s in ["submitted", "under_review", "qualified", "won", "lost"]:
        r = supabase.table("leads").select("lead_id", count="exact").eq("status", s).execute()
        leads_by_status[s] = r.count or 0

    ideas_by_status = {}
    for s in ["submitted", "under_review", "approved", "implemented", "rejected"]:
        r = supabase.table("value_ideas").select("idea_id", count="exact").eq("status", s).execute()
        ideas_by_status[s] = r.count or 0

    pending_assignments = (
        supabase.table("assignments")
        .select("assignment_id", count="exact")
        .eq("action_taken", "pending")
        .execute()
    )

    pipeline_result = (
        supabase.table("leads")
        .select("estimated_value")
        .in_("status", ["submitted", "under_review", "qualified"])
        .execute()
    )
    pipeline_value = sum(
        float(r.get("estimated_value") or 0) for r in (pipeline_result.data or [])
    )

    won_result = (
        supabase.table("leads")
        .select("estimated_value")
        .eq("status", "won")
        .execute()
    )
    won_value = sum(
        float(r.get("estimated_value") or 0) for r in (won_result.data or [])
    )

    savings_result = (
        supabase.table("value_ideas")
        .select("estimated_saving")
        .eq("status", "implemented")
        .execute()
    )
    total_savings = sum(
        float(r.get("estimated_saving") or 0) for r in (savings_result.data or [])
    )

    return {
        "total_leads": leads.count or 0,
        "total_ideas": ideas.count or 0,
        "total_accounts": accounts.count or 0,
        "active_users": users.count or 0,
        "leads_by_status": leads_by_status,
        "ideas_by_status": ideas_by_status,
        "pending_assignments": pending_assignments.count or 0,
        "pipeline_value": pipeline_value,
        "won_value": won_value,
        "total_savings": total_savings,
    }


@router.get("/recent-activity")
async def recent_activity(
    limit: int = 15,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()

    history = (
        supabase.table("status_history")
        .select("*, changer:profiles!changed_by(id, full_name)")
        .order("changed_at", desc=True)
        .limit(limit)
        .execute()
    )

    activities = []
    for h in history.data or []:
        title = ""
        if h["submission_type"] == "lead":
            r = supabase.table("leads").select("title").eq("lead_id", h["submission_id"]).execute()
            title = (r.data[0]["title"] if r.data else "")
        else:
            r = supabase.table("value_ideas").select("title").eq("idea_id", h["submission_id"]).execute()
            title = (r.data[0]["title"] if r.data else "")

        activities.append({
            "type": h["submission_type"],
            "title": title,
            "from_status": h["from_status"],
            "to_status": h["to_status"],
            "changed_by": h.get("changer", {}).get("full_name", "Unknown"),
            "changed_at": h["changed_at"],
        })

    return activities
