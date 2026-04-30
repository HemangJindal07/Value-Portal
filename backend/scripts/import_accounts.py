"""
Bulk-import accounts from the Project Details CSV.

Each account gets:
  - account_name             ← Project Details "Account Name"
  - no_of_projects           ← Project Details "No. of Projects"
  - no_of_billed_people      ← Project Details "No. of Billed people"
  - delivery_manager_name    ← Project Details "Delivery Manager"
  - region                   ← Project Details "Geo Location"
  - industry                 ← Emp List "Original Du" (most common per project)
  - account_status           = "active"

Rows where No. of Billed people <= 0 (or not parseable as a positive integer)
are SKIPPED and counted in the log summary.

Industry resolution: we pull the Vertical (`Original Du`) for every employee
whose `Project Name` matches the account name, then pick the most common one
(alphabetical tie-break) per Option A.

Idempotent: existing accounts (matched by exact account_name) are skipped —
their data is NOT touched.

Run AFTER applying migration 029_account_project_fields.sql.

Usage (from repo root):
    cd backend && python -m scripts.import_accounts
"""

from __future__ import annotations

import csv
import logging
import sys
from collections import Counter
from pathlib import Path

THIS_FILE = Path(__file__).resolve()
BACKEND_DIR = THIS_FILE.parent.parent
if str(BACKEND_DIR) not in sys.path:
    sys.path.insert(0, str(BACKEND_DIR))

from app.database.supabase import get_supabase_admin  # noqa: E402

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")
logger = logging.getLogger("import_accounts")

PROJECT_CSV = BACKEND_DIR.parent / "Delivery Project-Emp List(Project Details).csv"
EMP_CSV     = BACKEND_DIR.parent / "Delivery Project-Emp List(Delivery Emp List).csv"


def _open_csv(path: Path):
    """Open Excel-on-Windows CSVs (cp1252) with UTF-8 fallback."""
    try:
        fh = path.open("r", encoding="utf-8-sig", newline="")
        fh.read()
        fh.seek(0)
        return fh
    except UnicodeDecodeError:
        return path.open("r", encoding="cp1252", newline="")


def _norm(value: str | None) -> str | None:
    if value is None:
        return None
    v = value.strip()
    return v or None


def _parse_int(value: str | None) -> int | None:
    if not value:
        return None
    try:
        return int(value.strip())
    except (ValueError, AttributeError):
        return None


def _build_project_to_industry(emp_csv_path: Path) -> dict[str, str]:
    """
    Read the Emp List CSV and return {project_name: most_common_vertical}.
    Per Option A: pick the most common Original Du per project; alphabetical
    tie-break.
    """
    project_verticals: dict[str, list[str]] = {}
    with _open_csv(emp_csv_path) as fh:
        reader = csv.DictReader(fh)
        for row in reader:
            cleaned = {k.strip(): v for k, v in row.items()}
            project = _norm(cleaned.get("Project Name"))
            vertical = _norm(cleaned.get("Original Du"))
            if project and vertical:
                project_verticals.setdefault(project, []).append(vertical)

    most_common: dict[str, str] = {}
    for project, verts in project_verticals.items():
        counter = Counter(verts)
        # most_common returns items by count desc; for ties we sort alphabetically
        max_count = max(counter.values())
        candidates = sorted(v for v, c in counter.items() if c == max_count)
        most_common[project] = candidates[0]

    return most_common


def _existing_account_names(supabase) -> set[str]:
    """Set of lowercased account_names already in the DB (idempotency check)."""
    names: set[str] = set()
    page = 0
    page_size = 1000
    while True:
        res = (
            supabase.table("accounts")
            .select("account_name")
            .range(page * page_size, (page + 1) * page_size - 1)
            .execute()
        )
        rows = res.data or []
        if not rows:
            break
        for r in rows:
            n = r.get("account_name")
            if n:
                names.add(n.strip().lower())
        if len(rows) < page_size:
            break
        page += 1
    return names


