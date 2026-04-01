"use client";

import { useEffect, useState, useCallback } from "react";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import {
  Card, CardContent, CardDescription, CardHeader, CardTitle,
} from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
  Table, TableBody, TableCell, TableHead, TableHeader, TableRow,
} from "@/components/ui/table";
import { BarChart3, Download, Target, Lightbulb, Trophy, ClipboardList } from "lucide-react";
import { toast } from "sonner";
import type { LeadWithRelations, IdeaWithRelations } from "@/types";

type ScoreEvent = {
  event_id: string;
  event_type: string;
  points: number;
  submission_type: string;
  created_at: string;
};

type UserReportData = {
  myLeads: LeadWithRelations[];
  myIdeas: IdeaWithRelations[];
  totalPoints: number;
  pendingReviews: number;
  scoreEvents: ScoreEvent[];
};

// ── Status bar chart ───────────────────────────────────────────────────────

const STATUS_BADGE: Record<string, string> = {
  submitted:    "bg-[#2E75B6]/10 text-[#2E75B6]",
  under_review: "bg-[#003466]/10 text-[#003466]",
  approved:     "bg-[#B12B35]/10 text-[#B12B35]",
  qualified:    "bg-[#B12B35]/10 text-[#B12B35]",
  in_progress:  "bg-[#5D5D5D]/10 text-[#5D5D5D]",
  implemented:  "bg-green-100 text-green-700",
  won:          "bg-green-100 text-green-700",
  rejected:     "bg-[#C5C5C5]/20 text-[#5D5D5D]",
  lost:         "bg-[#C5C5C5]/20 text-[#5D5D5D]",
};

function StatusFunnel({
  data,
  total,
  color,
}: {
  data: Record<string, number>;
  total: number;
  color: string;
}) {
  if (Object.keys(data).length === 0) {
    return <p className="text-sm text-muted-foreground">No data yet.</p>;
  }
  return (
    <div className="space-y-2">
      {Object.entries(data).map(([status, count]) => {
        const pct = total > 0 ? Math.round((count / total) * 100) : 0;
        return (
          <div key={status} className="space-y-1">
            <div className="flex items-center justify-between text-sm">
              <Badge
                variant="outline"
                className={`capitalize text-[11px] px-2 py-0 ${STATUS_BADGE[status] || "bg-[#C5C5C5]/20 text-[#5D5D5D]"}`}
              >
                {status.replace(/_/g, " ")}
              </Badge>
              <span className="text-xs text-[#5D5D5D]">
                {count} ({pct}%)
              </span>
            </div>
            <div className="h-2 rounded-full bg-[#EDE7E6]">
              <div
                className="h-full rounded-full transition-all duration-700"
                style={{ width: `${pct}%`, background: color }}
              />
            </div>
          </div>
        );
      })}
    </div>
  );
}

// ── Reports page ───────────────────────────────────────────────────────────

