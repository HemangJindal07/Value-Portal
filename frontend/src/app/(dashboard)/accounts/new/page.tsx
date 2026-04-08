"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
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

export default function NewAccountPage() {
  const { token } = useAuth();
  const router = useRouter();
  const [loading, setLoading] = useState(false);

  // Stakeholder IDs — DU reviews first, DH reviews second
  const [duId, setDuId] = useState<string | null>(null);
  const [dhId, setDhId] = useState<string | null>(null);

  // Region (controlled so we can read it on submit)
  const [region, setRegion] = useState<string>("");
  const [status, setStatus] = useState<string>("prospect");

  async function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    setLoading(true);

    const payload = {
      account_name: formData.get("account_name") as string,
      industry: (formData.get("industry") as string) || null,
      region: region || null,
      contract_value: formData.get("contract_value")
        ? Number(formData.get("contract_value"))
        : null,
      engagement_start: (formData.get("engagement_start") as string) || null,
      engagement_end: (formData.get("engagement_end") as string) || null,
      account_status: status || "prospect",
      account_owner_id: dhId || null,
      practice_leader_id: duId || null,
      sales_lead_id: null,
    };

    try {
      await api("/api/accounts", {
        method: "POST",
        body: payload,
        token: token!,
      });
      toast.success("Account created");
      router.push("/accounts");
    } catch (err: unknown) {
      const message =
        err instanceof Error ? err.message : "Failed to create account";
      toast.error(message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="max-w-2xl">
      <div className="mb-6">
        <h1 className="text-2xl font-bold tracking-tight">New Account</h1>
        <p className="text-muted-foreground">
          Register a new client account and assign stakeholders.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Account Details</CardTitle>
          <CardDescription>
            Fill in the client account information and map the routing stakeholders.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            {/* Account Name */}
            <div className="space-y-2">
              <Label htmlFor="account_name">Account Name *</Label>
              <Input
                id="account_name"
                name="account_name"
                placeholder="e.g. Acme Corp"
                required
              />
            </div>

            {/* Industry + Region */}
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="industry">Industry</Label>
                <Input
                  id="industry"
                  name="industry"
                  placeholder="e.g. Financial Services"
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

            {/* Contract Value */}
            <div className="space-y-2">
              <Label htmlFor="contract_value">Contract Value ($)</Label>
              <Input
                id="contract_value"
                name="contract_value"
                type="number"
                step="0.01"
                placeholder="e.g. 500000"
              />
            </div>

            {/* Dates */}
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="engagement_start">Engagement Start</Label>
                <Input id="engagement_start" name="engagement_start" type="date" />
              </div>
              <div className="space-y-2">
                <Label htmlFor="engagement_end">Engagement End</Label>
                <Input id="engagement_end" name="engagement_end" type="date" />
              </div>
            </div>

            {/* Status */}
            <div className="space-y-2">
              <Label>Status</Label>
              <Select value={status} onValueChange={(v) => setStatus(v ?? "prospect")}>
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

            {/* ── Stakeholder Mapping ─────────────────────────────────── */}
            <div className="pt-2 border-t">
              <p className="text-sm font-medium mb-1">Stakeholder Mapping</p>
              <p className="text-xs text-muted-foreground mb-4">
                Leads and ideas for this account route in order:
                <span className="font-medium text-foreground"> DU → DH</span>.
                After DH approval, any additional reviewers set up in Stakeholder Mapping will receive the submission.
                Search by typing at least 3 characters.
              </p>

              <div className="space-y-4">
                <div className="space-y-2">
                  <Label>
                    Delivery Unit (DU)
                    <span className="ml-1 text-xs text-muted-foreground">— first reviewer</span>
                  </Label>
                  <UserCombobox
                    value={duId}
                    onChange={(id) => setDuId(id)}
                    token={token ?? ""}
                    placeholder="Search for Delivery Unit…"
                    disabled={loading}
                  />
                </div>

                <div className="space-y-2">
                  <Label>
                    Delivery Head (DH)
                    <span className="ml-1 text-xs text-muted-foreground">— second reviewer</span>
                  </Label>
                  <UserCombobox
                    value={dhId}
                    onChange={(id) => setDhId(id)}
                    token={token ?? ""}
                    placeholder="Search for Delivery Head…"
                    disabled={loading}
                  />
                </div>
              </div>
            </div>

            <div className="flex gap-3 pt-4">
              <Button type="submit" disabled={loading}>
                {loading ? "Creating Account…" : "Create Account"}
              </Button>
              <Button
                type="button"
                variant="outline"
                onClick={() => router.back()}
              >
                Cancel
              </Button>
            </div>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}
