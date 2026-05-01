from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel, EmailStr
from typing import Literal
from datetime import datetime, timedelta
from app.database.supabase import get_supabase_client, get_supabase_admin
from app.dependencies import get_current_user
from app.schemas.user import ProfileResponse, ProfileUpdate

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
