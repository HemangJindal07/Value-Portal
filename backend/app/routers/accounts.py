from fastapi import APIRouter, Depends, HTTPException, status, Query
from uuid import UUID
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user, require_role
from app.schemas.account import AccountCreate, AccountUpdate, AccountResponse

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
    current_user: dict = Depends(
        require_role("admin", "executive", "sales")
    ),
):
    supabase = get_supabase_admin()
    data = payload.model_dump(mode="json")
    result = supabase.table("accounts").insert(data).execute()
    return result.data[0]


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
    return result.data[0]


@router.delete("/{account_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_account(
    account_id: UUID,
    current_user: dict = Depends(require_role("admin")),
):
    supabase = get_supabase_admin()
    supabase.table("accounts").delete().eq("account_id", str(account_id)).execute()
