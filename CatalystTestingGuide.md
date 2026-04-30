# TX Catalyst — End-to-End Testing Guide

**Product:** TX Catalyst (Value Portal) — TestingXperts  
**Backend:** http://localhost:8000  
**Frontend:** http://localhost:3000  
**API Docs:** http://localhost:8000/docs  

---

## Test Credentials

| Role | Email | Password | What they can do |
|------|-------|----------|-----------------|
| Delivery Manager | `Syed@gmail.com` | `Syed@1` | Submit leads, view own submissions, see own scores |
| Executive (Stakeholder/Reviewer) | `Executive@gmail.com` | `Executive@1` | Review assigned leads, see own + assigned leads, executive dashboard |
| Admin | `admin@test.com` | `Test@1234` | Full access — all leads, all users, all accounts, admin dashboard |

---

## Part 1 — Authentication

### 1.1 Login
1. Open http://localhost:3000
2. You are redirected to `/login`
3. Enter credentials for any role above → click **Sign In**
4. On success you land on the **Dashboard** — the view changes per role
5. **Logout:** Click the avatar (top-right) → **Sign Out** → redirected back to `/login`

### 1.2 What changes per role on login
| Area | Delivery Manager | Executive | Admin |
|------|-----------------|-----------|-------|
| Dashboard view | Personal pipeline + scores | Executive analytics + charts | Admin analytics + all data |
| Leads visible | Own submissions only | Own + assigned to them | All 29 leads |
| Users list | Name only (no email/role) | Full profile | Full profile |
| Assignments | Own pending reviews | Own pending reviews | All org assignments |

---

## Part 2 — Accounts

### 2.1 Create an Account (any logged-in user)
1. Go to **Accounts** in the sidebar
2. Click **New Account**
3. Fill:
   - **Account Name** (required)
   - **Industry** (e.g. Healthcare, IT, Banking)
   - **Region** (select from dropdown — controls email routing)
   - **Delivery Unit (DU)** — first reviewer in the routing chain
   - **Delivery Head (DH)** — second reviewer
   - **Status** — Prospect / Active / Inactive
4. Click **Create Account**
5. Account is saved; DU and DH are auto-added as `account_stakeholders` (step 1 & 2)
6. DU and DH each receive an in-app notification of their assignment

> **Important:** Accounts without a DU/DH set will cause any lead submitted against them to go `routing_pending` — no reviewers, no emails.

### 2.2 Quick-Add Account from Lead Form
1. Open **Submit Lead**
2. In the **Account** field, type 3+ characters → search runs
3. If not found, click **"Add '...' as new account"**
4. Modal opens — fill Name (required), Industry, Region → **Create Account**
5. Account is created and auto-selected in the lead form
6. Continue to fill and submit the lead

> Note: Quick-add accounts have no DU/DH set — configure them via Account edit before submitting a lead.

### 2.3 View / Edit an Account (Admin / Executive / Stakeholder)
1. Go to **Accounts** → click any account name
2. View leads associated with this account
3. Edit button → update DU, DH, industry, region, status
4. Saving a new DU/DH re-syncs `account_stakeholders` automatically

---

## Part 3 — Lead Submission (Delivery Manager / any authenticated user)

### 3.1 Submit a Lead
1. Log in as **Syed@gmail.com** (Delivery Manager)
2. Click **Submit Lead** in the sidebar
3. Fill all required fields:
   - **Title** — name of the opportunity
   - **Lead Type** — Current Lead or New Lead
   - **Account** — must have DU/DH configured for routing to work
   - **Description** — detailed context
   - **Estimated Value** — must be ≥ 0 (negative values are rejected)
   - **Probability** — 0–100% (validated)
   - **Priority** — High / Medium / Low
   - **Expected Close Date** — optional
4. Click **Submit Lead**

### 3.2 What happens immediately after submission
- Lead is saved with status `submitted`
- Background task `start_routing` runs:
  - Looks up `account_stakeholders` for the selected account
  - If stakeholders found → creates an `assignment` for the DU → status changes to `under_review`
  - If no stakeholders → status changes to `routing_pending` → admins notified in-app
  - **Points awarded only on successful routing** (not on routing_pending)
