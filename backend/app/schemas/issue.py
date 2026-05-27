from pydantic import BaseModel, Field, field_validator
from uuid import UUID
from datetime import datetime
from typing import Literal


class ScreenshotRef(BaseModel):
    url: str
    filename: str

    @field_validator("url")
    @classmethod
    def _http_url_only(cls, v: str) -> str:
        # Block javascript:/data: and other schemes — screenshot URLs must be
        # the http(s) public URLs returned by the uploads endpoint. Prevents a
        # stored-XSS link from being rendered in the admin issues queue.
        if not v.lower().strip().startswith(("http://", "https://")):
            raise ValueError("Screenshot URL must be an http(s) URL.")
        return v


class IssueCreate(BaseModel):
    description: str = Field(..., min_length=1, max_length=5000)
    screenshots: list[ScreenshotRef] = []


class IssueStatusUpdate(BaseModel):
    status: Literal["open", "in_progress", "resolved"]


class IssueResponse(BaseModel):
    issue_id: UUID
    reporter_id: UUID
    reporter_name: str
    reporter_email: str
    description: str
    screenshots: list[ScreenshotRef] = []
    status: str
    created_at: datetime
    updated_at: datetime
