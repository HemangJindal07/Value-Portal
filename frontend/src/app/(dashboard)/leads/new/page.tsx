"use client";

import { useEffect, useState } from "react";
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
import { AccountCombobox } from "@/components/account-combobox";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import { toast } from "sonner";
import type { Account } from "@/types";

export default function NewLeadPage() {
  const { token } = useAuth();
  const router = useRouter();
  const [loading, setLoading] = useState(false);
  const [accounts, setAccounts] = useState<Account[]>([]);
  const [accountId, setAccountId] = useState("");

  useEffect(() => {
    if (!token) return;
    api<Account[]>("/api/accounts", { token }).then(setAccounts).catch(() => {});
  }, [token]);

  async function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    setLoading(true);

    const fd = new FormData(e.currentTarget);
    const payload = {
      title: fd.get("title") as string,
      description: fd.get("description") as string,
      lead_type: fd.get("lead_type") as string,
      account_id: fd.get("account_id") as string,
      estimated_value: fd.get("estimated_value")
        ? Number(fd.get("estimated_value"))
        : null,
      currency: (fd.get("currency") as string) || "USD",
      probability: fd.get("probability")
        ? Number(fd.get("probability"))
        : null,
      expected_close_date: (fd.get("expected_close_date") as string) || null,
      priority: (fd.get("priority") as string) || "medium",
    };

    try {
      await api("/api/leads", { method: "POST", body: payload, token: token! });
      toast.success("Lead submitted");
      router.push("/leads");
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to submit lead");
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="max-w-2xl">
      <div className="mb-6">
        <h1 className="text-2xl font-bold tracking-tight">Submit New Lead</h1>
        <p className="text-muted-foreground">
          Log a cross-sell, upsell, or new service opportunity.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Lead Details</CardTitle>
          <CardDescription>
            Describe the opportunity you&apos;ve identified.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="title">Title *</Label>
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

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label>Lead Type *</Label>
                <Select name="lead_type" required defaultValue="cross_sell">
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="cross_sell">Cross-sell</SelectItem>
                    <SelectItem value="upsell">Upsell</SelectItem>
                    <SelectItem value="new_service">New Service</SelectItem>
                    <SelectItem value="expansion">Expansion</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-2">
                <Label>Account *</Label>
                <AccountCombobox
                  accounts={accounts}
                  value={accountId}
                  onChange={setAccountId}
                  name="account_id"
                  placeholder="Select or type to search account..."
                  required
                />
              </div>
            </div>

            <div className="grid grid-cols-3 gap-4">
              <div className="space-y-2">
                <Label htmlFor="estimated_value">Estimated Value ($)</Label>
                <Input
                  id="estimated_value"
                  name="estimated_value"
                  type="number"
                  step="0.01"
                  placeholder="500000"
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="probability">Probability (%)</Label>
                <Input
                  id="probability"
                  name="probability"
                  type="number"
                  min="0"
                  max="100"
                  placeholder="60"
                />
              </div>
              <div className="space-y-2">
                <Label>Priority</Label>
                <Select name="priority" defaultValue="medium">
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
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
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="currency">Currency</Label>
                <Input
                  id="currency"
                  name="currency"
                  defaultValue="USD"
                  placeholder="USD"
                />
              </div>
            </div>

            <div className="flex gap-3 pt-4">
              <Button type="submit" disabled={loading}>
                {loading ? "Submitting..." : "Submit Lead"}
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
