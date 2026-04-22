"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { ArrowLeft, ExternalLink, FileText, Save, CheckCircle2, XCircle, Clock, CircleDot } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Separator } from "@/components/ui/separator";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import type { LeadWithRelations } from "@/types";
import Link from "next/link";
import { ActivitySection } from "@/components/activity-section";
import { toast } from "sonner";

const statusColors: Record<string, string> = {
  draft: "bg-gray-500/10 text-gray-400",
  submitted: "bg-blue-500/10 text-blue-400",
  routing_pending: "bg-orange-500/10 text-orange-700",
  under_review: "bg-amber-500/10 text-amber-400",
  qualified: "bg-green-500/10 text-green-400",
  approved: "bg-emerald-600/10 text-emerald-700",
  won: "bg-emerald-500/10 text-emerald-400",
  lost: "bg-red-500/10 text-red-400",
  dropped: "bg-gray-500/10 text-gray-500",
  rejected: "bg-red-600/15 text-red-700",
};

const priorityColors: Record<string, string> = {
  high: "bg-red-500/10 text-red-400",
  medium: "bg-amber-500/10 text-amber-400",
  low: "bg-blue-500/10 text-blue-400",
};

const typeLabels: Record<string, string> = {
  current_lead: "Current Lead",
  new_lead: "New Lead",
};

function Field({ label, value }: { label: string; value: string | null }) {
  return (
    <div>
      <p className="text-xs text-muted-foreground mb-1">{label}</p>
      <p className="text-sm">{value || "—"}</p>
    </div>
  );
}

const leadStatuses = [
  "draft",
  "submitted",
  "routing_pending",
  "under_review",
  "qualified",
  "approved",
  "won",
  "lost",
  "dropped",
  "rejected",
];

