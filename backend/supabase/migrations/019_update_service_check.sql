-- Migration 019: Update leads.service check constraint to use full service names
-- Replaces short codes (QE, DE, AI, Data, Insurance) with full names.

-- Drop constraint first so updates are not blocked
alter table public.leads drop constraint if exists leads_service_check;

-- Migrate any existing short-code rows to full names
update public.leads set service = 'Quality Engineering'     where service = 'QE';
update public.leads set service = 'Digital Engineering'     where service = 'DE';
update public.leads set service = 'Artificial Intelligence' where service = 'AI';
update public.leads set service = 'Data Engineering'        where service = 'Data';
-- 'Insurance' stays the same

alter table public.leads
  add constraint leads_service_check
  check (service in (
    'Quality Engineering',
    'Digital Engineering',
    'Artificial Intelligence',
    'Data Engineering',
    'Insurance'
  ));