- Background task `classify_lead` runs → AI fills `ai_category` and `ai_confidence`
- Email sent to all stakeholders (currently redirected to `hemang.jindal@testingxperts.com` in test mode)

### 3.3 Routing Pending — what to do
If a lead shows `routing_pending`:
1. Admin logs in → Go to **Admin → Stakeholder Mapping**
2. Find the account → add DU and DH
3. The lead remains routing_pending until manually re-routed (or admin can update lead status directly)

---

## Part 4 — Review & Approval (Executive / Assigned Reviewer)

### 4.1 Reviewer receives assignment
1. Log in as **Executive@gmail.com**
2. Check the **bell icon** (top-right) — shows unread notification count
3. Go to **My Assignments** in the sidebar
4. See all pending assignments with submission title, account, and due date

### 4.2 Approve or Reject
1. Click any pending assignment
2. Read the lead details
3. Select **Approved** or **Rejected** from the action dropdown
4. Add a **note/reason** (minimum 10 characters required)
5. Click **Submit Decision**

### 4.3 What happens after approval
- If more reviewers remain in chain → next reviewer gets an assignment + in-app notification + email
- If this was the last reviewer → lead status changes to `approved`; submitter notified
- Submitter receives in-app notification + email at each step

### 4.4 What happens after rejection
- Lead status changes to `rejected`
- Submitter receives in-app notification + email with reviewer name and role

---

## Part 5 — Lead Lifecycle Status Flow

```
submitted
    │
    ▼ (routing engine)
under_review ──────────────────────────► rejected
    │
    ▼ (reviewer approves)
qualified
    │
    ├──► won        (sales closes the deal)
    └──► lost       (deal lost)
    
routing_pending    (no stakeholders configured — stuck)
```

**Status changes via PATCH /leads/{id}:**
- Admin / Executive can change any status
- Assigned reviewers can move leads through their stage
- Sales can mark qualified → won / lost
- Submitters cannot change their own lead's status

---

## Part 6 — Dashboards

### 6.1 Delivery Manager Dashboard (Syed)
**API calls made:**
- `/api/dashboard/stats` — personal counts
- `/api/leads?submitted_by=me` — own leads only
- `/api/assignments/mine` — pending reviews assigned to me
- `/api/scores/me` — personal score
- `/api/scores/leaderboard` — full org leaderboard (mini view)

**What you see:**
- Your submitted leads and their current statuses
- Pending assignments (if you are a reviewer)
- Your points and rank in the leaderboard
- Mini leaderboard (top 5)

### 6.2 Executive Dashboard
**API calls made:**
- `/api/dashboard/admin-analytics` — qualification ratio, win rate, pipeline value, by-region, by-vertical, top accounts, reviewer turnaround
- `/api/dashboard/monthly-trend` — 12-month pipeline and won value trend
- `/api/dashboard/recent-activity?limit=20` — last 20 status changes
- `/api/dashboard/stakeholder-completeness` — % accounts with stakeholders mapped

**What you see:**
- Pipeline Value (excludes routing_pending — only submitted/under_review/qualified)
- Won Value and Win Rate
- Monthly trend chart (hover for tooltips)
- Leads by region (bar chart)
- Routing exceptions count (pending leads stuck)
- Stakeholder completeness card (% of accounts mapped)
- Strategic highlights — last 20 activity events filtered to key statuses
- Mini leaderboard

### 6.3 Admin Dashboard
**API calls made:**
- Everything Executive sees, plus:
- `/api/dashboard/recent-activity?limit=8` — latest 8 events
- `/api/dashboard/admin-analytics` — full analytics
- `/api/dashboard/stakeholder-completeness` — with list of unmapped account names

**What you see (beyond Executive):**
- Active Users count + Total Accounts count stat cards
- Stakeholder completeness with named list of unmapped accounts (click to fix)
- All top-account activity

---

## Part 7 — Notifications

### 7.1 In-app notifications
- Bell icon in the top-right shows unread count (refreshes every 30 seconds)
- Click bell → goes to `/notifications`
- Click any notification → mark as read
- **Mark All Read** button available

