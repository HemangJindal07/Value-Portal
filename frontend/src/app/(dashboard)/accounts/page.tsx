"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { Plus, Building2, Search } from "lucide-react";
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
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import type { Account } from "@/types";

const statusColors: Record<string, string> = {
  active: "bg-green-500/10 text-green-500",
  inactive: "bg-gray-500/10 text-gray-400",
  prospect: "bg-blue-500/10 text-blue-400",
};

export default function AccountsPage() {
  const { token } = useAuth();
  const [accounts, setAccounts] = useState<Account[]>([]);
  const [search, setSearch] = useState("");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!token) return;
    setLoading(true);
    const params = search ? `?search=${encodeURIComponent(search)}` : "";
    api<Account[]>(`/api/accounts${params}`, { token })
      .then(setAccounts)
      .catch(() => {})
      .finally(() => setLoading(false));
  }, [token, search]);

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Accounts</h1>
          <p className="text-muted-foreground">
            Manage client accounts and engagements.
          </p>
        </div>
        <Link href="/accounts/new">
          <Button>
            <Plus className="mr-2 h-4 w-4" />
            New Account
          </Button>
        </Link>
      </div>

      <div className="relative max-w-sm">
        <Search className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
        <Input
          placeholder="Search accounts..."
          className="pl-9"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
        />
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">All Accounts</CardTitle>
          <CardDescription>
            {accounts.length} account{accounts.length !== 1 ? "s" : ""}
          </CardDescription>
        </CardHeader>
        <CardContent>
          {loading ? (
            <p className="text-sm text-muted-foreground py-8 text-center">
              Loading...
            </p>
          ) : accounts.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-12 text-center">
              <Building2 className="h-10 w-10 text-muted-foreground mb-3" />
              <p className="text-sm text-muted-foreground">
                No accounts yet. Create your first account to get started.
              </p>
            </div>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Account Name</TableHead>
                  <TableHead>Industry</TableHead>
                  <TableHead>Region</TableHead>
                  <TableHead>Status</TableHead>
                  <TableHead className="text-right">Contract Value</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {accounts.map((acct) => (
                  <TableRow key={acct.account_id}>
                    <TableCell>
                      <Link
                        href={`/accounts/${acct.account_id}`}
                        className="font-medium hover:underline"
                      >
                        {acct.account_name}
                      </Link>
                    </TableCell>
                    <TableCell className="text-muted-foreground">
                      {acct.industry || "—"}
                    </TableCell>
                    <TableCell className="text-muted-foreground">
                      {acct.region || "—"}
                    </TableCell>
                    <TableCell>
                      <Badge
                        variant="secondary"
                        className={statusColors[acct.account_status]}
                      >
                        {acct.account_status}
                      </Badge>
                    </TableCell>
                    <TableCell className="text-right">
                      {acct.contract_value
                        ? `$${Number(acct.contract_value).toLocaleString()}`
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
