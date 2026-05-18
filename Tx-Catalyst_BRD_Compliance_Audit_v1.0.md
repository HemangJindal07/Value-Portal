# Tx-Catalyst Value Portal — BRD Compliance Audit

| | |
|---|---|
| **Document Type** | BRD Compliance & Gap Analysis Audit |
| **Product** | Tx-Catalyst Value Portal (TestingXperts) |
| **Audit Version** | v1.0 |
| **Audit Date** | 2026-05-17 |
| **Auditor** | Testing Engineering (independent code + database review) |
| **Repository Branch** | `develop` |
| **BRDs Reviewed** | Tx-Catalyst User Specific BRD v1.0; Tx-Catalyst Admin BRD v1.0; Tx-Catalyst Leadership (Reviewer) BRD v1.0 |
| **Supporting Doc** | Test credentials.docx |
| **Method** | Static review of backend code, Pydantic schemas, routers, services, and Supabase migrations against documented BRD clauses. No code changed. No runtime assumptions made — every finding is traced to a file/line and a BRD clause. |

---

## 1. Executive Summary

The implemented application is **architecturally a different product** than the one the three BRDs describe.

- **BRDs describe:** a practice-area lead-routing portal — a lead's *Practice Area* statically determines its single Reviewer (Delivery Head).
- **Code implements:** an account-stakeholder sequential-approval portal — a lead's *Account* drives a multi-step `account_stakeholders` approval chain, with fallbacks to `vertical_routing` then `service_routing`.

Almost every routing, scoping, and notification gap stems from this single structural mismatch. After stakeholder review, the following baseline decisions were confirmed and this audit is adjusted accordingly:

| Decision Point | Ruling | Effect on Audit |
|---|---|---|
| Routing model conflict | **BRD is the source of truth** | Stakeholder-chain routing is a **DEFECT** to be replaced |
| Role model (3 BRD vs 5 code) | **Keep 5 roles**; `executive` = Reviewer | 5-role model **accepted**; removed from gap list |
| Value Ideas / AI classification / reminder cron | **Approved extra scope** | **Not defects**; removed from gap list |
| Email hard-coded to TEST MODE | **Report as unverifiable** | All email criteria marked **BLOCKED**, not pass/fail |

**Overall verdict:** Not production-ready against the BRDs. 9 defects (4 Critical), 2 blocked verification areas.

---

## 2. Architectural Mismatch (Root Cause)

| Concept | BRD Specifies | Code Implements |
|---|---|---|
| Routing key | Practice Area → fixed Reviewer | Account → `account_stakeholders` chain (DU → DH → …) → `vertical_routing` → `service_routing` |
| Roles | 3: User, Reviewer, Admin | 5: `user`, `sales`, `practice_lead`, `executive`, `admin` (accepted) |
| Client identity | Free-text/dropdown "Client Name" + "Client Type" on lead form | FK `account_id` to a separate `accounts` table; no `client_name`/`client_type` on lead |
| Approval flow | Single Reviewer: Qualified → Opportunity Identified → Won/Lost | Multi-step chain by `step_order`, then auto-created Stage-2 / Stage-3 assignments |

---

## 3. Defect Register

Severity: **Critical** (blocks core BRD workflow / data integrity / security) · **High** · **Medium**.

### D1 — Routing model does not match the Practice-Area matrix · Critical

- **BRD:** User §4.1, §6.2; Admin §13.1 — static matrix: QE→Manjeet, Data Engineering→Rajiv Diwan, Digital Engineering & AI→Vivek Gupta, Insurance→Yurvaj Singh, New Client→Adeesh Jain.
- **Code:** No routing-rules table and no practice-based routing. `routing_engine.py:380-393` walks `account_stakeholders` → `vertical_routing` → `service_routing`.
- **Impact:** Entire routing engine must be rebuilt around practice area. **Fails AC-02.**
- **Reference:** `backend/app/services/routing_engine.py:380-393`

### D2 — Points values are wrong · Critical

- **BRD:** User §5.6, Leadership §8.3, Admin §14.2 — Submitted +10, Approved/Qualified +20, **Opportunity Identified +20**, **Won +50** (cumulative 10→30→50→100).
- **Code:** Submitted +10 ✅, Qualified +20 ✅, **Opportunity Created +50** ❌, **Won +100** ❌ (cumulative 10→30→80→180). Incorrect figures are also written verbatim into user-facing emails.
- **Impact:** Wrong leaderboard, wrong reward numbers communicated to users in writing. **Fails AC-08, AC-09, AC-L16, AC-L17.**
- **Reference:** `backend/app/services/scoring.py:10-16`; `backend/app/services/email_service.py:576`, `:583`

