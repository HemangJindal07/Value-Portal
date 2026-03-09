from pydantic import BaseModel
from datetime import datetime
from uuid import UUID


class CommentCreate(BaseModel):
    content: str
    is_internal: bool = False


class CommentResponse(BaseModel):
    comment_id: UUID
    submission_type: str
    submission_id: UUID
    author_id: UUID
    content: str
    is_internal: bool
    created_at: datetime


class StatusHistoryResponse(BaseModel):
    history_id: UUID
    submission_type: str
    submission_id: UUID
    from_status: str
    to_status: str
    changed_by: UUID
    changed_at: datetime
    reason: str | None = None
