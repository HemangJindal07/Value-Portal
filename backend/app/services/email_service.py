"""
Email notification service using SMTP (Gmail / any SMTP server).

Routing rules (driven by the contact-region the user enters on the lead form,
NOT by the account's own region)
──────────────────────────────────────────────────────────────────────────────
contact_region == UK   → TO: stakeholders + sahil.baquer@testingxperts.com
                         CC: adeesh.jain@testingxperts.com

contact_region == US   → TO: stakeholders + joe.underwood@testingxperts.com
                         CC: adeesh.jain@testingxperts.com

contact_region blank
or anything else       → TO: stakeholders
                         CC: adeesh.jain@testingxperts.com
"""

import logging
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

from app.config import get_settings

logger = logging.getLogger("email_service")

# ── Constants ─────────────────────────────────────────────────────────────────

CC_ALWAYS = "adeesh.jain@testingxperts.com"

REGION_EXTRA_RECIPIENTS: dict[str, str] = {
    "united kingdom": "sahil.baquer@testingxperts.com",
    "uk":             "sahil.baquer@testingxperts.com",
    "gb":             "sahil.baquer@testingxperts.com",
    "great britain":  "sahil.baquer@testingxperts.com",
    "england":        "sahil.baquer@testingxperts.com",
    "united states":  "joe.underwood@testingxperts.com",
    "us":             "joe.underwood@testingxperts.com",
    "usa":            "joe.underwood@testingxperts.com",
    "united states of america": "joe.underwood@testingxperts.com",
}


def _get_region_extra(region: str | None) -> str | None:
    if not region:
        return None
    return REGION_EXTRA_RECIPIENTS.get(region.strip().lower())


# ── SMTP send helper ──────────────────────────────────────────────────────────

def _smtp_send(
    to_emails: list[str],
    subject: str,
    html_body: str,
    cc_emails: list[str] | None = None,
) -> None:
    """Send an HTML email via SMTP (STARTTLS on port 587)."""
    settings = get_settings()

    if not settings.smtp_user or not settings.smtp_pass:
        logger.warning("[EMAIL] SMTP credentials not configured — skipping email.")
        return

    from_addr = f"{settings.smtp_from_name} <{settings.smtp_user}>"
    cc_list   = [e for e in (cc_emails or []) if e]

    msg = MIMEMultipart("alternative")
    msg["Subject"] = subject
    msg["From"]    = from_addr
    msg["To"]      = ", ".join(to_emails)
    if cc_list:
        msg["Cc"] = ", ".join(cc_list)

    msg.attach(MIMEText(html_body, "html", "utf-8"))

    all_recipients = list(to_emails) + cc_list

    try:
        with smtplib.SMTP(settings.smtp_host, settings.smtp_port, timeout=15) as server:
            server.ehlo()
            server.starttls()
            server.ehlo()
            server.login(settings.smtp_user, settings.smtp_pass)
            server.sendmail(settings.smtp_user, all_recipients, msg.as_string())
        logger.info("[EMAIL] Sent '%s' → %s (cc: %s)", subject, to_emails, cc_list)
    except smtplib.SMTPAuthenticationError:
        logger.error("[EMAIL] SMTP authentication failed — check SMTP_USER / SMTP_PASS.")
    except smtplib.SMTPException as exc:
        logger.exception("[EMAIL] SMTP error sending '%s': %s", subject, exc)
    except OSError as exc:
        logger.exception("[EMAIL] Network error sending '%s': %s", subject, exc)


# ── HTML templates ────────────────────────────────────────────────────────────

