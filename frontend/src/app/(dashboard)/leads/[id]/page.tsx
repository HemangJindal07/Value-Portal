"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { ArrowLeft, Save } from "lucide-react";
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
  under_review: "bg-amber-500/10 text-amber-400",
  qualified: "bg-green-500/10 text-green-400",
  won: "bg-emerald-500/10 text-emerald-400",
  lost: "bg-red-500/10 text-red-400",
  dropped: "bg-gray-500/10 text-gray-500",
};

const priorityColors: Record<string, string> = {
  high: "bg-red-500/10 text-red-400",
  medium: "bg-amber-500/10 text-amber-400",
  low: "bg-blue-500/10 text-blue-400",
};

const typeLabels: Record<string, string> = {
  cross_sell: "Cross-sell",
  upsell: "Upsell",
  new_service: "New Service",
  expansion: "Expansion",
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
  "under_review",
  "qualified",
  "won",
  "lost",
  "dropped",
];

export default function LeadDetailPage() {
  const { id } = useParams<{ id: string }>();
  const { token, user } = useAuth();
  const router = useRouter();
  const [lead, setLead] = useState<LeadWithRelations | null>(null);
  const [loading, setLoading] = useState(true);
  const [newStatus, setNewStatus] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    if (!token || !id) return;
    api<LeadWithRelations>(`/api/leads/${id}`, { token })
      .then((data) => {
        setLead(data);
        setNewStatus(data.status);
      })
      .catch(() => router.push("/leads"))
      .finally(() => setLoading(false));
  }, [token, id, router]);

  const canChangeStatus =
    user &&
    (user.role === "admin" ||
      user.role === "executive" ||
      user.role === "sales" ||
      lead?.submitted_by === user.id);

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
      toast.success(`Status changed to ${newStatus.replace("_", " ")}`);
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
        Loading...
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
              {lead.status.replace("_", " ")}
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
          <CardContent className="flex items-center gap-4 py-4">
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
                    {s.replace("_", " ")}
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
              {saving ? "Saving..." : "Save"}
            </Button>
          </CardContent>
        </Card>
      )}

      <div className="grid gap-4 lg:grid-cols-3">
        <Card className="lg:col-span-2">
          <CardHeader>
            <CardTitle className="text-base">Description</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-sm whitespace-pre-wrap">{lead.description}</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-base">Details</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <Field label="Account" value={lead.account?.account_name ?? null} />
            <Field label="Submitted by" value={lead.submitter?.full_name ?? null} />
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
                <Field label="AI Category" value={lead.ai_category} />
                <Field
                  label="AI Confidence"
                  value={
                    lead.ai_confidence
                      ? `${(lead.ai_confidence * 100).toFixed(0)}%`
                      : null
                  }
                />
              </>
            )}
          </CardContent>
        </Card>
      </div>

      <ActivitySection submissionType="lead" submissionId={id} />
    </div>
  );
}
