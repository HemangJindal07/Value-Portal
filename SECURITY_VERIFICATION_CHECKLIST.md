# Security Fixes Verification Checklist
**VAPT Report Date:** 28 April 2026  
**Fixes Applied:** 29 April 2026  
**Total Vulnerabilities:** 8 (1 High, 3 Medium, 2 Low, 2 Informational)

> **How to use this file:** Start both servers, then go through each section top-to-bottom.  
> Mark each checkbox `[x]` as you confirm it passes. If any step fails, see the "Expected Result" — that tells you what the fix should have done.

---

## Pre-Requisite: Start Both Servers

```bash
# Terminal 1 — Backend
cd backend
uvicorn app.main:app --reload
# Running at http://localhost:8000

# Terminal 2 — Frontend
cd frontend
npm run dev
# Running at http://localhost:3000
```

Have two browser tabs ready:
- **Tab A** — logged in as `Syed@gmail.com` / `Syed@1` (role: delivery_manager)
- **Tab B** — logged in as `admin@test.com` / `Test@1234` (role: admin)

---

## VULN 2.1 — Improper Authorization / Insufficient Access Control (HIGH)
**Fix applied in:** `backend/app/routers/accounts.py`, `backend/app/routers/users.py`, `frontend/src/lib/supabase/middleware.ts`

### Test A — Admin page blocked for delivery_manager (URL manipulation)
1. In **Tab A** (Syed / delivery_manager), open the browser address bar
2. Type: `http://localhost:3000/admin/users` and press Enter
3. **Expected:** You are immediately redirected back to `http://localhost:3000/` (dashboard). The User Management page never loads.
4. [x] PASS / [ ] FAIL

### Test B — Stakeholder Mapping blocked for delivery_manager
1. In **Tab A**, type: `http://localhost:3000/admin/stakeholder-mapping` and press Enter
2. **Expected:** Redirected to `/` (dashboard). Page never loads.
3. [x] PASS / [ ] FAIL

### Test C — Routing Config blocked for delivery_manager
1. In **Tab A**, type: `http://localhost:3000/admin/routing-config` and press Enter
2. **Expected:** Redirected to `/` (dashboard).
3. [x] PASS / [ ] FAIL

### Test D — New Account page blocked for delivery_manager
1. In **Tab A**, type: `http://localhost:3000/accounts/new` and press Enter
2. **Expected:** Redirected to `/` (dashboard). Account creation form never loads.
3. [x] PASS / [ ] FAIL

### Test E — Admin can still access all pages (regression check)
1. In **Tab B** (admin@test.com), navigate to `http://localhost:3000/admin/users`
2. **Expected:** User Management page loads normally.
3. [x] PASS / [ ] FAIL

### Test F — Backend rejects account creation from delivery_manager (API level)
Open browser DevTools → Network tab, or use curl/Postman:
```bash
# 1. Get token — login as Syed
curl -s -X POST http://localhost:8000/api/auth/signin \
  -H "Content-Type: application/json" \
  -d '{"email":"Syed@gmail.com","password":"Syed@1"}' | grep access_token

# 2. Try to create an account using that token (replace TOKEN below)
curl -s -X POST http://localhost:8000/api/accounts \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer TOKEN" \
  -d '{"account_name":"Hack Test"}'
```
4. **Expected:** HTTP 403 response — `"Role 'delivery_manager' not authorized"`
5. [x] PASS / [ ] FAIL

### Test G — Backend blocks GET /users/{id} from delivery_manager
```bash
# Use the same delivery_manager token from Test F
curl -s http://localhost:8000/api/users/ANY-USER-UUID \
  -H "Authorization: Bearer TOKEN"
```
6. **Expected:** HTTP 403 response
7. [x] PASS / [ ] FAIL

### Test H — Signup cannot set admin role
```bash
curl -s -X POST http://localhost:8000/api/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"email":"hacker@test.com","password":"Test@1234","full_name":"Hacker","role":"admin"}'
```
8. **Expected:** HTTP 422 Unprocessable Entity — Pydantic validation error rejecting "admin" as a role
9. [x] PASS / [ ] FAIL

---

## VULN 2.2 — Encryption Not Enforced (MEDIUM)
**Fix applied in:** `frontend/next.config.ts`, `backend/app/main.py`

### Test — HSTS header present on frontend
1. Open browser DevTools → Network tab
2. Navigate to `http://localhost:3000/`
3. Click the first document request (the HTML page)
4. Go to **Response Headers** tab
5. Look for: `Strict-Transport-Security: max-age=31536000; includeSubDomains`
6. **Expected:** Header is present
7. [ ] PASS / [ ] FAIL

### Test — HSTS header present on backend API
```bash
curl -I http://localhost:8000/health
```
8. **Expected:** Response includes `strict-transport-security: max-age=31536000; includeSubDomains`
9. [ ] PASS / [ ] FAIL

---

## VULN 2.3 — No HTTP Strict Transport Security (MEDIUM)
*(Same as 2.2 above — both are fixed by the same HSTS header)*
- [ ] Confirmed HSTS header is present (covered in Vuln 2.2 tests above)

---

## VULN 2.4 — Clickjacking / Cross-Frame Scripting (MEDIUM)
**Fix applied in:** `frontend/next.config.ts`, `backend/app/main.py`

