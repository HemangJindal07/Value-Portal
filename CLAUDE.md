# CLAUDE.md — Value Portal Project Context

This file is the single source of truth for AI assistants working on this codebase.
Read this before making any changes.

---

## 1. Project Overview

**Product Name**: Value Portal (internally also called "Idea Portal")
**Company**: TestingXperts (www.TestingXperts.com)
**Tagline**: "Passion For Perfection"
**Purpose**: A centralized platform for delivery teams to capture, track, and measure the business value (leads + ideas) they generate at client accounts.

---

## 2. Tech Stack

| Layer | Technology | Version | Notes |
|-------|-----------|---------|-------|
| Frontend | Next.js | 16 (App Router) | `frontend/` directory |
| Styling | Tailwind CSS + shadcn/ui | latest | CSS vars in `globals.css` |
| Backend | FastAPI (Python) | latest | `backend/` directory |
| Database | PostgreSQL via Supabase | — | hosted at osvfwzvpnkunttelskdi.supabase.co |
| Auth | Supabase Auth | — | JWT-based, used in middleware |
| AI | Anthropic Claude API | claude-3-haiku-20240307 | idea + lead classification |
| Notifications | In-app (notifications table) | — | Resend email not yet integrated |
| Deployment | Vercel (frontend) + Render (backend) | — | not yet deployed |

---

## 3. Project Structure

```
value-portal/
├── frontend/                     # Next.js 16 app
│   └── src/
│       ├── app/
│       │   ├── (auth)/           # login, register pages
│       │   └── (dashboard)/      # all protected pages
│       │       ├── page.tsx      # dashboard home
│       │       ├── accounts/
│       │       ├── leads/
│       │       ├── ideas/
│       │       ├── assignments/
│       │       ├── notifications/
│       │       ├── leaderboard/
│       │       ├── reports/
│       │       └── reviews/
│       ├── components/
│       │   ├── layout/           # topbar, app-sidebar
│       │   ├── ui/               # shadcn components
│       │   ├── activity-section.tsx
│       │   ├── theme-provider.tsx
│       │   └── theme-toggle.tsx
│       ├── lib/
│       │   ├── api.ts            # fetch wrapper for FastAPI
│       │   ├── auth-context.tsx  # AuthProvider + useAuth
│       │   └── supabase/         # client, server, middleware
│       └── types/index.ts        # all TypeScript interfaces
│
└── backend/                      # FastAPI Python app
    ├── app/
    │   ├── main.py               # FastAPI app + all routers
    │   ├── config.py             # Pydantic settings from .env
    │   ├── dependencies.py       # get_current_user, require_role
    │   ├── database/supabase.py  # supabase client helpers
    │   ├── routers/
    │   │   ├── auth.py
    │   │   ├── accounts.py
    │   │   ├── users.py
    │   │   ├── leads.py
    │   │   ├── ideas.py
    │   │   ├── assignments.py
    │   │   ├── tracking.py
    │   │   ├── notifications.py
    │   │   ├── ai.py
    │   │   ├── scoring.py
    │   │   ├── dashboard.py
    │   │   └── governance.py
    │   ├── schemas/              # Pydantic models per entity
    │   └── services/
    │       ├── ai_classifier.py      # Claude idea classification
    │       ├── lead_classifier.py    # Claude lead classification
    │       ├── assignment_engine.py  # auto-assign on submit
    │       ├── notification_service.py
    │       ├── reminder_engine.py    # cron-based reminders
    │       ├── scoring.py            # points engine
    │       └── tracking.py          # status history
    └── supabase/migrations/
        ├── 001_profiles.sql
        ├── 002_accounts.sql
        ├── 003_leads.sql
        ├── 004_ideas.sql
        ├── 005_assignments.sql
        ├── 006_tracking.sql
        ├── 007_notifications.sql
        ├── 008_scoring.sql
        └── 009_dashboards_governance.sql
```

---

## 4. User Roles & Permissions

| Role | Key Permissions |
|------|----------------|
| `admin` | Full access: user mgmt, account creation, all data, routing config |
| `executive` | Read all data, governance, reporting, update cycles |
| `sales` | Create/manage leads, view accounts |
| `practice_lead` | Review ideas, update idea status, manage assignments |
| `delivery_manager` | Submit leads and ideas (default role on registration) |

- Roles enforced in backend via `require_role()` dependency
- Frontend hides/shows UI based on `user.role` from `useAuth()`

---

## 5. Brand Guidelines (TestingXperts)

### Primary Colors

