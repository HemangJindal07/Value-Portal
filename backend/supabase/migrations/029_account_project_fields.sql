-- 029: Add project-import fields to accounts.
-- Used by scripts/import_accounts.py to populate from the Project Details CSV.

ALTER TABLE public.accounts
  ADD COLUMN IF NOT EXISTS no_of_projects        integer,
  ADD COLUMN IF NOT EXISTS no_of_billed_people   integer,
  ADD COLUMN IF NOT EXISTS delivery_manager_name text;
