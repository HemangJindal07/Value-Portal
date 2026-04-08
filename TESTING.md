# Value Portal — User Acceptance Testing Guide

> **Who this is for**: Anyone verifying the portal works correctly.
> No technical knowledge required. Just follow each step exactly as written.
>
> **Last updated**: April 2026

---

## What Is the Value Portal?

The Value Portal is an internal web application for TestingXperts delivery teams.
It lets team members submit **Leads** (potential sales opportunities) and **Value Ideas**
(improvement suggestions at client accounts). Managers and leadership can then review,
approve, and track the value these submissions create.

There are three types of users:
- **Delivery Manager / Sales / Practice Lead** — submits leads and ideas, sees their own data
- **Executive** — sees org-wide reports and analytics (read-only)
- **Admin** — full access: manages accounts, routing rules, users, and the system

---

## Before You Start

You will need:
- A laptop or desktop computer
- A web browser (Chrome or Edge recommended)
- The web address where the portal is running (ask your technical team)
  - Usually: **http://localhost:3000** (if running locally)
- Login credentials for at least three test accounts — one Admin, one Delivery Manager, one Executive
  - Ask your technical team for the test email addresses and passwords

> **Important**: Every time you see a checkbox like this — `[ ]` — tick it if the step passes.
> If something does NOT work as described, write a note next to that checkbox.

---

## Section 1 — Logging In

### Step 1.1 — Open the portal

1. Open your browser
2. Go to: **http://localhost:3000**
3. You should see a login page with the TestingXperts logo and a "Sign In" form

**Expected**: Login page appears. You do NOT land directly on a dashboard without logging in.

- [ ] Login page is visible
- [ ] TestingXperts logo is visible on the page

---

### Step 1.2 — Log in as Delivery Manager

1. Enter the **Delivery Manager** email and password
2. Click **Sign In**

**Expected**: You are taken to the dashboard. The page title should say something like
"Welcome back" with the user's name. The left sidebar should show:
- Dashboard
- Leads
- Value Ideas
- My Assignments
- Leaderboard
- My Score
- Reports
- Notifications

**NOT visible** (these should be hidden for this role):
- Accounts
- Stakeholder Mapping
- Routing Config
- Exception Queue
- Admin

- [ ] Logged in successfully
- [ ] Correct menu items visible (see list above)
- [ ] "Accounts", "Stakeholder Mapping", "Routing Config", "Exception Queue", "Admin" are NOT in the sidebar

---

### Step 1.3 — Log out

1. Look for a logout button — usually at the bottom of the sidebar or in the top-right corner
2. Click it
3. You should be returned to the login page

- [ ] Logged out successfully
- [ ] Returned to login page

---

### Step 1.4 — Log in as Executive

1. Enter the **Executive** email and password
2. Click **Sign In**

**Expected sidebar** (slightly different from Delivery Manager):
- Dashboard
- Leads
- Value Ideas
- My Assignments
- Leaderboard
- Reports
- Reviews
- Notifications

**NOT visible**:
- Stakeholder Mapping
- Routing Config
- Exception Queue
- Admin

- [ ] Logged in successfully
- [ ] "Reviews" appears in the sidebar (Delivery Manager does NOT have this)
- [ ] "Stakeholder Mapping", "Routing Config", "Exception Queue", "Admin" are NOT visible

Log out again when done.

---

### Step 1.5 — Log in as Admin

1. Enter the **Admin** email and password
2. Click **Sign In**

**Expected sidebar** — Admin sees everything:
- Dashboard, Accounts, Leads, Value Ideas, My Assignments
- Leaderboard, Reports, Reviews
- Notifications, **Exception Queue**, **Stakeholder Mapping**, **Routing Config**, **Admin**

- [ ] Logged in as Admin
- [ ] "Exception Queue", "Stakeholder Mapping", "Routing Config", "Admin" are all visible in the sidebar

Keep the Admin session open for the next sections.

---

## Section 2 — Dashboard (What Each Role Sees)

### Step 2.1 — Admin Dashboard

While logged in as Admin, click **Dashboard** in the sidebar (top item).

**Expected — the page should show all of the following**:

