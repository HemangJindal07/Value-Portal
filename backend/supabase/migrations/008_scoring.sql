-- Score events: individual point awards
create table public.score_events (
  event_id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  submission_type text not null
    check (submission_type in ('lead', 'idea')),
  submission_id uuid not null,
  event_type text not null
    check (event_type in ('submitted', 'approved', 'implemented', 'qualified', 'deal_won')),
  points_awarded integer not null,
  awarded_at timestamptz not null default now()
);

create index score_events_user_idx on public.score_events(user_id);

-- User scores: aggregated scoreboard per user per period
create table public.user_scores (
  score_id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  total_points integer not null default 0,
  leads_submitted integer not null default 0,
  ideas_submitted integer not null default 0,
  deals_won integer not null default 0,
  ideas_implemented integer not null default 0,
  period text not null default 'all_time',
  rank integer not null default 0,
  updated_at timestamptz not null default now()
);

create unique index user_scores_user_period_idx on public.user_scores(user_id, period);

-- Leaderboard entries: periodic snapshots
create table public.leaderboard_entries (
  entry_id uuid primary key default gen_random_uuid(),
  category text not null
    check (category in ('top_contributor', 'revenue_leader', 'value_champion', 'top_team')),
  entity_type text not null default 'user'
    check (entity_type in ('user', 'team')),
  entity_id uuid not null,
  rank integer not null,
  score integer not null,
  period text not null
    check (period in ('monthly', 'quarterly', 'annual')),
  period_label text not null,
  badge text,
  generated_at timestamptz not null default now()
);

-- RLS
alter table public.score_events enable row level security;
alter table public.user_scores enable row level security;
alter table public.leaderboard_entries enable row level security;

create policy "Users see own score events"
  on public.score_events for select
  to authenticated
  using (true);

create policy "Users can view all scores"
  on public.user_scores for select
  to authenticated
  using (true);

create policy "Anyone can view leaderboard"
  on public.leaderboard_entries for select
  to authenticated
  using (true);
