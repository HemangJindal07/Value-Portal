from pydantic import BaseModel
from enum import Enum
from datetime import date, datetime
from uuid import UUID


class LeadType(str, Enum):
    cross_sell = "cross_sell"
    upsell = "upsell"
    new_service = "new_service"
    expansion = "expansion"


class LeadStatus(str, Enum):
    draft = "draft"
    submitted = "submitted"
    under_review = "under_review"
    qualified = "qualified"
    won = "won"
    lost = "lost"
    dropped = "dropped"


class Priority(str, Enum):
    high = "high"
    medium = "medium"
    low = "low"


class LeadCreate(BaseModel):
    title: str
    description: str
    lead_type: LeadType
    account_id: UUID
    estimated_value: float | None = None
    currency: str = "USD"
    probability: int | None = None
    expected_close_date: date | None = None
    priority: Priority = Priority.medium


class LeadUpdate(BaseModel):
    title: str | None = None
    description: str | None = None
    lead_type: LeadType | None = None
    estimated_value: float | None = None
    currency: str | None = None
    probability: int | None = None
    expected_close_date: date | None = None
    status: LeadStatus | None = None
    priority: Priority | None = None


class LeadResponse(BaseModel):
    lead_id: UUID
    title: str
    description: str
    lead_type: LeadType
    account_id: UUID
    submitted_by: UUID
    estimated_value: float | None = None
    currency: str
    probability: int | None = None
    expected_close_date: date | None = None
    status: LeadStatus
    priority: Priority
    supporting_docs: list[str] = []
    ai_category: str | None = None
    ai_confidence: float | None = None
    value_score: int | None = None
    created_at: datetime
    updated_at: datetime