- [ ] Page heading says **"Admin Dashboard"** (or similar, with a red/dark badge)
- [ ] Four summary cards at the top: **Total Leads**, **Total Value Ideas**, **Total Accounts**, **Active Users** — each showing a number
- [ ] A **Lead Pipeline** bar chart (shows leads grouped by status like Submitted, Under Review, Qualified, Won)
- [ ] An **Ideas Pipeline** bar chart (same concept for ideas)
- [ ] A **Recent Activity** feed (list of actions taken across the system — not just your own)
- [ ] An **Analytics** section showing: Qualification Rate, Win Rate, Exception Queue count
- [ ] A **Reviewer Turnaround** table (shows how quickly each reviewer is acting on assignments)
- [ ] A **Region / Vertical / Top Accounts** breakdown section

---

### Step 2.2 — Executive Dashboard

Log out, then log back in as **Executive**.

Click **Dashboard**.

**Expected — should show**:
- [ ] Page heading says **"Executive Dashboard"** or has a "Leadership View" badge
- [ ] Org-wide pipeline charts (same as admin)
- [ ] Analytics section with qualification/win rates
- [ ] Recent activity feed

**Should NOT show**:
- [ ] No "Exception Queue fix" links or system admin controls
- [ ] No "Admin" system management section

Log out when done.

---

### Step 2.3 — User (Delivery Manager) Dashboard

Log in as **Delivery Manager**. Click **Dashboard**.

**Expected — should show ONLY personal data**:
- [ ] Cards say: **My Leads**, **My Value Ideas**, **Your Score**, **Pending Reviews** (your numbers only)
- [ ] Lead chart shows ONLY this user's leads
- [ ] Idea chart shows ONLY this user's ideas
- [ ] Quick action buttons: "Submit New Lead", "Submit Value Idea", "View My Assignments"

**Should NOT show**:
- [ ] No org-wide statistics
- [ ] No "Total Accounts" or "Active Users" cards

---

## Section 3 — Submitting a Lead

Stay logged in as **Delivery Manager**.

### Step 3.1 — Navigate to Submit New Lead

1. In the sidebar, click **Leads**
2. Look for a button like **"+ New Lead"** or **"Submit New Lead"** — click it
3. A form should open

- [ ] Form page opens with a title like "Submit New Lead"

---

### Step 3.2 — Fill in the Lead form

Fill in the following fields:

| Field | What to enter |
|-------|--------------|
| Title | `Test Lead April 2026` |
| Description | `This is a test lead for UAT purposes` |
| Lead Type | Select **"Current Lead"** from the dropdown |
| Account | Type at least 3 letters of an account name (e.g. "Tes") |
| Estimated Value | `50000` |
| Priority | Select any option |

**Account search test** (important):
- [ ] When you type 3 or more letters in the Account field, a dropdown list of matching accounts appears automatically
- [ ] You can click an account name from the dropdown to select it
- [ ] The account field fills in with your selection

---

### Step 3.3 — Test the Lead Type dropdown

Click the Lead Type dropdown.

- [ ] ONLY two options are visible: **"Current Lead"** and **"New Lead"**
- [ ] No other options (e.g. "New Service" or "Expansion") are present

Select **"Current Lead"** and continue.

---

### Step 3.4 — Test the file attachment (mandatory)

Scroll down to the **Supporting Document** section. This field is **required**.

**Test 1 — submit without a file**:
1. Do NOT attach any file yet
2. Scroll to the bottom and click **Submit**
3. **Expected**: An error message appears saying something like
   *"Please attach a supporting document before submitting"*
   The form does NOT submit.

- [ ] Error message appears when submitting without a file
- [ ] Form does not submit without a file

**Test 2 — attach a valid file**:
1. Click the upload area or "Click to upload" button
2. Choose any PDF, Word (.docx), or Excel (.xlsx) file from your computer (any size under 20MB)
3. **Expected**: The file name appears below the upload area, showing it was uploaded

- [ ] File name is shown after uploading
- [ ] A small "X" or remove button appears to delete the file if needed

**Test 3 — try an invalid file type** (optional):
1. Try uploading a `.exe` or `.bat` file
2. **Expected**: An error message appears rejecting the file type