### 7.2 Email notifications (test mode — all to hemang.jindal@testingxperts.com)

| Trigger | Email sent to |
|---------|--------------|
| Lead submitted (stakeholders found) | All account stakeholders + region contact (CC: always) |
| Reviewer approves → next step | Next reviewer in chain |
| Any approval step | Submitter ("your lead is progressing") |
| Final approval | Submitter ("your lead is fully approved") |
| Rejection | Submitter ("your lead was rejected by X") |

**Production routing (uncomment in email_service.py before go-live):**
- UK accounts → Sahil Baquer CC'd
- US accounts → Joe Underwood CC'd
- All cases → Adeesh Jain CC'd

---

## Part 8 — Scoring / Leaderboard

| Event | Points |
|-------|--------|
| Lead successfully routed (under_review) | 10 |
| Lead → Qualified | 20 |
| Lead → Won | 100 |
| Idea → Approved | 25 |
| Idea → Implemented | 50 |

- Points only awarded when routing **succeeds** (not for routing_pending leads)
- Deduplication: same user + same submission + same event = awarded only once
- Go to **Leaderboard** in the sidebar to see full ranking

---

## Part 9 — Admin-Only Features

### 9.1 User Management
1. Go to **Admin → Users**
2. See all users with role, email, department, active status
3. Click a user → edit role, department, active/inactive

### 9.2 Stakeholder Mapping
1. Go to **Admin → Stakeholder Mapping**
2. Search for an account
3. Add reviewers — each gets a `step_order` in the approval chain
4. DU (step 1) and DH (step 2) are auto-synced from the account's DU/DH fields
5. Additional reviewers (e.g. Sales, Regional) can be added as step 3, 4, etc.
6. Reorder reviewers by dragging or using the order controls

### 9.3 Vertical Routing (org-wide fallback)
If an account has no stakeholders, the routing engine falls back to:
1. **Vertical Routing** — maps an industry (vertical) to a DU and DH user
2. **Region Sales Mapping** — maps a region to a Sales user (+ copy-all contacts)

Configure at **Admin → Vertical Routing**.

### 9.4 Governance Review Cycles
1. Go to **Governance** in the sidebar (Admin / Executive)
2. Create a review cycle: type (monthly/quarterly), label, start/end date
3. `submissions_reviewed` is automatically computed from `status_history` — counts leads/ideas that reached a terminal status (qualified, approved, won, rejected, lost) within the cycle's date window
4. Mark cycles as completed with notes

---

## Part 10 — Common Scenarios & Edge Cases

### Scenario A: New client account, first lead
1. Admin creates account with DU and DH → stakeholders auto-created
2. DM submits lead against the account
3. Lead → `under_review`, DU gets assignment + email
4. DU approves → DH gets assignment + email, submitter notified
5. DH approves → lead → `approved`, submitter gets final approval email

### Scenario B: Account with no stakeholders
1. DM submits lead against an unmapped account
2. Lead goes to `routing_pending`
3. All admins receive in-app notification
4. **No points awarded** to submitter
5. Admin maps stakeholders via Stakeholder Mapping
6. Admin manually advances the lead (update status to `under_review`, re-assign)

### Scenario C: Executive reviews and rejects
1. Executive logs in, sees assignment in My Assignments
2. Opens lead → reads details → selects Rejected
3. Adds reason (min 10 chars) → submits
4. Lead status → `rejected`
5. Submitter gets in-app notification + email with Executive's name and role

### Scenario D: Duplicate lead prevention
- No automatic deduplication exists — same lead can be submitted twice
- Admin can delete a lead (admin only) or change its status to `dropped`

### Scenario E: Negative value rejection
- Entering `-500` for Estimated Value → backend returns HTTP 422
- Frontend shows: "Input should be greater than or equal to 0"
- Lead is not created

### Scenario F: Probability out of range
- Entering `150` for Probability → backend returns HTTP 422
- Valid range: 0–100

---

## Part 11 — API Health Checks

