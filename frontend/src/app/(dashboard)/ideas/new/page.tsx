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

export default function NewIdeaPage() {
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
      problem_statement: fd.get("problem_statement") as string,
      proposed_solution: fd.get("proposed_solution") as string,
      idea_category: fd.get("idea_category") as string,
      account_id: fd.get("account_id") as string,
      estimated_saving: fd.get("estimated_saving")
        ? Number(fd.get("estimated_saving"))
        : null,
      estimated_effort: (fd.get("estimated_effort") as string) || "medium",
      estimated_timeline: (fd.get("estimated_timeline") as string) || null,
      impact_area: (fd.get("impact_area") as string)
        ? (fd.get("impact_area") as string).split(",").map((s) => s.trim()).filter(Boolean)
        : [],
      tools_involved: (fd.get("tools_involved") as string)
        ? (fd.get("tools_involved") as string).split(",").map((s) => s.trim()).filter(Boolean)
        : [],
    };

    try {
      await api("/api/ideas", { method: "POST", body: payload, token: token! });
      toast.success("Idea submitted");
      router.push("/ideas");
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to submit idea");
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="max-w-2xl">
      <div className="mb-6">
        <h1 className="text-2xl font-bold tracking-tight">
          Submit Value Idea
        </h1>
        <p className="text-muted-foreground">
          Propose an innovation, automation, or process improvement.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Idea Details</CardTitle>
          <CardDescription>
            Describe the problem and your proposed solution.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="title">Title *</Label>
              <Input
                id="title"
                name="title"
                placeholder="e.g. Automate monthly reporting with Python scripts"
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="problem_statement">Problem Statement *</Label>
              <Textarea
                id="problem_statement"
                name="problem_statement"
                placeholder="What problem does this solve? What's the current pain point?"
                rows={3}
                required
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="proposed_solution">Proposed Solution *</Label>
              <Textarea
                id="proposed_solution"
                name="proposed_solution"
                placeholder="How would you solve it? Describe your approach..."
                rows={3}
                required
              />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label>Category *</Label>
                <Select name="idea_category" required defaultValue="automation">
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="automation">Automation</SelectItem>
                    <SelectItem value="cost_optimization">
                      Cost Optimization
                    </SelectItem>
                    <SelectItem value="efficiency">Efficiency</SelectItem>
                    <SelectItem value="risk_reduction">
                      Risk Reduction
                    </SelectItem>
                    <SelectItem value="innovation">Innovation</SelectItem>
                    <SelectItem value="process_improvement">
                      Process Improvement
                    </SelectItem>
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
                <Label htmlFor="estimated_saving">Est. Savings ($)</Label>
                <Input
                  id="estimated_saving"
                  name="estimated_saving"
                  type="number"
                  step="0.01"
                  placeholder="50000"
                />
              </div>
              <div className="space-y-2">
                <Label>Effort Level</Label>
                <Select name="estimated_effort" defaultValue="medium">
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="low">Low</SelectItem>
                    <SelectItem value="medium">Medium</SelectItem>
                    <SelectItem value="high">High</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label htmlFor="estimated_timeline">Timeline</Label>
                <Input
                  id="estimated_timeline"
                  name="estimated_timeline"
                  placeholder="e.g. 3 months"
                />
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="impact_area">
                  Impact Areas{" "}
                  <span className="text-muted-foreground font-normal">
                    (comma separated)
                  </span>
                </Label>
                <Input
                  id="impact_area"
                  name="impact_area"
                  placeholder="Operations, Finance, IT"
                />
              </div>
              <div className="space-y-2">
                <Label htmlFor="tools_involved">
                  Tools / Tech{" "}
                  <span className="text-muted-foreground font-normal">
                    (comma separated)
                  </span>
                </Label>
                <Input
                  id="tools_involved"
                  name="tools_involved"
                  placeholder="Python, Power BI, Terraform"
                />
              </div>
            </div>

            <div className="flex gap-3 pt-4">
              <Button type="submit" disabled={loading}>
                {loading ? "Submitting..." : "Submit Idea"}
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
