-- 034: User-reported issues.
-- Any authenticated user can report an issue they face in the portal; admins
-- review and triage them. Reporter name/email are snapshotted at submission so
-- the admin always sees who reported it even if the profile later changes.
-- Screenshots are stored as a JSON array of {url, filename} pointing at the
-- public `attachments` bucket (PNG).
--
-- All access goes through the backend service-role client (auth + role gated in
-- FastAPI), so RLS is enabled with no policies.

create table public.issues (
  issue_id uuid primary key default gen_random_uuid(),
  reporter_id uuid not null references public.profiles(id) on delete cascade,
  reporter_name text not null,
  reporter_email text not null,
  description text not null,
  screenshots jsonb not null default '[]'::jsonb,
  status text not null default 'open',  -- open | in_progress | resolved
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index issues_reporter_idx on public.issues(reporter_id);
create index issues_status_idx on public.issues(status);

alter table public.issues enable row level security;
-- No policies: only the service-role key (which bypasses RLS) may access this table.

-- Allow 'issue' as a notification submission_type so admins/reporters can be
-- notified about issues through the existing in-app notification system.
-- (notifications.type reuses the already-allowed 'info' and 'status_update'.)
alter table public.notifications
  drop constraint if exists notifications_submission_type_check;
alter table public.notifications
  add constraint notifications_submission_type_check
  check (submission_type in ('lead', 'idea', 'issue'));
