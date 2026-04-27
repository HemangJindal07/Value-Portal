from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
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
_cors_origins = list({
    settings.frontend_url,
    "http://localhost:3000",
    "http://localhost:3002",
    *_extra_origins,
})

app.add_middleware(
    CORSMiddleware,
    allow_origins=_cors_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
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
