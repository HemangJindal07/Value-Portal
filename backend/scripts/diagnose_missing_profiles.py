"""
Diagnose which CSV emails are missing in public.profiles and which are missing
in auth.users. Run after the import to see what happened.

Usage:
    cd backend && python -m scripts.diagnose_missing_profiles
"""

from __future__ import annotations

import csv
import sys
from pathlib import Path

THIS_FILE = Path(__file__).resolve()
BACKEND_DIR = THIS_FILE.parent.parent
if str(BACKEND_DIR) not in sys.path:
    sys.path.insert(0, str(BACKEND_DIR))

from app.database.supabase import get_supabase_admin  # noqa: E402

CSV_PATH = BACKEND_DIR.parent / "Delivery Project-Emp List(Delivery Emp List).csv"


def load_csv_emails() -> set[str]:
    emails: set[str] = set()
    with CSV_PATH.open("r", encoding="cp1252", newline="") as fh:
        reader = csv.DictReader(fh)
        for row in reader:
            cleaned = {k.strip(): v for k, v in row.items()}
            email = (cleaned.get("Employee Email ID") or "").strip().lower()
            name = (cleaned.get("Name of Employee") or "").strip()
            if email and name:
                emails.add(email)
    return emails


def load_profile_emails(supabase) -> set[str]:
    emails: set[str] = set()
    page = 0
    page_size = 1000
    while True:
        res = (
            supabase.table("profiles")
            .select("email")
            .range(page * page_size, (page + 1) * page_size - 1)
            .execute()
        )
        rows = res.data or []
        if not rows:
            break
        for r in rows:
            if r.get("email"):
                emails.add(r["email"].lower())
        if len(rows) < page_size:
            break
        page += 1
    return emails


def load_auth_emails(supabase) -> set[str]:
    """Lists all auth.users emails (paginates internally)."""
    emails: set[str] = set()
    page = 1
    while True:
        try:
            res = supabase.auth.admin.list_users(page=page, per_page=1000)
        except TypeError:
            # older signature
            res = supabase.auth.admin.list_users()
        users = getattr(res, "users", None)
        if users is None:
            users = res or []
        if not users:
            break
        for u in users:
            email = getattr(u, "email", None)
            if email:
                emails.add(email.lower())
        if len(users) < 1000:
            break
        page += 1
    return emails


def main() -> None:
    supabase = get_supabase_admin()

    csv_emails = load_csv_emails()
    profile_emails = load_profile_emails(supabase)

    print(f"CSV unique emails:       {len(csv_emails)}")
    print(f"profiles table emails:   {len(profile_emails)}")
    print()

    missing_in_profiles = csv_emails - profile_emails

    print(f"CSV emails MISSING from profiles: {len(missing_in_profiles)}")
    print()

    if missing_in_profiles:
        print("=== First 50 CSV emails missing from profiles ===")
        for e in sorted(missing_in_profiles)[:50]:
            print(f"  {e}")
        print()

        out_path = BACKEND_DIR / "missing_emails.txt"
        out_path.write_text("\n".join(sorted(missing_in_profiles)), encoding="utf-8")
        print(f"Full list written to: {out_path}")


if __name__ == "__main__":
    main()
