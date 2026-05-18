"use client";

import {
  createContext,
  useContext,
  useEffect,
  useState,
  useCallback,
  type ReactNode,
} from "react";
import { createClient } from "@/lib/supabase/client";
import { api } from "@/lib/api";
import type { Profile } from "@/types";

type AuthState = {
  user: Profile | null;
  token: string | null;
  loading: boolean;
  signIn: (email: string, password: string) => Promise<void>;
  signUp: (email: string, password: string, fullName: string) => Promise<void>;
  signOut: () => Promise<void>;
  refreshProfile: () => Promise<void>;
};

const AuthContext = createContext<AuthState | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<Profile | null>(null);
  const [token, setToken] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  const fetchProfile = useCallback(async (accessToken: string) => {
    try {
      const profile = await api<Profile>("/api/auth/me", {
        token: accessToken,
      });
      setUser(profile);
      setToken(accessToken);
    } catch (err: unknown) {
      // Profile fetch failed — token was valid but profile is missing from DB
      // (e.g. admin deleted the user). Force sign-out and redirect.
      // Only redirect if we actually had a token (not a normal logged-out state).
      console.warn("[AUTH] fetchProfile failed — profile missing or invalid token:", err);
      const supabase = createClient();
      const { data: { session } } = await supabase.auth.getSession();
      if (session) {
        // Had a live session but no profile — force full sign-out
        await supabase.auth.signOut();
        setUser(null);
        setToken(null);
        window.location.href = "/login";
      } else {
        // No session — just clear state quietly (normal post-logout state)
        setUser(null);
        setToken(null);
      }
    }
  }, []);

  useEffect(() => {
    if (typeof window === "undefined") return;

    const hash = window.location.hash;

    // Expired/invalid reset link — redirect immediately before anything else
    if (hash.includes("error=access_denied") || hash.includes("error_code=otp_expired")) {
      window.location.href = "/forgot-password?expired=1";
      return;
    }

    // PASSWORD_RECOVERY token in hash — Supabase lands on Site URL (root /)
    // with the token in the hash. Detect it here before onAuthStateChange
    // can miss it due to timing, and redirect immediately.
    if (hash.includes("type=recovery") || (hash.includes("access_token") && hash.includes("type=recovery"))) {
      window.location.href = "/set-new-password" + hash;
      return;
    }
  }, []);

  useEffect(() => {
    const supabase = createClient();

    supabase.auth.getUser().then(({ data: { user }, error }) => {
      if (error?.code === "refresh_token_not_found" || error?.message?.includes("Refresh Token")) {
        supabase.auth.signOut().finally(() => setLoading(false));
        return;
      }
      if (user) {
        supabase.auth.getSession().then(({ data: { session } }) => {
          if (session?.access_token) {
            fetchProfile(session.access_token).finally(() => setLoading(false));
          } else {
            setLoading(false);
          }
        });
      } else {
        setLoading(false);
      }
    }).catch(() => setLoading(false));

    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((event, session) => {
      if (event === "PASSWORD_RECOVERY") {
        // Supabase fired the recovery token — send user to set-new-password
        // regardless of which page they landed on (usually the root /).
        window.location.href = "/set-new-password";
        return;
      }
      if (event === "TOKEN_REFRESHED" && !session) {
        supabase.auth.signOut();
        setUser(null);
        setToken(null);
        return;
      }
      if (session?.access_token) {
        fetchProfile(session.access_token);
      } else {
        setUser(null);
        setToken(null);
      }
    });

    return () => subscription.unsubscribe();
  }, [fetchProfile]);

  // ── Auto-logout after 40 minutes of inactivity ──────────────────────────
  useEffect(() => {
    if (!user) return;

    const IDLE_TIMEOUT = 40 * 60 * 1000; // 40 minutes
    let timer: ReturnType<typeof setTimeout>;

    const resetTimer = () => {
      clearTimeout(timer);
      timer = setTimeout(async () => {
        const supabase = createClient();
        await supabase.auth.signOut();
        setUser(null);
        setToken(null);
        window.location.href = "/login";
      }, IDLE_TIMEOUT);
    };

    const events = ["mousedown", "keydown", "scroll", "touchstart", "mousemove"];
    events.forEach((e) => window.addEventListener(e, resetTimer, { passive: true }));
    resetTimer();

    return () => {
      clearTimeout(timer);
      events.forEach((e) => window.removeEventListener(e, resetTimer));
    };
  }, [user]);

  const signIn = async (email: string, password: string) => {
    const key = `_fl_${email.toLowerCase()}`;
    const raw = sessionStorage.getItem(key);
    if (raw) {
      const entry = JSON.parse(raw) as { count: number; until: number };
      if (entry.until && Date.now() < entry.until) {
        const mins = Math.ceil((entry.until - Date.now()) / 60000);
        throw new Error(`Too many failed attempts. Please wait ${mins} minute(s) before trying again.`);
      }
    }

    const supabase = createClient();
    const { error } = await supabase.auth.signInWithPassword({ email, password });

    if (error) {
      const stored = raw ? JSON.parse(raw) as { count: number; until: number } : { count: 0, until: 0 };
      stored.count += 1;
      if (stored.count >= 5) {
        stored.until = Date.now() + 15 * 60 * 1000;
      }
      sessionStorage.setItem(key, JSON.stringify(stored));
      throw new Error("Invalid email or password.");
    }

    sessionStorage.removeItem(key);
  };

  const signUp = async (
    email: string,
    password: string,
    fullName: string
  ) => {
    const supabase = createClient();
    const { error } = await supabase.auth.signUp({
      email,
      password,
      options: { data: { full_name: fullName } },
    });
    if (error) {
      const msg = error.message?.toLowerCase() ?? "";
      if (msg.includes("already") || msg.includes("registered") || msg.includes("taken")) {
        throw new Error("If this email is available, your account has been created.");
      }
      throw new Error("Registration failed. Please try again.");
    }
  };

  const signOut = async () => {
    const supabase = createClient();
    // scope: 'local' wipes the browser session immediately so the cookie is
    // gone before the page redirects — prevents the 307 redirect loop back to /
    await supabase.auth.signOut({ scope: "local" });
    setUser(null);
    setToken(null);
  };

  const refreshProfile = async () => {
    if (token) {
      await fetchProfile(token);
    }
  };

  return (
    <AuthContext.Provider
      value={{ user, token, loading, signIn, signUp, signOut, refreshProfile }}
    >
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
}
