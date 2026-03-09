from pydantic import BaseModel, EmailStr
from enum import Enum
from datetime import datetime
from uuid import UUID


class UserRole(str, Enum):
    delivery_manager = "delivery_manager"
    sales = "sales"
    practice_lead = "practice_lead"
    admin = "admin"
    executive = "executive"


class ProfileResponse(BaseModel):
    id: UUID
    full_name: str
    email: str
    role: UserRole
    department: str | None = None
    account_assigned: UUID | None = None
    profile_photo: str | None = None
    is_active: bool = True
    created_at: datetime
    last_login: datetime | None = None


class ProfileUpdate(BaseModel):
    full_name: str | None = None
    role: UserRole | None = None
    department: str | None = None
    account_assigned: UUID | None = None
    is_active: bool | None = None
