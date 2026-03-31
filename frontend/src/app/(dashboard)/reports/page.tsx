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
import { BarChart3, Download, Target, Lightbulb, Trophy } from "lucide-react";
import { toast } from "sonner";

type UserStats = {
  total_leads: number;
  total_ideas: number;
  leads_by_status: Record<string, number>;
  ideas_by_status: Record<string, number>;
  pending_assignments: number;
};

type ScoreEvent = {
  event_id: string;
  event_type: string;
  points: number;
  created_at: string;
};

export default function ReportsPage() {
  const { token, user } = useAuth();
  const [stats, setStats] = useState<UserStats | null>(null);
  const [scoreEvents, setScoreEvents] = useState<ScoreEvent[]>([]);
  const [totalPoints, setTotalPoints] = useState(0);
  const [loading, setLoading] = useState(true);

  const fetchData = useCallback(async () => {
    if (!token) return;
    try {
      const [s, scoreData] = await Promise.all([
        api<UserStats>("/api/dashboard/stats", { token }),
        api<{ total_points: number; events?: ScoreEvent[] }>("/api/scores/me", { token }),
      ]);
      setStats(s);
      setTotalPoints(scoreData.total_points || 0);
      setScoreEvents(scoreData.events || []);
    } catch {
      toast.error("Failed to load report data.");
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
      ["My Report — Value Portal", ""],
      ["User", user?.full_name || user?.email || ""],
      ["Generated", new Date().toLocaleString()],
      ["", ""],
      ["Metric", "Value"],
      ["My Leads", String(stats.total_leads)],
      ["My Value Ideas", String(stats.total_ideas)],
      ["Pending Assignments", String(stats.pending_assignments)],
      ["My Score (Points)", String(totalPoints)],
      ["", ""],
      ["Lead Status", "Count"],
      ...Object.entries(stats.leads_by_status).map(([k, v]) => [
        k.replace(/_/g, " "),
        String(v),
      ]),
      ["", ""],
      ["Idea Status", "Count"],
      ...Object.entries(stats.ideas_by_status).map(([k, v]) => [
        k.replace(/_/g, " "),
        String(v),
      ]),
    ];
    const csv = rows.map((r) => r.join(",")).join("\n");
    const blob = new Blob([csv], { type: "text/csv" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = `my-report-${new Date().toISOString().slice(0, 10)}.csv`;
    a.click();
    URL.revokeObjectURL(url);
    toast.success("Report exported.");
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center py-20 text-muted-foreground">
        Loading reports...
      </div>
    );
  }

  const s = stats!;

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">My Reports</h1>
          <p className="text-muted-foreground">
            Your personal activity, submissions, and points summary.
          </p>
        </div>
        <Button variant="outline" onClick={exportCSV}>
          <Download className="mr-2 h-4 w-4" />
          Export CSV
        </Button>
      </div>

      {/* Top KPI cards — user-scoped */}
      <div className="grid gap-4 sm:grid-cols-3">
        <Card className="border-[#C5C5C5]">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-[#5D5D5D]">
              My Leads
            </CardTitle>
            <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-[#B12B35]/10">
              <Target className="h-4 w-4 text-[#B12B35]" />
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-[#232222]">
              {s.total_leads}
            </div>
            <p className="text-xs text-[#5D5D5D]">
              {s.leads_by_status["won"] || 0} won
            </p>
          </CardContent>
        </Card>

        <Card className="border-[#C5C5C5]">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-[#5D5D5D]">
              My Value Ideas
            </CardTitle>
            <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-[#003466]/10">
              <Lightbulb className="h-4 w-4 text-[#003466]" />
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-[#232222]">
              {s.total_ideas}
            </div>
            <p className="text-xs text-[#5D5D5D]">
              {s.ideas_by_status["implemented"] || 0} implemented
            </p>
          </CardContent>
        </Card>

        <Card className="border-[#C5C5C5]">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-[#5D5D5D]">
              My Score
            </CardTitle>
            <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-[#B12B35]/10">
              <Trophy className="h-4 w-4 text-[#B12B35]" />
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-[#232222]">
              {totalPoints.toLocaleString()}
            </div>
            <p className="text-xs text-[#5D5D5D]">Value points earned</p>
          </CardContent>
        </Card>
      </div>

      {/* Lead funnel + Idea funnel */}
      <div className="grid gap-4 lg:grid-cols-2">
        <Card className="border-[#C5C5C5]">
          <CardHeader>
            <CardTitle className="text-base flex items-center gap-2">
              <BarChart3 className="h-4 w-4 text-[#B12B35]" />
              My Lead Funnel
            </CardTitle>
            <CardDescription>Your leads by current status</CardDescription>
          </CardHeader>
          <CardContent>
            {Object.keys(s.leads_by_status).length === 0 ? (
              <p className="text-sm text-muted-foreground">No leads submitted yet.</p>
            ) : (
              <div className="space-y-2">
                {Object.entries(s.leads_by_status).map(([status, count]) => {
                  const pct =
                    s.total_leads > 0
                      ? Math.round((count / s.total_leads) * 100)
                      : 0;
                  return (
                    <div key={status} className="space-y-1">
                      <div className="flex items-center justify-between text-sm">
                        <span className="capitalize text-[#232222]">
                          {status.replace(/_/g, " ")}
                        </span>
                        <span className="text-[#5D5D5D]">
                          {count} ({pct}%)
                        </span>
                      </div>
                      <div className="h-2 rounded-full bg-[#EDE7E6]">
                        <div
                          className="h-full rounded-full bg-[#B12B35] transition-all"
                          style={{ width: `${pct}%` }}
                        />
                      </div>
                    </div>
                  );
                })}
              </div>
            )}
          </CardContent>
        </Card>

        <Card className="border-[#C5C5C5]">
          <CardHeader>
            <CardTitle className="text-base flex items-center gap-2">
              <BarChart3 className="h-4 w-4 text-[#003466]" />
              My Idea Funnel
            </CardTitle>
            <CardDescription>Your value ideas by current status</CardDescription>
          </CardHeader>
          <CardContent>
            {Object.keys(s.ideas_by_status).length === 0 ? (
              <p className="text-sm text-muted-foreground">No ideas submitted yet.</p>
            ) : (
              <div className="space-y-2">
                {Object.entries(s.ideas_by_status).map(([status, count]) => {
                  const pct =
                    s.total_ideas > 0
                      ? Math.round((count / s.total_ideas) * 100)
                      : 0;
                  return (
                    <div key={status} className="space-y-1">
                      <div className="flex items-center justify-between text-sm">
                        <span className="capitalize text-[#232222]">
                          {status.replace(/_/g, " ")}
                        </span>
                        <span className="text-[#5D5D5D]">
                          {count} ({pct}%)
                        </span>
                      </div>
                      <div className="h-2 rounded-full bg-[#EDE7E6]">
                        <div
                          className="h-full rounded-full bg-[#003466] transition-all"
                          style={{ width: `${pct}%` }}
                        />
                      </div>
                    </div>
                  );
                })}
              </div>
            )}
          </CardContent>
        </Card>
      </div>

      {/* Score activity log */}
      {scoreEvents.length > 0 && (
        <Card className="border-[#C5C5C5]">
          <CardHeader>
            <CardTitle className="text-base">Points Activity</CardTitle>
            <CardDescription>
              Recent points earned from your submissions
            </CardDescription>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Activity</TableHead>
                  <TableHead>Points</TableHead>
                  <TableHead>Date</TableHead>
                  <TableHead>Status</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {scoreEvents.map((e) => (
                  <TableRow key={e.event_id}>
                    <TableCell className="capitalize">
                      {e.event_type.replace(/_/g, " ")}
                    </TableCell>
                    <TableCell className="font-semibold text-[#B12B35]">
                      +{e.points}
                    </TableCell>
                    <TableCell className="text-[#5D5D5D]">
                      {new Date(e.created_at).toLocaleDateString()}
                    </TableCell>
                    <TableCell>
                      <Badge className="bg-[#B12B35]/10 text-[#B12B35] border-0">
                        Awarded
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
