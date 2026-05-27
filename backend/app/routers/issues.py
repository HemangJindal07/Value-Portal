from datetime import datetime, timezone
from fastapi import APIRouter, Depends, HTTPException, status
from uuid import UUID

from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user, require_role
from app.schemas.issue import IssueCreate, IssueStatusUpdate, IssueResponse
from app.services.notification_service import send_notification
from app.services.email_service import (
    send_issue_reported_email,
    send_issue_resolved_email,
)

router = APIRouter(prefix="/issues", tags=["Issues"])

# Allowed forward-only status transitions. Once 'resolved' it is locked.
_ALLOWED_TRANSITIONS = {
    "open": {"in_progress"},
    "in_progress": {"resolved"},
    "resolved": set(),
}


def _active_admins(supabase) -> list[dict]:
    """All active admin profiles (id, full_name, email)."""
    return (
        supabase.table("profiles")
        .select("id, full_name, email")
        .eq("role", "admin")
        .eq("is_active", True)
        .execute()
        .data
        or []
    )


@router.post("", response_model=IssueResponse, status_code=status.HTTP_201_CREATED)
async def create_issue(
    payload: IssueCreate,
    current_user: dict = Depends(get_current_user),
):
    """Report a new issue. Reporter name/email are snapshotted from the profile."""
    supabase = get_supabase_admin()

    reporter_name = current_user.get("full_name") or "Unknown"
    reporter_email = current_user.get("email") or ""

    insert = (
        supabase.table("issues")
        .insert(
            {
                "reporter_id": current_user["id"],
                "reporter_name": reporter_name,
                "reporter_email": reporter_email,
                "description": payload.description,
                "screenshots": [s.model_dump() for s in payload.screenshots],
            }
        )
        .execute()
    )
    issue = (insert.data or [None])[0]
    if not issue:
        raise HTTPException(status.HTTP_500_INTERNAL_SERVER_ERROR, "Could not create issue.")

    # Notify every active admin: in-app notification + email to their real inbox.
    screenshot_names = [s.filename for s in payload.screenshots]
    try:
        for admin in _active_admins(supabase):
            send_notification(
                recipient_id=admin["id"],
                submission_type="issue",
                submission_id=issue["issue_id"],
                notification_type="info",
                message=f"New issue reported by {reporter_name}.",
            )
            if admin.get("email"):
                try:
                    send_issue_reported_email(
                        recipient_email=admin["email"],
                        reporter_name=reporter_name,
                        reporter_email=reporter_email,
                        description=payload.description,
                        screenshot_names=screenshot_names,
                    )
                except Exception:
                    pass  # email failure must not block issue creation
    except Exception:
        pass

    return issue


@router.get("", response_model=list[IssueResponse])
async def list_issues(current_user: dict = Depends(get_current_user)):
    """Admins see all issues; everyone else sees only the ones they reported."""
    supabase = get_supabase_admin()
    query = supabase.table("issues").select("*").order("created_at", desc=True)
    if current_user.get("role") != "admin":
        query = query.eq("reporter_id", current_user["id"])
    return query.execute().data or []


@router.patch("/{issue_id}", response_model=IssueResponse)
async def update_issue_status(
    issue_id: UUID,
    payload: IssueStatusUpdate,
    current_user: dict = Depends(require_role("admin")),
):
    """
    Admin advances an issue's status (open → in_progress → resolved, forward only).
    A resolved issue is locked. On resolution, emails the reporter + all admins.
    """
    supabase = get_supabase_admin()

    existing = (
        supabase.table("issues").select("*").eq("issue_id", str(issue_id)).execute().data
    )
    if not existing:
        raise HTTPException(status.HTTP_404_NOT_FOUND, "Issue not found.")

    issue = existing[0]
    current_status = issue["status"]
    new_status = payload.status

    if new_status == current_status:
        return issue  # no-op

    if current_status == "resolved":
        raise HTTPException(
            status.HTTP_409_CONFLICT,
            "This issue is resolved and can no longer be changed.",
        )
    if new_status not in _ALLOWED_TRANSITIONS.get(current_status, set()):
        raise HTTPException(
            status.HTTP_400_BAD_REQUEST,
            f"Cannot change status from '{current_status}' to '{new_status}'.",
        )

    res = (
        supabase.table("issues")
        .update(
            {
                "status": new_status,
                "updated_at": datetime.now(timezone.utc).isoformat(),
            }
        )
        .eq("issue_id", str(issue_id))
        .execute()
    )
    updated = (res.data or [None])[0]

    # In-app status update to the reporter — include a snippet so they can tell
    # which issue it refers to.
    snippet = (issue.get("description") or "").strip().replace("\n", " ")
    if len(snippet) > 50:
        snippet = snippet[:50].rstrip() + "…"
    try:
        send_notification(
            recipient_id=issue["reporter_id"],
            submission_type="issue",
            submission_id=str(issue_id),
            notification_type="status_update",
            message=f'Your issue "{snippet}" is now {new_status.replace("_", " ")}.',
        )
    except Exception:
        pass

    # On resolution: email the reporter + all admins.
    if new_status == "resolved":
        resolved_by = current_user.get("full_name") or "an admin"
        recipients = {issue.get("reporter_email")} | {
            a.get("email") for a in _active_admins(supabase)
        }
        for email in recipients:
            if not email:
                continue
            try:
                send_issue_resolved_email(
                    recipient_email=email,
                    reporter_name=issue.get("reporter_name") or "a user",
                    description=issue.get("description") or "",
                    resolved_by=resolved_by,
                )
            except Exception:
                pass

    return updated
