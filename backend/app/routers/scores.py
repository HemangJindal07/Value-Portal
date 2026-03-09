from fastapi import APIRouter

router = APIRouter()


@router.get("/")
async def list_scores():
    return {"message": "Scores endpoint coming soon"}
