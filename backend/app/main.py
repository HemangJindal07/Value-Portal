from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.responses import Response
from app.config import get_settings
# Value Ideas API disabled — leads-only portal (re-enable: add `ideas` back to import + router below)
from app.routers import auth, accounts, users, leads, ai, assignments, tracking, notifications, scoring, dashboard, governance, uploads, stakeholders, vertical_routing
# from app.routers import ideas

settings = get_settings()

app = FastAPI(
    title="TX Catalyst API",
    version="0.1.0",
    description="Backend API for TX Catalyst — lead tracking and AI-powered classification.",
)

_extra_origins = [o.strip() for o in settings.extra_cors_origins.split(",") if o.strip()]
_localhost_origins = (
    ["http://localhost:3000", "http://localhost:3002"]
    if settings.environment == "development"
    else []
)
_cors_origins = list({
    settings.frontend_url,
    *_localhost_origins,
    *_extra_origins,
})

_SECURITY_HEADERS = {
    "X-Content-Type-Options": "nosniff",
    "X-Frame-Options": "DENY",
    "X-XSS-Protection": "1; mode=block",
    "Referrer-Policy": "strict-origin-when-cross-origin",
    "Permissions-Policy": "camera=(), microphone=(), geolocation=()",
    "Strict-Transport-Security": "max-age=31536000; includeSubDomains",
    "Content-Security-Policy": (
        "default-src 'self'; "
        "script-src 'self' 'unsafe-inline'; "
        "style-src 'self' 'unsafe-inline'; "
        "img-src 'self' data: blob:; "
        "font-src 'self' data:; "
        "connect-src 'self' https://*.supabase.co wss://*.supabase.co; "
        "frame-ancestors 'none';"
    ),
}


class SecurityHeadersMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next) -> Response:
        response = await call_next(request)
        for header, value in _SECURITY_HEADERS.items():
            response.headers.setdefault(header, value)
        return response


app.add_middleware(SecurityHeadersMiddleware)
app.add_middleware(
    CORSMiddleware,
    allow_origins=_cors_origins,
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"],
    allow_headers=["Authorization", "Content-Type", "X-Cron-Secret"],
)

app.include_router(auth.router, prefix="/api")
app.include_router(accounts.router, prefix="/api")
app.include_router(users.router, prefix="/api")
app.include_router(leads.router, prefix="/api")
# app.include_router(ideas.router, prefix="/api")
app.include_router(ai.router, prefix="/api")
app.include_router(assignments.router, prefix="/api")
app.include_router(tracking.router, prefix="/api")
app.include_router(notifications.router, prefix="/api")
app.include_router(scoring.router, prefix="/api")
app.include_router(dashboard.router, prefix="/api")
app.include_router(governance.router, prefix="/api")
app.include_router(uploads.router, prefix="/api")
app.include_router(stakeholders.router, prefix="/api")
app.include_router(vertical_routing.router, prefix="/api")


@app.get("/health")
async def health_check():
    return {"status": "healthy", "version": "0.1.0"}


@app.post("/api/cron/reminders")
async def run_reminder_check(request: Request):
    from app.services.reminder_engine import check_reminders_and_escalations
    secret = request.headers.get("X-Cron-Secret", "")
    expected = settings.cron_secret
    if not expected or secret != expected:
        from fastapi import HTTPException
        raise HTTPException(status_code=403, detail="Invalid cron secret")
    stats = check_reminders_and_escalations()
    return {"status": "ok", **stats}
