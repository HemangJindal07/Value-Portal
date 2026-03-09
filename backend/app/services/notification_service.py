import logging
from app.database.supabase import get_supabase_admin

logger = logging.getLogger("notification_service")


def send_notification(
    recipient_id: str,
    submission_type: str,
    submission_id: str,
    notification_type: str,
    message: str,
    channel: str = "in_app",
) -> None:
    try:
        supabase = get_supabase_admin()
        supabase.table("notifications").insert(
            {
                "recipient_id": recipient_id,
                "submission_type": submission_type,
                "submission_id": submission_id,
                "type": notification_type,
                "message": message,
                "channel": channel,
            }
        ).execute()
        logger.info("Notification sent to %s: %s", recipient_id, notification_type)
    except Exception as exc:
        logger.exception("Failed to send notification to %s: %s", recipient_id, exc)


def notify_status_change(
    submission_type: str,
    submission_id: str,
    submission_title: str,
    submitter_id: str,
    old_status: str,
    new_status: str,
) -> None:
    message = f'Your {submission_type} "{submission_title}" status changed from {old_status} to {new_status}.'
    send_notification(
        recipient_id=submitter_id,
        submission_type=submission_type,
        submission_id=submission_id,
        notification_type="status_update",
        message=message,
    )


def notify_assignment(
    assignee_id: str,
    submission_type: str,
    submission_id: str,
    submission_title: str,
) -> None:
    message = f'You have been assigned to review a {submission_type}: "{submission_title}".'
    send_notification(
        recipient_id=assignee_id,
        submission_type=submission_type,
        submission_id=submission_id,
        notification_type="approval",
        message=message,
    )


def notify_reminder(
    recipient_id: str,
    submission_type: str,
    submission_id: str,
    submission_title: str,
    days_pending: int,
) -> None:
    message = f'Reminder: {submission_type} "{submission_title}" has been pending for {days_pending} days.'
    send_notification(
        recipient_id=recipient_id,
        submission_type=submission_type,
        submission_id=submission_id,
        notification_type="reminder",
        message=message,
    )


def notify_escalation(
    recipient_id: str,
    submission_type: str,
    submission_id: str,
    submission_title: str,
    days_pending: int,
) -> None:
    message = f'Escalation: {submission_type} "{submission_title}" has been pending for {days_pending} days and requires attention.'
    send_notification(
        recipient_id=recipient_id,
        submission_type=submission_type,
        submission_id=submission_id,
        notification_type="escalation",
        message=message,
    )
