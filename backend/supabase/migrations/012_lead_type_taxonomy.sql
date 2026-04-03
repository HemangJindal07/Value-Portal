-- Migration 012: Update lead_type taxonomy to BRD-aligned values
-- BRD §8.4 requires "Current Lead" and "New Lead" as the lead type taxonomy.
-- Previous values (cross_sell, upsell, new_service, expansion) are replaced.

-- Step 1: Drop the existing CHECK constraint
alter table public.leads
  drop constraint if exists leads_lead_type_check;

-- Step 2: Migrate existing data to the new taxonomy
--   cross_sell  → current_lead  (existing account relationship)
--   upsell      → current_lead  (existing account relationship)
--   new_service → new_lead      (new opportunity / service)
--   expansion   → current_lead  (expansion of existing relationship)
update public.leads
set lead_type = case
  when lead_type = 'new_service' then 'new_lead'
  else 'current_lead'
end
where lead_type in ('cross_sell', 'upsell', 'new_service', 'expansion');

-- Step 3: Add the new CHECK constraint
alter table public.leads
  add constraint leads_lead_type_check
  check (lead_type in ('current_lead', 'new_lead'));
