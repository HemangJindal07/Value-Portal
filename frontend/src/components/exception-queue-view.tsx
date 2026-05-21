"use client";

import { useEffect, useState, useCallback } from "react";
import Link from "next/link";
import {
  AlertTriangle,
  RefreshCw,
  ExternalLink,
  GitMerge,
  Route,
  Target,
  Clock,
} from "lucide-react";
import { Button } from "@/components/ui/button";
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
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import { Skeleton } from "@/components/ui/skeleton";
import { UserCombobox } from "@/components/user-combobox";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import { toast } from "sonner";
import type { LeadWithRelations } from "@/types";

// "admin"     → full remediation UI (Fix Mapping, yellow banner, help footer)
// "executive" → read-only view: lead list + View only (no admin config links)
type ExceptionQueueVariant = "admin" | "executive";

// ── Helpers ───────────────────────────────────────────────────────────────────

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

// ── Leads exception table ─────────────────────────────────────────────────────

function LeadsTable({
  leads,
  loading,
  showFixMapping,
  onFixMapping,
}: {
  leads: LeadWithRelations[];
  loading: boolean;
  showFixMapping: boolean;
  onFixMapping: (lead: LeadWithRelations) => void;
}) {
  if (loading) {
    return (
      <div className="space-y-2">
        {[1, 2, 3].map((i) => (
          <Skeleton key={i} className="h-14 w-full" />
        ))}
      </div>
    );
  }

  if (leads.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-12 text-center">
        <div className="h-12 w-12 rounded-full bg-green-100 flex items-center justify-center mb-3">
          <Target className="h-6 w-6 text-green-600" />
        </div>
        <p className="text-sm font-medium text-[#232222]">No pending leads</p>
        <p className="text-xs text-muted-foreground mt-1">
          All leads are routed correctly.
        </p>
      </div>
    );
  }

  return (
    <Table>
      <TableHeader>
        <TableRow>
          <TableHead>Lead Title</TableHead>
          <TableHead>Account</TableHead>
          <TableHead>Industry / Region</TableHead>
          <TableHead>Submitted By</TableHead>
          <TableHead>Waiting</TableHead>
          <TableHead className="text-right">Actions</TableHead>
        </TableRow>
      </TableHeader>
      <TableBody>
        {leads.map((lead) => (
          <TableRow key={lead.lead_id} className="hover:bg-amber-50/50">
            <TableCell>
              <div className="flex items-center gap-2">
                <Badge
                  variant="outline"
                  className="text-amber-700 border-amber-300 bg-amber-50 text-[10px] shrink-0"
                >
                  Lead
                </Badge>
                <span className="font-medium text-sm truncate max-w-[200px]">
                  {lead.title}
                </span>
              </div>
            </TableCell>
            <TableCell className="text-sm">
              {lead.account?.account_name ?? "—"}
            </TableCell>
            <TableCell>
              <div className="flex flex-col gap-0.5">
                <span className="text-xs text-[#5D5D5D]">
                  {lead.account?.industry ?? (
                    <span className="text-[#B12B35] italic">No industry set</span>
                  )}
                </span>
                <span className="text-xs text-muted-foreground">
                  {lead.account?.region ?? (
                    <span className="italic">No region set</span>
                  )}
                </span>
              </div>
            </TableCell>
            <TableCell className="text-sm text-muted-foreground">
              {lead.submitter?.full_name ?? "—"}
            </TableCell>
            <TableCell>
              <div className="flex items-center gap-1 text-amber-600 text-xs">
                <Clock className="h-3 w-3" />
                {timeAgo(lead.created_at)}
              </div>
            </TableCell>
            <TableCell className="text-right">
              <div className="flex items-center justify-end gap-2">
                {showFixMapping && (
                  <Button
                    size="sm"
                    variant="outline"
                    className="h-7 text-xs border-[#B12B35]/30 text-[#B12B35] hover:bg-[#B12B35]/5"
                    title="Assign a reviewer to this lead"
                    onClick={() => onFixMapping(lead)}
                  >
                    <GitMerge className="h-3 w-3 mr-1" />
                    Fix Mapping
                  </Button>
                )}
                <Link href={`/leads/${lead.lead_id}`}>
                  <Button size="sm" variant="ghost" className="h-7 text-xs">
                    <ExternalLink className="h-3 w-3 mr-1" />
                    View
                  </Button>
                </Link>
              </div>
            </TableCell>
          </TableRow>
        ))}
      </TableBody>
    </Table>
  );
}

