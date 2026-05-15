"""
update_industry_from_csv.py

Reads the delivery employee CSV, extracts unique Project Name → Vertical mappings,
then updates the `industry` column on matching accounts in Supabase.

Rules:
- Skip rows where Project Name is "Bench" or Vertical is empty / "?" character
- Match accounts by account_name (case-insensitive, trimmed)
- Only UPDATE industry — never inserts, never touches any other column
- Prints a summary of what was updated, what was skipped, and what had no DB match
"""

import csv
import os
import sys

# Force UTF-8 output on Windows
if sys.stdout.encoding != "utf-8":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from supabase import create_client

# ── Config ────────────────────────────────────────────────────────────────────
SUPABASE_URL = "https://irsyepgmxsjwgpnzowvn.supabase.co"
SUPABASE_SERVICE_ROLE_KEY = (
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
    ".eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlyc3llcGdteHNqd2dwbnpvd3ZuIiwicm9sZSI6"
    "InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3NzM5MjIzNiwiZXhwIjoyMDkyOTY4MjM2fQ"
    ".S0XCPwUsXo4Zd9aOoD-8zlT0L2Myh4HQcbWJXrgupmw"
)

CSV_PATH = os.path.join(
    os.path.dirname(__file__),
    "..",
    "Delivery Project-Emp List(Delivery Emp List) (1).csv",
)

# ── Step 1: Build project → vertical map from CSV ─────────────────────────────
def load_project_vertical_map(csv_path: str) -> dict[str, str]:
    """
    Returns {project_name_lower: vertical} for all non-Bench rows with a valid vertical.
    When the same project appears with multiple verticals (shouldn't happen but just in case),
    the first non-empty one wins.
    """
    mapping: dict[str, str] = {}
    skipped = []

    with open(csv_path, encoding="cp1252", newline="") as f:
        reader = csv.DictReader(f)
        for row in reader:
            project = (row.get("Project Name") or "").strip()
            vertical = (row.get("Vertical") or "").strip()

            # Skip bench rows
            if project.lower() == "bench" or not project:
                continue

            # Skip rows where vertical is empty or the garbled "?" character
            if not vertical or vertical in ("?", "—", "-") or "�" in vertical:
                skipped.append(project)
                continue

            key = project.lower()
            if key not in mapping:
                mapping[key] = vertical

    if skipped:
        unique_skipped = sorted(set(skipped))
        print(f"\n⚠  Skipped {len(unique_skipped)} project(s) with no valid vertical:")
        for p in unique_skipped:
            print(f"   • {p}")

    return mapping


# ── Step 2: Fetch all accounts from Supabase ─────────────────────────────────
def fetch_accounts(supabase) -> list[dict]:
    res = supabase.table("accounts").select("account_id, account_name, industry").execute()
    return res.data or []


# ── Step 3: Match and update ──────────────────────────────────────────────────
def update_industries(supabase, accounts: list[dict], mapping: dict[str, str]):
    updated = []
    no_match = []
    already_set = []

    # Build lookup: lowercase account_name → account row
    account_lookup: dict[str, dict] = {
        a["account_name"].strip().lower(): a for a in accounts
    }

    for project_lower, vertical in mapping.items():
        account = account_lookup.get(project_lower)

        if account is None:
            # Try partial match — project name might be a prefix of account_name or vice versa
            # e.g. "DraftKings-Functional" in CSV vs "DraftKings" in DB
            matches = [
                a for name, a in account_lookup.items()
                if project_lower in name or name in project_lower
            ]
            if len(matches) == 1:
                account = matches[0]
            elif len(matches) > 1:
                print(f"⚠  '{project_lower}' matched {len(matches)} accounts — skipping (ambiguous):")
                for m in matches:
                    print(f"     • {m['account_name']}")
                continue
            else:
                no_match.append(project_lower)
                continue

        account_id = account["account_id"]
        account_name = account["account_name"]
        current_industry = account.get("industry") or ""

        if current_industry == vertical:
            already_set.append((account_name, vertical))
            continue

        # Perform the update
        supabase.table("accounts").update({"industry": vertical}).eq("account_id", account_id).execute()
        updated.append((account_name, current_industry or "(none)", vertical))

    return updated, no_match, already_set


# ── Main ──────────────────────────────────────────────────────────────────────
def main():
    print("=" * 60)
    print("Industry updater — CSV → Supabase accounts.industry")
    print("=" * 60)

    print(f"\n📂 Reading CSV: {os.path.abspath(CSV_PATH)}")
    mapping = load_project_vertical_map(CSV_PATH)
    print(f"✅ Found {len(mapping)} unique project→vertical mappings\n")

    print("🔗 Connecting to Supabase…")
    supabase = create_client(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)

    accounts = fetch_accounts(supabase)
    print(f"📋 Fetched {len(accounts)} accounts from DB\n")

    updated, no_match, already_set = update_industries(supabase, accounts, mapping)

    print("\n" + "=" * 60)
    print(f"✅ UPDATED ({len(updated)}):")
    if updated:
        for name, old, new in updated:
            print(f"   {name!r:40s}  {old!r:25s} → {new!r}")
    else:
        print("   (none)")

    print(f"\n⏭  ALREADY CORRECT ({len(already_set)}) — no change needed:")
    if already_set:
        for name, vertical in already_set:
            print(f"   {name!r:40s}  {vertical!r}")
    else:
        print("   (none)")

    print(f"\n❌ NO DB MATCH ({len(no_match)}) — project exists in CSV but not in accounts table:")
    if no_match:
        for p in sorted(no_match):
            print(f"   • {p}")
    else:
        print("   (none)")

    print("\n" + "=" * 60)
    print("Done.")


if __name__ == "__main__":
    main()
