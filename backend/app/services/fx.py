"""Currency conversion helpers backed by the admin-managed `exchange_rates` table.

Lead `estimated_value` is stored in its native currency. Dashboard totals must be
normalized to USD, so we multiply each amount by its currency's `rate_to_usd`.
Unknown currencies fall back to the `OTH` rate, then to 1.0.
"""


def load_rates(supabase) -> dict[str, float]:
    """Load the full {currency: rate_to_usd} map. One small query per call."""
    rows = supabase.table("exchange_rates").select("currency, rate_to_usd").execute().data or []
    return {r["currency"]: float(r["rate_to_usd"]) for r in rows}


def to_usd(amount, currency: str | None, rates: dict[str, float]) -> float:
    """Convert `amount` in `currency` to USD using the given rate map."""
    if amount is None:
        return 0.0
    rate = rates.get(currency or "USD")
    if rate is None:
        rate = rates.get("OTH", 1.0)
    return float(amount) * rate
