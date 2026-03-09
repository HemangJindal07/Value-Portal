"use client";

import { useEffect, useState, useCallback } from "react";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  BarChart3,
  Download,
  TrendingUp,
  DollarSign,
  Target,
  Lightbulb,
} from "lucide-react";
import { toast } from "sonner";

type DashboardStats = {
  total_leads: number;
  total_ideas: number;
  total_accounts: number;
  active_users: number;
  leads_by_status: Record<string, number>;
  ideas_by_status: Record<string, number>;
  pending_assignments: number;
  pipeline_value: number;
  won_value: number;
  total_savings: number;
};

type ImpactRow = {
  impact_id: string;
  submission_type: string;
  submission_id: string;
  revenue_influenced: number | null;
  cost_saved: number | null;
  efficiency_gain: string | null;
  measurement_date: string;
  verified: boolean;
  measurer?: { id: string; full_name: string };
};

function formatCurrency(n: number) {
  return new Intl.NumberFormat("en-US", {
    style: "currency",
    currency: "USD",
    maximumFractionDigits: 0,
  }).format(n);
}

export default function ReportsPage() {
  const { token } = useAuth();
  const [stats, setStats] = useState<DashboardStats | null>(null);
  const [impacts, setImpacts] = useState<ImpactRow[]>([]);
  const [loading, setLoading] = useState(true);

  const fetchData = useCallback(async () => {
    if (!token) return;
    try {
      const [s, i] = await Promise.all([
        api<DashboardStats>("/api/dashboard/stats", { token }),
        api<ImpactRow[]>("/api/governance/impact", { token }),
      ]);
      setStats(s);
      setImpacts(i);
    } catch {
      toast.error("Failed to load report data");
    } finally {
      setLoading(false);
    }
  }, [token]);

  useEffect(() => {
    fetchData();
  }, [fetchData]);

  const exportCSV = () => {
    if (!stats) return;
    const rows = [
      ["Metric", "Value"],
      ["Total Leads", String(stats.total_leads)],
      ["Total Ideas", String(stats.total_ideas)],
      ["Pipeline Value", String(stats.pipeline_value)],
      ["Won Value", String(stats.won_value)],
      ["Total Savings", String(stats.total_savings)],
      ["Accounts", String(stats.total_accounts)],
      ["Active Users", String(stats.active_users)],
      ["Pending Assignments", String(stats.pending_assignments)],
      ...Object.entries(stats.leads_by_status).map(([k, v]) => [
        `Leads - ${k}`,
        String(v),
      ]),
      ...Object.entries(stats.ideas_by_status).map(([k, v]) => [
        `Ideas - ${k}`,
        String(v),
      ]),
    ];
    const csv = rows.map((r) => r.join(",")).join("\n");
    const blob = new Blob([csv], { type: "text/csv" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = `value-portal-report-${new Date().toISOString().slice(0, 10)}.csv`;
    a.click();
    URL.revokeObjectURL(url);
    toast.success("Report exported");
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center py-20 text-muted-foreground">
        Loading reports...
      </div>
    );
  }

  const s = stats!;
  const totalImpactRevenue = impacts.reduce(
    (sum, i) => sum + (i.revenue_influenced || 0),
    0
  );
  const totalImpactSavings = impacts.reduce(
    (sum, i) => sum + (i.cost_saved || 0),
    0
  );

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Reports</h1>
          <p className="text-muted-foreground">
            Analytics, metrics, and exportable reports.
          </p>
        </div>
        <Button variant="outline" onClick={exportCSV}>
          <Download className="mr-2 h-4 w-4" />
          Export CSV
        </Button>
      </div>

      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Total Leads
            </CardTitle>
            <Target className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{s.total_leads}</div>
            <p className="text-xs text-muted-foreground">
              {s.leads_by_status["won"] || 0} won
            </p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Total Ideas
            </CardTitle>
            <Lightbulb className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{s.total_ideas}</div>
            <p className="text-xs text-muted-foreground">
              {s.ideas_by_status["implemented"] || 0} implemented
            </p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Revenue Influenced
            </CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {formatCurrency(totalImpactRevenue || s.won_value)}
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              Cost Savings
            </CardTitle>
            <DollarSign className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {formatCurrency(totalImpactSavings || s.total_savings)}
            </div>
          </CardContent>
        </Card>
      </div>

      <div className="grid gap-4 lg:grid-cols-2">
        <Card>
          <CardHeader>
            <CardTitle className="text-base flex items-center gap-2">
              <BarChart3 className="h-4 w-4" />
              Lead Funnel
            </CardTitle>
            <CardDescription>Breakdown by status</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-2">
              {Object.entries(s.leads_by_status).map(([status, count]) => {
                const pct =
                  s.total_leads > 0
                    ? Math.round((count / s.total_leads) * 100)
                    : 0;
                return (
                  <div key={status} className="space-y-1">
                    <div className="flex items-center justify-between text-sm">
                      <span className="capitalize">
                        {status.replace("_", " ")}
                      </span>
                      <span className="text-muted-foreground">
                        {count} ({pct}%)
                      </span>
                    </div>
                    <div className="h-2 rounded-full bg-secondary">
                      <div
                        className="h-full rounded-full bg-primary transition-all"
                        style={{ width: `${pct}%` }}
                      />
                    </div>
                  </div>
                );
              })}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-base flex items-center gap-2">
              <BarChart3 className="h-4 w-4" />
              Idea Funnel
            </CardTitle>
            <CardDescription>Breakdown by status</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-2">
              {Object.entries(s.ideas_by_status).map(([status, count]) => {
                const pct =
                  s.total_ideas > 0
                    ? Math.round((count / s.total_ideas) * 100)
                    : 0;
                return (
                  <div key={status} className="space-y-1">
                    <div className="flex items-center justify-between text-sm">
                      <span className="capitalize">
                        {status.replace("_", " ")}
                      </span>
                      <span className="text-muted-foreground">
                        {count} ({pct}%)
                      </span>
                    </div>
                    <div className="h-2 rounded-full bg-secondary">
                      <div
                        className="h-full rounded-full bg-primary transition-all"
                        style={{ width: `${pct}%` }}
                      />
                    </div>
                  </div>
                );
              })}
            </div>
          </CardContent>
        </Card>
      </div>

      {impacts.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Impact Measurements</CardTitle>
            <CardDescription>
              Verified business impact from implemented ideas and won leads
            </CardDescription>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Type</TableHead>
                  <TableHead>Revenue Influenced</TableHead>
                  <TableHead>Cost Saved</TableHead>
                  <TableHead>Efficiency Gain</TableHead>
                  <TableHead>Measured By</TableHead>
                  <TableHead>Date</TableHead>
                  <TableHead>Verified</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {impacts.map((i) => (
                  <TableRow key={i.impact_id}>
                    <TableCell>
                      <Badge variant="outline" className="capitalize">
                        {i.submission_type}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      {i.revenue_influenced
                        ? formatCurrency(i.revenue_influenced)
                        : "—"}
                    </TableCell>
                    <TableCell>
                      {i.cost_saved ? formatCurrency(i.cost_saved) : "—"}
                    </TableCell>
                    <TableCell>{i.efficiency_gain || "—"}</TableCell>
                    <TableCell>
                      {i.measurer?.full_name || "Unknown"}
                    </TableCell>
                    <TableCell>{i.measurement_date}</TableCell>
                    <TableCell>
                      <Badge
                        variant={i.verified ? "default" : "secondary"}
                      >
                        {i.verified ? "Verified" : "Pending"}
                      </Badge>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
