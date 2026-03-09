from pydantic import BaseModel
from enum import Enum
from datetime import datetime
from uuid import UUID


class SubmissionType(str, Enum):
    lead = "lead"
    idea = "idea"


class AssignedRole(str, Enum):
    account_owner = "account_owner"
    sales_lead = "sales_lead"
    practice_leader = "practice_leader"
    review_committee = "review_committee"


class ActionTaken(str, Enum):
    pending = "pending"
    reviewed = "reviewed"
    approved = "approved"
    rejected = "rejected"
    escalated = "escalated"


class AssignmentUpdate(BaseModel):
    action_taken: ActionTaken
    notes: str | None = None


class AssignmentResponse(BaseModel):
    assignment_id: UUID
    submission_type: SubmissionType
    submission_id: UUID
    assigned_to: UUID
    assigned_role: AssignedRole
    assigned_by: str
    assignment_date: datetime
    due_date: datetime | None = None
    action_taken: ActionTaken
    action_date: datetime | None = None
    notes: str | None = None
    created_at: datetime
