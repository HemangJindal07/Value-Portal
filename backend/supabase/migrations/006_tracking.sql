-- Status history: immutable record of every status change on leads and ideas
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

-- Comments on leads and ideas
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
