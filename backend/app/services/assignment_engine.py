from datetime import datetime, timedelta, timezone
from app.database.supabase import get_supabase_admin
from app.services.notification_service import notify_assignment


ROLE_FIELD_MAP = {
    "account_owner_id": "account_owner",
    "sales_lead_id": "sales_lead",
    "practice_leader_id": "practice_leader",
}


async def auto_assign(submission_type: str, submission_id: str, account_id: str) -> None:
    """
    Background task: look up account stakeholders and create assignment rows.
    Fires after every lead or idea submission.
    Deduplicates by user_id so one person never gets two assignments for the same submission.
    Due date is set to 7 days from now (per Section 6 of the product brief).
    """
    print(f"[ASSIGN] 🔄 Auto-assigning {submission_type} {submission_id} (account {account_id})")

    try:
        supabase = get_supabase_admin()

        account_result = (
            supabase.table("accounts")
            .select("account_owner_id, sales_lead_id, practice_leader_id")
            .eq("account_id", account_id)
            .single()
            .execute()
        )

        if not account_result.data:
            print(f"[ASSIGN] ⚠  Account {account_id} not found — no assignments created")
            return

        account = account_result.data
        due_date = (datetime.now(timezone.utc) + timedelta(days=7)).isoformat()

        assignments = []
        seen_users: set[str] = set()

        for field, role in ROLE_FIELD_MAP.items():
            user_id = account.get(field)
            if user_id and user_id not in seen_users:
                seen_users.add(user_id)
                assignments.append({
                    "submission_type": submission_type,
                    "submission_id": submission_id,
                    "assigned_to": user_id,
                    "assigned_role": role,
                    "assigned_by": "system",
                    "due_date": due_date,
                    "action_taken": "pending",
                })

        if not assignments:
            print(f"[ASSIGN] ⚠  No stakeholders found on account {account_id} — no assignments created")
            return

        supabase.table("assignments").insert(assignments).execute()

        submission_title = ""
        if submission_type == "lead":
            res = supabase.table("leads").select("title").eq("lead_id", submission_id).single().execute()
            submission_title = (res.data or {}).get("title", "")
        elif submission_type == "idea":
            res = supabase.table("value_ideas").select("title").eq("idea_id", submission_id).single().execute()
            submission_title = (res.data or {}).get("title", "")

        for a in assignments:
            notify_assignment(a["assigned_to"], submission_type, submission_id, submission_title)

        roles = [a["assigned_role"] for a in assignments]
        print(f"[ASSIGN] ✅ Created {len(assignments)} assignment(s) for {submission_type} {submission_id} → {', '.join(roles)}")

    except Exception as exc:
        print(f"[ASSIGN] ❌ Auto-assign failed for {submission_type} {submission_id}: {exc}")
