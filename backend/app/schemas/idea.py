from pydantic import BaseModel
from enum import Enum
from datetime import datetime
from uuid import UUID


class IdeaCategory(str, Enum):
    automation = "automation"
    cost_optimization = "cost_optimization"
    efficiency = "efficiency"
    risk_reduction = "risk_reduction"
    innovation = "innovation"
    process_improvement = "process_improvement"


class IdeaStatus(str, Enum):
    draft = "draft"
    submitted = "submitted"
    under_review = "under_review"
    approved = "approved"
    in_progress = "in_progress"
    implemented = "implemented"
    rejected = "rejected"


class EffortLevel(str, Enum):
    low = "low"
    medium = "medium"
    high = "high"


class IdeaCreate(BaseModel):
    title: str
    problem_statement: str
    proposed_solution: str
    idea_category: IdeaCategory
    account_id: UUID
    estimated_saving: float | None = None
    estimated_effort: EffortLevel = EffortLevel.medium
    estimated_timeline: str | None = None
    impact_area: list[str] = []
    tools_involved: list[str] = []


class IdeaUpdate(BaseModel):
    title: str | None = None
    problem_statement: str | None = None
    proposed_solution: str | None = None
    idea_category: IdeaCategory | None = None
    estimated_saving: float | None = None
    estimated_effort: EffortLevel | None = None
    estimated_timeline: str | None = None
    impact_area: list[str] | None = None
    tools_involved: list[str] | None = None
    status: IdeaStatus | None = None


class IdeaResponse(BaseModel):
    idea_id: UUID
    title: str
    problem_statement: str
    proposed_solution: str
    idea_category: IdeaCategory
    account_id: UUID
    submitted_by: UUID
    estimated_saving: float | None = None
    estimated_effort: EffortLevel
    estimated_timeline: str | None = None
    impact_area: list[str] = []
    tools_involved: list[str] = []
    status: IdeaStatus
    ai_category: str | None = None
    ai_summary: str | None = None
    ai_confidence: float | None = None
    value_score: int | None = None
    supporting_docs: list[str] = []
    created_at: datetime
    updated_at: datetime
