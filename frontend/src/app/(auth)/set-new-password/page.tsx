"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { createClient } from "@/lib/supabase/client";
import { toast } from "sonner";
import Link from "next/link";

export default function SetNewPasswordPage() {
  const router = useRouter();
  const [ready, setReady] = useState(false);
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    const supabase = createClient();
    let resolved = false;

    const resolve = () => {
      resolved = true;
      setReady(true);
    };

    // 1. Check if there's already a valid session (token was processed)
    supabase.auth.getSession().then(({ data }) => {
      if (data.session) resolve();
    });

    // 2. Listen for PASSWORD_RECOVERY event — fires when Supabase processes
    //    the #access_token=...&type=recovery hash on this page
    const { data: { subscription } } = supabase.auth.onAuthStateChange((event, session) => {
      if ((event === "PASSWORD_RECOVERY" || event === "SIGNED_IN") && session) {
        resolve();
      }
    });

    // 3. Fallback timeout — if nothing fires in 5s, link is invalid/expired
    const timeout = setTimeout(() => {
      if (!resolved) {
        toast.error("Reset link is invalid or has expired. Please request a new one.");
        router.replace("/forgot-password");
      }
    }, 5000);

    return () => {
      subscription.unsubscribe();
      clearTimeout(timeout);
    };
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [router]);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (newPassword.length < 8) {
      toast.error("Password must be at least 8 characters long.");
      return;
    }
    if (newPassword === "Txcatalyst@123") {
      toast.error("Please choose a password different from the initial one.");
      return;
    }
    if (newPassword !== confirmPassword) {
      toast.error("Passwords do not match.");
      return;
    }

    setSubmitting(true);
    try {
      const supabase = createClient();
      const { error } = await supabase.auth.updateUser({ password: newPassword });
      if (error) throw error;
      toast.success("Password updated successfully. Please sign in.");
      router.replace("/login");
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : "Failed to update password.";
      toast.error(message);
    } finally {
      setSubmitting(false);
    }
  }

  if (!ready) {
    return (
      <div className="flex items-center justify-center py-12 text-sm text-[#5D5D5D]">
        Verifying reset link…
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-[#232222] leading-tight">
          Set a new password
        </h2>
        <p className="text-sm text-[#5D5D5D] mt-1">
          Choose a strong password for your account.
        </p>
      </div>

      <form onSubmit={handleSubmit} className="space-y-4">
        <div className="space-y-1.5">
          <Label htmlFor="new-password" className="text-sm font-medium text-[#232222]">
            New Password
          </Label>
          <Input
            id="new-password"
            type="password"
            placeholder="At least 8 characters"
            value={newPassword}
            onChange={(e) => setNewPassword(e.target.value)}
            required
            minLength={8}
            autoComplete="new-password"
            className="h-10 border-[#C5C5C5] bg-white focus-visible:border-[#B12B35] focus-visible:ring-[#B12B35]/20 placeholder:text-[#C5C5C5]"
          />
        </div>

        <div className="space-y-1.5">
          <Label htmlFor="confirm-password" className="text-sm font-medium text-[#232222]">
            Confirm New Password
          </Label>
          <Input
            id="confirm-password"
            type="password"
            placeholder="Re-enter password"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            required
            minLength={8}
            autoComplete="new-password"
            className="h-10 border-[#C5C5C5] bg-white focus-visible:border-[#B12B35] focus-visible:ring-[#B12B35]/20 placeholder:text-[#C5C5C5]"
          />
        </div>

        <Button
          type="submit"
          className="w-full h-11 text-base font-semibold bg-[#B12B35] hover:bg-[#9a2330] text-white rounded-lg mt-2 transition-colors"
          disabled={submitting}
        >
          {submitting ? "Updating…" : "Update Password"}
        </Button>
      </form>

      <Link
        href="/login"
        className="flex items-center justify-center w-full h-10 rounded-lg border border-[#B12B35] text-[#B12B35] text-sm font-semibold hover:bg-[#B12B35]/5 transition-colors"
      >
        Back to Sign In
      </Link>
    </div>
  );
}