### D3 — "CC Adeesh Jain on every lead" not implemented · Critical

- **BRD:** User §4.1 (note), AC-03; Admin AC-16, §15 — Adeesh receives portal + email for **every** lead submitted, portal-wide.
- **Code:** Adeesh is notified only for new-account leads without a service line; existing-account leads send Adeesh nothing. The email CC constant is a hard-coded test address, not Adeesh.
- **Impact:** Admin loses portal-wide oversight. **Fails AC-03, AC-16.**
- **Reference:** `backend/app/services/routing_engine.py:432-485`; `backend/app/services/email_service.py:23`

### D4 — Practice-area data scoping absent · Critical

- **BRD:** Leadership §10, AC-L23, AC-L24, NFR — server-side practice scoping; HTTP 403 on cross-practice access.
- **Code:** No `practice_area` column on `leads` or `profiles`. Reviewers are scoped by *assignment*, not practice.
- **Impact:** Cannot enforce or test practice isolation. **Fails AC-L23, AC-13.**
- **Reference:** `backend/app/routers/leads.py:60-79`

### D5 — Mandatory submission-form fields missing · High

- **BRD:** User §5.3 (#1 Client Name, #2 Client Type, #3 Practice Area); Leadership §5.1 (#8 Client Region, #9 Client Vertical), §4.6, AC-L06, AC-L07.
- **Code:** No `client_name` (only `account_id` FK), no `client_region`, no `client_vertical` on the lead. Region/Vertical dashboards source from `accounts` table, not the lead form as the BRD explicitly requires. Practice-area enum has 5 values vs the BRD's 4 (code splits "Digital Engineering" and "Artificial Intelligence" instead of the BRD's combined "Digital Engineering & AI").
- **Impact:** **Fails AC-L06, AC-L07; partial AC-01.**
- **Reference:** `backend/app/schemas/lead.py:41-53`; `backend/app/routers/dashboard.py:186-205`

### D6 — Admin module largely missing · High

| Admin BRD Feature | Clause | Status |
|---|---|---|
| Add User | §5.2, AC-A02 | ❌ No endpoint |
| Deactivate / Reactivate User | §5.4, AC-A04 | ❌ No endpoint (only generic PATCH on `is_active`) |
| Admin-triggered Reset Password (24h link) | §5.5 | ❌ Only self-service force-reset; no 24h expiry |
| Submit on behalf of another user | §6, AC-A05 | ❌ `create_lead` hard-sets submitter |
| Exception Queue | §11, AC-A07/A08 | ❌ Only a `routing_pending` count in analytics |
| Routing Config CRUD | §13, AC-A09/A10 | ❌ No rules table or endpoints |
| Stakeholder Mapping + Notification Opt-in | §12, AC-A11 | ⚠️ `account_stakeholders` auto-synced; no opt-in, no admin mapping API |
| Reviews — Re-assign / Override / Add Remark | §9.3, AC-A12 | ⚠️ Partial; no reason capture, no distinct override flow |
| Leaderboard filters / CSV export | §8.2, AC-A13 | ❌ Not present |
| Points Config | §14.2, AC-A14 | ❌ Points hard-coded |
| Practice-Area Management | §14.3 | ❌ Not present |
| Email Settings / kill switch / delivery logs | §14.4 | ❌ Not present |
| Audit Log viewer | §14.5, AC-A15 | ⚠️ `status_history` written but not exposed; only status changes logged, not user/config actions |

- **Impact:** **Fails AC-A02, A04, A05, A07–A11, A13–A15.**
- **Reference:** `backend/app/routers/users.py`; `backend/app/routers/leads.py:154`; `backend/app/routers/dashboard.py:258`

### D7 — Open self-service signup with self-assignable Reviewer role · High (Security + BRD)

- **BRD:** Admin §5.2 — only Admin creates accounts.
- **Code:** Public signup endpoint allows self-selecting `executive` (= Reviewer) — privilege self-escalation.
- **Reference:** `backend/app/routers/auth.py:11`, `:27-28`

### D8 — Lifecycle semantics differ · Medium-High

- **BRD:** Single reviewer drives 3a→4→5; "Under Review" set when reviewer **opens** the lead (Leadership §7.4, §13.1); term is "Opportunity **Identified**".
- **Code:** Multi-step stakeholder chain; `under_review` auto-set on routing; status named `opportunity_created`.
- **Reference:** `backend/app/services/routing_engine.py:541`, `:761-1009`

### D9 — Notification matrix gaps · Medium

