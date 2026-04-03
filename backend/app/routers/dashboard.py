from datetime import datetime
from fastapi import APIRouter, Depends, Query
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user, require_role

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


@router.get("/admin-analytics")
async def admin_analytics(
    current_user: dict = Depends(require_role("admin", "executive")),
):
    """
    Admin-only aggregated analytics.
    BRD §8.10 — qualification ratios, reviewer turnaround, region/vertical/account breakdown.
    """
    supabase = get_supabase_admin()

    # ── 1. Leads with account context ────────────────────────────────────────
    leads_res = supabase.table("leads").select(
        "lead_id, status, estimated_value, lead_type, "
        "account:accounts(account_id, account_name, region, industry)"
    ).execute()
    leads = leads_res.data or []

    # ── 2. Qualification + win ratios ─────────────────────────────────────────
    non_draft = [l for l in leads if l["status"] != "draft"]
    total_leads = len(non_draft)
    qualified_count = sum(1 for l in non_draft if l["status"] in ("qualified", "won", "lost", "approved"))
    won_count  = sum(1 for l in non_draft if l["status"] == "won")
    lost_count = sum(1 for l in non_draft if l["status"] == "lost")

    qualification_ratio = round(qualified_count / total_leads * 100, 1) if total_leads else 0
    win_rate = round(won_count / (won_count + lost_count) * 100, 1) if (won_count + lost_count) else 0

    # ── 3. Ideas with account context ────────────────────────────────────────
    ideas_res = supabase.table("value_ideas").select(
        "idea_id, status, estimated_saving, "
        "account:accounts(account_id, account_name, region, industry)"
    ).execute()
    ideas = ideas_res.data or []

    # ── 4. Revenue / savings ──────────────────────────────────────────────────
    pipeline_value = sum(
        float(l.get("estimated_value") or 0)
        for l in non_draft if l["status"] in ("submitted", "routing_pending", "under_review", "qualified")
    )
    won_value = sum(
        float(l.get("estimated_value") or 0) for l in non_draft if l["status"] == "won"
    )
    total_savings = sum(
        float(i.get("estimated_saving") or 0) for i in ideas if i["status"] == "implemented"
    )

    # ── 5. Leads by region ────────────────────────────────────────────────────
    region_map: dict[str, dict] = {}
    for l in non_draft:
        acct = l.get("account") or {}
        r = acct.get("region") or "Unknown"
        if r not in region_map:
            region_map[r] = {"region": r, "count": 0, "value": 0.0}
        region_map[r]["count"] += 1
        region_map[r]["value"] += float(l.get("estimated_value") or 0)
    leads_by_region = sorted(region_map.values(), key=lambda x: x["count"], reverse=True)

    # ── 6. Leads by vertical (industry) ──────────────────────────────────────
    vertical_map: dict[str, int] = {}
    for l in non_draft:
        v = (l.get("account") or {}).get("industry") or "Unknown"
        vertical_map[v] = vertical_map.get(v, 0) + 1
    leads_by_vertical = sorted(
        [{"vertical": k, "count": v} for k, v in vertical_map.items()],
        key=lambda x: x["count"], reverse=True,
    )[:10]

    # ── 7. Top accounts by activity (leads + ideas combined) ──────────────────
    acct_map: dict[str, dict] = {}
    for l in non_draft:
        acct = l.get("account") or {}
        aid  = acct.get("account_id")
        if not aid:
            continue
        if aid not in acct_map:
            acct_map[aid] = {"account_name": acct.get("account_name", "Unknown"), "leads": 0, "ideas": 0}
        acct_map[aid]["leads"] += 1
    for i in ideas:
        acct = i.get("account") or {}
        aid  = acct.get("account_id")
        if not aid:
            continue
        if aid not in acct_map:
            acct_map[aid] = {"account_name": acct.get("account_name", "Unknown"), "leads": 0, "ideas": 0}
        acct_map[aid]["ideas"] += 1
    top_accounts = sorted(
        acct_map.values(),
        key=lambda x: x["leads"] + x["ideas"], reverse=True
    )[:8]

    # ── 8. Reviewer turnaround ────────────────────────────────────────────────
    asgn_res = supabase.table("assignments").select(
        "assigned_role, assignment_date, action_date, action_taken"
    ).in_("action_taken", ["approved", "rejected"]).execute()

    role_times: dict[str, list[float]] = {}
    for a in (asgn_res.data or []):
        if not a.get("action_date") or not a.get("assignment_date"):
            continue
        try:
            t_start = datetime.fromisoformat(a["assignment_date"].replace("Z", "+00:00"))
            t_end   = datetime.fromisoformat(a["action_date"].replace("Z", "+00:00"))
            hours   = (t_end - t_start).total_seconds() / 3600
            role    = a.get("assigned_role") or "Unknown"
            role_times.setdefault(role, []).append(hours)
        except Exception:
            pass

    turnaround = [
        {
            "role":     role,
            "avg_days": round(sum(times) / len(times) / 24, 1),
            "count":    len(times),
        }
        for role, times in sorted(role_times.items())
    ]

    # ── 9. Exception queue count ──────────────────────────────────────────────
    pending_leads = sum(1 for l in leads if l["status"] == "routing_pending")
    pending_ideas = sum(1 for i in ideas if i["status"] == "routing_pending")

    return {
        "total_leads":          total_leads,
        "qualification_ratio":  qualification_ratio,
        "win_rate":             win_rate,
        "won_count":            won_count,
        "lost_count":           lost_count,
        "pipeline_value":       pipeline_value,
        "won_value":            won_value,
        "total_savings":        total_savings,
        "leads_by_region":      leads_by_region,
        "leads_by_vertical":    leads_by_vertical,
        "top_accounts":         top_accounts,
        "turnaround":           turnaround,
        "routing_pending_leads": pending_leads,
        "routing_pending_ideas": pending_ideas,
    }


