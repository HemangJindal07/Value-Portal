from app.database.supabase import get_supabase_admin


def record_status_change(
    submission_type: str,
    submission_id: str,
    from_status: str,
    to_status: str,
    changed_by: str,
    reason: str | None = None,
) -> None:
    """
    Synchronously insert a status_history row whenever a lead or idea status changes.
    Called inside PATCH /leads and PATCH /ideas when the status field is updated.
    """
    try:
        supabase = get_supabase_admin()
        supabase.table("status_history").insert({
            "submission_type": submission_type,
            "submission_id": submission_id,
            "from_status": from_status,
            "to_status": to_status,
            "changed_by": changed_by,
            "reason": reason,
        }).execute()
        print(f"[TRACK] 📋 Status change recorded: {submission_type} {submission_id} → {from_status} → {to_status}")
    except Exception as exc:
        print(f"[TRACK] ❌ Failed to record status change for {submission_type} {submission_id}: {exc}")
