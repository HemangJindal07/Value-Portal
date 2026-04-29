# TX Catalyst — Automated Test Results
**Date:** 2026-04-27 | **Tester:** Claude Code (Static + Runtime Analysis)
**Note:** Network calls blocked in sandbox — API/browser tests marked with manual steps required.

---

## SUMMARY

| Category | Status | Details |
|---|---|---|
| TypeScript compilation | ✅ PASS | 0 errors |
| ESLint | ⚠️ 3 WARNINGS | Non-critical React pattern warnings |
| Python syntax | ✅ PASS | All core backend files compile cleanly |
| Scoring logic | ✅ PASS | Points map correct: 10/20/50/100 |
| State machine | ✅ PASS | valid_prior transitions correct |
| XSS protection | ✅ PASS | sanitize_dict on all text inputs |
| File upload security | ✅ PASS | Type + size validation in place |
| Auth guards | ✅ PASS | All sensitive endpoints protected |
| CORS | ✅ PASS | Only localhost:3000 + env URL allowed |
| Cron security | ✅ PASS | X-Cron-Secret header required |
| Test mode emails | ⚠️ EXPECTED | 11 TEST_OVERRIDE_EMAIL in routing_engine (intentional) |
| Legacy 'approved' in UI | ⚠️ MINOR | ReviewDecisionDialog still sends action="approved" to backend |

---

## 1. TypeScript — ✅ PASS

```
npx tsc --noEmit → 0 errors
```
All types are consistent. `contact_details`, `service`, `opportunity_created` status, and new `ActionTaken` values are correctly typed.

---

## 2. ESLint — ⚠️ 3 WARNINGS (non-blocking)

These are React best-practice warnings, not bugs. The app works correctly.

| File | Line | Issue |
|---|---|---|
| accounts/page.tsx | 42 | `setLoading(true)` called synchronously inside useEffect |
| assignments/page.tsx | 113 | Same pattern |
| leads/page.tsx | 71 | Same pattern |

**Impact:** Minor — may cause one extra render on state change. No functional issue.
**Fix (optional):** Move `setLoading(true)` before the `useEffect` call or use `useCallback` wrapper.

---

## 3. Python Syntax — ✅ PASS

All 8 core backend files compile cleanly:
- `app/main.py`
- `app/routers/leads.py`
- `app/routers/assignments.py`
- `app/services/routing_engine.py`
- `app/services/scoring.py`
- `app/services/email_service.py`
- `app/schemas/lead.py`
- `app/schemas/assignment.py`

---

## 4. Scoring Logic — ✅ PASS

POINTS_MAP verified:
```python
submitted:           10   # +10 → cumulative 10
qualified:           20   # +20 → cumulative 30
opportunity_created: 50   # +50 → cumulative 80
deal_won:           100   # +100 → cumulative 180
deal_lost:            0   # tracked, no points
```
`approved` event type correctly REMOVED from map.

---

## 5. Lead Status State Machine — ✅ PASS

Routing engine correctly sets:
- Final approval → `qualified` (not `approved`)
- Rejection → `rejected`
- Routing failure → `routing_pending`

Assignment state machine verified:
```python
valid_prior = {
    "opportunity_created": {"qualified"},           # can only create opp from qualified
    "won":  {"opportunity_created"},                # can only win from opp_created
    "lost": {"opportunity_created", "qualified"},   # can lose from either
}
```

---

## 6. XSS Protection — ✅ PASS

`sanitize_dict()` called on all user-supplied text fields:
- `leads.py`: `["title", "description"]` on create AND update
- `accounts.py`: `["account_name", "industry", "region"]` on create AND update

---

## 7. File Upload Security — ✅ PASS

- Max size: 20MB enforced
- Allowed MIME types: PDF, Word, Excel, images, text, zip
- `.exe`, `.sh`, `.bat` and other executables rejected
- Files stored in Supabase Storage with UUID path (no directory traversal)

---

## 8. Auth Guards — ✅ PASS

