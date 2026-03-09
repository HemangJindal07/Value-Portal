# Value Portal — Product Guide

**Version**: 1.0  
**Date**: March 2026  
**Prepared by**: Engineering Team

---

## 1. What is Value Portal?

Value Portal is an enterprise platform that enables delivery teams to **capture, track, and measure the business value** they generate at client accounts. It bridges the gap between delivery execution and business outcomes by turning everyday observations into tracked revenue opportunities and innovation ideas.

**In simple terms**: When a delivery team member spots an opportunity to help a client save money, grow revenue, or improve efficiency — Value Portal captures that insight, routes it to the right stakeholders, tracks its progress, and measures its impact.

---

## 2. Who Uses It?

| Role | What They Do |
|------|-------------|
| **Delivery Manager** | Submits leads and value ideas from the field |
| **Sales** | Reviews and qualifies leads, manages pipeline |
| **Practice Lead** | Evaluates ideas for technical feasibility |
| **Executive** | Views dashboards, runs governance reviews |
| **Admin** | Manages users, accounts, system configuration |

---

## 3. Core Workflow (How It Works)

```
  Delivery Manager              System                    Reviewers
  ─────────────────      ─────────────────────      ─────────────────
        │                        │                         │
   1. Spots opportunity          │                         │
        │                        │                         │
   2. Submits lead/idea ───────► 3. AI classifies it       │
        │                     4. Auto-assigns to ────────► 5. Reviews & acts
        │                     5. Awards points             │
        │                        │                    6. Updates status
        │                   7. Sends notification ◄────────┤
        │                   8. Records in history          │
   9. Sees progress              │                         │
  10. Earns leaderboard rank     │                         │
```

---

## 4. The 12 Modules

### Module 1: Authentication & User Management

Secure login system with role-based access control.

- **Email/Password** registration and login
- **5 roles**: Delivery Manager, Sales, Practice Lead, Executive, Admin
- Role determines what you can see and do across the platform
- User profiles with department and account assignments

**Key screens**: Login page, Registration page, User profile dropdown

---

### Module 2: Account & Client Master

Central directory of all client accounts with assigned stakeholders.

- Create and manage client accounts with industry, region, and contract details
- Assign **Account Owner**, **Sales Lead**, and **Practice Leader** per account
- These stakeholders automatically receive assignments when submissions come in
- Track engagement periods and contract values

**Key screens**: Account list, Account creation form, Account detail page

---

### Module 3: Lead Submission

Capture revenue opportunities spotted by delivery teams.

- Submit leads with title, description, estimated value, and probability
- **4 lead types**: Cross-sell, Upsell, New Service, Expansion
- **7 status stages**: Draft → Submitted → Under Review → Qualified → Won / Lost / Dropped
- **3 priority levels**: High, Medium, Low
- Track expected close date and currency

**Key screens**: Lead list (with filters), New lead form, Lead detail page with status control

---

### Module 4: Value Idea Submission

Capture innovation and improvement ideas from delivery teams.

- Submit ideas with problem statement, proposed solution, and estimated savings
- **6 categories**: Automation, Cost Optimization, Efficiency, Risk Reduction, Innovation, Process Improvement
- **7 status stages**: Draft → Submitted → Under Review → Approved → In Progress → Implemented / Rejected
- **3 effort levels**: Low, Medium, High
- Tag impact areas and tools/technologies involved

**Key screens**: Idea list, New idea form, Idea detail page with AI classification card and status control

---

### Module 5: Assignment Engine

Automatic routing of submissions to the right reviewers.

- When a lead or idea is submitted, the system **automatically creates assignments** for all stakeholders on that account
- Each assignment has a **7-day due date**
- Assigned roles: Account Owner, Sales Lead, Practice Leader
- Reviewers can mark assignments as: Pending → Reviewed → Approved → Rejected → Escalated
- **In-app notification** sent to each assignee

**Key screens**: My Assignments page (with Pending / Reviewed / Organisation tabs)

---

### Module 6: Notifications & Reminders

Keep everyone informed and accountable.

- **In-app notifications** with bell icon badge showing unread count
- Notification types:
  - **Status Update**: "Your lead status changed from submitted to qualified"
  - **Approval**: "You have been assigned to review a lead"
  - **Reminder**: "Lead has been pending for 5 days" (auto-generated at 3+ days)
  - **Escalation**: "Idea has been pending for 8 days and requires attention" (7+ days, sent to admins)
- Mark individual or all notifications as read
- Tabs: All / Unread

**Key screens**: Notifications page, Bell icon with unread badge in top bar

---

### Module 7: Status Tracking & Comments

Full audit trail of every submission's journey.

- **Status History**: Every status change is recorded with who made it and when
- **Comments**: Team members can add comments to any submission
- Internal comments for reviewer-only discussions
- Activity feed on each lead and idea detail page

**Key screens**: Activity section on lead/idea detail pages (timeline of status changes + comments)

---

### Module 8: Value Scoring

Gamification engine that rewards contributions with points.

| Action | Points |
|--------|--------|
| Submit a lead or idea | **10 pts** |
| Lead reaches "Qualified" | **20 pts** |
| Idea gets "Approved" | **25 pts** |
| Idea reaches "Implemented" | **50 pts** |
| Lead status "Won" | **100 pts** |

- Points are awarded automatically — no manual intervention needed
- Duplicate awards are prevented (same event + same submission = one award)
- Running totals maintained per user

---

### Module 9: Leaderboard

Competitive rankings to drive engagement.