- [ ] Invalid file type is rejected

---

### Step 3.5 — Submit the Lead

1. Make sure all required fields are filled and a file is attached
2. Click **Submit**
3. **Expected**: A green success message (toast notification) appears briefly
4. You should be taken back to the Leads list

- [ ] Success message appeared
- [ ] Redirected to Leads list
- [ ] The new lead `Test Lead April 2026` appears in the list
- [ ] The lead shows status **"Submitted"**

---

## Section 4 — Submitting a Value Idea

### Step 4.1 — Navigate to Submit New Idea

1. In the sidebar, click **Value Ideas**
2. Click the **"+ New Idea"** or **"Submit New Idea"** button

- [ ] Form opens with a title like "Submit Value Idea"

---

### Step 4.2 — Fill in the Idea form

| Field | What to enter |
|-------|--------------|
| Title | `Test Value Idea April 2026` |
| Problem Statement | `This is a test idea for UAT verification` |
| Category | Select any option from the dropdown |
| Impact Level | Select any option |
| Effort Level | Select any option |
| Account | Type 3+ letters to search and select an account |

- [ ] Account autosuggest works the same as in the Lead form (dropdown appears after 3 characters)

---

### Step 4.3 — Test the mandatory attachment (same as leads)

1. Try submitting WITHOUT a file
   - [ ] Error message appears — file is required

2. Attach a file, then submit
   - [ ] Success message appears
   - [ ] Redirected to Ideas list
   - [ ] New idea `Test Value Idea April 2026` appears in the list with status **"Submitted"**

---

## Section 5 — Notifications

### Step 5.1 — Check in-app notifications

After submitting a lead/idea, relevant reviewers receive a notification.

To test this:
1. Stay logged in as the **reviewer** (admin or the assigned stakeholder) — or switch accounts
2. Look at the top of the page (topbar) for a **bell icon**
3. **Expected**: A red number badge appears on the bell showing unread notifications

- [ ] Bell icon is visible in the topbar
- [ ] Unread badge count appears after a submission

---

### Step 5.2 — Read a notification

1. Click the bell icon
2. A notification panel or page opens
3. Notifications about the new lead/idea submission should appear

- [ ] Notification about the new submission appears
- [ ] Clicking a notification marks it as read (badge count decreases)

---

### Step 5.3 — Mark all as read

1. Look for a **"Mark All Read"** button in the notifications panel
2. Click it
3. **Expected**: Badge count goes to 0

- [ ] "Mark All Read" works — badge disappears or shows 0

---

## Section 6 — Assignments & Reviewing Submissions

When a lead or idea is submitted and an account has reviewers configured, those reviewers
receive an **assignment** — a task to review and decide on the submission.

### Step 6.1 — View pending assignments

1. Log in as a user who has been assigned a review (ask your admin which account has reviewers set up)
2. Click **My Assignments** in the sidebar
3. You should see a **"Pending Review"** tab and a **"Reviewed"** tab

- [ ] My Assignments page loads
- [ ] Pending Review tab shows any assignments waiting for action

---

### Step 6.2 — Check the aging color on assignment cards

Each assignment card has a **colored left border** indicating how old the assignment is:

| Border Color | Meaning |
|-------------|---------|
| Green | Assignment created 0–3 days ago (on time) |
| Amber/Yellow | Assignment created 4–7 days ago (getting late) |
| Red | Assignment created 7+ days ago (overdue) |

- [ ] Assignment cards show a colored left border
- [ ] A new assignment (just submitted) shows a **green** border

---

### Step 6.3 — Approve a submission (mandatory reason required)

1. In the **Pending Review** tab, click **Approve** on any assignment
2. A dialog box (popup) appears

**Check the dialog contains**:
- [ ] A decision section — for a **Lead** it shows: **"Qualified"** and **"Disqualified"** options
- [ ] For an **Idea** it shows: **"Approved"** and **"Rejected"** options
- [ ] A **Reason / Comments** text box (this is mandatory)
- [ ] The Submit/Confirm button is **greyed out (disabled)** until both a decision AND a reason are entered