@router.get("/pipeline")
async def pipeline_report(
    scope: str = Query("mine", description="'mine' = own submissions only, 'all' = org-wide (admin/executive)"),
    current_user: dict = Depends(get_current_user),
):
    """
    Flow-based pipeline report: each submission enriched with its current
    pending assignment (reviewer + role).
    BRD §8.10 — Lead → Assigned To → Status → Qualified/Win/Loss
    """
    supabase = get_supabase_admin()
    user_id  = current_user["id"]
    role     = current_user.get("role", "delivery_manager")

    all_roles = {"admin", "executive"}
    leads_all_roles  = {"admin", "executive", "sales"}
    ideas_all_roles  = {"admin", "executive", "practice_lead"}

    # ── Fetch leads ───────────────────────────────────────────────────────────
    lq = supabase.table("leads").select(
        "lead_id, title, status, lead_type, estimated_value, priority, created_at, updated_at, "
        "submitted_by, "
        "account:accounts(account_id, account_name, region, industry), "
        "submitter:profiles!submitted_by(id, full_name)"
    ).order("created_at", desc=True)
    if scope == "mine" or role not in leads_all_roles:
        lq = lq.eq("submitted_by", user_id)
    leads_data = lq.execute().data or []

    # ── Fetch ideas ───────────────────────────────────────────────────────────
    iq = supabase.table("value_ideas").select(
        "idea_id, title, status, idea_category, estimated_saving, created_at, updated_at, "
        "submitted_by, "
        "account:accounts(account_id, account_name, region, industry), "
        "submitter:profiles!submitted_by(id, full_name)"
    ).order("created_at", desc=True)
    if scope == "mine" or role not in ideas_all_roles:
        iq = iq.eq("submitted_by", user_id)
    ideas_data = iq.execute().data or []

    # ── Fetch pending assignments for all these submissions ───────────────────
    lead_ids = [l["lead_id"] for l in leads_data]
    idea_ids = [i["idea_id"] for i in ideas_data]
    all_ids  = lead_ids + idea_ids

    assignments_map: dict = {}
    if all_ids:
        asgn_res = (
            supabase.table("assignments")
            .select(
                "submission_id, submission_type, assigned_role, action_taken, "
                "assignee:profiles!assigned_to(id, full_name)"
            )
            .in_("submission_id", all_ids)
            .eq("action_taken", "pending")
            .order("assignment_date", desc=False)
            .execute()
        )
        for a in (asgn_res.data or []):
            sid = a["submission_id"]
            if sid not in assignments_map:
                assignments_map[sid] = a

    # ── Enrich and return ─────────────────────────────────────────────────────
    def enrich(row: dict, id_field: str) -> dict:
        sid  = row[id_field]
        asgn = assignments_map.get(sid)
        return {
            **row,
            "current_assignee":      (asgn or {}).get("assignee", {}).get("full_name") if asgn else None,
            "current_assignee_role": (asgn or {}).get("assigned_role") if asgn else None,
        }

    return {
        "leads": [enrich(l, "lead_id")  for l in leads_data],
        "ideas": [enrich(i, "idea_id") for i in ideas_data],
    }
