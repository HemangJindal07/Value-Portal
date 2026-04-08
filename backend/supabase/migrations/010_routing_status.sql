-- Add routing_pending and approved status to leads and value_ideas
-- These are required for the sequential DH → DU → Sales routing engine.

-- Leads: add routing_pending and approved
alter table public.leads
  drop constraint if exists leads_status_check;

alter table public.leads
  add constraint leads_status_check
  check (status in ('draft', 'submitted', 'under_review', 'qualified', 'won', 'lost', 'dropped', 'routing_pending', 'approved', 'rejected'));

-- Value Ideas: add routing_pending
alter table public.value_ideas
  drop constraint if exists value_ideas_status_check;

alter table public.value_ideas
  add constraint value_ideas_status_check
  check (status in ('draft', 'submitted', 'under_review', 'approved', 'in_progress', 'implemented', 'rejected', 'routing_pending'));