- **BRD:** Admin §15 full matrix — Routing Config / Stakeholder Mapping / user-created / user-deactivated notifications; reviewer first-route email.
- **Code:** Dependent features absent (see D6); reviewer first-route email not guaranteed for stakeholder-chain leads.
- **Reference:** `backend/app/services/routing_engine.py:612`

---

## 4. Blocked Verification Areas

| Area | Reason | Status |
|---|---|---|
| All email acceptance criteria (AC-12, AC-L21, AC-16; full matrices User §5.7.2 / Leadership §9 / Admin §15) | `TEST_OVERRIDE_EMAIL` redirects every message to one address (`email_service.py:21-44`) | **BLOCKED** until removed — not pass, not fail |
| Practice-routing matrix end-to-end (AC-02) | BRD reviewers (Manjeet/Rajiv/Vivek/Yurvaj) not provisioned in `Test credentials.docx` | **BLOCKED** — cannot exercise even manually |

---

## 5. Accepted Items (No Action — per stakeholder ruling)

- 5-role model; `executive` = Reviewer; `sales` / `practice_lead` retained as intentional.
- Value Ideas module — approved extra scope.
- AI lead classification — approved extra scope.
- Reminder / escalation cron engine — approved extra scope.

---

## 6. Role Compliance Scorecard

| Role | Verdict | Open Defects | Blocked |
|---|---|---|---|
| **User (Delivery Team)** | Partial — core submit/track/leaderboard works | D2, D3, D5, D7 | Email |
| **Reviewer (`executive`)** | Diverges — review works via assignments | D1, D2, D4, D5, D8 | Email |
| **Admin** | Major gap | D3, D6, D7 | Email |

---

## 7. Recommended Remediation Order

| # | Defect | Rationale |
|---|---|---|
| 1 | **D2** Points values | Quick, isolated, high user-visible impact; corrects written communications |
| 2 | **D3** Adeesh CC on every lead | Restores admin oversight; moderate effort |
| 3 | **D1 + D4** Practice routing + scoping | Core structural rebuild; gates AC-02, AC-L23, AC-13; do together |
| 4 | **D5** Form fields (Client Name / Region / Vertical, practice enum) | Unblocks Leadership dashboards (AC-L06/07) |
| 5 | **D6** Admin module build-out | Large; sequence by acceptance-criteria priority |
| 6 | **D7** Lock down signup / Admin-only user creation | Security + BRD §5.2 |
| 7 | **D8 / D9** Lifecycle & notification alignment | After routing rebuild stabilizes |
| — | Remove `TEST_OVERRIDE_EMAIL` | Required before any email AC can be verified |

---

## 8. Acceptance Criteria Status Index

| AC | Source | Status |
|---|---|---|
| AC-02 Auto-Routing | User BRD | ❌ Fail (D1) / Blocked verification |
| AC-03 CC Notification | User BRD | ❌ Fail (D3) |
| AC-08 Points on Opportunity | User BRD | ❌ Fail (D2) |
| AC-09 Won/Lost Points | User BRD | ❌ Fail (D2) |
| AC-13 Role-Based Access | User BRD | ❌ Fail (D4) |
| AC-12 Email Notifications | User BRD | ⛔ Blocked |
| AC-L06 Leads by Region | Leadership BRD | ❌ Fail (D5) |
| AC-L07 Leads by Vertical | Leadership BRD | ❌ Fail (D5) |
| AC-L16 Opportunity Points | Leadership BRD | ❌ Fail (D2) |
| AC-L17 Won Points | Leadership BRD | ❌ Fail (D2) |
| AC-L21 Notifications email | Leadership BRD | ⛔ Blocked |
| AC-L23 Cross-Practice 403 | Leadership BRD | ❌ Fail (D4) |
| AC-A02 Add User | Admin BRD | ❌ Fail (D6) |
| AC-A04 Deactivate User | Admin BRD | ❌ Fail (D6) |
| AC-A05 Submit on Behalf | Admin BRD | ❌ Fail (D6) |
| AC-A07/A08 Exception Queue | Admin BRD | ❌ Fail (D6) |
| AC-A09/A10 Routing Config | Admin BRD | ❌ Fail (D6) |
| AC-A11 Stakeholder Mapping | Admin BRD | ❌ Fail (D6) |
| AC-A13 Leaderboard Filters/Export | Admin BRD | ❌ Fail (D6) |
| AC-A14 Points Config | Admin BRD | ❌ Fail (D6) |
| AC-A15 Audit Log | Admin BRD | ❌ Fail (D6) |
| AC-A16 Admin CC Notifications | Admin BRD | ❌ Fail (D3) |

---

*End of Document — Tx-Catalyst Value Portal BRD Compliance Audit v1.0. No code was modified during this audit. Every finding is traceable to a cited file/line and BRD clause.*
