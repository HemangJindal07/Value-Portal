from fastapi import APIRouter

router = APIRouter()


@router.get("/")
async def list_reviews():
    return {"message": "Reviews endpoint coming soon"}
