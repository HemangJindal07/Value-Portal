"use client";

import { useEffect, useState, useCallback } from "react";
import Link from "next/link";
import { ClipboardList, ExternalLink, Clock, CheckCircle2, XCircle, AlertTriangle, Eye, Target, Lightbulb } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Skeleton } from "@/components/ui/skeleton";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import { toast } from "sonner";
import type { AssignmentWithRelations, LeadWithRelations, IdeaWithRelations } from "@/types";

const roleLabels: Record<string, string> = {
  account_owner: "Delivery Head (DH)",
  practice_leader: "Delivery Unit Manager (DU)",
  sales_lead: "Sales Executive",
  review_committee: "Review Committee",
};

const actionColors: Record<string, string> = {
  pending: "bg-amber-500/10 text-amber-400",
  reviewed: "bg-blue-500/10 text-blue-400",
  approved: "bg-green-500/10 text-green-400",
  rejected: "bg-red-500/10 text-red-400",
  escalated: "bg-purple-500/10 text-purple-400",
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

function AssignmentCard({
  assignment,
  onAction,
  actioning,
}: {
  assignment: AssignmentWithRelations;
  onAction: (id: string, action: string) => void;
  actioning: string | null;
}) {
  const due = getDaysRemaining(assignment.due_date);
  const href =
    assignment.submission_type === "lead"
      ? `/leads/${assignment.submission_id}`
      : `/ideas/${assignment.submission_id}`;

  const isPending = assignment.action_taken === "pending";

  return (
    <Card className="hover:bg-muted/30 transition-colors">
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
              <Link
                href={href}
                className="text-sm font-medium hover:underline flex items-center gap-1 truncate"
              >
                {assignment.submission_title ?? "Untitled"}
                <ExternalLink className="h-3 w-3 shrink-0 text-muted-foreground" />
              </Link>
            </div>

            {/* Row 2: meta */}
            <div className="flex items-center gap-3 flex-wrap text-xs text-muted-foreground">
              <span>{assignment.account_name ?? "—"}</span>
              <span>·</span>
              <span>Your role: <span className="text-foreground font-medium">{roleLabels[assignment.assigned_role]}</span></span>
              {assignment.submission_status && (
                <>
                  <span>·</span>
                  <span>Status: <span className="text-foreground">{assignment.submission_status.replace(/_/g, " ")}</span></span>
                </>
              )}
            </div>

            {/* Row 3: due date + action taken */}
            <div className="flex items-center gap-3">
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

          {/* Action buttons — only shown for pending */}
          {isPending && (
            <div className="flex flex-col gap-1.5 shrink-0">
              <Button
                size="sm"
                variant="outline"
                className="h-7 text-xs gap-1"
                disabled={actioning === assignment.assignment_id}
                onClick={() => onAction(assignment.assignment_id, "reviewed")}
              >
                <Eye className="h-3 w-3" />
                Review
              </Button>
              <Button
                size="sm"
                className="h-7 text-xs gap-1 bg-green-600 hover:bg-green-700 text-white"
                disabled={actioning === assignment.assignment_id}
                onClick={() => onAction(assignment.assignment_id, "approved")}
              >
                <CheckCircle2 className="h-3 w-3" />
                Approve
              </Button>
              <Button
                size="sm"
                variant="outline"
                className="h-7 text-xs gap-1 text-red-400 border-red-400/30 hover:bg-red-500/10"
                disabled={actioning === assignment.assignment_id}
                onClick={() => onAction(assignment.assignment_id, "rejected")}
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
  draft:           "bg-[#C5C5C5]/30 text-[#5D5D5D]",
  submitted:       "bg-[#2E75B6]/10 text-[#2E75B6]",
  routing_pending: "bg-amber-100 text-amber-700",
  under_review:    "bg-[#003466]/10 text-[#003466]",
  qualified:       "bg-[#B12B35]/10 text-[#B12B35]",
  approved:        "bg-green-100 text-green-700",
  in_progress:     "bg-[#003466]/10 text-[#003466]",
  implemented:     "bg-[#003466]/15 text-[#003466]",
  won:             "bg-[#003466]/15 text-[#003466]",
  lost:            "bg-[#C5C5C5]/30 text-[#5D5D5D]",
  dropped:         "bg-[#C5C5C5]/30 text-[#5D5D5D]",
  rejected:        "bg-[#E42525]/10 text-[#E42525]",
};

function MySubmissionsTab({
  leads,
  ideas,
  loading,
}: {
  leads: LeadWithRelations[];
  ideas: IdeaWithRelations[];
  loading: boolean;
}) {
  const combined = [
    ...leads.map((l) => ({
      id: l.lead_id,
      type: "lead" as const,
      title: l.title,
      status: l.status,
      account: l.account?.account_name ?? "—",
      href: `/leads/${l.lead_id}`,
      created_at: l.created_at,
    })),
    ...ideas.map((i) => ({
      id: i.idea_id,
      type: "idea" as const,
      title: i.title,
      status: i.status,
      account: i.account?.account_name ?? "—",
      href: `/ideas/${i.idea_id}`,
      created_at: i.created_at,
    })),
  ].sort((a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime());

  if (loading) {
    return (
      <div className="space-y-3 mt-4">
        {Array.from({ length: 3 }).map((_, i) => <SkeletonCard key={i} />)}
      </div>
    );
  }

  if (combined.length === 0) {
    return (
      <div className="text-center py-16 text-muted-foreground mt-4">
        <ClipboardList className="h-10 w-10 mx-auto mb-3 opacity-30" />
        <p className="text-sm">No submissions yet.</p>
        <p className="text-xs mt-1">Submit a lead or value idea to start tracking.</p>
        <div className="flex gap-3 justify-center mt-4">
          <Link
            href="/leads/new"
            className="inline-flex items-center gap-1.5 rounded-lg bg-[#B12B35] px-4 py-2 text-sm font-semibold text-white hover:bg-[#9a2330] transition-colors"
          >
            <Target className="h-4 w-4" /> New Lead
          </Link>
          <Link
            href="/ideas/new"
            className="inline-flex items-center gap-1.5 rounded-lg bg-[#003466] px-4 py-2 text-sm font-semibold text-white hover:bg-[#003466]/90 transition-colors"
          >
            <Lightbulb className="h-4 w-4" /> New Idea
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-3 mt-4">
      {combined.map((item) => (
        <Card key={item.id} className="hover:bg-muted/30 transition-colors">
          <CardContent className="py-4 px-5">
            <div className="flex items-center gap-3 flex-wrap">
              <Badge
                variant="secondary"
                className={`text-[11px] px-2 py-0 ${item.type === "lead" ? "bg-blue-500/10 text-blue-600" : "bg-violet-500/10 text-violet-600"}`}
              >
                {item.type === "lead" ? "Lead" : "Idea"}
              </Badge>
              <Link
                href={item.href}
                className="text-sm font-medium hover:underline flex items-center gap-1"
              >
                {item.title}
                <ExternalLink className="h-3 w-3 shrink-0 text-muted-foreground" />
              </Link>
              <span className="text-xs text-muted-foreground ml-auto">
                {item.account}
              </span>
            </div>
            <div className="mt-2">
              <Badge
                variant="secondary"
                className={`text-[11px] ${submissionStatusColors[item.status] ?? ""}`}
              >
                {item.status.replace(/_/g, " ")}
              </Badge>
            </div>
          </CardContent>
        </Card>
      ))}
    </div>
  );
}

export default function AssignmentsPage() {
  const { token, user } = useAuth();
  const isAdmin = user?.role === "admin";

  const [myAssignments, setMyAssignments] = useState<AssignmentWithRelations[]>([]);
  const [allAssignments, setAllAssignments] = useState<AssignmentWithRelations[]>([]);
  const [myLeads, setMyLeads] = useState<LeadWithRelations[]>([]);
  const [myIdeas, setMyIdeas] = useState<IdeaWithRelations[]>([]);
  const [loading, setLoading] = useState(true);
  const [actioning, setActioning] = useState<string | null>(null);

  const fetchAssignments = useCallback(async () => {
    if (!token) return;
    try {
      const mine = await api<AssignmentWithRelations[]>("/api/assignments/mine", { token });
      setMyAssignments(mine);

      if (isAdmin) {
        const all = await api<AssignmentWithRelations[]>("/api/assignments/all", { token });
        setAllAssignments(all);
      } else {
        // Fetch the user's own submitted leads and ideas for the tracker tab
        const [leads, ideas] = await Promise.all([
          api<LeadWithRelations[]>("/api/leads", { token }),
          api<IdeaWithRelations[]>("/api/ideas", { token }),
        ]);
        if (user?.id) {
          setMyLeads(leads.filter((l) => l.submitted_by === user.id));
          setMyIdeas(ideas.filter((i) => i.submitted_by === user.id));
        }
      }
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to load assignments");
    } finally {
      setLoading(false);
    }
  }, [token, isAdmin, user?.id]);

  useEffect(() => {
    fetchAssignments();
  }, [fetchAssignments]);

  const handleAction = async (assignmentId: string, action: string) => {
    if (!token) return;
    setActioning(assignmentId);
    try {
      await api(`/api/assignments/${assignmentId}`, {
        method: "PATCH",
        body: { action_taken: action },
        token,
      });
      toast.success(`Marked as ${action}`);
      await fetchAssignments();
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Action failed");
    } finally {
      setActioning(null);
    }
  };

  const myPending = myAssignments.filter((a) => a.action_taken === "pending");
  const myActioned = myAssignments.filter((a) => a.action_taken !== "pending");

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight flex items-center gap-2">
            <ClipboardList className="h-6 w-6" />
            My Assignments
          </h1>
          <p className="text-muted-foreground text-sm mt-1">
            Review and act on submissions assigned to you.
          </p>
        </div>
        {myPending.length > 0 && (
          <Badge className="bg-amber-500 text-white text-sm px-3 py-1">
            {myPending.length} pending
          </Badge>
        )}
      </div>

      <Tabs defaultValue={isAdmin ? "pending" : "submissions"}>
        <TabsList>
          {/* My Submissions tracker — end users only */}
          {!isAdmin && (
            <TabsTrigger value="submissions">
              My Submissions
              {(myLeads.length + myIdeas.length) > 0 && (
                <span className="ml-1.5 text-xs bg-[#B12B35]/10 text-[#B12B35] px-1.5 py-0.5 rounded-full">
                  {myLeads.length + myIdeas.length}
                </span>
              )}
            </TabsTrigger>
          )}
          <TabsTrigger value="pending">
            Pending Review
            {myPending.length > 0 && (
              <span className="ml-1.5 text-xs bg-amber-500/20 text-amber-400 px-1.5 py-0.5 rounded-full">
                {myPending.length}
              </span>
            )}
          </TabsTrigger>
          <TabsTrigger value="actioned">
            Reviewed
            {myActioned.length > 0 && (
              <span className="ml-1.5 text-xs bg-muted text-muted-foreground px-1.5 py-0.5 rounded-full">
                {myActioned.length}
              </span>
            )}
          </TabsTrigger>
          {isAdmin && (
            <TabsTrigger value="all">
              Organisation
              {allAssignments.length > 0 && (
                <span className="ml-1.5 text-xs bg-muted text-muted-foreground px-1.5 py-0.5 rounded-full">
                  {allAssignments.length}
                </span>
              )}
            </TabsTrigger>
          )}
        </TabsList>

        {/* My Submissions tab — shows the user's leads + ideas with current status */}
        {!isAdmin && (
          <TabsContent value="submissions">
            <MySubmissionsTab
              leads={myLeads}
              ideas={myIdeas}
              loading={loading}
            />
          </TabsContent>
        )}

        <TabsContent value="pending" className="mt-4 space-y-3">
          {loading ? (
            Array.from({ length: 3 }).map((_, i) => <SkeletonCard key={i} />)
          ) : myPending.length === 0 ? (
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
                actioning={actioning}
              />
            ))
          )}
        </TabsContent>

        <TabsContent value="actioned" className="mt-4 space-y-3">
          {loading ? (
            Array.from({ length: 2 }).map((_, i) => <SkeletonCard key={i} />)
          ) : myActioned.length === 0 ? (
            <p className="text-sm text-muted-foreground py-8 text-center">
              No reviewed assignments yet.
            </p>
          ) : (
            myActioned.map((a) => (
              <AssignmentCard
                key={a.assignment_id}
                assignment={a}
                onAction={handleAction}
                actioning={actioning}
              />
            ))
          )}
        </TabsContent>

        {isAdmin && (
          <TabsContent value="all" className="mt-4 space-y-3">
            {loading ? (
              Array.from({ length: 4 }).map((_, i) => <SkeletonCard key={i} />)
            ) : allAssignments.length === 0 ? (
              <p className="text-sm text-muted-foreground py-8 text-center">
                No assignments across the organisation yet.
              </p>
            ) : (
              allAssignments.map((a) => (
                <AssignmentCard
                  key={a.assignment_id}
                  assignment={a}
                  onAction={handleAction}
                  actioning={actioning}
                />
              ))
            )}
          </TabsContent>
        )}
      </Tabs>
    </div>
  );
}
