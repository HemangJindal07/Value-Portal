"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Check } from "lucide-react";
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
import { Badge } from "@/components/ui/badge";
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

// ── DU vertical routing map (from image) ──────────────────────────────────
const DU_VERTICALS = [
  { value: "QE",        label: "QE",       desc: "Quality Engineering",            sme: "Manjeet" },
  { value: "DE",        label: "DE",       desc: "Data Engineering",               sme: "Vivek" },
  { value: "AI",        label: "AI",       desc: "Artificial Intelligence",        sme: "Vivek" },
  { value: "Data",      label: "Data",     desc: "Data (SME)",                     sme: "Rajiv Diwan" },
  { value: "Insurance", label: "Insurance", desc: "Insurance Vertical",            sme: "Manjeet" },
];

// ── TX Services (multi-select) ────────────────────────────────────────────
const TX_SERVICES = [
  { value: "QE",        label: "QE",        desc: "Quality Engineering" },
  { value: "DE",        label: "DE",        desc: "Data Engineering" },
  { value: "AI_Data",   label: "AI / Data", desc: "Artificial Intelligence & Data" },
  { value: "Insurance", label: "Insurance", desc: "Insurance Vertical" },
];

const REGIONS = [
  "Australia", "Brazil", "Canada", "China", "France", "Germany",
  "India", "Japan", "Malaysia", "Mexico", "Middle East", "Netherlands",
  "New Zealand", "Philippines", "Poland", "Singapore", "South Africa",
  "South Korea", "Sweden", "UAE", "United Kingdom", "United States", "Other",
];

export default function NewAccountPage() {
  const { token } = useAuth();
  const router = useRouter();
  const [loading, setLoading] = useState(false);

  const [duId, setDuId]     = useState<string | null>(null);
  const [dhId, setDhId]     = useState<string | null>(null);
  const [region, setRegion] = useState<string>("");
  const [status, setStatus] = useState<string>("prospect");

  // DU vertical selector
  const [duVertical, setDuVertical] = useState<string>("");

  // Services multi-select
  const [services, setServices] = useState<string[]>([]);

  function toggleService(val: string) {
    setServices((prev) =>
      prev.includes(val) ? prev.filter((s) => s !== val) : [...prev, val]
    );
  }

  async function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    setLoading(true);

    const payload = {
      account_name:       formData.get("account_name") as string,
      industry:           (formData.get("industry") as string) || null,
      region:             region || null,
      contract_value:     formData.get("contract_value") ? Number(formData.get("contract_value")) : null,
      engagement_start:   (formData.get("engagement_start") as string) || null,
      engagement_end:     (formData.get("engagement_end") as string) || null,
      account_status:     status || "prospect",
      account_owner_id:   dhId || null,
      practice_leader_id: duId || null,
      sales_lead_id:      null,
      services:           services.length > 0 ? services : null,
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
                <Input id="industry" name="industry" placeholder="e.g. Financial Services" />
              </div>
              <div className="space-y-2">
                <Label>Region / Country</Label>
                <Select value={region} onValueChange={(v) => setRegion(v ?? "")}>
                  <SelectTrigger>
                    <SelectValue placeholder="Select region…" />
                  </SelectTrigger>
                  <SelectContent>
                    {REGIONS.map((r) => (
                      <SelectItem key={r} value={r}>{r}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
            </div>

            {/* Services offered to this account */}
            <div className="space-y-2">
              <Label>
                Services
                <span className="ml-1 text-xs text-muted-foreground">— TX verticals offered to this account</span>
              </Label>
              <div className="flex flex-wrap gap-2">
                {TX_SERVICES.map((svc) => {
                  const selected = services.includes(svc.value);
                  return (
                    <button
                      key={svc.value}
                      type="button"
                      onClick={() => toggleService(svc.value)}
                      className={`inline-flex items-center gap-1.5 rounded-lg border px-3 py-1.5 text-sm font-medium transition-all cursor-pointer ${
                        selected
                          ? "border-[#B12B35] bg-[#B12B35]/8 text-[#B12B35]"
                          : "border-[#E5E5E5] bg-white text-[#5D5D5D] hover:border-[#B12B35]/40 hover:text-[#B12B35]"
                      }`}
                    >
                      {selected && <Check className="h-3.5 w-3.5" />}
                      <span>{svc.label}</span>
                      <span className="text-[11px] opacity-70">({svc.desc})</span>
                    </button>
                  );
                })}
              </div>
              {services.length > 0 && (
                <p className="text-xs text-muted-foreground">
                  Selected: {services.map((s) => TX_SERVICES.find((t) => t.value === s)?.label).join(", ")}
                </p>
              )}
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

            {/* ── Stakeholder Mapping ─────────────────────────────────────── */}
            <div className="pt-2 border-t space-y-5">
              <div>
                <p className="text-sm font-semibold">Stakeholder Mapping</p>
                <p className="text-xs text-muted-foreground mt-0.5">
                  Leads for this account route in order:
                  <span className="font-medium text-foreground"> DU → DH</span>.
                  Select a DU vertical to see the assigned SME, then confirm or override.
                </p>
              </div>

              {/* DU Vertical Selector */}
              <div className="space-y-3">
                <Label>
                  Delivery Unit (DU)
                  <span className="ml-1 text-xs text-muted-foreground">— first reviewer</span>
                </Label>

                {/* Vertical cards */}
                <div className="grid grid-cols-3 gap-2">
                  {DU_VERTICALS.map((v) => {
                    const active = duVertical === v.value;
                    return (
                      <button
                        key={v.value}
                        type="button"
                        onClick={() => setDuVertical(active ? "" : v.value)}
                        className={`text-left rounded-lg border px-3 py-2.5 transition-all cursor-pointer ${
                          active
                            ? "border-[#B12B35] bg-[#B12B35]/8 ring-1 ring-[#B12B35]/20"
                            : "border-[#E5E5E5] bg-white hover:border-[#B12B35]/40"
                        }`}
                      >
                        <div className="flex items-center justify-between gap-2">
                          <div>
                            <p className={`text-sm font-semibold leading-none ${active ? "text-[#B12B35]" : "text-[#232222]"}`}>
                              {v.label}
                            </p>
                            <p className="text-[11px] text-muted-foreground mt-0.5">{v.desc}</p>
                          </div>
                          <Badge
                            variant="secondary"
                            className={`text-[10px] shrink-0 ${active ? "bg-[#B12B35]/10 text-[#B12B35]" : "bg-[#F3F3F3] text-[#5D5D5D]"}`}
                          >
                            {v.sme}
                          </Badge>
                        </div>
                      </button>
                    );
                  })}
                </div>

                {duVertical && (
                  <p className="text-xs text-[#B12B35] bg-[#B12B35]/5 rounded-md px-3 py-1.5">
                    SME for <strong>{DU_VERTICALS.find(v => v.value === duVertical)?.label}</strong>:{" "}
                    <strong>{DU_VERTICALS.find(v => v.value === duVertical)?.sme}</strong>.
                    Search and select the user below to assign them as DU.
                  </p>
                )}

                {/* User search — confirm/override the SME */}
                <UserCombobox
                  value={duId}
                  onChange={(id) => setDuId(id)}
                  token={token ?? ""}
                  placeholder={
                    duVertical
                      ? `Search for ${DU_VERTICALS.find(v => v.value === duVertical)?.sme ?? "DU"}…`
                      : "Search for Delivery Unit…"
                  }
                  disabled={loading}
                />
              </div>

              {/* DH */}
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
