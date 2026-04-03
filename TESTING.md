# Value Portal — Testing Cheat Sheet

> **Local URLs**
> - Frontend: http://localhost:3000
> - Backend API: http://localhost:8000
> - API Docs (Swagger): http://localhost:8000/docs
> - Supabase Dashboard: https://supabase.com/dashboard/project/osvfwzvpnkunttelskdi

---

## 1. Start Services

```bash
# Terminal 1 — Backend
cd backend
.\venv\Scripts\activate
uvicorn app.main:app --reload --port 8000

# Terminal 2 — Frontend
cd frontend
npm run dev
```

Verify backend is up: http://localhost:8000/health → should return `{"status":"ok"}`

---

## 2. Test Users to Create

Create one user per role so you can test all views.

| Full Name           | Email                           | Role after creation   |
|---------------------|---------------------------------|-----------------------|
| Anurag Admin        | admin@tx.com                    | `admin` (set manually in Supabase) |
| Eve Executive       | executive@tx.com                | `executive`           |
| Sara Sales          | sara@tx.com                     | `sales`               |
| Pete Practice       | pete@tx.com                     | `practice_lead`       |
| Dave Delivery       | dave@tx.com                     | `delivery_manager`    |

> **How to change role:** Supabase → Table Editor → `profiles` → find row → edit `role` field.
> All new registrations default to `delivery_manager`.

---

## 3. Registration & Login

### 3.1 Register a new user
1. Go to http://localhost:3000/register
2. Fill: Full Name, Email, Password (min 6 chars)
3. Click **Create Account**
4. Expected: redirected to dashboard, toast "Account created! You can now sign in."

### 3.2 Login
1. Go to http://localhost:3000/login
2. Enter credentials → **Sign In**
3. Expected: redirected to `/` (dashboard)

### 3.3 Wrong password
1. Login with wrong password
2. Expected: red toast error, stays on login page

---

## 4. Accounts

> Only `admin` can create accounts. All roles can view.

### 4.1 Create an account (as admin)
1. Sidebar → **Accounts** → **New Account**
2. Fill:
   - Account Name: `Acme Corp`
   - Industry: `Banking`
   - Region: `EMEA`
   - Contract Value: `500000`
   - Status: `Active`
3. Stakeholder Mapping section:
   - Delivery Head: search and select `Eve Executive`
   - Delivery Unit Manager: search and select `Pete Practice`
   - Sales Executive: search and select `Sara Sales`
4. Click **Create Account**
5. Expected: redirected to account detail page, all stakeholders shown

### 4.2 View account detail
1. Sidebar → **Accounts** → click `Acme Corp`
2. Expected: shows Account Information, Engagement Timeline, Stakeholder Routing chain

### 4.3 Edit account
1. Account detail → **Edit** button (admin only)
2. Change Contract Value → save
3. Expected: values update without page reload

---

## 5. Leads

### 5.1 Submit a lead (as delivery_manager / any role)
1. Sidebar → **Leads** → **New Lead**
2. Fill:
   - Title: `API Testing Automation for Acme`
   - Description: `Client wants end-to-end API testing automation`
   - Lead Type: `Current Lead`
   - Account: `Acme Corp`
   - Estimated Value: `75000`
   - Probability: `60`
   - Priority: `High`
   - Expected Close Date: 3 months from today
3. Click **Submit Lead**
4. Expected:
   - Toast: "Lead submitted successfully"
   - Redirected to leads list
   - Lead appears with status `submitted`
   - Assignments auto-created for Acme Corp's stakeholders (check `/assignments`)
   - Notifications sent to stakeholders (check `/notifications` as each stakeholder)

### 5.2 Check lead visibility by role
| Login as         | Expected on /leads                |
|------------------|-----------------------------------|
| `admin`          | All leads (heading: "All Leads")  |
| `executive`      | All leads                         |
| `sales`          | All leads                         |
| `practice_lead`  | Only their own submissions        |
| `delivery_manager` | Only their own submissions      |

### 5.3 Change lead status (as admin/executive/sales)
1. Leads → click lead → status dropdown → select `Qualified`
2. Click **Save**
3. Expected:
   - Toast: "Status changed to qualified"
   - Badge updates
   - Activity log shows the transition
   - Submitter gets a notification

### 5.4 Lead detail fields to verify
- Description card
- Details sidebar: Account, Submitted By, Estimated Value, Probability, Expected Close, Created
- AI Category + Confidence (if classified)
- Activity / comments section at bottom

### 5.5 Full status progression to test
```
submitted → under_review → qualified → won
submitted → under_review → lost
```

---

## 6. Value Ideas

### 6.1 Submit an idea (as delivery_manager / any role)
1. Sidebar → **Value Ideas** → **New Idea**
2. Fill:
   - Title: `Shift-Left Testing Framework`
   - Problem Statement: `Testing happens too late in the SDLC, causing costly rework`
   - Proposed Solution: `Implement automated unit and integration tests from sprint 1`
   - Category: `Automation`
   - Account: `Acme Corp`
   - Est. Saving: `120000`
   - Effort Level: `Medium`
   - Timeline: `3 months`
   - Impact Areas: `Quality, Cost`
   - Tools / Tech: `Selenium, Pytest`
