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

-- RLS
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
