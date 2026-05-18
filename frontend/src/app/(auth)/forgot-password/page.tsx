"use client";

import { useState, useEffect } from "react";
import { useSearchParams } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { api } from "@/lib/api";
import { toast } from "sonner";
import Link from "next/link";

export default function ForgotPasswordPage() {
  const [email, setEmail] = useState("");
  const [loading, setLoading] = useState(false);
  const [sent, setSent] = useState(false);
  const searchParams = useSearchParams();

  useEffect(() => {
    if (searchParams.get("expired") === "1") {
      toast.error("Your password reset link has expired. Please request a new one.");
    }
  }, [searchParams]);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);
    try {
      await api("/api/auth/forgot-password", {
        method: "POST",
        body: { email },
      });
      setSent(true);
    } catch {
      // Show generic success even on error to prevent email enumeration
      setSent(true);
    } finally {
      setLoading(false);
    }
  }

  if (sent) {
    return (
      <div className="space-y-6">
        <div>
          <h2 className="text-2xl font-bold text-[#232222] leading-tight">
            Check your inbox
          </h2>
          <p className="text-sm text-[#5D5D5D] mt-1">
            If <span className="font-medium text-[#232222]">{email}</span> is
            registered, you will receive a password reset link shortly.
          </p>
        </div>
        <p className="text-xs text-[#5D5D5D]">
          Didn&apos;t receive it? Check your spam folder or{" "}
          <button
            className="text-[#B12B35] hover:underline"
            onClick={() => setSent(false)}
          >
            try again
          </button>
          .
        </p>
        <Link
          href="/login"
          className="flex items-center justify-center w-full h-10 rounded-lg border border-[#B12B35] text-[#B12B35] text-sm font-semibold hover:bg-[#B12B35]/5 transition-colors"
        >
          Back to Sign In
        </Link>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-bold text-[#232222] leading-tight">
          Forgot your password?
        </h2>
        <p className="text-sm text-[#5D5D5D] mt-1">
          Enter your email address and we&apos;ll send you a reset link.
        </p>
      </div>

      <form onSubmit={handleSubmit} className="space-y-4">
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
            className="h-10 border-[#C5C5C5] bg-white focus-visible:border-[#B12B35] focus-visible:ring-[#B12B35]/20 placeholder:text-[#C5C5C5]"
          />
        </div>

        <Button
          type="submit"
          className="w-full h-11 text-base font-semibold bg-[#B12B35] hover:bg-[#9a2330] text-white rounded-lg mt-2 transition-colors"
          disabled={loading}
        >
          {loading ? "Sending…" : "Send Reset Link"}
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
