-- Migration 015: Service routing table
-- Maps TX service verticals to DU (first reviewer) for automatic routing.
-- Used as fallback when an account has no per-account stakeholders and no
-- vertical routing entry. The routing engine checks the lead's service field
-- and looks up the DU here.
--
-- Service → SME mapping (from org chart):
--   QE        → Manjeet  (SME – QE)
--   DE        → Vivek    (SME – DE)
--   AI        → Vivek    (SME – AI)
--   Data      → Manjeet  (SME – Data)
--   Insurance → Manjeet  (SME – Insurance)
-- Admins seed this table via the Routing Config admin panel.

create table if not exists public.service_routing (
  id           uuid primary key default gen_random_uuid(),
  service_name text not null unique,   -- e.g. "QE", "DE", "AI", "Data", "Insurance"
  du_user_id   uuid references public.profiles(id) on delete set null,
  created_by   uuid references public.profiles(id) on delete set null,
  created_at   timestamptz not null default now()
);

alter table public.service_routing enable row level security;

drop policy if exists "Authenticated users can view service routing" on public.service_routing;
drop policy if exists "Only admins can manage service routing" on public.service_routing;

create policy "Authenticated users can view service routing"
  on public.service_routing for select
  to authenticated
  using (true);

create policy "Only admins can manage service routing"
  on public.service_routing for all
  to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'admin'
    )
  )
  with check (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'admin'
    )
  );
