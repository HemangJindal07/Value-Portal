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

export default function NewAccountPage() {
  const { token } = useAuth();
  const router = useRouter();
  const [loading, setLoading] = useState(false);

  async function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    setLoading(true);

    const formData = new FormData(e.currentTarget);
    const payload = {
      account_name: formData.get("account_name") as string,
      industry: (formData.get("industry") as string) || null,
      region: (formData.get("region") as string) || null,
      contract_value: formData.get("contract_value")
        ? Number(formData.get("contract_value"))
        : null,
      engagement_start: (formData.get("engagement_start") as string) || null,
      engagement_end: (formData.get("engagement_end") as string) || null,
      account_status: (formData.get("account_status") as string) || "prospect",
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
          Register a new client account.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Account Details</CardTitle>
          <CardDescription>
            Fill in the client account information.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="account_name">Account Name *</Label>
              <Input
                id="account_name"
                name="account_name"
                placeholder="e.g. Acme Corp"
                required
              />
            </div>

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
                <Label htmlFor="region">Region</Label>
                <Input
                  id="region"
                  name="region"
                  placeholder="e.g. North America"
                />
              </div>
            </div>

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

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="engagement_start">Engagement Start</Label>
                <Input
                  id="engagement_start"
                  name="engagement_start"
                  type="date"
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="engagement_end">Engagement End</Label>
                <Input
                  id="engagement_end"
                  name="engagement_end"
                  type="date"
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label>Status</Label>
              <Select name="account_status" defaultValue="prospect">
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

            <div className="flex gap-3 pt-4">
              <Button type="submit" disabled={loading}>
                {loading ? "Creating Account..." : "Create Account"}
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
