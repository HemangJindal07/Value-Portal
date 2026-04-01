"use client";

import * as React from "react";
import { Check, ChevronsUpDown, Loader2, X } from "lucide-react";
import { cn } from "@/lib/utils";
import { api } from "@/lib/api";

interface UserOption {
  id: string;
  full_name: string;
  email: string;
  role: string;
}

interface UserComboboxProps {
  value: string | null;
  onChange: (id: string | null, user: UserOption | null) => void;
  token: string;
  placeholder?: string;
  disabled?: boolean;
}

const MIN_CHARS = 3;
const DEBOUNCE_MS = 300;

export function UserCombobox({
  value,
  onChange,
  token,
  placeholder = "Search by name…",
  disabled = false,
}: UserComboboxProps) {
  const [open, setOpen] = React.useState(false);
  const [query, setQuery] = React.useState("");
  const [results, setResults] = React.useState<UserOption[]>([]);
  const [loading, setLoading] = React.useState(false);
  const [selectedUser, setSelectedUser] = React.useState<UserOption | null>(null);
  const containerRef = React.useRef<HTMLDivElement>(null);

  // Fetch selected user details when value is set externally
  React.useEffect(() => {
    if (!value || !token) return;
    if (selectedUser?.id === value) return;
    api<UserOption>(`/api/users/${value}`, { token })
      .then((u) => setSelectedUser(u))
      .catch(() => setSelectedUser(null));
  }, [value, token]); // eslint-disable-line react-hooks/exhaustive-deps

  // Debounced search
  React.useEffect(() => {
    if (query.length < MIN_CHARS) {
      setResults([]);
      return;
    }
    setLoading(true);
    const timer = setTimeout(() => {
      api<UserOption[]>(`/api/users?search=${encodeURIComponent(query)}`, { token })
        .then((data) => setResults(data))
        .catch(() => setResults([]))
        .finally(() => setLoading(false));
    }, DEBOUNCE_MS);
    return () => clearTimeout(timer);
  }, [query, token]);

  // Close on outside click
  React.useEffect(() => {
    function handle(e: MouseEvent) {
      if (containerRef.current && !containerRef.current.contains(e.target as Node)) {
        setOpen(false);
      }
    }
    document.addEventListener("mousedown", handle);
    return () => document.removeEventListener("mousedown", handle);
  }, []);

  function handleSelect(user: UserOption) {
    setSelectedUser(user);
    onChange(user.id, user);
    setQuery("");
    setOpen(false);
  }

  function handleClear(e: React.MouseEvent) {
    e.stopPropagation();
    setSelectedUser(null);
    onChange(null, null);
    setQuery("");
  }

  const charsNeeded = MIN_CHARS - query.length;

  return (
    <div ref={containerRef} className="relative w-full">
      <div
        className={cn(
          "flex items-center h-9 w-full rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm transition-colors",
          disabled ? "opacity-50 cursor-not-allowed" : "cursor-pointer hover:border-[#B12B35]/50"
        )}
        onClick={() => !disabled && setOpen((o) => !o)}
      >
        {selectedUser ? (
          <span className="flex-1 truncate text-foreground">
            {selectedUser.full_name}
            <span className="ml-1 text-xs text-muted-foreground">({selectedUser.role})</span>
          </span>
        ) : (
          <span className="flex-1 text-muted-foreground">{placeholder}</span>
        )}
        {selectedUser ? (
          <X
            className="h-3.5 w-3.5 text-muted-foreground hover:text-foreground ml-1 shrink-0"
            onClick={handleClear}
          />
        ) : (
          <ChevronsUpDown className="h-3.5 w-3.5 text-muted-foreground ml-1 shrink-0" />
        )}
      </div>

      {open && !disabled && (
        <div className="absolute z-50 mt-1 w-full rounded-md border bg-popover shadow-md">
          <div className="p-2">
            <input
              autoFocus
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              placeholder="Type to search…"
              className="w-full rounded border border-input bg-transparent px-2 py-1 text-sm outline-none placeholder:text-muted-foreground"
            />
          </div>

          <div className="max-h-48 overflow-y-auto">
            {loading && (
              <div className="flex items-center gap-2 px-3 py-2 text-sm text-muted-foreground">
                <Loader2 className="h-3.5 w-3.5 animate-spin" />
                Searching…
              </div>
            )}

            {!loading && query.length > 0 && query.length < MIN_CHARS && (
              <p className="px-3 py-2 text-xs text-muted-foreground">
                Type {charsNeeded} more character{charsNeeded !== 1 ? "s" : ""} to search
              </p>
            )}

            {!loading && query.length >= MIN_CHARS && results.length === 0 && (
              <p className="px-3 py-2 text-xs text-muted-foreground">No users found</p>
            )}

            {results.map((user) => (
              <div
                key={user.id}
                className="flex items-center gap-2 px-3 py-2 text-sm cursor-pointer hover:bg-accent"
                onMouseDown={() => handleSelect(user)}
              >
                <Check
                  className={cn("h-3.5 w-3.5 shrink-0", value === user.id ? "opacity-100" : "opacity-0")}
                />
                <span className="flex-1 truncate">{user.full_name}</span>
                <span className="text-xs text-muted-foreground capitalize">{user.role.replace("_", " ")}</span>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}
