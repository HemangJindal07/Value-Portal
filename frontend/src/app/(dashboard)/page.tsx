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
import {
  Target,
  Lightbulb,
  Trophy,
  Users,
  ClipboardList,
  ArrowRight,
} from "lucide-react";
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
  const days = Math.floor(hrs / 24);
  return `${days}d ago`;
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
    } catch {
      /* silently fail */
    } finally {
      setLoading(false);
    }
  }, [token]);

  useEffect(() => {
    fetchAll();
  }, [fetchAll]);

  if (loading) {
    return (
      <div className="flex items-center justify-center py-20 text-muted-foreground">
        Loading dashboard...
      </div>
    );
  }

  const s = stats || {
    total_leads: 0,
    total_ideas: 0,
    total_accounts: 0,
    active_users: 0,
    leads_by_status: {},
    ideas_by_status: {},
    pending_assignments: 0,
  };

  const topCards = [
    {
      title: "Total Leads",
      value: s.total_leads,
      desc: `${s.leads_by_status["qualified"] || 0} qualified`,
      icon: Target,
      iconColor: "text-[#B12B35]",
      iconBg: "bg-[#B12B35]/10",
      href: "/leads",
    },
    {
      title: "Value Ideas",
      value: s.total_ideas,
      desc: `${s.ideas_by_status["implemented"] || 0} implemented`,
      icon: Lightbulb,
      iconColor: "text-[#003466]",
      iconBg: "bg-[#003466]/10",
      href: "/ideas",
    },
    {
      title: "Your Score",
      value: myScore.toLocaleString(),
      desc: "Value points earned",
      icon: Trophy,
      iconColor: "text-[#B12B35]",
      iconBg: "bg-[#B12B35]/10",
      href: "/leaderboard",
      raw: true,
    },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Dashboard</h1>
        <p className="text-muted-foreground">
          Welcome to Value Portal. Track leads, ideas, and measure your impact.
        </p>
      </div>

      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        {topCards.map((c) => (
          <Link key={c.title} href={c.href}>
            <Card className="hover:shadow-md transition-shadow cursor-pointer border-[#C5C5C5]">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-[#5D5D5D]">
                  {c.title}
                </CardTitle>
                <div className={`flex h-8 w-8 items-center justify-center rounded-lg ${c.iconBg}`}>
                  <c.icon className={`h-4 w-4 ${c.iconColor}`} />
                </div>
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-[#232222]">
                  {c.raw ? c.value : c.value.toLocaleString()}
                </div>
                <p className="text-xs text-[#5D5D5D]">{c.desc}</p>
              </CardContent>
            </Card>
          </Link>
        ))}
      </div>

      <div className="grid gap-4 sm:grid-cols-3">
        {[
          { label: "Accounts", value: s.total_accounts, icon: Users, iconColor: "text-[#003466]", iconBg: "bg-[#003466]/10" },
          { label: "Active Users", value: s.active_users, icon: Users, iconColor: "text-[#2E75B6]", iconBg: "bg-[#2E75B6]/10" },
          { label: "Pending Reviews", value: s.pending_assignments, icon: ClipboardList, iconColor: "text-[#B12B35]", iconBg: "bg-[#B12B35]/10" },
        ].map((c) => (
          <Card key={c.label} className="border-[#C5C5C5]">
            <CardHeader className="flex flex-row items-center justify-between pb-2">
              <CardTitle className="text-sm font-medium text-[#5D5D5D]">
                {c.label}
              </CardTitle>
              <div className={`flex h-8 w-8 items-center justify-center rounded-lg ${c.iconBg}`}>
                <c.icon className={`h-4 w-4 ${c.iconColor}`} />
              </div>
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-[#232222]">
                {c.raw ? c.value : String(c.value)}
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      <div className="grid gap-4 lg:grid-cols-2">
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Lead Pipeline</CardTitle>
            <CardDescription>Leads by current status</CardDescription>
          </CardHeader>
          <CardContent>
            {Object.keys(s.leads_by_status).length === 0 ? (
              <p className="text-sm text-muted-foreground">No leads yet.</p>
            ) : (
              <div className="space-y-3">
                {Object.entries(s.leads_by_status).map(([status, count]) => (
                  <div key={status} className="flex items-center justify-between">
                    <Badge variant="outline" className="capitalize">
                      {status.replace("_", " ")}
                    </Badge>
                    <span className="text-sm font-medium">{count}</span>
                  </div>
                ))}
              </div>
            )}
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-base">Recent Activity</CardTitle>
            <CardDescription>Latest status changes</CardDescription>
          </CardHeader>
          <CardContent>
            {activity.length === 0 ? (
              <p className="text-sm text-muted-foreground">
                No recent activity.
              </p>
            ) : (
              <div className="space-y-3">
                {activity.map((a, idx) => (
                  <div key={idx} className="flex items-start gap-3 text-sm">
                    <div className="flex-1 min-w-0">
                      <p className="font-medium truncate">{a.title}</p>
                      <p className="text-xs text-muted-foreground">
                        {a.changed_by} moved {a.type} from{" "}
                        <span className="font-medium">{a.from_status}</span>
                        <ArrowRight className="inline h-3 w-3 mx-1" />
                        <span className="font-medium">{a.to_status}</span>
                      </p>
                    </div>
                    <span className="text-xs text-muted-foreground whitespace-nowrap">
                      {timeAgo(a.changed_at)}
                    </span>
                  </div>
                ))}
              </div>
            )}
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
