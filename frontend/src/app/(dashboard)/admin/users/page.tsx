"use client";

import { useQuery, useQueryClient } from "@tanstack/react-query";
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
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import { toast } from "sonner";
import type { Profile } from "@/types";

const roleLabels: Record<string, string> = {
  user: "User",
  sales: "Sales",
  practice_lead: "Practice Lead",
  admin: "Admin",
  executive: "Executive",
};

const roleColors: Record<string, string> = {
  admin: "bg-red-500/10 text-red-400",
  executive: "bg-purple-500/10 text-purple-400",
  sales: "bg-blue-500/10 text-blue-400",
  practice_lead: "bg-amber-500/10 text-amber-400",
  user: "bg-green-500/10 text-green-400",
};

function getInitials(name: string) {
  return name
    .split(" ")
    .map((n) => n[0])
    .join("")
    .toUpperCase()
    .slice(0, 2);
}

export default function AdminUsersPage() {
  const { token, user: currentUser } = useAuth();
  const queryClient = useQueryClient();

  const isAdmin = currentUser?.role === "admin";

  // Cached user list — instant on revisit, refreshed in the background.
  const { data: usersData, isLoading: loading } = useQuery({
    queryKey: ["admin-users"],
    queryFn: () => api<Profile[]>("/api/users", { token: token! }),
    enabled: !!token && !!isAdmin,
  });
  const users = usersData ?? [];

  if (currentUser && !isAdmin) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-muted-foreground">Admin access required.</p>
      </div>
    );
  }

  async function handleRoleChange(userId: string, newRole: string) {
    try {
      await api(`/api/users/${userId}`, {
        method: "PATCH",
        body: { role: newRole },
        token: token!,
      });
      // Refresh the cached list so the new role shows immediately.
      queryClient.invalidateQueries({ queryKey: ["admin-users"] });
      toast.success("Role updated");
    } catch (err: unknown) {
      const message =
        err instanceof Error ? err.message : "Failed to update role";
      toast.error(message);
    }
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">User Management</h1>
        <p className="text-muted-foreground">
          Manage users, roles, and permissions.
        </p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">All Users</CardTitle>
          <CardDescription>
            {users.length} user{users.length !== 1 ? "s" : ""} registered
          </CardDescription>
        </CardHeader>
        <CardContent>
          {loading ? (
            <p className="text-sm text-muted-foreground py-8 text-center">
              Loading…
            </p>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>User</TableHead>
                  <TableHead>Email</TableHead>
                  <TableHead>Role</TableHead>
                  <TableHead>Status</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {users.map((u) => (
                  <TableRow key={u.id}>
                    <TableCell>
                      <div className="flex items-center gap-3">
                        <Avatar className="h-8 w-8">
                          <AvatarFallback className="text-xs">
                            {getInitials(u.full_name || u.email)}
                          </AvatarFallback>
                        </Avatar>
                        <span className="font-medium">{u.full_name}</span>
                      </div>
                    </TableCell>
                    <TableCell className="text-muted-foreground">
                      {u.email}
                    </TableCell>
                    <TableCell>
                      {currentUser?.role === "admin" &&
                      u.id !== currentUser.id ? (
                        <Select
                          value={u.role}
                          onValueChange={(val: string | null) => {
                            if (val) handleRoleChange(u.id, val);
                          }}
                        >
                          <SelectTrigger className="w-44 h-8">
                            <SelectValue />
                          </SelectTrigger>
                          <SelectContent>
                            {Object.entries(roleLabels).map(([val, label]) => (
                              <SelectItem key={val} value={val}>
                                {label}
                              </SelectItem>
                            ))}
                          </SelectContent>
                        </Select>
                      ) : (
                        <Badge
                          variant="secondary"
                          className={roleColors[u.role]}
                        >
                          {roleLabels[u.role] || u.role}
                        </Badge>
                      )}
                    </TableCell>
                    <TableCell>
                      <Badge
                        variant="secondary"
                        className={
                          u.is_active
                            ? "bg-green-500/10 text-green-500"
                            : "bg-red-500/10 text-red-400"
                        }
                      >
                        {u.is_active ? "Active" : "Inactive"}
                      </Badge>
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
