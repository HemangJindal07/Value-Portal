# Value Portal — Testing Guide

**Version**: 1.0  
**Date**: March 2026  
**Purpose**: Step-by-step instructions to test the complete happy flow of Value Portal

---

## Prerequisites

### 1. Start the Servers

Open **two terminals**:

**Terminal 1 — Frontend (Next.js):**
```bash
cd value-portal/frontend
npm run dev
```
Frontend runs at: `http://localhost:3000`

**Terminal 2 — Backend (FastAPI):**
```bash
cd value-portal/backend
.\venv\Scripts\activate
uvicorn app.main:app --reload --port 8000
```
Backend runs at: `http://localhost:8000`

### 2. Verify Backend is Running

Open browser → `http://localhost:8000/health`

**Expected response:**
```json
{"status": "healthy", "version": "0.1.0"}
```

### 3. Verify Frontend is Running

Open browser → `http://localhost:3000`

**Expected**: Redirects to login page

---

## Test 1: User Registration & Login (Module 1)

### 1.1 Register Admin User

1. Open `http://localhost:3000/register`
2. Fill in:
   - **Full Name**: `Anurag Admin`
   - **Email**: `admin@test.com`
   - **Password**: `Test@1234`
3. Click **Create account**
4. You should be redirected to the Dashboard

> **Note**: If you hit a "rate limit exceeded" error, go to **Supabase Dashboard → Authentication → Users → Add User** and create the user with **"Auto Confirm User"** checked.

### 1.2 Promote to Admin Role

Go to **Supabase Dashboard → SQL Editor** and run:
```sql
UPDATE profiles SET role = 'admin' WHERE email = 'admin@test.com';
```

### 1.3 Verify Admin Role

1. Log out (click avatar in top-right → **Log out**)
2. Log back in with `admin@test.com` / `Test@1234`
3. Click the avatar dropdown

**Expected**: Role badge shows **"Admin"**

### 1.4 Register a Second User (Delivery Manager)

1. Log out
2. Go to `http://localhost:3000/register`
3. Fill in:
   - **Full Name**: `Ravi DM`
   - **Email**: `ravi@test.com`
   - **Password**: `Test@1234`
4. Click **Create account**

**Expected**: Dashboard loads. Avatar shows "RD". Role badge shows **"Delivery Manager"**.

| # | Check | Expected | Pass? |
|---|-------|----------|-------|
| 1 | Register a new user | Dashboard loads after signup | ☐ |
| 2 | Login works | Dashboard loads with user info | ☐ |
| 3 | Logout works | Redirects to login page | ☐ |
| 4 | Role shows correctly | Badge in avatar dropdown matches | ☐ |

---

## Test 2: Create an Account (Module 2)

Log in as **admin@test.com**

1. Click **Accounts** in the sidebar
2. Click **New Account**
3. Fill in:
   - **Account Name**: `Acme Corp`
   - **Industry**: `Technology`
   - **Region**: `North America`
   - **Status**: `Active`
   - **Account Owner**: Select `Anurag Admin`
   - **Sales Lead**: Select `Anurag Admin`
   - **Practice Leader**: Select `Anurag Admin`
   - **Contract Value**: `500000`
   - **Engagement Start**: `2026-01-01`
   - **Engagement End**: `2026-12-31`
4. Click **Create Account**
5. Click on the account name in the list to open detail page

| # | Check | Expected | Pass? |
|---|-------|----------|-------|
| 1 | Account created | Appears in the accounts list | ☐ |
| 2 | Detail page loads | Shows all fields correctly | ☐ |
| 3 | Stakeholders assigned | Owner, Sales, Practice leader shown | ☐ |

> **Important**: Assigning stakeholders is critical — without them, the auto-assignment engine won't create reviewer assignments when leads/ideas are submitted.

---

## Test 3: Submit a Lead (Module 3)

Log out. Log in as **ravi@test.com**

