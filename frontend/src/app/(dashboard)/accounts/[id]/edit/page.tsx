"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import Link from "next/link";
import { ArrowLeft } from "lucide-react";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import { toast } from "sonner";
import { UserCombobox } from "@/components/user-combobox";
import type { Account } from "@/types";

const REGIONS = [
  "Australia",
  "Brazil",
  "Canada",
  "China",
  "France",
  "Germany",
  "India",
  "Japan",
  "Malaysia",
  "Mexico",
  "Middle East",
  "Netherlands",
  "New Zealand",
  "Philippines",
  "Poland",
  "Singapore",
  "South Africa",
  "South Korea",
  "Sweden",
  "UAE",
  "United Kingdom",
  "United States",
  "Other",
];

export default function EditAccountPage() {
  const { id } = useParams<{ id: string }>();
  const { token } = useAuth();
  const router = useRouter();
  const [loading, setLoading] = useState(false);
  const [loadAccount, setLoadAccount] = useState(true);
  const [accountName, setAccountName] = useState("");
  const [industry, setIndustry] = useState("");
  const [duId, setDuId] = useState<string | null>(null);
  const [dhId, setDhId] = useState<string | null>(null);
  const [region, setRegion] = useState<string>("");
  const [status, setStatus] = useState<string>("prospect");
  const [contractValue, setContractValue] = useState<string>("");
  const [engagementStart, setEngagementStart] = useState<string>("");
  const [engagementEnd, setEngagementEnd] = useState<string>("");

  useEffect(() => {
    if (!token || !id) return;
    api<Account>(`/api/accounts/${id}`, { token })
      .then((acct) => {
        setAccountName(acct.account_name);
        setIndustry(acct.industry ?? "");
        setRegion(acct.region ?? "");
        setStatus(acct.account_status ?? "prospect");
        setContractValue(
          acct.contract_value != null ? String(acct.contract_value) : ""
        );
        setEngagementStart(acct.engagement_start ?? "");
        setEngagementEnd(acct.engagement_end ?? "");
        setDuId(acct.practice_leader_id);
        setDhId(acct.account_owner_id);
      })
      .catch(() => {
        toast.error("Could not load account");
        router.push("/accounts");
      })
      .finally(() => setLoadAccount(false));
  }, [token, id, router]);

  async function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    if (!token || !id) return;
    setLoading(true);
    const payload = {
      account_name: accountName,
      industry: industry || null,
      region: region || null,
      contract_value: contractValue ? Number(contractValue) : null,
      engagement_start: engagementStart || null,
      engagement_end: engagementEnd || null,
      account_status: status || "prospect",
      account_owner_id: dhId || null,
      practice_leader_id: duId || null,
    };
    try {
      await api(`/api/accounts/${id}`, {
        method: "PATCH",
        body: payload,
        token,
      });
      toast.success("Account updated");
      router.push(`/accounts/${id}`);
    } catch (err: unknown) {
      toast.error(
        err instanceof Error ? err.message : "Failed to update account"
      );
    } finally {
      setLoading(false);
    }
  }

  if (loadAccount) {
    return (
      <p className="text-sm text-muted-foreground py-12 text-center">
        Loading…
      </p>
    );
  }

  return (
    <div className="max-w-2xl">
      <div className="mb-6 flex items-center gap-3">
        <Button variant="ghost" size="icon" asChild>
          <Link href={`/accounts/${id}`}>
            <ArrowLeft className="h-4 w-4" />
          </Link>
        </Button>
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Edit Account</h1>
          <p className="text-muted-foreground text-sm">
            Update account details and DU / DH routing contacts.
          </p>
        </div>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Account Details</CardTitle>
          <CardDescription>
            Changes sync to the stakeholder table when DU or DH is updated.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="account_name">Account Name *</Label>
              <Input
                id="account_name"
                name="account_name"
                value={accountName}
                onChange={(e) => setAccountName(e.target.value)}
                required
              />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="industry">Industry</Label>
                <Input
                  id="industry"
                  name="industry"
                  value={industry}
                  onChange={(e) => setIndustry(e.target.value)}
                />
              </div>
              <div className="space-y-2">
                <Label>Region / Country</Label>
                <Select value={region} onValueChange={(v) => setRegion(v ?? "")}>
                  <SelectTrigger>
                    <SelectValue placeholder="Select region…" />
                  </SelectTrigger>
                  <SelectContent>
                    {REGIONS.map((r) => (
                      <SelectItem key={r} value={r}>
                        {r}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="contract_value">Contract Value ($)</Label>
              <Input
                id="contract_value"
                name="contract_value"
                type="number"
                step="0.01"
                value={contractValue}
                onChange={(e) => setContractValue(e.target.value)}
              />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="engagement_start">Engagement Start</Label>
                <Input
                  id="engagement_start"
                  name="engagement_start"
                  type="date"
                  value={engagementStart}
                  onChange={(e) => setEngagementStart(e.target.value)}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="engagement_end">Engagement End</Label>
                <Input
                  id="engagement_end"
                  name="engagement_end"
                  type="date"
                  value={engagementEnd}
                  onChange={(e) => setEngagementEnd(e.target.value)}
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label>Status</Label>
              <Select
                value={status}
                onValueChange={(v) => setStatus(v ?? "prospect")}
              >
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="prospect">Prospect</SelectItem>
                  <SelectItem value="active">Active</SelectItem>
                  <SelectItem value="inactive">Inactive</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="pt-2 border-t space-y-4">
              <p className="text-sm font-medium">Stakeholder Mapping</p>
              <div className="space-y-2">
                <Label>
                  Delivery Unit (DU)
                  <span className="ml-1 text-xs text-muted-foreground">
                    — first reviewer
                  </span>
                </Label>
                <UserCombobox
                  value={duId}
                  onChange={(uid) => setDuId(uid)}
                  token={token ?? ""}
                  placeholder="Search for Delivery Unit…"
                  disabled={loading}
                />
              </div>
              <div className="space-y-2">
                <Label>
                  Delivery Head (DH)
                  <span className="ml-1 text-xs text-muted-foreground">
                    — second reviewer
                  </span>
                </Label>
                <UserCombobox
                  value={dhId}
                  onChange={(uid) => setDhId(uid)}
                  token={token ?? ""}
                  placeholder="Search for Delivery Head…"
                  disabled={loading}
                />
              </div>
            </div>

            <div className="flex gap-3 pt-4">
              <Button type="submit" disabled={loading}>
                {loading ? "Saving…" : "Save Changes"}
              </Button>
              <Button type="button" variant="outline" asChild>
                <Link href={`/accounts/${id}`}>Cancel</Link>
              </Button>
            </div>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}
