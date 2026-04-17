"use client";

import { useEffect, useState, useCallback } from "react";
import Link from "next/link";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import {
  Card, CardContent, CardDescription, CardHeader, CardTitle,
} from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import {
  Table, TableBody, TableCell, TableHead, TableHeader, TableRow,
} from "@/components/ui/table";
import { BarChart3, Download, Target, Trophy, ClipboardList, GitBranch, ArrowRight, Users } from "lucide-react";
import { toast } from "sonner";
import type { LeadWithRelations } from "@/types";

type ScoreEvent = {
  event_id: string;
  event_type: string;
  points: number;
  submission_type: string;
  created_at: string;
};

type UserReportData = {
  myLeads: LeadWithRelations[];
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

// ── Pipeline types + helpers ───────────────────────────────────────────────

type PipelineLead = {
  lead_id: string;
  title: string;
  status: string;
  lead_type: string;
  estimated_value: number | null;
  priority: string;
  created_at: string;
  account: { account_name: string; region?: string } | null;
  submitter: { full_name: string } | null;
  current_assignee: string | null;
  current_assignee_role: string | null;
};

/* Value Ideas pipeline type disabled
type PipelineIdea = { ... };
*/

const LEAD_TYPE_LABEL: Record<string, string> = {
  current_lead: "Current Lead",
  new_lead:     "New Lead",
};

// Maps a status to a simplified outcome for the Outcome column
function leadOutcome(status: string): { label: string; cls: string } | null {
  if (status === "won")       return { label: "Won",           cls: "bg-green-100 text-green-700" };
  if (status === "qualified") return { label: "Qualified",     cls: "bg-[#B12B35]/10 text-[#B12B35]" };
  if (status === "lost")      return { label: "Lost",          cls: "bg-[#C5C5C5]/30 text-[#5D5D5D]" };
  if (status === "rejected")  return { label: "Disqualified",  cls: "bg-[#E42525]/10 text-[#E42525]" };
  if (status === "dropped")   return { label: "Dropped",       cls: "bg-[#C5C5C5]/30 text-[#5D5D5D]" };
  return null;
}

// function ideaOutcome(...) — Value Ideas disabled

// ── Pipeline sub-components ────────────────────────────────────────────────

function FlowStep({ label }: { label: string }) {
  return (
    <span className="inline-flex items-center gap-1 text-[10px] text-muted-foreground">
      <ArrowRight className="h-3 w-3" />
      {label}
    </span>
  );
}

function LeadsPipelineTable({ leads, loading }: { leads: PipelineLead[]; loading: boolean }) {
  if (loading) return <p className="text-sm text-muted-foreground py-8 text-center">Loading…</p>;
  if (leads.length === 0)
    return (
      <div className="flex flex-col items-center justify-center py-12 text-muted-foreground">
        <Target className="h-10 w-10 mb-3 opacity-30" />
        <p className="text-sm">No leads to show.</p>
      </div>
    );

  return (
    <Table>
      <TableHeader>
        <TableRow>
          <TableHead>Lead</TableHead>
          <TableHead>Account</TableHead>
          <TableHead>Type</TableHead>
          <TableHead>
            <span className="flex items-center gap-1"><Users className="h-3 w-3" />Assigned To</span>
          </TableHead>
          <TableHead>Status</TableHead>
          <TableHead>Outcome</TableHead>
          <TableHead className="text-right">Value</TableHead>
        </TableRow>
      </TableHeader>
      <TableBody>
        {leads.map((lead) => {
          const outcome = leadOutcome(lead.status);
          return (
            <TableRow key={lead.lead_id}>
              <TableCell>
                <Link href={`/leads/${lead.lead_id}`} className="font-medium hover:underline text-[#232222]">
                  {lead.title}
                </Link>
                <p className="text-[10px] text-muted-foreground mt-0.5">
                  {lead.submitter?.full_name}
                </p>
              </TableCell>
              <TableCell className="text-sm text-[#5D5D5D]">
                {lead.account?.account_name ?? "—"}
              </TableCell>
              <TableCell>
                <Badge variant="outline" className="text-[10px]">
                  {LEAD_TYPE_LABEL[lead.lead_type] ?? lead.lead_type}
                </Badge>
              </TableCell>
              <TableCell>
                {lead.current_assignee ? (
                  <div>
                    <p className="text-sm font-medium text-[#232222]">{lead.current_assignee}</p>
                    <p className="text-[10px] text-muted-foreground">{lead.current_assignee_role}</p>
                  </div>
                ) : (
                  <span className="text-xs text-muted-foreground italic">—</span>
                )}
              </TableCell>
              <TableCell>
                <Badge variant="secondary" className={`capitalize text-[11px] ${STATUS_BADGE[lead.status] ?? "bg-[#C5C5C5]/20 text-[#5D5D5D]"}`}>
                  {lead.status.replace(/_/g, " ")}
                </Badge>
              </TableCell>
              <TableCell>
                {outcome ? (
                  <Badge variant="secondary" className={`text-[11px] ${outcome.cls}`}>
                    {outcome.label}
                  </Badge>
                ) : (
                  <span className="text-xs text-muted-foreground">In Progress</span>
                )}
              </TableCell>
              <TableCell className="text-right text-sm font-medium text-[#232222]">
                {lead.estimated_value
                  ? `$${Number(lead.estimated_value).toLocaleString()}`
                  : "—"}
              </TableCell>
            </TableRow>
          );
        })}
      </TableBody>
    </Table>
  );
}

// IdeasPipelineTable removed — Value Ideas disabled

// ── Reports page ───────────────────────────────────────────────────────────

const PIPELINE_ALL_ROLES = ["admin", "executive"];

export default function ReportsPage() {
  const { token, user } = useAuth();
  const [reportData, setReportData] = useState<UserReportData | null>(null);
  const [loading, setLoading] = useState(true);
  const [pipeline, setPipeline] = useState<{ leads: PipelineLead[] } | null>(null);
  const [pipelineLoading, setPipelineLoading] = useState(true);

  const canSeeAll = PIPELINE_ALL_ROLES.includes(user?.role ?? "");

  const fetchData = useCallback(async () => {
    if (!token || !user?.id) return;
    try {
      const [leadsRaw, scoreRaw, assignmentsRaw] = await Promise.all([
        api<LeadWithRelations[]>("/api/leads", { token }),
        api<{ total_points: number; events?: ScoreEvent[] }>("/api/scores/me", { token }),
        api<{ action_taken: string }[]>("/api/assignments/mine", { token }),
      ]);

      const myLeads = leadsRaw.filter((l) => l.submitted_by === user.id);
      const pendingReviews = Array.isArray(assignmentsRaw)
        ? assignmentsRaw.filter((a) => a.action_taken === "pending").length
        : 0;

      setReportData({
        myLeads,
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

  const fetchPipeline = useCallback(async () => {
    if (!token) return;
    setPipelineLoading(true);
    try {
      const scope = canSeeAll ? "all" : "mine";
      const data = await api<{ leads: PipelineLead[]; ideas: unknown[] }>(
        `/api/dashboard/pipeline?scope=${scope}`,
        { token }
      );
      setPipeline({ leads: data.leads ?? [] });
    } catch {
      toast.error("Failed to load pipeline data.");
    } finally {
      setPipelineLoading(false);
    }
  }, [token, canSeeAll]);

  useEffect(() => { fetchData(); }, [fetchData]);
  useEffect(() => { fetchPipeline(); }, [fetchPipeline]);

  // ── CSV export ────────────────────────────────────────────────────────────
  const exportCSV = () => {
    if (!reportData) return;

    const leadsByStatus = reportData.myLeads.reduce<Record<string, number>>((acc, l) => {
      acc[l.status] = (acc[l.status] || 0) + 1;
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
      ["Pending Reviews",   String(reportData.pendingReviews)],
      ["My Score (Points)", String(reportData.totalPoints)],
      ["", ""],
      ["Lead Status Breakdown", "Count"],
      ...Object.entries(leadsByStatus).map(([k, v]) => [k.replace(/_/g, " "), String(v)]),
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
  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight text-[#232222]">Reports</h1>
          <p className="text-muted-foreground text-sm mt-1">
            Submission pipeline and personal activity for{" "}
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

      <Tabs defaultValue="pipeline">
        <TabsList>
          <TabsTrigger value="pipeline" className="gap-2">
            <GitBranch className="h-4 w-4" />
            Pipeline
          </TabsTrigger>
          <TabsTrigger value="my-report" className="gap-2">
            <BarChart3 className="h-4 w-4" />
            My Report
          </TabsTrigger>
        </TabsList>

        {/* ── Pipeline tab ───────────────────────────────────────────────── */}
        <TabsContent value="pipeline" className="mt-4 space-y-6">
          {/* BRD flow legend */}
          <div className="flex flex-wrap items-center gap-1.5 text-xs text-muted-foreground bg-[#F9F9F9] border border-[#EDE7E6] rounded-lg px-4 py-3">
            <span className="font-semibold text-[#232222]">Lead flow:</span>
            <span>Submission</span>
            <FlowStep label="Assigned To" />
            <FlowStep label="Status" />
            <FlowStep label="Qualified / Disqualified" />
            <FlowStep label="Win / Loss" />
          </div>

          <Card className="border-[#C5C5C5] bg-white mt-4">
            <CardHeader className="pb-3">
              <CardTitle className="text-base text-[#232222] flex items-center gap-2">
                <Target className="h-4 w-4" />
                {canSeeAll ? "All Leads — Pipeline" : "My Leads — Pipeline"}
                {pipeline && (
                  <Badge variant="secondary" className="ml-1 text-[10px] h-4 px-1.5">
                    {pipeline.leads.length}
                  </Badge>
                )}
              </CardTitle>
              <CardDescription>
                Lead → Assigned To → Status → Qualified/Disqualified → Win/Loss
              </CardDescription>
            </CardHeader>
            <CardContent>
              <LeadsPipelineTable
                leads={pipeline?.leads ?? []}
                loading={pipelineLoading}
              />
            </CardContent>
          </Card>
        </TabsContent>

        {/* ── My Report tab (existing content) ───────────────────────────── */}
        <TabsContent value="my-report" className="mt-4 space-y-6">

      {/* KPI cards — strictly user-scoped */}
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
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
      <div className="grid gap-4 lg:grid-cols-1">
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
      </div>

      {/* Recent submissions list */}
      <Card className="border-[#C5C5C5] bg-white">
        <CardHeader>
          <CardTitle className="text-base text-[#232222]">My Recent Submissions</CardTitle>
          <CardDescription>All leads submitted by you</CardDescription>
        </CardHeader>
        <CardContent>
          {reportData.myLeads.length === 0 ? (
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
        </TabsContent>
      </Tabs>
    </div>
  );
}
