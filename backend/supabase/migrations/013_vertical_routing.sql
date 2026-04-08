-- Migration 013: Vertical routing and region-sales mapping tables
-- BRD §8.6 — org-level routing based on vertical (DU → DH) and region (Sales).
-- The routing engine falls back to these tables when no per-account
-- stakeholders exist in account_stakeholders.

-- ── 1. vertical_routing ─────────────────────────────────────────────────────
-- Maps an account vertical (= accounts.industry value) to a DU and DH user.

create table public.vertical_routing (
  id              uuid primary key default gen_random_uuid(),
  vertical_name   text not null unique,           -- must match accounts.industry
  du_user_id      uuid references public.profiles(id) on delete set null,
  dh_user_id      uuid references public.profiles(id) on delete set null,
  created_by      uuid references public.profiles(id) on delete set null,
  created_at      timestamptz not null default now()
);

alter table public.vertical_routing enable row level security;

create policy "Authenticated users can view vertical routing"
  on public.vertical_routing for select
  to authenticated
  using (true);

create policy "Only admins can manage vertical routing"
  on public.vertical_routing for all
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

-- ── 2. region_sales_mapping ─────────────────────────────────────────────────
-- Maps a region (= accounts.region value) to a sales stakeholder.
-- copy_all = true means the user is copied on EVERY workflow regardless of region.

create table public.region_sales_mapping (
  id              uuid primary key default gen_random_uuid(),
  region_name     text not null,                  -- must match accounts.region; ignored when copy_all = true
  sales_user_id   uuid not null references public.profiles(id) on delete cascade,
  copy_all        boolean not null default false,
  created_at      timestamptz not null default now(),
  unique (region_name, sales_user_id)
);

alter table public.region_sales_mapping enable row level security;

create policy "Authenticated users can view region sales mapping"
  on public.region_sales_mapping for select
  to authenticated
  using (true);

create policy "Only admins can manage region sales mapping"
  on public.region_sales_mapping for all
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
