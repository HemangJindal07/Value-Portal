"""
Email notification service using Resend.

Region routing rules
──────────────────────────────────────────────────────────────────────────────
UK  → TO: account stakeholders + sahil.baquer@testingxperts.com
      CC: adeesh.jain@testingxperts.com

US  → TO: account stakeholders + joe.underwood@testingxperts.com
      CC: adeesh.jain@testingxperts.com

All other regions
    → TO: account stakeholders
      CC: adeesh.jain@testingxperts.com

NOTE: Until testingxperts.com is verified with Resend the FROM address uses
      Resend's shared sandbox domain.  Once the domain is verified, set
      FROM_EMAIL = "Value Portal <noreply@testingxperts.com>" in .env or
      directly in this file.
"""

import logging
import resend
from app.config import get_settings

logger = logging.getLogger("email_service")

# ── Constants ─────────────────────────────────────────────────────────────────

# Sandbox FROM — works before domain verification.
# Replace with "Value Portal <noreply@testingxperts.com>" once verified.
FROM_EMAIL = "Value Portal <onboarding@resend.dev>"

CC_ALWAYS = "adeesh.jain@testingxperts.com"

# Region → fixed extra recipient (TO)
REGION_EXTRA_RECIPIENTS: dict[str, str] = {
    # United Kingdom variations
    "united kingdom": "sahil.baquer@testingxperts.com",
    "uk":             "sahil.baquer@testingxperts.com",
    "gb":             "sahil.baquer@testingxperts.com",
    "great britain":  "sahil.baquer@testingxperts.com",
    "england":        "sahil.baquer@testingxperts.com",
    # United States variations
    "united states":  "joe.underwood@testingxperts.com",
    "us":             "joe.underwood@testingxperts.com",
    "usa":            "joe.underwood@testingxperts.com",
    "united states of america": "joe.underwood@testingxperts.com",
}


def _get_region_extra(region: str | None) -> str | None:
    """Return the region-specific fixed recipient email, or None."""
    if not region:
        return None
    return REGION_EXTRA_RECIPIENTS.get(region.strip().lower())


# ── HTML email template ───────────────────────────────────────────────────────

def _build_html(
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
    """Return a branded HTML email body."""

    type_label = "New Lead" if submission_type == "lead" else "New Value Idea"
    detail_path = f"leads/{submission_id}" if submission_type == "lead" else f"ideas/{submission_id}"
    cta_url = f"{portal_url}/{detail_path}"

    # Truncate description for email preview
    desc_preview = description[:300] + ("…" if len(description) > 300 else "")

    extra_html = ""
    if extra_rows:
        for label, value in extra_rows:
            extra_html += f"""
            <tr>
              <td style="padding:6px 12px;color:#5D5D5D;font-size:13px;width:140px;white-space:nowrap;">{label}</td>
              <td style="padding:6px 12px;color:#232222;font-size:13px;">{value}</td>
            </tr>"""

    return f"""<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>{type_label}: {title}</title>
</head>
<body style="margin:0;padding:0;background:#F9F9F9;font-family:'Inter',Arial,sans-serif;">
  <table width="100%" cellpadding="0" cellspacing="0" style="background:#F9F9F9;padding:32px 0;">
    <tr><td align="center">
      <table width="600" cellpadding="0" cellspacing="0"
             style="background:#ffffff;border-radius:8px;overflow:hidden;border:1px solid #EDE7E6;">

        <!-- Header -->
        <tr>
          <td style="background:#B12B35;padding:20px 28px;">
            <table width="100%" cellpadding="0" cellspacing="0">
              <tr>
                <td>
                  <span style="color:#ffffff;font-size:18px;font-weight:700;letter-spacing:-0.3px;">
                    Value Portal
                  </span>
                  <span style="color:rgba(255,255,255,0.65);font-size:12px;margin-left:8px;">
                    TestingXperts
                  </span>
                </td>
                <td align="right">
                  <span style="background:rgba(255,255,255,0.15);color:#fff;font-size:11px;
                               padding:3px 10px;border-radius:20px;font-weight:600;">
                    {type_label.upper()}
                  </span>
                </td>
              </tr>
            </table>
          </td>
        </tr>

        <!-- Title row -->
        <tr>
          <td style="padding:24px 28px 8px;">
            <p style="margin:0 0 4px;font-size:11px;color:#B12B35;font-weight:600;
                      text-transform:uppercase;letter-spacing:0.8px;">
              {type_label}
            </p>
            <h1 style="margin:0;font-size:22px;font-weight:700;color:#232222;line-height:1.3;">
              {title}
            </h1>
          </td>
        </tr>

        <!-- Details table -->
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

        <!-- Description -->
        <tr>
          <td style="padding:0 28px 16px;">
            <p style="margin:0 0 6px;font-size:11px;color:#5D5D5D;font-weight:600;
                      text-transform:uppercase;letter-spacing:0.8px;">Description</p>
            <p style="margin:0;font-size:14px;color:#232222;line-height:1.6;
                      background:#F9F9F9;border-left:3px solid #B12B35;
                      padding:10px 14px;border-radius:0 4px 4px 0;">
              {desc_preview}
            </p>
          </td>
        </tr>

        <!-- CTA -->
        <tr>
          <td style="padding:8px 28px 28px;">
            <a href="{cta_url}"
               style="display:inline-block;background:#B12B35;color:#ffffff;
                      text-decoration:none;font-size:14px;font-weight:600;
                      padding:11px 24px;border-radius:6px;">
              View in Value Portal →
            </a>
          </td>
        </tr>

        <!-- Footer -->
        <tr>
          <td style="background:#F9F9F9;padding:14px 28px;border-top:1px solid #EDE7E6;">
            <p style="margin:0;font-size:11px;color:#C5C5C5;text-align:center;">
              This is an automated notification from the TestingXperts Value Portal.
              Please do not reply to this email.
            </p>
          </td>
        </tr>

      </table>
    </td></tr>
  </table>
</body>
</html>"""


# ── Public send function ──────────────────────────────────────────────────────

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
) -> None:
    """
    Send a new-submission notification email.

    stakeholder_emails — list of reviewer email addresses (DH, DU, Sales, etc.)
    extra_rows         — optional additional rows for the details table
    """
    settings = get_settings()

    if not settings.resend_api_key:
        logger.warning("[EMAIL] RESEND_API_KEY not set — skipping email.")
        return

    resend.api_key = settings.resend_api_key
    portal_url = settings.portal_url

    # Build TO list: stakeholders + region-specific extra recipient
    to_emails: list[str] = list(stakeholder_emails)  # copy
    region_extra = _get_region_extra(region)
    if region_extra and region_extra not in to_emails:
        to_emails.append(region_extra)

    if not to_emails:
        logger.warning(
            "[EMAIL] No recipients for %s %s (no stakeholders, no region match) — skipping.",
            submission_type, submission_id,
        )
        return

    subject = f"[Value Portal] New {submission_type.title()}: {title} — {account_name}"

    html_body = _build_html(
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

    try:
        params: resend.Emails.SendParams = {
            "from": FROM_EMAIL,
            "to": to_emails,
            "cc": [CC_ALWAYS],
            "subject": subject,
            "html": html_body,
        }
        response = resend.Emails.send(params)
        logger.info(
            "[EMAIL] Sent %s notification for %s '%s' → %s (cc: %s) | id: %s",
            submission_type, submission_id, title,
            to_emails, CC_ALWAYS,
            getattr(response, "id", "?"),
        )
    except Exception as exc:
        logger.exception("[EMAIL] Failed to send email for %s %s: %s", submission_type, submission_id, exc)
