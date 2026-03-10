"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { ArrowLeft, Pencil } from "lucide-react";
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
  active: "bg-green-500/10 text-green-500",
  inactive: "bg-gray-500/10 text-gray-400",
  prospect: "bg-blue-500/10 text-blue-400",
};

function Field({ label, value }: { label: string; value: string | null }) {
  return (
    <div>
      <p className="text-xs text-muted-foreground mb-1">{label}</p>
      <p className="text-sm">{value || "—"}</p>
    </div>
  );
}

export default function AccountDetailPage() {
  const { id } = useParams<{ id: string }>();
  const { token } = useAuth();
  const router = useRouter();
  const [account, setAccount] = useState<Account | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!token || !id) return;
    api<Account>(`/api/accounts/${id}`, { token })
      .then(setAccount)
      .catch(() => router.push("/accounts"))
      .finally(() => setLoading(false));
  }, [token, id, router]);

  if (loading) {
    return (
      <p className="text-sm text-muted-foreground py-12 text-center">
        Loading...
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
            <Field label="Region" value={account.region} />
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

      <Separator />

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Activity</CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">
            Leads and ideas linked to this account will appear here in Step 2.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
