"""Inspect the most recently submitted lead and its routing/assignments."""
import sys
if sys.stdout.encoding and sys.stdout.encoding.lower() != "utf-8":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from supabase import create_client

SUPABASE_URL = "https://irsyepgmxsjwgpnzowvn.supabase.co"
KEY = (
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
    ".eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlyc3llcGdteHNqd2dwbnpvd3ZuIiwicm9sZSI6"
    "InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3NzM5MjIzNiwiZXhwIjoyMDkyOTY4MjM2fQ"
    ".S0XCPwUsXo4Zd9aOoD-8zlT0L2Myh4HQcbWJXrgupmw"
)
sb = create_client(SUPABASE_URL, KEY)

# Latest lead
leads = (
    sb.table("leads")
    .select("lead_id,title,status,lead_type,service,submitted_by,account_id,created_at")
    .order("created_at", desc=True)
    .limit(3)
    .execute()
).data or []

for lead in leads:
    print("=" * 70)
    print(f"LEAD: {lead['title']}")
    print(f"  id         : {lead['lead_id']}")
    print(f"  status     : {lead['status']}")
    print(f"  lead_type  : {lead['lead_type']}")
    print(f"  service    : {lead.get('service')!r}")
    print(f"  created_at : {lead['created_at']}")

    # submitter
    sub = (
        sb.table("profiles")
        .select("full_name,email,role")
        .eq("id", lead["submitted_by"])
        .single()
        .execute()
    ).data or {}
    print(f"  submitter  : {sub.get('full_name')} <{sub.get('email')}>  role={sub.get('role')}")

    # account
    if lead.get("account_id"):
        acct = (
            sb.table("accounts")
            .select("account_name,industry,region")
            .eq("account_id", lead["account_id"])
            .single()
            .execute()
        ).data or {}
        print(f"  account    : {acct.get('account_name')}  (industry={acct.get('industry')}, region={acct.get('region')})")

    # assignments
    asgns = (
        sb.table("assignments")
        .select("*")
        .eq("submission_id", lead["lead_id"])
        .order("assignment_date", desc=False)
        .execute()
    ).data or []

    print(f"  assignments ({len(asgns)}):")
    for a in asgns:
        prof = (
            sb.table("profiles")
            .select("full_name,email,role")
            .eq("id", a["assigned_to"])
            .single()
            .execute()
        ).data or {}
        print(
            f"    - role={a['assigned_role']!r:30s} "
            f"to={prof.get('full_name')} <{prof.get('email')}> ({prof.get('role')}) "
            f"action={a['action_taken']!r:12s} by={a['assigned_by']} "
            f"date={a['assignment_date']}"
        )
        if a.get("notes"):
            print(f"        notes: {a['notes']}")
    print()
