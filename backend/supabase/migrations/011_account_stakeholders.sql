-- Dynamic stakeholder mapping table.
-- Replaces the hard-coded account_owner_id / sales_lead_id / practice_leader_id fields
-- for routing purposes. Each row represents one reviewer in the approval chain for an account.
-- Rows are ordered by step_order (ASC); the routing engine walks through them sequentially.

create table public.account_stakeholders (
  id uuid primary key default gen_random_uuid(),
  account_id uuid not null references public.accounts(account_id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  role_label text not null default 'Reviewer',
  step_order integer not null default 1,
  created_at timestamptz not null default now(),
  -- a user should only appear once per account
  unique (account_id, user_id)
);

create index account_stakeholders_account_idx on public.account_stakeholders(account_id, step_order);

-- RLS
alter table public.account_stakeholders enable row level security;

create policy "Authenticated users can view stakeholders"
  on public.account_stakeholders for select
  to authenticated
  using (true);

create policy "Only admins can manage stakeholders"
  on public.account_stakeholders for all
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

-- Relax the assignments.assigned_role constraint so it can store any role label string.
-- The old enum values (account_owner, sales_lead, practice_leader, review_committee)
-- remain valid; new dynamic labels like "Delivery Head" or "Sales Executive" are now
-- also allowed.
alter table public.assignments drop constraint if exists assignments_assigned_role_check;
