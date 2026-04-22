"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { ArrowLeft, Check } from "lucide-react";
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
import type { Account } from "@/types";

// ── DU vertical routing map ───────────────────────────────────────────────
const DU_VERTICALS = [
  { value: "QE",        label: "QE",        desc: "Quality Engineering",      sme: "Manjeet" },
  { value: "DE",        label: "DE",        desc: "Data Engineering",         sme: "Vivek" },
  { value: "AI",        label: "AI",        desc: "Artificial Intelligence",  sme: "Vivek" },
  { value: "Data",      label: "Data",      desc: "Data (SME)",               sme: "Rajiv Diwan" },
  { value: "Insurance", label: "Insurance", desc: "Insurance Vertical",       sme: "Manjeet" },
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

export default function EditAccountPage() {
  const { id } = useParams<{ id: string }>();
  const { token } = useAuth();
  const router = useRouter();
  const [loading, setLoading]           = useState(false);
  const [loadAccount, setLoadAccount]   = useState(true);
  const [accountName, setAccountName]   = useState("");
  const [industry, setIndustry]         = useState("");
  const [duId, setDuId]                 = useState<string | null>(null);
  const [dhId, setDhId]                 = useState<string | null>(null);
  const [region, setRegion]             = useState<string>("");
  const [status, setStatus]             = useState<string>("prospect");
  const [contractValue, setContractValue] = useState<string>("");
  const [engagementStart, setEngagementStart] = useState<string>("");
  const [engagementEnd, setEngagementEnd]     = useState<string>("");
  const [duVertical, setDuVertical]     = useState<string>("");
  const [services, setServices]         = useState<string[]>([]);

  useEffect(() => {
    if (!token || !id) return;
    api<Account>(`/api/accounts/${id}`, { token })
      .then((acct) => {
        setAccountName(acct.account_name);
        setIndustry(acct.industry ?? "");
        setRegion(acct.region ?? "");
        setStatus(acct.account_status ?? "prospect");
        setContractValue(acct.contract_value != null ? String(acct.contract_value) : "");
        setEngagementStart(acct.engagement_start ?? "");
        setEngagementEnd(acct.engagement_end ?? "");
        setDuId(acct.practice_leader_id);
        setDhId(acct.account_owner_id);
        setServices(acct.services ?? []);
      })
      .catch(() => {
        toast.error("Could not load account");
        router.push("/accounts");
      })
      .finally(() => setLoadAccount(false));
  }, [token, id, router]);

  function toggleService(val: string) {
    setServices((prev) =>
      prev.includes(val) ? prev.filter((s) => s !== val) : [...prev, val]
    );
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (!token || !id) return;
    setLoading(true);
    const payload = {
      account_name:       accountName,
      industry:           industry || null,
      region:             region || null,
      contract_value:     contractValue ? Number(contractValue) : null,
      engagement_start:   engagementStart || null,
      engagement_end:     engagementEnd || null,
      account_status:     status || "prospect",
      account_owner_id:   dhId || null,
      practice_leader_id: duId || null,
      services:           services.length > 0 ? services : null,
    };
    try {
      await api(`/api/accounts/${id}`, { method: "PATCH", body: payload, token });
      toast.success("Account updated");
      router.push(`/accounts/${id}`);
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to update account");
    } finally {
      setLoading(false);
    }
  }

  if (loadAccount) {
    return <p className="text-sm text-muted-foreground py-12 text-center">Loading…</p>;
  }

  return (
    <div className="max-w-2xl">
      <div className="mb-6 flex items-center gap-3">
        <Button variant="ghost" size="icon" onClick={() => router.push(`/accounts/${id}`)}>
          <ArrowLeft className="h-4 w-4" />
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
          <form onSubmit={handleSubmit} className="space-y-5">

            <div className="space-y-2">
              <Label htmlFor="account_name">Account Name *</Label>
              <Input
                id="account_name"
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
                <span className="ml-1 text-xs text-muted-foreground">— Tx verticals offered to this account</span>
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

            <div className="space-y-2">
              <Label htmlFor="contract_value">Contract Value ($)</Label>
              <Input
                id="contract_value"
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
                  type="date"
                  value={engagementStart}
                  onChange={(e) => setEngagementStart(e.target.value)}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="engagement_end">Engagement End</Label>
                <Input
                  id="engagement_end"
                  type="date"
                  value={engagementEnd}
                  onChange={(e) => setEngagementEnd(e.target.value)}
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label>Status</Label>
              <Select value={status} onValueChange={(v) => setStatus(v ?? "prospect")}>
                <SelectTrigger><SelectValue /></SelectTrigger>
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
                  Select a DU vertical to see the assigned SME, then confirm or override below.
                </p>
              </div>

              {/* DU Vertical Selector */}
              <div className="space-y-3">
                <Label>
                  Delivery Unit (DU)
                  <span className="ml-1 text-xs text-muted-foreground">— first reviewer</span>
                </Label>

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
                    Search and select the user below to assign as DU.
                  </p>
                )}

                <UserCombobox
                  value={duId}
                  onChange={(uid) => setDuId(uid)}
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
                  onChange={(uid) => setDhId(uid)}
                  token={token ?? ""}
                  placeholder="Search for Delivery Head…"
                  disabled={loading}
                />
              </div>
            </div>

            <div className="flex gap-3 pt-2">
              <Button type="submit" disabled={loading} className="bg-[#B12B35] hover:bg-[#9a2330]">
                {loading ? "Saving…" : "Save Changes"}
              </Button>
              <Button type="button" variant="outline" onClick={() => router.push(`/accounts/${id}`)}>
                Cancel
              </Button>
            </div>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}