### Test — X-Frame-Options blocks iframing
1. Create a file on your Desktop called `clickjack_test.html` with this content:
```html
<html>
<head><title>Clickjack Test</title></head>
<body>
<h2>If the login page appears below, clickjacking is NOT fixed:</h2>
<iframe src="http://localhost:3000/login" height="450" width="1000"></iframe>
</body>
</html>
```
2. Open that file in your browser (file:// path)
3. **Expected:** The iframe is blank / refused to load. Browser console should show: `Refused to display 'http://localhost:3000/' in a frame because it set 'X-Frame-Options' to 'deny'`
4. [ ] PASS / [ ] FAIL

### Test — Headers present in response
1. DevTools → Network → any page request → Response Headers
2. Look for:
   - `x-frame-options: DENY`
   - `content-security-policy` containing `frame-ancestors 'none'`
3. [ ] PASS / [ ] FAIL

---

## VULN 2.5 — Missing Cookie Flags (LOW)
**Fix applied in:** `frontend/src/lib/supabase/middleware.ts`

### Test — Cookies have HttpOnly and SameSite flags
1. In **Tab A**, open DevTools → Application tab → Cookies → `http://localhost:3000`
2. Find the Supabase auth cookies (named like `sb-*-auth-token`)
3. Check each column:
   - **HttpOnly** column → should show a checkmark/tick
   - **SameSite** column → should show `Lax`
   - **Secure** column → will be empty in local dev (HTTP) — this is expected. In production (HTTPS) this will be checked.
4. [ ] PASS / [ ] FAIL

> **Note:** `Secure` flag is only active in production (HTTPS). On localhost HTTP it is intentionally off so you can log in locally.

---

## VULN 2.6 — Missing Security Headers (LOW)
**Fix applied in:** `frontend/next.config.ts`, `backend/app/main.py`

### Test — All security headers present on frontend
1. DevTools → Network → navigate to `http://localhost:3000/` → click HTML document → Response Headers
2. Verify ALL of the following are present:

| Header | Expected Value |
|--------|---------------|
| `x-content-type-options` | `nosniff` |
| `x-frame-options` | `DENY` |
| `x-xss-protection` | `1; mode=block` |
| `referrer-policy` | `strict-origin-when-cross-origin` |
| `permissions-policy` | `camera=(), microphone=(), geolocation=()` |
| `strict-transport-security` | `max-age=31536000; includeSubDomains` |
| `content-security-policy` | starts with `default-src 'self'` |

3. [ ] All 7 headers present — PASS / [ ] FAIL (note which are missing)

### Test — Security headers present on backend API
```bash
curl -I http://localhost:8000/health
```
4. **Expected:** Same headers appear in the API response
5. [ ] PASS / [ ] FAIL

### Test — X-Powered-By is removed (bonus)
1. In the same Response Headers view, confirm there is NO `X-Powered-By: Next.js` header
   > *Note: Next.js may still send this. If present, it is a minor info leak but not one of the 8 vulns.*
2. [ ] Absent (good) / [ ] Present (acceptable for now)

---

## VULN 2.7 — Lack of Post-Quantum Cryptography (INFORMATIONAL)
**Status: Accepted risk — no code fix possible**

This requires infrastructure-level TLS library upgrades (OpenSSL 3.x with ML-KEM support), not application code. The app uses Supabase Auth (industry standard JWT) over HTTPS. Mark as accepted risk in your audit response.

- [ ] Acknowledged as infrastructure/future concern — no action required in code

---

## VULN 2.8 — Weak Cryptography / Math.random() (INFORMATIONAL)
**Fix applied in:** `frontend/src/components/ui/sidebar.tsx` line 608

### Test — Code verification
1. Open [frontend/src/components/ui/sidebar.tsx](frontend/src/components/ui/sidebar.tsx)
2. Search for `Math.random` — it should return **0 results**
3. Search for `crypto.getRandomValues` — should find 1 result around line 610
4. [ ] PASS / [ ] FAIL

### Quick grep check:
```bash
grep -n "Math.random" frontend/src/components/ui/sidebar.tsx
# Expected: no output (0 results)

grep -n "crypto.getRandomValues" frontend/src/components/ui/sidebar.tsx
# Expected: line ~610 found
```

---

## Summary Table

| # | Vulnerability | Severity | Fix Location | Status |
|---|--------------|----------|--------------|--------|
| 2.1 | Improper Authorization | HIGH | middleware.ts + accounts.py + users.py | [ ] Verified |
| 2.1b | Signup role escalation | HIGH | auth.py | [ ] Verified |
| 2.2 | Encryption Not Enforced | MEDIUM | next.config.ts + main.py | [ ] Verified |
| 2.3 | No HSTS | MEDIUM | next.config.ts + main.py | [ ] Verified |
| 2.4 | Clickjacking / XFS | MEDIUM | next.config.ts + main.py | [ ] Verified |
| 2.5 | Missing Cookie Flags | LOW | middleware.ts | [ ] Verified |
| 2.6 | Missing Security Headers | LOW | next.config.ts + main.py | [ ] Verified |
| 2.7 | Post-Quantum Cryptography | INFO | N/A — accepted risk | [ ] Acknowledged |
| 2.8 | Weak Cryptography (Math.random) | INFO | sidebar.tsx | [ ] Verified |

---

## Files Changed (Code Audit Reference)

| File | What Changed |
|------|-------------|
| `backend/app/routers/accounts.py:65` | `require_role("admin","executive","sales")` restored on POST /accounts |
| `backend/app/routers/users.py:45` | `require_role("admin","executive")` added to GET /users/{user_id} |
| `backend/app/routers/auth.py:17` | `role` field typed as `Literal[...]` — "admin" rejected at signup |
| `backend/app/main.py:26-60` | `SecurityHeadersMiddleware` added; CORS methods/headers tightened |
| `frontend/next.config.ts` | `headers()` function added with all 7 security headers |
| `frontend/src/lib/supabase/middleware.ts` | Route guard for /admin/* and /accounts/new + cookie HttpOnly/SameSite flags |
| `frontend/src/components/ui/sidebar.tsx:608` | `Math.random()` → `crypto.getRandomValues()` |
