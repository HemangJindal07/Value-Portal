"use client";

import * as React from "react";
import { createPortal } from "react-dom";
import { ChevronDown, Loader2, Plus, X } from "lucide-react";
import { cn } from "@/lib/utils";
import { api } from "@/lib/api";
import { toast } from "sonner";
import type { Account } from "@/types";

const MIN_CHARS = 3;
const DEBOUNCE_MS = 300;

const REGIONS = ["North America", "EMEA", "APAC"];

const INDUSTRIES = [
  "Banking & Financial Services",
  "Credit Unions",
  "Education & EduTech",
  "Gaming",
  "Insurance",
  "Non-Profit & Public Sector",
  "Healthcare & Life Sciences",
  "Energy & Utilities",
  "QSR",
  "Retail & e-commerce",
  "ISV & High Tech",
  "Travel & Logistics",
  "Media & Entertainment",
  "Telecom",
  "Manufacturing & Logistics",
  "Others",
];

type AccountComboboxProps = {
  token: string;
  value: string;
  onChange: (accountId: string) => void;
  onAccountSelected?: (account: Account, isNew: boolean) => void;
  onCleared?: () => void;
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
  onAccountSelected,
  onCleared,
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
  const [dropdownStyle, setDropdownStyle] = React.useState<React.CSSProperties>({});
  const containerRef = React.useRef<HTMLDivElement>(null);
  const inputRef = React.useRef<HTMLInputElement>(null);
  const debounceRef = React.useRef<ReturnType<typeof setTimeout> | null>(null);

  // ── Quick-add modal state ─────────────────────────────────────────────────
  const [modalOpen, setModalOpen] = React.useState(false);
  const [newName, setNewName] = React.useState("");
  const [newIndustry, setNewIndustry] = React.useState("");
  const [newRegion, setNewRegion] = React.useState("");
  const [creating, setCreating] = React.useState(false);
  const [createError, setCreateError] = React.useState("");
  const [createSuccessMsg, setCreateSuccessMsg] = React.useState("");

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

  // Resolve the display name when a value is supplied externally (e.g. the
  // account_id arrives as a URL param) but no account has been picked in this
  // session yet. Without this the input would render blank / placeholder even
  // though an account is selected. Skipped while the dropdown is open so it
  // never overwrites what the user is actively typing.
  React.useEffect(() => {
    if (!value || !token || open) return;
    // Already showing the right account — nothing to do.
    if (selectedName) return;
    let cancelled = false;
    (async () => {
      try {
        const acct = await api<Account>(`/api/accounts/${value}`, { token });
        if (!cancelled && acct?.account_name) {
          setSelectedName(acct.account_name);
        }
      } catch {
        /* leave blank — user can still search */
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [value, token, selectedName, open]);

  // Close on outside click (but not when modal is open)
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

  function updateDropdownPosition() {
    if (!inputRef.current) return;
    const rect = inputRef.current.getBoundingClientRect();
    setDropdownStyle({
      position: "fixed",
      top: rect.bottom + 4,
      left: rect.left,
      width: rect.width,
      zIndex: 9999,
    });
  }

  const inputValue = open ? query : selectedName;

  function handleSelect(account: Account) {
    onChange(account.account_id);
    setSelectedName(account.account_name);
    setQuery("");
    setOpen(false);
    onAccountSelected?.(account, false);
  }

  function handleInputChange(e: React.ChangeEvent<HTMLInputElement>) {
    const val = e.target.value;
    setQuery(val);
    updateDropdownPosition();
    setOpen(true);
    // Clear the prior selection when the box is emptied OR when the user
    // edits the query while an account was already selected (the old pick
    // is stale until they choose again — keeps the derived Account Type
    // from showing the previous account's type).
    if (!val || value) {
      onChange("");
      setSelectedName("");
      onCleared?.();
    }
  }

  function openModal() {
    setNewName(query.trim());
    setNewIndustry("");
    setNewRegion("");
    setCreateError("");
    setCreateSuccessMsg("");
    setOpen(false);
    setModalOpen(true);
  }

  function closeModal() {
    setModalOpen(false);
    setCreateError("");
    setCreateSuccessMsg("");
  }

  async function handleCreate(e: React.SyntheticEvent<HTMLFormElement>) {
    // Stop the event from bubbling to the parent form (the leads form),
    // which would otherwise fire its own onSubmit handler.
    e.preventDefault();
    e.stopPropagation();
    const name = newName.trim();
    if (!name) return;
    if (!newRegion) { setCreateError("Please select a region."); return; }
    if (!newIndustry) { setCreateError("Please select an industry."); return; }
    setCreating(true);
    setCreateError("");
    setCreateSuccessMsg("");

    const payload = {
      account_name: name,
      industry: newIndustry,
      region: newRegion,
      account_status: "prospect",
    };
    console.log("[AccountCombobox] Submitting create:", payload, "| token present:", !!token);

    try {
      const account = await api<Account>("/api/accounts", {
        method: "POST",
        token,
        body: payload,
      });
      console.log("[AccountCombobox] ✅ Account created:", account);

      if (!account?.account_id) {
        throw new Error("Server returned an invalid response — account_id missing.");
      }

      setCreateSuccessMsg(`"${account.account_name}" created successfully!`);
      toast.success(`Account "${account.account_name}" created successfully.`);
      setTimeout(() => {
        onChange(account.account_id);
        setSelectedName(account.account_name);
        setQuery("");
        onAccountSelected?.(account, true);
        closeModal();
      }, 900);
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : "Failed to create account.";
      console.error("[AccountCombobox] ❌ Create failed:", msg);
      setCreateError(msg);
    } finally {
      setCreating(false);
    }
  }

  const showDropdown = open && query.trim().length >= MIN_CHARS;

  return (
    <>
      <div ref={containerRef} className={cn("relative", className)}>
        <input type="hidden" name={name} value={value} readOnly aria-hidden />
        <div className="relative">
          <input
            ref={inputRef}
            type="text"
            value={inputValue}
            onChange={handleInputChange}
            onFocus={() => { updateDropdownPosition(); setOpen(true); }}
            onBlur={() => setTimeout(() => setOpen(false), 150)}
            placeholder={placeholder}
            required={required && !value}
            disabled={disabled}
            className={cn(
              "flex h-10 w-full rounded-lg border border-input bg-transparent px-3 py-2 pr-9 text-sm transition-colors outline-none",
              "placeholder:text-muted-foreground focus-visible:border-ring focus-visible:ring-2 focus-visible:ring-ring/50",
              "disabled:cursor-not-allowed disabled:opacity-50",
              "dark:bg-input/30",
              value ? "[&:invalid]:border-input [&:invalid]:ring-0" : ""
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

      </div>

      {/* Hint — not enough chars yet, rendered via portal to escape overflow:hidden */}
      {open && query.trim().length > 0 && query.trim().length < MIN_CHARS && createPortal(
        <div style={dropdownStyle} className="rounded-lg border border-[#C5C5C5] bg-white px-2.5 py-2 text-xs text-[#5D5D5D] shadow-lg">
          Type {MIN_CHARS - query.trim().length} more character
          {MIN_CHARS - query.trim().length > 1 ? "s" : ""} to search…
        </div>,
        document.body
      )}

      {/* Results dropdown — rendered via portal to escape Card's overflow:hidden */}
      {showDropdown && createPortal(
        <ul
          style={dropdownStyle}
          className="max-h-60 overflow-auto rounded-lg border border-[#C5C5C5] bg-white py-1 text-[#232222] shadow-xl"
          role="listbox"
        >
          {loading ? (
            <li className="flex items-center gap-2 px-3 py-2.5 text-sm text-[#5D5D5D]">
              <Loader2 className="h-3 w-3 animate-spin" /> Searching…
            </li>
          ) : (
            <>
              {results.length === 0 ? (
                <li className="px-3 py-2.5 text-sm text-[#5D5D5D]">
                  No accounts found for &ldquo;{query}&rdquo;.
                </li>
              ) : (
                results.map((a) => (
                  <li
                    key={a.account_id}
                    role="option"
                    aria-selected={value === a.account_id}
                    className={cn(
                      "cursor-pointer px-3 py-2.5 text-sm outline-none hover:bg-[#F9F9F9]",
                      value === a.account_id && "bg-[#F9F9F9]"
                    )}
                    onMouseDown={(e) => {
                      e.preventDefault();
                      handleSelect(a);
                    }}
                  >
                    <span className="font-medium text-[#232222]">{a.account_name}</span>
                    {(a.industry || a.region) && (
                      <div className="text-xs text-[#5D5D5D] mt-0.5">
                        {[a.industry, a.region].filter(Boolean).join(" · ")}
                      </div>
                    )}
                  </li>
                ))
              )}

              {/* ── Add Account button — always shown at the bottom ── */}
              <li
                className="border-t border-[#EDE7E6] mt-1 pt-1"
                onMouseDown={(e) => {
                  e.preventDefault();
                  openModal();
                }}
              >
                <button
                  type="button"
                  className="flex w-full items-center gap-2 px-3 py-2.5 text-sm font-medium text-[#B12B35] hover:bg-[#B12B35]/5 transition-colors"
                >
                  <Plus className="h-3.5 w-3.5" />
                  Add &ldquo;{query.trim()}&rdquo; as new account
                </button>
              </li>
            </>
          )}
        </ul>,
        document.body
      )}

      {/* ── Quick-add modal — rendered via portal so it's never inside a <form> ── */}
      {modalOpen && createPortal(
        <div
          className="fixed inset-0 z-[200] flex items-center justify-center p-4"
          style={{ background: "rgba(0,0,0,0.45)" }}
        >
          <div
            className="w-full max-w-md rounded-xl bg-white shadow-2xl border border-[#EDE7E6]"
            onMouseDown={(e) => e.stopPropagation()}
          >
            {/* Header */}
            <div className="flex items-center justify-between px-6 py-4 border-b border-[#EDE7E6]">
              <div>
                <h2 className="text-base font-semibold text-[#232222]">Add New Account</h2>
                <p className="text-xs text-[#5D5D5D] mt-0.5">
                  All fields marked <span className="text-[#B12B35]">*</span> are required.
                </p>
              </div>
              <button
                type="button"
                onClick={closeModal}
                className="rounded-lg p-1.5 hover:bg-[#F9F9F9] text-[#5D5D5D] transition-colors"
              >
                <X className="h-4 w-4" />
              </button>
            </div>

            {/* Form */}
            <form onSubmit={handleCreate} className="px-6 py-5 space-y-4">
              {/* Account Name */}
              <div className="space-y-1.5">
                <label className="text-sm font-medium text-[#232222]">
                  Account Name <span className="text-[#B12B35]">*</span>
                </label>
                <input
                  type="text"
                  value={newName}
                  onChange={(e) => setNewName(e.target.value)}
                  placeholder="e.g. Acme Corporation"
                  required
                  autoFocus
                  className="flex h-10 w-full rounded-lg border border-input bg-transparent px-3 py-2 text-sm outline-none transition-colors placeholder:text-muted-foreground focus-visible:border-[#B12B35] focus-visible:ring-2 focus-visible:ring-[#B12B35]/20"
                />
              </div>

              {/* Industry */}
              <div className="space-y-1.5">
                <label className="text-sm font-medium text-[#232222]">
                  Industry <span className="text-[#B12B35]">*</span>
                </label>
                <select
                  value={newIndustry}
                  onChange={(e) => setNewIndustry(e.target.value)}
                  required
                  className="flex h-10 w-full rounded-lg border border-input bg-transparent px-3 py-2 text-sm outline-none transition-colors text-[#232222] focus-visible:border-[#B12B35] focus-visible:ring-2 focus-visible:ring-[#B12B35]/20"
                >
                  <option value="">Select industry…</option>
                  {INDUSTRIES.map((i) => (
                    <option key={i} value={i}>{i}</option>
                  ))}
                </select>
              </div>

              {/* Region */}
              <div className="space-y-1.5">
                <label className="text-sm font-medium text-[#232222]">
                  Region <span className="text-[#B12B35]">*</span>
                </label>
                <select
                  value={newRegion}
                  onChange={(e) => setNewRegion(e.target.value)}
                  required
                  className="flex h-10 w-full rounded-lg border border-input bg-transparent px-3 py-2 text-sm outline-none transition-colors text-[#232222] focus-visible:border-[#B12B35] focus-visible:ring-2 focus-visible:ring-[#B12B35]/20"
                >
                  <option value="">Select region…</option>
                  {REGIONS.map((r) => (
                    <option key={r} value={r}>{r}</option>
                  ))}
                </select>
              </div>

              {createSuccessMsg && (
                <p className="text-sm text-green-700 bg-green-50 border border-green-200 rounded-lg px-3 py-2 flex items-center gap-2">
                  <span className="text-green-500">✓</span> {createSuccessMsg}
                </p>
              )}

              {createError && (
                <p className="text-sm text-[#B12B35] bg-[#B12B35]/5 border border-[#B12B35]/20 rounded-lg px-3 py-2">
                  ✗ {createError}
                </p>
              )}

              {/* Actions */}
              <div className="flex gap-3 pt-1">
                <button
                  type="submit"
                  disabled={creating || !newName.trim() || !newRegion || !newIndustry}
                  className="flex-1 flex items-center justify-center gap-2 rounded-lg bg-[#B12B35] px-4 py-2.5 text-sm font-semibold text-white hover:bg-[#9a2330] disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
                >
                  {creating ? (
                    <><Loader2 className="h-3.5 w-3.5 animate-spin" /> Creating…</>
                  ) : (
                    <><Plus className="h-3.5 w-3.5" /> Create Account</>
                  )}
                </button>
                <button
                  type="button"
                  onClick={closeModal}
                  className="rounded-lg border border-[#EDE7E6] px-4 py-2.5 text-sm font-medium text-[#5D5D5D] hover:border-[#C5C5C5] transition-colors"
                >
                  Cancel
                </button>
              </div>
            </form>
          </div>
        </div>,
        document.body
      )}
    </>
  );
}
