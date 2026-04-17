"""
Keep account_stakeholders aligned with accounts.practice_leader_id (DU) and
accounts.account_owner_id (DH).

- On stakeholder list: if there are no rows yet but the account has DU/DH,
  insert them (same behaviour as create_account).
- On account update: replace Delivery Unit / Delivery Head rows to match the
  account record and renumber remaining reviewers so step_order stays sequential.
"""

from __future__ import annotations

import logging

from postgrest.exceptions import APIError

logger = logging.getLogger("account_stakeholders_sync")


def _is_missing_table(exc: Exception) -> bool:
    # Be defensive: some environments wrap/shape postgrest errors differently.
    args = getattr(exc, "args", None)
    if isinstance(args, tuple) and args and isinstance(args[0], dict):
        return args[0].get("code") == "PGRST205"
    return "PGRST205" in str(exc)


def ensure_du_dh_if_no_stakeholders(supabase, account_id: str) -> None:
    """
    If account_stakeholders has zero rows but the account defines DU and/or DH,
    upsert those two rows (step 1 → DU, step 2 → DH).
    """
    try:
        acct_res = (
            supabase.table("accounts")
            .select("practice_leader_id, account_owner_id")
            .eq("account_id", account_id)
            .execute()
        )
    except Exception as exc:
        if _is_missing_table(exc):
            raise
        logger.warning("[STAKEHOLDER_SYNC] Account %s not found or fetch failed: %s", account_id, exc)
        return

    if not acct_res.data:
        return
    acct = acct_res.data[0]
    du_id = acct.get("practice_leader_id")
    dh_id = acct.get("account_owner_id")

    if not du_id and not dh_id:
        return

    try:
        existing = (
            supabase.table("account_stakeholders")
            .select("id")
            .eq("account_id", account_id)
            .limit(1)
            .execute()
        )
    except Exception as exc:
        if _is_missing_table(exc):
            raise
        logger.exception("[STAKEHOLDER_SYNC] Failed to read stakeholders for %s", account_id)
        return

    if existing.data:
        return

    rows: list[dict] = []
    step = 1
    if du_id:
        rows.append(
            {
                "account_id": account_id,
                "user_id": str(du_id),
                "role_label": "Delivery Unit",
                "step_order": step,
            }
        )
        step += 1
    if dh_id:
        rows.append(
            {
                "account_id": account_id,
                "user_id": str(dh_id),
                "role_label": "Delivery Head",
                "step_order": step,
            }
        )

    if not rows:
        return

    try:
        supabase.table("account_stakeholders").upsert(
            rows, on_conflict="account_id,user_id"
        ).execute()
        logger.info("[STAKEHOLDER_SYNC] Seeded %d DU/DH row(s) for account %s", len(rows), account_id)
    except Exception as exc:
        if _is_missing_table(exc):
            raise
        logger.exception("[STAKEHOLDER_SYNC] Failed to seed DU/DH for account %s: %s", account_id, exc)


def refresh_du_dh_and_renumber(supabase, account_id: str) -> None:
    """
    After account DU/DH fields change: remove existing Delivery Unit / Delivery Head
    rows, insert current DU/DH at steps 1–2, then renumber all other reviewers
    starting at the next step.
    """
    try:
        acct_res = (
            supabase.table("accounts")
            .select("practice_leader_id, account_owner_id")
            .eq("account_id", account_id)
            .execute()
        )
    except Exception as exc:
        if _is_missing_table(exc):
            raise
        logger.warning("[STAKEHOLDER_SYNC] refresh: account %s: %s", account_id, exc)
        return

    if not acct_res.data:
        return
    acct = acct_res.data[0]
    du_id = acct.get("practice_leader_id")
    dh_id = acct.get("account_owner_id")

    try:
        res = (
            supabase.table("account_stakeholders")
            .select("id, user_id, role_label, step_order")
            .eq("account_id", account_id)
            .order("step_order")
            .execute()
        )
        rows = res.data or []
    except Exception as exc:
        if _is_missing_table(exc):
            raise
        logger.exception("[STAKEHOLDER_SYNC] refresh: list failed for %s", account_id)
        return

    system_labels = ("Delivery Unit", "Delivery Head")
    du_dh_rows = [r for r in rows if r.get("role_label") in system_labels]
    custom_rows = [r for r in rows if r.get("role_label") not in system_labels]

    for r in du_dh_rows:
        try:
            supabase.table("account_stakeholders").delete().eq("id", r["id"]).execute()
        except Exception as exc:
            if _is_missing_table(exc):
                raise
            logger.exception("[STAKEHOLDER_SYNC] refresh: delete %s failed", r.get("id"))

    new_rows: list[dict] = []
    step = 1
    if du_id:
        new_rows.append(
            {
                "account_id": account_id,
                "user_id": str(du_id),
                "role_label": "Delivery Unit",
                "step_order": step,
            }
        )
        step += 1
    if dh_id:
        new_rows.append(
            {
                "account_id": account_id,
                "user_id": str(dh_id),
                "role_label": "Delivery Head",
                "step_order": step,
            }
        )
        step += 1

    if new_rows:
        try:
            supabase.table("account_stakeholders").upsert(
                new_rows, on_conflict="account_id,user_id"
            ).execute()
        except Exception as exc:
            if _is_missing_table(exc):
                raise
            logger.exception("[STAKEHOLDER_SYNC] refresh: upsert DU/DH failed for %s", account_id)
            return

    for r in sorted(custom_rows, key=lambda x: x.get("step_order") or 0):
        try:
            supabase.table("account_stakeholders").update({"step_order": step}).eq("id", r["id"]).execute()
            step += 1
        except Exception as exc:
            if _is_missing_table(exc):
                raise
            logger.exception("[STAKEHOLDER_SYNC] refresh: renumber %s failed", r.get("id"))
