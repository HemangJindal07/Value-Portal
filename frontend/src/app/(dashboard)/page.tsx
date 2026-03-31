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
import { Target, Lightbulb, Trophy, Users, ClipboardList, ArrowRight } from "lucide-react";
import Link from "next/link";
type DashboardStats = {
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

/** Pure-CSS horizontal bar chart — no external library needed */
function StatusBarChart({ data }: { data: Record<string, number> }) {
  const entries = Object.entries(data);
  if (!entries.length) return <p className="text-sm text-muted-foreground">No data yet.</p>;
  const max = Math.max(...entries.map(([, v]) => v), 1);
  return (
    <div className="space-y-2.5">
      {entries.map(([status, count]) => {
        const pct = Math.round((count / max) * 100);
        const color = STATUS_COLORS[status] || "#C5C5C5";
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

export default function DashboardPage() {
  const { token } = useAuth();
  const [stats, setStats] = useState<DashboardStats | null>(null);
  const [activity, setActivity] = useState<Activity[]>([]);
  const [myScore, setMyScore] = useState(0);
  const [loading, setLoading] = useState(true);

  const fetchAll = useCallback(async () => {
    if (!token) return;
    try {
      const [s, a, score] = await Promise.all([
        api<DashboardStats>("/api/dashboard/stats", { token }),
        api<Activity[]>("/api/dashboard/recent-activity?limit=8", { token }),
        api<{ total_points: number }>("/api/scores/me", { token }),
      ]);
      setStats(s);
      setActivity(a);
      setMyScore(score.total_points || 0);
    } catch { /* silently fail */ }
    finally { setLoading(false); }
  }, [token]);

  useEffect(() => { fetchAll(); }, [fetchAll]);

  if (loading) {
    return (
      <div className="flex items-center justify-center py-20 text-muted-foreground">
        Loading dashboard...
      </div>
    );
  }

  const s = stats ?? {
    total_leads: 0, total_ideas: 0, total_accounts: 0, active_users: 0,
    leads_by_status: {}, ideas_by_status: {}, pending_assignments: 0,
  };

  const topCards = [
    { title: "Total Leads",  value: s.total_leads,  desc: `${s.leads_by_status["qualified"] || 0} qualified`,   icon: Target,       iconColor: "text-[#B12B35]", iconBg: "bg-[#B12B35]/10", href: "/leads" },
    { title: "Value Ideas",  value: s.total_ideas,  desc: `${s.ideas_by_status["implemented"] || 0} implemented`, icon: Lightbulb,   iconColor: "text-[#003466]", iconBg: "bg-[#003466]/10", href: "/ideas" },
    { title: "Your Score",   value: myScore,        desc: "Value points earned",                                  icon: Trophy,      iconColor: "text-[#B12B35]", iconBg: "bg-[#B12B35]/10", href: "/leaderboard" },
  ];

  const metaCards = [
    { label: "Accounts",        value: s.total_accounts,      icon: Users,         iconColor: "text-[#003466]", iconBg: "bg-[#003466]/10" },
    { label: "Active Users",    value: s.active_users,        icon: Users,         iconColor: "text-[#2E75B6]", iconBg: "bg-[#2E75B6]/10" },
    { label: "Pending Reviews", value: s.pending_assignments, icon: ClipboardList, iconColor: "text-[#B12B35]", iconBg: "bg-[#B12B35]/10" },
  ];

  return (
    <div className="space-y-6">

      {/* Campaign Banner — Template 3 */}

      <div>
        <h1 className="text-2xl font-bold tracking-tight text-[#232222]">Dashboard</h1>
        <p className="text-muted-foreground text-sm mt-1">
          Welcome to Value Portal. Track leads, ideas, and measure your impact.
        </p>
      </div>

      {/* Primary stat cards */}
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {topCards.map((c) => (
          <Link key={c.title} href={c.href}>
            <Card className="hover:shadow-md transition-shadow cursor-pointer border-[#C5C5C5] bg-white">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-[#5D5D5D]">{c.title}</CardTitle>
                <div className={`flex h-8 w-8 items-center justify-center rounded-lg ${c.iconBg}`}>
                  <c.icon className={`h-4 w-4 ${c.iconColor}`} />
                </div>
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-[#232222]">{c.value.toLocaleString()}</div>
                <p className="text-xs text-[#5D5D5D] mt-0.5">{c.desc}</p>
              </CardContent>
            </Card>
          </Link>
        ))}
      </div>

      {/* Meta cards */}
      <div className="grid gap-4 sm:grid-cols-3">
        {metaCards.map((c) => (
          <Card key={c.label} className="border-[#C5C5C5] bg-white">
            <CardHeader className="flex flex-row items-center justify-between pb-2">
              <CardTitle className="text-sm font-medium text-[#5D5D5D]">{c.label}</CardTitle>
              <div className={`flex h-8 w-8 items-center justify-center rounded-lg ${c.iconBg}`}>
                <c.icon className={`h-4 w-4 ${c.iconColor}`} />
              </div>
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-[#232222]">{c.value}</div>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* Charts row — Template 2 */}
      <div className="grid gap-4 lg:grid-cols-2">
        <Card className="border-[#C5C5C5] bg-white">
          <CardHeader>
            <CardTitle className="text-base text-[#232222]">Lead Pipeline</CardTitle>
            <CardDescription>Leads by current status</CardDescription>
          </CardHeader>
          <CardContent>
            <StatusBarChart data={s.leads_by_status} />
          </CardContent>
        </Card>

        <Card className="border-[#C5C5C5] bg-white">
          <CardHeader>
            <CardTitle className="text-base text-[#232222]">Ideas in Progress</CardTitle>
            <CardDescription>Value ideas breakdown by stage</CardDescription>
          </CardHeader>
          <CardContent>
            <StatusBarChart data={s.ideas_by_status} />
          </CardContent>
        </Card>
      </div>

      {/* Activity Feed */}
      <Card className="border-[#C5C5C5] bg-white">
        <CardHeader>
          <CardTitle className="text-base text-[#232222]">Recent Activity</CardTitle>
          <CardDescription>Latest status changes across leads and ideas</CardDescription>
        </CardHeader>
        <CardContent>
          {activity.length === 0 ? (
            <p className="text-sm text-muted-foreground">No recent activity.</p>
          ) : (
            <div className="divide-y divide-[#EDE7E6]">
              {activity.map((a, idx) => (
                <div key={idx} className="flex items-start gap-3 py-3 text-sm">
                  <div
                    className="mt-2 h-2 w-2 shrink-0 rounded-full"
                    style={{ background: STATUS_COLORS[a.to_status] || "#C5C5C5" }}
                  />
                  <div className="flex-1 min-w-0">
                    <p className="font-semibold truncate text-[#232222]">{a.title}</p>
                    <p className="text-xs text-[#5D5D5D] mt-0.5 flex items-center flex-wrap gap-1">
                      <span>{a.changed_by}</span>
                      <span className="text-[#C5C5C5]">moved {a.type}</span>
                      <Badge variant="outline" className={`capitalize text-[10px] px-1.5 py-0 ${STATUS_BADGE[a.from_status] || ""}`}>
                        {a.from_status?.replace(/_/g, " ")}
                      </Badge>
                      <ArrowRight className="h-3 w-3 text-[#C5C5C5]" />
                      <Badge variant="outline" className={`capitalize text-[10px] px-1.5 py-0 ${STATUS_BADGE[a.to_status] || ""}`}>
                        {a.to_status?.replace(/_/g, " ")}
                      </Badge>
                    </p>
                  </div>
                  <span className="text-[11px] text-[#C5C5C5] whitespace-nowrap pt-0.5">
                    {timeAgo(a.changed_at)}
                  </span>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
