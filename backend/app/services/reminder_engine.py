"""
Checks for overdue assignments and creates reminder/escalation notifications.
Designed to be called periodically (e.g., via a cron endpoint).
"""

import logging
from datetime import datetime, timezone, timedelta
from app.database.supabase import get_supabase_admin
from app.services.notification_service import notify_reminder, notify_escalation

logger = logging.getLogger("reminder_engine")


def check_reminders_and_escalations() -> dict:
    supabase = get_supabase_admin()
    now = datetime.now(timezone.utc)
    stats = {"reminders_sent": 0, "escalations_sent": 0}

    pending_assignments = (
        supabase.table("assignments")
        .select("*, lead:leads(lead_id, title), idea:value_ideas(idea_id, title)")
        .eq("action_taken", "pending")
        .execute()
    )

    if not pending_assignments.data:
        return stats

    rules = (
        supabase.table("escalation_rules")
        .select("*")
        .eq("is_active", True)
        .execute()
    )
    escalation_rules = rules.data or []

    for assignment in pending_assignments.data:
        created = datetime.fromisoformat(
            assignment["created_at"].replace("Z", "+00:00")
        )
        days_pending = (now - created).days

        sub_type = assignment["submission_type"]
        sub_id = assignment["submission_id"]
        assignee_id = assignment["assigned_to"]

        title = ""
        if sub_type == "lead" and assignment.get("lead"):
            title = assignment["lead"].get("title", "")
        elif sub_type == "idea" and assignment.get("idea"):
            title = assignment["idea"].get("title", "")

        if days_pending >= 3 and days_pending < 7:
            already_reminded = (
                supabase.table("notifications")
                .select("notification_id", count="exact")
                .eq("recipient_id", assignee_id)
                .eq("submission_id", sub_id)
                .eq("type", "reminder")
                .execute()
            )
            if (already_reminded.count or 0) == 0:
                notify_reminder(assignee_id, sub_type, sub_id, title, days_pending)
                stats["reminders_sent"] += 1

        for rule in escalation_rules:
            if days_pending >= rule["trigger_days"]:
                escalate_to_role = rule["escalate_to_role"]

                admins = (
                    supabase.table("profiles")
                    .select("id")
                    .eq("role", escalate_to_role)
                    .eq("is_active", True)
                    .execute()
                )

                for admin in admins.data or []:
                    already_escalated = (
                        supabase.table("notifications")
                        .select("notification_id", count="exact")
                        .eq("recipient_id", admin["id"])
                        .eq("submission_id", sub_id)
                        .eq("type", "escalation")
                        .execute()
                    )
                    if (already_escalated.count or 0) == 0:
                        notify_escalation(
                            admin["id"], sub_type, sub_id, title, days_pending
                        )
                        stats["escalations_sent"] += 1

    logger.info(
        "Reminder check complete: %d reminders, %d escalations",
        stats["reminders_sent"],
        stats["escalations_sent"],
    )
    return stats
