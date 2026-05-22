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
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import {
  Dialog, DialogContent, DialogHeader, DialogTitle,
} from "@/components/ui/dialog";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Trophy, Medal, Award, Star, TrendingUp, Zap, Target } from "lucide-react";
import { toast } from "sonner";

type LeaderboardUser = {
  score_id: string;
  user_id: string;
  total_points: number;
  leads_submitted: number;
  ideas_submitted: number;
  deals_won: number;
  ideas_implemented: number;
  rank: number;
  user?: {
    id: string;
    full_name: string;
    email: string;
    role: string;
    department: string | null;
  };
};

type MyScore = {
  total_points: number;
  leads_submitted: number;
  ideas_submitted: number;
  deals_won: number;
  ideas_implemented: number;
  rank: number;
};

function getInitials(name: string) {
  return name
    .split(" ")
    .map((n) => n[0])
    .join("")
    .toUpperCase()
    .slice(0, 2);
}

function getRankIcon(rank: number) {
  if (rank === 1) return <Trophy className="h-5 w-5 text-yellow-500" />;
  if (rank === 2) return <Medal className="h-5 w-5 text-gray-400" />;
  if (rank === 3) return <Award className="h-5 w-5 text-amber-600" />;
  return <span className="text-sm font-mono text-muted-foreground">#{rank}</span>;
}

const roleLabels: Record<string, string> = {
  user: "User",
  sales: "Sales",
  practice_lead: "Practice Lead",
  admin: "Admin",
  executive: "Executive",
};

