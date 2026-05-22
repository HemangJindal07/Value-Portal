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

// ── Services + Stakeholder Mapping (DU/DH) commented out ─────────────────
// Routing is now fully automatic via service_routing table when a lead is submitted.
// const DU_VERTICALS = [ ... ];
// const TX_SERVICES  = [ ... ];

// Canonical regions — only org regions, no countries.
const REGIONS = ["North America", "EMEA", "APAC"];

// Canonical industry list (kept in sync with components/account-combobox.tsx).
const INDUSTRIES = [
  "Banking & Financial Services",
  "Credit Unions",
  "Education & EduTech",
  "Gaming",
  "Insurance",
  "Non-Profit & Public Sector",
  "Healthcare & Life Sciences",
  "Energy & Utilities",
  "QSR",
  "Retail & e-commerce",
  "ISV & High Tech",
  "Travel & Logistics",
  "Media & Entertainment",
  "Telecom",
  "Manufacturing & Logistics",
  "Others",
];

export default function NewAccountPage() {
  const { token, user } = useAuth();
  const router = useRouter();
  const [loading, setLoading] = useState(false);
  const [region, setRegion] = useState<string>("");
  const [industry, setIndustry] = useState<string>("");
  const [status, setStatus] = useState<string>("prospect");
  const [engagementStart, setEngagementStart] = useState<string>("");

  if (user && user.role !== "admin") {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-muted-foreground">Admin access required.</p>
      </div>
    );
  }

  async function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    setLoading(true);

    const payload = {
      account_name:     formData.get("account_name") as string,
      industry:         industry || null,
      region:           region || null,
      contract_value:   formData.get("contract_value") ? Number(formData.get("contract_value")) : null,
      engagement_start: (formData.get("engagement_start") as string) || null,
      engagement_end:   (formData.get("engagement_end") as string) || null,
      account_status:   status || "prospect",
      // DU / DH / services omitted — routing handled automatically via lead service field
    };

    try {
      await api("/api/accounts", { method: "POST", body: payload, token: token! });
      toast.success("Account created");
      router.push("/accounts");
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to create account");
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="max-w-2xl">
      <div className="mb-6">
        <h1 className="text-2xl font-bold tracking-tight">New Account</h1>
        <p className="text-muted-foreground">
          Register a new client account.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Account Details</CardTitle>
          <CardDescription>
            Fill in the client account information. Reviewer routing is handled automatically when a lead is submitted.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-5">

            {/* Account Name */}
            <div className="space-y-2">
              <Label htmlFor="account_name">Account Name *</Label>
              <Input id="account_name" name="account_name" placeholder="e.g. Acme Corp" required />
            </div>

            {/* Industry + Region */}
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="industry">Industry</Label>
                <Select value={industry} onValueChange={(v) => setIndustry(v ?? "")}>
                  <SelectTrigger id="industry" className="w-full">
                    <SelectValue placeholder="Select industry…" />
                  </SelectTrigger>
                  <SelectContent
                    alignItemWithTrigger={false}
                    side="bottom"
                    sideOffset={4}
                    className="z-[200] w-[var(--anchor-width)] min-w-[var(--anchor-width)] max-h-72 overflow-y-auto bg-white border border-[#EDE7E6] shadow-lg"
                  >
                    {INDUSTRIES.map((ind) => (
                      <SelectItem key={ind} value={ind}>{ind}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label>Region</Label>
                <Select value={region} onValueChange={(v) => setRegion(v ?? "")}>
                  <SelectTrigger className="w-full">
                    <SelectValue placeholder="Select region…" />
                  </SelectTrigger>
                  <SelectContent
                    alignItemWithTrigger={false}
                    side="bottom"
                    sideOffset={4}
                    className="z-[200] w-[var(--anchor-width)] min-w-[var(--anchor-width)] bg-white border border-[#EDE7E6] shadow-lg"
                  >
                    {REGIONS.map((r) => (
                      <SelectItem key={r} value={r}>{r}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
            </div>

            {/* Contract Value */}
            <div className="space-y-2">
              <Label htmlFor="contract_value">Contract Value ($)</Label>
              <Input id="contract_value" name="contract_value" type="number" step="0.01" placeholder="e.g. 500000" />
            </div>

            {/* Dates */}
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
                  min={engagementStart || undefined}
                />
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

            {/* Services + Stakeholder Mapping removed — auto-routed via lead service field */}

            <div className="flex gap-3 pt-2">
              <Button type="submit" disabled={loading} className="bg-[#B12B35] hover:bg-[#9a2330]">
                {loading ? "Creating…" : "Create Account"}
              </Button>
              <Button type="button" variant="outline" onClick={() => router.back()}>
                Cancel
              </Button>
            </div>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}
