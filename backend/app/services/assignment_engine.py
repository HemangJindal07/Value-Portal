"""
Thin wrapper kept for backward-compatibility with existing call-sites in leads/ideas routers.
Delegates to routing_engine which implements the proper DH → DU → Sales sequential flow.
"""

from app.services.routing_engine import start_routing


async def auto_assign(submission_type: str, submission_id: str, account_id: str) -> None:
    """Start the sequential routing chain for a newly submitted lead or idea."""
    # submitted_by is not passed here from the legacy call-sites so we pass an empty string;
    # routing_engine only uses it for notifications, which still read submitted_by from the DB.
    await start_routing(
        submission_type=submission_type,
        submission_id=submission_id,
        account_id=account_id,
        submitter_id="",
    )
