"use client";

import { useEffect, useState, useCallback } from "react";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Textarea } from "@/components/ui/textarea";
import { Plus, Calendar, CheckCircle, Clock, Play } from "lucide-react";
import { toast } from "sonner";

type ReviewCycle = {
  cycle_id: string;
  cycle_type: string;
  period_label: string;
  start_date: string;
  end_date: string;
  status: string;
  submissions_reviewed: number;
  notes: string | null;
  facilitator?: { id: string; full_name: string };
};

const statusConfig: Record<string, { icon: React.ElementType; color: string }> = {
  planned: { icon: Calendar, color: "text-blue-500" },
  in_progress: { icon: Play, color: "text-yellow-500" },
  completed: { icon: CheckCircle, color: "text-green-500" },
};

export default function ReviewsPage() {
  const { token, user } = useAuth();
  const [cycles, setCycles] = useState<ReviewCycle[]>([]);
  const [loading, setLoading] = useState(true);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [form, setForm] = useState({
    cycle_type: "monthly",
    period_label: "",
    start_date: "",
    end_date: "",
    notes: "",
  });

  const isPrivileged = user?.role === "admin" || user?.role === "executive";

  const fetchCycles = useCallback(async () => {
    if (!token) return;
    try {
      const data = await api<ReviewCycle[]>("/api/governance/review-cycles", {
        token,
      });
      setCycles(data);
    } catch {
      toast.error("Failed to load review cycles");
    } finally {
      setLoading(false);
    }
  }, [token]);

  useEffect(() => {
    fetchCycles();
  }, [fetchCycles]);

  const createCycle = async () => {
    if (!token || !form.period_label || !form.start_date || !form.end_date) {
      toast.error("Please fill all required fields");
      return;
    }
    try {
      await api("/api/governance/review-cycles", {
        method: "POST",
        token,
        body: form,
      });
      toast.success("Review cycle created");
      setDialogOpen(false);
      setForm({
        cycle_type: "monthly",
        period_label: "",
        start_date: "",
        end_date: "",
        notes: "",
      });
      fetchCycles();
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to create cycle");
    }
  };

  const updateStatus = async (cycleId: string, newStatus: string) => {
    if (!token) return;
    try {
      await api(`/api/governance/review-cycles/${cycleId}`, {
        method: "PATCH",
        token,
        body: { status: newStatus },
      });
      toast.success(`Cycle moved to ${newStatus.replace("_", " ")}`);
      fetchCycles();
    } catch {
      toast.error("Failed to update cycle");
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Reviews</h1>
          <p className="text-muted-foreground">
            Governance review cycles and impact measurement.
          </p>
        </div>
        {isPrivileged && (
          <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
            <DialogTrigger asChild>
              <Button>
                <Plus className="mr-2 h-4 w-4" />
                New Review Cycle
              </Button>
            </DialogTrigger>
            <DialogContent>
              <DialogHeader>
                <DialogTitle>Create Review Cycle</DialogTitle>
              </DialogHeader>
              <div className="space-y-4 pt-2">
                <div className="space-y-2">
                  <Label>Type</Label>
                  <Select
                    value={form.cycle_type}
                    onValueChange={(v) =>
                      setForm((f) => ({ ...f, cycle_type: v }))
                    }
                  >
                    <SelectTrigger>
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="monthly">Monthly</SelectItem>
                      <SelectItem value="quarterly">Quarterly</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-2">
                  <Label>Period Label</Label>
                  <Input
                    placeholder="e.g., March 2026"
                    value={form.period_label}
                    onChange={(e) =>
                      setForm((f) => ({ ...f, period_label: e.target.value }))
                    }
                  />
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label>Start Date</Label>
                    <Input
                      type="date"
                      value={form.start_date}
                      onChange={(e) =>
                        setForm((f) => ({ ...f, start_date: e.target.value }))
                      }
                    />
                  </div>
                  <div className="space-y-2">
                    <Label>End Date</Label>
                    <Input
                      type="date"
                      value={form.end_date}
                      onChange={(e) =>
                        setForm((f) => ({ ...f, end_date: e.target.value }))
                      }
                    />
                  </div>
                </div>
                <div className="space-y-2">
                  <Label>Notes (optional)</Label>
                  <Textarea
                    value={form.notes}
                    onChange={(e) =>
                      setForm((f) => ({ ...f, notes: e.target.value }))
                    }
                  />
                </div>
                <Button className="w-full" onClick={createCycle}>
                  Create Cycle
                </Button>
              </div>
            </DialogContent>
          </Dialog>
        )}
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Review Cycles</CardTitle>
          <CardDescription>
            Periodic governance reviews of submissions and their impact.
          </CardDescription>
        </CardHeader>
        <CardContent>
          {loading ? (
            <p className="text-sm text-muted-foreground py-8 text-center">
              Loading...
            </p>
          ) : cycles.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-12 text-muted-foreground">
              <Clock className="h-12 w-12 mb-4 opacity-40" />
              <p className="text-sm">No review cycles created yet.</p>
            </div>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Period</TableHead>
                  <TableHead>Type</TableHead>
                  <TableHead>Dates</TableHead>
                  <TableHead>Facilitator</TableHead>
                  <TableHead>Reviewed</TableHead>
                  <TableHead>Status</TableHead>
                  {isPrivileged && <TableHead>Actions</TableHead>}
                </TableRow>
              </TableHeader>
              <TableBody>
                {cycles.map((c) => {
                  const cfg = statusConfig[c.status] || statusConfig.planned;
                  const Icon = cfg.icon;
                  return (
                    <TableRow key={c.cycle_id}>
                      <TableCell className="font-medium">
                        {c.period_label}
                      </TableCell>
                      <TableCell>
                        <Badge variant="outline" className="capitalize">
                          {c.cycle_type}
                        </Badge>
                      </TableCell>
                      <TableCell className="text-sm text-muted-foreground">
                        {c.start_date} — {c.end_date}
                      </TableCell>
                      <TableCell>
                        {c.facilitator?.full_name || "—"}
                      </TableCell>
                      <TableCell>{c.submissions_reviewed}</TableCell>
                      <TableCell>
                        <Badge
                          variant="secondary"
                          className="capitalize gap-1"
                        >
                          <Icon className={`h-3 w-3 ${cfg.color}`} />
                          {c.status.replace("_", " ")}
                        </Badge>
                      </TableCell>
                      {isPrivileged && (
                        <TableCell>
                          {c.status === "planned" && (
                            <Button
                              variant="outline"
                              size="sm"
                              onClick={() =>
                                updateStatus(c.cycle_id, "in_progress")
                              }
                            >
                              Start
                            </Button>
                          )}
                          {c.status === "in_progress" && (
                            <Button
                              variant="outline"
                              size="sm"
                              onClick={() =>
                                updateStatus(c.cycle_id, "completed")
                              }
                            >
                              Complete
                            </Button>
                          )}
                        </TableCell>
                      )}
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
