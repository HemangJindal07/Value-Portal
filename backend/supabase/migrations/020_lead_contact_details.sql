-- Migration 020: Add contact_details column to leads table
-- Stores key contact info (name, email, region, title) as a JSONB object.

alter table public.leads
  add column if not exists contact_details jsonb;
