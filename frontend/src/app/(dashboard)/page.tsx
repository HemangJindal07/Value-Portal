"use client";

import { useEffect, useState, useCallback } from "react";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import {
  Card, CardContent, CardDescription, CardHeader, CardTitle,
} from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import {
  Target, Lightbulb, Trophy, Users, ClipboardList, ArrowRight, ShieldCheck,
} from "lucide-react";
import Link from "next/link";
import type { LeadWithRelations, IdeaWithRelations } from "@/types";

// ── Types ──────────────────────────────────────────────────────────────────

type OrgStats = {
  total_leads: number;
  total_ideas: number;
  total_accounts: number;
  active_users: number;
  leads_by_status: Record<string, number>;
  ideas_by_status: Record<string, number>;
  pending_assignments: number;
};

type Activity = {
  type: string;
  title: string;
  from_status: string;
  to_status: string;
  changed_by: string;
  changed_at: string;
};

// ── Shared helpers ─────────────────────────────────────────────────────────

function timeAgo(dateStr: string) {
  const diff = Date.now() - new Date(dateStr).getTime();
  const mins = Math.floor(diff / 60000);
  if (mins < 1) return "Just now";
  if (mins < 60) return `${mins}m ago`;
  const hrs = Math.floor(mins / 60);
  if (hrs < 24) return `${hrs}h ago`;
  return `${Math.floor(hrs / 24)}d ago`;
}

const STATUS_COLORS: Record<string, string> = {
  submitted:    "#2E75B6",
  under_review: "#003466",
  approved:     "#B12B35",
  qualified:    "#B12B35",
  in_progress:  "#5D5D5D",
  implemented:  "#22c55e",
  won:          "#22c55e",
  rejected:     "#C5C5C5",
  lost:         "#C5C5C5",
};

const STATUS_BADGE: Record<string, string> = {
  submitted:    "bg-[#2E75B6]/10 text-[#2E75B6] border-[#2E75B6]/20",
  under_review: "bg-[#003466]/10 text-[#003466] border-[#003466]/20",
  approved:     "bg-[#B12B35]/10 text-[#B12B35] border-[#B12B35]/20",
  qualified:    "bg-[#B12B35]/10 text-[#B12B35] border-[#B12B35]/20",
  in_progress:  "bg-[#5D5D5D]/10 text-[#5D5D5D] border-[#5D5D5D]/20",
  implemented:  "bg-green-100 text-green-700 border-green-200",
  won:          "bg-green-100 text-green-700 border-green-200",
  rejected:     "bg-[#C5C5C5]/20 text-[#5D5D5D] border-[#C5C5C5]/40",
  lost:         "bg-[#C5C5C5]/20 text-[#5D5D5D] border-[#C5C5C5]/40",
};

