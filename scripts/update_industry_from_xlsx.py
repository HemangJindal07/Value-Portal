"""
update_industry_from_xlsx.py

Reads Account Name + Vertical from the 'Project Details' sheet of the Excel file,
then updates accounts.industry in Supabase where account_name matches.
Skips rows with no vertical. Never touches any other column.
"""

import sys
import os

if sys.stdout.encoding and sys.stdout.encoding.lower() != "utf-8":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

import openpyxl
from supabase import create_client

SUPABASE_URL = "https://irsyepgmxsjwgpnzowvn.supabase.co"
SUPABASE_SERVICE_ROLE_KEY = (
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
    ".eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlyc3llcGdteHNqd2dwbnpvd3ZuIiwicm9sZSI6"
    "InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3NzM5MjIzNiwiZXhwIjoyMDkyOTY4MjM2fQ"
    ".S0XCPwUsXo4Zd9aOoD-8zlT0L2Myh4HQcbWJXrgupmw"
)

XLSX_PATH = os.path.join(
    os.path.dirname(__file__), "..", "Delivery Project-Emp List (3).xlsx"
)

def main():
    print("=" * 65)
    print("Industry updater  —  Excel Project Details -> Supabase accounts")
    print("=" * 65)

    # ── Load Excel mapping ────────────────────────────────────────────────
    wb = openpyxl.load_workbook(XLSX_PATH, read_only=True)
    ws = wb["Project Details"]
    rows = list(ws.iter_rows(values_only=True))

    # Row 0 is the header; skip it
    mapping: dict[str, str] = {}   # account_name_lower -> vertical
    for account_name, vertical, *_ in rows[1:]:
        account_name = (account_name or "").strip()
        vertical = (vertical or "").strip()
        if not account_name or not vertical:
            continue
        mapping[account_name.lower()] = (account_name, vertical)  # keep original casing too

    print(f"\nLoaded {len(mapping)} account->vertical mappings from Excel\n")

    # ── Fetch all accounts from Supabase ──────────────────────────────────
    supabase = create_client(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)
    res = supabase.table("accounts").select("account_id, account_name, industry").execute()
    db_accounts = res.data or []
    print(f"Fetched {len(db_accounts)} accounts from Supabase\n")

    updated      = []
    already_set  = []
    no_match     = []

    for xlsx_lower, (xlsx_name, vertical) in mapping.items():
        # Exact match first
        match = next(
            (a for a in db_accounts if a["account_name"].strip().lower() == xlsx_lower),
            None,
        )

        if match is None:
            no_match.append(xlsx_name)
            continue

        current = (match.get("industry") or "").strip()
        if current == vertical:
            already_set.append((match["account_name"], vertical))
            continue

        supabase.table("accounts") \
            .update({"industry": vertical}) \
            .eq("account_id", match["account_id"]) \
            .execute()
        updated.append((match["account_name"], current or "(none)", vertical))

    # ── Summary ───────────────────────────────────────────────────────────
    print("=" * 65)
    print(f"UPDATED ({len(updated)}):")
    if updated:
        for name, old, new in updated:
            print(f"  {name:<45}  {old:<25} -> {new}")
    else:
        print("  (none)")

    print(f"\nALREADY CORRECT ({len(already_set)}) — no change needed:")
    if already_set:
        for name, v in already_set:
            print(f"  {name:<45}  {v}")
    else:
        print("  (none)")

    print(f"\nNO DB MATCH ({len(no_match)}) — in Excel but not in accounts table:")
    if no_match:
        for n in sorted(no_match):
            print(f"  - {n}")
    else:
        print("  (none)")

    print("\n" + "=" * 65)
    print("Done.")

if __name__ == "__main__":
    main()
