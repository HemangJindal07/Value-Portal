create table public.assignments (
  assignment_id uuid primary key default gen_random_uuid(),
  submission_type text not null
    check (submission_type in ('lead', 'idea')),
  submission_id uuid not null,
  assigned_to uuid not null references public.profiles(id) on delete cascade,
  assigned_role text not null
    check (assigned_role in ('account_owner', 'sales_lead', 'practice_leader', 'review_committee')),
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

-- RLS
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