function StatusBarChart({ data, color = "#B12B35" }: { data: Record<string, number>; color?: string }) {
  const entries = Object.entries(data);
  if (!entries.length) return <p className="text-sm text-muted-foreground">No data yet.</p>;
  const max = Math.max(...entries.map(([, v]) => v), 1);
  return (
    <div className="space-y-2.5">
      {entries.map(([status, count]) => {
        const pct = Math.round((count / max) * 100);
        const badge = STATUS_BADGE[status] || "bg-[#C5C5C5]/20 text-[#5D5D5D] border-[#C5C5C5]/40";
        return (
          <div key={status}>
            <div className="flex items-center justify-between mb-1">
              <Badge variant="outline" className={`capitalize text-[11px] px-2 py-0.5 ${badge}`}>
                {status.replace(/_/g, " ")}
              </Badge>
              <span className="text-xs font-semibold text-[#232222]">{count}</span>
            </div>
            <div className="h-2 w-full rounded-full bg-[#EDE7E6] overflow-hidden">
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

function StatCard({
  title, value, desc, icon: Icon, iconColor, iconBg, href,
}: {
  title: string; value: string | number; desc?: string;
  icon: React.ElementType; iconColor: string; iconBg: string; href?: string;
}) {
  const inner = (
    <Card className="hover:shadow-md transition-shadow cursor-pointer border-[#C5C5C5] bg-white h-full">
      <CardHeader className="flex flex-row items-center justify-between pb-2">
        <CardTitle className="text-sm font-medium text-[#5D5D5D]">{title}</CardTitle>
        <div className={`flex h-8 w-8 items-center justify-center rounded-lg ${iconBg}`}>
          <Icon className={`h-4 w-4 ${iconColor}`} />
        </div>
      </CardHeader>
      <CardContent>
        <div className="text-2xl font-bold text-[#232222]">{String(value)}</div>
        {desc && <p className="text-xs text-[#5D5D5D] mt-0.5">{desc}</p>}
      </CardContent>
    </Card>
  );
  return href ? <Link href={href}>{inner}</Link> : inner;
}

// ── Admin dashboard ────────────────────────────────────────────────────────

function AdminDashboard({ token, userName }: { token: string; userName: string }) {
  const [stats, setStats] = useState<OrgStats | null>(null);
  const [activity, setActivity] = useState<Activity[]>([]);
  const [myScore, setMyScore] = useState(0);
  const [loading, setLoading] = useState(true);

  const fetch = useCallback(async () => {
    try {
      const [s, a, score] = await Promise.all([
        api<OrgStats>("/api/dashboard/stats", { token }),
        api<Activity[]>("/api/dashboard/recent-activity?limit=8", { token }),
        api<{ total_points: number }>("/api/scores/me", { token }),
      ]);
      setStats(s);
      setActivity(a);
      setMyScore(score.total_points || 0);
    } catch { /* silent */ }
    finally { setLoading(false); }
  }, [token]);

  useEffect(() => { fetch(); }, [fetch]);

  if (loading) return <div className="flex items-center justify-center py-20 text-muted-foreground">Loading dashboard…</div>;

  const s = stats ?? { total_leads: 0, total_ideas: 0, total_accounts: 0, active_users: 0, leads_by_status: {}, ideas_by_status: {}, pending_assignments: 0 };

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <div className="flex items-center gap-2 mb-1">
            <ShieldCheck className="h-4 w-4 text-[#B12B35]" />
            <span className="text-xs font-semibold text-[#B12B35] uppercase tracking-wider">Admin Dashboard</span>
          </div>
          <h1 className="text-2xl font-bold tracking-tight text-[#232222]">
            Welcome, {userName.split(" ")[0]}
          </h1>
          <p className="text-muted-foreground text-sm mt-1">
            Organisation-wide overview — leads, ideas, accounts and activity.
          </p>
        </div>
        <Badge className="bg-[#232222] text-white border-0 text-xs">Full Access</Badge>
      </div>

      {/* Primary KPIs */}
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <StatCard title="Total Leads"    value={s.total_leads}    desc={`${s.leads_by_status["qualified"] || 0} qualified`}   icon={Target}       iconColor="text-[#B12B35]" iconBg="bg-[#B12B35]/10" href="/leads" />
        <StatCard title="Value Ideas"    value={s.total_ideas}    desc={`${s.ideas_by_status["implemented"] || 0} implemented`} icon={Lightbulb}   iconColor="text-[#003466]" iconBg="bg-[#003466]/10" href="/ideas" />
        <StatCard title="Total Accounts" value={s.total_accounts} desc="Client accounts"                                        icon={Users}        iconColor="text-[#2E75B6]" iconBg="bg-[#2E75B6]/10" href="/accounts" />
        <StatCard title="Active Users"   value={s.active_users}   desc="Portal contributors"                                    icon={Users}        iconColor="text-[#003466]" iconBg="bg-[#003466]/10" href="/admin/users" />
      </div>

      {/* Secondary row */}
      <div className="grid gap-4 sm:grid-cols-3">
        <StatCard title="My Score"          value={myScore.toLocaleString()} desc="Points earned"       icon={Trophy}       iconColor="text-[#B12B35]" iconBg="bg-[#B12B35]/10" href="/leaderboard" />
        <StatCard title="Pending Reviews"   value={s.pending_assignments}    desc="Awaiting action"     icon={ClipboardList} iconColor="text-[#003466]" iconBg="bg-[#003466]/10" href="/assignments" />
        <StatCard title="Ideas Implemented" value={s.ideas_by_status["implemented"] || 0} desc="Delivered" icon={Lightbulb} iconColor="text-[#2E75B6]" iconBg="bg-[#2E75B6]/10" href="/ideas" />
      </div>

      {/* Charts */}
      <div className="grid gap-4 lg:grid-cols-2">
        <Card className="border-[#C5C5C5] bg-white">
          <CardHeader><CardTitle className="text-base text-[#232222]">Lead Pipeline</CardTitle><CardDescription>All leads by status</CardDescription></CardHeader>
          <CardContent><StatusBarChart data={s.leads_by_status} color="#B12B35" /></CardContent>
        </Card>
        <Card className="border-[#C5C5C5] bg-white">
          <CardHeader><CardTitle className="text-base text-[#232222]">Ideas Pipeline</CardTitle><CardDescription>All value ideas by stage</CardDescription></CardHeader>
          <CardContent><StatusBarChart data={s.ideas_by_status} color="#003466" /></CardContent>
        </Card>
      </div>

      {/* Activity feed */}
      <Card className="border-[#C5C5C5] bg-white">
        <CardHeader>
          <CardTitle className="text-base text-[#232222]">Recent Activity</CardTitle>
          <CardDescription>Latest status changes across the organisation</CardDescription>
        </CardHeader>
        <CardContent>
          {activity.length === 0 ? (
            <p className="text-sm text-muted-foreground">No recent activity.</p>
          ) : (
            <div className="divide-y divide-[#EDE7E6]">
              {activity.map((a, idx) => (
                <div key={idx} className="flex items-start gap-3 py-3 text-sm">
                  <div className="mt-2 h-2 w-2 shrink-0 rounded-full" style={{ background: STATUS_COLORS[a.to_status] || "#C5C5C5" }} />
                  <div className="flex-1 min-w-0">
                    <p className="font-semibold truncate text-[#232222]">{a.title}</p>
                    <p className="text-xs text-[#5D5D5D] mt-0.5 flex items-center flex-wrap gap-1">
                      <span>{a.changed_by}</span>
                      <span className="text-[#C5C5C5]">moved {a.type}</span>
                      <Badge variant="outline" className={`capitalize text-[10px] px-1.5 py-0 ${STATUS_BADGE[a.from_status] || ""}`}>{a.from_status?.replace(/_/g, " ")}</Badge>
                      <ArrowRight className="h-3 w-3 text-[#C5C5C5]" />
                      <Badge variant="outline" className={`capitalize text-[10px] px-1.5 py-0 ${STATUS_BADGE[a.to_status] || ""}`}>{a.to_status?.replace(/_/g, " ")}</Badge>
                    </p>
                  </div>
                  <span className="text-[11px] text-[#C5C5C5] whitespace-nowrap pt-0.5">{timeAgo(a.changed_at)}</span>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}

// ── User dashboard (personal data only) ────────────────────────────────────

type UserDashData = {
  myLeads: number;
  myIdeas: number;
  myScore: number;
  myPendingReviews: number;
  leadsByStatus: Record<string, number>;
  ideasByStatus: Record<string, number>;
};

function UserDashboard({
  token, userName, userId,
}: {
  token: string; userName: string; userId: string;
}) {
  const [data, setData] = useState<UserDashData | null>(null);
  const [loading, setLoading] = useState(true);

  const fetch = useCallback(async () => {
    try {
      const [leadsRaw, ideasRaw, scoreRaw, assignmentsRaw] = await Promise.all([
        api<LeadWithRelations[]>("/api/leads", { token }),
        api<IdeaWithRelations[]>("/api/ideas", { token }),
        api<{ total_points: number }>("/api/scores/me", { token }),
        api<{ action_taken: string }[]>("/api/assignments/mine", { token }),
      ]);

      // Filter strictly to this user's submissions
      const myLeads = leadsRaw.filter((l) => l.submitted_by === userId);
      const myIdeas = ideasRaw.filter((i) => i.submitted_by === userId);

      const leadsByStatus = myLeads.reduce<Record<string, number>>((acc, l) => {
        acc[l.status] = (acc[l.status] || 0) + 1;
        return acc;
      }, {});

      const ideasByStatus = myIdeas.reduce<Record<string, number>>((acc, i) => {
        acc[i.status] = (acc[i.status] || 0) + 1;
        return acc;
      }, {});

      const myPendingReviews = Array.isArray(assignmentsRaw)
        ? assignmentsRaw.filter((a) => a.action_taken === "pending").length
        : 0;

      setData({
        myLeads: myLeads.length,
        myIdeas: myIdeas.length,
        myScore: scoreRaw.total_points || 0,
        myPendingReviews,
        leadsByStatus,
        ideasByStatus,
      });
    } catch { /* silent */ }
    finally { setLoading(false); }
  }, [token, userId]);

  useEffect(() => { fetch(); }, [fetch]);

  if (loading) return <div className="flex items-center justify-center py-20 text-muted-foreground">Loading dashboard…</div>;

  const d = data ?? { myLeads: 0, myIdeas: 0, myScore: 0, myPendingReviews: 0, leadsByStatus: {}, ideasByStatus: {} };

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight text-[#232222]">
          Welcome, {userName.split(" ")[0]}
        </h1>
        <p className="text-muted-foreground text-sm mt-1">
          Here&apos;s a summary of your activity and contributions.
        </p>
      </div>

      {/* 4 personal KPI cards */}
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <StatCard
          title="My Leads"
          value={d.myLeads}
          desc={`${d.leadsByStatus["qualified"] || 0} qualified`}
          icon={Target}
          iconColor="text-[#B12B35]"
          iconBg="bg-[#B12B35]/10"
          href="/leads"
        />
        <StatCard
          title="My Value Ideas"
          value={d.myIdeas}
          desc={`${d.ideasByStatus["implemented"] || 0} implemented`}
          icon={Lightbulb}
          iconColor="text-[#003466]"
          iconBg="bg-[#003466]/10"
          href="/ideas"
        />
        <StatCard
          title="Your Score"
          value={d.myScore.toLocaleString()}
          desc="Value points earned"
          icon={Trophy}
          iconColor="text-[#B12B35]"
          iconBg="bg-[#B12B35]/10"
          href="/leaderboard"
        />
        <StatCard
          title="Pending Reviews"
          value={d.myPendingReviews}
          desc="Your items under review"
          icon={ClipboardList}
          iconColor="text-[#2E75B6]"
          iconBg="bg-[#2E75B6]/10"
          href="/assignments"
        />
      </div>

      {/* My pipelines */}
      <div className="grid gap-4 lg:grid-cols-2">
        <Card className="border-[#C5C5C5] bg-white">
          <CardHeader>
            <CardTitle className="text-base text-[#232222]">My Lead Pipeline</CardTitle>
            <CardDescription>Your leads by current status</CardDescription>
          </CardHeader>
          <CardContent>
            {Object.keys(d.leadsByStatus).length === 0 ? (
              <div className="py-6 text-center">
                <p className="text-sm text-muted-foreground mb-3">No leads submitted yet.</p>
                <Link href="/leads/new" className="inline-flex items-center gap-1.5 rounded-lg bg-[#B12B35] px-4 py-2 text-sm font-semibold text-white hover:bg-[#9a2330] transition-colors">
                  <Target className="h-4 w-4" /> Submit a Lead
                </Link>
              </div>
            ) : (
              <StatusBarChart data={d.leadsByStatus} color="#B12B35" />
            )}
          </CardContent>
        </Card>

        <Card className="border-[#C5C5C5] bg-white">
          <CardHeader>
            <CardTitle className="text-base text-[#232222]">My Idea Pipeline</CardTitle>
            <CardDescription>Your value ideas by current status</CardDescription>
          </CardHeader>
          <CardContent>
            {Object.keys(d.ideasByStatus).length === 0 ? (
              <div className="py-6 text-center">
                <p className="text-sm text-muted-foreground mb-3">No ideas submitted yet.</p>
                <Link href="/ideas/new" className="inline-flex items-center gap-1.5 rounded-lg bg-[#003466] px-4 py-2 text-sm font-semibold text-white hover:bg-[#003466]/90 transition-colors">
                  <Lightbulb className="h-4 w-4" /> Submit an Idea
                </Link>
              </div>
            ) : (
              <StatusBarChart data={d.ideasByStatus} color="#003466" />
            )}
          </CardContent>
        </Card>
      </div>

      {/* Quick actions */}
      <Card className="border-[#C5C5C5] bg-white">
        <CardHeader>
          <CardTitle className="text-base text-[#232222]">Quick Actions</CardTitle>
          <CardDescription>Submit and track your contributions</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="flex flex-wrap gap-3">
            <Link href="/leads/new" className="inline-flex items-center gap-2 rounded-lg border border-[#B12B35] bg-[#B12B35]/5 px-4 py-2 text-sm font-semibold text-[#B12B35] hover:bg-[#B12B35]/10 transition-colors">
              <Target className="h-4 w-4" /> Submit New Lead
            </Link>
            <Link href="/ideas/new" className="inline-flex items-center gap-2 rounded-lg border border-[#003466] bg-[#003466]/5 px-4 py-2 text-sm font-semibold text-[#003466] hover:bg-[#003466]/10 transition-colors">
              <Lightbulb className="h-4 w-4" /> Submit Value Idea
            </Link>
            <Link href="/assignments" className="inline-flex items-center gap-2 rounded-lg border border-[#C5C5C5] bg-white px-4 py-2 text-sm font-semibold text-[#5D5D5D] hover:border-[#B12B35]/40 transition-colors">
              <ClipboardList className="h-4 w-4" /> View My Assignments
            </Link>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}

// ── Root page ──────────────────────────────────────────────────────────────

export default function DashboardPage() {
  const { user, token } = useAuth();

  if (!token || !user) {
    return <div className="flex items-center justify-center py-20 text-muted-foreground">Loading…</div>;
  }

  if (user.role === "admin") {
    return <AdminDashboard token={token} userName={user.full_name || user.email} />;
  }

  return <UserDashboard token={token} userName={user.full_name || user.email} userId={user.id} />;
}
