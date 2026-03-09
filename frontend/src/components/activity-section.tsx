"use client";

import { useEffect, useState, useCallback } from "react";
import { MessageSquare, GitBranch, Send, Trash2 } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { Badge } from "@/components/ui/badge";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import { toast } from "sonner";
import type { StatusHistory, Comment } from "@/types";

interface Props {
  submissionType: "lead" | "idea";
  submissionId: string;
}

const statusColors: Record<string, string> = {
  draft: "bg-gray-500/10 text-gray-400",
  submitted: "bg-blue-500/10 text-blue-400",
  under_review: "bg-amber-500/10 text-amber-400",
  qualified: "bg-green-500/10 text-green-400",
  approved: "bg-green-500/10 text-green-400",
  in_progress: "bg-cyan-500/10 text-cyan-400",
  implemented: "bg-emerald-500/10 text-emerald-400",
  won: "bg-emerald-500/10 text-emerald-400",
  lost: "bg-red-500/10 text-red-400",
  rejected: "bg-red-500/10 text-red-400",
  dropped: "bg-gray-500/10 text-gray-500",
};

type HistoryEntry = StatusHistory & {
  changed_by_profile?: { id: string; full_name: string; role: string };
};

type CommentEntry = Comment & {
  author?: { id: string; full_name: string; role: string };
};

type TimelineItem =
  | { kind: "history"; data: HistoryEntry; timestamp: string }
  | { kind: "comment"; data: CommentEntry; timestamp: string };