**Test — reason is mandatory**:
1. Select a decision (e.g. "Qualified") but leave the reason blank
   - [ ] Submit button stays disabled

2. Type only 5 characters in the reason box
   - [ ] A character counter appears showing something like "5/10 min characters"
   - [ ] Submit button still stays disabled

3. Type at least 10 characters in the reason box (e.g. "Test reason for UAT")
   - [ ] Submit button becomes active (clickable)

4. Click the Submit/Confirm button
   - [ ] Success message appears
   - [ ] Assignment disappears from the **Pending Review** tab
   - [ ] Assignment now appears in the **Reviewed** tab with your decision and reason visible

---

### Step 6.4 — Reject a submission

Repeat Step 6.3 but choose the rejection option ("Disqualified" for leads, "Rejected" for ideas).

- [ ] Same mandatory reason requirement applies
- [ ] After rejection, submission status updates accordingly

---

## Section 7 — Admin: Stakeholder Mapping

This section is only accessible when logged in as **Admin**.

Stakeholder mapping controls **who reviews** submissions for each account —
and in what order.

### Step 7.1 — Open Stakeholder Mapping

1. Log in as Admin
2. In the sidebar under **System**, click **Stakeholder Mapping**

- [ ] Page loads with a title like "Stakeholder Mapping"
- [ ] There is an Account search/selector at the top

---

### Step 7.2 — Select an account

1. Click the account selector
2. Type 3+ letters of an account name
3. Select an account from the dropdown

- [ ] Matching accounts appear in the dropdown
- [ ] After selecting, the stakeholder list for that account loads below

---

### Step 7.3 — View the stakeholder chain

After selecting an account:

- [ ] A list of reviewers appears, showing each person's **name**, **role label**, and **step number** (the order they review)
- [ ] Step 1 is the first reviewer, Step 2 is second, and so on

If no reviewers are configured:
- [ ] A warning banner appears telling the admin that routing cannot happen for this account

---

### Step 7.4 — Add a new reviewer

1. Look for an **"Add Reviewer"** or **"+"** button
2. Click it — a small form appears
3. Search for a user by typing their name (3+ characters)
4. Enter a role label (e.g. "Delivery Head" or "Practice Lead")
5. Click **Add** or **Save**

- [ ] New reviewer appears in the list with the next step number
- [ ] No page refresh needed — the list updates instantly

---

### Step 7.5 — Reorder reviewers

1. Use the **Up** and **Down** arrows next to each reviewer to change the order
2. **Expected**: Step numbers update to reflect the new order

- [ ] Reordering works — step numbers change
- [ ] The order is saved (refresh the page to confirm the order persists)

---

### Step 7.6 — Remove a reviewer

1. Click the **delete** (trash/X) button next to a reviewer
2. **Expected**: Reviewer is removed from the list

- [ ] Reviewer removed successfully

---

## Section 8 — Admin: Routing Configuration

This section controls how submissions are automatically routed when an account
does not have specific stakeholders manually mapped.

### Step 8.1 — Open Routing Config

1. In the sidebar under **System**, click **Routing Config**
2. The page has two tabs: **Vertical Routing** and **Region Sales**

- [ ] Page loads with two tabs visible

---

### Step 8.2 — Vertical Routing tab

This maps each industry vertical (e.g. Banking, Insurance, Retail) to a **Delivery Unit (DU) head**
and a **Delivery Head (DH)**.

1. Click the **Vertical Routing** tab
2. You should see a table of industry verticals with assigned DU/DH users

- [ ] Table of vertical routing rules is visible
- [ ] Each row shows: Vertical Name, DU Head, DH Head

**Add a new vertical rule**:
1. Click **"+ Add"** or the add button
2. Enter a vertical name (e.g. "Retail")
3. Search and select a DU Head user
4. Search and select a DH Head user
5. Save

- [ ] New vertical rule appears in the table

---

### Step 8.3 — Region Sales tab

This maps geographic regions (e.g. UK, US) to the sales person responsible for that region.

1. Click the **Region Sales** tab
2. A table shows region → sales person mappings

- [ ] Region Sales table is visible

**Understanding "Copy All"**:
A "Copy All" entry (with no specific region) means that sales person is CC'd on every submission, regardless of region.

