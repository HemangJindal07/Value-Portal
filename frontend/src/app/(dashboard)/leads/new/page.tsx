"use client";

import { useState, useEffect, useRef } from "react";
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
import { Textarea } from "@/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { FileAttachment } from "@/components/ui/file-attachment";
import { AccountCombobox } from "@/components/account-combobox";
import { useAuth } from "@/lib/auth-context";
import { useNavigationGuard } from "@/lib/navigation-guard-context";
import { api, uploadFile } from "@/lib/api";
import { toast } from "sonner";
import type { Account } from "@/types";

const TX_SERVICES = [
  { value: "Quality Engineering",    label: "Quality Engineering",    reviewer: "Manjeet" },
  { value: "Digital Engineering",    label: "Digital Engineering",    reviewer: "Vivek" },
  { value: "Artificial Intelligence",label: "Artificial Intelligence",reviewer: "Vivek" },
  { value: "Data Engineering",       label: "Data Engineering",       reviewer: "Rajiv" },
  { value: "Insurance",              label: "Insurance",              reviewer: "Yuvraj" },
];

// Country -> ISO 4217 currency code. Used to pre-select currency when the
// contact country changes (the user can still override via the dropdown).
const COUNTRY_CURRENCY: Record<string, string> = {
  "Australia": "AUD",
  "Bahrain": "BHD",
  "Belgium": "EUR",
  "Canada": "CAD",
  "Denmark": "DKK",
  "France": "EUR",
  "Germany": "EUR",
  "Hong Kong": "HKD",
  "India": "INR",
  "Indonesia": "IDR",
  "Ireland": "EUR",
  "Kenya": "KES",
  "Kuwait": "KWD",
  "Malaysia": "MYR",
  "Netherlands": "EUR",
  "New Zealand": "NZD",
  "Nigeria": "NGN",
  "North America": "USD",
  "Norway": "NOK",
  "Oman": "OMR",
  "Philippines": "PHP",
  "Qatar": "QAR",
  "Saudi Arabia": "SAR",
  "Singapore": "SGD",
  "South Africa": "ZAR",
  "South Korea": "KRW",
  "Spain": "EUR",
  "Sweden": "SEK",
  "Switzerland": "CHF",
  "Thailand": "THB",
  "United Arab Emirates": "AED",
  "United Kingdom": "GBP",
  "United States": "USD",
  "Vietnam": "VND",
};

const CURRENCY_OPTIONS = Array.from(
  new Set(Object.values(COUNTRY_CURRENCY))
).sort();

const COUNTRIES = [
  "Australia",
  "Bahrain",
  "Belgium",
  "Canada",
  "Denmark",
  "France",
  "Germany",
  "Hong Kong",
  "India",
  "Indonesia",
  "Ireland",
  "Kenya",
  "Kuwait",
  "Malaysia",
  "Netherlands",
  "New Zealand",
  "Nigeria",
  "North America",
  "Norway",
  "Oman",
  "Philippines",
  "Qatar",
  "Saudi Arabia",
  "Singapore",
  "South Africa",
  "South Korea",
  "Spain",
  "Sweden",
  "Switzerland",
  "Thailand",
  "United Arab Emirates",
  "United Kingdom",
  "United States",
  "Vietnam",
];