def _build_submission_html(
    submission_type: str,
    title: str,
    account_name: str,
    region: str | None,
    submitter_name: str,
    submitter_email: str,
    description: str,
    portal_url: str,
    submission_id: str,
    extra_rows: list[tuple[str, str]] | None = None,
) -> str:
    type_label  = "New Lead" if submission_type == "lead" else "New Value Idea"
    detail_path = f"leads/{submission_id}" if submission_type == "lead" else f"ideas/{submission_id}"
    cta_url     = f"{portal_url}/{detail_path}"
    desc_preview = description[:300] + ("…" if len(description) > 300 else "")

    extra_html = ""
    for label, value in (extra_rows or []):
        extra_html += f"""
        <tr>
          <td style="padding:6px 12px;color:#5D5D5D;font-size:13px;width:140px;white-space:nowrap;">{label}</td>
          <td style="padding:6px 12px;color:#232222;font-size:13px;">{value}</td>
        </tr>"""

    return f"""<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
  <title>{type_label}: {title}</title>
</head>
<body style="margin:0;padding:0;background:#F9F9F9;font-family:'Inter',Arial,sans-serif;">
  <table width="100%" cellpadding="0" cellspacing="0" style="background:#F9F9F9;padding:32px 0;">
    <tr><td align="center">
      <table width="600" cellpadding="0" cellspacing="0"
             style="background:#ffffff;border-radius:8px;overflow:hidden;border:1px solid #EDE7E6;">
        <tr>
          <td style="background:#B12B35;padding:20px 28px;">
            <table width="100%" cellpadding="0" cellspacing="0"><tr>
              <td><span style="color:#fff;font-size:18px;font-weight:700;">Tx-Catalyst</span>
                  <span style="color:rgba(255,255,255,0.65);font-size:12px;margin-left:8px;">TestingXperts</span></td>
              <td align="right"><span style="background:rgba(255,255,255,0.15);color:#fff;font-size:11px;
                               padding:3px 10px;border-radius:20px;font-weight:600;">{type_label.upper()}</span></td>
            </tr></table>
          </td>
        </tr>
        <tr>
          <td style="padding:24px 28px 8px;">
            <p style="margin:0 0 4px;font-size:11px;color:#B12B35;font-weight:600;
                      text-transform:uppercase;letter-spacing:0.8px;">{type_label}</p>
            <h1 style="margin:0;font-size:22px;font-weight:700;color:#232222;line-height:1.3;">{title}</h1>
          </td>
        </tr>
        <tr>
          <td style="padding:16px 28px;">
            <table width="100%" cellpadding="0" cellspacing="0"
                   style="border:1px solid #EDE7E6;border-radius:6px;overflow:hidden;">
              <tr style="background:#F9F9F9;">
                <td style="padding:6px 12px;color:#5D5D5D;font-size:13px;width:140px;">Account</td>
                <td style="padding:6px 12px;color:#232222;font-size:13px;font-weight:600;">{account_name}</td>
              </tr>
              <tr>
                <td style="padding:6px 12px;color:#5D5D5D;font-size:13px;">Region</td>
                <td style="padding:6px 12px;color:#232222;font-size:13px;">{region or "—"}</td>
              </tr>
              <tr style="background:#F9F9F9;">
                <td style="padding:6px 12px;color:#5D5D5D;font-size:13px;">Submitted by</td>
                <td style="padding:6px 12px;color:#232222;font-size:13px;">
                  {submitter_name}
                  <span style="color:#5D5D5D;font-size:12px;margin-left:4px;">&lt;{submitter_email}&gt;</span>
                </td>
              </tr>
              {extra_html}
            </table>
          </td>
        </tr>
        <tr>
          <td style="padding:0 28px 16px;">
            <p style="margin:0 0 6px;font-size:11px;color:#5D5D5D;font-weight:600;
                      text-transform:uppercase;letter-spacing:0.8px;">Description</p>
            <p style="margin:0;font-size:14px;color:#232222;line-height:1.6;
                      background:#F9F9F9;border-left:3px solid #B12B35;
                      padding:10px 14px;border-radius:0 4px 4px 0;">{desc_preview}</p>
          </td>
        </tr>
        <tr>
          <td style="padding:8px 28px 28px;">
            <a href="{cta_url}" style="display:inline-block;background:#B12B35;color:#ffffff;
                      text-decoration:none;font-size:14px;font-weight:600;
                      padding:11px 24px;border-radius:6px;">View in Tx-Catalyst →</a>
          </td>
        </tr>
        <tr>
          <td style="background:#F9F9F9;padding:14px 28px;border-top:1px solid #EDE7E6;">
            <p style="margin:0;font-size:11px;color:#C5C5C5;text-align:center;">
              Automated notification from TestingXperts Tx-Catalyst. Do not reply.
            </p>
          </td>
        </tr>
      </table>
    </td></tr>
  </table>
</body>
</html>"""


