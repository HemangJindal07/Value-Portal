"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { ArrowLeft, Pencil, Users } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import type { Account } from "@/types";
import Link from "next/link";

const statusColors: Record<string, string> = {
  active: "bg-[#B12B35]/10 text-[#B12B35]",
  inactive: "bg-[#C5C5C5]/30 text-[#5D5D5D]",
  prospect: "bg-[#2E75B6]/10 text-[#2E75B6]",
};

interface UserProfile {
  id: string;
  full_name: string;
  email: string;
  role: string;
}

function Field({ label, value }: { label: string; value: string | null }) {
  return (
    <div>
      <p className="text-xs text-muted-foreground mb-1">{label}</p>
      <p className="text-sm">{value || "—"}</p>
    </div>
  );
}

function StakeholderRow({
  step,
  label,
  user,
}: {
  step: number;
  label: string;
  user: UserProfile | null | undefined;
}) {
  return (
    <div className="flex items-start gap-3 py-2">
      <div className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-[#B12B35]/10 text-[#B12B35] text-xs font-bold">
        {step}
      </div>
      <div className="flex-1 min-w-0">
        <p className="text-xs text-muted-foreground">{label}</p>
        {user ? (
          <p className="text-sm font-medium truncate">
            {user.full_name}
            <span className="ml-1 text-xs text-muted-foreground font-normal">
              ({user.email})
            </span>
          </p>
        ) : (
          <p className="text-sm text-muted-foreground italic">Not assigned</p>
        )}
      </div>
    </div>
  );
}

export default function AccountDetailPage() {
  const { id } = useParams<{ id: string }>();
  const { token } = useAuth();
  const router = useRouter();
  const [account, setAccount] = useState<Account | null>(null);
  const [loading, setLoading] = useState(true);
  const [dh, setDh] = useState<UserProfile | null>(null);
  const [du, setDu] = useState<UserProfile | null>(null);
  const [sales, setSales] = useState<UserProfile | null>(null);

  useEffect(() => {
    if (!token || !id) return;
    api<Account>(`/api/accounts/${id}`, { token })
      .then((acct) => {
        setAccount(acct);
        // Resolve stakeholder names in parallel
        const fetches: Promise<void>[] = [];
        if (acct.account_owner_id) {
          fetches.push(
            api<UserProfile>(`/api/users/${acct.account_owner_id}`, { token })
              .then(setDh)
              .catch(() => setDh(null))
          );
        }
        if (acct.practice_leader_id) {
          fetches.push(
            api<UserProfile>(`/api/users/${acct.practice_leader_id}`, { token })
              .then(setDu)
              .catch(() => setDu(null))
          );
        }
        if (acct.sales_lead_id) {
          fetches.push(
            api<UserProfile>(`/api/users/${acct.sales_lead_id}`, { token })
              .then(setSales)
              .catch(() => setSales(null))
          );
        }
        return Promise.all(fetches);
      })
      .catch(() => router.push("/accounts"))
      .finally(() => setLoading(false));
  }, [token, id, router]);

  if (loading) {
    return (
      <p className="text-sm text-muted-foreground py-12 text-center">
        Loading…
      </p>
    );
  }

  if (!account) return null;

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-4">
        <Link href="/accounts">
          <Button variant="ghost" size="icon">
            <ArrowLeft className="h-4 w-4" />
          </Button>
        </Link>
        <div className="flex-1">
          <h1 className="text-2xl font-bold tracking-tight">
            {account.account_name}
          </h1>
          <div className="flex items-center gap-2 mt-1">
            <Badge
              variant="secondary"
              className={statusColors[account.account_status]}
            >
              {account.account_status}
            </Badge>
            {account.industry && (
              <span className="text-sm text-muted-foreground">
                {account.industry}
              </span>
            )}
            {account.region && (
              <span className="text-sm text-muted-foreground">
                · {account.region}
              </span>
            )}
          </div>
        </div>
        <Button variant="outline" size="sm">
          <Pencil className="mr-2 h-3 w-3" />
          Edit
        </Button>
      </div>

      <div className="grid gap-4 lg:grid-cols-2">
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Account Information</CardTitle>
          </CardHeader>
          <CardContent className="grid grid-cols-2 gap-4">
            <Field label="Industry" value={account.industry} />
            <Field label="Region / Country" value={account.region} />
            <Field
              label="Contract Value"
              value={
                account.contract_value
                  ? `$${Number(account.contract_value).toLocaleString()}`
                  : null
              }
            />
            <Field label="Status" value={account.account_status} />
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-base">Engagement Timeline</CardTitle>
          </CardHeader>
          <CardContent className="grid grid-cols-2 gap-4">
            <Field label="Start Date" value={account.engagement_start} />
            <Field label="End Date" value={account.engagement_end} />
            <Field
              label="Created"
              value={new Date(account.created_at).toLocaleDateString()}
            />
          </CardContent>
        </Card>
      </div>

      {/* Stakeholder Routing Map */}
      <Card>
        <CardHeader>
          <CardTitle className="text-base flex items-center gap-2">
            <Users className="h-4 w-4 text-[#B12B35]" />
            Stakeholder Routing
          </CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-xs text-muted-foreground mb-3">
            Leads and Value Ideas submitted for this account follow this approval chain:
          </p>
          <div className="divide-y">
            <StakeholderRow step={1} label="Delivery Head (DH) — First Review" user={dh} />
            <StakeholderRow step={2} label="Delivery Unit Manager (DU) — Second Review" user={du} />
            <StakeholderRow step={3} label="Sales Executive — Final Approval" user={sales} />
          </div>
          {!account.account_owner_id && !account.practice_leader_id && !account.sales_lead_id && (
            <p className="mt-3 text-xs text-amber-600 bg-amber-50 rounded px-3 py-2">
              No stakeholders mapped — submissions will be placed in &quot;Routing Pending&quot; status until stakeholders are assigned.
            </p>
          )}
        </CardContent>
      </Card>

      <Separator />

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Activity</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">
            Leads and ideas linked to this account will appear here.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