export default function NewLeadPage() {
  const { token, user } = useAuth();
  const router = useRouter();
  const { registerGuard, requestNavigate } = useNavigationGuard();
  const [loading, setLoading] = useState(false);
  const [accountId, setAccountId] = useState("");
  const [accountType, setAccountType] = useState<"current_lead" | "new_lead" | null>(null);
  const [service, setService] = useState("");
  const [contactCountry, setContactCountry] = useState("");
  const [priority, setPriority] = useState("");
  const [attachment, setAttachment] = useState<File | null>(null);
  const [estimatedValueError, setEstimatedValueError] = useState(false);
  const [estimatedValue, setEstimatedValue] = useState("");
  const [currency, setCurrency] = useState("USD");
  const [isDirty, setIsDirty] = useState(false);
  const isDirtyRef = useRef(false);

  // Keep ref in sync so the guard callback always reads the latest value
  useEffect(() => { isDirtyRef.current = isDirty; }, [isDirty]);

  // Register with the global navigation guard
  useEffect(() => {
    const unregister = registerGuard(() => isDirtyRef.current);
    return unregister;
  }, [registerGuard]);

  // Block browser tab close / hard refresh
  useEffect(() => {
    if (!isDirty) return;
    const handler = (e: BeforeUnloadEvent) => { e.preventDefault(); e.returnValue = ""; };
    window.addEventListener("beforeunload", handler);
    return () => window.removeEventListener("beforeunload", handler);
  }, [isDirty]);

  // Block browser back/forward button while form is dirty.
  // Push a sentinel entry once so the back button has somewhere to "pop" to.
  // Guard against tab-switch popstate events by checking state identity.
  useEffect(() => {
    if (!isDirty) return;
    // Push sentinel only once when form becomes dirty
    window.history.pushState({ navGuard: true }, "", window.location.href);
    const handlePopState = (e: PopStateEvent) => {
      // Tab switches don't carry our sentinel state — ignore them
      if (!e.state || !e.state.navGuard) return;
      window.history.pushState({ navGuard: true }, "", window.location.href);
      requestNavigate(() => router.back());
    };
    window.addEventListener("popstate", handlePopState);
    return () => window.removeEventListener("popstate", handlePopState);
  }, [isDirty, router, requestNavigate]);

  const selectedService = TX_SERVICES.find((s) => s.value === service);

  function handleAccountSelected(account: Account, isNew: boolean) {
    setAccountType(isNew ? "new_lead" : "current_lead");
    if (isNew) setService("");
  }

  function handleAccountCleared() {
    setAccountType(null);
    setService("");
  }

  const ALLOWED_EXTENSIONS = [".pdf", ".doc", ".docx", ".xls", ".xlsx"];
  const MAX_FILE_BYTES = 20 * 1024 * 1024; // 20 MB — matches the backend upload limit

  function getFileExt(filename: string) {
    const idx = filename.lastIndexOf(".");
    return idx >= 0 ? filename.slice(idx).toLowerCase() : "";
  }

  async function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();

    if (!service && accountType !== "new_lead") {
      toast.error("Please select a Service Line before submitting.");
      return;
    }

    const fd = new FormData(e.currentTarget);

    const evRaw = ((fd.get("estimated_value") as string) || "").replace(/,/g, "");
    if (evRaw) {
      const evNum = Number(evRaw);
      if (isNaN(evNum) || evNum < 0) {
        setEstimatedValueError(true);
        toast.error("Estimated value must be a valid positive number.");
        return;
      }
      if (evNum > 999_999_999_999) {
        setEstimatedValueError(true);
        toast.error("Estimated value cannot exceed $999,999,999,999. Please enter a valid amount.");
        return;
      }
    }

    if (attachment) {
      const ext = getFileExt(attachment.name);
      if (!ALLOWED_EXTENSIONS.includes(ext)) {
        toast.error(
          `"${attachment.name}" cannot be uploaded. Only PDF, Word (.doc/.docx), and Excel (.xls/.xlsx) files are accepted.`
        );
        return;
      }
      if (attachment.size > MAX_FILE_BYTES) {
        const sizeMb = (attachment.size / (1024 * 1024)).toFixed(1);
        toast.error(
          `"${attachment.name}" is ${sizeMb} MB. Maximum file size is 20 MB.`
        );
        return;
      }
    }

    setLoading(true);

    try {
      let uploadedDoc: { url: string; name: string } | null = null;
      if (attachment) {
        const uploaded = await uploadFile(attachment, token!);
        uploadedDoc = { url: uploaded.url, name: uploaded.filename };
      }

      const contactName  = (fd.get("contact_name") as string) || null;
      const contactEmail = (fd.get("contact_email") as string) || null;
      const contactTitle = (fd.get("contact_title") as string) || null;
      const contactDetails =
        contactName || contactEmail || contactCountry || contactTitle
          ? { name: contactName, email: contactEmail, country: contactCountry || null, title: contactTitle }
          : null;

      const payload = {
        title:               fd.get("title") as string,
        description:         fd.get("description") as string,
        lead_type:           accountType ?? "current_lead",
        account_id:          fd.get("account_id") as string,
        service:             service || null,
        contact_details:     contactDetails,
        estimated_value:     evRaw ? Number(evRaw) : null,
        currency:            currency || "USD",
        expected_close_date: (fd.get("expected_close_date") as string) || null,
        priority:            priority || "medium",
        supporting_docs:     uploadedDoc ? [uploadedDoc] : [],
      };

      await api("/api/leads", { method: "POST", body: payload, token: token! });
      setIsDirty(false);
      toast.success("Lead submitted successfully.");
      // An executive's own submission is assigned to a reviewer, not to them,
      // so it never appears in their Pending Review tab. Send executives to the
      // Overview tab (value "all", lists all org assignments) so they see it.
      router.push(
        user?.role === "executive" ? "/assignments?tab=all" : "/assignments"
      );
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to submit lead");
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="max-w-2xl">
      <div className="mb-6">
        <h1 className="text-2xl font-bold tracking-tight">Lead Opportunity</h1>
        <p className="text-muted-foreground">
          Log an Opportunity.
        </p>
      </div>

      <form onSubmit={handleSubmit} onChange={() => setIsDirty(true)} className="space-y-4">
        {/* ── Lead Details ── */}
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Lead Details</CardTitle>
            <CardDescription>Describe the opportunity you&apos;ve identified.</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">

            <div className="space-y-2">
              <Label htmlFor="title">Lead Opportunity *</Label>
              <Input
                id="title"
                name="title"
                placeholder="e.g. Cloud migration consulting for Acme"
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="description">Description *</Label>
              <Textarea
                id="description"
                name="description"
                placeholder="Describe the opportunity, client need, and potential scope..."
                rows={4}
                required
              />
            </div>

            {/* Account + Account Type */}
            <div className={accountType !== null ? "grid grid-cols-2 gap-4" : "space-y-2"}>
              <div className="space-y-2">
                <Label>Account *</Label>
                <AccountCombobox
                  token={token!}
                  value={accountId}
                  onChange={setAccountId}
                  onAccountSelected={handleAccountSelected}
                  onCleared={handleAccountCleared}
                  name="account_id"
                  required
                />
              </div>
              {accountType !== null && (
                <div className="space-y-2">
                  <Label>Account Type</Label>
                  <Select value={accountType} disabled>
                    <SelectTrigger className="bg-muted/40 text-muted-foreground cursor-not-allowed">
                      <SelectValue>
                        {accountType === "new_lead" ? "New Account" : "Existing Account"}
                      </SelectValue>
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="current_lead">Existing Account</SelectItem>
                      <SelectItem value="new_lead">New Account</SelectItem>
                    </SelectContent>
                  </Select>
                  <p className="text-[11px] text-muted-foreground">Auto-filled based on account selection</p>
                </div>
              )}
            </div>

          </CardContent>
        </Card>

        {/* ── Client Contact Details ── */}
        <Card>
          <CardHeader>
            <CardDescription>Key contact at the client for this opportunity.</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="contact_name">Name</Label>
                <Input id="contact_name" name="contact_name" placeholder="e.g. John Smith" />
              </div>
              <div className="space-y-2">
                <Label htmlFor="contact_email">Email</Label>
                <Input id="contact_email" name="contact_email" type="email" placeholder="e.g. john@acme.com" />
              </div>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label>Country</Label>
                <Select value={contactCountry} onValueChange={(v) => {
                  const next = v ?? "";
                  setContactCountry(next);
                  if (next && COUNTRY_CURRENCY[next]) {
                    setCurrency(COUNTRY_CURRENCY[next]);
                  }
                }}>
                  <SelectTrigger className="w-full h-9">
                    {contactCountry ? (
                      <span className="flex flex-1 items-center justify-between text-sm">
                        <span>{contactCountry}</span>
                        <span
                          role="button"
                          aria-label="Clear country"
                          onClick={(e) => { e.stopPropagation(); setContactCountry(""); }}
                          className="ml-2 flex h-4 w-4 shrink-0 items-center justify-center rounded-full text-muted-foreground hover:bg-[#B12B35]/10 hover:text-[#B12B35] transition-colors cursor-pointer text-[10px]"
                        >
                          ✕
                        </span>
                      </span>
                    ) : (
                      <SelectValue placeholder="Select country…" />
                    )}
                  </SelectTrigger>
                  <SelectContent
                    alignItemWithTrigger={false}
                    side="bottom"
                    sideOffset={4}
                    className="z-[200] w-[var(--anchor-width)] min-w-[var(--anchor-width)] bg-white border border-[#EDE7E6] shadow-lg"
                  >
                    {COUNTRIES.map((c) => (
                      <SelectItem key={c} value={c}>{c}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label htmlFor="contact_title">Title</Label>
                <Input id="contact_title" name="contact_title" placeholder="e.g. VP of Engineering" />
              </div>
            </div>
          </CardContent>
        </Card>

        {/* ── Service Line ── (hidden for new accounts; auto-routed to Adeesh Jain) */}
        {accountType !== "new_lead" && (
        <Card>
          <CardHeader>
            <CardTitle className="text-base">
              Service Line <span className="text-[#B12B35]">*</span>
            </CardTitle>
            <CardDescription>Select the Tx vertical for this opportunity.</CardDescription>
          </CardHeader>
          <CardContent>
            <Select value={service} onValueChange={(v) => setService(v ?? "")}>
              <SelectTrigger className="w-full">
                <SelectValue placeholder="Select service line…">
                  {selectedService ? selectedService.label : undefined}
                </SelectValue>
              </SelectTrigger>
              <SelectContent
                alignItemWithTrigger={false}
                sideOffset={4}
                className="w-[var(--anchor-width)] min-w-[var(--anchor-width)] bg-white border border-[#EDE7E6] shadow-lg"
              >
                {TX_SERVICES.map((s) => (
                  <SelectItem key={s.value} value={s.value} className="whitespace-normal">
                    {s.label}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
            {selectedService ? (
              <p className="text-[12px] text-[#B12B35] bg-[#B12B35]/5 rounded-md px-3 py-1.5 font-medium mt-2">
                This lead will be submitted to <strong>{selectedService.reviewer}</strong> for review.
              </p>
            ) : (
              <p className="text-[11px] text-muted-foreground mt-2">
                Select a service line to see who will review this lead.
              </p>
            )}
          </CardContent>
        </Card>
        )}


        {/* ── Deal Details ── */}
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Deal Details</CardTitle>
            <CardDescription>Financial and timeline information.</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            {/* Value + Priority */}
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="estimated_value">Estimated Value</Label>
                <Input
                  id="estimated_value"
                  name="estimated_value"
                  type="text"
                  inputMode="decimal"
                  placeholder="e.g. 500,000"
                  value={estimatedValue}
                  className={estimatedValueError ? "border-red-500 focus-visible:ring-red-500/50" : ""}
                  onChange={(e) => {
                    // Strip everything except digits and a single decimal point,
                    // then re-insert thousands separators on the integer portion
                    // so the user sees "900,000" while typing "900000".
                    const cleaned = e.target.value.replace(/[^\d.]/g, "");
                    const firstDot = cleaned.indexOf(".");
                    const normalized =
                      firstDot === -1
                        ? cleaned
                        : cleaned.slice(0, firstDot + 1) +
                          cleaned.slice(firstDot + 1).replace(/\./g, "");
                    const [intPart, decPart] = normalized.split(".");
                    const intFormatted = intPart
                      ? Number(intPart).toLocaleString("en-US")
                      : "";
                    const display =
                      decPart !== undefined ? `${intFormatted}.${decPart}` : intFormatted;
                    setEstimatedValue(display);
                    const raw = normalized;
                    setEstimatedValueError(raw !== "" && (isNaN(Number(raw)) || Number(raw) < 0));
                  }}
                />
                {estimatedValueError && (
                  <p className="text-xs text-red-500">Estimated value cannot be exceeded.</p>
                )}
              </div>
              <div className="space-y-2">
                <Label>Priority</Label>
                <Select value={priority} onValueChange={(v) => setPriority(v ?? "")}>
                  <SelectTrigger className="w-full h-9">
                    <SelectValue placeholder="Select priority…">
                      {priority ? priority.charAt(0).toUpperCase() + priority.slice(1) : undefined}
                    </SelectValue>
                  </SelectTrigger>
                  <SelectContent
                    alignItemWithTrigger={false}
                    side="bottom"
                    sideOffset={4}
                    className="z-[200] w-[var(--anchor-width)] min-w-[var(--anchor-width)] bg-white border border-[#EDE7E6] shadow-lg"
                  >
                    <SelectItem value="high">High</SelectItem>
                    <SelectItem value="medium">Medium</SelectItem>
                    <SelectItem value="low">Low</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="expected_close_date">Expected Close Date</Label>
                <Input
                  id="expected_close_date"
                  name="expected_close_date"
                  type="date"
                  min={new Date().toISOString().split("T")[0]}
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="currency">Currency</Label>
                <Select value={currency} onValueChange={(v) => setCurrency(v ?? "USD")}>
                  <SelectTrigger id="currency" className="w-full h-9">
                    <SelectValue placeholder="Select currency…" />
                  </SelectTrigger>
                  <SelectContent
                    alignItemWithTrigger={false}
                    side="bottom"
                    sideOffset={4}
                    className="z-[200] w-[var(--anchor-width)] min-w-[var(--anchor-width)] max-h-72 overflow-y-auto bg-white border border-[#EDE7E6] shadow-lg"
                  >
                    {CURRENCY_OPTIONS.map((c) => (
                      <SelectItem key={c} value={c}>{c}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
                <p className="text-[11px] text-muted-foreground">
                  Auto-set from selected country; you can override.
                </p>
              </div>
            </div>

            {/* Supporting Document — optional */}
            <div className="space-y-2">
              <Label>Supporting Document</Label>
              <FileAttachment
                file={attachment}
                onChange={setAttachment}
                disabled={loading}
              />
            </div>
          </CardContent>
        </Card>



        <div className="flex gap-3 pt-2">
          <Button type="submit" disabled={loading} className="bg-[#B12B35] hover:bg-[#9a2330]">
            {loading ? "Submitting…" : "Submit Lead"}
          </Button>
          <Button type="button" variant="outline" onClick={() => requestNavigate(() => router.back())} disabled={loading}>
            Cancel
          </Button>
        </div>
      </form>
    </div>
  );
}
