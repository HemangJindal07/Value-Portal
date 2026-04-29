from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel, EmailStr
from typing import Literal
from app.database.supabase import get_supabase_client, get_supabase_admin
from app.dependencies import get_current_user
from app.schemas.user import ProfileResponse, ProfileUpdate

router = APIRouter(prefix="/auth", tags=["Auth"])

SELF_ASSIGNABLE_ROLES = ("user", "sales", "practice_lead", "executive")


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


@router.post("/signup", response_model=AuthResponse)
async def sign_up(payload: SignUpRequest):
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

        return AuthResponse(
            access_token=response.session.access_token,
            refresh_token=response.session.refresh_token,
            user=profile.data,
        )
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid email or password",
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
