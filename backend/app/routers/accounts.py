import logging
from fastapi import APIRouter, Depends, HTTPException, status, Query
from uuid import UUID
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user, require_role
from app.schemas.account import AccountCreate, AccountUpdate, AccountResponse
from app.services.notification_service import send_notification
from app.services.account_stakeholders_sync import refresh_du_dh_and_renumber
from postgrest.exceptions import APIError

logger = logging.getLogger("accounts")

router = APIRouter(prefix="/accounts", tags=["Accounts"])


@router.get("")
async def list_accounts(
    status_filter: str | None = Query(None, alias="status"),
    region: str | None = None,
    industry: str | None = None,
    search: str | None = None,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    query = supabase.table("accounts").select("*")

    if status_filter:
        query = query.eq("account_status", status_filter)
    if region:
        query = query.eq("region", region)
    if industry:
        query = query.eq("industry", industry)
    if search:
        query = query.ilike("account_name", f"%{search}%")

    query = query.order("created_at", desc=True)
    result = query.execute()
    return result.data


@router.get("/{account_id}")
async def get_account(
    account_id: UUID,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    result = (
        supabase.table("accounts")
        .select("*")
        .eq("account_id", str(account_id))
        .single()
        .execute()
    )

    if not result.data:
        raise HTTPException(status_code=404, detail="Account not found")

    return result.data


@router.post("", status_code=status.HTTP_201_CREATED)
async def create_account(
    payload: AccountCreate,
    # NOTE: role restriction commented out — any authenticated user can create an account
    # was: current_user: dict = Depends(require_role("admin", "executive", "sales"))
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    # Exclude None values — avoids sending null FK UUIDs that could confuse Supabase
    data = {k: v for k, v in payload.model_dump(mode="json").items() if v is not None}
    logger.info(
        "[ACCOUNT CREATE] user=%s role=%s | account_name=%r | fields=%s",
        current_user.get("id"), current_user.get("role"),
        data.get("account_name"), list(data.keys()),
    )
    try:
        result = supabase.table("accounts").insert(data).execute()
        logger.info("[ACCOUNT CREATE] Supabase response: data=%s", result.data)
    except Exception as exc:
        logger.exception("[ACCOUNT CREATE] Supabase insert raised exception: %s", exc)
        raise HTTPException(status_code=500, detail=f"Failed to create account: {exc}")

    if not result.data:
        logger.error("[ACCOUNT CREATE] Insert returned empty data — no row created for: %s", data.get("account_name"))
        raise HTTPException(status_code=500, detail="Account insert returned no data.")

    account = result.data[0]
    logger.info(
        "[ACCOUNT CREATE] ✅ SUCCESS — account_id=%s name=%r created by user=%s",
        account.get("account_id"), account.get("account_name"), current_user.get("id"),
    )
    account_id   = str(account["account_id"])
    account_name = account["account_name"]

    # ── Auto-populate account_stakeholders: DU (step 1) → DH (step 2) ───────
    du_id = str(payload.practice_leader_id) if payload.practice_leader_id else None
    dh_id = str(payload.account_owner_id)   if payload.account_owner_id   else None

    stakeholder_rows = []
    step = 1
    if du_id:
        stakeholder_rows.append({
            "account_id": account_id,
            "user_id":    du_id,
            "role_label": "Delivery Unit",
            "step_order": step,
        })
        step += 1
    if dh_id:
        stakeholder_rows.append({
            "account_id": account_id,
            "user_id":    dh_id,
            "role_label": "Delivery Head",
            "step_order": step,
        })

    if stakeholder_rows:
        try:
            supabase.table("account_stakeholders").upsert(
                stakeholder_rows, on_conflict="account_id,user_id"
            ).execute()
            logger.info("[ACCOUNT] Inserted %d stakeholder(s) for account %s", len(stakeholder_rows), account_id)
        except Exception as exc:
            logger.exception("[ACCOUNT CREATE] Failed to insert stakeholders for %s: %s", account_id, exc)

    # ── Notify DU and DH of their assignment ─────────────────────────────────
    if du_id:
        send_notification(
            recipient_id=du_id,
            submission_type="account",
            submission_id=account_id,
            notification_type="info",
            message=(
                f'You have been assigned as Delivery Unit (DU) for account "{account_name}". '
                f'Leads and ideas from this account will be routed to you first for review.'
            ),
        )
    if dh_id:
        send_notification(
            recipient_id=dh_id,
            submission_type="account",
            submission_id=account_id,
            notification_type="info",
            message=(
                f'You have been assigned as Delivery Head (DH) for account "{account_name}". '
                f'You will receive leads and ideas for review after DU approval.'
            ),
        )

    return account


@router.patch("/{account_id}")
async def update_account(
    account_id: UUID,
    payload: AccountUpdate,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()

    existing = (
        supabase.table("accounts")
        .select("*")
        .eq("account_id", str(account_id))
        .single()
        .execute()
    )
    if not existing.data:
        raise HTTPException(status_code=404, detail="Account not found")

    user_role = current_user["role"]
    user_id = current_user["id"]
    acct = existing.data
    is_stakeholder = user_id in [
        acct.get("account_owner_id"),
        acct.get("sales_lead_id"),
        acct.get("practice_leader_id"),
    ]

    if user_role not in ("admin", "executive") and not is_stakeholder:
        raise HTTPException(status_code=403, detail="Not authorized to update this account")

    update_data = payload.model_dump(exclude_unset=True, mode="json")
    if not update_data:
        return acct

    result = (
        supabase.table("accounts")
        .update(update_data)
        .eq("account_id", str(account_id))
        .execute()
    )
    updated = result.data[0]

    if any(
        k in update_data
        for k in ("practice_leader_id", "account_owner_id")
    ):
        try:
            refresh_du_dh_and_renumber(supabase, str(account_id))
        except APIError as exc:
            payload = getattr(exc, "args", [None])[0]
            if isinstance(payload, dict) and payload.get("code") == "PGRST205":
                logger.warning(
                    "[ACCOUNT] Stakeholder sync skipped — apply migration 011_account_stakeholders.sql"
                )
            else:
                logger.exception("[ACCOUNT] Stakeholder refresh failed: %s", exc)
        except Exception as exc:
            logger.exception("[ACCOUNT] Stakeholder refresh failed: %s", exc)

    return updated


@router.delete("/{account_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_account(
    account_id: UUID,
    current_user: dict = Depends(require_role("admin")),
):
    supabase = get_supabase_admin()
    # Use limit(1) instead of .single() to avoid a 500 when the row doesn't exist
    existing = (
        supabase.table("accounts")
        .select("account_id")
        .eq("account_id", str(account_id))
        .limit(1)
        .execute()
    )
    if not existing.data:
        raise HTTPException(status_code=404, detail="Account not found")
    supabase.table("accounts").delete().eq("account_id", str(account_id)).execute()