def _build_status_html(
    recipient_name: str,
    submission_type: str,
    title: str,
    account_name: str,
    message_body: str,
    portal_url: str,
    submission_id: str,
    status_color: str = "#B12B35",
) -> str:
    detail_path = f"leads/{submission_id}" if submission_type == "lead" else f"ideas/{submission_id}"
    cta_url = f"{portal_url}/{detail_path}"
    type_label = submission_type.title()

    return f"""<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><title>Tx-Catalyst Notification</title></head>
<body style="margin:0;padding:0;background:#F9F9F9;font-family:'Inter',Arial,sans-serif;">
  <table width="100%" cellpadding="0" cellspacing="0" style="background:#F9F9F9;padding:32px 0;">
    <tr><td align="center">
      <table width="600" cellpadding="0" cellspacing="0"
             style="background:#ffffff;border-radius:8px;overflow:hidden;border:1px solid #EDE7E6;">
        <tr>
          <td style="background:#B12B35;padding:20px 28px;">
            <span style="color:#fff;font-size:18px;font-weight:700;">Tx-Catalyst</span>
            <span style="color:rgba(255,255,255,0.65);font-size:12px;margin-left:8px;">TestingXperts</span>
          </td>
        </tr>
        <tr>
          <td style="padding:28px 28px 12px;">
            <p style="margin:0 0 8px;font-size:13px;color:#5D5D5D;">Hi {recipient_name},</p>
            <p style="margin:0;font-size:16px;color:#232222;line-height:1.6;">{message_body}</p>
          </td>
        </tr>
        <tr>
          <td style="padding:0 28px 12px;">
            <table cellpadding="0" cellspacing="0"
                   style="border:1px solid #EDE7E6;border-radius:6px;overflow:hidden;width:100%;">
              <tr style="background:#F9F9F9;">
                <td style="padding:6px 12px;color:#5D5D5D;font-size:13px;width:100px;">{type_label}</td>
                <td style="padding:6px 12px;color:#232222;font-size:13px;font-weight:600;">{title}</td>
              </tr>
              <tr>
                <td style="padding:6px 12px;color:#5D5D5D;font-size:13px;">Account</td>
                <td style="padding:6px 12px;color:#232222;font-size:13px;">{account_name}</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td style="padding:8px 28px 28px;">
            <a href="{cta_url}" style="display:inline-block;background:#B12B35;color:#ffffff;
                      text-decoration:none;font-size:14px;font-weight:600;
                      padding:11px 24px;border-radius:6px;">View in Tx-Catalyst →</a>
          </td>
        </tr>
        <tr>
          <td style="background:#F9F9F9;padding:14px 28px;border-top:1px solid #EDE7E6;">
            <p style="margin:0;font-size:11px;color:#C5C5C5;text-align:center;">
              Automated notification from TestingXperts Tx-Catalyst. Do not reply.
            </p>
          </td>
        </tr>
      </table>
    </td></tr>
  </table>
</body>
</html>"""


# ── Public API ────────────────────────────────────────────────────────────────

def send_submission_email(
    submission_type: str,
    submission_id: str,
    title: str,
    description: str,
    account_name: str,
    region: str | None,
    submitter_name: str,
    submitter_email: str,
    stakeholder_emails: list[str],
    extra_rows: list[tuple[str, str]] | None = None,
    routing_region: str | None = None,
) -> None:
    """
    Send a new-submission notification email to all stakeholders.
    Called by routing_engine.start_routing immediately after a lead/idea is submitted.

    stakeholder_emails — reviewer addresses (DU, DH, Sales, etc.)
    region — account region; shown in the email body for context only.
    routing_region — the region the user typed under "Client Contact Details"
        on the lead form. Only this value adds UK/US extra recipients.
        If None or unrecognised, the email goes only to stakeholders + Adeesh in CC.
    """
    settings = get_settings()
    portal_url = settings.portal_url

    to_emails: list[str] = list(stakeholder_emails)
    region_extra = _get_region_extra(routing_region)
    if region_extra and region_extra not in to_emails:
        to_emails.append(region_extra)

    if not to_emails:
        logger.warning(
            "[EMAIL] No recipients for %s %s — skipping submission email.",
            submission_type, submission_id,
        )
        return

    subject = f"[Tx-Catalyst] New {submission_type.title()}: {title} — {account_name}"
    html = _build_submission_html(
        submission_type=submission_type,
        title=title,
        account_name=account_name,
        region=region,
        submitter_name=submitter_name,
        submitter_email=submitter_email,
        description=description,
        portal_url=portal_url,
        submission_id=submission_id,
        extra_rows=extra_rows,
    )

    _smtp_send(to_emails=to_emails, subject=subject, html_body=html, cc_emails=[CC_ALWAYS])


