from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel, EmailStr
from typing import Literal
from datetime import datetime, timedelta, timezone
import hashlib
import secrets

from app.database.supabase import get_supabase_client, get_supabase_admin
from app.dependencies import get_current_user
from app.schemas.user import ProfileResponse, ProfileUpdate
from app.services.email_service import send_password_reset_otp_email

router = APIRouter(prefix="/auth", tags=["Auth"])

SELF_ASSIGNABLE_ROLES = ("user", "sales", "practice_lead", "executive")

_COMMON_PASSWORDS = {
    "12345678", "password", "password1", "password123", "qwerty123",
    "iloveyou", "welcome1", "abc12345", "letmein1", "monkey123",
    "dragon12", "master12", "sunshine", "princess", "football",
}

_LOCKOUT_THRESHOLD = 5
_LOCKOUT_MINUTES = 15
_failed_attempts: dict[str, dict] = {}

# ── Password-reset OTP config ─────────────────────────────────────────────────
_OTP_EXPIRY_MINUTES = 10
_OTP_MAX_ATTEMPTS = 5  # wrong-code guesses allowed per OTP before it is invalidated


class SignUpRequest(BaseModel):
    email: str
    password: str
    full_name: str
    role: Literal["user", "sales", "practice_lead", "executive"] = "user"


class SignInRequest(BaseModel):
    email: str
    password: str


class ResetPasswordRequest(BaseModel):
    new_password: str


class ForgotPasswordRequest(BaseModel):
    email: EmailStr


class VerifyOtpRequest(BaseModel):
    email: EmailStr
    code: str


class ConfirmResetRequest(BaseModel):
    email: EmailStr
    code: str
    new_password: str


class AuthResponse(BaseModel):
    access_token: str
    refresh_token: str
    user: dict


def _check_password_strength(password: str) -> None:
    if len(password) < 8:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Password must be at least 8 characters.",
        )
    if password.lower() in _COMMON_PASSWORDS:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="This password is too common. Please choose a stronger one.",
        )


def _check_lockout(email: str) -> None:
    key = email.lower()
    entry = _failed_attempts.get(key)
    if not entry:
        return
    locked_until = entry.get("locked_until")
    if locked_until and datetime.utcnow() < locked_until:
        remaining = int((locked_until - datetime.utcnow()).total_seconds() / 60) + 1
        raise HTTPException(
            status_code=status.HTTP_429_TOO_MANY_REQUESTS,
            detail=f"Account temporarily locked. Try again in {remaining} minute(s).",
        )


def _record_failure(email: str) -> None:
    key = email.lower()
    entry = _failed_attempts.setdefault(key, {"count": 0, "locked_until": None})
    locked_until = entry.get("locked_until")
    if locked_until and datetime.utcnow() >= locked_until:
        entry["count"] = 0
        entry["locked_until"] = None
    entry["count"] += 1
    if entry["count"] >= _LOCKOUT_THRESHOLD:
        entry["locked_until"] = datetime.utcnow() + timedelta(minutes=_LOCKOUT_MINUTES)


def _clear_failure(email: str) -> None:
    _failed_attempts.pop(email.lower(), None)


# ── Password-reset OTP helpers ────────────────────────────────────────────────

def _hash_otp(code: str) -> str:
    """Hash an OTP code so plaintext codes are never stored at rest."""
    return hashlib.sha256(code.encode("utf-8")).hexdigest()


def _find_user_by_email(email: str) -> dict | None:
    """Return the profiles row for an email, or None if no such active user."""
    result = (
        get_supabase_admin()
        .table("profiles")
        .select("*")
        .ilike("email", email)
        .limit(1)
        .execute()
    )
    return result.data[0] if result.data else None


@router.post("/signup", response_model=AuthResponse)
async def sign_up(payload: SignUpRequest):
    _check_password_strength(payload.password)
    supabase = get_supabase_client()
    try:
        response = supabase.auth.sign_up(
            {
                "email": payload.email,
                "password": payload.password,
                "options": {
                    "data": {
                        "full_name": payload.full_name,
                        "role": payload.role,
                    }
                },
            }
        )

        if not response.session:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Signup failed — check if email confirmation is required in Supabase settings.",
            )

        return AuthResponse(
            access_token=response.session.access_token,
            refresh_token=response.session.refresh_token,
            user={
                "id": str(response.user.id),
                "email": response.user.email,
                "full_name": payload.full_name,
                "role": payload.role,
            },
        )
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(e),
        )


@router.post("/signin", response_model=AuthResponse)
async def sign_in(payload: SignInRequest):
    _check_lockout(payload.email)
    supabase = get_supabase_client()
    try:
        response = supabase.auth.sign_in_with_password(
            {"email": payload.email, "password": payload.password}
        )

        profile = (
            get_supabase_admin()
            .table("profiles")
            .select("*")
            .eq("id", response.user.id)
            .single()
            .execute()
        )

        _clear_failure(payload.email)
        return AuthResponse(
            access_token=response.session.access_token,
            refresh_token=response.session.refresh_token,
            user=profile.data,
        )
    except HTTPException:
        raise
    except Exception:
        _record_failure(payload.email)
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid email or password.",
        )


@router.get("/me")
async def get_me(current_user: dict = Depends(get_current_user)):
    return current_user


@router.patch("/me")
async def update_me(
    payload: ProfileUpdate,
    current_user: dict = Depends(get_current_user),
):
    supabase = get_supabase_admin()
    update_data = payload.model_dump(exclude_unset=True)

    update_data.pop("role", None)
    update_data.pop("is_active", None)

    if not update_data:
        return current_user

    result = (
        supabase.table("profiles")
        .update(update_data)
        .eq("id", current_user["id"])
        .execute()
    )
    return result.data[0]