1. Click **Leads** in the sidebar
2. Click **New Lead**
3. Fill in:
   - **Title**: `Cloud Migration Opportunity`
   - **Description**: `Client wants to migrate 20 legacy apps to AWS. Estimated 8-month engagement with potential for managed services follow-on.`
   - **Lead Type**: `Upsell`
   - **Account**: `Acme Corp`
   - **Estimated Value**: `250000`
   - **Probability**: `70`
   - **Priority**: `High`
4. Click **Submit Lead**
5. You are redirected to the leads list

### Verify in Backend Terminal

Watch the backend terminal output. You should see:
```
[ASSIGN] ✅ Created X assignment(s) for lead ...
[AI] 🔍 Starting classification for lead ...
[AI] ✅ Classification complete for lead ...
```

### Verify on Frontend

1. Click on the lead title in the list
2. Check the detail page

| # | Check | Expected | Pass? |
|---|-------|----------|-------|
| 1 | Lead created | Shows in list with "Submitted" status | ☐ |
| 2 | Detail page | Title, description, value, priority all correct | ☐ |
| 3 | AI classification | AI Category and AI Confidence appear (may take 5-10 seconds) | ☐ |
| 4 | Backend logs | Assignment + AI classification logs visible | ☐ |

---

## Test 4: Submit a Value Idea (Module 4)

Still logged in as **ravi@test.com**

1. Click **Ideas** in the sidebar
2. Click **New Idea**
3. Fill in:
   - **Title**: `Automated Deployment Pipeline`
   - **Problem Statement**: `Manual deployments take 4 hours each and are error-prone. Last quarter had 3 failed deployments causing downtime.`
   - **Proposed Solution**: `Implement CI/CD pipeline using GitHub Actions with Terraform for infrastructure-as-code. Estimated to reduce deployment time to 15 minutes.`
   - **Category**: `Automation`
   - **Account**: `Acme Corp`
   - **Estimated Saving**: `50000`
   - **Effort Level**: `Medium`
   - **Impact Areas**: `DevOps, Engineering`
   - **Tools / Tech**: `GitHub Actions, Terraform`
4. Click **Submit Idea**

### Verify on Detail Page

1. Click on the idea in the list
2. Wait 5-10 seconds — you should see:
   - A spinning **"Classifying with AI..."** badge
   - Then the **AI Classification card** appears with category, summary, and confidence bar

| # | Check | Expected | Pass? |
|---|-------|----------|-------|
| 1 | Idea created | Shows in list with "Submitted" status | ☐ |
| 2 | AI polling | "Classifying with AI..." spinner appears | ☐ |
| 3 | AI result | AI Category, AI Summary, Confidence bar populate | ☐ |
| 4 | Detail fields | Problem, solution, savings, effort all correct | ☐ |

---

## Test 5: Check Assignments (Module 5)

Log out. Log in as **admin@test.com**

1. Click **Assignments** in the sidebar
2. You should see **2 pending assignments**:
   - One for the lead: `Cloud Migration Opportunity`
   - One for the idea: `Automated Deployment Pipeline`
3. Each shows: submission type, title, your assigned role, due date (7 days out)

### Act on an Assignment

1. On the lead assignment, click **Review** (or the action button)
2. Set action to **Reviewed**
3. Add notes: `Looks promising, scheduling client call`
4. Save

| # | Check | Expected | Pass? |
|---|-------|----------|-------|
| 1 | Assignments auto-created | 2 assignments visible for admin | ☐ |
| 2 | Assignment details | Shows title, type, role, due date | ☐ |
| 3 | Review action | Status changes from Pending to Reviewed | ☐ |

---

## Test 6: Change Lead Status (Modules 7 + 6 + 8)

Still logged in as **admin@test.com**

1. Go to **Leads** → click on `Cloud Migration Opportunity`
2. Find the **"Change Status"** dropdown bar below the title
3. Change status: select **`under_review`** → click **Save**
4. Success toast: "Status changed to under review"
5. Change status: select **`qualified`** → click **Save**
6. Change status: select **`won`** → click **Save**