3. Click **Submit Idea**
4. Expected:
   - Toast: "Idea submitted successfully"
   - Idea appears in list with status `submitted`
   - AI classification runs in background (wait 5–10s, refresh detail page)
   - AI Category + Summary + Confidence should populate on detail page

### 6.2 Watch AI classification
1. Open idea detail immediately after submit
2. Purple badge "Classifying with AI…" should show
3. Wait ~5s — AI fields auto-populate (polling every 3s)
4. Expected: AI Category, AI Summary, Confidence bar visible

### 6.3 Check idea visibility by role
| Login as         | Expected on /ideas                     |
|------------------|----------------------------------------|
| `admin`          | All ideas ("All Value Ideas")          |
| `executive`      | All ideas                              |
| `practice_lead`  | All ideas                              |
| `sales`          | Only their own ("My Value Ideas")      |
| `delivery_manager` | Only their own                       |

### 6.4 Full status progression to test
```
submitted → under_review → approved → in_progress → implemented
submitted → under_review → rejected
```

---

## 7. Assignments

### 7.1 View your assignments (as any stakeholder)
1. Sidebar → **My Assignments**
2. Tabs:
   - **My Submissions** — items you submitted
   - **Pending Review** — items assigned to you awaiting action
   - **Reviewed** — items you already acted on
   - **Organisation** — all assignments (admin/executive only)

### 7.2 Approve/Reject an assignment
1. Log in as `Eve Executive` (Delivery Head for Acme Corp)
2. My Assignments → **Pending Review** tab
3. Find the lead or idea submitted above
4. Click **Approve** or **Reject**
5. Expected:
   - Assignment moves to "Reviewed" tab
   - Submitter gets a notification
   - Next stakeholder in chain gets notified (DU Manager → Sales)

### 7.3 Escalate
1. On a pending assignment click **Escalate**
2. Expected: escalation notification sent, toast confirmation

---

## 8. Notifications

### 8.1 View notifications
1. Sidebar → **Notifications**
2. Tabs: **All** / **Unread**
3. Expected: notification cards with type badges (Reminder, Escalation, Status Update, Approval, Info)

### 8.2 Mark individual as read
1. Click **Mark Read** on an unread notification
2. Expected: card loses left red border, moves to "read" styling

### 8.3 Mark all read
1. **Mark All Read (n)** button top right
2. Expected: all notifications marked, unread count drops to 0

---

## 9. Leaderboard & Scoring

### Points awarded automatically:
| Action                     | Points |
|---------------------------|--------|
| Submit lead or idea        | 10     |
| Lead → Qualified           | 20     |
| Lead → Won                 | 100    |
| Idea → Approved            | 25     |
| Idea → Implemented         | 50     |

### 9.1 Check your score
1. Sidebar → **Leaderboard**
2. Your card: Rank, Total Points, Leads, Ideas, Deals Won
3. Table: all users ranked

### 9.2 Verify scoring
1. Submit a lead → check leaderboard → should +10 pts
2. Change lead to Qualified → +20 pts more
3. Change to Won → +100 pts more

---

## 10. Reports

### 10.1 Pipeline tab
1. Sidebar → **Reports** → **Pipeline** tab
2. Sub-tabs: **Leads** / **Value Ideas**
3. Expected: table showing Lead → Assigned To → Status → Outcome flow
4. `admin`/`executive` see "All Leads — Pipeline"; others see "My Leads — Pipeline"

### 10.2 My Report tab
1. **My Report** tab
2. Expected: KPI cards (My Leads, My Value Ideas, My Score, Pending Reviews)
3. My Lead Funnel + My Idea Funnel bar charts
4. My Recent Submissions table
5. Points Activity log

### 10.3 Export CSV
1. Reports → **Export CSV** button
2. Expected: CSV file downloads with your submissions data

---

## 11. Reviews (Admin / Executive only)

### 11.1 Access gate
- Log in as `delivery_manager` → go to `/reviews`
- Expected: "Access Restricted" screen with shield icon

### 11.2 Create a review cycle (as admin)
1. Sidebar → **Reviews** → **New Review Cycle**
2. Fill: Type `Monthly`, Period Label `April 2026`, Start/End dates, Notes
3. Click **Create Cycle**
4. Expected: cycle appears in table with status `planned`

### 11.3 Cycle lifecycle
1. Click **Start** → status changes to `active`
2. Click **Complete** → status changes to `completed`

---

## 12. Admin — User Management

1. Sidebar → **Admin** (bottom of System group)
2. Expected: table of all users with Name, Email, Role, Department, Status
3. Change role via dropdown (e.g. promote `dave@tx.com` to `practice_lead`)
4. Expected: role badge updates immediately

