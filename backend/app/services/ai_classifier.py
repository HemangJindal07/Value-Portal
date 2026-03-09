import json
import logging
from anthropic import Anthropic
from app.config import get_settings
from app.database.supabase import get_supabase_admin

logger = logging.getLogger("ai_classifier")

VALID_CATEGORIES = {
    "revenue_opportunity",
    "automation",
    "cost_optimization",
    "efficiency_improvement",
    "risk_reduction",
    "innovation",
}

CLASSIFICATION_PROMPT = """You are an expert business analyst. Analyze the following value idea submitted by a delivery team and return a JSON classification.

IDEA DETAILS:
Title: {title}
Problem Statement: {problem_statement}
Proposed Solution: {proposed_solution}
User-Selected Category: {idea_category}
Estimated Savings: {estimated_saving}
Impact Areas: {impact_area}
Tools / Tech Involved: {tools_involved}

Classify this idea and return ONLY a valid JSON object with exactly these three fields:

{{
  "ai_category": "<one of: revenue_opportunity | automation | cost_optimization | efficiency_improvement | risk_reduction | innovation>",
  "ai_summary": "<2-3 sentence plain-English summary of the idea, its core value, and expected business impact>",
  "ai_confidence": <a decimal between 0.0 and 1.0 representing your confidence in the classification>
}}

Category definitions:
- revenue_opportunity: Ideas that directly create new revenue streams or unlock upsell/cross-sell potential
- automation: Ideas that replace manual processes with automated workflows or scripts
- cost_optimization: Ideas that reduce operational costs, waste, or resource spend
- efficiency_improvement: Ideas that make existing processes faster, leaner, or more effective without direct cost saving
- risk_reduction: Ideas that mitigate technical, operational, or business risk
- innovation: Ideas that introduce new technology, approaches, or capabilities not previously used

Rules:
- ai_category must be exactly one of the 6 values listed above
- ai_summary must be 2-3 sentences, clear and non-technical
- ai_confidence must be a number between 0.0 and 1.0
- Return ONLY the JSON object, no other text, no markdown fences"""


async def classify_idea(idea_id: str) -> None:
    """
    Background task: fetch idea from DB, classify with Claude,
    write ai_category / ai_summary / ai_confidence back to Supabase.
    Silently exits on any error so the submission is never affected.
    """
    settings = get_settings()

    if not settings.anthropic_api_key:
        print(f"[AI] ⚠  ANTHROPIC_API_KEY not set — skipping classification for idea {idea_id}")
        logger.warning("ANTHROPIC_API_KEY not set — skipping AI classification for idea %s", idea_id)
        return

    print(f"[AI] 🔍 Starting classification for idea {idea_id}")
    logger.info("Starting AI classification for idea %s", idea_id)

    try:
        supabase = get_supabase_admin()

        result = (
            supabase.table("value_ideas")
            .select("*")
            .eq("idea_id", idea_id)
            .single()
            .execute()
        )

        if not result.data:
            print(f"[AI] ❌ Idea {idea_id} not found in DB")
            logger.error("AI classifier: idea %s not found in DB", idea_id)
            return

        idea = result.data
        print(f"[AI] 📄 Fetched idea: \"{idea.get('title', '')}\"")

        prompt = CLASSIFICATION_PROMPT.format(
            title=idea.get("title", ""),
            problem_statement=idea.get("problem_statement", ""),
            proposed_solution=idea.get("proposed_solution", ""),
            idea_category=idea.get("idea_category", ""),
            estimated_saving=idea.get("estimated_saving") or "Not specified",
            impact_area=", ".join(idea.get("impact_area") or []) or "Not specified",
            tools_involved=", ".join(idea.get("tools_involved") or []) or "Not specified",
        )

        print(f"[AI] 🤖 Sending to Claude (claude-3-haiku-20240307)...")
        client = Anthropic(api_key=settings.anthropic_api_key)
        message = client.messages.create(
            model="claude-3-haiku-20240307",
            max_tokens=512,
            messages=[{"role": "user", "content": prompt}],
        )

        raw = message.content[0].text.strip()
        print(f"[AI] 📨 Claude raw response: {raw}")

        try:
            parsed = json.loads(raw)
        except json.JSONDecodeError:
            start = raw.find("{")
            end = raw.rfind("}") + 1
            if start != -1 and end > start:
                parsed = json.loads(raw[start:end])
            else:
                raise ValueError(f"Could not parse Claude response as JSON: {raw!r}")

        ai_category = parsed.get("ai_category", "").strip().lower()
        ai_summary = parsed.get("ai_summary", "").strip()
        ai_confidence = float(parsed.get("ai_confidence", 0.0))

        if ai_category not in VALID_CATEGORIES:
            print(f"[AI] ⚠  Invalid category '{ai_category}' — defaulting to '{idea.get('idea_category')}'")
            logger.warning(
                "Claude returned invalid category '%s' for idea %s — defaulting to user category '%s'",
                ai_category, idea_id, idea.get("idea_category"),
            )
            ai_category = idea.get("idea_category", "innovation")

        ai_confidence = max(0.0, min(1.0, ai_confidence))

        supabase.table("value_ideas").update(
            {
                "ai_category": ai_category,
                "ai_summary": ai_summary,
                "ai_confidence": ai_confidence,
            }
        ).eq("idea_id", idea_id).execute()

        print(
            f"[AI] ✅ Classification complete for idea {idea_id}\n"
            f"     Category  : {ai_category}\n"
            f"     Confidence: {ai_confidence:.0%}\n"
            f"     Summary   : {ai_summary[:120]}{'...' if len(ai_summary) > 120 else ''}"
        )
        logger.info(
            "AI classification complete for idea %s — category: %s, confidence: %.2f",
            idea_id, ai_category, ai_confidence,
        )

    except Exception as exc:
        print(f"[AI] ❌ Classification FAILED for idea {idea_id}: {exc}")
        logger.exception("AI classification failed for idea %s: %s", idea_id, exc)
