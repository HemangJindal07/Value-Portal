"use client";

import { useRouter } from "next/navigation";
import { useEffect, useState, useCallback, useRef } from "react";
import { useNavigationGuard } from "@/lib/navigation-guard-context";
import { Bell, LogOut, Search, Loader2 } from "lucide-react";
import { SidebarTrigger } from "@/components/ui/sidebar";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Separator } from "@/components/ui/separator";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { useAuth } from "@/lib/auth-context";
import { ThemeToggle } from "@/components/theme-toggle";
import { api } from "@/lib/api";
import type { LeadWithRelations } from "@/types";

function getInitials(name: string) {
  return name
    .split(" ")
    .map((n) => n[0])
    .join("")
    .toUpperCase()
    .slice(0, 2);
}

export function Topbar() {
  const { user, token, signOut } = useAuth();
  const router = useRouter();
  const { requestNavigate } = useNavigationGuard();
  const [unreadCount, setUnreadCount] = useState(0);

  // ── Global lead search ─────────────────────────────────────
  const [searchQuery, setSearchQuery] = useState("");
  const [searchResults, setSearchResults] = useState<LeadWithRelations[]>([]);
  const [searchOpen, setSearchOpen] = useState(false);
  const [searchLoading, setSearchLoading] = useState(false);
  const searchContainerRef = useRef<HTMLDivElement | null>(null);

  const fetchUnread = useCallback(async () => {
    if (!token) return;
    try {
      const data = await api<{ unread: number }>("/api/notifications/count", {
        token,
      });
      setUnreadCount(data.unread);
    } catch {
      /* ignore */
    }
  }, [token]);

  useEffect(() => {
    fetchUnread();
    const interval = setInterval(fetchUnread, 30_000);
    return () => clearInterval(interval);
  }, [fetchUnread]);

  // Debounced search — backend /api/leads already scopes by role
  useEffect(() => {
    if (!token) return;
    const q = searchQuery.trim();
    if (q.length < 2) {
      setSearchResults([]);
      setSearchLoading(false);
      return;
    }
    setSearchLoading(true);
    const handle = setTimeout(async () => {
      try {
        const data = await api<LeadWithRelations[]>(
          `/api/leads?search=${encodeURIComponent(q)}`,
          { token }
        );
        setSearchResults(data.slice(0, 8));
      } catch {
        setSearchResults([]);
      } finally {
        setSearchLoading(false);
      }
    }, 250);
    return () => clearTimeout(handle);
  }, [searchQuery, token]);

  // Close dropdown when clicking outside
  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (
        searchContainerRef.current &&
        !searchContainerRef.current.contains(e.target as Node)
      ) {
        setSearchOpen(false);
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const handleSelectLead = (leadId: string) => {
    setSearchOpen(false);
    setSearchQuery("");
    setSearchResults([]);
    requestNavigate(() => router.push(`/leads/${leadId}`));
  };

  const handleSignOut = async () => {
    try {
      await signOut();
      localStorage.clear();
      sessionStorage.clear();
    } catch {
      // signOut failed — proceed with redirect anyway
    } finally {
      window.location.href = "/login";
    }
  };

  return (
    <header className="flex h-14 items-center gap-4 border-b border-border bg-background px-4">
      <SidebarTrigger className="text-muted-foreground hover:text-foreground" />
      <Separator orientation="vertical" className="h-6" />

      <div className="relative flex-1 max-w-md" ref={searchContainerRef}>
        <Search className="pointer-events-none absolute left-2.5 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
        <Input
          type="search"
          placeholder="Search leads..."
          value={searchQuery}
          onChange={(e) => {
            setSearchQuery(e.target.value);
            setSearchOpen(true);
          }}
          onFocus={() => setSearchOpen(true)}
          className="pl-9 h-9 bg-[#F9F9F9] border-[#C5C5C5] focus:border-[#B12B35] focus:ring-[#B12B35]/20"
        />
        {searchLoading && (
          <Loader2 className="absolute right-2.5 top-1/2 -translate-y-1/2 h-4 w-4 animate-spin text-muted-foreground" />
        )}

        {searchOpen && searchQuery.trim().length >= 2 && (
          <div className="absolute left-0 right-0 top-full mt-1 z-50 max-h-80 overflow-y-auto rounded-lg border border-[#EDE7E6] bg-white shadow-lg">
            {searchLoading && searchResults.length === 0 ? (
              <div className="px-3 py-4 text-center text-xs text-muted-foreground">
                Searching…
              </div>
            ) : searchResults.length === 0 ? (
              <div className="px-3 py-4 text-center text-xs text-muted-foreground">
                No leads found for &quot;{searchQuery}&quot;
              </div>
            ) : (
              <ul className="py-1">
                {searchResults.map((lead) => (
                  <li key={lead.lead_id}>
                    <button
                      type="button"
                      onClick={() => handleSelectLead(lead.lead_id)}
                      className="w-full px-3 py-2 text-left hover:bg-[#F9F9F9] transition-colors flex flex-col gap-0.5"
                    >
                      <span className="text-sm font-medium text-[#232222] line-clamp-1">
                        {lead.title}
                      </span>
                      <span className="text-[11px] text-muted-foreground line-clamp-1">
                        {lead.account?.account_name ?? "—"}
                        {lead.status && (
                          <>
                            {" · "}
                            <span className="capitalize">
                              {lead.status.replace(/_/g, " ")}
                            </span>
                          </>
                        )}
                      </span>
                    </button>
                  </li>
                ))}
              </ul>
            )}
          </div>
        )}
      </div>

      <div className="ml-auto flex items-center gap-2">
        <ThemeToggle />

        {/* Notification bell — Brand Red badge */}
        <Button
          variant="ghost"
          size="icon"
          className="relative"
          onClick={() => requestNavigate(() => router.push("/notifications"))}
        >
          <Bell className="h-4 w-4" />
          {unreadCount > 0 && (
            <span className="absolute -top-0.5 -right-0.5 flex h-4 min-w-4 items-center justify-center rounded-full bg-[#B12B35] px-1 text-[10px] font-bold text-white">
              {unreadCount > 99 ? "99+" : unreadCount}
            </span>
          )}
        </Button>

        {/* User dropdown */}
        <DropdownMenu>
          <DropdownMenuTrigger className="rounded-full outline-none focus-visible:ring-2 focus-visible:ring-[#B12B35]/50">
            <Avatar className="h-8 w-8 cursor-pointer">
              <AvatarFallback className="text-xs bg-[#B12B35] text-white font-semibold">
                {user ? getInitials(user.full_name || user.email) : "?"}
              </AvatarFallback>
            </Avatar>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end" className="w-56">
            {user && (
              <>
                <DropdownMenuLabel className="font-normal">
                  <div className="flex flex-col gap-1">
                    <p className="text-sm font-semibold text-[#232222]">
                      {user.full_name}
                    </p>
                    <p className="text-xs text-[#5D5D5D]">{user.email}</p>
                  </div>
                </DropdownMenuLabel>
                <DropdownMenuSeparator />
              </>
            )}
            <DropdownMenuItem
              className="text-[#B12B35] focus:text-[#B12B35] focus:bg-[#B12B35]/5"
              onClick={handleSignOut}
            >
              <LogOut className="mr-2 h-4 w-4" />
              Sign Out
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      </div>
    </header>
  );
}
