create table public.accounts (
  account_id uuid primary key default gen_random_uuid(),
  account_name text not null,
  industry text,
  region text,
  account_owner_id uuid references public.profiles(id),
  sales_lead_id uuid references public.profiles(id),
  practice_leader_id uuid references public.profiles(id),
  contract_value decimal(15,2),
  engagement_start date,
  engagement_end date,
  account_status text not null default 'prospect'
    check (account_status in ('active', 'inactive', 'prospect')),
  created_at timestamptz not null default now()
);

-- Link profiles.account_assigned to accounts
alter table public.profiles
  add constraint profiles_account_assigned_fk
  foreign key (account_assigned) references public.accounts(account_id);

-- RLS
alter table public.accounts enable row level security;

create policy "Authenticated users can view accounts"
  on public.accounts for select
  to authenticated
  using (true);

create policy "Admins and executives can create accounts"
  on public.accounts for insert
  to authenticated
  with check (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role in ('admin', 'executive', 'sales')
    )
  );

create policy "Account stakeholders and admins can update"
  on public.accounts for update
  to authenticated
  using (
    account_owner_id = auth.uid()
    or sales_lead_id = auth.uid()
    or practice_leader_id = auth.uid()
    or exists (
      select 1 from public.profiles
      where id = auth.uid() and role in ('admin', 'executive')
    )
  );

create policy "Only admins can delete accounts"
  on public.accounts for delete
  to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'admin'
    )
  );
