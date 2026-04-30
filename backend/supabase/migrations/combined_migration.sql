-- ============================================================
-- COMBINED MIGRATION — Run this once in Supabase SQL Editor
-- ============================================================

-- ── 001: Profiles ────────────────────────────────────────────
create table public.profiles (
  id uuid references auth.users on delete cascade primary key,
  full_name text not null,
  email text not null unique,
  role text not null default 'delivery_manager'
    check (role in ('delivery_manager', 'sales', 'practice_lead', 'admin', 'executive')),
  department text,
  account_assigned uuid,
  profile_photo text,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  last_login timestamptz
);

create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, full_name, email, role)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'full_name', ''),
    new.email,
    coalesce(new.raw_user_meta_data ->> 'role', 'delivery_manager')
  );
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

alter table public.profiles enable row level security;

create policy "Users can view all active profiles"
  on public.profiles for select
  using (is_active = true);

create policy "Users can update their own profile"
  on public.profiles for update
  using (auth.uid() = id)
  with check (auth.uid() = id);

create policy "Admins can update any profile"
  on public.profiles for update
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'admin'
    )
  );

create policy "Admins can insert profiles"
  on public.profiles for insert
  with check (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'admin'
    )
  );

-- ── 002: Accounts ────────────────────────────────────────────
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

alter table public.profiles
  add constraint profiles_account_assigned_fk
  foreign key (account_assigned) references public.accounts(account_id);

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

-- ── 003: Leads ───────────────────────────────────────────────
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

-- ── 004: Value Ideas ─────────────────────────────────────────
create table public.value_ideas (
  idea_id uuid primary key default gen_random_uuid(),
  title text not null,
  problem_statement text not null,
  proposed_solution text not null,
  idea_category text not null
    check (idea_category in ('automation', 'cost_optimization', 'efficiency', 'risk_reduction', 'innovation', 'process_improvement')),
  account_id uuid not null references public.accounts(account_id),
  submitted_by uuid not null references public.profiles(id),
  estimated_saving decimal(15,2),
  estimated_effort text not null default 'medium'
    check (estimated_effort in ('low', 'medium', 'high')),
  estimated_timeline text,
  impact_area text[] default '{}',
  tools_involved text[] default '{}',
  status text not null default 'draft'
    check (status in ('draft', 'submitted', 'under_review', 'approved', 'in_progress', 'implemented', 'rejected')),
  ai_category text,
  ai_summary text,
  ai_confidence real,
  value_score integer,
  supporting_docs text[] default '{}',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger value_ideas_updated_at
  before update on public.value_ideas
  for each row execute function public.update_updated_at();

alter table public.value_ideas enable row level security;

create policy "Authenticated users can view ideas"
  on public.value_ideas for select
  to authenticated
  using (true);

create policy "Authenticated users can create ideas"
  on public.value_ideas for insert
  to authenticated
  with check (submitted_by = auth.uid());

create policy "Submitter and admins can update ideas"
  on public.value_ideas for update
  to authenticated
  using (
    submitted_by = auth.uid()
    or exists (
      select 1 from public.profiles
      where id = auth.uid() and role in ('admin', 'executive', 'practice_lead')
    )
  );

-- ── 005: Assignments ─────────────────────────────────────────
create table public.assignments (
  assignment_id uuid primary key default gen_random_uuid(),
  submission_type text not null
    check (submission_type in ('lead', 'idea')),
  submission_id uuid not null,
  assigned_to uuid not null references public.profiles(id) on delete cascade,
  assigned_role text not null,
  assigned_by text not null default 'system'
    check (assigned_by in ('system', 'manual')),
  assignment_date timestamptz not null default now(),
  due_date timestamptz,
  action_taken text not null default 'pending'
    check (action_taken in ('pending', 'reviewed', 'approved', 'rejected', 'escalated')),
  action_date timestamptz,
  notes text,
  created_at timestamptz not null default now()
);

create index assignments_assigned_to_idx on public.assignments(assigned_to);
create index assignments_submission_idx on public.assignments(submission_type, submission_id);

alter table public.assignments enable row level security;

create policy "Users see own assignments; admins/execs see all"
  on public.assignments for select
  to authenticated
  using (
    assigned_to = auth.uid()
    or exists (
      select 1 from public.profiles
      where id = auth.uid() and role in ('admin', 'executive')
    )
  );

create policy "Only assigned user or admin can update assignment"
  on public.assignments for update
  to authenticated
  using (
    assigned_to = auth.uid()
    or exists (
      select 1 from public.profiles
      where id = auth.uid() and role in ('admin', 'executive')
    )
  );

-- ── 006: Tracking (Status History + Comments) ────────────────
create table public.status_history (
  history_id uuid primary key default gen_random_uuid(),
  submission_type text not null
    check (submission_type in ('lead', 'idea')),
  submission_id uuid not null,
  from_status text not null,
  to_status text not null,
  changed_by uuid not null references public.profiles(id) on delete set null,
  changed_at timestamptz not null default now(),
  reason text
);

create index status_history_submission_idx on public.status_history(submission_type, submission_id);
create index status_history_changed_at_idx on public.status_history(changed_at desc);

alter table public.status_history enable row level security;

create policy "Authenticated users can view status history"
  on public.status_history for select
  to authenticated
  using (true);

create table public.comments (
  comment_id uuid primary key default gen_random_uuid(),
  submission_type text not null
    check (submission_type in ('lead', 'idea')),
  submission_id uuid not null,
  author_id uuid not null references public.profiles(id) on delete cascade,
  content text not null,
  is_internal boolean not null default false,
  created_at timestamptz not null default now()
);

create index comments_submission_idx on public.comments(submission_type, submission_id);
create index comments_created_at_idx on public.comments(created_at asc);

alter table public.comments enable row level security;

create policy "Authenticated users can view comments"
  on public.comments for select
  to authenticated
  using (true);

create policy "Authenticated users can create comments"
  on public.comments for insert
  to authenticated
  with check (author_id = auth.uid());

create policy "Authors and admins can delete comments"
  on public.comments for delete
  to authenticated
  using (
    author_id = auth.uid()
    or exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'admin'
    )
  );

