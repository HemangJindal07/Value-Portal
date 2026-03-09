from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.config import get_settings
from app.routers import auth, accounts, users, leads, ideas

settings = get_settings()

app = FastAPI(
    title="Value Portal API",
    version="0.1.0",
    description="Backend API for the Value Portal — lead tracking, idea management, and AI-powered classification.",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=[settings.frontend_url, "http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router, prefix="/api")
app.include_router(accounts.router, prefix="/api")
app.include_router(users.router, prefix="/api")
app.include_router(leads.router, prefix="/api")
app.include_router(ideas.router, prefix="/api")


@app.get("/health")
async def health_check():
    return {"status": "healthy", "version": "0.1.0"}
