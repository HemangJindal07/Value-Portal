# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**TX Catalyst Value Portal** is a full-stack lead tracking and value management portal for TestingXperts. It captures, tracks, and measures business value generated at client accounts through lead submissions, multi-step approvals, and scoring. The app is currently in a test/demo state and not yet live in production.

## Development Commands

### Frontend (Next.js — `frontend/`)
```bash
npm run dev        # Dev server on http://localhost:3000
npm run build      # Production build
npm run lint       # ESLint
```

### Backend (FastAPI — `backend/`)
```bash
uvicorn app.main:app --reload   # Dev server on http://localhost:8000
# API docs: http://localhost:8000/docs
# Health:   http://localhost:8000/health
```

### Environment Setup
- **Frontend**: Copy `.env.example` to `.env.local`, fill in `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`, `NEXT_PUBLIC_API_URL`
- **Backend**: Copy `.env.example` to `.env`, fill in Supabase keys, `ANTHROPIC_API_KEY`, `RESEND_API_KEY`, and optionally SMTP and `CRON_SECRET`

## Architecture

### Tech Stack
- **Frontend**: Next.js (App Router), React 19, TypeScript, Tailwind CSS 4, shadcn/ui, Recharts
- **Backend**: FastAPI, Uvicorn, Supabase Python client, Anthropic Claude SDK
- **Database**: Supabase (PostgreSQL with RLS)
- **Auth**: Supabase Auth (email/password)
- **Email**: Resend API (primary) + SMTP Gmail fallback

### Request Flow
1. User authenticates via Supabase Auth → gets a JWT access token
2. Frontend stores token in Supabase session; `api()` helper in `frontend/src/lib/api.ts` injects `Authorization: Bearer <token>` on every request
3. Backend `get_current_user` dependency in `backend/app/dependencies.py` validates the token against Supabase and fetches the user's `profiles` row
4. `require_role(*roles)` wraps `get_current_user` for role-based endpoint protection

### Backend Structure (`backend/app/`)
- **`main.py`** — FastAPI app definition, all routers registered with `/api` prefix
- **`config.py`** — Pydantic `BaseSettings` loading from `.env`
- **`dependencies.py`** — Auth dependency injection (`get_current_user`, `require_role`)
- **`database/supabase.py`** — Two clients: `get_supabase_client()` (anon, respects RLS) and `get_supabase_admin()` (service-role, bypasses RLS). Use admin only for privileged operations.
- **`routers/`** — Endpoints by domain: `auth`, `accounts`, `leads`, `assignments`, `scoring`, `dashboard`, `notifications`, `stakeholders`, `vertical_routing`, `governance`, `uploads`, `ai`, `cron`
- **`schemas/`** — Pydantic request/response models (all validation lives here)
- **`services/`** — Business logic:
  - `routing_engine.py` — Multi-step approval chain; reads `account_stakeholders` ordered by `step_order`, advances to the next step on approval
  - `email_service.py` — Email on lead submit/approval/rejection; **currently in TEST MODE** (all emails go to `hemang.jindal@testingxperts.com`)
  - `scoring.py` — Awards points for routing (10), qualification (20), deal won (100), idea approved (25), idea implemented (50)
  - `ai_classifier.py` / `lead_classifier.py` — Calls Claude Haiku to categorize leads
  - `notification_service.py` — In-app notifications
  - `reminder_engine.py` — Cron escalation engine, exposed at `/api/cron/reminders` (requires `X-Cron-Secret` header)
  - `account_stakeholders_sync.py` — Auto-syncs DU/DH to `account_stakeholders` when an account is created/updated

### Frontend Structure (`frontend/src/`)
- **`app/(auth)/`** — Public pages: `login`, `register`
- **`app/(dashboard)/`** — Protected pages: `page.tsx` (dashboard), `accounts/`, `leads/`, `assignments/`, `leaderboard/`, `notifications/`, `admin/`
- **`lib/auth-context.tsx`** — Global auth state, `useAuth()` hook
- **`lib/api.ts`** — Fetch wrapper with bearer token; base URL from env or `window.__VALUE_PORTAL_API_URL__`
- **`lib/supabase/client.ts`** — Browser Supabase client
- **`types/index.ts`** — All TypeScript domain interfaces
- **`components/layout/`** — `app-sidebar.tsx` (role-based nav), `topbar.tsx` (notifications bell, logout)

### Lead Lifecycle
`submitted` → `routing_pending` (no stakeholders) or `under_review` → `qualified` → `won` / `lost`; or `rejected` / `dropped` at any step.

Background tasks fire on lead submit: routing assignment creation, AI classification, email notifications.

### Role-Based Access
| Role | Can Do |
|---|---|
| `delivery_manager` | Submit leads, view own leads |
| `sales` | View assigned leads |
| `practice_lead` | Review assigned leads |
| `executive` | View own submissions + assigned leads |
| `admin` | Full access, user management, stakeholder/routing config |

### Key Patterns
- UUIDs are normalized to lowercase strings in `routing_engine.py` via `_uuid_key()` for consistent Supabase joins
- Pydantic validation errors → HTTP 422 with field-level detail
- Background tasks (`BackgroundTasks`) used for routing, classification, email — these are async; re-read the DB to check results
- Points are deduplicated: same user + same submission + same event type = 1 award

## Pre-Production Checklist (DO NOT DEPLOY without these)
- Remove the `# TEST:` block and uncomment the `# PRODUCTION:` block in `backend/app/services/email_service.py`
- Replace all `TEST_OVERRIDE_EMAIL` references in `routing_engine.py` (4 spots)
- Restore role restriction on the `create_account` endpoint in `routers/accounts.py`
- Update `FRONTEND_URL` in backend `.env` to the Vercel URL
- Update `NEXT_PUBLIC_API_URL` in frontend `.env` to the Render URL
- Configure Supabase Auth Site URL and Redirect URLs for production domain
- Clean test data (leads with `TEST_DIRECT_INSERT`, `AUDIT` prefixes) from Supabase

## Test Credentials (Dev Only)
- Delivery Manager: `Syed@gmail.com` / `Syed@1`
- Executive: `Executive@gmail.com` / `Executive@1`
- Admin: `admin@test.com` / `Test@1234`

## Database Notes
- Supabase migrations are in `backend/supabase/migrations/` (numbered `001_`–`023_`)
- Use `get_supabase_admin()` only for operations that must bypass RLS (admin endpoints, system sync)
- `account_stakeholders.step_order` defines the approval chain order; gaps are allowed
- `vertical_routing` table provides org-wide fallback DU/DH when an account has no stakeholders configured
