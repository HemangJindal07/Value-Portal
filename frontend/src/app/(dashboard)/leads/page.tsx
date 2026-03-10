"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
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

export default function LeadsPage() {
  const { token } = useAuth();
  const [leads, setLeads] = useState<LeadWithRelations[]>([]);
  const [search, setSearch] = useState("");
  const [statusFilter, setStatusFilter] = useState<string>("");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!token) return;
    setLoading(true);
    const params = new URLSearchParams();
    if (search) params.set("search", search);
    if (statusFilter) params.set("status", statusFilter);
    const qs = params.toString() ? `?${params.toString()}` : "";

    api<LeadWithRelations[]>(`/api/leads${qs}`, { token })
      .then(setLeads)
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [token, search, statusFilter]);

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
            <SelectItem value="under_review">Under Review</SelectItem>
            <SelectItem value="qualified">Qualified</SelectItem>
            <SelectItem value="won">Won</SelectItem>
            <SelectItem value="lost">Lost</SelectItem>
          </SelectContent>
        </Select>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">All Leads</CardTitle>
          <CardDescription>
            {leads.length} lead{leads.length !== 1 ? "s" : ""}
          </CardDescription>
        </CardHeader>
        <CardContent>
          {loading ? (
            <p className="text-sm text-muted-foreground py-8 text-center">
              Loading...
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
                  <TableHead>Type</TableHead>
                  <TableHead>Priority</TableHead>
                  <TableHead>Status</TableHead>
                  <TableHead className="text-right">Est. Value</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {leads.map((lead) => (
                  <TableRow key={lead.lead_id}>
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
                      <Badge variant="outline">
                        {typeLabels[lead.lead_type] || lead.lead_type}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <Badge
                        variant="secondary"
                        className={priorityColors[lead.priority]}
                      >
                        {lead.priority}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <Badge
                        variant="secondary"
                        className={statusColors[lead.status]}
                      >
                        {lead.status.replace("_", " ")}
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
