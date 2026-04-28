-- Migration 022: Clean up stale score events and recalculate all user scores
-- Removes events for event_types that no longer exist in the points map
-- (approved=25, implemented=50) and resets all user_scores totals.
-- After running this, scores will reflect the correct cumulative logic:
--   submitted=10, qualified=20, opportunity_created=50, deal_won=100

-- 1. Delete stale event types that no longer award points
delete from public.score_events
where event_type in ('approved', 'implemented');

-- 2. Fix any existing events that have wrong points_awarded values
update public.score_events set points_awarded = 10  where event_type = 'submitted';
update public.score_events set points_awarded = 20  where event_type = 'qualified';
update public.score_events set points_awarded = 50  where event_type = 'opportunity_created';
update public.score_events set points_awarded = 100 where event_type = 'deal_won';
update public.score_events set points_awarded = 0   where event_type = 'deal_lost';

-- 3. Recalculate user_scores from scratch based on corrected score_events
with aggregated as (
  select
    user_id,
    sum(points_awarded) as total_points,
    count(*) filter (where event_type = 'submitted' and submission_type = 'lead') as leads_submitted,
    count(*) filter (where event_type = 'deal_won') as deals_won,
    count(*) filter (where event_type = 'opportunity_created') as ideas_implemented
  from public.score_events
  group by user_id
)
update public.user_scores us
set
  total_points      = coalesce(a.total_points, 0),
  leads_submitted   = coalesce(a.leads_submitted, 0),
  deals_won         = coalesce(a.deals_won, 0),
  ideas_implemented = coalesce(a.ideas_implemented, 0),
  updated_at        = now()
from aggregated a
where us.user_id = a.user_id
  and us.period = 'all_time';

-- 4. Zero out scores for users who have no events left
update public.user_scores
set total_points = 0, leads_submitted = 0, deals_won = 0, ideas_implemented = 0, updated_at = now()
where period = 'all_time'
  and user_id not in (select distinct user_id from public.score_events);

-- 5. Recompute ranks
with ranked as (
  select score_id, row_number() over (order by total_points desc, updated_at asc) as new_rank
  from public.user_scores
  where period = 'all_time'
)
update public.user_scores us
set rank = r.new_rank
from ranked r
where us.score_id = r.score_id;