```bash
# Backend health
curl http://localhost:8000/health

# Sign in
curl -X POST http://localhost:8000/api/auth/signin \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@test.com","password":"Test@1234"}'

# Dashboard stats
curl http://localhost:8000/api/dashboard/stats \
  -H "Authorization: Bearer <token>"
```

Full interactive API docs: http://localhost:8000/docs

---

## Part 12 — Known Limitations (Pre-Production)

| Item | Status |
|------|--------|
| Email in TEST MODE — all to hemang.jindal@testingxperts.com | Intentional until go-live |
| Account creation open to all roles | Intentional for testing — restore role restriction before go-live |
| No duplicate lead prevention | Backlog |
| routing_pending leads need manual admin re-routing | Backlog |
| Value Ideas workflow disabled in sidebar | Backend exists, frontend routes commented out |
| Test data in DB (TEST_DIRECT_INSERT, AUDIT leads, etc.) | Clean up before production |

---

## Part 13 — Go-Live Checklist

- [ ] In `email_service.py`: delete TEST block, uncomment PRODUCTION block
- [ ] In `routing_engine.py`: replace `TEST_OVERRIDE_EMAIL` with real variables (4 spots marked `# TEST:`)
- [ ] In `accounts.py`: restore `require_role("admin", "executive", "sales")` on `create_account`
- [ ] Delete test accounts and leads from Supabase
- [ ] Set `FRONTEND_URL` in Render to Vercel URL
- [ ] Set `NEXT_PUBLIC_API_URL` in Vercel to Render URL
- [ ] Update Supabase Auth → Site URL + Redirect URLs
- [ ] Verify domain for Resend/SMTP (currently using Gmail app password)

---

## Part 14 — QA Test Cases (Structured)

**Updated:** 2026-04-27 | **Status:** For internal demo testing

---

### AUTH

| TC | Test | Expected |
|---|---|---|
| TC-AUTH-01 | Login with each valid credential set | Dashboard loads, correct nav per role |
| TC-AUTH-02 | Login with wrong password | Error toast, no redirect |
| TC-AUTH-03 | Submit login with empty fields | Browser required validation, no API call |
| TC-AUTH-04 | Close tab after login, reopen | Still logged in |
| TC-AUTH-05 | Logout via topbar | Redirected to /login, back button doesn't return |
| TC-AUTH-06 | Navigate to /leads, /assignments while logged out | Redirect to /login |
| TC-AUTH-07 | As Syed, navigate to /admin/users via URL | 403 or redirect — must never load |

---

### NAVIGATION

| TC | Test | Expected |
|---|---|---|
| TC-NAV-01 | Admin sidebar items | Dashboard, Accounts, Submit New Lead, My Assignments, Leaderboard, Reviews, Notifications, Exception Queue, Stakeholder Mapping, Routing Config, Admin |
| TC-NAV-02 | Executive sidebar items | Dashboard, Submit New Lead, My Assignments, Leaderboard, Reviews, Notifications — NO Reports, NO Admin |
| TC-NAV-03 | User sidebar items | Dashboard, Submit New Lead, My Submissions, Leaderboard, Notifications — NO Reports |
| TC-NAV-04 | Click "Submit New Lead" in sidebar | Opens /leads/new directly, NOT /leads list |
| TC-NAV-05 | Active link highlighting | Only current page highlighted red |

---

### LEAD FORM

| TC | Test | Expected |
|---|---|---|
| TC-FORM-01 | Page title | "Lead Opportunity" |
| TC-FORM-02 | Field label for title input | "Lead Opportunity *" |
| TC-FORM-03 | Account Type field | Present, disabled, auto-filled |
| TC-FORM-04 | Select existing account | Account Type = "Existing Account" |
| TC-FORM-05 | Create new account via modal | Account Type = "New Account" |
| TC-FORM-06 | Service Line card | Red asterisk present |
| TC-FORM-07 | Submit without Service Line | Toast error, form does not submit |
| TC-FORM-08 | Select Quality Engineering | Hint: "submitted to Manjeet for review" |
| TC-FORM-09 | Select Digital Engineering | Hint: "Vivek" |
| TC-FORM-10 | Select Artificial Intelligence | Hint: "Vivek" |
| TC-FORM-11 | Select Data Engineering | Hint: "Rajiv" |
| TC-FORM-12 | Select Insurance | Hint: "Yuvraj" |
| TC-FORM-13 | Probability field | Must NOT be visible |
| TC-FORM-14 | Supporting Document | No asterisk — optional |
| TC-FORM-15 | Priority display | "High", "Medium", "Low" (capitalized) |
| TC-FORM-16 | Contact Details card | Name, Email, Region (dropdown), Title fields |
| TC-FORM-17 | Submit without document | Succeeds |

