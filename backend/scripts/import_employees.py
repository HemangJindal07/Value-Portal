"""
Bulk-import employees from the Delivery Project-Emp List CSV.

Each employee gets:
  - a Supabase Auth user with the initial password read from the
    IMPORT_SHARED_PASSWORD environment variable (must be set before running)
  - a profile row with role='user' and must_reset_password=true

Usage (from repo root):
    IMPORT_SHARED_PASSWORD=<password> python -m backend.scripts.import_employees
or:
    cd backend && IMPORT_SHARED_PASSWORD=<password> python -m scripts.import_employees

Idempotent: existing profiles (matched by email) are skipped — their auth
records and passwords are NOT touched.

Run AFTER applying migrations 025 (role rename) and 026 (must_reset_password).
"""

from __future__ import annotations

import csv
import logging
import os
import sys
from pathlib import Path

# Make `app.*` importable when run from repo root or from backend/
THIS_FILE = Path(__file__).resolve()
BACKEND_DIR = THIS_FILE.parent.parent
if str(BACKEND_DIR) not in sys.path:
    sys.path.insert(0, str(BACKEND_DIR))

from app.database.supabase import get_supabase_admin  # noqa: E402

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")
logger = logging.getLogger("import_employees")

CSV_PATH = (
    BACKEND_DIR.parent / "Delivery Project-Emp List(Delivery Emp List).csv"
)
SHARED_PASSWORD = os.environ.get("IMPORT_SHARED_PASSWORD")
if not SHARED_PASSWORD:
    logger.error("IMPORT_SHARED_PASSWORD environment variable is not set. Aborting.")
    sys.exit(1)


def _norm(value: str | None) -> str | None:
    if value is None:
        return None
    v = value.strip()
    return v or None


def _row_to_profile(row: dict) -> dict | None:
    """Map a CSV row to the profile fields we want to persist."""
    # CSV headers have leading/trailing spaces — normalise once.
    cleaned = {k.strip(): v for k, v in row.items()}

    email = _norm(cleaned.get("Employee Email ID"))
    name = _norm(cleaned.get("Name of Employee"))
    if not email or not name:
        return None

    return {
        "email":            email.lower(),
        "full_name":        name,
        "emp_code":         _norm(cleaned.get("Emp.Code")),
        "designation":      _norm(cleaned.get("Designation")),
        "level_id":         _norm(cleaned.get("Level Id")),
        "location":         _norm(cleaned.get("Location")),
        "delivery_manager": _norm(cleaned.get("Delivery Manager")),
        "project_name":     _norm(cleaned.get("Project Name")),
        "role":             "user",
        "is_active":        True,
        "must_reset_password": True,
    }


def _existing_profile_emails(supabase) -> set[str]:
    """Returns a lowercase set of every email already in profiles."""
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


def _create_auth_user(supabase, email: str, full_name: str) -> str | None:
    """
    Creates a confirmed Supabase Auth user. Returns the auth user id, or None
    if the email already exists in auth.users (which we treat as a skip).
    """
    try:
        res = supabase.auth.admin.create_user({
            "email": email,
            "password": SHARED_PASSWORD,
            "email_confirm": True,
            "user_metadata": {"full_name": full_name, "role": "user"},
        })
        user_obj = getattr(res, "user", None) or res
        uid = getattr(user_obj, "id", None)
        return str(uid) if uid else None
    except Exception as exc:
        msg = str(exc).lower()
        if "already" in msg or "registered" in msg or "duplicate" in msg:
            logger.info("auth user already exists for %s — skipping auth create", email)
            return None
        raise


def import_employees() -> None:
    if not CSV_PATH.exists():
        logger.error("CSV not found at %s", CSV_PATH)
        sys.exit(1)

    supabase = get_supabase_admin()

    logger.info("Loading existing profile emails…")
    existing = _existing_profile_emails(supabase)
    logger.info("Found %d existing profiles in DB.", len(existing))

    created = 0
    skipped_existing = 0
    failed = 0
    seen_emails: set[str] = set()

    # Excel-on-Windows saves CSVs as cp1252 (Windows-1252), not UTF-8. Reading
    # this file as UTF-8 silently truncates at the first non-ASCII byte (e.g.
    # the 0xA0 non-breaking space at row 337). Try utf-8 first, fall back to
    # cp1252 — both header strings still match because they're plain ASCII.
    try:
        fh = CSV_PATH.open("r", encoding="utf-8-sig", newline="")
        fh.read()  # touch the whole file to surface decode errors up-front
        fh.seek(0)
    except UnicodeDecodeError:
        logger.info("CSV is not UTF-8 — falling back to cp1252 (Windows-1252).")
        fh = CSV_PATH.open("r", encoding="cp1252", newline="")

    with fh:
        reader = csv.DictReader(fh)
        for idx, row in enumerate(reader, start=2):  # start=2 → CSV line numbers
            profile = _row_to_profile(row)
            if not profile:
                logger.warning("Row %d: missing email or name — skipping", idx)
                continue

            email = profile["email"]

            # De-dup within the CSV itself
            if email in seen_emails:
                logger.info("Row %d: duplicate email %s in CSV — skipping", idx, email)
                continue
            seen_emails.add(email)

            if email in existing:
                skipped_existing += 1
                continue

            try:
                auth_uid = _create_auth_user(supabase, email, profile["full_name"])
                if not auth_uid:
                    # Auth user existed but no profile — fetch the id by email.
                    list_res = supabase.auth.admin.list_users()
                    users = getattr(list_res, "users", None) or list_res or []
                    found = next(
                        (u for u in users if getattr(u, "email", "").lower() == email),
                        None,
                    )
                    if not found:
                        logger.error("Row %d: could not resolve auth user for %s", idx, email)
                        failed += 1
                        continue
                    auth_uid = str(found.id)

                profile["id"] = auth_uid
                supabase.table("profiles").upsert(profile, on_conflict="id").execute()
                existing.add(email)
                created += 1
                if created % 25 == 0:
                    logger.info(
                        "Progress: created=%d skipped=%d failed=%d",
                        created, skipped_existing, failed,
                    )
            except Exception as exc:
                failed += 1
                logger.exception("Row %d: failed to import %s — %s", idx, email, exc)

    logger.info(
        "Done. created=%d skipped_existing=%d failed=%d total_csv_unique=%d",
        created, skipped_existing, failed, len(seen_emails),
    )


if __name__ == "__main__":
    import_employees()
