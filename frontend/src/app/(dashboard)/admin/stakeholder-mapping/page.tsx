"use client";

import { useState, useEffect, useCallback } from "react";
import {
  GitMerge,
  Plus,
  Trash2,
  ChevronUp,
  ChevronDown,
  Pencil,
  Check,
  X,
  AlertTriangle,
  Users,
} from "lucide-react";
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
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import { Badge } from "@/components/ui/badge";
import { Skeleton } from "@/components/ui/skeleton";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import { toast } from "sonner";
import { AccountCombobox } from "@/components/account-combobox";
import { UserCombobox } from "@/components/user-combobox";

// ── Types ────────────────────────────────────────────────────────────────────

interface Stakeholder {
  id: string;
  account_id: string;
  user_id: string;
  role_label: string;
  step_order: number;
  user?: {
    id: string;
    full_name: string;
    email: string;
    role: string;
  };
}

// ── Stakeholder row component ─────────────────────────────────────────────────

function StakeholderRow({
  item,
  index,
  total,
  token,
  onMoveUp,
  onMoveDown,
  onRemove,
  onUpdate,
}: {
  item: Stakeholder;
  index: number;
  total: number;
  token: string;
  onMoveUp: () => void;
  onMoveDown: () => void;
  onRemove: () => void;
  onUpdate: (id: string, changes: { role_label?: string; user_id?: string }) => void;
}) {
  const [editingLabel, setEditingLabel] = useState(false);
  const [labelDraft, setLabelDraft] = useState(item.role_label);
  const [editingUser, setEditingUser] = useState(false);
  const [newUserId, setNewUserId] = useState<string | null>(null);
  const [confirmDelete, setConfirmDelete] = useState(false);

  function saveLabel() {
    if (labelDraft.trim() && labelDraft !== item.role_label) {
      onUpdate(item.id, { role_label: labelDraft.trim() });
    }
    setEditingLabel(false);
  }

  function saveUser() {
    if (newUserId && newUserId !== item.user_id) {
      onUpdate(item.id, { user_id: newUserId });
    }
    setEditingUser(false);
    setNewUserId(null);
  }

  return (
    <div className="flex items-start gap-3 rounded-lg border bg-card p-4 transition-colors hover:bg-muted/20">
      {/* Step number */}
      <div className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-[#B12B35]/10 text-[#B12B35] text-sm font-bold">
        {index + 1}
      </div>

      {/* Main content */}
      <div className="flex-1 min-w-0 space-y-2">
        {/* Role label */}
        {editingLabel ? (
          <div className="flex items-center gap-2">
            <Input
              value={labelDraft}
              onChange={(e) => setLabelDraft(e.target.value)}
              className="h-7 text-sm"
              autoFocus
              onKeyDown={(e) => {
                if (e.key === "Enter") saveLabel();
                if (e.key === "Escape") { setLabelDraft(item.role_label); setEditingLabel(false); }
              }}
            />
            <Button size="icon" variant="ghost" className="h-7 w-7" onClick={saveLabel}>
              <Check className="h-3.5 w-3.5 text-green-600" />
            </Button>
            <Button size="icon" variant="ghost" className="h-7 w-7" onClick={() => { setLabelDraft(item.role_label); setEditingLabel(false); }}>
              <X className="h-3.5 w-3.5 text-muted-foreground" />
            </Button>
          </div>
        ) : (
          <div className="flex items-center gap-1.5">
            <span className="text-sm font-semibold text-foreground">{item.role_label}</span>
            <button onClick={() => setEditingLabel(true)} className="text-muted-foreground hover:text-foreground">
              <Pencil className="h-3 w-3" />
            </button>
          </div>
        )}

        {/* Reviewer */}
        {editingUser ? (
          <div className="flex items-center gap-2">
            <div className="flex-1">
              <UserCombobox
                value={newUserId ?? item.user_id}
                onChange={(id) => setNewUserId(id)}
                token={token}
                placeholder="Search for reviewer…"
              />
            </div>
            <Button size="icon" variant="ghost" className="h-7 w-7" onClick={saveUser}>
              <Check className="h-3.5 w-3.5 text-green-600" />
            </Button>
            <Button size="icon" variant="ghost" className="h-7 w-7" onClick={() => { setEditingUser(false); setNewUserId(null); }}>
              <X className="h-3.5 w-3.5 text-muted-foreground" />
            </Button>
          </div>
        ) : (
          <div className="flex items-center gap-1.5">
            {item.user ? (
              <>
                <span className="text-sm text-muted-foreground">{item.user.full_name}</span>
                <span className="text-xs text-muted-foreground">({item.user.email})</span>
                <Badge variant="secondary" className="text-[10px] px-1.5 py-0 capitalize">
                  {item.user.role.replace(/_/g, " ")}
                </Badge>
              </>
            ) : (
              <span className="text-sm text-muted-foreground italic">Unknown user</span>
            )}
            <button onClick={() => setEditingUser(true)} className="text-muted-foreground hover:text-foreground ml-0.5">
              <Pencil className="h-3 w-3" />
            </button>
          </div>
        )}
      </div>

      {/* Controls */}
      <div className="flex items-center gap-0.5 shrink-0">
        <Button
          size="icon" variant="ghost" className="h-7 w-7"
          disabled={index === 0}
          onClick={onMoveUp}
          title="Move up"
        >
          <ChevronUp className="h-4 w-4" />
        </Button>
        <Button
          size="icon" variant="ghost" className="h-7 w-7"
          disabled={index === total - 1}
          onClick={onMoveDown}
          title="Move down"
        >
          <ChevronDown className="h-4 w-4" />
        </Button>
        <Button
          size="icon" variant="ghost"
          className="h-7 w-7 text-red-400 hover:text-red-600 hover:bg-red-50"
          onClick={() => setConfirmDelete(true)}
          title="Remove reviewer"
        >
          <Trash2 className="h-3.5 w-3.5" />
        </Button>

        <Dialog open={confirmDelete} onOpenChange={setConfirmDelete}>
          <DialogContent className="sm:max-w-sm">
            <DialogHeader>
              <DialogTitle className="text-[#232222]">Remove Reviewer</DialogTitle>
            </DialogHeader>
            <p className="text-sm text-[#5D5D5D]">
              Are you sure you want to remove <span className="font-medium text-[#232222]">{item.user?.full_name ?? item.role_label}</span> from the routing chain? This cannot be undone.
            </p>
            <DialogFooter className="gap-2 mt-2">
              <Button variant="outline" className="border-[#C5C5C5]" onClick={() => setConfirmDelete(false)}>
                Cancel
              </Button>
              <Button
                className="bg-red-600 hover:bg-red-700 text-white"
                onClick={() => { setConfirmDelete(false); onRemove(); }}
              >
                Remove
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </div>
  );
}

// ── Add reviewer form ─────────────────────────────────────────────────────────

function AddReviewerForm({
  accountId,
  token,
  nextStep,
  onAdded,
  onCancel,
}: {
  accountId: string;
  token: string;
  nextStep: number;
  onAdded: () => void;
  onCancel: () => void;
}) {
  const [userId, setUserId] = useState<string | null>(null);
  const [selectedName, setSelectedName] = useState<string>("");
  const [saving, setSaving] = useState(false);

  async function handleAdd() {
    if (!userId) { toast.error("Please select a reviewer."); return; }
    setSaving(true);
    try {
      await api("/api/stakeholders", {
        method: "POST",
        body: {
          account_id: accountId,
          user_id: userId,
          role_label: selectedName || "Reviewer",
          step_order: nextStep,
        },
        token,
      });
      toast.success("Reviewer added.");
      onAdded();
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to add reviewer.");
    } finally {
      setSaving(false);
    }
  }

  return (
    <div className="rounded-lg border border-dashed border-[#B12B35]/30 bg-[#B12B35]/5 p-4 space-y-3">
      <p className="text-sm font-medium text-[#B12B35]">Add Reviewer — Step {nextStep}</p>
      <div className="space-y-2">
        <Label className="text-xs">Reviewer</Label>
        <UserCombobox
          value={userId}
          onChange={(id, user) => { setUserId(id); setSelectedName(user?.full_name ?? ""); }}
          token={token}
          placeholder="Search by name (3+ characters)…"
        />
      </div>
      <div className="flex gap-2 pt-1">
        <Button size="sm" onClick={handleAdd} disabled={saving || !userId}>
          {saving ? "Adding…" : "Add Reviewer"}
        </Button>
        <Button size="sm" variant="outline" onClick={onCancel} disabled={saving}>
          Cancel
        </Button>
      </div>
    </div>
  );
}

// ── Main page ─────────────────────────────────────────────────────────────────

export default function StakeholderMappingPage() {
  const { token, user } = useAuth();
  const [accountId, setAccountId] = useState<string | null>(null);
  const [stakeholders, setStakeholders] = useState<Stakeholder[]>([]);
  const [loading, setLoading] = useState(false);
  const [showAddForm, setShowAddForm] = useState(false);
  const [saving, setSaving] = useState(false);

  if (user && user.role !== "admin") {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-muted-foreground">Admin access required.</p>
      </div>
    );
  }

  const fetchStakeholders = useCallback(async () => {
    if (!accountId || !token) return;
    setLoading(true);
    try {
      const data = await api<Stakeholder[]>(`/api/stakeholders?account_id=${accountId}`, { token });
      setStakeholders(data);
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to load stakeholders.");
    } finally {
      setLoading(false);
    }
  }, [accountId, token]);

  useEffect(() => {
    fetchStakeholders();
  }, [fetchStakeholders]);

  // ── Reorder helpers ────────────────────────────────────────────────────────

  async function persistOrder(reordered: Stakeholder[]) {
    if (!token) return;
    setSaving(true);
    try {
      const items = reordered.map((s, idx) => ({ id: s.id, step_order: idx + 1 }));
      await api("/api/stakeholders/reorder", {
        method: "POST",
        body: { items },
        token,
      });
      setStakeholders(reordered.map((s, idx) => ({ ...s, step_order: idx + 1 })));
    } catch {
      toast.error("Failed to save order.");
    } finally {
      setSaving(false);
    }
  }

  function moveUp(index: number) {
    if (index === 0) return;
    const reordered = [...stakeholders];
    [reordered[index - 1], reordered[index]] = [reordered[index], reordered[index - 1]];
    persistOrder(reordered);
  }

  function moveDown(index: number) {
    if (index === stakeholders.length - 1) return;
    const reordered = [...stakeholders];
    [reordered[index], reordered[index + 1]] = [reordered[index + 1], reordered[index]];
    persistOrder(reordered);
  }

  // ── Update a single stakeholder (label or user) ────────────────────────────

  async function updateStakeholder(id: string, changes: { role_label?: string; user_id?: string }) {
    if (!token) return;
    try {
      await api(`/api/stakeholders/${id}`, {
        method: "PATCH",
        body: changes,
        token,
      });
      toast.success("Updated.");
      fetchStakeholders();
    } catch {
      toast.error("Failed to update.");
    }
  }

  // ── Remove ────────────────────────────────────────────────────────────────

  async function removeStakeholder(id: string) {
    if (!token) return;
    try {
      await api(`/api/stakeholders/${id}`, { method: "DELETE", token });
      toast.success("Reviewer removed.");
      setStakeholders((prev) => prev.filter((s) => s.id !== id));
    } catch {
      toast.error("Failed to remove.");
    }
  }

  const nextStep = stakeholders.length + 1;

  return (
    <div className="max-w-2xl space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-2xl font-bold tracking-tight flex items-center gap-2">
          <GitMerge className="h-6 w-6 text-[#B12B35]" />
          Stakeholder Mapping
        </h1>
        <p className="text-muted-foreground text-sm mt-1">
          Configure the approval chain for each account. Submissions are routed through
          reviewers in the order shown below — step 1 first, then step 2, and so on.
        </p>
      </div>

      {/* Account selector */}
      {/* Allow combobox dropdown to overflow outside the card */}
      <Card className="overflow-visible">
        <CardHeader className="pb-3">
          <CardTitle className="text-base">Select Account</CardTitle>
          <CardDescription>
            Search for an account to view and manage its reviewer chain.
          </CardDescription>
        </CardHeader>
        <CardContent className="overflow-visible">
          <AccountCombobox
            name="account_id"
            value={accountId ?? ""}
            onChange={(id) => {
              setAccountId(id || null);
              setStakeholders([]);
              setShowAddForm(false);
            }}
            token={token ?? ""}
            placeholder="Type 3+ characters to search accounts…"
          />
        </CardContent>
      </Card>

      {/* Routing chain */}
      {accountId && (
        <Card>
          <CardHeader className="pb-3">
            <CardTitle className="text-base flex items-center gap-2">
              <Users className="h-4 w-4 text-[#B12B35]" />
              Routing Chain
              {saving && (
                <span className="text-xs text-muted-foreground font-normal ml-2">Saving…</span>
              )}
            </CardTitle>
            <CardDescription>
              Submissions flow from Step 1 → Step 2 → … in sequence. Use arrows to reorder.
              Click the pencil icon to rename a role or change the reviewer.
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-2">
            {loading ? (
              <>
                <Skeleton className="h-16 w-full" />
                <Skeleton className="h-16 w-full" />
                <Skeleton className="h-16 w-full" />
              </>
            ) : stakeholders.length === 0 && !showAddForm ? (
              <div className="flex flex-col items-center gap-3 py-8 text-center">
                <AlertTriangle className="h-8 w-8 text-amber-400" />
                <p className="text-sm font-medium">No reviewers configured</p>
                <p className="text-xs text-muted-foreground max-w-xs">
                  Submissions for this account will be placed in &quot;Routing Pending&quot; status
                  until at least one reviewer is added.
                </p>
              </div>
            ) : (
              <>
                {stakeholders.map((s, idx) => (
                  <StakeholderRow
                    key={s.id}
                    item={s}
                    index={idx}
                    total={stakeholders.length}
                    token={token ?? ""}
                    onMoveUp={() => moveUp(idx)}
                    onMoveDown={() => moveDown(idx)}
                    onRemove={() => removeStakeholder(s.id)}
                    onUpdate={updateStakeholder}
                  />
                ))}
              </>
            )}

            {/* Add reviewer form (inline) */}
            {showAddForm && accountId ? (
              <AddReviewerForm
                accountId={accountId}
                token={token ?? ""}
                nextStep={nextStep}
                onAdded={() => { setShowAddForm(false); fetchStakeholders(); }}
                onCancel={() => setShowAddForm(false)}
              />
            ) : (
              !loading && (
                <Button
                  variant="outline"
                  size="sm"
                  className="w-full mt-2 border-dashed"
                  onClick={() => setShowAddForm(true)}
                >
                  <Plus className="h-4 w-4 mr-1.5" />
                  Add Reviewer
                </Button>
              )
            )}
          </CardContent>
        </Card>
      )}

      {/* How it works */}
      <Card className="bg-muted/30 border-dashed">
        <CardContent className="pt-4 pb-4">
          <p className="text-xs font-semibold text-muted-foreground uppercase tracking-wide mb-2">How routing works</p>
          <ul className="text-xs text-muted-foreground space-y-1 list-disc list-inside">
            <li>When a user submits a lead, it is assigned to <strong>Step 1</strong> reviewer.</li>
            <li>On approval, it automatically moves to <strong>Step 2</strong>, then Step 3, and so on.</li>
            <li>On rejection at any step, the submitter is notified and the chain stops.</li>
            <li>After the final step approves, the submission is marked <strong>Approved</strong>.</li>
            <li>If no reviewers are configured, the submission status becomes <strong>Routing Pending</strong>.</li>
          </ul>
        </CardContent>
      </Card>
    </div>
  );
}
