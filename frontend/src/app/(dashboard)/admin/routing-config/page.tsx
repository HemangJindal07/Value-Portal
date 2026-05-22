"use client";

import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Plus, Trash2, Pencil, Check, X, Info, MapPin, Layers } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Skeleton } from "@/components/ui/skeleton";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import { toast } from "sonner";
import { UserCombobox } from "@/components/user-combobox";

// ── Types ─────────────────────────────────────────────────────────────────────

interface UserRef {
  id: string;
  full_name: string;
  email: string;
  role: string;
}

interface VerticalEntry {
  id: string;
  vertical_name: string;
  du_user_id: string | null;
  dh_user_id: string | null;
  du: UserRef | null;
  dh: UserRef | null;
}

interface RegionSalesEntry {
  id: string;
  region_name: string;
  sales_user_id: string;
  copy_all: boolean;
  sales: UserRef | null;
}

// ── Shared delete-confirm dialog ──────────────────────────────────────────────

interface DeleteConfirmDialogProps {
  open: boolean;
  label: string;
  onConfirm: () => void;
  onCancel: () => void;
}

function DeleteConfirmDialog({ open, label, onConfirm, onCancel }: DeleteConfirmDialogProps) {
  return (
    <Dialog open={open} onOpenChange={(v) => !v && onCancel()}>
      <DialogContent className="sm:max-w-sm">
        <DialogHeader>
          <DialogTitle className="text-[#232222]">Remove Mapping</DialogTitle>
        </DialogHeader>
        <p className="text-sm text-[#5D5D5D]">
          Are you sure you want to remove the mapping for{" "}
          <span className="font-medium text-[#232222]">&ldquo;{label}&rdquo;</span>?
          This cannot be undone.
        </p>
        <DialogFooter className="gap-2 mt-2">
          <Button variant="outline" className="border-[#C5C5C5]" onClick={onCancel}>
            Cancel
          </Button>
          <Button className="bg-red-600 hover:bg-red-700 text-white" onClick={onConfirm}>
            Remove
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

// ── Vertical Routing Tab ──────────────────────────────────────────────────────

function VerticalRoutingTab({ token }: { token: string }) {
  // Cached vertical-routing config — `load` re-runs the query after a mutation.
  const { data: entries = [], isLoading: loading, refetch } = useQuery({
    queryKey: ["vertical-routing"],
    queryFn: () => api<VerticalEntry[]>("/api/vertical-routing", { token }),
    enabled: !!token,
  });
  const load = () => { refetch(); };
  const [editingId, setEditingId] = useState<string | null>(null);
  const [showAdd, setShowAdd] = useState(false);
  const [pendingDelete, setPendingDelete] = useState<{ id: string; name: string } | null>(null);

  // Add form state
  const [addVertical, setAddVertical] = useState("");
  const [addDuId, setAddDuId] = useState("");
  const [addDhId, setAddDhId] = useState("");
  const [addSaving, setAddSaving] = useState(false);

  // Edit state
  const [editDuId, setEditDuId] = useState("");
  const [editDhId, setEditDhId] = useState("");
  const [editSaving, setEditSaving] = useState(false);

  const handleAdd = async () => {
    if (!addVertical.trim()) {
      toast.error("Vertical name is required.");
      return;
    }
    setAddSaving(true);
    try {
      await api("/api/vertical-routing", {
        method: "POST",
        body: {
          vertical_name: addVertical.trim(),
          du_user_id: addDuId || null,
          dh_user_id: addDhId || null,
        },
        token,
      });
      toast.success("Vertical routing entry added.");
      setShowAdd(false);
      setAddVertical("");
      setAddDuId("");
      setAddDhId("");
      load();
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to add entry.");
    } finally {
      setAddSaving(false);
    }
  };

  const startEdit = (entry: VerticalEntry) => {
    setEditingId(entry.id);
    setEditDuId(entry.du_user_id || "");
    setEditDhId(entry.dh_user_id || "");
  };

  const handleSaveEdit = async (id: string) => {
    setEditSaving(true);
    try {
      await api(`/api/vertical-routing/${id}`, {
        method: "PATCH",
        body: { du_user_id: editDuId || null, dh_user_id: editDhId || null },
        token,
      });
      toast.success("Entry updated.");
      setEditingId(null);
      load();
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to update.");
    } finally {
      setEditSaving(false);
    }
  };

  const confirmDelete = async () => {
    if (!pendingDelete) return;
    const { id } = pendingDelete;
    setPendingDelete(null);
    try {
      await api(`/api/vertical-routing/${id}`, { method: "DELETE", token });
      toast.success("Entry removed.");
      load();
    } catch {
      toast.error("Failed to remove entry.");
    }
  };

  if (loading) {
    return (
      <div className="space-y-3">
        {[1, 2, 3].map((i) => <Skeleton key={i} className="h-16 w-full" />)}
      </div>
    );
  }

  return (
    <div className="space-y-4">
      <DeleteConfirmDialog
        open={!!pendingDelete}
        label={pendingDelete?.name ?? ""}
        onConfirm={confirmDelete}
        onCancel={() => setPendingDelete(null)}
      />

      <div className="flex items-start gap-2 p-3 rounded-lg bg-[#2E75B6]/8 border border-[#2E75B6]/20 text-sm text-[#003466]">
        <Info className="h-4 w-4 mt-0.5 shrink-0 text-[#2E75B6]" />
        <span>
          The <strong>Vertical Name</strong> must exactly match the{" "}
          <strong>Industry</strong> value set on the Account. Used as fallback
          routing when no per-account stakeholders are configured.
        </span>
      </div>

      {entries.length === 0 && !showAdd && (
        <p className="text-sm text-muted-foreground text-center py-8">
          No vertical routing entries yet. Add one to enable org-level routing.
        </p>
      )}

      <div className="space-y-2">
        {entries.map((entry) => (
          <div
            key={entry.id}
            className="border border-border rounded-lg p-4 bg-card"
          >
            {editingId === entry.id ? (
              <div className="space-y-3">
                <p className="text-sm font-semibold text-[#232222]">
                  Editing: <span className="text-[#B12B35]">{entry.vertical_name}</span>
                </p>
                <div className="grid grid-cols-2 gap-3">
                  <div className="space-y-1.5">
                    <Label className="text-xs">Delivery Unit (DU)</Label>
                    <UserCombobox token={token} value={editDuId || null} onChange={(id) => setEditDuId(id ?? "")} placeholder="Select DU head..." />
                  </div>
                  <div className="space-y-1.5">
                    <Label className="text-xs">Delivery Head (DH)</Label>
                    <UserCombobox token={token} value={editDhId || null} onChange={(id) => setEditDhId(id ?? "")} placeholder="Select DH..." />
                  </div>
                </div>
                <div className="flex gap-2">
                  <Button size="sm" onClick={() => handleSaveEdit(entry.id)} disabled={editSaving}>
                    <Check className="h-3.5 w-3.5 mr-1" />
                    {editSaving ? "Saving…" : "Save"}
                  </Button>
                  <Button size="sm" variant="outline" onClick={() => setEditingId(null)} disabled={editSaving}>
                    <X className="h-3.5 w-3.5 mr-1" />
                    Cancel
                  </Button>
                </div>
              </div>
            ) : (
              <div className="flex items-center justify-between gap-4">
                <div className="flex items-center gap-4 min-w-0">
                  <Badge variant="outline" className="text-[#B12B35] border-[#B12B35]/30 bg-[#B12B35]/5 shrink-0">
                    {entry.vertical_name}
                  </Badge>
                  <div className="flex items-center gap-3 text-sm min-w-0">
                    <span className="text-muted-foreground shrink-0">DU:</span>
                    <span className="font-medium truncate">
                      {entry.du?.full_name || <span className="text-muted-foreground italic">Not set</span>}
                    </span>
                    <span className="text-muted-foreground shrink-0">DH:</span>
                    <span className="font-medium truncate">
                      {entry.dh?.full_name || <span className="text-muted-foreground italic">Not set</span>}
                    </span>
                  </div>
                </div>
                <div className="flex gap-1 shrink-0">
                  <Button size="icon" variant="ghost" className="h-8 w-8" onClick={() => startEdit(entry)}>
                    <Pencil className="h-3.5 w-3.5" />
                  </Button>
                  <Button
                    size="icon"
                    variant="ghost"
                    className="h-8 w-8 text-[#B12B35] hover:text-[#B12B35] hover:bg-[#B12B35]/10"
                    onClick={() => setPendingDelete({ id: entry.id, name: entry.vertical_name })}
                  >
                    <Trash2 className="h-3.5 w-3.5" />
                  </Button>
                </div>
              </div>
            )}
          </div>
        ))}
      </div>

      {showAdd && (
        <div className="border border-[#B12B35]/30 rounded-lg p-4 bg-[#B12B35]/5 space-y-3">
          <p className="text-sm font-semibold text-[#232222]">New Vertical Entry</p>
          <div className="space-y-1.5">
            <Label className="text-xs">Vertical Name *</Label>
            <Input
              placeholder="e.g. Banking & Financial Services"
              value={addVertical}
              onChange={(e) => setAddVertical(e.target.value)}
            />
          </div>
          <div className="grid grid-cols-2 gap-3">
            <div className="space-y-1.5">
              <Label className="text-xs">Delivery Unit (DU)</Label>
              <UserCombobox token={token} value={addDuId || null} onChange={(id) => setAddDuId(id ?? "")} placeholder="Select DU head..." />
            </div>
            <div className="space-y-1.5">
              <Label className="text-xs">Delivery Head (DH)</Label>
              <UserCombobox token={token} value={addDhId || null} onChange={(id) => setAddDhId(id ?? "")} placeholder="Select DH..." />
            </div>
          </div>
          <div className="flex gap-2">
            <Button size="sm" onClick={handleAdd} disabled={addSaving}>
              <Check className="h-3.5 w-3.5 mr-1" />
              {addSaving ? "Adding…" : "Add Entry"}
            </Button>
            <Button size="sm" variant="outline" onClick={() => { setShowAdd(false); setAddVertical(""); setAddDuId(""); setAddDhId(""); }}>
              <X className="h-3.5 w-3.5 mr-1" />
              Cancel
            </Button>
          </div>
        </div>
      )}

      {!showAdd && (
        <Button variant="outline" size="sm" onClick={() => setShowAdd(true)}>
          <Plus className="h-4 w-4 mr-2" />
          Add Vertical
        </Button>
      )}
    </div>
  );
}

// ── Region Sales Tab ──────────────────────────────────────────────────────────

function RegionSalesTab({ token }: { token: string }) {
  // Cached region-sales config — `load` re-runs the query after a mutation.
  const { data: entries = [], isLoading: loading, refetch } = useQuery({
    queryKey: ["region-sales"],
    queryFn: () => api<RegionSalesEntry[]>("/api/region-sales", { token }),
    enabled: !!token,
  });
  const load = () => { refetch(); };
  const [showAdd, setShowAdd] = useState(false);
  const [pendingDelete, setPendingDelete] = useState<{ id: string; name: string } | null>(null);

  const [addRegion, setAddRegion] = useState("");
  const [addUserId, setAddUserId] = useState("");
  const [addCopyAll, setAddCopyAll] = useState(false);
  const [addSaving, setAddSaving] = useState(false);

  const handleAdd = async () => {
    if (!addUserId) {
      toast.error("Please select a sales person.");
      return;
    }
    if (!addCopyAll && !addRegion.trim()) {
      toast.error("Region name is required unless Copy All is enabled.");
      return;
    }
    setAddSaving(true);
    try {
      await api("/api/region-sales", {
        method: "POST",
        body: {
          region_name: addCopyAll ? "ALL" : addRegion.trim(),
          sales_user_id: addUserId,
          copy_all: addCopyAll,
        },
        token,
      });
      toast.success("Region sales mapping added.");
      setShowAdd(false);
      setAddRegion("");
      setAddUserId("");
      setAddCopyAll(false);
      load();
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to add entry.");
    } finally {
      setAddSaving(false);
    }
  };

  const confirmDelete = async () => {
    if (!pendingDelete) return;
    const { id } = pendingDelete;
    setPendingDelete(null);
    try {
      await api(`/api/region-sales/${id}`, { method: "DELETE", token });
      toast.success("Entry removed.");
      load();
    } catch {
      toast.error("Failed to remove entry.");
    }
  };

  const copyAllEntries = entries.filter((e) => e.copy_all);
  const regionalEntries = entries.filter((e) => !e.copy_all);

  if (loading) {
    return (
      <div className="space-y-3">
        {[1, 2, 3].map((i) => <Skeleton key={i} className="h-14 w-full" />)}
      </div>
    );
  }

  return (
    <div className="space-y-4">
      <DeleteConfirmDialog
        open={!!pendingDelete}
        label={pendingDelete?.name ?? ""}
        onConfirm={confirmDelete}
        onCancel={() => setPendingDelete(null)}
      />

      <div className="flex items-start gap-2 p-3 rounded-lg bg-[#2E75B6]/8 border border-[#2E75B6]/20 text-sm text-[#003466]">
        <Info className="h-4 w-4 mt-0.5 shrink-0 text-[#2E75B6]" />
        <span>
          <strong>Region Name</strong> must match the <strong>Region</strong> value on
          the Account (e.g. EMEA, US, APAC).{" "}
          <strong>Copy All</strong> users are always included on every workflow
          regardless of region.
        </span>
      </div>

      {copyAllEntries.length > 0 && (
        <div>
          <p className="text-xs font-semibold text-muted-foreground uppercase tracking-wider mb-2">
            Always Copied (All Workflows)
          </p>
          <div className="space-y-2">
            {copyAllEntries.map((entry) => (
              <div key={entry.id} className="flex items-center justify-between border border-[#003466]/20 rounded-lg px-4 py-3 bg-[#003466]/5">
                <div className="flex items-center gap-3">
                  <Badge className="bg-[#003466] text-white text-[10px]">Copy All</Badge>
                  <span className="text-sm font-medium">{entry.sales?.full_name}</span>
                  <span className="text-xs text-muted-foreground">{entry.sales?.email}</span>
                </div>
                <Button
                  size="icon"
                  variant="ghost"
                  className="h-8 w-8 text-[#B12B35] hover:bg-[#B12B35]/10"
                  onClick={() => setPendingDelete({ id: entry.id, name: entry.sales?.full_name || "" })}
                >
                  <Trash2 className="h-3.5 w-3.5" />
                </Button>
              </div>
            ))}
          </div>
        </div>
      )}

      {regionalEntries.length > 0 && (
        <div>
          <p className="text-xs font-semibold text-muted-foreground uppercase tracking-wider mb-2">
            Region-Specific Sales
          </p>
          <div className="space-y-2">
            {regionalEntries.map((entry) => (
              <div key={entry.id} className="flex items-center justify-between border border-border rounded-lg px-4 py-3 bg-card">
                <div className="flex items-center gap-3">
                  <Badge variant="outline" className="text-[#2E75B6] border-[#2E75B6]/30 bg-[#2E75B6]/5 shrink-0">
                    <MapPin className="h-3 w-3 mr-1" />
                    {entry.region_name}
                  </Badge>
                  <span className="text-sm font-medium">{entry.sales?.full_name}</span>
                  <span className="text-xs text-muted-foreground">{entry.sales?.email}</span>
                </div>
                <Button
                  size="icon"
                  variant="ghost"
                  className="h-8 w-8 text-[#B12B35] hover:bg-[#B12B35]/10"
                  onClick={() => setPendingDelete({ id: entry.id, name: entry.sales?.full_name || "" })}
                >
                  <Trash2 className="h-3.5 w-3.5" />
                </Button>
              </div>
            ))}
          </div>
        </div>
      )}

      {entries.length === 0 && !showAdd && (
        <p className="text-sm text-muted-foreground text-center py-8">
          No region sales mappings yet.
        </p>
      )}

      {showAdd && (
        <div className="border border-[#B12B35]/30 rounded-lg p-4 bg-[#B12B35]/5 space-y-3">
          <p className="text-sm font-semibold text-[#232222]">New Region Sales Entry</p>

          <div className="flex items-center gap-3">
            <input
              type="checkbox"
              id="copy-all"
              checked={addCopyAll}
              onChange={(e) => { setAddCopyAll(e.target.checked); if (e.target.checked) setAddRegion(""); }}
              className="h-4 w-4 accent-[#B12B35]"
            />
            <Label htmlFor="copy-all" className="text-sm cursor-pointer">
              Copy All — include on every workflow (e.g. global leadership)
            </Label>
          </div>

          {!addCopyAll && (
            <div className="space-y-1.5">
              <Label className="text-xs">Region Name *</Label>
              <Input
                placeholder="e.g. EMEA, US, APAC"
                value={addRegion}
                onChange={(e) => setAddRegion(e.target.value)}
              />
            </div>
          )}

          <div className="space-y-1.5">
            <Label className="text-xs">Sales Person *</Label>
            <UserCombobox token={token} value={addUserId || null} onChange={(id) => setAddUserId(id ?? "")} placeholder="Select sales person..." />
          </div>

          <div className="flex gap-2">
            <Button size="sm" onClick={handleAdd} disabled={addSaving}>
              <Check className="h-3.5 w-3.5 mr-1" />
              {addSaving ? "Adding…" : "Add Entry"}
            </Button>
            <Button size="sm" variant="outline" onClick={() => { setShowAdd(false); setAddRegion(""); setAddUserId(""); setAddCopyAll(false); }}>
              <X className="h-3.5 w-3.5 mr-1" />
              Cancel
            </Button>
          </div>
        </div>
      )}

      {!showAdd && (
        <Button variant="outline" size="sm" onClick={() => setShowAdd(true)}>
          <Plus className="h-4 w-4 mr-2" />
          Add Mapping
        </Button>
      )}
    </div>
  );
}

// ── Page ──────────────────────────────────────────────────────────────────────

export default function RoutingConfigPage() {
  const { token, user } = useAuth();

  if (user?.role !== "admin") {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-muted-foreground">Admin access required.</p>
      </div>
    );
  }

  return (
    <div className="max-w-4xl space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Routing Configuration</h1>
        <p className="text-muted-foreground mt-1">
          Configure org-level routing. These are used as a fallback when no
          per-account stakeholders are set in Stakeholder Mapping.
        </p>
      </div>

      <Tabs defaultValue="vertical">
        <TabsList className="mb-4">
          <TabsTrigger value="vertical" className="gap-2">
            <Layers className="h-4 w-4" />
            Vertical Routing
          </TabsTrigger>
          <TabsTrigger value="region" className="gap-2">
            <MapPin className="h-4 w-4" />
            Region Sales
          </TabsTrigger>
        </TabsList>

        <TabsContent value="vertical">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Vertical → DU / DH Mapping</CardTitle>
              <CardDescription>
                Map each industry vertical to a Delivery Unit head and Delivery
                Head. When a submission is made on an account with a matching
                industry, the routing chain starts with DU → DH.
              </CardDescription>
            </CardHeader>
            <CardContent>
              <VerticalRoutingTab token={token!} />
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="region">
          <Card>
            <CardHeader>
              <CardTitle className="text-base">Region → Sales Person Mapping</CardTitle>
              <CardDescription>
                Map each sales territory to the responsible sales stakeholder.
                Mark a person as Copy All to include them on every workflow
                regardless of region.
              </CardDescription>
            </CardHeader>
            <CardContent>
              <RegionSalesTab token={token!} />
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
