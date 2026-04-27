-- Migration 016: Add service column to leads table
-- Captures which TX service vertical a lead belongs to.
-- Used by the routing engine when no per-account or vertical routing is found.

alter table public.leads
  add column if not exists service text
    check (service in ('QE', 'DE', 'AI', 'Data', 'Insurance'));
