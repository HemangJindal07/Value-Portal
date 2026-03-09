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

CLASSIFICATION_PROMPT = """You are an expert sales analyst. Analyze the following lead submitted by a delivery team and return a JSON classification.

LEAD DETAILS:
Title: {title}
Description: {description}
User-Selected Type: {lead_type}
Estimated Value: {estimated_value}
Probability: {probability}%
Priority: {priority}

Classify this lead and return ONLY a valid JSON object with exactly these three fields:

{{
  "ai_category": "<one of: cross_sell | upsell | new_service | expansion | strategic_partnership | renewal_risk>",
  "ai_summary": "<2-3 sentence summary of the opportunity, its potential, and recommended next steps>",
  "ai_confidence": <a decimal between 0.0 and 1.0 representing your confidence in the classification>
}}

Category definitions:
- cross_sell: Opportunity to sell a different service/product to the same client
- upsell: Opportunity to expand scope or upgrade existing engagement
- new_service: Completely new service line not previously offered to this client
- expansion: Growing the current engagement (more resources, longer duration)
- strategic_partnership: Long-term partnership or joint venture opportunity
- renewal_risk: Client may not renew — proactive retention opportunity

Rules:
- ai_category must be exactly one of the 6 values listed above
- ai_summary must be 2-3 sentences, clear and actionable
- ai_confidence must be a number between 0.0 and 1.0
- Return ONLY the JSON object, no other text, no markdown fences"""


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
            model="claude-3-haiku-20240307",
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

        supabase.table("leads").update(
            {
                "ai_category": ai_category,
                "ai_confidence": ai_confidence,
            }
        ).eq("lead_id", lead_id).execute()

        logger.info("Lead %s classified: %s (%.0f%%)", lead_id, ai_category, ai_confidence * 100)

    except Exception as exc:
        logger.exception("Lead classification failed for %s: %s", lead_id, exc)