- [ ] At least one "Copy All" entry is visible (or can be added)

**Add a region mapping**:
1. Click **"+ Add"**
2. Enter a region name (e.g. "UK")
3. Search and select a sales person
4. Save

- [ ] New region → sales person mapping appears

---

## Section 9 — Admin: Exception Queue

When a lead or idea is submitted for an account that has **no routing configured**
(no stakeholders AND no matching vertical rule), it lands in the Exception Queue
instead of going to a reviewer.

### Step 9.1 — Open Exception Queue

1. In the sidebar under **System**, click **Exception Queue**
2. You should see two tabs: **Leads** and **Value Ideas**

- [ ] Page loads
- [ ] A count badge shows how many items are pending

---

### Step 9.2 — Verify an unrouted submission appears here

To test this, a lead/idea must have been submitted for an account with no routing setup.

- [ ] The lead/idea appears in the correct tab (Leads or Value Ideas)
- [ ] It shows the account name, industry, region, who submitted it, and when
- [ ] Status shows **"Routing Pending"**

---

### Step 9.3 — Fix the routing from the exception queue

1. Click the **"Fix Mapping"** button next to a pending item
2. **Expected**: You are taken directly to the Stakeholder Mapping page
   with that account pre-selected

- [ ] "Fix Mapping" button navigates to Stakeholder Mapping
- [ ] The correct account is already selected on the mapping page

---

## Section 10 — Reports

### Step 10.1 — Reports as Delivery Manager

1. Log in as **Delivery Manager**
2. Click **Reports** in the sidebar

**Expected — only personal data visible**:
- [ ] "My Lead Funnel" shows only this user's leads by status
- [ ] "My Idea Funnel" shows only this user's ideas by status
- [ ] "My Recent Submissions" table shows only entries submitted by this user
- [ ] "Points Activity" shows only this user's scoring history
- [ ] NO org-wide data visible

---

### Step 10.2 — Reports as Admin or Executive

1. Log in as **Admin** or **Executive**
2. Click **Reports**

**Expected — org-wide data visible**:
- [ ] Lead pipeline table shows ALL leads (across all users), with columns:
  Lead Title → Account → Lead Type → Submitter → Assignee → Status → Outcome
- [ ] Idea pipeline table shows ALL ideas
- [ ] Funnel percentage bars show what proportion reached each stage
- [ ] Reviewer turnaround table shows how quickly each reviewer acts (color coded):
  - Green = 0–2 days (fast)
  - Blue = 3–5 days (acceptable)
  - Red = 5+ days (slow)

---

### Step 10.3 — Check Lead Type filter in reports

1. Look for a filter on the reports page for **Lead Type**
2. Filter by "Current Lead"
   - [ ] Only "Current Lead" entries appear

3. Filter by "New Lead"
   - [ ] Only "New Lead" entries appear

---

## Section 11 — Leaderboard & Scoring

### Step 11.1 — Check the leaderboard

1. Click **Leaderboard** in the sidebar
2. A ranked list of users should appear, showing points and rank

- [ ] Leaderboard page loads
- [ ] Users are ranked with point totals visible
- [ ] The logged-in user's row is highlighted or easy to find

---

### Step 11.2 — Verify points are awarded

After completing actions, check the scoring:

| Action | Points Expected |
|--------|----------------|
| Submit a lead | +10 points |
| Submit an idea | +10 points |
| Lead marked as Qualified | +20 points |
| Lead marked as Won | +100 points |
| Idea marked as Approved | +25 points |
| Idea marked as Implemented | +50 points |

1. Note the current score of the Delivery Manager user
2. Submit a new lead (Section 3)
3. Return to Leaderboard and refresh
4. **Expected**: Score increased by 10 points

- [ ] Score increased after submitting a lead
- [ ] Score increased after a lead/idea status change (when tested)

---

## Section 12 — Email Notifications

> **Note**: Emails are in sandbox mode and may only be delivered to verified addresses.
> Check the **Resend dashboard** or ask your technical team to verify email logs.

When a lead or idea is submitted to an account in a specific region, an email is sent.
The expected recipients depend on the region:

