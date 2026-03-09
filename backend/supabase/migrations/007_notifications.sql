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

-- Seed default escalation rules
insert into public.escalation_rules (trigger_days, escalate_to_role, submission_status) values
  (7, 'admin', 'submitted'),
  (7, 'admin', 'under_review'),
  (14, 'executive', 'submitted');
