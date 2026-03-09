from fastapi import APIRouter

router = APIRouter()


@router.get("/")
async def list_ai():
    return {"message": "AI endpoint coming soon"}
