"use client";

import * as React from "react";
import { ChevronDown, Loader2 } from "lucide-react";
import { cn } from "@/lib/utils";
import { api } from "@/lib/api";
import type { Account } from "@/types";

const MIN_CHARS = 3;
const DEBOUNCE_MS = 300;

type AccountComboboxProps = {
  token: string;
  value: string;
  onChange: (accountId: string) => void;
  name: string;
  placeholder?: string;
  required?: boolean;
  disabled?: boolean;
  className?: string;
};

export function AccountCombobox({
  token,
  value,
  onChange,
  name,
  placeholder = "Type at least 3 characters to search...",
  required,
  disabled,
  className,
}: AccountComboboxProps) {
  const [open, setOpen] = React.useState(false);
  const [query, setQuery] = React.useState("");
  const [results, setResults] = React.useState<Account[]>([]);
  const [loading, setLoading] = React.useState(false);
  const [selectedName, setSelectedName] = React.useState("");
  const containerRef = React.useRef<HTMLDivElement>(null);
  const debounceRef = React.useRef<ReturnType<typeof setTimeout> | null>(null);

  // Search backend when query reaches MIN_CHARS, debounced
  React.useEffect(() => {
    if (debounceRef.current) clearTimeout(debounceRef.current);

    if (query.trim().length < MIN_CHARS) {
      setResults([]);
      setLoading(false);
      return;
    }

    setLoading(true);
    debounceRef.current = setTimeout(async () => {
      try {
        const data = await api<Account[]>(
          `/api/accounts?search=${encodeURIComponent(query.trim())}`,
          { token }
        );
        setResults(data);
      } catch {
        setResults([]);
      } finally {
        setLoading(false);
      }
    }, DEBOUNCE_MS);

    return () => {
      if (debounceRef.current) clearTimeout(debounceRef.current);
    };
  }, [query, token]);

  // Close on outside click
  React.useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (
        containerRef.current &&
        !containerRef.current.contains(e.target as Node)
      ) {
        setOpen(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const inputValue = open ? query : selectedName;

  function handleSelect(account: Account) {
    onChange(account.account_id);
    setSelectedName(account.account_name);
    setQuery("");
    setOpen(false);
  }

  function handleInputChange(e: React.ChangeEvent<HTMLInputElement>) {
    const val = e.target.value;
    setQuery(val);
    setOpen(true);
    if (!val) {
      onChange("");
      setSelectedName("");
    }
  }

  const showDropdown = open && query.trim().length >= MIN_CHARS;

  return (
    <div ref={containerRef} className={cn("relative", className)}>
      <input type="hidden" name={name} value={value} readOnly aria-hidden />
      <div className="relative">
        <input
          type="text"
          value={inputValue}
          onChange={handleInputChange}
          onFocus={() => setOpen(true)}
          onBlur={() => {
            // Delay so click on option fires first
            setTimeout(() => setOpen(false), 150);
          }}
          placeholder={placeholder}
          required={required && !value}
          disabled={disabled}
          className={cn(
            "flex h-10 w-full rounded-lg border border-input bg-transparent px-3 py-2 pr-9 text-sm transition-colors outline-none",
            "placeholder:text-muted-foreground focus-visible:border-ring focus-visible:ring-2 focus-visible:ring-ring/50",
            "disabled:cursor-not-allowed disabled:opacity-50",
            "dark:bg-input/30"
          )}
          autoComplete="off"
        />
        {loading ? (
          <Loader2 className="absolute right-2 top-1/2 h-4 w-4 -translate-y-1/2 shrink-0 text-muted-foreground animate-spin" />
        ) : (
          <ChevronDown
            className="absolute right-2 top-1/2 h-4 w-4 -translate-y-1/2 shrink-0 text-muted-foreground pointer-events-none"
            aria-hidden
          />
        )}
      </div>

      {/* Hint shown while user hasn't typed enough */}
      {open && query.trim().length > 0 && query.trim().length < MIN_CHARS && (
        <div className="absolute z-50 mt-1 w-full rounded-lg border border-input bg-popover px-2.5 py-2 text-xs text-muted-foreground shadow-md">
          Type {MIN_CHARS - query.trim().length} more character
          {MIN_CHARS - query.trim().length > 1 ? "s" : ""} to search…
        </div>
      )}

      {showDropdown && (
        <ul
          className="absolute z-50 mt-1 max-h-60 min-w-full w-max max-w-[480px] overflow-auto rounded-lg border border-input bg-popover py-1 text-popover-foreground shadow-lg"
          role="listbox"
        >
          {loading ? (
            <li className="flex items-center gap-2 px-3 py-2.5 text-sm text-muted-foreground">
              <Loader2 className="h-3 w-3 animate-spin" /> Searching…
            </li>
          ) : results.length === 0 ? (
            <li className="px-3 py-2.5 text-sm text-muted-foreground">
              No accounts found for &ldquo;{query}&rdquo;.
            </li>
          ) : (
            results.map((a) => (
              <li
                key={a.account_id}
                role="option"
                aria-selected={value === a.account_id}
                className={cn(
                  "cursor-pointer px-3 py-2.5 text-sm outline-none hover:bg-accent hover:text-accent-foreground",
                  value === a.account_id && "bg-accent text-accent-foreground"
                )}
                onMouseDown={(e) => {
                  e.preventDefault();
                  handleSelect(a);
                }}
              >
                <span className="font-medium">{a.account_name}</span>
                {(a.industry || a.region) && (
                  <div className="text-xs text-muted-foreground mt-0.5">
                    {[a.industry, a.region].filter(Boolean).join(" · ")}
                  </div>
                )}
              </li>
            ))
          )}
        </ul>
      )}
    </div>
  );
}