| Token | Hex | Usage |
|-------|-----|-------|
| Brand Red | `#B12B35` | Primary brand color, hero sections, active states |
| Brand Black | `#232222` | Sidebar, nav, dark backgrounds |
| Navy Blue | `#003466` | Charts, secondary headers, data viz |
| Mid Grey | `#5D5D5D` | Subtext, muted foreground |
| Light Cream | `#EDE7E6` | Page backgrounds, card fills |

### Secondary Colors

| Token | Hex | Usage |
|-------|-----|-------|
| Accent Blue | `#2E75B6` | Links, highlights, info states |
| Bright Red | `#E42525` | CTA buttons hover, alert states |
| Light Grey | `#C5C5C5` | Dividers, disabled states |
| Off White | `#F9F9F9` | Page backgrounds, input fills |

### Typography

- **Website font**: `Inter` (Light / Regular / Medium / Semibold / Bold)
- Already correctly configured in the app as default shadcn/Next.js font.

### Heading Scale

| Heading | Size |
|---------|------|
| H1 | 60px |
| H2 | 46px |
| H3 | 36px |
| H4 | 24px |
| H5 | 20px |
| Body | 14–16px |

### Button Style

- Primary: solid `#B12B35` background, white text
- Secondary/outline: white background, `#B12B35` border + text
- CTA sizes: small (14px), medium (16px), large (18px)

### Logo

- TestingXperts TX mark — must appear in sidebar header and login page
- Clear space: 0.5x logo width on all sides
- White version on dark/red backgrounds; color version on white/light

### Current UI vs Brand

- Primary color is currently generic dark (shadcn default) — needs `#B12B35`
- Logo not yet placed in the app
- Rest of the design (Inter font, card layouts, light/dark toggle) is consistent

---

## 6. Database Schema Summary

### Key Tables

| Table | Primary Key | Notes |
|-------|------------|-------|
| `profiles` | `id` (= auth.uid) | auto-created on signup via trigger |
| `accounts` | `account_id` | stakeholder IDs: owner/sales/practice |
| `leads` | `lead_id` | has `ai_category`, `ai_confidence` |
| `value_ideas` | `idea_id` | has `ai_category`, `ai_summary`, `ai_confidence` |
| `assignments` | `assignment_id` | auto-created by assignment_engine |
| `status_history` | `history_id` | every status change logged |
| `comments` | `comment_id` | threaded per submission |
| `notifications` | `notification_id` | in-app, with read/unread |
| `escalation_rules` | `rule_id` | trigger_days + escalate_to_role |
| `score_events` | `event_id` | per-event points log |
| `user_scores` | `score_id` | aggregated totals + rank |
| `leaderboard_entries` | `entry_id` | periodic snapshots |
| `dashboard_metrics` | `metric_id` | precomputed KPIs |
| `review_cycles` | `cycle_id` | monthly/quarterly governance |
| `impact_measurements` | `impact_id` | actual revenue/savings |

### RLS Policy Pattern
All tables have RLS enabled. Common patterns:
- `auth.uid()` for ownership checks
- role checks via `select 1 from profiles where id = auth.uid() and role in (...)`

---

## 7. Key API Endpoints

### Backend base: `http://localhost:8000`

| Method | Path | Notes |
|--------|------|-------|
| GET | `/health` | health check |
| POST | `/api/auth/signup` | register |
| POST | `/api/auth/signin` | login |
| GET | `/api/auth/me` | current user profile |
| GET/POST | `/api/accounts` | list / create |
| GET/PATCH | `/api/accounts/:id` | detail / update |
| GET/POST | `/api/leads` | list / create |
| GET/PATCH | `/api/leads/:id` | detail / update status |
| GET/POST | `/api/ideas` | list / create |
| GET/PATCH | `/api/ideas/:id` | detail / update status |
| GET | `/api/assignments` | my assignments |
| PATCH | `/api/assignments/:id` | update action/notes |
| GET | `/api/notifications` | list notifications |
| GET | `/api/notifications/count` | unread count |
| PATCH | `/api/notifications/read` | mark read |
| PATCH | `/api/notifications/read-all` | mark all read |
| POST | `/api/ai/classify/idea/:id` | manual reclassify |
| POST | `/api/ai/classify/lead/:id` | manual reclassify |
| GET | `/api/scores/me` | my score |
| GET | `/api/scores/leaderboard` | all rankings |
| GET | `/api/dashboard/stats` | aggregate stats |
| GET | `/api/dashboard/recent-activity` | activity feed |
| GET/POST | `/api/governance/review-cycles` | list / create |
| POST | `/api/cron/reminders` | trigger reminder check |

---

## 8. Environment Variables