def import_accounts() -> None:
    if not PROJECT_CSV.exists():
        logger.error("Project Details CSV not found at %s", PROJECT_CSV)
        sys.exit(1)
    if not EMP_CSV.exists():
        logger.error("Delivery Emp List CSV not found at %s", EMP_CSV)
        sys.exit(1)

    supabase = get_supabase_admin()

    logger.info("Building project -> industry map from Emp List…")
    project_to_industry = _build_project_to_industry(EMP_CSV)
    logger.info("Resolved %d unique projects with verticals.", len(project_to_industry))

    logger.info("Loading existing account names from DB…")
    existing_names = _existing_account_names(supabase)
    logger.info("DB already has %d accounts.", len(existing_names))

    inserted = 0
    skipped_existing = 0
    skipped_zero_billed = 0
    skipped_invalid_billed = 0
    skipped_missing_name = 0
    failed = 0
    industry_unmatched = 0
    seen_names_in_csv: set[str] = set()

    with _open_csv(PROJECT_CSV) as fh:
        reader = csv.DictReader(fh)
        for idx, row in enumerate(reader, start=2):
            cleaned = {k.strip(): v for k, v in row.items()}
            name = _norm(cleaned.get("Account Name"))
            if not name:
                skipped_missing_name += 1
                continue

            name_key = name.lower()
            if name_key in seen_names_in_csv:
                # CSV duplicate — skip silently (first occurrence wins)
                continue
            seen_names_in_csv.add(name_key)

            billed_raw = cleaned.get("No. of Billed people", "")
            billed = _parse_int(billed_raw)

            if billed is None:
                skipped_invalid_billed += 1
                logger.warning(
                    "Row %d: %r — invalid 'No. of Billed people' value %r — skipping.",
                    idx, name, billed_raw,
                )
                continue
            if billed <= 0:
                skipped_zero_billed += 1
                logger.info(
                    "Row %d: %r — billed=%d (not > 0) — skipping.",
                    idx, name, billed,
                )
                continue

            if name_key in existing_names:
                skipped_existing += 1
                continue

            projects = _parse_int(cleaned.get("No. of Projects", ""))
            geo = _norm(cleaned.get("Geo Location"))
            dm = _norm(cleaned.get("Delivery Manager"))

            industry = project_to_industry.get(name)
            if not industry:
                industry_unmatched += 1
                logger.info(
                    "Row %d: %r — no vertical found in Emp List (industry left null).",
                    idx, name,
                )

            payload = {
                "account_name":            name,
                "no_of_projects":          projects,
                "no_of_billed_people":     billed,
                "delivery_manager_name":   dm,
                "region":                  geo,
                "industry":                industry,
                "account_status":          "active",
            }
            payload = {k: v for k, v in payload.items() if v is not None}

            try:
                res = supabase.table("accounts").insert(payload).execute()
                if not res.data:
                    failed += 1
                    logger.error("Row %d: %r — insert returned no data.", idx, name)
                    continue
                inserted += 1
                existing_names.add(name_key)
                if inserted % 25 == 0:
                    logger.info(
                        "Progress: inserted=%d skipped_zero=%d skipped_existing=%d failed=%d",
                        inserted, skipped_zero_billed, skipped_existing, failed,
                    )
            except Exception as exc:
                failed += 1
                logger.exception("Row %d: %r — insert failed: %s", idx, name, exc)

    total_skipped_no_billed = skipped_zero_billed + skipped_invalid_billed

    logger.info("=" * 60)
    logger.info("DONE")
    logger.info("=" * 60)
    logger.info("inserted:                   %d", inserted)
    logger.info("skipped (already existed):  %d", skipped_existing)
    logger.info("skipped (billed = 0):       %d", skipped_zero_billed)
    logger.info("skipped (billed invalid):   %d", skipped_invalid_billed)
    logger.info("→ total accounts NOT added because billed not > 0: %d",
                total_skipped_no_billed)
    logger.info("skipped (missing name):     %d", skipped_missing_name)
    logger.info("failed (insert error):      %d", failed)
    logger.info("industry unresolved (null): %d", industry_unmatched)


if __name__ == "__main__":
    import_accounts()
