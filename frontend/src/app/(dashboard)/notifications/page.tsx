"use client";

import { useState } from "react";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { useRouter } from "next/navigation";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import type { Notification } from "@/types";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import {
  Bell,
  BellOff,
  CheckCheck,
  AlertTriangle,
  Info,
  Clock,
  ShieldCheck,
} from "lucide-react";
import { toast } from "sonner";

const submissionTypeLabel: Record<string, string> = {
  lead:       "Lead",
  value_idea: "Value Idea",
  idea:       "Value Idea",
};

const typeConfig: Record<
  string,
  { icon: React.ElementType; color: string; label: string }
> = {
  reminder: { icon: Clock, color: "text-yellow-500", label: "Reminder" },
  escalation: {
    icon: AlertTriangle,
    color: "text-red-500",
    label: "Escalation",
  },
  status_update: { icon: Info, color: "text-blue-500", label: "Status Update" },
  approval: {
    icon: ShieldCheck,
    color: "text-green-500",
    label: "Approval",
  },
  info: { icon: Info, color: "text-muted-foreground", label: "Info" },
};

function timeAgo(dateStr: string) {
  const diff = Date.now() - new Date(dateStr).getTime();
  const mins = Math.floor(diff / 60000);
  if (mins < 1) return "Just now";
  if (mins < 60) return `${mins}m ago`;
  const hrs = Math.floor(mins / 60);
  if (hrs < 24) return `${hrs}h ago`;
  const days = Math.floor(hrs / 24);
  return `${days}d ago`;
}

// The Opportunity Created / Won-Loss / Pending Review tabs only exist for
// org roles (admin / executive). For everyone else those tab URLs would land
// on a blank page, so non-org users are always routed to the lead detail page.
function notificationHref(n: Notification, isOrgRole: boolean): string | null {
  if (!n.submission_id) return null;
  if (n.submission_type !== "lead") return null;
  // Regular users don't have the assignment tabs — open the lead directly.
  if (!isOrgRole) return `/leads/${n.submission_id}`;
  const msg = (n.message || "").toLowerCase();
  // Map message → destination + tab on the assignments page. Highlight uses the
  // ?highlight=<lead_id> query param picked up by the assignments page.
  if (
    msg.includes("awaiting your review") ||
    msg.includes("assigned to review") ||
    msg.includes("new lead awaiting") ||
    msg.includes("new-account lead")
  ) {
    return `/assignments?tab=pending&highlight=${n.submission_id}`;
  }
  if (msg.includes("opportunity") && (msg.includes("won") || msg.includes("lost"))) {
    return `/assignments?tab=won_loss&highlight=${n.submission_id}`;
  }
  if (msg.includes("now qualified") || msg.includes("create an opportunity")) {
    return `/assignments?tab=opportunity_created&highlight=${n.submission_id}`;
  }
  if (msg.includes("now an opportunity")) {
    return `/assignments?tab=won_loss&highlight=${n.submission_id}`;
  }
  // Fallback — open the lead detail page.
  return `/leads/${n.submission_id}`;
}

export default function NotificationsPage() {
  const { token, user } = useAuth();
  const router = useRouter();
  const isOrgRole = user?.role === "admin" || user?.role === "executive";
  const queryClient = useQueryClient();
  const [tab, setTab] = useState("all");

  // Cached notification list — instant on revisit, refreshed in the background.
  const { data: notificationsData, isLoading: loading } = useQuery({
    queryKey: ["notifications"],
    queryFn: async () => {
      try {
        return await api<Notification[]>("/api/notifications", { token: token! });
      } catch {
        toast.error("Failed to load notifications");
        throw new Error("Failed to load notifications");
      }
    },
    enabled: !!token,
    refetchInterval: 30_000,
  });
  const notifications = notificationsData ?? [];

  const markAsRead = async (ids: string[]) => {
    if (!token) return;
    try {
      await api("/api/notifications/read", {
        method: "PATCH",
        token,
        body: { notification_ids: ids },
      });
      // Refresh the cached list so the read state is reflected immediately.
      queryClient.invalidateQueries({ queryKey: ["notifications"] });
    } catch {
      toast.error("Failed to mark as read");
    }
  };

  const markAllRead = async () => {
    if (!token) return;
    try {
      await api("/api/notifications/read-all", {
        method: "PATCH",
        token,
      });
      queryClient.invalidateQueries({ queryKey: ["notifications"] });
      toast.success("All notifications marked as read");
    } catch {
      toast.error("Failed to mark all as read");
    }
  };

  const filtered =
    tab === "unread"
      ? notifications.filter((n) => !n.is_read)
      : notifications;

  const unreadCount = notifications.filter((n) => !n.is_read).length;

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Notifications</h1>
          <p className="text-muted-foreground">
            Reminders, Status updates, and Escalations
          </p>
        </div>
        {unreadCount > 0 && (
          <Button variant="outline" size="sm" onClick={markAllRead}>
            <CheckCheck className="mr-2 h-4 w-4" />
            Mark All Read ({unreadCount})
          </Button>
        )}
      </div>

      <Tabs value={tab} onValueChange={setTab}>
        <TabsList>
          <TabsTrigger value="all">
            All ({notifications.length})
          </TabsTrigger>
          <TabsTrigger value="unread">
            Unread ({unreadCount})
          </TabsTrigger>
        </TabsList>

        <TabsContent value={tab} className="mt-4 space-y-2">
          {loading ? (
            <p className="text-sm text-muted-foreground py-8 text-center">
              Loading notifications…
            </p>
          ) : filtered.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-12 text-muted-foreground">
              <BellOff className="h-12 w-12 mb-4 opacity-40" />
              <p className="text-sm">
                {tab === "unread"
                  ? "No unread notifications"
                  : "No notifications yet"}
              </p>
            </div>
          ) : (
            filtered.map((n) => {
              const cfg = typeConfig[n.type] || typeConfig.info;
              const Icon = cfg.icon;
              const href = notificationHref(n, isOrgRole);
              const handleOpen = () => {
                if (!href) return;
                if (!n.is_read) markAsRead([n.notification_id]);
                router.push(href);
              };
              return (
                <Card
                  key={n.notification_id}
                  onClick={href ? handleOpen : undefined}
                  className={`transition-colors ${
                    !n.is_read
                      ? "border-l-4 border-l-primary bg-accent/30"
                      : "opacity-75"
                  } ${href ? "cursor-pointer hover:bg-accent/50" : ""}`}
                >
                  <CardContent className="flex items-start gap-4 py-4">
                    <div className={`mt-0.5 ${cfg.color}`}>
                      <Icon className="h-5 w-5" />
                    </div>
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2 mb-1">
                        <Badge variant="outline" className="text-xs">
                          {cfg.label}
                        </Badge>
                        <Badge variant="secondary" className="text-xs">
                          {submissionTypeLabel[n.submission_type] ?? n.submission_type}
                        </Badge>
                        <span className="text-xs text-muted-foreground ml-auto">
                          {timeAgo(n.sent_at)}
                        </span>
                      </div>
                      <p className="text-sm">{n.message}</p>
                    </div>
                    {!n.is_read && (
                      <Button
                        variant="ghost"
                        size="sm"
                        className="shrink-0"
                        onClick={(e) => {
                          e.stopPropagation();
                          markAsRead([n.notification_id]);
                        }}
                      >
                        Mark Read
                      </Button>
                    )}
                  </CardContent>
                </Card>
              );
            })
          )}
        </TabsContent>
      </Tabs>
    </div>
  );
}
