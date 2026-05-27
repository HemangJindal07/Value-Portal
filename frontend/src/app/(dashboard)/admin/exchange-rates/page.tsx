"use client";

import { useState, useEffect, useCallback } from "react";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import { toast } from "sonner";

type Rate = {
  currency: string;
  rate_to_usd: number;
  updated_at: string | null;
};

const currencyLabel = (code: string) => (code === "OTH" ? "Others (OTH)" : code);

export default function ExchangeRatesPage() {
  const { token, user } = useAuth();
  const [rates, setRates] = useState<Rate[]>([]);
  const [drafts, setDrafts] = useState<Record<string, string>>({});
  const [savingCode, setSavingCode] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  const loadRates = useCallback(async () => {
    if (!token) return;
    try {
      const data = await api<Rate[]>("/api/exchange-rates", { token: token ?? undefined });
      setRates(data);
      setDrafts(
        Object.fromEntries(data.map((r) => [r.currency, String(r.rate_to_usd)]))
      );
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Failed to load rates.");
    } finally {
      setLoading(false);
    }
  }, [token]);

  useEffect(() => {
    loadRates();
  }, [loadRates]);

  if (user && user.role !== "admin") {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-muted-foreground">Admin access required.</p>
      </div>
    );
  }

  async function handleSave(currency: string) {
    const raw = drafts[currency];
    const value = Number(raw);
    if (raw === undefined || raw === "" || Number.isNaN(value) || value < 0) {
      toast.error("Enter a valid non-negative rate.");
      return;
    }
    setSavingCode(currency);
    try {
      await api(`/api/exchange-rates/${currency}`, {
        method: "PUT",
        token: token ?? undefined,
        body: { rate_to_usd: value },
      });
      toast.success(`${currency} rate updated.`);
      await loadRates();
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Failed to update rate.");
    } finally {
      setSavingCode(null);
    }
  }

  return (
    <div className="max-w-3xl space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-[#232222]">Exchange Rates</h1>
        <p className="text-sm text-[#5D5D5D] mt-1">
          Rates convert each currency to USD for dashboard Pipeline Value and Won to Date totals.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Currency &rarr; USD</CardTitle>
          <CardDescription>
            Value of 1 unit of the currency in USD (e.g. INR = 0.012 means 1 INR = $0.012).
          </CardDescription>
        </CardHeader>
        <CardContent>
          {loading ? (
            <p className="text-sm text-muted-foreground">Loading…</p>
          ) : (
            <div className="space-y-3">
              {rates.map((r) => (
                <div key={r.currency} className="flex items-center gap-4">
                  <div className="w-32 font-medium text-sm">{currencyLabel(r.currency)}</div>
                  <Input
                    type="number"
                    step="0.0001"
                    min="0"
                    value={drafts[r.currency] ?? ""}
                    onChange={(e) =>
                      setDrafts((d) => ({ ...d, [r.currency]: e.target.value }))
                    }
                    className="w-40 h-9"
                    disabled={r.currency === "USD"}
                  />
                  <div className="flex-1 text-xs text-muted-foreground">
                    {r.updated_at
                      ? `Updated ${new Date(r.updated_at).toLocaleDateString()}`
                      : ""}
                  </div>
                  <Button
                    size="sm"
                    onClick={() => handleSave(r.currency)}
                    disabled={savingCode === r.currency || r.currency === "USD"}
                    className="bg-[#B12B35] hover:bg-[#9a2330] text-white"
                  >
                    {savingCode === r.currency ? "Saving…" : "Save"}
                  </Button>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