@router.post("/reset-password")
async def reset_password(
    payload: ResetPasswordRequest,
    current_user: dict = Depends(get_current_user),
):
    """
    Force-reset endpoint used the first time a bulk-imported employee logs in.
    Updates the Supabase Auth password and clears the must_reset_password flag.
    """
    if len(payload.new_password) < 8:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Password must be at least 8 characters long.",
        )
    if payload.new_password == "Txcatalyst@123":
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Please choose a different password from the initial one.",
        )

    supabase = get_supabase_admin()
    try:
        supabase.auth.admin.update_user_by_id(
            current_user["id"],
            {"password": payload.new_password},
        )
    except Exception as exc:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Could not update password: {exc}",
        )

    result = (
        supabase.table("profiles")
        .update({"must_reset_password": False})
        .eq("id", current_user["id"])
        .execute()
    )
    return result.data[0] if result.data else {"must_reset_password": False}


# ── Forgot-password OTP flow ──────────────────────────────────────────────────

@router.post("/forgot-password")
async def forgot_password(payload: ForgotPasswordRequest):
    """
    Step 1 — request a reset code. Generates a 6-digit OTP, stores it hashed
    with a short expiry, and emails it to the user.

    Always returns a generic success response so the endpoint cannot be used to
    enumerate which emails are registered.
    """
    email = payload.email.strip().lower()
    generic_ok = {
        "message": "If an account exists for that email, a reset code has been sent."
    }

    user = _find_user_by_email(email)
    if not user:
        return generic_ok

    supabase = get_supabase_admin()

    # Invalidate any earlier unconsumed codes for this email.
    now = datetime.now(timezone.utc)
    supabase.table("password_reset_otps").update(
        {"consumed_at": now.isoformat()}
    ).ilike("email", email).is_("consumed_at", "null").execute()

    code = f"{secrets.randbelow(1_000_000):06d}"
    expires_at = now + timedelta(minutes=_OTP_EXPIRY_MINUTES)

    supabase.table("password_reset_otps").insert(
        {
            "email": email,
            "code_hash": _hash_otp(code),
            "expires_at": expires_at.isoformat(),
        }
    ).execute()

    try:
        send_password_reset_otp_email(
            recipient_email=user["email"],
            recipient_name=user.get("full_name") or "there",
            code=code,
            expiry_minutes=_OTP_EXPIRY_MINUTES,
        )
    except Exception:
        raise HTTPException(
            status_code=status.HTTP_502_BAD_GATEWAY,
            detail="Could not send the reset email. Please try again shortly.",
        )

    return generic_ok


def _consume_active_otp(email: str, code: str, *, mark_consumed: bool) -> dict:
    """
    Validate an OTP for an email. Raises HTTPException on any failure.
    On success, optionally marks the OTP consumed and returns the row.
    """
    supabase = get_supabase_admin()
    now = datetime.now(timezone.utc)

    result = (
        supabase.table("password_reset_otps")
        .select("*")
        .ilike("email", email)
        .is_("consumed_at", "null")
        .order("created_at", desc=True)
        .limit(1)
        .execute()
    )
    otp = result.data[0] if result.data else None

    invalid = HTTPException(
        status_code=status.HTTP_400_BAD_REQUEST,
        detail="Invalid or expired code. Please request a new one.",
    )

    if not otp:
        raise invalid

    expires_at = datetime.fromisoformat(otp["expires_at"])
    if expires_at < now:
        raise invalid

    if otp["attempts"] >= _OTP_MAX_ATTEMPTS:
        supabase.table("password_reset_otps").update(
            {"consumed_at": now.isoformat()}
        ).eq("otp_id", otp["otp_id"]).execute()
        raise HTTPException(
            status_code=status.HTTP_429_TOO_MANY_REQUESTS,
            detail="Too many incorrect attempts. Please request a new code.",
        )

    if _hash_otp(code.strip()) != otp["code_hash"]:
        supabase.table("password_reset_otps").update(
            {"attempts": otp["attempts"] + 1}
        ).eq("otp_id", otp["otp_id"]).execute()
        raise invalid

    if mark_consumed:
        supabase.table("password_reset_otps").update(
            {"consumed_at": now.isoformat()}
        ).eq("otp_id", otp["otp_id"]).execute()

    return otp


@router.post("/verify-otp")
async def verify_otp(payload: VerifyOtpRequest):
    """
    Step 2 — verify the 6-digit code without consuming it. Lets the frontend
    confirm the code before showing the new-password form.
    """
    email = payload.email.strip().lower()
    _consume_active_otp(email, payload.code, mark_consumed=False)
    return {"verified": True}


@router.post("/confirm-reset")
async def confirm_reset(payload: ConfirmResetRequest):
    """
    Step 3 — re-verify the code, then set the new password in Supabase Auth.
    The OTP is consumed here so it cannot be reused.
    """
    email = payload.email.strip().lower()
    _check_password_strength(payload.new_password)

    user = _find_user_by_email(email)
    if not user:
        # Code was issued for an email that no longer has a profile.
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid or expired code. Please request a new one.",
        )

    # Verify and consume the OTP in one step.
    _consume_active_otp(email, payload.code, mark_consumed=True)

    supabase = get_supabase_admin()
    try:
        supabase.auth.admin.update_user_by_id(
            user["id"],
            {"password": payload.new_password},
        )
    except Exception as exc:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Could not update password: {exc}",
        )

    # Clear any login lockout so the user can sign in immediately.
    _clear_failure(email)

    return {"message": "Password updated. You can now sign in with your new password."}