export default function LeadDetailPage() {
  const { id } = useParams<{ id: string }>();
  const { token, user } = useAuth();
  const router = useRouter();
  const [lead, setLead] = useState<LeadWithRelations | null>(null);
  const [loading, setLoading] = useState(true);
  const [newStatus, setNewStatus] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);
  const [routingSteps, setRoutingSteps] = useState<{
    step_order: number;
    role_label: string;
    reviewer_name: string;
    action_taken: string | null;
    action_date: string | null;
  }[]>([]);

  useEffect(() => {
    if (!token || !id) return;
    api<LeadWithRelations>(`/api/leads/${id}`, { token })
      .then((data) => {
        setLead(data);
        setNewStatus(data.status);
      })
      .catch(() => router.push("/leads"))
      .finally(() => setLoading(false));

    api<{ steps: typeof routingSteps }>(`/api/leads/${id}/routing`, { token })
      .then((data) => setRoutingSteps(data.steps))
      .catch(() => {});
  }, [token, id, router]);

  const canChangeStatus = Boolean(lead?.can_update_status);

  const handleStatusChange = async () => {
    if (!token || !lead || !newStatus || newStatus === lead.status) return;
    setSaving(true);
    try {
      const updated = await api<LeadWithRelations>(`/api/leads/${id}`, {
        method: "PATCH",
        token,
        body: { status: newStatus },
      });
      setLead({ ...lead, ...updated });
      toast.success(`Status changed to ${newStatus.replace(/_/g, " ")}`);
    } catch (err: unknown) {
      toast.error(
        err instanceof Error ? err.message : "Failed to update status"
      );
      setNewStatus(lead.status);
    } finally {
      setSaving(false);
    }
  };

  if (loading) {
    return (
      <p className="text-sm text-muted-foreground py-12 text-center">
        Loading…
      </p>
    );
  }

  if (!lead) return null;

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-4">
        <Link href="/leads">
          <Button variant="ghost" size="icon">
            <ArrowLeft className="h-4 w-4" />
          </Button>
        </Link>
        <div className="flex-1">
          <h1 className="text-2xl font-bold tracking-tight">{lead.title}</h1>
          <div className="flex items-center gap-2 mt-1 flex-wrap">
            <Badge
              variant="secondary"
              className={statusColors[lead.status]}
            >
              {lead.status.replace(/_/g, " ")}
            </Badge>
            <Badge
              variant="secondary"
              className={priorityColors[lead.priority]}
            >
              {lead.priority}
            </Badge>
            <Badge variant="outline">
              {typeLabels[lead.lead_type] || lead.lead_type}
            </Badge>
          </div>
        </div>
      </div>

      {canChangeStatus && (
        <Card>
          <CardContent className="flex flex-wrap items-center gap-4 py-4">
            <p className="text-sm font-medium text-muted-foreground">
              Change Status:
            </p>
            <Select
              value={newStatus || lead.status}
              onValueChange={setNewStatus}
            >
              <SelectTrigger className="w-48">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                {leadStatuses.map((s) => (
                  <SelectItem key={s} value={s} className="capitalize">
                    {s.replace(/_/g, " ")}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
            <Button
              size="sm"
              disabled={saving || newStatus === lead.status}
              onClick={handleStatusChange}
            >
              <Save className="mr-2 h-4 w-4" />
              {saving ? "Saving…" : "Apply"}
            </Button>
            <p className="text-xs text-muted-foreground w-full">
              Reviewers should use <strong>My Assignments</strong> → Approve or Reject
              to move the chain forward; use this only when you need a manual status
              correction (admin / assigned reviewer / sales after approval).
            </p>
          </CardContent>
        </Card>
      )}

      {!canChangeStatus && user?.id === lead.submitted_by && (
        <Card>
          <CardContent className="py-4">
            <p className="text-sm text-muted-foreground">
              <span className="font-medium text-foreground">Your submission status</span>{" "}
              is shown above and updates as each reviewer acts on{" "}
              <strong>My Assignments</strong>. You cannot change it here.
            </p>
          </CardContent>
        </Card>
      )}

      <div className="grid gap-4 lg:grid-cols-3">
        <Card className="lg:col-span-2">
          <CardHeader>
            <CardTitle className="text-base">Description</CardTitle>
          </CardHeader>
          <CardContent className="space-y-6">
            <p className="text-sm whitespace-pre-wrap">{lead.description}</p>

            {lead.supporting_docs &&
              lead.supporting_docs.length > 0 && (
                <div className="rounded-lg border border-[#C5C5C5] bg-[#F9F9F9] p-4">
                  <p className="text-xs font-medium text-muted-foreground mb-2 flex items-center gap-1.5">
                    <FileText className="h-3.5 w-3.5" />
                    Supporting documents
                  </p>
                  <ul className="space-y-2">
                    {lead.supporting_docs.map((url) => (
                      <li key={url}>
                        <a
                          href={url}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="text-sm text-[#2E75B6] hover:underline inline-flex items-center gap-1.5 break-all"
                        >
                          <ExternalLink className="h-3.5 w-3.5 shrink-0" />
                          {url.split("/").pop() || url}
                        </a>
                      </li>
                    ))}
                  </ul>
                </div>
              )}
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-base">Details</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <Field label="Account" value={lead.account?.account_name ?? null} />
            <Field label="Submitted By" value={lead.submitter?.full_name ?? null} />
            <Field
              label="Estimated Value"
              value={
                lead.estimated_value
                  ? `${lead.currency} ${Number(lead.estimated_value).toLocaleString()}`
                  : null
              }
            />
            <Field
              label="Probability"
              value={lead.probability ? `${lead.probability}%` : null}
            />
            <Field label="Expected Close" value={lead.expected_close_date} />
            <Field
              label="Created"
              value={new Date(lead.created_at).toLocaleDateString()}
            />
            {lead.ai_category && (
              <>
                <Separator />
                <p className="text-xs font-semibold text-muted-foreground uppercase tracking-wide">AI Insights</p>
                <Field label="Category" value={lead.ai_category.replace(/_/g, " ")} />
                <Field
                  label="Confidence"
                  value={
                    lead.ai_confidence
                      ? `${(lead.ai_confidence * 100).toFixed(0)}%`
                      : null
                  }
                />
                {lead.ai_suggested_priority && (
                  <Field label="Suggested Priority" value={lead.ai_suggested_priority} />
                )}
                {lead.ai_win_probability != null && lead.ai_win_probability > 0 && (
                  <Field label="Win Probability" value={`${(lead.ai_win_probability * 100).toFixed(0)}%`} />
                )}
                {lead.ai_summary && (
                  <div>
                    <p className="text-xs text-muted-foreground mb-1">AI Recommendation</p>
                    <p className="text-sm text-foreground">{lead.ai_summary}</p>
                  </div>
                )}
              </>
            )}
          </CardContent>
        </Card>
      </div>

      {routingSteps.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="text-base">Routing Progress</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="relative">
              {routingSteps.map((step, i) => {
                const isApproved = step.action_taken === "approved";
                const isRejected = step.action_taken === "rejected";
                const isPending = step.action_taken === "pending";
                const isWaiting = !step.action_taken;
                const isLast = i === routingSteps.length - 1;

                return (
                  <div key={step.step_order} className="flex gap-3 relative">
                    {!isLast && (
                      <div className={`absolute left-[13px] top-7 w-0.5 h-[calc(100%-8px)] ${
                        isApproved ? "bg-green-400" : "bg-gray-200"
                      }`} />
                    )}
                    <div className="shrink-0 mt-0.5 z-10">
                      {isApproved && <CheckCircle2 className="h-[26px] w-[26px] text-green-500" />}
                      {isRejected && <XCircle className="h-[26px] w-[26px] text-red-500" />}
                      {isPending && <Clock className="h-[26px] w-[26px] text-amber-500 animate-pulse" />}
                      {isWaiting && <CircleDot className="h-[26px] w-[26px] text-gray-300" />}
                    </div>
                    <div className={`pb-6 ${isLast ? "pb-0" : ""}`}>
                      <p className="text-sm font-medium">
                        Step {step.step_order}: {step.role_label}
                      </p>
                      <p className="text-xs text-muted-foreground">
                        {step.reviewer_name}
                        {isApproved && (
                          <span className="text-green-600 ml-2">
                            Approved {step.action_date ? `on ${new Date(step.action_date).toLocaleDateString()}` : ""}
                          </span>
                        )}
                        {isRejected && (
                          <span className="text-red-600 ml-2">
                            Rejected {step.action_date ? `on ${new Date(step.action_date).toLocaleDateString()}` : ""}
                          </span>
                        )}
                        {isPending && <span className="text-amber-600 ml-2">Awaiting review</span>}
                        {isWaiting && <span className="text-gray-400 ml-2">Waiting</span>}
                      </p>
                    </div>
                  </div>
                );
              })}
            </div>
          </CardContent>
        </Card>
      )}

      <ActivitySection submissionType="lead" submissionId={id} />
    </div>
  );
}
