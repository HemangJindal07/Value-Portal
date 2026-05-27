"use client";

import { useState } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
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
import { ImageIcon, Eye, Lock, CheckCircle2, PlayCircle, CircleDot } from "lucide-react";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import { isHttpUrl } from "@/lib/utils";
import { toast } from "sonner";

type Screenshot = { url: string; filename: string };
type IssueStatus = "open" | "in_progress" | "resolved";

type Issue = {
  issue_id: string;
  reporter_id: string;
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

export default function AdminIssuesPage() {
  const { token, user: currentUser } = useAuth();
  const queryClient = useQueryClient();

  const [viewIssue, setViewIssue] = useState<Issue | null>(null);
  const [confirmResolve, setConfirmResolve] = useState<Issue | null>(null);
  const [pendingId, setPendingId] = useState<string | null>(null);

  const isAdmin = currentUser?.role === "admin";

  const { data: issuesData, isLoading: loading } = useQuery({
    queryKey: ["admin-issues"],
    queryFn: () => api<Issue[]>("/api/issues", { token: token! }),
    enabled: !!token && !!isAdmin,
  });

  // Active issues first (open, then in-progress), resolved sink to the bottom;
  // within each group, newest first.
  const issues = [...(issuesData ?? [])].sort((a, b) => {
    if (statusOrder[a.status] !== statusOrder[b.status]) {
      return statusOrder[a.status] - statusOrder[b.status];
    }
    return new Date(b.created_at).getTime() - new Date(a.created_at).getTime();
  });

  if (currentUser && !isAdmin) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-muted-foreground">Admin access required.</p>
      </div>
    );
  }

  async function changeStatus(issue: Issue, status: IssueStatus) {
    setPendingId(issue.issue_id);
    try {
      await api(`/api/issues/${issue.issue_id}`, {
        method: "PATCH",
        body: { status },
        token: token!,
      });
      queryClient.invalidateQueries({ queryKey: ["admin-issues"] });
      toast.success(`Issue marked ${statusLabel(status)}.`);
      setViewIssue((v) => (v && v.issue_id === issue.issue_id ? { ...v, status } : v));
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to update status.");
    } finally {
      setPendingId(null);
      setConfirmResolve(null);
    }
  }

  function StatusAction({ issue }: { issue: Issue }) {
    if (issue.status === "resolved") {
      return (
        <span className="inline-flex w-full items-center justify-center gap-1 text-xs text-muted-foreground">
          <Lock className="h-3 w-3" /> Locked
        </span>
      );
    }
    if (issue.status === "open") {
      return (
        <Button
          size="sm"
          variant="outline"
          disabled={pendingId === issue.issue_id}
          onClick={() => changeStatus(issue, "in_progress")}
          className="h-8 w-full justify-center text-xs"
        >
          <PlayCircle className="h-3.5 w-3.5" /> In Progress
        </Button>
      );
    }
    // in_progress → resolve (confirm first)
    return (
      <Button
        size="sm"
        disabled={pendingId === issue.issue_id}
        onClick={() => setConfirmResolve(issue)}
        className="h-8 w-full justify-center bg-green-600 hover:bg-green-700 text-white text-xs"
      >
        <CheckCircle2 className="h-3.5 w-3.5" /> Resolve
      </Button>
    );
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Reported Issues</h1>
        <p className="text-muted-foreground">Issues reported by users across the portal.</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">All Issues</CardTitle>
          <CardDescription>
            {issues.length} issue{issues.length !== 1 ? "s" : ""} reported
          </CardDescription>
        </CardHeader>
        <CardContent>
          {loading ? (
            <p className="text-sm text-muted-foreground py-8 text-center">Loading…</p>
          ) : issues.length === 0 ? (
            <p className="text-sm text-muted-foreground py-8 text-center">
              No issues reported yet.
            </p>
          ) : (
            <Table className="table-fixed">
              <TableHeader>
                <TableRow>
                  <TableHead className="w-[17%]">Reporter</TableHead>
                  <TableHead className="w-[27%]">Description</TableHead>
                  <TableHead className="w-[11%]">Screenshots</TableHead>
                  <TableHead className="w-[10%]">Reported</TableHead>
                  <TableHead className="w-[13%]">Status</TableHead>
                  <TableHead className="w-[22%] text-right">Action</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {issues.map((issue) => (
                  <TableRow
                    key={issue.issue_id}
                    className={`align-top ${issue.status === "resolved" ? "opacity-60" : ""}`}
                  >
                    <TableCell className="min-w-0">
                      <div className="font-medium text-[#232222] truncate">
                        {issue.reporter_name}
                      </div>
                      <div className="text-xs text-muted-foreground truncate">
                        {issue.reporter_email}
                      </div>
                    </TableCell>
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
                    <TableCell>
                      <div className="flex flex-col items-stretch gap-2">
                        <Button
                          size="sm"
                          variant="ghost"
                          onClick={() => setViewIssue(issue)}
                          className="h-8 w-full justify-center text-xs text-[#B12B35] hover:bg-[#B12B35]/10"
                        >
                          <Eye className="h-3.5 w-3.5" /> View
                        </Button>
                        <StatusAction issue={issue} />
                      </div>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          )}
        </CardContent>
      </Card>

      {/* ── View / review modal ── */}
      <Dialog open={!!viewIssue} onOpenChange={(o) => !o && setViewIssue(null)}>
        <DialogContent className="sm:max-w-lg bg-white">
          <DialogHeader>
            <DialogTitle>Issue Details</DialogTitle>
            <DialogDescription>Full report submitted by the user.</DialogDescription>
          </DialogHeader>

          {viewIssue && (
            <div className="min-w-0 space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div className="min-w-0">
                  <p className="text-xs font-medium text-muted-foreground">Reporter</p>
                  <p className="text-sm text-[#232222] truncate">{viewIssue.reporter_name}</p>
                  <p className="text-xs text-muted-foreground truncate">
                    {viewIssue.reporter_email}
                  </p>
                </div>
                <div className="min-w-0">
                  <p className="text-xs font-medium text-muted-foreground">Reported</p>
                  <p className="text-sm text-[#232222]">
                    {new Date(viewIssue.created_at).toLocaleString()}
                  </p>
                  <div className="pt-1">
                    <StatusBadge status={viewIssue.status} />
                  </div>
                </div>
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

              <div className="flex items-center justify-end gap-2 border-t border-[#EDE7E6] pt-3">
                {viewIssue.status === "resolved" ? (
                  <span className="inline-flex items-center gap-1 text-xs text-muted-foreground">
                    <Lock className="h-3 w-3" /> Resolved — status locked
                  </span>
                ) : viewIssue.status === "open" ? (
                  <Button
                    variant="outline"
                    disabled={pendingId === viewIssue.issue_id}
                    onClick={() => changeStatus(viewIssue, "in_progress")}
                  >
                    <PlayCircle className="h-4 w-4" /> Mark In Progress
                  </Button>
                ) : (
                  <Button
                    disabled={pendingId === viewIssue.issue_id}
                    onClick={() => setConfirmResolve(viewIssue)}
                    className="bg-green-600 hover:bg-green-700 text-white"
                  >
                    <CheckCircle2 className="h-4 w-4" /> Mark Resolved
                  </Button>
                )}
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      {/* ── Resolve confirmation ── */}
      <Dialog open={!!confirmResolve} onOpenChange={(o) => !o && setConfirmResolve(null)}>
        <DialogContent className="sm:max-w-md bg-white">
          <DialogHeader>
            <DialogTitle>Resolve this ticket?</DialogTitle>
            <DialogDescription>
              Are you sure you have resolved this ticket assigned to you? Once resolved,
              the status is locked and cannot be changed again.
            </DialogDescription>
          </DialogHeader>
          <div className="flex items-center justify-end gap-2 pt-2">
            <Button variant="outline" onClick={() => setConfirmResolve(null)}>
              Cancel
            </Button>
            <Button
              disabled={!!pendingId}
              onClick={() => confirmResolve && changeStatus(confirmResolve, "resolved")}
              className="bg-green-600 hover:bg-green-700 text-white"
            >
              {pendingId ? "Resolving…" : "Yes, mark resolved"}
            </Button>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
}
