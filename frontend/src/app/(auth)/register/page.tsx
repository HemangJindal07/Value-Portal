"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useAuth } from "@/lib/auth-context";
import { toast } from "sonner";
import Link from "next/link";

export default function RegisterPage() {
  const [fullName, setFullName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const { signUp } = useAuth();
  const router = useRouter();

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);
    try {
      await signUp(email, password, fullName);
      toast.success("Account created! You can now sign in.");
      router.push("/");
    } catch (err: unknown) {
      const message =
        err instanceof Error ? err.message : "Registration failed.";
      toast.error(message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="space-y-6">
      {/* Heading */}
      <div>
        <h2 className="text-2xl font-bold text-[#232222] leading-tight">
          Create an Account
        </h2>
        <p className="text-sm text-[#5D5D5D] mt-1">
          Join the Value Portal and start contributing today.
        </p>
      </div>

      {/* Form */}
      <form onSubmit={handleSubmit} className="space-y-4">
        <div className="space-y-1.5">
          <Label htmlFor="name" className="text-sm font-medium text-[#232222]">
            Full Name
          </Label>
          <Input
            id="name"
            placeholder="Your full name"
            value={fullName}
            onChange={(e) => setFullName(e.target.value)}
            required
            className="h-10 border-[#C5C5C5] bg-white focus-visible:border-[#B12B35] focus-visible:ring-[#B12B35]/20 placeholder:text-[#C5C5C5]"
          />
        </div>

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

        <div className="space-y-1.5">
          <Label
            htmlFor="password"
            className="text-sm font-medium text-[#232222]"
          >
            Password
          </Label>
          <Input
            id="password"
            type="password"
            placeholder="Minimum 6 characters"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            minLength={6}
            className="h-10 border-[#C5C5C5] bg-white focus-visible:border-[#B12B35] focus-visible:ring-[#B12B35]/20 placeholder:text-[#C5C5C5]"
          />
        </div>

        <Button
          type="submit"
          className="w-full h-11 text-base font-semibold bg-[#B12B35] hover:bg-[#9a2330] text-white rounded-lg mt-2 transition-colors"
          disabled={loading}
        >
          {loading ? "Creating Account…" : "Create Account"}
        </Button>
      </form>

      {/* Divider */}
      <div className="relative">
        <div className="absolute inset-0 flex items-center">
          <div className="w-full border-t border-[#EDE7E6]" />
        </div>
        <div className="relative flex justify-center text-xs">
          <span className="bg-[#F9F9F9] px-3 text-[#5D5D5D]">
            Already have an account?
          </span>
        </div>
      </div>

      <Link
        href="/login"
        className="flex items-center justify-center w-full h-10 rounded-lg border border-[#B12B35] text-[#B12B35] text-sm font-semibold hover:bg-[#B12B35]/5 transition-colors"
      >
        Sign In
      </Link>
    </div>
  );
}
