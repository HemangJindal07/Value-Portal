"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import { toast } from "sonner";

export default function ResetPasswordPage() {
  const { user, token, loading, refreshProfile, signOut } = useAuth();
  const router = useRouter();

  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (loading) return;
    if (!user || !token) {
      router.replace("/login");
      return;
    }
    if (user.must_reset_password === false) {
      router.replace("/");
    }
  }, [user, token, loading, router]);

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
      await api("/api/auth/reset-password", {
        method: "POST",
        body: { new_password: newPassword },
        token: token!,
      });
      await refreshProfile();
      toast.success("Password updated. Welcome to Tx-Catalyst.");
      router.replace("/");
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : "Failed to reset password.";
      toast.error(message);
    } finally {
      setSubmitting(false);
    }
  }

  async function handleSignOut() {
    await signOut();
    router.replace("/login");
  }

  if (loading || !user) {
    return (
      <div className="flex items-center justify-center py-12 text-sm text-[#5D5D5D]">
        Loading…
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-[#232222] leading-tight">
          Set Your Password
        </h2>
        <p className="text-sm text-[#5D5D5D] mt-1">
          Welcome, {user.full_name}. Please choose a new password to continue.
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
          {submitting ? "Updating…" : "Update Password & Continue"}
        </Button>
      </form>

      <button
        type="button"
        onClick={handleSignOut}
        className="text-xs text-[#5D5D5D] hover:text-[#B12B35] underline"
      >
        Sign out
      </button>
    </div>
  );
}
