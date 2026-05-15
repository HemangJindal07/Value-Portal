from pydantic import BaseModel, Field
from enum import Enum
from datetime import date, datetime
from uuid import UUID
from typing import Union


class LeadType(str, Enum):
    current_lead = "current_lead"
    new_lead = "new_lead"


class LeadStatus(str, Enum):
    draft                = "draft"
    submitted            = "submitted"
    routing_pending      = "routing_pending"
    under_review         = "under_review"
    qualified            = "qualified"
    opportunity_created  = "opportunity_created"
    approved             = "approved"
    won                  = "won"
    lost                 = "lost"
    dropped              = "dropped"
    rejected             = "rejected"


class Priority(str, Enum):
    high = "high"
    medium = "medium"
    low = "low"


class ServiceType(str, Enum):
    quality_engineering     = "Quality Engineering"
    digital_engineering     = "Digital Engineering"
    artificial_intelligence = "Artificial Intelligence"
    data_engineering        = "Data Engineering"
    insurance               = "Insurance"


class LeadCreate(BaseModel):
    title: str
    description: str
    lead_type: LeadType
    account_id: UUID
    service: ServiceType | None = None
    contact_details: dict | None = None
    estimated_value: float | None = Field(None, ge=0, description="Must be zero or positive")
    currency: str = Field("USD", pattern=r"^USD$", description="USD only per BRD")
    probability: int | None = Field(None, ge=0, le=100, description="0–100 percent")
    expected_close_date: date | None = None
    priority: Priority = Priority.medium
    supporting_docs: list[Union[str, dict[str, str]]] = []


class LeadUpdate(BaseModel):
    title: str | None = None
    description: str | None = None
    lead_type: LeadType | None = None
    estimated_value: float | None = Field(None, ge=0, description="Must be zero or positive")
    currency: str | None = Field(None, pattern=r"^USD$", description="USD only per BRD")
    probability: int | None = Field(None, ge=0, le=100, description="0–100 percent")
    expected_close_date: date | None = None
    status: LeadStatus | None = None
    priority: Priority | None = None
    rejection_remarks: str | None = None


class LeadResponse(BaseModel):
    lead_id: UUID
    title: str
    description: str
    lead_type: LeadType
    account_id: UUID
    submitted_by: UUID
    service: ServiceType | None = None
    contact_details: dict | None = None
    estimated_value: float | None = None
    currency: str
    probability: int | None = None
    expected_close_date: date | None = None
    status: LeadStatus
    priority: Priority
    supporting_docs: list[Union[str, dict[str, str]]] = []
    rejection_remarks: str | None = None
    ai_category: str | None = None
    ai_confidence: float | None = None
    value_score: int | None = None
    created_at: datetime
    updated_at: datetime
