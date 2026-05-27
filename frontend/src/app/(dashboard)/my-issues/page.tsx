"use client";

import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Badge } from "@/components/ui/badge";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { ImageIcon, Eye, CheckCircle2, PlayCircle, CircleDot } from "lucide-react";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import { isHttpUrl } from "@/lib/utils";

type Screenshot = { url: string; filename: string };
type IssueStatus = "open" | "in_progress" | "resolved";

type Issue = {
  issue_id: string;
  reporter_name: string;
  reporter_email: string;
  description: string;
  screenshots: Screenshot[];
  status: IssueStatus;
  created_at: string;
  updated_at: string;
};

const statusColors: Record<IssueStatus, string> = {
  open: "bg-red-500/10 text-red-500",
  in_progress: "bg-amber-500/10 text-amber-600",
  resolved: "bg-green-500/10 text-green-600",
};

const statusLabel = (s: string) =>
  s === "in_progress" ? "In Progress" : s.charAt(0).toUpperCase() + s.slice(1);

const statusOrder: Record<IssueStatus, number> = { open: 0, in_progress: 1, resolved: 2 };

function StatusBadge({ status }: { status: IssueStatus }) {
  return (
    <Badge className={`w-fit gap-1 border-0 ${statusColors[status]}`}>
      {status === "open" && <CircleDot className="h-3 w-3" />}
      {status === "in_progress" && <PlayCircle className="h-3 w-3" />}
      {status === "resolved" && <CheckCircle2 className="h-3 w-3" />}
      {statusLabel(status)}
    </Badge>
  );
}

export default function MyIssuesPage() {
  const { token, user } = useAuth();
  const [viewIssue, setViewIssue] = useState<Issue | null>(null);

  const { data, isLoading: loading } = useQuery({
    queryKey: ["my-issues"],
    queryFn: () => api<Issue[]>("/api/issues", { token: token! }),
    enabled: !!token && !!user,
    refetchInterval: 30_000,
  });

  // Active first (open, then in-progress); resolved sink to the bottom; newest first.
  const issues = [...(data ?? [])].sort((a, b) => {
    if (statusOrder[a.status] !== statusOrder[b.status]) {
      return statusOrder[a.status] - statusOrder[b.status];
    }
    return new Date(b.created_at).getTime() - new Date(a.created_at).getTime();
  });

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">My Reported Issues</h1>
        <p className="text-muted-foreground">
          Track the status of the issues you have reported.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">Your Issues</CardTitle>
          <CardDescription>
            {issues.length} issue{issues.length !== 1 ? "s" : ""} reported
          </CardDescription>
        </CardHeader>
        <CardContent>
          {loading ? (
            <p className="text-sm text-muted-foreground py-8 text-center">Loading…</p>
          ) : issues.length === 0 ? (
            <p className="text-sm text-muted-foreground py-8 text-center">
              You haven&apos;t reported any issues yet.
            </p>
          ) : (
            <Table className="table-fixed">
              <TableHeader>
                <TableRow>
                  <TableHead className="w-[44%]">Description</TableHead>
                  <TableHead className="w-[16%]">Screenshots</TableHead>
                  <TableHead className="w-[14%]">Reported</TableHead>
                  <TableHead className="w-[14%]">Status</TableHead>
                  <TableHead className="w-[12%] text-right">Action</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {issues.map((issue) => (
                  <TableRow
                    key={issue.issue_id}
                    className={`align-top ${issue.status === "resolved" ? "opacity-60" : ""}`}
                  >
                    <TableCell className="min-w-0">
                      <p className="text-sm text-[#232222] line-clamp-2 break-words">
                        {issue.description}
                      </p>
                    </TableCell>
                    <TableCell className="min-w-0">
                      {issue.screenshots.length === 0 ? (
                        <span className="text-xs text-muted-foreground">—</span>
                      ) : (
                        <div className="flex items-center gap-1 text-xs text-muted-foreground">
                          <ImageIcon className="h-3.5 w-3.5 shrink-0" />
                          {issue.screenshots.length} file
                          {issue.screenshots.length !== 1 ? "s" : ""}
                        </div>
                      )}
                    </TableCell>
                    <TableCell className="text-xs text-muted-foreground whitespace-nowrap">
                      {new Date(issue.created_at).toLocaleDateString()}
                    </TableCell>
                    <TableCell>
                      <StatusBadge status={issue.status} />
                    </TableCell>
                    <TableCell className="text-right">
                      <Button
                        size="sm"
                        variant="ghost"
                        onClick={() => setViewIssue(issue)}
                        className="h-8 justify-center text-xs text-[#B12B35] hover:bg-[#B12B35]/10"
                      >
                        <Eye className="h-3.5 w-3.5" /> View
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          )}
        </CardContent>
      </Card>

      {/* ── View modal ── */}
      <Dialog open={!!viewIssue} onOpenChange={(o) => !o && setViewIssue(null)}>
        <DialogContent className="sm:max-w-lg bg-white">
          <DialogHeader>
            <DialogTitle>Issue Details</DialogTitle>
            <DialogDescription>The issue you reported and its current status.</DialogDescription>
          </DialogHeader>

          {viewIssue && (
            <div className="min-w-0 space-y-4">
              <div className="flex items-center justify-between gap-4">
                <div className="min-w-0">
                  <p className="text-xs font-medium text-muted-foreground">Reported</p>
                  <p className="text-sm text-[#232222]">
                    {new Date(viewIssue.created_at).toLocaleString()}
                  </p>
                </div>
                <StatusBadge status={viewIssue.status} />
              </div>

              <div className="min-w-0">
                <p className="text-xs font-medium text-muted-foreground mb-1">Description</p>
                <div className="max-h-56 overflow-y-auto rounded-md border border-[#EDE7E6] bg-[#F9F9F9] p-3">
                  <p className="text-sm text-[#232222] whitespace-pre-wrap break-words">
                    {viewIssue.description}
                  </p>
                </div>
              </div>

              <div className="min-w-0">
                <p className="text-xs font-medium text-muted-foreground mb-1">
                  Screenshots ({viewIssue.screenshots.length})
                </p>
                {viewIssue.screenshots.length === 0 ? (
                  <p className="text-sm text-muted-foreground">None attached.</p>
                ) : (
                  <div className="max-h-40 space-y-1 overflow-y-auto">
                    {viewIssue.screenshots.map((s, i) => (
                      <a
                        key={`${s.url}-${i}`}
                        href={isHttpUrl(s.url) ? s.url : undefined}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="flex min-w-0 items-center gap-2 rounded-md bg-[#F9F9F9] px-3 py-1.5 text-xs hover:bg-[#B12B35]/5"
                      >
                        <ImageIcon className="h-3.5 w-3.5 shrink-0 text-[#5D5D5D]" />
                        <span className="min-w-0 flex-1 truncate text-[#B12B35] hover:underline">
                          {s.filename}
                        </span>
                      </a>
                    ))}
                  </div>
                )}
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>
    </div>
  );
}