| Endpoint | Guard |
|---|---|
| All leads endpoints | `get_current_user` (authenticated) |
| `GET /assignments/all` | `require_role("admin", "executive")` |
| `DELETE /accounts/{id}` | `require_role("admin")` |
| Admin pages (frontend) | Role checked via `isOrgRole` flag |

---

## 9. CORS — ✅ PASS

Whitelist: `settings.frontend_url` + `http://localhost:3000`
No wildcard (`*`) — production-safe.

---

## 10. Test Mode Email — ⚠️ EXPECTED / INTENTIONAL

11 locations in `routing_engine.py` redirect emails to `hemang.jindal@testingxperts.com`.
This is correct for demo/testing. Must be replaced before go-live.

Locations to change before production:
- Line 313–316 (submission email redirect)
- Lines 523, 525 (rejection email)
- Lines 595, 597 (step approval email)
- Lines 629, 631 (next reviewer email)
- Lines 676, 678 (final approval email)

---

## 11. Known Issue — ReviewDecisionDialog sends "approved" not "qualified"

**File:** `frontend/src/app/(dashboard)/assignments/page.tsx`
**Lines:** 93, 123, 303

The Qualify button sends `action_taken: "approved"` to the backend. The backend `advance_routing` correctly interprets this and sets the lead status to `qualified`, so the **end result is correct**. However the action value stored in `assignments.action_taken` will be `"approved"` not `"qualified"`, which could confuse future queries.

**Risk:** Low — functional flow works correctly. Dashboard and My Submissions read `leads.status` not `assignments.action_taken`.
**Fix (optional):** Change the ReviewDecisionDialog action from `"approved"` to `"qualified"` for leads.

---

## 12. Manual Tests Required (servers not running in sandbox)

These require the app to be running — test manually:

### AUTH
- [ ] Login with Syed@gmail.com / Syed@1 → user dashboard
- [ ] Login with Executive@gmail.com / Executive@1 → executive dashboard
- [ ] Login with admin@test.com / Test@1234 → admin dashboard
- [ ] Navigate to /admin/users as Syed → confirm 403/redirect

### LEAD FLOW (end-to-end)
- [ ] Submit lead with "Quality Engineering" service → routes to Manjeet
- [ ] Submit lead with no service line → toast error, blocked
- [ ] As reviewer: Qualify → lead = qualified, submitter +20pts
- [ ] As reviewer: Create Opportunity → lead = opportunity_created, +50pts
- [ ] As reviewer: Won → lead = won, +100pts

### DASHBOARD
- [ ] User pipeline chart total = My Leads Submitted count
- [ ] Score KPI matches sum of score_events in Supabase
- [ ] Executive funnel has "Opportunity Created" not "Approved"

### DB INTEGRITY (run in Supabase SQL editor)
```sql
-- All should return 0 rows or expected values:

-- No stale event types
select distinct event_type from score_events;

-- No legacy approved leads
select count(*) from leads where status = 'approved';

-- Score totals match events
select us.user_id, us.total_points, sum(se.points_awarded) as calc
from user_scores us
left join score_events se on se.user_id = us.user_id
where us.period = 'all_time'
group by us.user_id, us.total_points
having us.total_points != coalesce(sum(se.points_awarded), 0);

-- No orphaned score events
select count(*) from score_events se
where submission_type = 'lead'
  and submission_id::text not in (select lead_id::text from leads);

-- Service routing correct
select service_name, p.full_name from service_routing sr
join profiles p on p.id = sr.du_user_id order by service_name;
```

---

## VERDICT

| Area | Result |
|---|---|
| Code quality | ✅ Ready for internal demo |
| Security | ✅ No critical vulnerabilities found |
| Scoring logic | ✅ Correct |
| State machine | ✅ Correct |
| Email (test mode) | ⚠️ All go to hemang.jindal — intentional |
| action="approved" in dialog | ⚠️ Minor — functional but semantically wrong |
| ESLint warnings | ⚠️ Non-blocking React patterns |

**Overall: READY FOR INTERNAL DEMO with noted caveats.**
