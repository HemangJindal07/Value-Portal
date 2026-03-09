from fastapi import APIRouter

router = APIRouter()


@router.get("/")
async def list_leaderboard():
    return {"message": "Leaderboard endpoint coming soon"}