---

### LEAD LIFECYCLE

| TC | Test | Expected |
|---|---|---|
| TC-FLOW-01 | Submit lead with service line | Status = under_review, reviewer assigned, submitter +10pts |
| TC-FLOW-02 | Submit with no routing config | Status = routing_pending, admin notified, 0 pts |
| TC-FLOW-03 | Reviewer clicks Qualify | Status = qualified, submitter +20pts, notification sent |
| TC-FLOW-04 | Reviewer clicks Reject | Status = rejected, 0 new pts, submitter notified |
| TC-FLOW-05 | Reviewer clicks Create Opportunity | Status = opportunity_created, submitter +50pts |
| TC-FLOW-06 | Reviewer clicks Won | Status = won, submitter +100pts |
| TC-FLOW-07 | Reviewer clicks Lost | Status = lost, 0 pts, submitter notified |
| TC-FLOW-08 | Try Won on qualified lead directly | Backend blocks — must go through opportunity_created first |
| TC-FLOW-09 | Escalate assignment | action_taken = escalated, no status change |

---

### MY SUBMISSIONS (User role)

| TC | Test | Expected |
|---|---|---|
| TC-SUB-01 | Tab names as Syed | My Submissions, Under Review, Qualified/Rejected |
| TC-SUB-02 | My Submissions table columns | Title, Account, Contact, Service Line, Account Type, Priority, Status, Est. Value |
| TC-SUB-03 | Status display in table | Capitalized first word (e.g. "Under review") |
| TC-SUB-04 | Contact column | Shows Name + Email + Title from contact_details |
| TC-SUB-05 | Under Review tab | Only submitted/routing_pending/under_review leads |
| TC-SUB-06 | Qualified/Rejected tab | Only qualified/rejected/opportunity_created/won/lost |
| TC-SUB-07 | Tab count badge | Matches filtered row count |

---

### ASSIGNMENTS (Reviewer)

| TC | Test | Expected |
|---|---|---|
| TC-ASSIGN-01 | Page title as admin/executive | "My Assignments" |
| TC-ASSIGN-02 | Page title as delivery_manager | "My Submissions" |
| TC-ASSIGN-03 | Buttons on under_review lead | Qualify, Reject, Escalate |
| TC-ASSIGN-04 | Buttons on qualified lead | Create Opportunity only |
| TC-ASSIGN-05 | Buttons on opportunity_created lead | Won, Lost only |
| TC-ASSIGN-06 | Executive Organisation tab | Read-only — no action buttons |
| TC-ASSIGN-07 | Admin Organisation tab | Full action buttons |
| TC-ASSIGN-08 | Review dialog reason validation | Submit disabled until 10+ chars |
| TC-ASSIGN-09 | Aging border <3 days | Green left border |
| TC-ASSIGN-10 | Aging border 4-7 days | Amber left border |
| TC-ASSIGN-11 | Aging border 7+ days | Red left border |

---

### SCORING

| TC | Test | Expected |
|---|---|---|
| TC-SCORE-01 | Submit lead → routing succeeds | score_events row: submitted, 10pts |
| TC-SCORE-02 | Submit lead → routing_pending | NO score_events row |
| TC-SCORE-03 | Qualify lead | score_events row: qualified, 20pts |
| TC-SCORE-04 | Create opportunity | score_events row: opportunity_created, 50pts |
| TC-SCORE-05 | Mark won | score_events row: deal_won, 100pts |
| TC-SCORE-06 | Qualify same lead twice | Only 1 qualified event (deduplication) |
| TC-SCORE-07 | Dashboard My Score | Matches sum of score_events.points_awarded |

---