export default function ReportsPage() {
  const { token, user } = useAuth();
  const [reportData, setReportData] = useState<UserReportData | null>(null);
  const [loading, setLoading] = useState(true);

  const fetchData = useCallback(async () => {
    if (!token || !user?.id) return;
    try {
      const [leadsRaw, ideasRaw, scoreRaw, assignmentsRaw] = await Promise.all([
        api<LeadWithRelations[]>("/api/leads", { token }),
        api<IdeaWithRelations[]>("/api/ideas", { token }),
        api<{ total_points: number; events?: ScoreEvent[] }>("/api/scores/me", { token }),
        api<{ action_taken: string }[]>("/api/assignments/mine", { token }),
      ]);

      // Filter strictly to this user's submissions
      const myLeads = leadsRaw.filter((l) => l.submitted_by === user.id);
      const myIdeas = ideasRaw.filter((i) => i.submitted_by === user.id);
      const pendingReviews = Array.isArray(assignmentsRaw)
        ? assignmentsRaw.filter((a) => a.action_taken === "pending").length
        : 0;

      setReportData({
        myLeads,
        myIdeas,
        totalPoints: scoreRaw.total_points || 0,
        pendingReviews,
        scoreEvents: scoreRaw.events || [],
      });
    } catch {
      toast.error("Failed to load report data.");
    } finally {
      setLoading(false);
    }
  }, [token, user?.id]);

  useEffect(() => { fetchData(); }, [fetchData]);

  // ── CSV export ────────────────────────────────────────────────────────────
  const exportCSV = () => {
    if (!reportData) return;

    const leadsByStatus = reportData.myLeads.reduce<Record<string, number>>((acc, l) => {
      acc[l.status] = (acc[l.status] || 0) + 1;
      return acc;
    }, {});
    const ideasByStatus = reportData.myIdeas.reduce<Record<string, number>>((acc, i) => {
      acc[i.status] = (acc[i.status] || 0) + 1;
      return acc;
    }, {});

    const rows = [
      ["My Report — Value Portal", ""],
      ["User",      user?.full_name || user?.email || ""],
      ["User ID",   user?.id || ""],
      ["Generated", new Date().toLocaleString()],
      ["", ""],
      ["Metric", "Value"],
      ["My Total Leads",    String(reportData.myLeads.length)],
      ["My Total Ideas",    String(reportData.myIdeas.length)],
      ["Pending Reviews",   String(reportData.pendingReviews)],
      ["My Score (Points)", String(reportData.totalPoints)],
      ["", ""],
      ["Lead Status Breakdown", "Count"],
      ...Object.entries(leadsByStatus).map(([k, v]) => [k.replace(/_/g, " "), String(v)]),
      ["", ""],
      ["Idea Status Breakdown", "Count"],
      ...Object.entries(ideasByStatus).map(([k, v]) => [k.replace(/_/g, " "), String(v)]),
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
        Loading reports…
      </div>
    );
  }

  if (!reportData) return null;

  const leadsByStatus = reportData.myLeads.reduce<Record<string, number>>((acc, l) => {
    acc[l.status] = (acc[l.status] || 0) + 1;
    return acc;
  }, {});
  const ideasByStatus = reportData.myIdeas.reduce<Record<string, number>>((acc, i) => {
    acc[i.status] = (acc[i.status] || 0) + 1;
    return acc;
  }, {});

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight text-[#232222]">My Reports</h1>
          <p className="text-muted-foreground text-sm mt-1">
            Your personal activity, submissions and points — data for{" "}
            <span className="font-medium text-[#232222]">
              {user?.full_name || user?.email}
            </span>
          </p>
        </div>
        <Button variant="outline" onClick={exportCSV}>
          <Download className="mr-2 h-4 w-4" />
          Export CSV
        </Button>
      </div>

      {/* KPI cards — strictly user-scoped */}
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <Card className="border-[#C5C5C5] bg-white">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-[#5D5D5D]">My Leads</CardTitle>
            <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-[#B12B35]/10">
              <Target className="h-4 w-4 text-[#B12B35]" />
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-[#232222]">{reportData.myLeads.length}</div>
            <p className="text-xs text-[#5D5D5D]">
              {leadsByStatus["won"] || 0} won · {leadsByStatus["qualified"] || 0} qualified
            </p>
          </CardContent>
        </Card>

        <Card className="border-[#C5C5C5] bg-white">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-[#5D5D5D]">My Value Ideas</CardTitle>
            <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-[#003466]/10">
              <Lightbulb className="h-4 w-4 text-[#003466]" />
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-[#232222]">{reportData.myIdeas.length}</div>
            <p className="text-xs text-[#5D5D5D]">
              {ideasByStatus["implemented"] || 0} implemented · {ideasByStatus["approved"] || 0} approved
            </p>
          </CardContent>
        </Card>

        <Card className="border-[#C5C5C5] bg-white">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-[#5D5D5D]">My Score</CardTitle>
            <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-[#B12B35]/10">
              <Trophy className="h-4 w-4 text-[#B12B35]" />
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-[#232222]">
              {reportData.totalPoints.toLocaleString()}
            </div>
            <p className="text-xs text-[#5D5D5D]">Value points earned</p>
          </CardContent>
        </Card>

        <Card className="border-[#C5C5C5] bg-white">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-[#5D5D5D]">Pending Reviews</CardTitle>
            <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-[#2E75B6]/10">
              <ClipboardList className="h-4 w-4 text-[#2E75B6]" />
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-[#232222]">{reportData.pendingReviews}</div>
            <p className="text-xs text-[#5D5D5D]">Items awaiting action</p>
          </CardContent>
        </Card>
      </div>

      {/* Funnel charts */}
      <div className="grid gap-4 lg:grid-cols-2">
        <Card className="border-[#C5C5C5] bg-white">
          <CardHeader>
            <CardTitle className="text-base flex items-center gap-2 text-[#232222]">
              <BarChart3 className="h-4 w-4 text-[#B12B35]" />
              My Lead Funnel
            </CardTitle>
            <CardDescription>Your {reportData.myLeads.length} leads by current status</CardDescription>
          </CardHeader>
          <CardContent>
            <StatusFunnel data={leadsByStatus} total={reportData.myLeads.length} color="#B12B35" />
          </CardContent>
        </Card>

        <Card className="border-[#C5C5C5] bg-white">
          <CardHeader>
            <CardTitle className="text-base flex items-center gap-2 text-[#232222]">
              <BarChart3 className="h-4 w-4 text-[#003466]" />
              My Idea Funnel
            </CardTitle>
            <CardDescription>Your {reportData.myIdeas.length} ideas by current status</CardDescription>
          </CardHeader>
          <CardContent>
            <StatusFunnel data={ideasByStatus} total={reportData.myIdeas.length} color="#003466" />
          </CardContent>
        </Card>
      </div>

      {/* Recent submissions list */}
      <Card className="border-[#C5C5C5] bg-white">
        <CardHeader>
          <CardTitle className="text-base text-[#232222]">My Recent Submissions</CardTitle>
          <CardDescription>All leads and value ideas submitted by you</CardDescription>
        </CardHeader>
        <CardContent>
          {reportData.myLeads.length === 0 && reportData.myIdeas.length === 0 ? (
            <p className="text-sm text-muted-foreground">No submissions yet.</p>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Title</TableHead>
                  <TableHead>Type</TableHead>
                  <TableHead>Account</TableHead>
                  <TableHead>Status</TableHead>
                  <TableHead>Date</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {[
                  ...reportData.myLeads.map((l) => ({
                    id: l.lead_id,
                    title: l.title,
                    type: "Lead",
                    account: l.account?.account_name ?? "—",
                    status: l.status,
                    date: l.created_at,
                    href: `/leads/${l.lead_id}`,
                  })),
                  ...reportData.myIdeas.map((i) => ({
                    id: i.idea_id,
                    title: i.title,
                    type: "Idea",
                    account: i.account?.account_name ?? "—",
                    status: i.status,
                    date: i.created_at,
                    href: `/ideas/${i.idea_id}`,
                  })),
                ]
                  .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
                  .map((row) => (
                    <TableRow key={row.id}>
                      <TableCell>
                        <a href={row.href} className="font-medium hover:underline text-[#232222]">
                          {row.title}
                        </a>
                      </TableCell>
                      <TableCell>
                        <Badge
                          variant="secondary"
                          className={row.type === "Lead" ? "bg-blue-500/10 text-blue-600" : "bg-violet-500/10 text-violet-600"}
                        >
                          {row.type}
                        </Badge>
                      </TableCell>
                      <TableCell className="text-[#5D5D5D]">{row.account}</TableCell>
                      <TableCell>
                        <Badge
                          variant="secondary"
                          className={`capitalize ${STATUS_BADGE[row.status] || "bg-[#C5C5C5]/20 text-[#5D5D5D]"}`}
                        >
                          {row.status.replace(/_/g, " ")}
                        </Badge>
                      </TableCell>
                      <TableCell className="text-[#5D5D5D] text-xs">
                        {new Date(row.date).toLocaleDateString()}
                      </TableCell>
                    </TableRow>
                  ))}
              </TableBody>
            </Table>
          )}
        </CardContent>
      </Card>

      {/* Points activity */}
      {reportData.scoreEvents.length > 0 && (
        <Card className="border-[#C5C5C5] bg-white">
          <CardHeader>
            <CardTitle className="text-base text-[#232222]">Points Activity</CardTitle>
            <CardDescription>Recent points earned from your submissions</CardDescription>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Activity</TableHead>
                  <TableHead>Type</TableHead>
                  <TableHead>Points</TableHead>
                  <TableHead>Date</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {reportData.scoreEvents.map((e) => (
                  <TableRow key={e.event_id}>
                    <TableCell className="capitalize text-[#232222]">
                      {e.event_type.replace(/_/g, " ")}
                    </TableCell>
                    <TableCell>
                      <Badge variant="secondary" className={e.submission_type === "lead" ? "bg-blue-500/10 text-blue-600" : "bg-violet-500/10 text-violet-600"}>
                        {e.submission_type}
                      </Badge>
                    </TableCell>
                    <TableCell className="font-semibold text-[#B12B35]">+{e.points}</TableCell>
                    <TableCell className="text-[#5D5D5D] text-xs">
                      {new Date(e.created_at).toLocaleDateString()}
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