---

## 13. Admin — Stakeholder Mapping

> BRD §8.5 — maps the review chain per account

1. Sidebar → **Stakeholder Mapping**
2. Search and select `Acme Corp`
3. Expected: current routing chain shown (DH → DU → Sales)
4. Add a new reviewer: pick role label + user → **Add Reviewer**
5. Reorder with up/down arrows
6. Expected: chain saves automatically (Saving… indicator)

---

## 14. Admin — Routing Configuration

> BRD §8.6 — org-level fallback routing

1. Sidebar → **Routing Config**

### Vertical Routing tab
1. **Add Vertical** form: Vertical Name `Healthcare`, select DU Manager + DH
2. Click **Add Entry**
3. Expected: entry appears in table

### Region Sales tab
1. **Add Mapping** form: Region `US East`, select Sales Person, toggle Copy All if needed
2. Click **Add Entry**
3. Expected: entry appears in correct section

---

## 15. Admin — Exception Queue

> Shows all submissions stuck in `routing_pending`

1. Sidebar → **Exception Queue**
2. Expected: leads and ideas with no matching routing chain
3. Click **Fix Mapping** → navigates to Stakeholder Mapping for that account
4. Click **View** → opens the submission detail
5. After fixing mapping, re-submitting or changing status should resolve the pending state

---

## 16. Admin Dashboard Analytics

1. Log in as `admin` → Dashboard
2. Scroll below the activity feed to the **Analytics** section
3. Verify:
   - Qualification Rate % card
   - Win Rate % card (won ÷ closed)
   - Pipeline Value $ card
   - Exception Queue count card (links to `/admin/exception-queue`)
   - Leads by Region bar breakdown
   - Leads by Vertical bar breakdown
   - Top Accounts (Lead + Idea counts)
   - Reviewer Turnaround table (avg days per role, color-coded)

---

## 17. End-to-End Smoke Test (10 minutes)

Run this sequence in one session to verify the full workflow:

```
1.  Register dave@tx.com (delivery_manager)
2.  Register sara@tx.com (sales) — set role to sales in Supabase
3.  Register pete@tx.com — set role to practice_lead
4.  Register eve@tx.com — set role to executive
5.  Register admin@tx.com — set role to admin

6.  [admin] Create account: Acme Corp (EMEA, Banking)
             → Stakeholders: Eve (DH), Pete (DU), Sara (Sales)

7.  [dave]  Submit lead: "API Automation for Acme" → Current Lead, $75k, High
             → Verify: status=submitted, assignments created, notifications sent

8.  [eve]   My Assignments → Pending Review → Approve the lead
             → Verify: pete gets notified

9.  [pete]  My Assignments → Approve
             → Verify: sara gets notified

10. [sara]  My Assignments → Approve
             → Verify: lead status moves to next stage

11. [admin] Open lead → change status to Qualified → then Won
             → Verify: dave's leaderboard score increases

12. [dave]  Submit idea: "Shift-Left Testing" → Automation, $120k saving
             → Verify: AI classification auto-runs (watch the purple badge)

13. [pete]  My Assignments → Approve idea
             → Verify: idea moves to approved, dave gets notification

14. [admin] Dashboard → scroll to Analytics → verify all metrics populated
15. [admin] Reports → Pipeline tab → verify both lead and idea appear
16. [admin] Leaderboard → verify dave has points for submission + won deal
```

---

## 18. Common Issues & Fixes

| Symptom | Likely Cause | Fix |
|---------|-------------|-----|
| Lead stuck on `routing_pending` | No stakeholders set for account | Go to Stakeholder Mapping → assign DH/DU/Sales for that account |
| AI classification never appears | Anthropic API key missing | Check `backend/.env` → `ANTHROPIC_API_KEY` |
| Assignments not created | No stakeholders on account | Same as above |
| Login fails after register | Supabase email confirm enabled | Disable confirm in Supabase Auth settings (for dev) |
| 401 errors in console | Token expired | Log out and log back in |
| `Failed to fetch` errors | Backend not running | Start `uvicorn app.main:app --reload --port 8000` |
| Role not respected in UI | Role set incorrectly in DB | Check `profiles` table in Supabase, update `role` field |
| Points not updating | Score event already recorded | Same action only awards points once per user/submission |

---

## 19. Quick API Tests (Swagger)

Open http://localhost:8000/docs

1. **POST /api/auth/signin** — get a token
2. Paste token into **Authorize** (top right)
3. Test endpoints:
   - `GET /api/dashboard/stats` — org-wide KPIs
   - `GET /api/dashboard/admin-analytics` — full analytics payload
   - `GET /api/dashboard/pipeline` — pipeline flow data
   - `GET /api/scores/leaderboard` — all user scores
   - `GET /api/assignments/mine` — your assignments

---

*Last updated: April 2026 | Value Portal v0.1.0 | TestingXperts*
