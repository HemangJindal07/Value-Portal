from fastapi import Depends, HTTPException, Request, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from app.database.supabase import get_supabase_admin

security = HTTPBearer()

# Endpoints a user with must_reset_password=True is still allowed to call
# while their account is locked into the password-reset flow.
_RESET_PASSWORD_ALLOWED_PATHS = {
    "/api/auth/me",
    "/api/auth/reset-password",
    "/api/auth/signin",
    "/api/auth/signup",
}


async def get_current_user(
    request: Request,
    credentials: HTTPAuthorizationCredentials = Depends(security),
):
    supabase = get_supabase_admin()
    try:
        user_response = supabase.auth.get_user(credentials.credentials)
        if not user_response or not user_response.user:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid or expired token",
            )

        profile = (
            supabase.table("profiles")
            .select("*")
            .eq("id", user_response.user.id)
            .single()
            .execute()
        )

        if not profile.data:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Profile not found",
            )

        if (
            profile.data.get("must_reset_password")
            and request.url.path not in _RESET_PASSWORD_ALLOWED_PATHS
        ):
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Password reset required before accessing this resource.",
            )

        return profile.data
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Could not validate credentials",
        )


def require_role(*allowed_roles: str):
    async def role_checker(current_user: dict = Depends(get_current_user)):
        if current_user["role"] not in allowed_roles:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail=f"Role '{current_user['role']}' not authorized. Required: {', '.join(allowed_roles)}",
            )
        return current_user

    return role_checker
