"use client";

import { useState, type ReactNode } from "react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

/**
 * App-wide TanStack Query provider.
 *
 * Caching strategy ("balanced"):
 *  - staleTime 30s  — cached data is shown instantly on revisit; a background
 *    refetch only happens once the data is older than 30s.
 *  - refetchOnWindowFocus / refetchOnReconnect — silently pull fresh data when
 *    the user returns to the tab or regains connectivity, so the UI stays current.
 *  - retry 1 — one quick retry on a failed request, then surface the error.
 *
 * The QueryClient is created inside useState so it is instantiated once per
 * browser session and never recreated on re-render.
 */
export function QueryProvider({ children }: { children: ReactNode }) {
  const [queryClient] = useState(
    () =>
      new QueryClient({
        defaultOptions: {
          queries: {
            staleTime: 30_000,
            gcTime: 5 * 60_000,
            refetchOnWindowFocus: true,
            refetchOnReconnect: true,
            retry: 1,
          },
        },
      })
  );

  return (
    <QueryClientProvider client={queryClient}>{children}</QueryClientProvider>
  );
}