### What Happens Behind the Scenes

Each status change triggers:
- **Status history recorded** (Module 7)
- **Notification sent** to `ravi@test.com` (Module 6)
- **Points awarded** to Ravi (Module 8):
  - Qualified = 20 pts
  - Won = 100 pts

| # | Check | Expected | Pass? |
|---|-------|----------|-------|
| 1 | Status → Under Review | Badge updates, toast appears | ☐ |
| 2 | Status → Qualified | Badge updates, toast appears | ☐ |
| 3 | Status → Won | Badge updates, toast appears | ☐ |
| 4 | Backend logs | No errors in terminal | ☐ |

---

## Test 7: Change Idea Status (Modules 7 + 6 + 8)

Still logged in as **admin@test.com**

1. Go to **Ideas** → click on `Automated Deployment Pipeline`
2. Use the **"Change Status"** dropdown:
   - `submitted` → `under_review` → **Save**
   - `under_review` → `approved` → **Save**
   - `approved` → `implemented` → **Save**

### Points Awarded to Ravi

| Transition | Points |
|-----------|--------|
| Approved | +25 pts |
| Implemented | +50 pts |

| # | Check | Expected | Pass? |
|---|-------|----------|-------|
| 1 | Status → Under Review | Badge updates | ☐ |
| 2 | Status → Approved | Badge updates | ☐ |
| 3 | Status → Implemented | Badge updates | ☐ |

---

## Test 8: Verify Notifications (Module 6)

Log out. Log in as **ravi@test.com**

1. Look at the **bell icon** in the top-right bar
2. It should show a **red badge** with the unread count (should be 6+)
3. Click the bell icon → **Notifications page** opens
4. Verify you see notifications like:
   - `"You have been assigned to review a lead: Cloud Migration Opportunity"`
   - `"You have been assigned to review an idea: Automated Deployment Pipeline"`
   - `"Your lead 'Cloud Migration Opportunity' status changed from submitted to under_review"`
   - `"Your lead 'Cloud Migration Opportunity' status changed from under_review to qualified"`
   - `"Your lead 'Cloud Migration Opportunity' status changed from qualified to won"`
   - Similar notifications for the idea
5. Click **Mark read** on one notification → it fades out
6. Click **Mark all read** → all notifications marked, bell badge disappears
7. Switch to **Unread** tab → shows "No unread notifications"

| # | Check | Expected | Pass? |
|---|-------|----------|-------|
| 1 | Bell icon badge | Shows unread count (red number) | ☐ |
| 2 | Notification list | Shows all expected notifications | ☐ |
| 3 | Notification types | Assignment, status update types shown | ☐ |
| 4 | Mark individual read | Notification fades, count decreases | ☐ |
| 5 | Mark all read | All cleared, badge disappears | ☐ |
| 6 | Unread tab | Shows correct filtered count | ☐ |

---

## Test 9: Leaderboard & Scoring (Modules 8 + 9)

Still logged in as **ravi@test.com**

1. Click **Leaderboard** in the sidebar
2. Check **Your Stats** cards at the top:

| Card | Expected Value |
|------|---------------|
| Your Rank | #1 |
| Total Points | **215** (10+10+20+100+25+50) |
| Leads | 1 |
| Ideas | 1 |
| Deals Won | 1 |

3. Check the **All-Time Rankings** table:
   - Ravi should be at **#1** with a **gold trophy** icon
   - Your row should be highlighted with a **"You"** badge

### Points Breakdown

| Action | Points |
|--------|--------|
| Submitted lead | 10 |
| Submitted idea | 10 |
| Lead qualified | 20 |
| Lead won | 100 |
| Idea approved | 25 |
| Idea implemented | 50 |
| **Total** | **215** |

