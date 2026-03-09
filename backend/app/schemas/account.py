from pydantic import BaseModel
from enum import Enum
from datetime import date, datetime
from uuid import UUID


class AccountStatus(str, Enum):
    active = "active"
    inactive = "inactive"
    prospect = "prospect"


class AccountCreate(BaseModel):
    account_name: str
    industry: str | None = None
    region: str | None = None
    account_owner_id: UUID | None = None
    sales_lead_id: UUID | None = None
    practice_leader_id: UUID | None = None
    contract_value: float | None = None
    engagement_start: date | None = None
    engagement_end: date | None = None
    account_status: AccountStatus = AccountStatus.prospect


class AccountUpdate(BaseModel):
    account_name: str | None = None
    industry: str | None = None
    region: str | None = None
    account_owner_id: UUID | None = None
    sales_lead_id: UUID | None = None
    practice_leader_id: UUID | None = None
    contract_value: float | None = None
    engagement_start: date | None = None
    engagement_end: date | None = None
    account_status: AccountStatus | None = None


class AccountResponse(BaseModel):
    account_id: UUID
    account_name: str
    industry: str | None = None
    region: str | None = None
    account_owner_id: UUID | None = None
    sales_lead_id: UUID | None = None
    practice_leader_id: UUID | None = None
    contract_value: float | None = None
    engagement_start: date | None = None
    engagement_end: date | None = None
    account_status: AccountStatus
    created_at: datetime