| Region | Extra Email Recipient |
|--------|----------------------|
| UK | sahil.baquer@testingxperts.com |
| US | joe.underwood@testingxperts.com |
| Any region | adeesh.jain@testingxperts.com (always CC'd) |

- [ ] Submit a lead for a UK-region account
- [ ] Confirm (via Resend dashboard or email inbox) that email was attempted to the UK contact
- [ ] Confirm adeesh.jain@testingxperts.com is CC'd

---

## Section 13 — Reminder & Escalation (Technical Test)

> **This section requires a brief technical action. Ask your developer to help.**

The system automatically:
- Sends a **reminder** to any reviewer who has not acted on an assignment after **5 days**
- **Escalates** to a manager if the assignment is still pending after **7 days**

### Step 13.1 — Trigger the reminder check

Your developer will run this command:

```
POST http://localhost:8000/api/cron/reminders
```

(with an Admin token — your developer will handle this)

**Expected result**:
- [ ] If any assignments are 5–6 days old: reviewers receive a reminder notification
- [ ] If any assignments are 7+ days old: managers receive an escalation notification
- [ ] Assignments under 5 days old receive nothing

### Step 13.2 — Verify no duplicate notifications

Run the cron trigger a second time without resolving any assignments.

- [ ] No duplicate reminder or escalation notifications are created (each person gets each type only once per assignment)

---

## Section 14 — Brand & Visual Check

### Step 14.1 — Sidebar branding

Look at the left sidebar:

- [ ] **TestingXperts logo** (TX mark) appears at the top of the sidebar
- [ ] Text "Value Portal" and "TestingXperts" appears next to the logo
- [ ] The active/selected menu item is highlighted in **dark red** (#B12B35)

---

### Step 14.2 — Button colors

- [ ] Primary action buttons (e.g. "Submit", "Save", "Add") are **dark red / brand red**
- [ ] Cancel/secondary buttons are white with a red border or grey

---

### Step 14.3 — Dark mode toggle

1. Look for a light/dark mode toggle (usually in the topbar or sidebar footer)
2. Switch to dark mode
   - [ ] Page switches to dark theme
   - [ ] Brand red color is still visible on active items and buttons
3. Switch back to light mode
   - [ ] Page returns to light theme normally

---

## Section 15 — Access Control Verification

This section verifies that users cannot access pages they should not see.

### Step 15.1 — Delivery Manager cannot access admin pages

1. Log in as **Delivery Manager**
2. In the browser address bar, manually type: `http://localhost:3000/admin/users`
3. Press Enter

**Expected**: Either redirected to the dashboard, shown an "Access Denied" message, or shown an empty page — but NOT a working admin user management page.

- [ ] Delivery Manager cannot access `/admin/users`
- [ ] Same test for `/admin/stakeholder-mapping` — [ ] blocked
- [ ] Same test for `/admin/routing-config` — [ ] blocked
- [ ] Same test for `/admin/exception-queue` — [ ] blocked

---

### Step 15.2 — Executive cannot access admin pages

1. Log in as **Executive**
2. Manually navigate to `http://localhost:3000/admin/users`

- [ ] Executive cannot access admin management pages

---

## Quick Reference — Expected Sidebar by Role

| Menu Item | Delivery Manager | Executive | Admin |
|-----------|:---:|:---:|:---:|
| Dashboard | ✅ | ✅ | ✅ |
| Accounts | ❌ | ❌ | ✅ |
| Leads | ✅ | ✅ | ✅ |
| Value Ideas | ✅ | ✅ | ✅ |
| My Assignments | ✅ | ✅ | ✅ |
| Leaderboard | ✅ | ✅ | ✅ |
| My Score | ✅ | ❌ | ❌ |
| Reports | ✅ | ✅ | ✅ |
| Reviews | ❌ | ✅ | ✅ |
| Notifications | ✅ | ✅ | ✅ |
| Exception Queue | ❌ | ❌ | ✅ |
| Stakeholder Mapping | ❌ | ❌ | ✅ |
| Routing Config | ❌ | ❌ | ✅ |
| Admin | ❌ | ❌ | ✅ |

---

## Quick Reference — Dashboard by Role

| What I See on Dashboard | Delivery Manager | Executive | Admin |
|-------------------------|:---:|:---:|:---:|
| My personal leads count | ✅ | ❌ | ❌ |
| My personal ideas count | ✅ | ❌ | ❌ |
| My personal score | ✅ | Optional | Optional |
| Org-wide total leads | ❌ | ✅ | ✅ |
| Org-wide total ideas | ❌ | ✅ | ✅ |
| Total accounts | ❌ | ✅ | ✅ |
| Active users | ❌ | ✅ | ✅ |
| Lead pipeline chart (org) | ❌ | ✅ | ✅ |
| Reviewer turnaround table | ❌ | ✅ | ✅ |
| Exception queue link | ❌ | ❌ | ✅ |
| Recent activity (all users) | ❌ | ✅ | ✅ |
| Recent activity (own only) | ✅ | ❌ | ❌ |

---

## What to Do If Something Is Not Working

| Problem | What to try |
|---------|-------------|
| Page is blank or shows an error | Refresh the browser (F5). If still broken, tell your developer. |
| Cannot log in | Double-check the email and password. Copy-paste to avoid typos. |
| Sidebar shows wrong menu items | Log out completely and log back in — the role may not have loaded. |
| Form won't submit | Check all required fields are filled. Look for red error text under any field. |
| File upload fails | Make sure the file is under 20MB and is a PDF, Word, Excel, or image file. |
| No notifications appearing | Make sure the backend is running. Ask your developer to check. |
| Numbers on dashboard show 0 | There may be no data yet. Submit a test lead and refresh. |

---

## Sign-Off Checklist

Use this as your final sign-off checklist. All items must pass before going live.

### Authentication
- [ ] Login works for all three roles
- [ ] Logout works
- [ ] Unauthenticated access is blocked

### Role-Based Navigation
- [ ] Delivery Manager sees correct sidebar (no admin items)
- [ ] Executive sees correct sidebar (no admin items, has Reviews)
- [ ] Admin sees full sidebar

### Dashboard
- [ ] Admin dashboard shows org-wide data + system controls
- [ ] Executive dashboard shows org-wide data (no system controls)
- [ ] User dashboard shows only personal data

### Lead Submission
- [ ] Form loads correctly
- [ ] Account autosuggest works (3+ characters triggers dropdown)
- [ ] Lead Type shows only "Current Lead" and "New Lead"
- [ ] File attachment is mandatory (form blocked without file)
- [ ] Valid file uploads successfully
- [ ] Invalid file type is rejected
- [ ] Submission succeeds and appears in list

### Idea Submission
- [ ] Same file attachment requirement as leads
- [ ] Submission succeeds and appears in list

### Assignments & Reviews
- [ ] Reviewer sees assignment in My Assignments
- [ ] Aging color border is visible on assignment cards (green/amber/red)
- [ ] Approve/Reject dialog opens with correct decision labels
- [ ] Reason field is mandatory (min 10 characters)
- [ ] Submit button disabled until reason is filled
- [ ] Decision recorded and assignment moves to Reviewed tab

### Admin Functions
- [ ] Stakeholder Mapping: add, reorder, delete reviewers
- [ ] Routing Config: vertical routing rules work
- [ ] Routing Config: region sales mappings work
- [ ] Exception Queue: shows unrouted submissions
- [ ] Exception Queue: "Fix Mapping" navigates correctly

### Notifications
- [ ] Bell icon shows unread count
- [ ] Notifications appear after submission and review actions
- [ ] Mark as read works
- [ ] Mark all read works

### Reports
- [ ] User reports show only personal data
- [ ] Admin/Executive reports show org-wide data with pipeline flow
- [ ] Lead type filter works

### Leaderboard & Scoring
- [ ] Leaderboard shows ranked users
- [ ] Submitting a lead awards +10 points

### Brand & Visual
- [ ] TestingXperts logo visible in sidebar
- [ ] Brand red color used for active states and primary buttons
- [ ] Dark mode toggle works

---

*If all boxes above are checked, the Value Portal is ready for use.*
*Any unchecked items should be raised with the development team before go-live.*
