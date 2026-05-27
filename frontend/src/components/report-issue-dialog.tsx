"use client";

import { useState } from "react";
import { X, Upload, ImageIcon, Loader2 } from "lucide-react";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { useAuth } from "@/lib/auth-context";
import { api, uploadFile } from "@/lib/api";
import { isHttpUrl } from "@/lib/utils";
import { toast } from "sonner";

const ADMIN_EMAIL = "admin@testingxperts.com";
const MAX_BYTES = 20 * 1024 * 1024;

type Screenshot = { url: string; filename: string };

export function ReportIssueDialog({
  open,
  onOpenChange,
}: {
  open: boolean;
  onOpenChange: (open: boolean) => void;
}) {
  const { user, token } = useAuth();
  const [description, setDescription] = useState("");
  const [screenshots, setScreenshots] = useState<Screenshot[]>([]);
  const [uploading, setUploading] = useState(false);
  const [submitting, setSubmitting] = useState(false);

  const name = user?.full_name ?? "";
  const email = user?.email ?? "";

  function reset() {
    setDescription("");
    setScreenshots([]);
  }

  async function handleFiles(files: FileList | null) {
    if (!files || files.length === 0 || !token) return;
    const picked = Array.from(files);
    setUploading(true);
    try {
      for (const file of picked) {
        if (file.type !== "image/png") {
          toast.error(`${file.name}: only PNG screenshots are allowed.`);
          continue;
        }
        if (file.size > MAX_BYTES) {
          toast.error(`${file.name}: exceeds the 20 MB limit.`);
          continue;
        }
        const res = await uploadFile(file, token);
        setScreenshots((prev) => [...prev, { url: res.url, filename: res.filename }]);
      }
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Upload failed.");
    } finally {
      setUploading(false);
    }
  }

  function removeScreenshot(idx: number) {
    setScreenshots((prev) => prev.filter((_, i) => i !== idx));
  }

  async function handleSubmit() {
    if (!description.trim()) {
      toast.error("Please describe the issue.");
      return;
    }
    setSubmitting(true);
    try {
      await api("/api/issues", {
        method: "POST",
        token: token ?? undefined,
        body: { description: description.trim(), screenshots },
      });
      toast.success("Issue reported. Our admins have been notified.");
      reset();
      onOpenChange(false);
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Could not submit the issue.");
    } finally {
      setSubmitting(false);
    }
  }

  const mailtoHref = `mailto:${ADMIN_EMAIL}?subject=${encodeURIComponent(
    "Tx Catalyst Issue Report"
  )}&body=${encodeURIComponent(
    `Reported by: ${name} (${email})\n\nIssue description:\n${description}`
  )}`;

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-lg bg-white">
        <DialogHeader>
          <DialogTitle>Report an Issue</DialogTitle>
          <DialogDescription>
            Tell us what went wrong. Our admins will review your report.
          </DialogDescription>
        </DialogHeader>

        <div className="min-w-0 space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div className="min-w-0 space-y-1.5">
              <Label>Name</Label>
              <Input value={name} readOnly disabled className="w-full bg-[#F9F9F9]" />
            </div>
            <div className="min-w-0 space-y-1.5">
              <Label>Email</Label>
              <Input value={email} readOnly disabled className="w-full bg-[#F9F9F9]" />
            </div>
          </div>

          <div className="min-w-0 space-y-1.5">
            <Label htmlFor="issue-description">Description</Label>
            <Textarea
              id="issue-description"
              placeholder="Describe the issue you're facing…"
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              rows={4}
              maxLength={5000}
              className="w-full resize-none"
            />
          </div>

          <div className="min-w-0 space-y-1.5">
            <Label>Screenshots (PNG)</Label>
            <label
              className="flex w-full items-center gap-2 cursor-pointer rounded-md border border-dashed border-[#C5C5C5] px-3 py-2.5 text-sm text-[#5D5D5D] hover:border-[#B12B35] hover:text-[#B12B35] transition-colors"
            >
              {uploading ? (
                <Loader2 className="h-4 w-4 animate-spin" />
              ) : (
                <Upload className="h-4 w-4" />
              )}
              <span>{uploading ? "Uploading…" : "Attach PNG screenshots"}</span>
              <input
                type="file"
                accept="image/png"
                multiple
                className="hidden"
                disabled={uploading}
                onChange={(e) => {
                  handleFiles(e.target.files);
                  e.target.value = "";
                }}
              />
            </label>

            {screenshots.length > 0 && (
              <div className="space-y-1.5 pt-1">
                {screenshots.map((s, idx) => (
                  <div
                    key={`${s.url}-${idx}`}
                    className="flex w-full min-w-0 items-center gap-2 rounded-md bg-[#F9F9F9] px-3 py-1.5 text-xs"
                  >
                    <ImageIcon className="h-3.5 w-3.5 text-[#5D5D5D] shrink-0" />
                    <a
                      href={isHttpUrl(s.url) ? s.url : undefined}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="min-w-0 flex-1 truncate text-[#232222] hover:underline"
                    >
                      {s.filename}
                    </a>
                    <button
                      type="button"
                      aria-label="Remove screenshot"
                      onClick={() => removeScreenshot(idx)}
                      className="text-muted-foreground hover:text-[#B12B35] shrink-0"
                    >
                      <X className="h-3.5 w-3.5" />
                    </button>
                  </div>
                ))}
              </div>
            )}
          </div>

          <div className="flex items-center justify-between gap-3 pt-2">
            <a
              href={mailtoHref}
              className="min-w-0 truncate text-xs text-[#B12B35] hover:underline"
            >
              Or email the admin directly
            </a>
            <Button
              onClick={handleSubmit}
              disabled={submitting || uploading}
              className="shrink-0 bg-[#B12B35] hover:bg-[#9a2330] text-white"
            >
              {submitting ? "Submitting…" : "Submit Issue"}
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
}
