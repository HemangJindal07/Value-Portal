"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { ArrowLeft, Eye, EyeOff } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { api } from "@/lib/api";
import { toast } from "sonner";

type Step = "email" | "otp" | "password";

const inputClass =
  "h-10 border-[#C5C5C5] bg-white focus-visible:border-[#B12B35] focus-visible:ring-[#B12B35]/20 placeholder:text-[#C5C5C5]";

export default function ForgotPasswordPage() {
  const router = useRouter();

  const [step, setStep] = useState<Step>("email");
  const [submitting, setSubmitting] = useState(false);

  const [email, setEmail] = useState("");
  const [code, setCode] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);

  // ── Step 1: request the OTP ──────────────────────────────────────────────
  async function handleRequestOtp(e: React.FormEvent) {
    e.preventDefault();
    setSubmitting(true);
    try {
      await api("/api/auth/forgot-password", {
        method: "POST",
        body: { email: email.trim() },
      });
      toast.success("If an account exists, a reset code has been sent.");
      setStep("otp");
    } catch (err: unknown) {
      const message =
        err instanceof Error ? err.message : "Could not send reset code.";
      toast.error(message);
    } finally {
      setSubmitting(false);
    }
  }

  // ── Step 2: verify the OTP ───────────────────────────────────────────────
  async function handleVerifyOtp(e: React.FormEvent) {
    e.preventDefault();
    if (code.trim().length !== 6) {
      toast.error("Enter the 6-digit code from your email.");
      return;
    }
    setSubmitting(true);
    try {
      await api("/api/auth/verify-otp", {
        method: "POST",
        body: { email: email.trim(), code: code.trim() },
      });
      toast.success("Code verified. Set your new password.");
      setStep("password");
    } catch (err: unknown) {
      const message =
        err instanceof Error ? err.message : "Verification failed.";
      toast.error(message);
    } finally {
      setSubmitting(false);
    }
  }

  // ── Step 3: confirm the new password ─────────────────────────────────────
  async function handleConfirmReset(e: React.FormEvent) {
    e.preventDefault();
    if (newPassword.length < 8) {
      toast.error("Password must be at least 8 characters long.");
      return;
    }
    if (newPassword !== confirmPassword) {
      toast.error("Passwords do not match.");
      return;
    }
    setSubmitting(true);
    try {
      await api("/api/auth/confirm-reset", {
        method: "POST",
        body: {
          email: email.trim(),
          code: code.trim(),
          new_password: newPassword,
        },
      });
      toast.success("Password updated. Please sign in.");
      router.replace("/login");
    } catch (err: unknown) {
      const message =
        err instanceof Error ? err.message : "Could not update password.";
      toast.error(message);
    } finally {
      setSubmitting(false);
    }
  }

  async function handleResendOtp() {
    setSubmitting(true);
    try {
      await api("/api/auth/forgot-password", {
        method: "POST",
        body: { email: email.trim() },
      });
      toast.success("A new code has been sent to your email.");
      setCode("");
    } catch {
      toast.error("Could not resend code. Please try again.");
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <div className="space-y-6">
      {/* Heading */}
      <div>
        <h2 className="text-2xl font-bold text-[#232222] leading-tight">
          {step === "email" && "Forgot Password"}
          {step === "otp" && "Enter Verification Code"}
          {step === "password" && "Set a New Password"}
        </h2>
        <p className="text-sm text-[#5D5D5D] mt-1">
          {step === "email" &&
            "Enter your email and we'll send you a 6-digit code."}
          {step === "otp" && (
            <>
              We sent a code to <strong>{email}</strong>. It expires in 10
              minutes.
            </>
          )}
          {step === "password" && "Choose a strong password for your account."}
        </p>
      </div>

      {/* Step 1 — email */}
      {step === "email" && (
        <form onSubmit={handleRequestOtp} className="space-y-4">
          <div className="space-y-1.5">
            <Label htmlFor="email" className="text-sm font-medium text-[#232222]">
              Email Address
            </Label>
            <Input
              id="email"
              type="email"
              placeholder="you@testingxperts.com"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
              className={inputClass}
            />
          </div>
          <Button
            type="submit"
            className="w-full h-11 text-base font-semibold bg-[#B12B35] hover:bg-[#9a2330] text-white rounded-lg mt-2 transition-colors"
            disabled={submitting}
          >
            {submitting ? "Sending…" : "Send Reset Code"}
          </Button>
        </form>
      )}

      {/* Step 2 — OTP */}
      {step === "otp" && (
        <form onSubmit={handleVerifyOtp} className="space-y-4">
          <div className="space-y-1.5">
            <Label htmlFor="code" className="text-sm font-medium text-[#232222]">
              6-Digit Code
            </Label>
            <Input
              id="code"
              type="text"
              inputMode="numeric"
              autoComplete="one-time-code"
              maxLength={6}
              placeholder="000000"
              value={code}
              onChange={(e) =>
                setCode(e.target.value.replace(/\D/g, "").slice(0, 6))
              }
              required
              className={`${inputClass} tracking-[0.5em] text-center text-lg font-semibold`}
            />
          </div>
          <Button
            type="submit"
            className="w-full h-11 text-base font-semibold bg-[#B12B35] hover:bg-[#9a2330] text-white rounded-lg mt-2 transition-colors"
            disabled={submitting}
          >
            {submitting ? "Verifying…" : "Verify Code"}
          </Button>
          <div className="flex items-center justify-between text-xs">
            <button
              type="button"
              onClick={() => setStep("email")}
              className="text-[#5D5D5D] hover:text-[#B12B35] underline"
            >
              Change email
            </button>
            <button
              type="button"
              onClick={handleResendOtp}
              disabled={submitting}
              className="text-[#5D5D5D] hover:text-[#B12B35] underline disabled:opacity-50"
            >
              Resend code
            </button>
          </div>
        </form>
      )}

      {/* Step 3 — new password */}
      {step === "password" && (
        <form onSubmit={handleConfirmReset} className="space-y-4">
          <div className="space-y-1.5">
            <Label
              htmlFor="new-password"
              className="text-sm font-medium text-[#232222]"
            >
              New Password
            </Label>
            <div className="relative">
              <Input
                id="new-password"
                type={showPassword ? "text" : "password"}
                placeholder="At least 8 characters"
                value={newPassword}
                onChange={(e) => setNewPassword(e.target.value)}
                required
                minLength={8}
                autoComplete="new-password"
                className={`${inputClass} pr-10`}
              />
              <button
                type="button"
                onClick={() => setShowPassword((v) => !v)}
                aria-label={showPassword ? "Hide password" : "Show password"}
                className="absolute inset-y-0 right-2 flex items-center text-[#5D5D5D] hover:text-[#232222] transition-colors"
                tabIndex={-1}
              >
                {showPassword ? (
                  <EyeOff className="h-4 w-4" />
                ) : (
                  <Eye className="h-4 w-4" />
                )}
              </button>
            </div>
          </div>
          <div className="space-y-1.5">
            <Label
              htmlFor="confirm-password"
              className="text-sm font-medium text-[#232222]"
            >
              Confirm New Password
            </Label>
            <Input
              id="confirm-password"
              type={showPassword ? "text" : "password"}
              placeholder="Re-enter password"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              required
              minLength={8}
              autoComplete="new-password"
              className={inputClass}
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
      )}

      {/* Back to login */}
      <Link
        href="/login"
        className="flex items-center justify-center gap-1.5 text-xs text-[#5D5D5D] hover:text-[#B12B35] transition-colors"
      >
        <ArrowLeft className="h-3.5 w-3.5" />
        Back to sign in
      </Link>
    </div>
  );
}
