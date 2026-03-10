"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { Plus, Lightbulb, Search } from "lucide-react";
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
import type { IdeaWithRelations } from "@/types";

const statusColors: Record<string, string> = {
  draft: "bg-gray-500/10 text-gray-400",
  submitted: "bg-blue-500/10 text-blue-400",
  under_review: "bg-amber-500/10 text-amber-400",
  approved: "bg-green-500/10 text-green-400",
  in_progress: "bg-cyan-500/10 text-cyan-400",
  implemented: "bg-emerald-500/10 text-emerald-400",
  rejected: "bg-red-500/10 text-red-400",
};

const categoryLabels: Record<string, string> = {
  automation: "Automation",
  cost_optimization: "Cost Optimization",
  efficiency: "Efficiency",
  risk_reduction: "Risk Reduction",
  innovation: "Innovation",
  process_improvement: "Process Improvement",
};

const effortColors: Record<string, string> = {
  low: "bg-green-500/10 text-green-400",
  medium: "bg-amber-500/10 text-amber-400",
  high: "bg-red-500/10 text-red-400",
};

export default function IdeasPage() {
  const { token } = useAuth();
  const [ideas, setIdeas] = useState<IdeaWithRelations[]>([]);
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

    api<IdeaWithRelations[]>(`/api/ideas${qs}`, { token })
      .then(setIdeas)
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [token, search, statusFilter]);

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Value Ideas</h1>
          <p className="text-muted-foreground">
            Innovation, automation, and process improvement ideas.
          </p>
        </div>
        <Link href="/ideas/new">
          <Button>
            <Plus className="mr-2 h-4 w-4" />
            New Idea
          </Button>
        </Link>
      </div>

      <div className="flex gap-3 flex-wrap">
        <div className="relative max-w-sm">
          <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
          <Input
            placeholder="Search ideas..."
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
            <SelectItem value="approved">Approved</SelectItem>
            <SelectItem value="in_progress">In Progress</SelectItem>
            <SelectItem value="implemented">Implemented</SelectItem>
          </SelectContent>
        </Select>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">All Ideas</CardTitle>
          <CardDescription>
            {ideas.length} idea{ideas.length !== 1 ? "s" : ""}
          </CardDescription>
        </CardHeader>
        <CardContent>
          {loading ? (
            <p className="text-sm text-muted-foreground py-8 text-center">
              Loading...
            </p>
          ) : ideas.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-12 text-center">
              <Lightbulb className="h-10 w-10 text-muted-foreground mb-3" />
              <p className="text-sm text-muted-foreground">
                No ideas yet. Submit your first value idea.
              </p>
            </div>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Title</TableHead>
                  <TableHead>Account</TableHead>
                  <TableHead>Category</TableHead>
                  <TableHead>Effort</TableHead>
                  <TableHead>Status</TableHead>
                  <TableHead className="text-right">Est. Savings</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {ideas.map((idea) => (
                  <TableRow key={idea.idea_id}>
                    <TableCell>
                      <Link
                        href={`/ideas/${idea.idea_id}`}
                        className="font-medium hover:underline"
                      >
                        {idea.title}
                      </Link>
                      <p className="text-xs text-muted-foreground mt-0.5">
                        by{" "}
                        {idea.submitter?.full_name ?? "Unknown"}
                      </p>
                    </TableCell>
                    <TableCell className="text-muted-foreground">
                      {idea.account?.account_name ?? "—"}
                    </TableCell>
                    <TableCell>
                      <Badge variant="outline">
                        {categoryLabels[idea.idea_category] || idea.idea_category}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <Badge
                        variant="secondary"
                        className={effortColors[idea.estimated_effort]}
                      >
                        {idea.estimated_effort}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <Badge
                        variant="secondary"
                        className={statusColors[idea.status]}
                      >
                        {idea.status.replace("_", " ")}
                      </Badge>
                    </TableCell>
                    <TableCell className="text-right">
                      {idea.estimated_saving
                        ? `$${Number(idea.estimated_saving).toLocaleString()}`
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
