-- Migration 021: Expand lead status workflow
-- Adds 'opportunity_created' status and aligns score_events event_type.
--
-- Full status lifecycle:
--   submitted → under_review → qualified → opportunity_created → won
--                           ↘ rejected              ↘ lost

-- 1. Drop and recreate leads.status check to include opportunity_created
alter table public.leads drop constraint if exists leads_status_check;

alter table public.leads
  add constraint leads_status_check
  check (status in (
    'draft', 'submitted', 'routing_pending', 'under_review',
    'qualified', 'opportunity_created', 'approved',
    'won', 'lost', 'dropped', 'rejected'
  ));

-- 2. Expand score_events.event_type to include opportunity_created
alter table public.score_events drop constraint if exists score_events_event_type_check;

alter table public.score_events
  add constraint score_events_event_type_check
  check (event_type in (
    'submitted', 'qualified', 'approved', 'opportunity_created',
    'implemented', 'deal_won', 'deal_lost'
  ));