| # | Check | Expected | Pass? |
|---|-------|----------|-------|
| 1 | Your Rank card | Shows #1 | ☐ |
| 2 | Total Points card | Shows 215 | ☐ |
| 3 | Leads/Ideas/Deals cards | Show 1/1/1 | ☐ |
| 4 | Rankings table | Ravi at #1 with gold trophy | ☐ |
| 5 | "You" badge | Highlighted on your row | ☐ |

---

## Test 10: Dashboard (Module 11)

1. Click **Dashboard** (home icon) in the sidebar
2. Verify the **top KPI cards**:

| Card | Expected |
|------|----------|
| Total Leads | 1 |
| Value Ideas | 1 |
| Pipeline Value | $0 (lead is "Won", so not in pipeline) |
| Your Score | 215 |

3. Verify **secondary metrics**:

| Card | Expected |
|------|----------|
| Accounts | 1 |
| Active Users | 2 |
| Pending Reviews | 0 or 1 (depending on assignment status) |
| Total Savings | $50,000 (from implemented idea) |

4. **Lead Pipeline** card — shows breakdown by status (1 Won)
5. **Recent Activity** card — shows all status transitions made in Tests 6 & 7

| # | Check | Expected | Pass? |
|---|-------|----------|-------|
| 1 | KPI cards | Numbers match test data | ☐ |
| 2 | Secondary metrics | Accounts=1, Users=2 | ☐ |
| 3 | Lead pipeline | Status breakdown visible | ☐ |
| 4 | Recent activity | Timeline of changes | ☐ |
| 5 | Clickable cards | Lead/Idea cards link to list pages | ☐ |

---

## Test 11: Reports (Module 11)

1. Click **Reports** in the sidebar
2. Verify summary cards:
   - Total Leads: 1
   - Total Ideas: 1
   - Revenue Influenced: based on won lead value
   - Cost Savings: $50,000
3. Check **Lead Funnel** — progress bar breakdown by status
4. Check **Idea Funnel** — progress bar breakdown by status
5. Click **Export CSV** button
6. A CSV file downloads with all metrics

| # | Check | Expected | Pass? |
|---|-------|----------|-------|
| 1 | Summary cards | Values match test data | ☐ |
| 2 | Lead funnel | Progress bars with percentages | ☐ |
| 3 | Idea funnel | Progress bars with percentages | ☐ |
| 4 | CSV export | File downloads, opens in Excel | ☐ |

---

## Test 12: Governance Reviews (Module 12)

Log out. Log in as **admin@test.com**

1. Click **Reviews** in the sidebar
2. Click **New Review Cycle**
3. Fill in:
   - **Type**: `Monthly`
   - **Period Label**: `March 2026`
   - **Start Date**: `2026-03-01`
   - **End Date**: `2026-03-31`
   - **Notes**: `First governance review cycle`
4. Click **Create Cycle**
5. Cycle appears in the table with status **"Planned"**
6. Click **Start** → status changes to **"In Progress"**
7. Click **Complete** → status changes to **"Completed"**

| # | Check | Expected | Pass? |
|---|-------|----------|-------|
| 1 | Create cycle | Appears in table as "Planned" | ☐ |
| 2 | Start cycle | Status changes to "In Progress" | ☐ |
| 3 | Complete cycle | Status changes to "Completed" | ☐ |
| 4 | Non-admin view | Start/Complete buttons hidden for DM role | ☐ |

---

## Test 13: Theme Toggle

1. Look at the top bar, next to the bell icon
2. Click the **sun/moon icon** to toggle between **light** and **dark** mode
3. All pages should switch theme correctly

| # | Check | Expected | Pass? |
|---|-------|----------|-------|
| 1 | Toggle to dark | Entire UI switches to dark theme | ☐ |
| 2 | Toggle to light | Entire UI switches to light theme | ☐ |
| 3 | Persists on reload | Theme stays after page refresh | ☐ |

---

