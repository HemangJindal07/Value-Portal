from fastapi import APIRouter, BackgroundTasks, Depends, HTTPException, status, Query
from uuid import UUID
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user
from app.schemas.lead import LeadCreate, LeadUpdate, LeadResponse
from app.services.routing_engine import start_routing
from app.services.lead_classifier import classify_lead
from app.services.tracking import record_status_change
from app.services.notification_service import notify_status_change
from app.services.scoring import award_points, revoke_points_for_submission
from app.services.sanitize import sanitize_dict

router = APIRouter(prefix="/leads", tags=["Leads"])


def _user_can_update_lead_status(supabase, lead: dict, current_user: dict) -> bool:
    """Who may use PATCH to change lead.status (UI: Change Status)."""
    uid = current_user["id"]
    role = current_user["role"]
    if role in ("admin", "executive"):
        return True
    if lead.get("submitted_by") == uid:
        return False
    if role == "sales" and lead.get("status") in ("approved", "qualified"):
        return True
    pending = (
        supabase.table("assignments")
        .select("assignment_id")
        .eq("submission_type", "lead")
        .eq("submission_id", str(lead["lead_id"]))
        .eq("assigned_to", uid)
        .eq("action_taken", "pending")
        .limit(1)
        .execute()
    )
    return bool(pending.data)