-- ── 007: Notifications ───────────────────────────────────────
create table public.notifications (
  notification_id uuid primary key default gen_random_uuid(),
  recipient_id uuid not null references public.profiles(id) on delete cascade,
  submission_type text not null
    check (submission_type in ('lead', 'idea')),
  submission_id uuid not null,
  type text not null
    check (type in ('reminder', 'escalation', 'status_update', 'approval', 'info')),
  message text not null,
  channel text not null default 'in_app'
    check (channel in ('email', 'in_app', 'slack')),
  is_read boolean not null default false,
  sent_at timestamptz not null default now(),
  read_at timestamptz
);

create index notifications_recipient_idx on public.notifications(recipient_id);
create index notifications_unread_idx on public.notifications(recipient_id, is_read) where is_read = false;

alter table public.notifications enable row level security;

create policy "Users see their own notifications"
  on public.notifications for select
  to authenticated
  using (recipient_id = auth.uid());

create policy "Users can update their own notifications"
  on public.notifications for update
  to authenticated
  using (recipient_id = auth.uid());

create table public.escalation_rules (
  rule_id uuid primary key default gen_random_uuid(),
  trigger_days integer not null default 7,
  escalate_to_role text not null,
  submission_status text not null,
  is_active boolean not null default true
);

alter table public.escalation_rules enable row level security;

create policy "Authenticated users can view escalation rules"
  on public.escalation_rules for select
  to authenticated
  using (true);

create policy "Admins can manage escalation rules"
  on public.escalation_rules for all
  to authenticated
  using (
    exists (
      select 1 from public.profiles
      where id = auth.uid() and role = 'admin'
    )
  );

insert into public.escalation_rules (trigger_days, escalate_to_role, submission_status) values
  (7, 'admin', 'submitted'),
  (7, 'admin', 'under_review'),
  (14, 'executive', 'submitted');

-- ── 008: Scoring ─────────────────────────────────────────────
create table public.score_events (
  event_id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  submission_type text not null
    check (submission_type in ('lead', 'idea')),
  submission_id uuid not null,
  event_type text not null,
  points_awarded integer not null,
  awarded_at timestamptz not null default now()
);

create index score_events_user_idx on public.score_events(user_id);

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

-- ── 009: Dashboards & Governance ─────────────────────────────
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

-- ── 010: Routing Status ──────────────────────────────────────
alter table public.leads
  drop constraint if exists leads_status_check;

alter table public.leads
  add constraint leads_status_check
  check (status in ('draft', 'submitted', 'under_review', 'qualified', 'won', 'lost', 'dropped', 'routing_pending', 'approved', 'rejected'));

alter table public.value_ideas
  drop constraint if exists value_ideas_status_check;

alter table public.value_ideas
  add constraint value_ideas_status_check
  check (status in ('draft', 'submitted', 'under_review', 'approved', 'in_progress', 'implemented', 'rejected', 'routing_pending'));

