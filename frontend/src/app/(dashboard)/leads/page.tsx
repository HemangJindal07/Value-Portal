"use client";

import { useEffect, useState, Suspense } from "react";
import Link from "next/link";
import { useSearchParams } from "next/navigation";
import { Plus, Target, Search } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
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
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import type { LeadWithRelations } from "@/types";

const statusColors: Record<string, string> = {
  draft: "bg-[#C5C5C5]/30 text-[#5D5D5D]",
  submitted: "bg-[#2E75B6]/10 text-[#2E75B6]",
  routing_pending: "bg-amber-100 text-amber-700",
  under_review: "bg-[#003466]/10 text-[#003466]",
  qualified: "bg-[#B12B35]/10 text-[#B12B35]",
  approved: "bg-green-100 text-green-700",
  won: "bg-[#003466]/15 text-[#003466]",
  lost: "bg-[#C5C5C5]/30 text-[#5D5D5D]",
  dropped: "bg-[#C5C5C5]/30 text-[#5D5D5D]",
};

const priorityColors: Record<string, string> = {
  high: "bg-[#E42525]/10 text-[#E42525]",
  medium: "bg-[#003466]/10 text-[#003466]",
  low: "bg-[#2E75B6]/10 text-[#2E75B6]",
};

const typeLabels: Record<string, string> = {
  current_lead: "Current Lead",
  new_lead: "New Lead",
};

// Roles that can see ALL leads across the org
const LEADS_ALL_ROLES = ["admin", "executive", "sales"];

function LeadsPageInner() {
  const { token, user } = useAuth();
  const searchParams = useSearchParams();
  const canSeeAll = LEADS_ALL_ROLES.includes(user?.role ?? "");
  const [leads, setLeads] = useState<LeadWithRelations[]>([]);
  const [search, setSearch] = useState("");
  // Initialize status filter from ?status= URL param so dashboard cards
  // (e.g. "Under Review" → /leads?status=under_review) pre-filter the list.
  // Only a single status value pre-applies — comma-separated values are used
  // for highlighting only (see highlightPending below).
  const initialStatus = (() => {
    const raw = (searchParams.get("status") ?? "").trim();
    if (!raw || raw.includes(",")) return "";
    return raw;
  })();
  const [statusFilter, setStatusFilter] = useState<string>(initialStatus);
  const [loading, setLoading] = useState(true);
  // Highlight routing_pending rows when navigated from dashboard alert
  const highlightPending = (searchParams.get("status") ?? "")
    .split(",")
    .map((s) => s.trim())
    .includes("routing_pending");

  useEffect(() => {
    if (!token) return;
    setLoading(true);
    const params = new URLSearchParams();
    if (search) params.set("search", search);
    if (statusFilter) params.set("status", statusFilter);
    const qs = params.toString() ? `?${params.toString()}` : "";

    api<LeadWithRelations[]>(`/api/leads${qs}`, { token })
      .then((data) => {
        // user and practice_lead only see their own submissions
        if (!canSeeAll && user?.id) {
          setLeads(data.filter((l) => l.submitted_by === user.id));
        } else {
          setLeads(data);
        }
      })
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [token, search, statusFilter, canSeeAll, user?.id]);

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Leads</h1>
          <p className="text-muted-foreground">
            Track cross-sell, upsell, and new service opportunities.
          </p>
        </div>
        <Link href="/leads/new">
          <Button>
            <Plus className="mr-2 h-4 w-4" />
            New Lead
          </Button>
        </Link>
      </div>

      <div className="flex gap-3 flex-wrap">
        <div className="relative max-w-sm">
          <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
          <Input
            placeholder="Search leads..."
            className="pl-9"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
          />
        </div>
        <Select
          value={statusFilter}
          onValueChange={(val: string | null) => setStatusFilter(val || "")}
        >
          <SelectTrigger className="w-44">
            <SelectValue placeholder="All Statuses" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="">All Statuses</SelectItem>
            <SelectItem value="submitted">Submitted</SelectItem>
            <SelectItem value="routing_pending">Routing Pending</SelectItem>
            <SelectItem value="under_review">Under Review</SelectItem>
            <SelectItem value="qualified">Qualified</SelectItem>
            <SelectItem value="approved">Approved</SelectItem>
            <SelectItem value="won">Won</SelectItem>
            <SelectItem value="lost">Lost</SelectItem>
            <SelectItem value="rejected">Rejected</SelectItem>
          </SelectContent>
        </Select>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">
            {canSeeAll ? "All Leads" : "My Leads"}
          </CardTitle>
          <CardDescription>
            {leads.length} lead{leads.length !== 1 ? "s" : ""}
          </CardDescription>
        </CardHeader>
        <CardContent>
          {loading ? (
            <p className="text-sm text-muted-foreground py-8 text-center">
              Loading…
            </p>
          ) : leads.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-12 text-center">
              <Target className="h-10 w-10 text-muted-foreground mb-3" />
              <p className="text-sm text-muted-foreground">
                No leads yet. Submit your first lead to get started.
              </p>
            </div>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Title</TableHead>
                  <TableHead>Account</TableHead>
                  <TableHead>Service</TableHead>
                  <TableHead>Type</TableHead>
                  <TableHead>Priority</TableHead>
                  <TableHead>Status</TableHead>
                  <TableHead className="text-right">Est. Value</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {leads.map((lead) => (
                  <TableRow
                    key={lead.lead_id}
                    className={
                      highlightPending && lead.status === "routing_pending"
                        ? "border-2 border-red-500 bg-red-50/40"
                        : ""
                    }
                  >
                    <TableCell>
                      <Link
                        href={`/leads/${lead.lead_id}`}
                        className="font-medium hover:underline"
                      >
                        {lead.title}
                      </Link>
                      <p className="text-xs text-muted-foreground mt-0.5">
                        by{" "}
                        {lead.submitter?.full_name ?? "Unknown"}
                      </p>
                    </TableCell>
                    <TableCell className="text-muted-foreground">
                      {lead.account?.account_name ?? "—"}
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
                      <Badge variant="outline">
                        {typeLabels[lead.lead_type] || lead.lead_type}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <Badge
                        variant="secondary"
                        className={priorityColors[lead.priority]}
                      >
                        {lead.priority.charAt(0).toUpperCase() + lead.priority.slice(1)}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <Badge
                        variant="secondary"
                        className={statusColors[lead.status]}
                      >
                        {lead.status.replace(/_/g, " ").replace(/\b\w/g, c => c.toUpperCase())}
                      </Badge>
                    </TableCell>
                    <TableCell className="text-right">
                      {lead.estimated_value
                        ? `$${Number(lead.estimated_value).toLocaleString()}`
                        : "—"}
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          )}
        </CardContent>
      </Card>
    </div>
  );
}

export default function LeadsPage() {
  return (
    <Suspense>
      <LeadsPageInner />
    </Suspense>
  );
}
