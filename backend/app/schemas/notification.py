from pydantic import BaseModel
from uuid import UUID
from datetime import datetime


class NotificationResponse(BaseModel):
    notification_id: UUID
    recipient_id: UUID
    submission_type: str
    submission_id: UUID
    type: str
    message: str
    channel: str
    is_read: bool
    sent_at: datetime
    read_at: datetime | None = None


class MarkReadRequest(BaseModel):
    notification_ids: list[UUID]