-- ── 011: Account Stakeholders ────────────────────────────────
create table public.account_stakeholders (
  id uuid primary key default gen_random_uuid(),
  account_id uuid not null references public.accounts(account_id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  role_label text not null default 'Reviewer',
  step_order integer not null default 1,
  created_at timestamptz not null default now(),
  unique (account_id, user_id)
);

create index account_stakeholders_account_idx on public.account_stakeholders(account_id, step_order);

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

-- ── 012: Lead Type Taxonomy ──────────────────────────────────
alter table public.leads
  drop constraint if exists leads_lead_type_check;

update public.leads
set lead_type = case
  when lead_type = 'new_service' then 'new_lead'
  else 'current_lead'
end
where lead_type in ('cross_sell', 'upsell', 'new_service', 'expansion');

alter table public.leads
  add constraint leads_lead_type_check
  check (lead_type in ('current_lead', 'new_lead'));

-- ── 013: Vertical Routing ────────────────────────────────────
create table public.vertical_routing (
  id              uuid primary key default gen_random_uuid(),
  vertical_name   text not null unique,
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

create table public.region_sales_mapping (
  id              uuid primary key default gen_random_uuid(),
  region_name     text not null,
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

-- ── 014: Account Services ────────────────────────────────────
alter table public.accounts
  add column if not exists services text[] default '{}';

-- ── 015a: Lead AI Fields ─────────────────────────────────────
alter table public.leads add column if not exists ai_summary text;
alter table public.leads add column if not exists ai_suggested_priority text;
alter table public.leads add column if not exists ai_win_probability real;

-- ── 015b: Service Routing Table ──────────────────────────────
create table if not exists public.service_routing (
  id           uuid primary key default gen_random_uuid(),
  service_name text not null unique,
  du_user_id   uuid references public.profiles(id) on delete set null,
  created_by   uuid references public.profiles(id) on delete set null,
  created_at   timestamptz not null default now()
);

alter table public.service_routing enable row level security;

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

-- ── 016: Lead Service Column ─────────────────────────────────
alter table public.leads
  add column if not exists service text;

-- ── 017 + 018: Seed Service Routing ──────────────────────────
insert into public.service_routing (service_name, du_user_id)
select 'Quality Engineering', id from public.profiles where email = 'manjeet.kumar@testingxperts.com' limit 1
on conflict (service_name) do update set du_user_id = excluded.du_user_id;

insert into public.service_routing (service_name, du_user_id)
select 'Digital Engineering', id from public.profiles where email = 'vivek.gupta@testingxperts.com' limit 1
on conflict (service_name) do update set du_user_id = excluded.du_user_id;

insert into public.service_routing (service_name, du_user_id)
select 'Artificial Intelligence', id from public.profiles where email = 'vivek.gupta@testingxperts.com' limit 1
on conflict (service_name) do update set du_user_id = excluded.du_user_id;

insert into public.service_routing (service_name, du_user_id)
select 'Data Engineering', id from public.profiles where email = 'rajiv.diwan@testingxperts.com' limit 1
on conflict (service_name) do update set du_user_id = excluded.du_user_id;

insert into public.service_routing (service_name, du_user_id)
select 'Insurance', id from public.profiles where email = 'yuvraj.singh@testingxperts.com' limit 1
on conflict (service_name) do update set du_user_id = excluded.du_user_id;

-- ── 019: Update Service Check Constraint ─────────────────────
alter table public.leads drop constraint if exists leads_service_check;

update public.leads set service = 'Quality Engineering'     where service = 'QE';
update public.leads set service = 'Digital Engineering'     where service = 'DE';
update public.leads set service = 'Artificial Intelligence' where service = 'AI';
update public.leads set service = 'Data Engineering'        where service = 'Data';

alter table public.leads
  add constraint leads_service_check
  check (service in (
    'Quality Engineering',
    'Digital Engineering',
    'Artificial Intelligence',
    'Data Engineering',
    'Insurance'
  ));

-- ── 020: Lead Contact Details ────────────────────────────────
alter table public.leads
  add column if not exists contact_details jsonb;

-- ── 021: Lead Status Workflow ────────────────────────────────
alter table public.leads drop constraint if exists leads_status_check;

alter table public.leads
  add constraint leads_status_check
  check (status in (
    'draft', 'submitted', 'routing_pending', 'under_review',
    'qualified', 'opportunity_created', 'approved',
    'won', 'lost', 'dropped', 'rejected'
  ));

alter table public.score_events drop constraint if exists score_events_event_type_check;

alter table public.score_events
  add constraint score_events_event_type_check
  check (event_type in (
    'submitted', 'qualified', 'approved', 'opportunity_created',
    'implemented', 'deal_won', 'deal_lost'
  ));

-- ── 022 + 023: Fix Score Events & Recalculate ────────────────
delete from public.score_events
where event_type in ('approved', 'implemented');

update public.score_events set points_awarded = 10  where event_type = 'submitted';
update public.score_events set points_awarded = 20  where event_type = 'qualified';
update public.score_events set points_awarded = 50  where event_type = 'opportunity_created';
update public.score_events set points_awarded = 100 where event_type = 'deal_won';
update public.score_events set points_awarded = 0   where event_type = 'deal_lost';

update public.leads
set status = 'qualified'
where status = 'approved';

-- ============================================================
-- END OF MIGRATION
-- ============================================================