### DASHBOARD DATA ACCURACY

| TC | Test | Expected |
|---|---|---|
| TC-DASH-01 | User: My Leads Submitted count | Matches actual lead count in DB |
| TC-DASH-02 | User: Pipeline chart total | "X total" header = My Leads Submitted |
| TC-DASH-03 | User: Pipeline stages sum | Awaiting+UnderReview+Qualified+Opportunity+Won/Lost = total |
| TC-DASH-04 | Executive: Funnel stages | No "Approved" stage — shows "Opportunity Created" |
| TC-DASH-05 | Admin: Pipeline chart | No routing_pending or draft rows shown |
| TC-DASH-06 | Leaderboard scores | Match score_events sums in DB |

---

### SECURITY

| TC | Test | Expected |
|---|---|---|
| TC-SEC-01 | API call without token | 401 Unauthorized |
| TC-SEC-02 | As Syed, PATCH /api/admin/users | 403 Forbidden |
| TC-SEC-03 | As Syed, GET another user's lead | 403 Forbidden |
| TC-SEC-04 | XSS in title/description | Stored as plain text, never executed |
| TC-SEC-05 | SQL injection in search field | Treated as literal string |
| TC-SEC-06 | Upload .exe file | Rejected — file type not allowed |
| TC-SEC-07 | Upload file > 20MB | Rejected — size limit error |
| TC-SEC-08 | As Syed, PATCH another user's assignment | 403 Forbidden |
| TC-SEC-09 | As Syed, change own lead status via API | 403 — submitters cannot change status |

---

### DATABASE INTEGRITY — Run in Supabase

```sql
-- 1. No stale event types
select distinct event_type from score_events;
-- Expected: submitted, qualified, opportunity_created, deal_won, deal_lost only

-- 2. No legacy approved leads
select count(*) from leads where status = 'approved';
-- Expected: 0

-- 3. Service lines use full names
select distinct service from leads where service is not null;
-- Expected: Quality Engineering, Digital Engineering, Artificial Intelligence, Data Engineering, Insurance

-- 4. Score totals match events
select us.user_id, us.total_points, sum(se.points_awarded) as calc
from user_scores us
left join score_events se on se.user_id = us.user_id
where us.period = 'all_time'
group by us.user_id, us.total_points
having us.total_points != coalesce(sum(se.points_awarded), 0);
-- Expected: 0 rows

-- 5. No orphaned score events
select count(*) from score_events se
where submission_type = 'lead'
  and submission_id::text not in (select lead_id::text from leads);
-- Expected: 0

-- 6. Service routing correct
select service_name, p.full_name from service_routing sr
join profiles p on p.id = sr.du_user_id order by service_name;
-- Expected: 5 rows — QE=Manjeet, DE=Vivek, AI=Vivek, Data Engineering=Rajiv, Insurance=Yuvraj

-- 7. TypeScript clean
-- Run in terminal: npx tsc --noEmit (from frontend/)
-- Expected: 0 errors
```

---

### REGRESSION SMOKE TEST — Run Before Every Demo

| # | Check | Pass |
|---|---|---|
| 1 | All 3 role logins work | ☐ |
| 2 | Submit New Lead in sidebar → opens form directly | ☐ |
| 3 | Lead form: Account Type + Service Line + Contact Details visible | ☐ |
| 4 | Service Line mandatory — toast on empty submit | ☐ |
| 5 | Lead routes → status = under_review (not routing_pending) | ☐ |
| 6 | Submitter gets 10pts after routing | ☐ |
| 7 | Reviewer sees lead in Pending Review | ☐ |
| 8 | Qualify → qualified, submitter +20pts | ☐ |
| 9 | Create Opportunity → +50pts | ☐ |
| 10 | Won → +100pts | ☐ |
| 11 | Dashboard pipeline total matches lead count | ☐ |
| 12 | Leaderboard scores correct | ☐ |
| 13 | No "approved" status visible anywhere in UI | ☐ |
| 14 | Reports not in sidebar | ☐ |
| 15 | Executive Organisation tab is read-only | ☐ |
| 16 | TypeScript: npx tsc --noEmit → 0 errors | ☐ |