// ── Shared page view ──────────────────────────────────────────────────────────

export function ExceptionQueueView({
  variant,
}: {
  variant: ExceptionQueueVariant;
}) {
  const { token, user } = useAuth();
  const [leads, setLeads] = useState<LeadWithRelations[]>([]);
  const [loadingLeads, setLoadingLeads] = useState(true);

  // Per-lead "Fix Mapping" reviewer-assignment dialog state.
  const [fixLead, setFixLead] = useState<LeadWithRelations | null>(null);
  const [reviewerId, setReviewerId] = useState<string | null>(null);
  const [reviewerName, setReviewerName] = useState<string>("");
  const [assigning, setAssigning] = useState(false);

  // Admin sees the full remediation surface; executive gets a read-only view.
  const isAdminView = variant === "admin";

  const loadLeads = useCallback(async () => {
    if (!token) return;
    setLoadingLeads(true);
    try {
      const data = await api<LeadWithRelations[]>(
        "/api/leads?status=routing_pending",
        { token }
      );
      setLeads(data);
    } catch {
      // silently handled — table shows empty state
    } finally {
      setLoadingLeads(false);
    }
  }, [token]);

  useEffect(() => {
    loadLeads();
  }, [loadLeads]);

  const refresh = () => {
    loadLeads();
  };

  // ── Per-lead "Fix Mapping" ────────────────────────────────────────────────
  function openFixDialog(lead: LeadWithRelations) {
    setFixLead(lead);
    setReviewerId(null);
    setReviewerName("");
  }

  function closeFixDialog() {
    setFixLead(null);
    setReviewerId(null);
    setReviewerName("");
  }

  async function confirmAssignReviewer() {
    if (!token || !fixLead || !reviewerId) {
      toast.error("Select a reviewer first.");
      return;
    }
    setAssigning(true);
    try {
      // Assigns the reviewer to THIS lead only — the account's permanent
      // routing chain is not modified.
      await api(`/api/leads/${fixLead.lead_id}/assign-reviewer`, {
        method: "POST",
        token,
        body: { reviewer_id: reviewerId },
      });
      toast.success(
        `"${fixLead.title}" assigned to ${reviewerName || "the reviewer"} — now under review.`
      );
      closeFixDialog();
      loadLeads();
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to assign reviewer.");
    } finally {
      setAssigning(false);
    }
  }

  // Admin view: admin only. Executive view: executive (admins can also reach
  // it but are normally routed to the admin variant).
  const allowed = isAdminView
    ? user?.role === "admin"
    : user?.role === "executive" || user?.role === "admin";

  if (user && !allowed) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-muted-foreground">
          {isAdminView
            ? "Admin access required."
            : "Admin or executive access required."}
        </p>
      </div>
    );
  }

  const total = leads.length;

  return (
    <div className="max-w-6xl space-y-6">
      {/* Header */}
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight flex items-center gap-2">
            Exception Queue
            {total > 0 && (
              <Badge className="bg-[#B12B35] text-white text-xs ml-1">
                {total}
              </Badge>
            )}
          </h1>
          <p className="text-muted-foreground mt-1">
            Submissions that could not be routed due to missing stakeholder or
            vertical routing configuration.
          </p>
        </div>
        <Button variant="outline" size="sm" onClick={refresh}>
          <RefreshCw className="h-4 w-4 mr-2" />
          Refresh
        </Button>
      </div>

      {/* Alert banner — admin only (it links to admin-only config pages) */}
      {isAdminView && total > 0 && (
        <div className="flex items-start gap-3 p-4 rounded-lg bg-amber-50 border border-amber-200">
          <AlertTriangle className="h-5 w-5 text-amber-600 mt-0.5 shrink-0" />
          <div className="text-sm">
            <p className="font-semibold text-amber-800">
              {total} submission{total !== 1 ? "s" : ""} awaiting routing
              resolution
            </p>
            <p className="text-amber-700 mt-0.5">
              To resolve: either add stakeholders via{" "}
              <Link
                href="/admin/stakeholder-mapping"
                className="underline font-medium"
              >
                Stakeholder Mapping
              </Link>{" "}
              or configure org-level routing via{" "}
              <Link
                href="/admin/routing-config"
                className="underline font-medium"
              >
                Routing Config
              </Link>
              . Once mapping is added, re-submit or manually update the status.
            </p>
          </div>
        </div>
      )}

      {/* Leads only — Value Ideas exception tab removed */}
      <Card className="mt-4">
        <CardHeader className="pb-3">
          <CardTitle className="text-base flex items-center gap-2">
            <Target className="h-4 w-4" />
            Leads — Routing Pending
            {leads.length > 0 && (
              <Badge className="ml-1 bg-amber-500 text-white text-[10px] h-4 px-1.5">
                {leads.length}
              </Badge>
            )}
          </CardTitle>
          <CardDescription>
            These leads were submitted but no routing chain could be resolved.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <LeadsTable
            leads={leads}
            loading={loadingLeads}
            showFixMapping={isAdminView}
            onFixMapping={openFixDialog}
          />
        </CardContent>
      </Card>

      {/* Help footer — admin only */}
      {isAdminView && (
        <div className="flex items-start gap-3 p-4 rounded-lg bg-[#F9F9F9] border border-[#EDE7E6] text-sm text-[#5D5D5D]">
          <Route className="h-4 w-4 mt-0.5 shrink-0 text-[#2E75B6]" />
          <div>
            <p className="font-medium text-[#232222] mb-1">
              How to resolve routing failures
            </p>
            <ol className="list-decimal list-inside space-y-1 text-xs">
              <li>
                Click <strong>Fix Mapping</strong> on a lead to assign a reviewer
                directly — this fixes <em>that lead only</em> and does not change
                the account&apos;s routing for future leads.
              </li>
              <li>
                To fix routing permanently for an account, go to{" "}
                <Link
                  href="/admin/stakeholder-mapping"
                  className="text-[#2E75B6] underline"
                >
                  Stakeholder Mapping
                </Link>{" "}
                or{" "}
                <Link
                  href="/admin/routing-config"
                  className="text-[#2E75B6] underline"
                >
                  Routing Config
                </Link>{" "}
                — those changes apply to all future submissions.
              </li>
            </ol>
          </div>
        </div>
      )}

      {/* ── Fix Mapping dialog — assign a reviewer to one lead ── */}
      <Dialog open={!!fixLead} onOpenChange={(open) => !open && closeFixDialog()}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle className="text-[#232222]">
              Assign Reviewer
            </DialogTitle>
          </DialogHeader>
          {fixLead && (
            <div className="space-y-3 py-1">
              <p className="text-sm text-[#5D5D5D]">
                Assign a reviewer to{" "}
                <span className="font-medium text-[#232222]">
                  &ldquo;{fixLead.title}&rdquo;
                </span>{" "}
                ({fixLead.account?.account_name ?? "—"}). The lead will move to{" "}
                <strong>Under Review</strong> and the reviewer is notified by
                email and in the portal.
              </p>
              <div className="rounded-md bg-amber-50 border border-amber-200 px-3 py-2 text-xs text-amber-800">
                This assigns the reviewer to <strong>this lead only</strong> —
                the account&apos;s routing for future leads is not changed.
              </div>
              <div className="space-y-1.5">
                <label className="text-sm font-medium text-[#232222]">
                  Reviewer
                </label>
                <UserCombobox
                  value={reviewerId}
                  onChange={(id, u) => {
                    setReviewerId(id);
                    setReviewerName(u?.full_name ?? "");
                  }}
                  token={token ?? ""}
                  placeholder="Search reviewer by name (3+ characters)…"
                />
              </div>
            </div>
          )}
          <DialogFooter className="gap-2">
            <Button
              variant="outline"
              onClick={closeFixDialog}
              disabled={assigning}
            >
              Cancel
            </Button>
            <Button
              className="bg-[#B12B35] hover:bg-[#9a2330] text-white"
              onClick={confirmAssignReviewer}
              disabled={assigning || !reviewerId}
            >
              {assigning ? "Assigning…" : "Assign Reviewer"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