export function ActivitySection({ submissionType, submissionId }: Props) {
  const { token, user } = useAuth();
  const [history, setHistory] = useState<HistoryEntry[]>([]);
  const [comments, setComments] = useState<CommentEntry[]>([]);
  const [commentText, setCommentText] = useState("");
  const [submitting, setSubmitting] = useState(false);
  const [loading, setLoading] = useState(true);

  const fetchActivity = useCallback(async () => {
    if (!token) return;
    try {
      const [hist, comms] = await Promise.all([
        api<HistoryEntry[]>(
          `/api/tracking/${submissionType}/${submissionId}/history`,
          { token }
        ),
        api<CommentEntry[]>(
          `/api/tracking/${submissionType}/${submissionId}/comments`,
          { token }
        ),
      ]);
      setHistory(hist);
      setComments(comms);
    } catch {
      // silently fail — activity is supplementary
    } finally {
      setLoading(false);
    }
  }, [token, submissionType, submissionId]);

  useEffect(() => {
    fetchActivity();
  }, [fetchActivity]);

  const handleAddComment = async () => {
    if (!commentText.trim() || !token) return;
    setSubmitting(true);
    try {
      await api(`/api/tracking/${submissionType}/${submissionId}/comments`, {
        method: "POST",
        body: { content: commentText.trim(), is_internal: false },
        token,
      });
      setCommentText("");
      await fetchActivity();
      toast.success("Comment added");
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Failed to add comment");
    } finally {
      setSubmitting(false);
    }
  };

  const handleDeleteComment = async (commentId: string) => {
    if (!token) return;
    try {
      await api(
        `/api/tracking/${submissionType}/${submissionId}/comments/${commentId}`,
        { method: "DELETE", token }
      );
      await fetchActivity();
      toast.success("Comment deleted");
    } catch {
      toast.error("Failed to delete comment");
    }
  };

  // Merge history + comments into a single sorted timeline
  const timeline: TimelineItem[] = [
    ...history.map((h) => ({
      kind: "history" as const,
      data: h,
      timestamp: h.changed_at,
    })),
    ...comments.map((c) => ({
      kind: "comment" as const,
      data: c,
      timestamp: c.created_at,
    })),
  ].sort((a, b) => new Date(a.timestamp).getTime() - new Date(b.timestamp).getTime());

  return (
    <Card>
      <CardHeader>
        <CardTitle className="text-base flex items-center gap-2">
          <MessageSquare className="h-4 w-4" />
          Activity & Comments
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        {/* Timeline */}
        {loading ? (
          <p className="text-sm text-muted-foreground">Loading activity...</p>
        ) : timeline.length === 0 ? (
          <p className="text-sm text-muted-foreground">
            No activity yet. Status changes and comments will appear here.
          </p>
        ) : (
          <div className="relative space-y-3">
            {/* vertical line */}
            <div className="absolute left-[7px] top-2 bottom-2 w-px bg-border" />

            {timeline.map((item) => {
              if (item.kind === "history") {
                const h = item.data as HistoryEntry;
                return (
                  <div key={h.history_id} className="flex gap-3 items-start pl-1">
                    <div className="mt-1 h-3.5 w-3.5 rounded-full bg-amber-500/20 border border-amber-500/40 flex items-center justify-center shrink-0 z-10">
                      <GitBranch className="h-2 w-2 text-amber-400" />
                    </div>
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2 flex-wrap">
                        <span className="text-xs font-medium">
                          {h.changed_by_profile?.full_name ?? "System"}
                        </span>
                        <span className="text-xs text-muted-foreground">changed status</span>
                        <Badge
                          variant="secondary"
                          className={`text-[10px] px-1.5 py-0 ${statusColors[h.from_status] ?? ""}`}
                        >
                          {h.from_status.replace(/_/g, " ")}
                        </Badge>
                        <span className="text-xs text-muted-foreground">→</span>
                        <Badge
                          variant="secondary"
                          className={`text-[10px] px-1.5 py-0 ${statusColors[h.to_status] ?? ""}`}
                        >
                          {h.to_status.replace(/_/g, " ")}
                        </Badge>
                      </div>
                      {h.reason && (
                        <p className="text-xs text-muted-foreground mt-0.5">{h.reason}</p>
                      )}
                      <p className="text-[11px] text-muted-foreground mt-0.5">
                        {new Date(h.changed_at).toLocaleString()}
                      </p>
                    </div>
                  </div>
                );
              }

              const c = item.data as CommentEntry;
              const isOwn = c.author_id === user?.id;
              return (
                <div key={c.comment_id} className="flex gap-3 items-start pl-1">
                  <div className="mt-1 h-3.5 w-3.5 rounded-full bg-blue-500/20 border border-blue-500/40 flex items-center justify-center shrink-0 z-10">
                    <MessageSquare className="h-2 w-2 text-blue-400" />
                  </div>
                  <div className="flex-1 min-w-0 group">
                    <div className="flex items-center justify-between gap-2">
                      <div className="flex items-center gap-1.5">
                        <span className="text-xs font-medium">
                          {c.author?.full_name ?? "Unknown"}
                        </span>
                        {c.is_internal && (
                          <Badge
                            variant="secondary"
                            className="text-[10px] px-1.5 py-0 bg-purple-500/10 text-purple-400"
                          >
                            internal
                          </Badge>
                        )}
                      </div>
                      {isOwn && (
                        <Button
                          variant="ghost"
                          size="icon"
                          className="h-5 w-5 opacity-0 group-hover:opacity-100 text-muted-foreground hover:text-destructive"
                          onClick={() => handleDeleteComment(c.comment_id)}
                        >
                          <Trash2 className="h-3 w-3" />
                        </Button>
                      )}
                    </div>
                    <p className="text-sm mt-0.5 break-words">{c.content}</p>
                    <p className="text-[11px] text-muted-foreground mt-0.5">
                      {new Date(c.created_at).toLocaleString()}
                    </p>
                  </div>
                </div>
              );
            })}
          </div>
        )}

        {/* Add comment */}
        <div className="pt-2 border-t border-border space-y-2">
          <Textarea
            placeholder="Add a comment..."
            rows={2}
            value={commentText}
            onChange={(e) => setCommentText(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === "Enter" && (e.metaKey || e.ctrlKey)) handleAddComment();
            }}
            className="text-sm resize-none"
          />
          <div className="flex items-center justify-between">
            <p className="text-[11px] text-muted-foreground">
              Ctrl+Enter to submit
            </p>
            <Button
              size="sm"
              onClick={handleAddComment}
              disabled={submitting || !commentText.trim()}
            >
              <Send className="h-3.5 w-3.5 mr-1.5" />
              {submitting ? "Posting..." : "Comment"}
            </Button>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
