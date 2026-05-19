import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";

// Routes that require a specific set of roles.
// Patterns are matched in order; first match wins.
// NOTE: `POST /api/accounts` (inline quick-add) is open to every authenticated
// role — only the standalone /accounts/new and /accounts/{id}/edit *pages* are
// gated here so URL manipulation cannot reach the full admin-only forms.
const PROTECTED_ROUTES: { pattern: RegExp; allowedRoles: string[] }[] = [
  {
    // All /admin/* pages — admin only (unchanged)
    pattern: /^\/admin(\/|$)/,
    allowedRoles: ["admin"],
  },
  {
    // Executive Exception Queue — read-only org-wide context surfaced via the
    // executive dashboard's "Routing Exceptions" tile. Admin + executive only.
    pattern: /^\/executive\/exception-queue(\/|$)/,
    allowedRoles: ["admin", "executive"],
  },
  {
    // New account page and account edit page — admin, executive, sales only
    // Must come before the accounts list/detail rule (more specific first)
    pattern: /^\/accounts\/(new|[^/]+\/edit)$/,
    allowedRoles: ["admin", "executive", "sales"],
  },
  {
    // Accounts list and account detail — admin, executive, sales only
    // user and practice_lead are redirected to / if they type this URL directly
    pattern: /^\/accounts(\/[^/]+)?$/,
    allowedRoles: ["admin", "executive", "sales"],
  },
  {
    // Reviews page — admin and executive only
    pattern: /^\/reviews(\/|$)/,
    allowedRoles: ["admin", "executive"],
  },
];

function matchProtectedRoute(pathname: string) {
  for (const route of PROTECTED_ROUTES) {
    if (route.pattern.test(pathname)) {
      return route.allowedRoles;
    }
  }
  return null;
}

export async function updateSession(request: NextRequest) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

  if (!supabaseUrl || !supabaseAnonKey) {
    return NextResponse.next({ request });
  }

  let supabaseResponse = NextResponse.next({ request });

  const supabase = createServerClient(supabaseUrl, supabaseAnonKey, {
    cookies: {
      getAll() {
        return request.cookies.getAll();
      },
      setAll(cookiesToSet) {
        cookiesToSet.forEach(({ name, value }) =>
          request.cookies.set(name, value)
        );
        supabaseResponse = NextResponse.next({ request });
        cookiesToSet.forEach(({ name, value, options }) =>
          supabaseResponse.cookies.set(name, value, {
            ...options,
            httpOnly: true,
            sameSite: "lax",
            // secure is set to true only in production (HTTPS); in local HTTP dev it would block the cookie
            secure: process.env.NODE_ENV === "production",
          })
        );
      },
    },
  });

  const pathname = request.nextUrl.pathname;
  const isAuthPage =
    pathname.startsWith("/login") || pathname.startsWith("/register");

  try {
    const {
      data: { user },
    } = await supabase.auth.getUser();

    if (!user && !isAuthPage) {
      const url = request.nextUrl.clone();
      url.pathname = "/login";
      return NextResponse.redirect(url);
    }

    if (user && isAuthPage) {
      const url = request.nextUrl.clone();
      url.pathname = "/";
      return NextResponse.redirect(url);
    }

    // Role-based route protection — only runs when user is authenticated
    if (user) {
      const allowedRoles = matchProtectedRoute(pathname);
      if (allowedRoles) {
        // Fetch the user's role from their profile
        const { data: profile } = await supabase
          .from("profiles")
          .select("role")
          .eq("id", user.id)
          .single();

        const userRole: string | undefined = profile?.role;

        if (!userRole || !allowedRoles.includes(userRole)) {
          // Redirect unauthorised users to the dashboard root
          const url = request.nextUrl.clone();
          url.pathname = "/";
          return NextResponse.redirect(url);
        }
      }
    }
  } catch {
    // Edge runtime network failure — let the request through.
    // Client-side auth context will handle session validation.
    if (isAuthPage) {
      return supabaseResponse;
    }
  }

  return supabaseResponse;
}