@router.get("")
async def list_leads(
    status_filter: str | None = Query(None, alias="status"),
    lead_type: str | None = None,
    account_id: str | None = None,
    priority: str | None = None,
    search: str | None = None,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    user_id = current_user["id"]
    role = current_user["role"]

    query = supabase.table("leads").select(
        "*, account:accounts(account_id, account_name), submitter:profiles!submitted_by(id, full_name, email)"
    )

    # Executives may view the org-wide unrouted-leads list (Exception Queue
    # page / dashboard tile). For the routing_pending status query only, give
    # them the same org-wide visibility as admin so the Exception Queue page
    # matches the count shown on their dashboard tile (Catalyst issue #15).
    exec_exception_view = (
        role == "executive"
        and status_filter is not None
        and {s.strip() for s in status_filter.split(",") if s.strip()} == {"routing_pending"}
    )

    # Role-based scoping:
    # - admin: sees all leads
    # - executive: sees leads they submitted + leads they have an assignment on
    #   (plus the org-wide routing_pending list — see exec_exception_view above)
    # - all others (user, sales, practice_lead): own submissions only
    if role == "admin" or exec_exception_view:
        pass  # no filter — admin (or executive viewing Exception Queue) sees all
    elif role == "executive":
        # Get submission IDs the executive has an assignment on
        asgn_res = (
            supabase.table("assignments")
            .select("submission_id")
            .eq("assigned_to", user_id)
            .eq("submission_type", "lead")
            .execute()
        )
        assigned_ids = [a["submission_id"] for a in (asgn_res.data or [])]
        # Leads they submitted OR leads assigned to them
        if assigned_ids:
            query = query.or_(f"submitted_by.eq.{user_id},lead_id.in.({','.join(assigned_ids)})")
        else:
            query = query.eq("submitted_by", user_id)
    else:
        # user, sales, practice_lead — own submissions only
        query = query.eq("submitted_by", user_id)

    if status_filter:
        statuses = [s.strip() for s in status_filter.split(",") if s.strip()]
        if len(statuses) == 1:
            query = query.eq("status", statuses[0])
        elif statuses:
            query = query.in_("status", statuses)
    if lead_type:
        query = query.eq("lead_type", lead_type)
    if account_id:
        query = query.eq("account_id", account_id)
    if priority:
        query = query.eq("priority", priority)
    if search:
        query = query.ilike("title", f"%{search}%")

    query = query.order("created_at", desc=True)
    result = query.execute()
    return result.data


@router.get("/{lead_id}")
async def get_lead(
    lead_id: UUID,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    result = (
        supabase.table("leads")
        .select(
            "*, account:accounts(account_id, account_name, industry, region), submitter:profiles!submitted_by(id, full_name, email, role)"
        )
        .eq("lead_id", str(lead_id))
        .single()
        .execute()
    )

    if not result.data:
        raise HTTPException(status_code=404, detail="Lead not found")

    row = result.data
    uid = current_user["id"]
    role = current_user["role"]

    if role not in ("admin", "executive"):
        is_submitter = row.get("submitted_by") == uid
        has_assignment = bool(
            supabase.table("assignments")
            .select("assignment_id")
            .eq("submission_type", "lead")
            .eq("submission_id", str(lead_id))
            .eq("assigned_to", uid)
            .limit(1)
            .execute()
            .data
        )
        if not is_submitter and not has_assignment:
            raise HTTPException(status_code=403, detail="Not authorized to view this lead")

    row["can_update_status"] = _user_can_update_lead_status(
        supabase, row, current_user
    )
    return row


@router.post("", status_code=status.HTTP_201_CREATED)
async def create_lead(
    payload: LeadCreate,
    background_tasks: BackgroundTasks,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    data = payload.model_dump(mode="json")
    sanitize_dict(data, ["title", "description"])
    data["submitted_by"] = current_user["id"]
    data["status"] = "submitted"

    result = supabase.table("leads").insert(data).execute()
    lead = result.data[0]

    # Points are awarded inside start_routing (only when routing succeeds,
    # not when the lead ends up routing_pending)
    background_tasks.add_task(
        start_routing, "lead", str(lead["lead_id"]), str(lead["account_id"]), current_user["id"]
    )
    background_tasks.add_task(classify_lead, str(lead["lead_id"]))

    return lead


@router.patch("/{lead_id}")
async def update_lead(
    lead_id: UUID,
    payload: LeadUpdate,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()

    existing = (
        supabase.table("leads")
        .select("*")
        .eq("lead_id", str(lead_id))
        .single()
        .execute()
    )
    if not existing.data:
        raise HTTPException(status_code=404, detail="Lead not found")

    user_role = current_user["role"]
    user_id = current_user["id"]
    is_submitter = existing.data["submitted_by"] == user_id
    is_privileged = user_role in ("admin", "executive", "sales")

    if not is_submitter and not is_privileged:
        raise HTTPException(status_code=403, detail="Not authorized")

    update_data = payload.model_dump(exclude_unset=True, mode="json")
    sanitize_dict(update_data, ["title", "description"])
    if not update_data:
        out = existing.data.copy()
        out["can_update_status"] = _user_can_update_lead_status(
            supabase, existing.data, current_user
        )
        return out

    old_status = existing.data.get("status")
    new_status = update_data.get("status")

    if new_status is not None and new_status != old_status:
        if is_submitter and user_role not in ("admin", "executive"):
            raise HTTPException(
                status_code=403,
                detail="Submitters cannot change lead status; use My Assignments to track review progress",
            )
        if user_role not in ("admin", "executive"):
            allowed = False
            if (
                user_role == "sales"
                and old_status in ("approved", "qualified")
                and new_status
                in ("qualified", "won", "lost", "dropped")
            ):
                allowed = True
            if not allowed:
                pending = (
                    supabase.table("assignments")
                    .select("assignment_id")
                    .eq("submission_type", "lead")
                    .eq("submission_id", str(lead_id))
                    .eq("assigned_to", user_id)
                    .eq("action_taken", "pending")
                    .limit(1)
                    .execute()
                )
                if pending.data:
                    allowed = True
            if not allowed:
                raise HTTPException(
                    status_code=403,
                    detail="Only assigned reviewers or sales (after approval) can change status",
                )

    result = (
        supabase.table("leads")
        .update(update_data)
        .eq("lead_id", str(lead_id))
        .execute()
    )

    if new_status and new_status != old_status:
        record_status_change(
            submission_type="lead",
            submission_id=str(lead_id),
            from_status=old_status,
            to_status=new_status,
            changed_by=current_user["id"],
        )
        notify_status_change(
            submission_type="lead",
            submission_id=str(lead_id),
            submission_title=existing.data.get("title", ""),
            submitter_id=existing.data["submitted_by"],
            old_status=old_status,
            new_status=new_status,
        )

        scoreable = {"qualified", "won"}
        event_map = {"qualified": "qualified", "won": "deal_won"}
        if new_status in scoreable:
            award_points(
                existing.data["submitted_by"],
                "lead",
                str(lead_id),
                event_map[new_status],
            )

    updated_row = result.data[0]
    updated_row["can_update_status"] = _user_can_update_lead_status(
        supabase, updated_row, current_user
    )
    return updated_row


@router.get("/{lead_id}/routing")
async def get_lead_routing(
    lead_id: UUID,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    lead_res = (
        supabase.table("leads")
        .select("submitted_by, account_id, status")
        .eq("lead_id", str(lead_id))
        .single()
        .execute()
    )
    if not lead_res.data:
        raise HTTPException(status_code=404, detail="Lead not found")

    lead = lead_res.data
    uid = current_user["id"]
    role = current_user["role"]

    if role not in ("admin", "executive") and lead["submitted_by"] != uid:
        has_assignment = bool(
            supabase.table("assignments")
            .select("assignment_id")
            .eq("submission_type", "lead")
            .eq("submission_id", str(lead_id))
            .eq("assigned_to", uid)
            .limit(1)
            .execute()
            .data
        )
        if not has_assignment:
            raise HTTPException(status_code=403, detail="Not authorized")

    account_id = lead.get("account_id")
    if not account_id:
        return {"steps": [], "lead_status": lead["status"]}

    stakeholders = (
        supabase.table("account_stakeholders")
        .select("user_id, role_label, step_order")
        .eq("account_id", str(account_id))
        .order("step_order")
        .execute()
    ).data or []

    assignments = (
        supabase.table("assignments")
        .select("assigned_to, action_taken, action_date, assigned_role")
        .eq("submission_type", "lead")
        .eq("submission_id", str(lead_id))
        .execute()
    ).data or []

    assignment_map = {a["assigned_to"]: a for a in assignments}

    user_ids = list({s["user_id"] for s in stakeholders})
    profiles_map: dict[str, str] = {}
    if user_ids:
        profiles = (
            supabase.table("profiles")
            .select("id, full_name")
            .in_("id", user_ids)
            .execute()
        ).data or []
        profiles_map = {p["id"]: p["full_name"] for p in profiles}

    steps = []
    for s in stakeholders:
        asgn = assignment_map.get(s["user_id"])
        steps.append({
            "step_order": s["step_order"],
            "role_label": s["role_label"],
            "reviewer_name": profiles_map.get(s["user_id"], "Unknown"),
            "action_taken": asgn["action_taken"] if asgn else None,
            "action_date": asgn.get("action_date") if asgn else None,
        })

    return {"steps": steps, "lead_status": lead["status"]}


@router.delete("/{lead_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_lead(
    lead_id: UUID,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    existing = (
        supabase.table("leads")
        .select("submitted_by, status")
        .eq("lead_id", str(lead_id))
        .single()
        .execute()
    )

    if not existing.data:
        raise HTTPException(status_code=404, detail="Lead not found")

    is_submitter = existing.data["submitted_by"] == current_user["id"]
    is_draft = existing.data["status"] == "draft"
    is_admin = current_user["role"] == "admin"

    if not is_admin and not (is_submitter and is_draft):
        raise HTTPException(status_code=403, detail="Can only delete own drafts")

    supabase.table("leads").delete().eq("lead_id", str(lead_id)).execute()
    revoke_points_for_submission(str(lead_id))
