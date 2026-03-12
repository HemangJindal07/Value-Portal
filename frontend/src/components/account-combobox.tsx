"use client";

import * as React from "react";
import { ChevronDown } from "lucide-react";
import { Input } from "@/components/ui/input";
import { cn } from "@/lib/utils";
import type { Account } from "@/types";

type AccountComboboxProps = {
  accounts: Account[];
  value: string;
  onChange: (accountId: string) => void;
  name: string;
  placeholder?: string;
  required?: boolean;
  disabled?: boolean;
  className?: string;
};

export function AccountCombobox({
  accounts,
  value,
  onChange,
  name,
  placeholder = "Select or type to search account...",
  required,
  disabled,
  className,
}: AccountComboboxProps) {
  const [open, setOpen] = React.useState(false);
  const [query, setQuery] = React.useState("");
  const containerRef = React.useRef<HTMLDivElement>(null);

  const selectedAccount = value
    ? accounts.find((a) => a.account_id === value)
    : null;
  const displayText = selectedAccount?.account_name ?? "";

  const filtered = React.useMemo(() => {
    if (!query.trim()) return accounts;
    const q = query.toLowerCase();
    return accounts.filter(
      (a) =>
        a.account_name?.toLowerCase().includes(q) ||
        a.industry?.toLowerCase().includes(q) ||
        a.region?.toLowerCase().includes(q)
    );
  }, [accounts, query]);

  React.useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (containerRef.current && !containerRef.current.contains(e.target as Node)) {
        setOpen(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const inputValue = open ? query : displayText;

  return (
    <div ref={containerRef} className={cn("relative", className)}>
      <input type="hidden" name={name} value={value} readOnly aria-hidden />
      <div className="relative">
        <input
          type="text"
          value={inputValue}
          onChange={(e) => {
            setQuery(e.target.value);
            setOpen(true);
            if (!e.target.value) onChange("");
          }}
          onFocus={() => setOpen(true)}
          onBlur={() => {
            // Delay so click on option can fire first
            setTimeout(() => setOpen(false), 150);
          }}
          placeholder={placeholder}
          required={required && !value}
          disabled={disabled}
          className={cn(
            "flex h-8 w-full rounded-lg border border-input bg-transparent px-2.5 py-1 pr-8 text-sm transition-colors outline-none",
            "placeholder:text-muted-foreground focus-visible:border-ring focus-visible:ring-2 focus-visible:ring-ring/50",
            "disabled:cursor-not-allowed disabled:opacity-50",
            "dark:bg-input/30"
          )}
          autoComplete="off"
        />
        <ChevronDown
          className="absolute right-2 top-1/2 h-4 w-4 -translate-y-1/2 shrink-0 text-muted-foreground pointer-events-none"
          aria-hidden
        />
      </div>
      {open && (
        <ul
          className="absolute z-50 mt-1 max-h-48 w-full overflow-auto rounded-lg border border-input bg-popover py-1 text-popover-foreground shadow-md"
          role="listbox"
        >
          {filtered.length === 0 ? (
            <li className="px-2.5 py-2 text-sm text-muted-foreground">
              No account found. Select from list or create one in Accounts.
            </li>
          ) : (
            filtered.map((a) => (
              <li
                key={a.account_id}
                role="option"
                aria-selected={value === a.account_id}
                className={cn(
                  "cursor-pointer px-2.5 py-2 text-sm outline-none hover:bg-accent hover:text-accent-foreground",
                  value === a.account_id && "bg-accent text-accent-foreground"
                )}
                onMouseDown={(e) => {
                  e.preventDefault();
                  onChange(a.account_id);
                  setQuery("");
                  setOpen(false);
                }}
              >
                {a.account_name}
                {(a.industry || a.region) && (
                  <span className="ml-2 text-xs text-muted-foreground">
                    {[a.industry, a.region].filter(Boolean).join(" · ")}
                  </span>
                )}
              </li>
            ))
          )}
        </ul>
      )}
    </div>
  );
}