export default function LeaderboardPage() {
  const { token, user } = useAuth();
  // Admin/executive don't compete on the leaderboard, so hide the personal
  // "Your Rank / Total Points / Leads / Deals Won" stat cards for them.
  const isLeadershipRole = user?.role === "admin" || user?.role === "executive";
  const [entries, setEntries] = useState<LeaderboardUser[]>([]);
  const [myScore, setMyScore] = useState<MyScore | null>(null);
  const [loading, setLoading] = useState(true);
  const [viewAllOpen, setViewAllOpen] = useState(false);
  const [allEntries, setAllEntries] = useState<LeaderboardUser[]>([]);
  const [allLoading, setAllLoading] = useState(false);

  const fetchData = useCallback(async () => {
    if (!token) return;
    try {
      const [lb, me] = await Promise.all([
        api<LeaderboardUser[]>("/api/scores/leaderboard?limit=10", { token }),
        api<MyScore>("/api/scores/me", { token }),
      ]);
      setEntries(lb.slice(0, 10));
      setMyScore(me);
    } catch {
      toast.error("Failed to load leaderboard");
    } finally {
      setLoading(false);
    }
  }, [token]);

  useEffect(() => {
    fetchData();
  }, [fetchData]);

  const openViewAll = async () => {
    setViewAllOpen(true);
    if (allEntries.length > 0 || !token) return;
    setAllLoading(true);
    try {
      const lb = await api<LeaderboardUser[]>(
        "/api/scores/leaderboard?limit=1000",
        { token }
      );
      setAllEntries(lb);
    } catch {
      toast.error("Failed to load full leaderboard");
    } finally {
      setAllLoading(false);
    }
  };

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Leaderboard</h1>
        <p className="text-muted-foreground">
          Top contributors and revenue leaders (leads-focused scoring).
        </p>
      </div>

      {myScore && !isLeadershipRole && (
        <div className="grid gap-4 md:grid-cols-4">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Your Rank</CardTitle>
              <Trophy className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">
                {myScore.rank > 0 ? `#${myScore.rank}` : "—"}
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Total Points</CardTitle>
              <Star className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">
                {myScore.total_points.toLocaleString()}
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Leads</CardTitle>
              <Target className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{myScore.leads_submitted}</div>
            </CardContent>
          </Card>
          {/* Value Ideas stats hidden — leads-only portal
          <Card>Ideas …</Card>
          */}
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Deals Won</CardTitle>
              <Zap className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{myScore.deals_won}</div>
            </CardContent>
          </Card>
        </div>
      )}

      <Card>
        <CardHeader className="flex flex-row items-start justify-between space-y-0">
          <div>
            <CardTitle className="flex items-center gap-2">
              <TrendingUp className="h-5 w-5" />
              Top 10 Rankings
            </CardTitle>
            <CardDescription>
              Points are earned by submitting leads and when they progress (e.g. qualified or won).
            </CardDescription>
          </div>
          <Button
            variant="outline"
            size="sm"
            onClick={openViewAll}
            className="border-[#B12B35] text-[#B12B35] hover:bg-[#B12B35]/5 hover:text-[#B12B35]"
          >
            View All
          </Button>
        </CardHeader>
        <CardContent className="p-0">
          {loading ? (
            <p className="text-sm text-muted-foreground py-8 text-center">Loading leaderboard...</p>
          ) : entries.length === 0 ? (
            <p className="text-sm text-muted-foreground py-8 text-center">No scores yet. Start submitting leads to earn points!</p>
          ) : (
            <div className="divide-y divide-[#EDE7E6]">
              {/* Header */}
              <div className="grid grid-cols-[48px_1fr_80px_64px_72px] gap-3 px-5 py-2.5 bg-[#F9F9F9] text-[11px] font-semibold text-[#5D5D5D] uppercase tracking-wider">
                <span className="text-center">Rank</span>
                <span>Contributor</span>
                <span className="text-right">Points</span>
                <span className="text-right">Leads</span>
                <span className="text-right">Deals Won</span>
              </div>
              {entries.map((entry) => {
                const isMe = entry.user_id === user?.id;
                return (
                  <div
                    key={entry.score_id}
                    className={`grid grid-cols-[48px_1fr_80px_64px_72px] gap-3 px-5 py-3 items-center ${isMe ? "bg-[#B12B35]/5" : ""}`}
                  >
                    <div className="flex items-center justify-center">
                      {getRankIcon(entry.rank)}
                    </div>
                    <div className="flex items-center gap-2.5 min-w-0">
                      <Avatar className="h-8 w-8 shrink-0">
                        <AvatarFallback className="text-xs bg-[#B12B35] text-white">
                          {entry.user ? getInitials(entry.user.full_name) : "?"}
                        </AvatarFallback>
                      </Avatar>
                      <div className="min-w-0">
                        <p className="text-sm font-semibold text-[#232222] truncate">
                          {entry.user?.full_name || "Unknown"}
                          {isMe && <Badge variant="outline" className="ml-2 text-[10px] py-0">You</Badge>}
                        </p>
                        <p className="text-[11px] text-muted-foreground truncate">
                          {entry.user?.email}
                        </p>
                      </div>
                    </div>
                    <p className="text-right font-bold text-[#B12B35] text-base tabular-nums">
                      {entry.total_points.toLocaleString()}
                    </p>
                    <p className="text-right text-sm font-medium text-[#232222] tabular-nums">
                      {entry.leads_submitted}
                    </p>
                    <p className="text-right text-sm font-medium text-[#232222] tabular-nums">
                      {entry.deals_won}
                    </p>
                  </div>
                );
              })}
            </div>
          )}
        </CardContent>
      </Card>

      <Dialog open={viewAllOpen} onOpenChange={setViewAllOpen}>
        <DialogContent className="!max-w-4xl w-[min(960px,95vw)] max-h-[85vh] overflow-hidden flex flex-col">
          <DialogHeader>
            <DialogTitle className="flex items-center gap-2">
              <TrendingUp className="h-5 w-5" />
              All Contributors
            </DialogTitle>
          </DialogHeader>
          <div className="overflow-y-auto -mx-6 px-6">
            {allLoading ? (
              <p className="text-sm text-muted-foreground py-8 text-center">Loading…</p>
            ) : allEntries.length === 0 ? (
              <p className="text-sm text-muted-foreground py-8 text-center">No contributors yet.</p>
            ) : (
              <div className="divide-y divide-[#EDE7E6] border border-[#EDE7E6] rounded-lg overflow-hidden">
                <div className="grid grid-cols-[60px_minmax(220px,1fr)_100px_80px_90px] gap-3 px-5 py-2.5 bg-[#F9F9F9] text-[11px] font-semibold text-[#5D5D5D] uppercase tracking-wider sticky top-0">
                  <span className="text-center">Rank</span>
                  <span>Contributor</span>
                  <span className="text-right">Points</span>
                  <span className="text-right">Leads</span>
                  <span className="text-right">Deals Won</span>
                </div>
                {allEntries.map((entry) => {
                  const isMe = entry.user_id === user?.id;
                  return (
                    <div
                      key={entry.score_id}
                      className={`grid grid-cols-[60px_minmax(220px,1fr)_100px_80px_90px] gap-3 px-5 py-3 items-center ${isMe ? "bg-[#B12B35]/5" : ""}`}
                    >
                      <div className="flex items-center justify-center">
                        {getRankIcon(entry.rank)}
                      </div>
                      <div className="flex items-center gap-2.5 min-w-0">
                        <Avatar className="h-8 w-8 shrink-0">
                          <AvatarFallback className="text-xs bg-[#B12B35] text-white">
                            {entry.user ? getInitials(entry.user.full_name) : "?"}
                          </AvatarFallback>
                        </Avatar>
                        <div className="min-w-0">
                          <p className="text-sm font-semibold text-[#232222] truncate">
                            {entry.user?.full_name || "Unknown"}
                            {isMe && <Badge variant="outline" className="ml-2 text-[10px] py-0">You</Badge>}
                          </p>
                          <p className="text-[11px] text-muted-foreground truncate">
                            {entry.user?.email}
                          </p>
                        </div>
                      </div>
                      <p className="text-right font-bold text-[#B12B35] text-base tabular-nums">
                        {entry.total_points.toLocaleString()}
                      </p>
                      <p className="text-right text-sm font-medium text-[#232222] tabular-nums">
                        {entry.leads_submitted}
                      </p>
                      <p className="text-right text-sm font-medium text-[#232222] tabular-nums">
                        {entry.deals_won}
                      </p>
                    </div>
                  );
                })}
              </div>
            )}
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
}