### Frontend (`frontend/.env.local`)
```
NEXT_PUBLIC_SUPABASE_URL=https://osvfwzvpnkunttelskdi.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=<anon_key>
NEXT_PUBLIC_API_URL=http://localhost:8000
```

### Backend (`backend/.env`)
```
SUPABASE_URL=https://osvfwzvpnkunttelskdi.supabase.co
SUPABASE_ANON_KEY=<anon_key>
SUPABASE_SERVICE_ROLE_KEY=<service_role_key>
ANTHROPIC_API_KEY=<claude_api_key>
RESEND_API_KEY=<not yet set>
FRONTEND_URL=http://localhost:3000
ENVIRONMENT=development
```

---

## 9. Scoring / Points System

| Event | Points |
|-------|--------|
| Submit lead or idea | 10 |
| Lead → Qualified | 20 |
| Lead → Won | 100 |
| Idea → Approved | 25 |
| Idea → Implemented | 50 |

- Deduplication: same user + same submission + same event = 1 award
- Ranks recomputed after every award

---

## 10. Auto-Assignment Logic

When a lead or idea is submitted:
1. Look up account by `account_id`
2. Find stakeholders: `account_owner_id`, `sales_lead_id`, `practice_leader_id`
3. Create one `assignment` row per non-null stakeholder
4. Set `due_date = now() + 7 days`
5. Send in-app notification to each assignee
6. If no stakeholders found → log warning, no assignment created (known gap — see section 11)

---

## 11. Known Gaps vs BRD (Pending Implementation)

These are confirmed missing requirements from the BRD. Do NOT mark them as done until implemented:

| # | Gap | BRD Section | Priority |
|---|-----|------------|---------|
| 1 | Stakeholder mapping UI (admin screen) | 8.5 | P0 |
| 2 | Routing: DU → DH → Sales-by-region + copy stakeholder | 8.6 | P0 |
| 3 | Configurable sales mapping by geography/region | 8.6 | P0 |
| 4 | Vertical coverage in routing | 8.6 | P1 |
| 5 | Fallback logic: "Routing Pending" status + exception queue | 8.7 | P0 |
| 6 | Admin exception queue for unresolved routing | 8.7 | P1 |
| 7 | ~~Email integration via Resend~~ ✅ DONE — sandbox FROM until domain verified | 8.9 | P0 |
| 8 | Mandatory attachment for Value Idea submission | 8.4 | P1 |
| 9 | Account name predictive search / autosuggest | 8.3 | P1 |
| 10 | Lead type taxonomy: "Current Lead" / "New Lead" | 8.4 | P1 |
| 11 | Apply TestingXperts brand colors to UI | 8.2 | P1 |
| 12 | Role-based UI visibility (hide unauthorized nav items) | 8.1 | P1 |
| 13 | Flow-based report view (Lead → Assigned To → Status → Win/Loss) | 8.10 | P2 |
| 14 | Salesforce integration for Value Ideas + sales owner sync | External | P2 |

---

## 12. Running Locally

### Frontend
```bash
cd value-portal/frontend
npm install
npm run dev
# runs on http://localhost:3000
```

### Backend
```bash
cd value-portal/backend
.\venv\Scripts\activate          # Windows
# or: source venv/bin/activate   # Mac/Linux
uvicorn app.main:app --reload --port 8000
# runs on http://localhost:8000
```

### Verify
- Backend health: `http://localhost:8000/health`
- API docs: `http://localhost:8000/docs`
- Frontend: `http://localhost:3000`

---

## 13. Deployment Plan

| Service | Provider | Cost |
|---------|---------|------|
| Frontend | Vercel (free tier) | $0 |
| Backend | Render ($7/mo always-on) | $7/mo |
| Database + Auth | Supabase (free tier) | $0 |
| AI Classification | Anthropic (pay per use) | ~$0.25/1M tokens |

After deploy:
- Set `FRONTEND_URL` in Render env vars to Vercel URL
- Set `NEXT_PUBLIC_API_URL` in Vercel env vars to Render URL
- Update Supabase Auth → URL Configuration → Site URL + Redirect URLs

---

## 14. Code Conventions

- **TypeScript** everywhere in frontend. No `any` types.
- All API calls go through `src/lib/api.ts` (typed fetch wrapper)
- All types live in `src/types/index.ts`
- Use `useAuth()` hook for token + user in client components
- Backend: use `get_supabase_admin()` for service-role queries, `get_current_user` dep for auth
- Background tasks use FastAPI `BackgroundTasks` (do not block response)
- All status changes must call `record_status_change()` + `notify_status_change()` + `award_points()` where applicable
- Never expose service role key to frontend
- `.env` and `.env.local` are gitignored — never commit secrets
