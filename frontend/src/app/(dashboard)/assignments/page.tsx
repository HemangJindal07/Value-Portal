"use client";

import { useEffect, useState, useCallback } from "react";
import Link from "next/link";
import { ClipboardList, ExternalLink, Clock, CheckCircle2, XCircle, AlertTriangle, Eye, Target, Briefcase, Trophy, TrendingDown } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import {
  Table, TableBody, TableCell, TableHead, TableHeader, TableRow,
} from "@/components/ui/table";
import { Input } from "@/components/ui/input";
import { Search } from "lucide-react";
import {
  Select as StatusSelect,
  SelectContent as StatusSelectContent,
  SelectItem as StatusSelectItem,
  SelectTrigger as StatusSelectTrigger,
  SelectValue as StatusSelectValue,
} from "@/components/ui/select";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Skeleton } from "@/components/ui/skeleton";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import { toast } from "sonner";
import type { AssignmentWithRelations, LeadWithRelations } from "@/types";

const roleLabels: Record<string, string> = {
  account_owner: "Delivery Head (DH)",
  practice_leader: "Delivery Unit Manager (DU)",
  sales_lead: "Sales Executive",
  review_committee: "Review Committee",
};

const actionColors: Record<string, string> = {
  pending:              "bg-amber-500/10 text-amber-400",
  reviewed:             "bg-blue-500/10 text-blue-400",
  approved:             "bg-green-500/10 text-green-400",
  rejected:             "bg-red-500/10 text-red-400",
  escalated:            "bg-purple-500/10 text-purple-400",
  opportunity_created:  "bg-[#003466]/10 text-[#003466]",
  won:                  "bg-emerald-500/10 text-emerald-600",
  lost:                 "bg-[#C5C5C5]/30 text-[#5D5D5D]",
};

const submissionTypeColors: Record<string, string> = {
  lead: "bg-blue-500/10 text-blue-400",
  idea: "bg-violet-500/10 text-violet-400",
};

function getDaysRemaining(dueDate: string | null): { label: string; urgent: boolean } {
  if (!dueDate) return { label: "No due date", urgent: false };
  const diff = Math.ceil(
    (new Date(dueDate).getTime() - Date.now()) / (1000 * 60 * 60 * 24)
  );
  if (diff < 0) return { label: `${Math.abs(diff)}d overdue`, urgent: true };
  if (diff === 0) return { label: "Due today", urgent: true };
  if (diff === 1) return { label: "Due tomorrow", urgent: true };
  return { label: `${diff}d remaining`, urgent: false };
}

// 3-tier aging color: green 0-3 days · amber 4-7 days · red 7+ days
function getAgingBorder(assignmentDate: string | null | undefined): string {
  if (!assignmentDate) return "border-l-4 border-l-[#C5C5C5]";
  const daysPending = Math.floor(
    (Date.now() - new Date(assignmentDate).getTime()) / (1000 * 60 * 60 * 24)
  );
  if (daysPending <= 3) return "border-l-4 border-l-green-500";
  if (daysPending <= 7) return "border-l-4 border-l-amber-500";
  return "border-l-4 border-l-red-500";
}

// ── Review Decision Dialog ─────────────────────────────────────────────────
type ReviewPending = {
  assignmentId: string;
  submissionType: "lead" | "idea";
  action: "approved" | "rejected";
};