def send_reviewer_assignment_email(
    reviewer_email: str,
    reviewer_name: str,
    role_label: str,
    submission_type: str,
    submission_id: str,
    title: str,
    account_name: str,
) -> None:
    """
    Email a reviewer when a submission is routed to them for action.
    Called by routing_engine.advance_routing on each approval step.
    """
    settings = get_settings()
    type_label = submission_type.title()
    message = (
        f"A <strong>{type_label}</strong> has been routed to you for review as "
        f"<strong>{role_label}</strong>. Please log in to the Tx-Catalyst to take action."
    )
    subject = f"[Tx-Catalyst] Action Required — {type_label}: {title}"
    html = _build_status_html(
        recipient_name=reviewer_name,
        submission_type=submission_type,
        title=title,
        account_name=account_name,
        message_body=message,
        portal_url=settings.portal_url,
        submission_id=submission_id,
    )
    _smtp_send(to_emails=[reviewer_email], subject=subject, html_body=html)


def send_submitter_status_email(
    submitter_email: str,
    submitter_name: str,
    submission_type: str,
    submission_id: str,
    title: str,
    account_name: str,
    new_status: str,
    actor_name: str,
    actor_role: str,
) -> None:
    """
    Email the submitter whenever their lead/idea changes status (approved/rejected/final).
    Called by routing_engine.advance_routing.
    """
    settings = get_settings()
    type_label = submission_type.title()

    if new_status in ("approved", "qualified"):
        message = (
            f"Great news! Your <strong>{type_label}</strong> <em>{title}</em> has been "
            f"<strong>Qualified</strong> by <strong>{actor_name}</strong> ({actor_role}). "
            f"The team will now work on creating the opportunity. You have earned <strong>20 points</strong>!"
        )
        subject = f"[Tx-Catalyst] ✓ Lead Qualified: {title}"
    elif new_status == "rejected":
        message = (
            f"Your <strong>{type_label}</strong> <em>{title}</em> was <strong>Rejected</strong> "
            f"by {actor_name} ({actor_role}). Please log in to the portal for details."
        )
        subject = f"[Tx-Catalyst] Lead Rejected: {title}"
    elif new_status == "opportunity_created":
        message = (
            f"Your lead <em>{title}</em> has been moved to <strong>Opportunity Created</strong> "
            f"by <strong>{actor_name}</strong>. The team is now actively working on this opportunity. "
            f"You have earned <strong>50 points</strong>!"
        )
        subject = f"[Tx-Catalyst] Opportunity Created: {title}"
    elif new_status == "won":
        message = (
            f"Congratulations! Your lead <em>{title}</em> has been marked as <strong>Won</strong> "
            f"by <strong>{actor_name}</strong>. Excellent work! "
            f"You have earned <strong>100 points</strong>!"
        )
        subject = f"[Tx-Catalyst] 🎉 Lead Won: {title}"
    elif new_status == "lost":
        message = (
            f"Your lead <em>{title}</em> has been marked as <strong>Lost</strong> "
            f"by <strong>{actor_name}</strong>. Please log in to the portal for more details."
        )
        subject = f"[Tx-Catalyst] Lead Lost: {title}"
    else:
        # Intermediate approval step
        message = (
            f"Your <strong>{type_label}</strong> <em>{title}</em> was approved by "
            f"<strong>{actor_name}</strong> ({actor_role}) and has moved to the next review stage."
        )
        subject = f"[Tx-Catalyst] Lead Progressing: {title}"

    html = _build_status_html(
        recipient_name=submitter_name,
        submission_type=submission_type,
        title=title,
        account_name=account_name,
        message_body=message,
        portal_url=settings.portal_url,
        submission_id=submission_id,
    )
    _smtp_send(to_emails=[submitter_email], subject=subject, html_body=html)
