"use client";

import { useEffect } from "react";
import { useQuery } from "@tanstack/react-query";
import { useParams, useRouter } from "next/navigation";
import { ArrowLeft, ExternalLink, FileText, CheckCircle2, XCircle, Clock, CircleDot, AlertOctagon } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import type { LeadWithRelations } from "@/types";
import { ActivitySection } from "@/components/activity-section";

const statusColors: Record<string, string> = {
  draft: "bg-gray-500/10 text-gray-400",
  submitted: "bg-blue-500/10 text-blue-400",
  routing_pending: "bg-orange-500/10 text-orange-700",
  under_review: "bg-amber-500/10 text-amber-400",
  qualified: "bg-green-500/10 text-green-400",
  opportunity_created: "bg-purple-500/10 text-purple-700",
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

type RoutingStep = {
  step_order: number;
  role_label: string;
  reviewer_name: string;
  action_taken: string | null;
  action_date: string | null;
};

export default function LeadDetailPage() {
  const { id } = useParams<{ id: string }>();
  const { token } = useAuth();
  const router = useRouter();

  // Cached lead detail. A missing/forbidden lead redirects to the list.
  const { data: lead, isLoading: loading, isError } = useQuery({
    queryKey: ["lead", id],
    queryFn: () => api<LeadWithRelations>(`/api/leads/${id}`, { token: token! }),
    enabled: !!token && !!id,
  });

  useEffect(() => {
    if (isError) router.push("/leads");
  }, [isError, router]);

  // Cached routing steps for this lead.
  const { data: routingData } = useQuery({
    queryKey: ["lead-routing", id],
    queryFn: () =>
      api<{ steps: RoutingStep[] }>(`/api/leads/${id}/routing`, { token: token! }),
    enabled: !!token && !!id,
  });
  const routingSteps = routingData?.steps ?? [];


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
        <Button
          variant="ghost"
          size="icon"
          onClick={() => {
            // Return to wherever the user came from (My Submissions, Leads,
            // Assignments, etc.). Fall back to /leads on a deep-link/refresh
            // where there's no in-app history to go back to.
            if (typeof window !== "undefined" && window.history.length > 1) {
              router.back();
            } else {
              router.push("/leads");
            }
          }}
        >
          <ArrowLeft className="h-4 w-4" />
        </Button>
        <div className="flex-1">
          <h1 className="text-2xl font-bold tracking-tight">{lead.title}</h1>
          <div className="flex items-center gap-2 mt-1 flex-wrap">
            <Badge
              variant="secondary"
              className={statusColors[lead.status]}
            >
              {lead.status.replace(/_/g, " ").replace(/\b\w/g, c => c.toUpperCase())}
            </Badge>
            <Badge
              variant="secondary"
              className={priorityColors[lead.priority]}
            >
              {lead.priority.replace(/\b\w/g, c => c.toUpperCase())}
            </Badge>
            <Badge variant="outline">
              {typeLabels[lead.lead_type] || lead.lead_type}
            </Badge>
          </div>
        </div>
      </div>

      <Card>
        <CardContent className="py-4">
          <p className="text-sm text-muted-foreground">
            <span className="font-medium text-foreground">Lead Status:</span>{" "}
            This lead is currently{" "}
            <span className="font-semibold">
              {lead.status.replace(/_/g, " ").replace(/\b\w/g, c => c.toUpperCase())}
            </span>.{" "}
            Status updates progress automatically as reviewers act via{" "}
            <strong>My Assignments</strong>. Contact your administrator for manual corrections.
          </p>
        </CardContent>
      </Card>

      {lead.status === "rejected" && lead.rejection_remarks && (
        <Card className="border-red-200 bg-red-50/40">
          <CardHeader className="pb-2">
            <CardTitle className="text-base flex items-center gap-2 text-red-700">
              <AlertOctagon className="h-4 w-4" />
              Reviewer Remarks (Rejection)
            </CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-sm whitespace-pre-wrap text-red-900">
              {lead.rejection_remarks}
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
                    {lead.supporting_docs.map((doc, i) => {
                      let parsed: { url: string; name: string } | null = null;
                      if (typeof doc === "string") {
                        try { parsed = JSON.parse(doc); } catch { /* plain URL */ }
                      }
                      const docObj = parsed ?? (typeof doc === "object" ? doc as { url: string; name: string } : null);
                      const url  = docObj ? docObj.url  : (doc as string);
                      // Legacy plain-URL docs have no stored name — derive a clean
                      // label from the storage path (the last segment is a UUID,
                      // so fall back to a generic "Document.<ext>").
                      let name = docObj?.name ?? "";
                      if (!name) {
                        const segment = decodeURIComponent((doc as string).split("?")[0].split("/").pop() || "");
                        const ext = segment.includes(".") ? segment.slice(segment.lastIndexOf(".")) : "";
                        // If the segment is just a UUID (optionally with extension), show a generic name
                        name = /^[0-9a-f-]{36}(\.\w+)?$/i.test(segment)
                          ? `Document${ext}`
                          : (segment || "Document");
                      }
                      // Force a download (with the real filename) instead of
                      // opening a blank inline preview of the storage object.
                      const downloadUrl = url.includes("download=")
                        ? url
                        : `${url}${url.includes("?") ? "&" : "?"}download=${encodeURIComponent(name)}`;
                      return (
                        <li key={i}>
                          <a
                            href={downloadUrl}
                            download={name}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="text-sm text-[#2E75B6] hover:underline inline-flex items-center gap-1.5 break-all"
                          >
                            <ExternalLink className="h-3.5 w-3.5 shrink-0" />
                            {name}
                          </a>
                        </li>
                      );
                    })}
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
            <Field label="Service" value={lead.service ?? null} />
            <Field label="Submitted By" value={lead.submitter?.full_name ?? null} />
            {lead.contact_details && (lead.contact_details.name || lead.contact_details.email || lead.contact_details.country || lead.contact_details.title) && (
              <>
                <Separator />
                <p className="text-xs font-semibold text-muted-foreground uppercase tracking-wide">Key Contact</p>
                {lead.contact_details.name && <Field label="Contact Name" value={lead.contact_details.name} />}
                {lead.contact_details.email && <Field label="Contact Email" value={lead.contact_details.email} />}
                {lead.contact_details.title && <Field label="Contact Title" value={lead.contact_details.title} />}
                {lead.contact_details.country && <Field label="Country" value={lead.contact_details.country} />}
              </>
            )}
            <Field
              label="Estimated Value"
              value={
                lead.estimated_value
                  ? `${lead.currency} ${Number(lead.estimated_value).toLocaleString()}`
                  : null
              }
            />
            <Field
              label="Expected Close Date"
              value={
                lead.expected_close_date
                  ? new Date(lead.expected_close_date).toLocaleDateString()
                  : null
              }
            />
            <Field
              label="Created"
              value={new Date(lead.created_at).toLocaleDateString()}
            />
            {lead.ai_category && (
              <>
                <Separator />
                <p className="text-xs font-semibold text-muted-foreground uppercase tracking-wide">AI Insights</p>
                <Field
                  label="Category"
                  value={lead.ai_category
                    .replace(/_/g, " ")
                    .replace(/\b\w/g, (c) => c.toUpperCase())}
                />
                <Field
                  label="Confidence"
                  value={
                    lead.ai_confidence
                      ? `${(lead.ai_confidence * 100).toFixed(0)}%`
                      : null
                  }
                />
                {lead.ai_suggested_priority && (
                  <Field
                    label="Suggested Priority"
                    value={lead.ai_suggested_priority.replace(/\b\w/g, (c) => c.toUpperCase())}
                  />
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
              {/* When a lead is closed without reaching a step (e.g. rejected at
                  Step 1), the remaining steps will never run — show them as
                  "Not required" rather than a misleading "Waiting". */}
              {(() => {
                const leadClosed = ["rejected", "lost", "dropped"].includes(
                  lead.status
                );
                return routingSteps.map((step, i) => {
                const isApproved = step.action_taken === "approved";
                const isRejected = step.action_taken === "rejected";
                const isPending = step.action_taken === "pending";
                const isWaiting = !step.action_taken;
                const isSkipped = isWaiting && leadClosed;
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
                      {isWaiting && (
                        <CircleDot className="h-[26px] w-[26px] text-gray-300" />
                      )}
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
                        {isWaiting && !isSkipped && (
                          <span className="text-gray-400 ml-2">Waiting</span>
                        )}
                        {isSkipped && (
                          <span className="text-gray-400 ml-2">Not required</span>
                        )}
                      </p>
                    </div>
                  </div>
                );
              });
              })()}
            </div>
          </CardContent>
        </Card>
      )}

      <ActivitySection submissionType="lead" submissionId={id} />
    </div>
  );
}
