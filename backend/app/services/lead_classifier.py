import json
import logging
from anthropic import Anthropic
from app.config import get_settings
from app.database.supabase import get_supabase_admin

logger = logging.getLogger("lead_classifier")

VALID_CATEGORIES = {
    "cross_sell",
    "upsell",
    "new_service",
    "expansion",
    "strategic_partnership",
    "renewal_risk",
}

CLASSIFICATION_PROMPT = """Analyze this sales lead and return a JSON classification.

Title: {title}
Description: {description}
Type: {lead_type}
Value: {estimated_value}
Probability: {probability}%
Priority: {priority}

Return ONLY valid JSON:
{{
  "ai_category": "<cross_sell|upsell|new_service|expansion|strategic_partnership|renewal_risk>",
  "ai_summary": "<1-2 sentence actionable summary with recommended next step>",
  "ai_confidence": <0.0-1.0>,
  "ai_suggested_priority": "<high|medium|low>",
  "ai_win_probability": <0.0-1.0>
}}

Priority guidance: high=urgent/large value/strong signals, medium=moderate potential, low=exploratory/early stage.
Win probability: factor in deal value, client signals, competition likelihood, and stated probability."""


async def classify_lead(lead_id: str) -> None:
    settings = get_settings()

    if not settings.anthropic_api_key:
        logger.warning("ANTHROPIC_API_KEY not set — skipping classification for lead %s", lead_id)
        return

    try:
        supabase = get_supabase_admin()

        result = (
            supabase.table("leads")
            .select("*")
            .eq("lead_id", lead_id)
            .single()
            .execute()
        )

        if not result.data:
            logger.error("Lead %s not found in DB", lead_id)
            return

        lead = result.data

        prompt = CLASSIFICATION_PROMPT.format(
            title=lead.get("title", ""),
            description=lead.get("description", ""),
            lead_type=lead.get("lead_type", ""),
            estimated_value=lead.get("estimated_value") or "Not specified",
            probability=lead.get("probability") or "Not specified",
            priority=lead.get("priority", "medium"),
        )

        client = Anthropic(api_key=settings.anthropic_api_key)
        message = client.messages.create(
            model="claude-sonnet-4-6",
            max_tokens=512,
            messages=[{"role": "user", "content": prompt}],
        )

        raw = message.content[0].text.strip()

        try:
            parsed = json.loads(raw)
        except json.JSONDecodeError:
            start = raw.find("{")
            end = raw.rfind("}") + 1
            if start != -1 and end > start:
                parsed = json.loads(raw[start:end])
            else:
                raise ValueError(f"Could not parse Claude response: {raw!r}")

        ai_category = parsed.get("ai_category", "").strip().lower()
        ai_confidence = max(0.0, min(1.0, float(parsed.get("ai_confidence", 0.0))))

        if ai_category not in VALID_CATEGORIES:
            ai_category = lead.get("lead_type", "cross_sell")

        ai_summary = (parsed.get("ai_summary") or "")[:500]
        ai_suggested_priority = parsed.get("ai_suggested_priority", "").strip().lower()
        if ai_suggested_priority not in ("high", "medium", "low"):
            ai_suggested_priority = lead.get("priority", "medium")
        ai_win_probability = max(0.0, min(1.0, float(parsed.get("ai_win_probability", 0.0))))

        update_fields: dict = {
            "ai_category": ai_category,
            "ai_confidence": ai_confidence,
        }
        if ai_summary:
            update_fields["ai_summary"] = ai_summary
        if ai_suggested_priority:
            update_fields["ai_suggested_priority"] = ai_suggested_priority
        if ai_win_probability > 0:
            update_fields["ai_win_probability"] = ai_win_probability

        supabase.table("leads").update(update_fields).eq("lead_id", lead_id).execute()

        logger.info("Lead %s classified: %s (%.0f%%) priority=%s win=%.0f%%",
                     lead_id, ai_category, ai_confidence * 100,
                     ai_suggested_priority, ai_win_probability * 100)

    except Exception as exc:
        logger.exception("Lead classification failed for %s: %s", lead_id, exc)
