-- Dashboard metrics: precomputed/cached metrics
create table public.dashboard_metrics (
  metric_id uuid primary key default gen_random_uuid(),
  metric_name text not null,
  metric_value decimal(15,2) not null default 0,
  metric_type text not null
    check (metric_type in ('revenue', 'savings', 'count', 'score')),
  account_id uuid references public.accounts(account_id),
  user_id uuid references public.profiles(id),
  period text not null default 'all_time',
  computed_at timestamptz not null default now()
);

create index dashboard_metrics_period_idx on public.dashboard_metrics(period);

-- Review cycles: governance periodic reviews
create table public.review_cycles (
  cycle_id uuid primary key default gen_random_uuid(),
  cycle_type text not null
    check (cycle_type in ('monthly', 'quarterly')),
  period_label text not null,
  start_date date not null,
  end_date date not null,
  facilitator_id uuid references public.profiles(id),
  status text not null default 'planned'
    check (status in ('planned', 'in_progress', 'completed')),
  submissions_reviewed integer not null default 0,
  notes text,
  created_at timestamptz not null default now()
);

-- Impact measurements: actual measured business impact
create table public.impact_measurements (
  impact_id uuid primary key default gen_random_uuid(),
  submission_type text not null
    check (submission_type in ('lead', 'idea')),
  submission_id uuid not null,
  revenue_influenced decimal(15,2),
  cost_saved decimal(15,2),
  efficiency_gain text,
  measured_by uuid not null references public.profiles(id),
  measurement_date date not null default current_date,
  verified boolean not null default false,
  created_at timestamptz not null default now()
);

-- RLS
alter table public.dashboard_metrics enable row level security;
alter table public.review_cycles enable row level security;
alter table public.impact_measurements enable row level security;

create policy "Authenticated users can view metrics"
  on public.dashboard_metrics for select
  to authenticated using (true);

create policy "Authenticated users can view review cycles"
  on public.review_cycles for select
  to authenticated using (true);

create policy "Admins manage review cycles"
  on public.review_cycles for all
  to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role in ('admin', 'executive')
    )
  );

create policy "Authenticated users can view impact measurements"
  on public.impact_measurements for select
  to authenticated using (true);

create policy "Privileged users manage impact measurements"
  on public.impact_measurements for all
  to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role in ('admin', 'executive', 'practice_lead')
    )
  );
