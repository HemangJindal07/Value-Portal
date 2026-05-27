import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

/** True only for http(s) URLs — used to avoid rendering javascript:/data: links. */
export function isHttpUrl(u: string | null | undefined): boolean {
  return !!u && /^https?:\/\//i.test(u);
}

/**
 * Format a monetary amount with the currency's own symbol (₹, $, £, …) — never
 * the currency name/code. Uses Intl narrow symbols; "OTH" (and any unknown code)
 * falls back to a plain number with no prefix. Returns "—" when value is empty.
 */
export function formatMoney(
  value: number | string | null | undefined,
  currency: string | null | undefined,
): string {
  if (value === null || value === undefined || value === "") return "—";
  const amount = Number(value);
  if (Number.isNaN(amount)) return "—";
  const code = (currency || "USD").toUpperCase();
  const plain = amount.toLocaleString(undefined, { maximumFractionDigits: 2 });
  if (code === "OTH") return plain;
  try {
    return new Intl.NumberFormat(undefined, {
      style: "currency",
      currency: code,
      currencyDisplay: "narrowSymbol",
      minimumFractionDigits: 0,
      maximumFractionDigits: 2,
    }).format(amount);
  } catch {
    return plain;
  }
}
