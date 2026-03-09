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
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Trophy, Medal, Award, Star, TrendingUp, Zap, Target, Lightbulb } from "lucide-react";
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
  delivery_manager: "Delivery Manager",
  sales: "Sales",
  practice_lead: "Practice Lead",
  admin: "Admin",
  executive: "Executive",
};

export default function LeaderboardPage() {
  const { token, user } = useAuth();
  const [entries, setEntries] = useState<LeaderboardUser[]>([]);
  const [myScore, setMyScore] = useState<MyScore | null>(null);
  const [loading, setLoading] = useState(true);

  const fetchData = useCallback(async () => {
    if (!token) return;
    try {
      const [lb, me] = await Promise.all([
        api<LeaderboardUser[]>("/api/scores/leaderboard", { token }),
        api<MyScore>("/api/scores/me", { token }),
      ]);
      setEntries(lb);
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

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Leaderboard</h1>
        <p className="text-muted-foreground">
          Top contributors, revenue leaders, and value champions.
        </p>
      </div>

      {myScore && (
        <div className="grid gap-4 md:grid-cols-5">
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
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">Ideas</CardTitle>
              <Lightbulb className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{myScore.ideas_submitted}</div>
            </CardContent>
          </Card>
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
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <TrendingUp className="h-5 w-5" />
            All-Time Rankings
          </CardTitle>
          <CardDescription>
            Points are earned by submitting leads & ideas, and when they get
            qualified, approved, implemented, or won.
          </CardDescription>
        </CardHeader>
        <CardContent>
          {loading ? (
            <p className="text-sm text-muted-foreground py-8 text-center">
              Loading leaderboard...
            </p>
          ) : entries.length === 0 ? (
            <p className="text-sm text-muted-foreground py-8 text-center">
              No scores yet. Start submitting leads and ideas to earn points!
            </p>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead className="w-16">Rank</TableHead>
                  <TableHead>Contributor</TableHead>
                  <TableHead>Role</TableHead>
                  <TableHead className="text-right">Points</TableHead>
                  <TableHead className="text-right">Leads</TableHead>
                  <TableHead className="text-right">Ideas</TableHead>
                  <TableHead className="text-right">Deals Won</TableHead>
                  <TableHead className="text-right">Implemented</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {entries.map((entry) => {
                  const isMe = entry.user_id === user?.id;
                  return (
                    <TableRow
                      key={entry.score_id}
                      className={isMe ? "bg-accent/50" : undefined}
                    >
                      <TableCell className="font-medium">
                        <div className="flex items-center justify-center">
                          {getRankIcon(entry.rank)}
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="flex items-center gap-3">
                          <Avatar className="h-8 w-8">
                            <AvatarFallback className="text-xs bg-primary text-primary-foreground">
                              {entry.user
                                ? getInitials(entry.user.full_name)
                                : "?"}
                            </AvatarFallback>
                          </Avatar>
                          <div>
                            <p className="text-sm font-medium leading-none">
                              {entry.user?.full_name || "Unknown"}
                              {isMe && (
                                <Badge
                                  variant="outline"
                                  className="ml-2 text-xs"
                                >
                                  You
                                </Badge>
                              )}
                            </p>
                            <p className="text-xs text-muted-foreground">
                              {entry.user?.department || entry.user?.email}
                            </p>
                          </div>
                        </div>
                      </TableCell>
                      <TableCell>
                        <Badge variant="secondary" className="text-xs">
                          {roleLabels[entry.user?.role || ""] ||
                            entry.user?.role}
                        </Badge>
                      </TableCell>
                      <TableCell className="text-right font-bold">
                        {entry.total_points.toLocaleString()}
                      </TableCell>
                      <TableCell className="text-right">
                        {entry.leads_submitted}
                      </TableCell>
                      <TableCell className="text-right">
                        {entry.ideas_submitted}
                      </TableCell>
                      <TableCell className="text-right">
                        {entry.deals_won}
                      </TableCell>
                      <TableCell className="text-right">
                        {entry.ideas_implemented}
                      </TableCell>
                    </TableRow>
                  );
                })}
              </TableBody>
            </Table>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
