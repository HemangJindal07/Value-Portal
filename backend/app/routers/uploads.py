from fastapi import APIRouter, Depends, HTTPException, UploadFile, File, status
from app.database.supabase import get_supabase_admin
from app.dependencies import get_current_user
import uuid
import mimetypes
import logging

logger = logging.getLogger("uploads")

router = APIRouter(prefix="/uploads", tags=["Uploads"])

BUCKET = "attachments"

# Max 20 MB per file
MAX_SIZE_BYTES = 20 * 1024 * 1024

ALLOWED_MIME_TYPES = {
    "application/pdf",
    # Word
    "application/msword",
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    # Excel
    "application/vnd.ms-excel",
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
}


def _is_allowed(content_type: str) -> bool:
    return content_type in ALLOWED_MIME_TYPES


@router.post("", status_code=status.HTTP_201_CREATED)
async def upload_attachment(
    file: UploadFile = File(...),
    current_user: dict = Depends(get_current_user),
):
    """
    Upload a supporting document to Supabase Storage.
    Returns the public URL to be included in supporting_docs when
    creating a lead or value idea.
    """
    content_type = file.content_type or mimetypes.guess_type(file.filename or "")[0] or ""

    if not _is_allowed(content_type):
        ext = (file.filename or "").rsplit(".", 1)[-1].upper() if file.filename and "." in file.filename else content_type
        raise HTTPException(
            status_code=400,
            detail=f"{ext} files are not supported. Please upload a PDF, Word (.doc/.docx), or Excel (.xls/.xlsx) file.",
        )

    contents = await file.read()

    if len(contents) > MAX_SIZE_BYTES:
        raise HTTPException(
            status_code=400,
            detail="File size exceeds the 20 MB limit.",
        )

    # Build a unique storage path: <user_id>/<uuid>_<original_filename>
    ext = (file.filename or "file").rsplit(".", 1)[-1]
    storage_path = f"{current_user['id']}/{uuid.uuid4()}.{ext}"

    supabase = get_supabase_admin()

    # Ensure the bucket exists (no-op if already present)
    try:
        supabase.storage.get_bucket(BUCKET)
    except Exception:
        try:
            supabase.storage.create_bucket(BUCKET, options={"public": True})
        except Exception as exc:
            logger.warning("Could not create storage bucket '%s' (may already exist): %s", BUCKET, exc)

    # Upload to Supabase Storage
    try:
        supabase.storage.from_(BUCKET).upload(
            path=storage_path,
            file=contents,
            file_options={"content-type": content_type, "upsert": "false"},
        )
    except Exception as exc:
        raise HTTPException(
            status_code=500,
            detail=f"Storage upload failed: {str(exc)}",
        )

    # Build the public URL. Pass the original filename via the `download`
    # option so the browser saves it with the real name (e.g. "Report.pdf")
    # instead of opening a blank inline preview of the UUID object.
    original_name = file.filename or f"document.{ext}"
    public_url = supabase.storage.from_(BUCKET).get_public_url(
        storage_path,
        options={"download": original_name},
    )

    return {
        "url": public_url,
        "filename": original_name,
        "size": len(contents),
        "content_type": content_type,
    }
