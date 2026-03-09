create table public.leads (
  lead_id uuid primary key default gen_random_uuid(),
  title text not null,
  description text not null,
  lead_type text not null
    check (lead_type in ('cross_sell', 'upsell', 'new_service', 'expansion')),
  account_id uuid not null references public.accounts(account_id),
  submitted_by uuid not null references public.profiles(id),
  estimated_value decimal(15,2),
  currency text not null default 'USD',
  probability integer check (probability between 0 and 100),
  expected_close_date date,
  status text not null default 'draft'
    check (status in ('draft', 'submitted', 'under_review', 'qualified', 'won', 'lost', 'dropped')),
  priority text not null default 'medium'
    check (priority in ('high', 'medium', 'low')),
  supporting_docs text[] default '{}',
  ai_category text,
  ai_confidence real,
  value_score integer,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Auto-update updated_at
create or replace function public.update_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger leads_updated_at
  before update on public.leads
  for each row execute function public.update_updated_at();

-- RLS
alter table public.leads enable row level security;

create policy "Authenticated users can view leads"
  on public.leads for select
  to authenticated
  using (true);

create policy "Authenticated users can create leads"
  on public.leads for insert
  to authenticated
  with check (submitted_by = auth.uid());

create policy "Submitter and admins can update leads"
  on public.leads for update
  to authenticated
  using (
    submitted_by = auth.uid()
    or exists (
      select 1 from public.profiles
      where id = auth.uid() and role in ('admin', 'executive', 'sales')
    )
  );
