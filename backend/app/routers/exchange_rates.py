from datetime import datetime, timezone
from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel, Field

from app.database.supabase import get_supabase_admin
from app.dependencies import require_role

router = APIRouter(prefix="/exchange-rates", tags=["Exchange Rates"])


class RateUpdate(BaseModel):
    rate_to_usd: float = Field(..., ge=0, description="Value of 1 unit of this currency in USD")


@router.get("")
async def list_rates(current_user: dict = Depends(require_role("admin", "executive"))):
    """List all currency exchange rates. Admin + executive (executive reads only)."""
    supabase = get_supabase_admin()
    rows = (
        supabase.table("exchange_rates")
        .select("currency, rate_to_usd, updated_at")
        .order("currency")
        .execute()
        .data
        or []
    )
    return rows


@router.put("/{currency}")
async def update_rate(
    currency: str,
    payload: RateUpdate,
    current_user: dict = Depends(require_role("admin")),
):
    """Update a single currency's USD rate. Admin only."""
    supabase = get_supabase_admin()
    code = currency.upper().strip()

    existing = supabase.table("exchange_rates").select("currency").eq("currency", code).execute().data
    if not existing:
        raise HTTPException(status.HTTP_404_NOT_FOUND, f"Unknown currency '{code}'.")

    res = (
        supabase.table("exchange_rates")
        .update(
            {
                "rate_to_usd": payload.rate_to_usd,
                "updated_at": datetime.now(timezone.utc).isoformat(),
                "updated_by": current_user["id"],
            }
        )
        .eq("currency", code)
        .execute()
    )
    return (res.data or [{}])[0]
