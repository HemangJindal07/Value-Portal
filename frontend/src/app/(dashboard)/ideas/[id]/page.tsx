"use client";

import { useEffect, useRef, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { ArrowLeft, Bot, Loader2, Save } from "lucide-react";
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
import type { IdeaWithRelations } from "@/types";
import Link from "next/link";
import { ActivitySection } from "@/components/activity-section";
import { toast } from "sonner";

const statusColors: Record<string, string> = {
  draft: "bg-gray-500/10 text-gray-400",
  submitted: "bg-blue-500/10 text-blue-400",
  under_review: "bg-amber-500/10 text-amber-400",
  approved: "bg-green-500/10 text-green-400",
  in_progress: "bg-cyan-500/10 text-cyan-400",
  implemented: "bg-emerald-500/10 text-emerald-400",
  rejected: "bg-red-500/10 text-red-400",
};

// Labels for user-submitted idea_category (from the submission form)
const categoryLabels: Record<string, string> = {
  automation: "Automation",
  cost_optimization: "Cost Optimization",
  efficiency: "Efficiency",
  risk_reduction: "Risk Reduction",
  innovation: "Innovation",
  process_improvement: "Process Improvement",
};

// Labels for AI-classified ai_category (doc section 9 — 6 defined categories)
const aiCategoryLabels: Record<string, string> = {
  revenue_opportunity: "Revenue Opportunity",
  automation: "Automation",
  cost_optimization: "Cost Optimization",
  efficiency_improvement: "Efficiency Improvement",
  risk_reduction: "Risk Reduction",
  innovation: "Innovation",
};

const effortColors: Record<string, string> = {
  low: "bg-green-500/10 text-green-400",
  medium: "bg-amber-500/10 text-amber-400",
  high: "bg-red-500/10 text-red-400",
};

const AI_POLL_INTERVAL_MS = 3000;
const AI_POLL_MAX_ATTEMPTS = 10;

function Field({ label, value }: { label: string; value: string | null }) {
  return (
    <div>
      <p className="text-xs text-muted-foreground mb-1">{label}</p>
      <p className="text-sm">{value || "—"}</p>
    </div>
  );
}

function ConfidenceBar({ confidence }: { confidence: number }) {
  const pct = Math.round(confidence * 100);
  const color =
    pct >= 80 ? "bg-emerald-500" : pct >= 50 ? "bg-amber-500" : "bg-red-500";
  return (
    <div>
      <p className="text-xs text-muted-foreground mb-1">AI Confidence</p>
      <div className="flex items-center gap-2">
        <div className="flex-1 h-1.5 rounded-full bg-muted overflow-hidden">
          <div
            className={`h-full rounded-full ${color}`}
            style={{ width: `${pct}%` }}
          />
        </div>
        <span className="text-xs font-medium tabular-nums">{pct}%</span>
      </div>
    </div>
  );
}

const ideaStatuses = [
  "draft",
  "submitted",
  "under_review",
  "approved",
  "in_progress",
  "implemented",
  "rejected",
];

export default function IdeaDetailPage() {
  const { id } = useParams<{ id: string }>();
  const { token, user } = useAuth();
  const router = useRouter();
  const [idea, setIdea] = useState<IdeaWithRelations | null>(null);
  const [loading, setLoading] = useState(true);
  const [aiPolling, setAiPolling] = useState(false);
  const [newStatus, setNewStatus] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);
  const pollAttempts = useRef(0);
  const pollTimer = useRef<ReturnType<typeof setTimeout> | null>(null);

  const fetchIdea = async (): Promise<IdeaWithRelations> => {
    return api<IdeaWithRelations>(`/api/ideas/${id}`, { token: token! });
  };

  // Poll for AI fields after initial load if they are not yet populated
  const startPolling = (currentIdea: IdeaWithRelations) => {
    if (currentIdea.ai_category) return;
    pollAttempts.current = 0;
    setAiPolling(true);

    const poll = async () => {
      if (pollAttempts.current >= AI_POLL_MAX_ATTEMPTS) {
        setAiPolling(false);
        return;
      }
      pollAttempts.current += 1;

      try {
        const fresh = await fetchIdea();
        if (fresh.ai_category) {
          setIdea(fresh);
          setAiPolling(false);
          return;
        }
      } catch {
        // silent — keep polling
      }

      pollTimer.current = setTimeout(poll, AI_POLL_INTERVAL_MS);
    };

    pollTimer.current = setTimeout(poll, AI_POLL_INTERVAL_MS);
  };

  useEffect(() => {
    if (!token || !id) return;
    fetchIdea()
      .then((data) => {
        setIdea(data);
        setNewStatus(data.status);
        startPolling(data);
      })
      .catch(() => router.push("/ideas"))
      .finally(() => setLoading(false));

    return () => {
      if (pollTimer.current) clearTimeout(pollTimer.current);
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [token, id]);

  const canChangeStatus =
    user &&
    (user.role === "admin" ||
      user.role === "executive" ||
      user.role === "practice_lead" ||
      idea?.submitted_by === user?.id);

  const handleStatusChange = async () => {
    if (!token || !idea || !newStatus || newStatus === idea.status) return;
    setSaving(true);
    try {
      const updated = await api<IdeaWithRelations>(`/api/ideas/${id}`, {
        method: "PATCH",
        token,
        body: { status: newStatus },
      });
      setIdea({ ...idea, ...updated });
      toast.success(`Status changed to ${newStatus.replace(/_/g, " ")}`);
    } catch (err: unknown) {
      toast.error(
        err instanceof Error ? err.message : "Failed to update status"
      );
      setNewStatus(idea.status);
    } finally {
      setSaving(false);
    }
  };

  if (loading) {
    return (
      <p className="text-sm text-muted-foreground py-12 text-center">
        Loading...
      </p>
    );
  }

  if (!idea) return null;

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-4">
        <Button variant="ghost" size="icon" render={<Link href="/ideas" />}>
          <ArrowLeft className="h-4 w-4" />
        </Button>
        <div className="flex-1">
          <h1 className="text-2xl font-bold tracking-tight">{idea.title}</h1>
          <div className="flex items-center gap-2 mt-1 flex-wrap">
            <Badge variant="secondary" className={statusColors[idea.status]}>
              {idea.status.replace(/_/g, " ")}
            </Badge>
            <Badge variant="outline">
              {categoryLabels[idea.idea_category] || idea.idea_category}
            </Badge>
            {idea.estimated_effort && (
              <Badge
                variant="secondary"
                className={effortColors[idea.estimated_effort]}
              >
                {idea.estimated_effort} effort
              </Badge>
            )}
            {aiPolling && (
              <Badge
                variant="secondary"
                className="bg-violet-500/10 text-violet-400 flex items-center gap-1"
              >
                <Loader2 className="h-3 w-3 animate-spin" />
                Classifying with AI...
              </Badge>
            )}
          </div>
        </div>
      </div>

      {canChangeStatus && idea && (
        <Card>
          <CardContent className="flex items-center gap-4 py-4">
            <p className="text-sm font-medium text-muted-foreground">
              Change Status:
            </p>
            <Select
              value={newStatus || idea.status}
              onValueChange={setNewStatus}
            >
              <SelectTrigger className="w-48">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                {ideaStatuses.map((s) => (
                  <SelectItem key={s} value={s} className="capitalize">
                    {s.replace(/_/g, " ")}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
            <Button
              size="sm"
              disabled={saving || newStatus === idea.status}
              onClick={handleStatusChange}
            >
              <Save className="mr-2 h-4 w-4" />
              {saving ? "Saving..." : "Save"}
            </Button>
          </CardContent>
        </Card>
      )}

      <div className="grid gap-4 lg:grid-cols-3">
        <div className="lg:col-span-2 space-y-4">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Problem Statement</CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-sm whitespace-pre-wrap">
                {idea.problem_statement}
              </p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-base">Proposed Solution</CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-sm whitespace-pre-wrap">
                {idea.proposed_solution}
              </p>
            </CardContent>
          </Card>

          {/* AI Classification Card */}
          {idea.ai_category ? (
            <Card className="border-violet-500/20 bg-violet-500/5">
              <CardHeader>
                <CardTitle className="text-base flex items-center gap-2">
                  <Bot className="h-4 w-4 text-violet-400" />
                  AI Classification
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="flex items-center gap-2">
                  <p className="text-xs text-muted-foreground">AI Category</p>
                  <Badge
                    variant="secondary"
                    className="bg-violet-500/10 text-violet-400"
                  >
                    {aiCategoryLabels[idea.ai_category] || idea.ai_category}
                  </Badge>
                </div>
                {idea.ai_summary && (
                  <div>
                    <p className="text-xs text-muted-foreground mb-1">
                      AI Summary
                    </p>
                    <p className="text-sm leading-relaxed">{idea.ai_summary}</p>
                  </div>
                )}
                {idea.ai_confidence != null && (
                  <ConfidenceBar confidence={idea.ai_confidence} />
                )}
              </CardContent>
            </Card>
          ) : aiPolling ? (
            <Card className="border-violet-500/20 bg-violet-500/5">
              <CardHeader>
                <CardTitle className="text-base flex items-center gap-2">
                  <Bot className="h-4 w-4 text-violet-400" />
                  AI Classification
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="flex items-center gap-2 text-sm text-muted-foreground">
                  <Loader2 className="h-4 w-4 animate-spin text-violet-400" />
                  Claude is analysing this idea — this usually takes a few
                  seconds...
                </div>
              </CardContent>
            </Card>
          ) : (
            <Card className="border-dashed">
              <CardContent className="py-4">
                <p className="text-sm text-muted-foreground flex items-center gap-2">
                  <Bot className="h-4 w-4" />
                  AI classification pending
                </p>
              </CardContent>
            </Card>
          )}
        </div>

        <Card>
          <CardHeader>
            <CardTitle className="text-base">Details</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <Field label="Account" value={idea.account?.account_name ?? null} />
            <Field
              label="Submitted by"
              value={idea.submitter?.full_name ?? null}
            />
            <Field
              label="Estimated Savings"
              value={
                idea.estimated_saving
                  ? `$${Number(idea.estimated_saving).toLocaleString()}`
                  : null
              }
            />
            <Field label="Timeline" value={idea.estimated_timeline} />
            <Field
              label="Impact Areas"
              value={
                idea.impact_area?.length ? idea.impact_area.join(", ") : null
              }
            />
            <Field
              label="Tools / Tech"
              value={
                idea.tools_involved?.length
                  ? idea.tools_involved.join(", ")
                  : null
              }
            />
            <Field
              label="Created"
              value={new Date(idea.created_at).toLocaleDateString()}
            />
            {idea.ai_category && (
              <>
                <Separator />
                <div className="flex items-center gap-1.5">
                  <Bot className="h-3.5 w-3.5 text-violet-400" />
                  <p className="text-xs text-violet-400 font-medium">
                    AI Classified
                  </p>
                </div>
              </>
            )}
          </CardContent>
        </Card>
      </div>

      <ActivitySection submissionType="idea" submissionId={id} />
    </div>
  );
}