- **Your Stats Dashboard**: Personal rank, total points, leads submitted, ideas submitted, deals won
- **All-Time Rankings Table**: Shows all users ranked by total points
  - Gold / Silver / Bronze icons for top 3
  - "You" badge highlighting your row
  - Role, department, and breakdown columns
- Ranks recompute automatically after every point award

**Key screens**: Leaderboard page with personal stats cards + rankings table

---

### Module 10: AI Classification (Powered by Claude)

Automatic categorization and summarization of submissions using AI.

**For Ideas:**
- AI reads the problem statement, solution, and context
- Returns: **AI Category** (e.g., "Cost Optimization"), **AI Summary** (2-3 sentence plain-English analysis), **AI Confidence** (0-100%)
- Shown on the idea detail page with a confidence bar
- Live polling: classification appears within seconds of submission

**For Leads:**
- AI reads the title, description, estimated value, and probability
- Returns: **AI Category** (e.g., "Cross-sell", "Strategic Partnership"), **AI Confidence**
- Shown on the lead detail page

**Manual re-trigger**: Admins can re-classify any submission via the API

---

### Module 11: Dashboards & Reports

Real-time analytics and exportable reports.

**Dashboard (Home Page):**
- **Top-line KPIs**: Total Leads, Value Ideas, Pipeline Value, Your Score
- **Secondary metrics**: Accounts, Active Users, Pending Reviews, Total Savings
- **Lead Pipeline**: Breakdown of leads by status
- **Recent Activity**: Live feed of status changes across the platform

**Reports Page:**
- Summary cards: Total Leads, Total Ideas, Revenue Influenced, Cost Savings
- **Lead Funnel**: Visual progress bars showing conversion through stages
- **Idea Funnel**: Same visualization for ideas
- **Impact Measurements Table**: Verified business outcomes
- **CSV Export**: One-click download of all metrics

**Key screens**: Dashboard home, Reports page

---

### Module 12: Governance & Reviews

Structured review cycles for accountability and impact measurement.

- **Review Cycles**: Monthly or quarterly governance reviews
  - Create cycles with period label, date range, and notes
  - Move through stages: Planned → In Progress → Completed
  - Track number of submissions reviewed per cycle
  - Role-gated: only Admins and Executives can manage cycles
- **Impact Measurements**: Record actual business outcomes
  - Revenue influenced, cost saved, efficiency gains
  - Verification status (Pending / Verified)
  - Linked to specific leads and ideas

**Key screens**: Reviews page with create dialog + cycle management table

---

## 5. Technology Stack

| Layer | Technology | Purpose |
|-------|-----------|---------|
| Frontend | Next.js 16 + React | Fast, modern web interface |
| Styling | Tailwind CSS + shadcn/ui | Professional, responsive design |
| Backend | FastAPI (Python) | High-performance REST API |
| Database | PostgreSQL via Supabase | Hosted database with built-in auth |
| AI | Claude (Anthropic) | Intelligent classification & summarization |
| Auth | Supabase Auth | Secure email/password authentication |
| Theme | Dark/Light mode toggle | User preference support |

---

## 6. Security Features

- **Row-Level Security (RLS)**: Database-level access control — users can only access data they're authorized to see
- **JWT Authentication**: Every API call is authenticated with a secure token
- **Role-Based Access Control**: Actions are restricted based on user roles
- **Audit Trail**: Every status change is logged with who did it and when

---

## 7. Key Metrics Value Portal Tracks

| Metric | Description |
|--------|-------------|
| Pipeline Value | Sum of estimated values of active leads |
| Won Value | Revenue from leads marked as "Won" |
| Total Savings | Sum of estimated savings from implemented ideas |
| Revenue Influenced | Measured actual revenue impact from impact assessments |
| Cost Saved | Measured actual cost savings from impact assessments |
| Submission Count | Total leads and ideas submitted |
| Conversion Rate | Leads that progress from submitted → qualified → won |
| Implementation Rate | Ideas that progress from submitted → approved → implemented |
| Average Response Time | How quickly reviewers act on assignments |
| User Engagement | Points, rankings, and submission frequency |

---

## 8. Quick Demo Script (5-minute walkthrough)

1. **Login** → Show the login page and dashboard
2. **Create Account** → "Acme Corp" with stakeholders assigned
3. **Submit a Lead** → "Cloud Migration Opportunity" worth $250K
4. **Show AI in action** → Idea auto-classified within seconds
5. **Assignment Queue** → Show how reviewers get notified automatically
6. **Change Status** → Move lead through Submitted → Qualified → Won
7. **Notifications** → Show bell icon update and notification page
8. **Leaderboard** → Points awarded, rank updated
9. **Dashboard** → All metrics update in real-time
10. **Export** → Download CSV report

---

## 9. Business Value Proposition

### For Delivery Teams
- Easy way to surface opportunities they see on the ground
- Gamification (points + leaderboard) makes it engaging
- Visibility into what happens after they submit

### For Sales Teams
- Pipeline of pre-qualified leads from people closest to the client
- AI-powered categorization saves triage time
- Structured handoff with all context preserved

### For Leadership
- Real-time visibility into the value generated by delivery teams
- Governance cycles ensure nothing falls through the cracks
- Impact measurement ties delivery work to business outcomes
- Data-driven reports for board reviews and client QBRs

### ROI Indicators
- **Increased cross-sell/upsell** from delivery-sourced leads
- **Cost savings** from implemented value ideas
- **Faster response time** through automated assignment and escalation
- **Higher engagement** through gamification and recognition
- **Better governance** through structured review cycles

---

*For questions or a live demo, contact the Engineering Team.*