function ReviewDecisionDialog({
  pending,
  onClose,
  onConfirm,
  submitting,
}: {
  pending: ReviewPending | null;
  onClose: () => void;
  onConfirm: (assignmentId: string, action: string, notes: string) => void;
  submitting: boolean;
}) {
  const [reason, setReason] = useState("");
  const [decision, setDecision] = useState<string>("");

  // Reset form when dialog opens
  useEffect(() => {
    if (pending) {
      setReason("");
      setDecision(pending.action);
    }
  }, [pending]);

  if (!pending) return null;

  const isLead = pending.submissionType === "lead";
  const decisionOptions = isLead
    ? [
        { value: "approved", label: "Qualified — move to next stage" },
        { value: "rejected", label: "Disqualified — does not meet criteria" },
      ]
    : [
        { value: "approved", label: "Approved — proceed with idea" },
        { value: "rejected", label: "Rejected — not viable at this time" },
      ];

  const canSubmit = decision && reason.trim().length >= 10;

  return (
    <Dialog open={!!pending} onOpenChange={(open) => !open && onClose()}>
      <DialogContent className="sm:max-w-md">
        <DialogHeader>
          <DialogTitle className="text-[#232222]">
            {pending.action === "approved" ? "Approve Submission" : "Reject Submission"}
          </DialogTitle>
        </DialogHeader>
        <div className="space-y-4 py-2">
          <div className="space-y-1.5">
            <Label htmlFor="decision" className="text-sm font-medium text-[#232222]">
              Decision <span className="text-red-500">*</span>
            </Label>
            <Select value={decision} onValueChange={(v) => { if (v !== null) setDecision(v); }}>
              <SelectTrigger id="decision" className="border-[#C5C5C5]">
                <SelectValue placeholder="Select a decision…" />
              </SelectTrigger>
              <SelectContent>
                {decisionOptions.map((opt) => (
                  <SelectItem key={opt.value} value={opt.value}>
                    {opt.label}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div className="space-y-1.5">
            <Label htmlFor="reason" className="text-sm font-medium text-[#232222]">
              Reason / Comments <span className="text-red-500">*</span>
            </Label>
            <Textarea
              id="reason"
              placeholder="Provide a clear reason for this decision (min 10 characters)…"
              value={reason}
              onChange={(e) => setReason(e.target.value)}
              rows={4}
              className="border-[#C5C5C5] resize-none text-sm"
            />
            <p className="text-[11px] text-[#5D5D5D]">
              {reason.trim().length}/10 min characters
              {reason.trim().length < 10 && reason.length > 0 && (
                <span className="text-red-400 ml-1">— please add more detail</span>
              )}
            </p>
          </div>
        </div>
        <DialogFooter className="gap-2">
          <Button variant="outline" onClick={onClose} disabled={submitting} className="border-[#C5C5C5]">
            Cancel
          </Button>
          <Button
            disabled={!canSubmit || submitting}
            onClick={() => onConfirm(pending.assignmentId, decision, reason.trim())}
            className={
              decision === "rejected"
                ? "bg-red-600 hover:bg-red-700 text-white"
                : "bg-green-600 hover:bg-green-700 text-white"
            }
          >
            {submitting ? "Submitting…" : decision === "rejected" ? "Confirm Rejection" : "Confirm Approval"}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function AssignmentCard({
  assignment,
  onAction,
  onOpenReview,
  actioning,
  readOnly = false,
}: {
  assignment: AssignmentWithRelations;
  onAction: (id: string, action: string, notes?: string) => void;
  onOpenReview: (pending: ReviewPending) => void;
  actioning: string | null;
  readOnly?: boolean;
}) {
  const due = getDaysRemaining(assignment.due_date);
  const agingBorder = getAgingBorder(assignment.assignment_date);
  const href =
    assignment.submission_type === "lead"
      ? `/leads/${assignment.submission_id}`
      : `/ideas/${assignment.submission_id}`;

  const isPending = assignment.action_taken === "pending" && !readOnly;

  return (
    <Card className={`hover:bg-muted/30 transition-colors overflow-hidden ${agingBorder}`}>
      <CardContent className="py-4 px-5">
        <div className="flex items-start justify-between gap-4">
          <div className="flex-1 min-w-0 space-y-2">
            {/* Row 1: type + title */}
            <div className="flex items-center gap-2 flex-wrap">
              <Badge
                variant="secondary"
                className={`text-[11px] px-2 py-0 ${submissionTypeColors[assignment.submission_type]}`}
              >
                {assignment.submission_type === "lead" ? "Lead" : "Idea"}
              </Badge>
              {assignment.submission_type === "lead" ? (
              <Link
                href={href}
                className="text-sm font-medium hover:underline flex items-center gap-1 truncate"
              >
                {assignment.submission_title ?? "Untitled"}
                <ExternalLink className="h-3 w-3 shrink-0 text-muted-foreground" />
              </Link>
              ) : (
              <span className="text-sm font-medium text-muted-foreground flex items-center gap-1 truncate" title="Value Ideas are disabled">
                {assignment.submission_title ?? "Untitled (legacy idea)"}
              </span>
              )}
            </div>

            {/* Row 2: meta */}
            <div className="flex items-center gap-3 flex-wrap text-xs text-muted-foreground">
              <span>{assignment.account_name ?? "—"}</span>
              <span>·</span>
              <span>Your role: <span className="text-foreground font-medium">{roleLabels[assignment.assigned_role] ?? assignment.assigned_role}</span></span>
              {assignment.submission_status && (
                <>
                  <span>·</span>
                  <span>Status: <span className="text-foreground">{assignment.submission_status.replace(/_/g, " ")}</span></span>
                </>
              )}
            </div>

            {/* Row 3: due date + action taken */}
            <div className="flex items-center gap-3 flex-wrap">
              <span
                className={`text-xs flex items-center gap-1 ${due.urgent ? "text-red-400" : "text-muted-foreground"}`}
              >
                <Clock className="h-3 w-3" />
                {due.label}
              </span>
              <Badge
                variant="secondary"
                className={`text-[11px] px-2 py-0 ${actionColors[assignment.action_taken]}`}
              >
                {assignment.action_taken}
              </Badge>
            </div>

            {assignment.notes && (
              <p className="text-xs text-muted-foreground italic truncate">
                Note: {assignment.notes}
              </p>
            )}
          </div>

          {/* Action buttons */}
          {isPending && (
            <div className="flex flex-col gap-1.5 shrink-0">
              {/* Open link — always shown */}
              <Link href={href} className="inline-flex items-center justify-center gap-1 h-7 px-3 text-xs font-medium rounded-md border border-input bg-background hover:bg-accent hover:text-accent-foreground">
                <Eye className="h-3 w-3" />
                Open
              </Link>

              {/* Qualify / Reject / Escalate — Stage 1: under_review leads */}
              {(assignment.submission_status === "under_review" || assignment.submission_type === "idea") && (
                <>
                  <Button
                    size="sm"
                    className="h-7 text-xs gap-1 bg-green-600 hover:bg-green-700 text-white"
                    disabled={actioning === assignment.assignment_id}
                    onClick={() => onOpenReview({ assignmentId: assignment.assignment_id, submissionType: assignment.submission_type as "lead" | "idea", action: "approved" })}
                  >
                    <CheckCircle2 className="h-3 w-3" />
                    Qualify
                  </Button>
                  <Button
                    size="sm"
                    variant="outline"
                    className="h-7 text-xs gap-1 text-red-400 border-red-400/30 hover:bg-red-500/10"
                    disabled={actioning === assignment.assignment_id}
                    onClick={() => onOpenReview({ assignmentId: assignment.assignment_id, submissionType: assignment.submission_type as "lead" | "idea", action: "rejected" })}
                  >
                    <XCircle className="h-3 w-3" />
                    Reject
                  </Button>
                  <Button
                    size="sm"
                    variant="outline"
                    className="h-7 text-xs gap-1 text-purple-400 border-purple-400/30 hover:bg-purple-500/10"
                    disabled={actioning === assignment.assignment_id}
                    onClick={() => onAction(assignment.assignment_id, "escalated")}
                  >
                    <AlertTriangle className="h-3 w-3" />
                    Escalate
                  </Button>
                </>
              )}
            </div>
          )}
        </div>
      </CardContent>
    </Card>
  );
}

function SkeletonCard() {
  return (
    <Card>
      <CardContent className="py-4 px-5 space-y-3">
        <Skeleton className="h-4 w-2/3" />
        <Skeleton className="h-3 w-1/2" />
        <Skeleton className="h-3 w-1/3" />
      </CardContent>
    </Card>
  );
}

const submissionStatusColors: Record<string, string> = {
  draft:                "bg-[#C5C5C5]/30 text-[#5D5D5D]",
  submitted:            "bg-[#2E75B6]/10 text-[#2E75B6]",
  routing_pending:      "bg-amber-100 text-amber-700",
  opportunity_created:  "bg-[#003466]/10 text-[#003466]",
  under_review:    "bg-[#003466]/10 text-[#003466]",
  qualified:       "bg-green-100 text-green-700",
  approved:        "bg-green-100 text-green-700",
  in_progress:     "bg-[#003466]/10 text-[#003466]",
  implemented:     "bg-[#003466]/15 text-[#003466]",
  won:             "bg-emerald-100 text-emerald-700",
  lost:            "bg-[#C5C5C5]/30 text-[#5D5D5D]",
  dropped:         "bg-[#C5C5C5]/30 text-[#5D5D5D]",
  rejected:        "bg-red-100 text-red-700",
};

const submissionPriorityColors: Record<string, string> = {
  high:   "bg-[#E42525]/10 text-[#E42525]",
  medium: "bg-[#003466]/10 text-[#003466]",
  low:    "bg-[#2E75B6]/10 text-[#2E75B6]",
};

const accountTypeLabels: Record<string, string> = {
  current_lead: "Existing Account",
  new_lead:     "New Account",
};

function MySubmissionsTab({
  leads,
  loading,
}: {
  leads: LeadWithRelations[];
  loading: boolean;
}) {
  const [search, setSearch] = useState("");
  const [statusFilter, setStatusFilter] = useState("");

  const sorted = [...leads].sort(
    (a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime()
  );

  const filtered = sorted.filter((l) => {
    const matchSearch = !search || l.title.toLowerCase().includes(search.toLowerCase());
    const matchStatus = !statusFilter || l.status === statusFilter;
    return matchSearch && matchStatus;
  });

  if (loading) {
    return (
      <div className="space-y-3 mt-4">
        {Array.from({ length: 3 }).map((_, i) => <SkeletonCard key={i} />)}
      </div>
    );
  }

  return (
    <div className="space-y-4 mt-4">
      {/* Filters */}
      <div className="flex gap-3 flex-wrap">
        <div className="relative max-w-xs">
          <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
          <Input
            placeholder="Search leads..."
            className="pl-9"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
          />
        </div>
        <StatusSelect value={statusFilter} onValueChange={(v) => setStatusFilter(v ?? "")}>
          <StatusSelectTrigger className="w-44">
            <StatusSelectValue placeholder="All Statuses" />
          </StatusSelectTrigger>
          <StatusSelectContent>
            <StatusSelectItem value="">All Statuses</StatusSelectItem>
            <StatusSelectItem value="submitted">Submitted</StatusSelectItem>
            <StatusSelectItem value="routing_pending">Routing Pending</StatusSelectItem>
            <StatusSelectItem value="under_review">Under Review</StatusSelectItem>
            <StatusSelectItem value="qualified">Qualified</StatusSelectItem>
            <StatusSelectItem value="approved">Approved</StatusSelectItem>
            <StatusSelectItem value="won">Won</StatusSelectItem>
            <StatusSelectItem value="lost">Lost</StatusSelectItem>
            <StatusSelectItem value="rejected">Rejected</StatusSelectItem>
          </StatusSelectContent>
        </StatusSelect>
      </div>

      <Card>
        <CardHeader className="pb-2">
          <CardTitle className="text-base">My Leads</CardTitle>
          <CardDescription>{filtered.length} lead{filtered.length !== 1 ? "s" : ""}</CardDescription>
        </CardHeader>
        <CardContent className="p-0">
          {filtered.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-12 text-center px-6">
              <Target className="h-10 w-10 text-muted-foreground mb-3" />
              <p className="text-sm text-muted-foreground">
                {leads.length === 0 ? "No submissions yet. Submit a lead to start tracking." : "No leads match your filters."}
              </p>
              {leads.length === 0 && (
                <Link
                  href="/leads/new"
                  className="mt-4 inline-flex items-center gap-1.5 rounded-lg bg-[#B12B35] px-4 py-2 text-sm font-semibold text-white hover:bg-[#9a2330] transition-colors"
                >
                  <Target className="h-4 w-4" /> Submit New Lead
                </Link>
              )}
            </div>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Title</TableHead>
                  <TableHead>Account</TableHead>
                  <TableHead>Contact</TableHead>
                  <TableHead>Service Line</TableHead>
                  <TableHead>Account Type</TableHead>
                  <TableHead>Priority</TableHead>
                  <TableHead>Status</TableHead>
                  <TableHead className="text-right">Est. Value</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {filtered.map((lead) => {
                  const cd = lead.contact_details as { name?: string; email?: string; title?: string } | null;
                  const STATUS_DISPLAY: Record<string, string> = {
                    submitted:           "Submitted",
                    routing_pending:     "Routing Pending",
                    under_review:        "Under Review",
                    qualified:           "Qualified",
                    rejected:            "Rejected",
                    opportunity_created: "Opportunity Created",
                    won:                 "Won",
                    lost:                "Lost",
                    dropped:             "Dropped",
                    draft:               "Draft",
                  };
                  const statusDisplay = STATUS_DISPLAY[lead.status] ?? lead.status.replace(/_/g, " ");
                  return (
                  <TableRow key={lead.lead_id}>
                    <TableCell>
                      <Link
                        href={`/leads/${lead.lead_id}`}
                        className="font-medium hover:underline"
                      >
                        {lead.title}
                      </Link>
                    </TableCell>
                    <TableCell className="text-muted-foreground">
                      {lead.account?.account_name ?? "—"}
                    </TableCell>
                    <TableCell>
                      {cd?.name ? (
                        <div className="text-xs">
                          <p className="font-medium text-[#232222]">{cd.name}</p>
                          {cd.email && <p className="text-muted-foreground">{cd.email}</p>}
                          {cd.title && <p className="text-muted-foreground">{cd.title}</p>}
                        </div>
                      ) : (
                        <span className="text-muted-foreground text-xs">—</span>
                      )}
                    </TableCell>
                    <TableCell>
                      {lead.service ? (
                        <Badge variant="secondary" className="text-[11px] bg-purple-500/10 text-purple-600">
                          {lead.service}
                        </Badge>
                      ) : (
                        <span className="text-muted-foreground text-xs">—</span>
                      )}
                    </TableCell>
                    <TableCell>
                      <Badge variant="outline" className="text-[11px]">
                        {accountTypeLabels[lead.lead_type] || lead.lead_type}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <Badge variant="secondary" className={`text-[11px] ${submissionPriorityColors[lead.priority] ?? ""}`}>
                        {lead.priority.charAt(0).toUpperCase() + lead.priority.slice(1)}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <Badge variant="secondary" className={`text-[11px] ${submissionStatusColors[lead.status] ?? ""}`}>
                        {statusDisplay}
                      </Badge>
                    </TableCell>
                    <TableCell className="text-right">
                      {lead.estimated_value
                        ? `$${Number(lead.estimated_value).toLocaleString()}`
                        : "—"}
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

export default function AssignmentsPage() {
  const { token, user } = useAuth();
  const isOrgRole = user?.role === "admin" || user?.role === "executive";

  const [myAssignments, setMyAssignments] = useState<AssignmentWithRelations[]>([]);
  const [allAssignments, setAllAssignments] = useState<AssignmentWithRelations[]>([]);
  const [myLeads, setMyLeads] = useState<LeadWithRelations[]>([]);
  const [orgLeads, setOrgLeads] = useState<LeadWithRelations[]>([]);
  const [loading, setLoading] = useState(true);
  const [activeTab, setActiveTab] = useState<string | null>(null);
  const [actioning, setActioning] = useState<string | null>(null);
  const [reviewPending, setReviewPending] = useState<ReviewPending | null>(null);
  const [wlConfirm, setWlConfirm] = useState<{ assignmentId: string; action: "won" | "lost"; title: string } | null>(null);

  // Set the default tab once we know the user's role (avoids Base UI uncontrolled warning)
  useEffect(() => {
    if (user && activeTab === null) {
      setActiveTab(isOrgRole ? "pending" : "submissions");
    }
  }, [user, isOrgRole, activeTab]);

  const fetchAssignments = useCallback(async () => {
    if (!token) return;
    try {
      const mine = await api<AssignmentWithRelations[]>("/api/assignments/mine", { token });
      setMyAssignments(mine);

      if (isOrgRole) {
        const all = await api<AssignmentWithRelations[]>("/api/assignments/all", { token });
        setAllAssignments(all);
        const leads = await api<LeadWithRelations[]>("/api/leads", { token });
        setOrgLeads(Array.isArray(leads) ? leads : []);
      } else {
        const leads = await api<LeadWithRelations[]>("/api/leads", { token });
        // const ideas = await api<IdeaWithRelations[]>("/api/ideas", { token }); // Value Ideas disabled
        if (user?.id) {
          setMyLeads(leads.filter((l) => l.submitted_by === user.id));
        }
      }
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to load assignments");
    } finally {
      setLoading(false);
    }
  }, [token, isOrgRole, user?.id]);

  useEffect(() => {
    fetchAssignments();
  }, [fetchAssignments]);

  const handleAction = async (assignmentId: string, action: string, notes?: string) => {
    if (!token) return;
    setActioning(assignmentId);
    try {
      await api(`/api/assignments/${assignmentId}`, {
        method: "PATCH",
        body: { action_taken: action, ...(notes ? { notes } : {}) },
        token,
      });
      toast.success(`Marked as ${action}`);
      setReviewPending(null);
      await fetchAssignments();
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Action failed");
    } finally {
      setActioning(null);
    }
  };

  const myPending = myAssignments.filter((a) => a.action_taken === "pending");
  // Reviewed: all actioned assignments, sorted by action_date descending (most recent first)
  const myActioned = [...myAssignments.filter((a) => a.action_taken !== "pending")].sort(
    (a, b) => new Date(b.action_date ?? b.created_at).getTime() - new Date(a.action_date ?? a.created_at).getTime()
  );

  // User-perspective tabs (non-org role):
  const myUnderReview = myLeads.filter((l) =>
    ["submitted", "routing_pending", "under_review"].includes(l.status)
  );
  const myQualifiedRejected = myLeads.filter((l) =>
    ["qualified", "rejected", "opportunity_created", "won", "lost"].includes(l.status)
  );

  // Org-role: Stage 2 — pending assignments on qualified leads (approve opportunity or reject)
  const oppPendingAssignments = allAssignments.filter(
    (a) => a.action_taken === "pending" && a.submission_status === "qualified" && a.submission_type === "lead"
  );

  // Org-role: Stage 3 — pending assignments on opportunity_created leads (won or lost)
  const wonLostPendingAssignments = allAssignments.filter(
    (a) => a.action_taken === "pending" && a.submission_status === "opportunity_created" && a.submission_type === "lead"
  );

  // Won/Loss history — closed leads
  const wonLostLeads = orgLeads.filter((l) => ["won", "lost"].includes(l.status));

  const handleWonLost = async (assignmentId: string, action: "won" | "lost", title: string) => {
    if (!token) return;
    setActioning(assignmentId);
    try {
      await api(`/api/assignments/${assignmentId}`, {
        method: "PATCH",
        body: { action_taken: action },
        token,
      });
      toast.success(`Lead marked as ${action === "won" ? "Won" : "Lost"}`);
      setWlConfirm(null);
      await fetchAssignments();
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Action failed");
    } finally {
      setActioning(null);
    }
  };

  return (
    <div className="space-y-6">
      <ReviewDecisionDialog
        pending={reviewPending}
        onClose={() => setReviewPending(null)}
        onConfirm={handleAction}
        submitting={actioning !== null}
      />

      {/* Won / Lost confirmation dialog */}
      {wlConfirm && (
        <Dialog open={!!wlConfirm} onOpenChange={(open) => !open && setWlConfirm(null)}>
          <DialogContent className="sm:max-w-md">
            <DialogHeader>
              <DialogTitle className="text-[#232222]">
                Confirm — Mark as {wlConfirm.action === "won" ? "Won" : "Lost"}
              </DialogTitle>
            </DialogHeader>
            <p className="text-sm text-muted-foreground py-2">
              Are you sure you want to mark <strong>&ldquo;{wlConfirm.title}&rdquo;</strong> as{" "}
              <strong className={wlConfirm.action === "won" ? "text-emerald-600" : "text-[#5D5D5D]"}>
                {wlConfirm.action === "won" ? "Won" : "Lost"}
              </strong>?
              {wlConfirm.action === "won" && (
                <span className="block mt-1 text-[#B12B35] font-medium">+100 points will be awarded to the submitter.</span>
              )}
            </p>
            <DialogFooter className="gap-2">
              <Button variant="outline" onClick={() => setWlConfirm(null)} disabled={actioning !== null}>
                Cancel
              </Button>
              <Button
                disabled={actioning !== null}
                onClick={() => handleWonLost(wlConfirm.assignmentId, wlConfirm.action, wlConfirm.title)}
                className={wlConfirm.action === "won" ? "bg-emerald-600 hover:bg-emerald-700 text-white" : "bg-[#5D5D5D] hover:bg-[#3D3D3D] text-white"}
              >
                {actioning ? "Processing…" : `Confirm ${wlConfirm.action === "won" ? "Won" : "Lost"}`}
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      )}

      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight flex items-center gap-2">
            <ClipboardList className="h-6 w-6" />
            {isOrgRole ? "My Assignments" : "My Submissions"}
          </h1>
          <p className="text-muted-foreground text-sm mt-1">
            {isOrgRole
              ? "Review and act on leads assigned to you."
              : "Review and act on submissions assigned to you."}
          </p>
        </div>
        {myPending.length > 0 && (
          <Badge className="bg-amber-500 text-white text-sm px-3 py-1">
            {myPending.length} pending
          </Badge>
        )}
      </div>

      <Tabs value={activeTab ?? (isOrgRole ? "pending" : "submissions")} onValueChange={setActiveTab}>
        <TabsList>
          {/* My Submissions tracker — end users only */}
          {!isOrgRole && (
            <TabsTrigger value="submissions">
              My Submissions
              {myLeads.length > 0 && (
                <span className="ml-1.5 text-xs bg-[#B12B35]/10 text-[#B12B35] px-1.5 py-0.5 rounded-full">
                  {myLeads.length}
                </span>
              )}
            </TabsTrigger>
          )}
          <TabsTrigger value="pending">
            {isOrgRole ? "Pending Review" : "Under Review"}
            {isOrgRole ? (
              myPending.length > 0 && (
                <span className="ml-1.5 text-xs bg-amber-500/20 text-amber-400 px-1.5 py-0.5 rounded-full">
                  {myPending.length}
                </span>
              )
            ) : (
              myUnderReview.length > 0 && (
                <span className="ml-1.5 text-xs bg-[#003466]/10 text-[#003466] px-1.5 py-0.5 rounded-full">
                  {myUnderReview.length}
                </span>
              )
            )}
          </TabsTrigger>
          <TabsTrigger value="actioned">
            {isOrgRole ? "Reviewed" : "Qualified / Rejected"}
            {isOrgRole ? (
              myActioned.length > 0 && (
                <span className="ml-1.5 text-xs bg-muted text-muted-foreground px-1.5 py-0.5 rounded-full">
                  {myActioned.length}
                </span>
              )
            ) : (
              myQualifiedRejected.length > 0 && (
                <span className="ml-1.5 text-xs bg-[#B12B35]/10 text-[#B12B35] px-1.5 py-0.5 rounded-full">
                  {myQualifiedRejected.length}
                </span>
              )
            )}
          </TabsTrigger>
          {isOrgRole && (
            <TabsTrigger value="all">
              Organisation
              {allAssignments.length > 0 && (
                <span className="ml-1.5 text-xs bg-muted text-muted-foreground px-1.5 py-0.5 rounded-full">
                  {allAssignments.length}
                </span>
              )}
            </TabsTrigger>
          )}
          {isOrgRole && (
            <TabsTrigger value="opportunity_created">
              Opportunity Created
              {oppPendingAssignments.length > 0 && (
                <span className="ml-1.5 text-xs bg-purple-500/20 text-purple-600 px-1.5 py-0.5 rounded-full">
                  {oppPendingAssignments.length}
                </span>
              )}
            </TabsTrigger>
          )}
          {isOrgRole && (
            <TabsTrigger value="won_loss">
              Won / Loss
              {wonLostPendingAssignments.length > 0 && (
                <span className="ml-1.5 text-xs bg-emerald-500/20 text-emerald-600 px-1.5 py-0.5 rounded-full">
                  {wonLostPendingAssignments.length}
                </span>
              )}
            </TabsTrigger>
          )}
        </TabsList>

        {/* My Submissions tab — user's leads only (Value Ideas disabled) */}
        {!isOrgRole && (
          <TabsContent value="submissions">
            <MySubmissionsTab
              leads={myLeads}
              loading={loading}
            />
          </TabsContent>
        )}

        <TabsContent value="pending" className="mt-4 space-y-3">
          {loading ? (
            Array.from({ length: 3 }).map((_, i) => <SkeletonCard key={i} />)
          ) : isOrgRole ? (
            myPending.length === 0 ? (
              <div className="text-center py-16 text-muted-foreground">
                <ClipboardList className="h-10 w-10 mx-auto mb-3 opacity-30" />
                <p className="text-sm">No pending assignments.</p>
                <p className="text-xs mt-1">You&apos;re all caught up!</p>
              </div>
            ) : (
              myPending.map((a) => (
                <AssignmentCard
                  key={a.assignment_id}
                  assignment={a}
                  onAction={handleAction}
                  onOpenReview={setReviewPending}
                  actioning={actioning}
                />
              ))
            )
          ) : (
            <MySubmissionsTab leads={myUnderReview} loading={false} />
          )}
        </TabsContent>

        <TabsContent value="actioned" className="mt-4 space-y-3">
          {loading ? (
            Array.from({ length: 2 }).map((_, i) => <SkeletonCard key={i} />)
          ) : isOrgRole ? (
            myActioned.length === 0 ? (
              <p className="text-sm text-muted-foreground py-8 text-center">
                No reviewed assignments yet.
              </p>
            ) : (
              <>
                <p className="text-xs text-muted-foreground pb-1">
                  Most recently actioned first. Status shows the <strong>current</strong> state of each lead.
                </p>
                <Card className="border-[#EDE7E6]">
                  <CardContent className="p-0">
                    <Table>
                      <TableHeader>
                        <TableRow>
                          <TableHead>Lead</TableHead>
                          <TableHead>Account</TableHead>
                          <TableHead>Your Role</TableHead>
                          <TableHead>Actioned</TableHead>
                          <TableHead className="text-right">Current Status</TableHead>
                        </TableRow>
                      </TableHeader>
                      <TableBody>
                        {myActioned.map((a) => {
                          const STATUS_DISPLAY: Record<string, string> = {
                            submitted: "Submitted", routing_pending: "Routing Pending",
                            under_review: "Under Review", qualified: "Qualified",
                            opportunity_created: "Opportunity Created",
                            won: "Won", lost: "Lost", rejected: "Rejected", dropped: "Dropped",
                          };
                          const liveStatus = a.submission_status ?? "";
                          const statusDisplay = STATUS_DISPLAY[liveStatus] ?? liveStatus.replace(/_/g, " ");
                          const statusColor = submissionStatusColors[liveStatus] ?? "bg-muted text-muted-foreground";
                          const actionDate = a.action_date ? new Date(a.action_date).toLocaleDateString() : "—";
                          return (
                            <TableRow key={a.assignment_id}>
                              <TableCell>
                                {a.submission_type === "lead" ? (
                                  <Link href={`/leads/${a.submission_id}`} className="font-medium hover:underline flex items-center gap-1">
                                    {a.submission_title ?? "Untitled"}
                                    <ExternalLink className="h-3 w-3 shrink-0 text-muted-foreground" />
                                  </Link>
                                ) : (
                                  <span className="font-medium text-muted-foreground">{a.submission_title ?? "Untitled"}</span>
                                )}
                              </TableCell>
                              <TableCell className="text-muted-foreground text-sm">{a.account_name ?? "—"}</TableCell>
                              <TableCell className="text-sm">{roleLabels[a.assigned_role] ?? a.assigned_role}</TableCell>
                              <TableCell className="text-sm text-muted-foreground">{actionDate}</TableCell>
                              <TableCell className="text-right">
                                <Badge variant="secondary" className={`text-[11px] ${statusColor}`}>
                                  {statusDisplay}
                                </Badge>
                              </TableCell>
                            </TableRow>
                          );
                        })}
                      </TableBody>
                    </Table>
                  </CardContent>
                </Card>
              </>
            )
          ) : (
            <MySubmissionsTab leads={myQualifiedRejected} loading={false} />
          )}
        </TabsContent>

        {isOrgRole && (
          <TabsContent value="all" className="mt-4 space-y-3">
            {loading ? (
              Array.from({ length: 4 }).map((_, i) => <SkeletonCard key={i} />)
            ) : allAssignments.length === 0 ? (
              <p className="text-sm text-muted-foreground py-8 text-center">
                No assignments across the organisation yet.
              </p>
            ) : (
              <>
                {user?.role === "executive" && (
                  <p className="text-xs text-muted-foreground pb-1">
                    Viewing all organisation assignments — use <strong>Pending Review</strong> to action your own assignments.
                  </p>
                )}
                {allAssignments.map((a) => (
                  <AssignmentCard
                    key={a.assignment_id}
                    assignment={a}
                    onAction={handleAction}
                    onOpenReview={setReviewPending}
                    actioning={actioning}
                    readOnly={user?.role === "executive"}
                  />
                ))}
              </>
            )}
          </TabsContent>
        )}

        {/* ── Opportunity Created tab — Stage 2: approve or reject opportunity ── */}
        {isOrgRole && (
          <TabsContent value="opportunity_created" className="mt-4 space-y-4">
            <Card className="border-[#EDE7E6] bg-[#F9F9F9]">
              <CardContent className="py-3 px-4">
                <p className="text-sm text-[#5D5D5D] italic">
                  These qualified leads are awaiting your decision: approve to create an opportunity or reject to close them.
                </p>
              </CardContent>
            </Card>
            {loading ? (
              Array.from({ length: 3 }).map((_, i) => <SkeletonCard key={i} />)
            ) : oppPendingAssignments.length === 0 ? (
              <div className="text-center py-16 text-muted-foreground">
                <Briefcase className="h-10 w-10 mx-auto mb-3 opacity-30" />
                <p className="text-sm">No qualified leads awaiting opportunity review.</p>
              </div>
            ) : (
              <Card className="border-[#EDE7E6]">
                <CardContent className="p-0">
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>Lead</TableHead>
                        <TableHead>Account</TableHead>
                        <TableHead>Submitted By</TableHead>
                        <TableHead className="text-right">Action</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {oppPendingAssignments.map((a) => (
                        <TableRow key={a.assignment_id}>
                          <TableCell>
                            <Link href={`/leads/${a.submission_id}`} className="font-medium hover:underline flex items-center gap-1">
                              {a.submission_title ?? "Untitled"}
                              <ExternalLink className="h-3 w-3 shrink-0 text-muted-foreground" />
                            </Link>
                          </TableCell>
                          <TableCell className="text-muted-foreground text-sm">{a.account_name ?? "—"}</TableCell>
                          <TableCell className="text-muted-foreground text-sm">
                            {(a as AssignmentWithRelations & { submitter_name?: string }).submitter_name ?? "—"}
                          </TableCell>
                          <TableCell className="text-right">
                            <div className="flex gap-1.5 justify-end">
                              <Button
                                size="sm"
                                className="h-7 text-xs bg-[#003466] hover:bg-[#002244] text-white gap-1"
                                disabled={actioning === a.assignment_id}
                                onClick={() => handleAction(a.assignment_id, "approved")}
                              >
                                <Briefcase className="h-3 w-3" /> Approve Opportunity
                              </Button>
                              <Button
                                size="sm"
                                variant="outline"
                                className="h-7 text-xs gap-1 text-red-400 border-red-400/30 hover:bg-red-500/10"
                                disabled={actioning === a.assignment_id}
                                onClick={() => setReviewPending({ assignmentId: a.assignment_id, submissionType: "lead", action: "rejected" })}
                              >
                                <XCircle className="h-3 w-3" /> Reject
                              </Button>
                            </div>
                          </TableCell>
                        </TableRow>
                      ))}
                    </TableBody>
                  </Table>
                </CardContent>
              </Card>
            )}
          </TabsContent>
        )}

        {/* ── Won / Loss tab — Stage 3: mark opportunity as won or lost ── */}
        {isOrgRole && (
          <TabsContent value="won_loss" className="mt-4 space-y-4">
            {/* Pending Won/Lost decisions */}
            {wonLostPendingAssignments.length > 0 && (
              <>
                <Card className="border-[#EDE7E6] bg-[#F9F9F9]">
                  <CardContent className="py-3 px-4">
                    <p className="text-sm text-[#5D5D5D] italic">
                      These opportunities are awaiting your final decision — mark each as Won or Lost.
                    </p>
                  </CardContent>
                </Card>
                <Card className="border-[#EDE7E6]">
                  <CardContent className="p-0">
                    <Table>
                      <TableHeader>
                        <TableRow>
                          <TableHead>Lead</TableHead>
                          <TableHead>Account</TableHead>
                          <TableHead>Submitted By</TableHead>
                          <TableHead className="text-right">Action</TableHead>
                        </TableRow>
                      </TableHeader>
                      <TableBody>
                        {wonLostPendingAssignments.map((a) => (
                          <TableRow key={a.assignment_id}>
                            <TableCell>
                              <Link href={`/leads/${a.submission_id}`} className="font-medium hover:underline flex items-center gap-1">
                                {a.submission_title ?? "Untitled"}
                                <ExternalLink className="h-3 w-3 shrink-0 text-muted-foreground" />
                              </Link>
                            </TableCell>
                            <TableCell className="text-muted-foreground text-sm">{a.account_name ?? "—"}</TableCell>
                            <TableCell className="text-muted-foreground text-sm">
                              {(a as AssignmentWithRelations & { submitter_name?: string }).submitter_name ?? "—"}
                            </TableCell>
                            <TableCell className="text-right">
                              <div className="flex gap-1.5 justify-end">
                                <Button
                                  size="sm"
                                  className="h-7 text-xs bg-emerald-600 hover:bg-emerald-700 text-white gap-1"
                                  disabled={actioning === a.assignment_id}
                                  onClick={() => setWlConfirm({ assignmentId: a.assignment_id, action: "won", title: a.submission_title ?? "" })}
                                >
                                  <Trophy className="h-3 w-3" /> Won
                                </Button>
                                <Button
                                  size="sm"
                                  variant="outline"
                                  className="h-7 text-xs gap-1 text-[#5D5D5D] border-[#C5C5C5] hover:bg-muted"
                                  disabled={actioning === a.assignment_id}
                                  onClick={() => setWlConfirm({ assignmentId: a.assignment_id, action: "lost", title: a.submission_title ?? "" })}
                                >
                                  <TrendingDown className="h-3 w-3" /> Lost
                                </Button>
                              </div>
                            </TableCell>
                          </TableRow>
                        ))}
                      </TableBody>
                    </Table>
                  </CardContent>
                </Card>
              </>
            )}

            {/* Closed history */}
            {loading ? (
              Array.from({ length: 3 }).map((_, i) => <SkeletonCard key={i} />)
            ) : wonLostLeads.length === 0 && wonLostPendingAssignments.length === 0 ? (
              <div className="text-center py-16 text-muted-foreground">
                <Trophy className="h-10 w-10 mx-auto mb-3 opacity-30" />
                <p className="text-sm">No closed leads yet.</p>
              </div>
            ) : wonLostLeads.length > 0 ? (
              <>
                <p className="text-xs font-medium text-muted-foreground uppercase tracking-wide pt-2">Closed Leads</p>
                <Card className="border-[#EDE7E6]">
                  <CardContent className="p-0">
                    <Table>
                      <TableHeader>
                        <TableRow>
                          <TableHead>Lead</TableHead>
                          <TableHead>Account</TableHead>
                          <TableHead>Service Line</TableHead>
                          <TableHead>Submitted By</TableHead>
                          <TableHead className="text-right">Est. Value</TableHead>
                          <TableHead className="text-right">Outcome</TableHead>
                        </TableRow>
                      </TableHeader>
                      <TableBody>
                        {wonLostLeads.map((lead) => (
                          <TableRow key={lead.lead_id}>
                            <TableCell>
                              <Link href={`/leads/${lead.lead_id}`} className="font-medium hover:underline flex items-center gap-1">
                                {lead.title}
                                <ExternalLink className="h-3 w-3 shrink-0 text-muted-foreground" />
                              </Link>
                            </TableCell>
                            <TableCell className="text-muted-foreground">{lead.account?.account_name ?? "—"}</TableCell>
                            <TableCell>
                              {lead.service ? (
                                <Badge variant="secondary" className="text-[11px] bg-purple-500/10 text-purple-600">{lead.service}</Badge>
                              ) : <span className="text-xs text-muted-foreground">—</span>}
                            </TableCell>
                            <TableCell className="text-muted-foreground text-sm">{lead.submitter?.full_name ?? "—"}</TableCell>
                            <TableCell className="text-right text-sm">
                              {lead.estimated_value ? `$${Number(lead.estimated_value).toLocaleString()}` : "—"}
                            </TableCell>
                            <TableCell className="text-right">
                              <Badge
                                variant="secondary"
                                className={lead.status === "won" ? "bg-emerald-100 text-emerald-700" : "bg-[#C5C5C5]/30 text-[#5D5D5D]"}
                              >
                                {lead.status === "won" ? "Won" : "Lost"}
                              </Badge>
                            </TableCell>
                          </TableRow>
                        ))}
                      </TableBody>
                    </Table>
                  </CardContent>
                </Card>
              </>
            ) : null}
          </TabsContent>
        )}
      </Tabs>
    </div>
  );
}