## Test 14: AI Classification — Manual Re-trigger (Module 10)

This test is **API-only** (no UI button yet).

1. Get a lead ID from the lead detail page URL (e.g., `http://localhost:3000/leads/abc-123-...`)
2. Get your auth token from browser DevTools:
   - Open DevTools (F12) → **Application** → **Local Storage**
   - Look for key starting with `sb-` → find `access_token` in the value
3. Use Postman or curl:

```bash
curl -X POST http://localhost:8000/api/ai/classify/lead/{lead_id} \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**Expected response:**
```json
{"status": "classification_queued", "lead_id": "abc-123-..."}
```

4. Check the lead detail page — AI fields should update

---

## Test 15: Reminder Cron (Module 6)

1. To simulate an overdue assignment, run in **Supabase SQL Editor**:
   ```sql
   UPDATE assignments
   SET created_at = now() - interval '4 days'
   WHERE action_taken = 'pending'
   LIMIT 1;
   ```

2. Trigger the reminder check:
   ```bash
   curl -X POST http://localhost:8000/api/cron/reminders
   ```

3. **Expected response:**
   ```json
   {"status": "ok", "reminders_sent": 1, "escalations_sent": 0}
   ```

4. Log in as the assigned user → check **Notifications** → you should see a reminder

For escalation testing, backdate to 8+ days:
   ```sql
   UPDATE assignments
   SET created_at = now() - interval '8 days'
   WHERE action_taken = 'pending'
   LIMIT 1;
   ```
Then re-run the cron endpoint. Admins should receive escalation notifications.

---

## Summary Checklist

| Test # | Module(s) | Description | Pass? |
|--------|----------|-------------|-------|
| 1 | M1 | Register, login, logout, roles | ☐ |
| 2 | M2 | Create account with stakeholders | ☐ |
| 3 | M3 | Submit a lead | ☐ |
| 4 | M4 | Submit a value idea | ☐ |
| 5 | M5 | Verify auto-assignments | ☐ |
| 6 | M3+M7+M8 | Change lead status (track + score) | ☐ |
| 7 | M4+M7+M8 | Change idea status (track + score) | ☐ |
| 8 | M6 | Notifications: bell badge, list, mark read | ☐ |
| 9 | M8+M9 | Leaderboard: points, rank, table | ☐ |
| 10 | M11 | Dashboard: live stats, activity feed | ☐ |
| 11 | M11 | Reports: funnels, CSV export | ☐ |
| 12 | M12 | Governance: create/start/complete cycle | ☐ |
| 13 | — | Theme toggle (dark/light) | ☐ |
| 14 | M10 | AI manual re-classification | ☐ |
| 15 | M6 | Reminder/escalation cron | ☐ |

---

## Troubleshooting

| Issue | Solution |
|-------|---------|
| "Rate limit exceeded" on signup | Create users directly in Supabase Dashboard → Auth → Users → Add User (check "Auto Confirm") |
| "No stakeholders found" on submit | Update the account in Supabase to set `account_owner_id`, `sales_lead_id`, `practice_leader_id` |
| "Role not authorized" (403) | Run `UPDATE profiles SET role = 'admin' WHERE email = 'admin@test.com';` in Supabase SQL |
| AI classification not appearing | Check `ANTHROPIC_API_KEY` is set in `backend/.env` — look at backend terminal for `[AI]` logs |
| Notifications bell always 0 | Make sure the `notifications` table exists (run migration 007) and status changes are being made |
| Leaderboard shows 0 points | Make sure `score_events` and `user_scores` tables exist (run migration 008) |
| Reviews page "Failed to load" | Make sure `review_cycles` table exists (run migration 009) |
| Backend won't start | Check `backend/.env` has all keys set — run `pip install -r requirements.txt` in venv |
| Frontend won't start | Run `npm install` in `frontend/` directory |

---

*Document prepared for testing by the QA and Marketing teams.*
