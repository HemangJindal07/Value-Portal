"use client";

import Image from "next/image";
import Link from "next/link";
import { X } from "lucide-react";
import { useState } from "react";

export function CampaignBanner() {
  const [dismissed, setDismissed] = useState(false);
  if (dismissed) return null;

  return (
    <div className="relative overflow-hidden rounded-xl bg-[#B12B35] px-6 py-5 flex items-center gap-5">
      {/* Geometric decoration */}
      <div className="pointer-events-none absolute inset-0">
        <div className="absolute -top-8 -right-8 w-40 h-40 rounded-full bg-white/5" />
        <div className="absolute -bottom-6 -left-6 w-28 h-28 rounded-full bg-black/10" />
        <div className="absolute top-1/2 right-1/4 -translate-y-1/2 w-64 h-64 rounded-full border border-white/10" />
      </div>

      {/* Logo mark */}
      <div className="relative shrink-0 flex h-10 w-10 items-center justify-center rounded-lg bg-white/15 border border-white/20 p-1.5">
        <Image
          src="/txlogo.webp"
          alt="TestingXperts"
          width={28}
          height={28}
          className="object-contain"
        />
      </div>

      {/* Copy */}
      <div className="relative flex-1 min-w-0">
        <p className="text-white/70 text-[10px] font-semibold tracking-[0.15em] mb-0.5">
          Tx Catalyst
        </p>
        <p className="text-white font-bold text-base leading-tight">
          Got a lead?&nbsp;
          <span className="text-white/80 font-normal">
            Log it, track it, and measure the impact.
          </span>
        </p>
      </div>

      {/* CTA — Value Ideas disabled: point to leads */}
      <Link
        href="/leads/new"
        className="relative shrink-0 inline-flex items-center gap-2 bg-white text-[#B12B35] font-semibold text-sm px-4 py-2 rounded-lg hover:bg-[#F9F9F9] transition-colors"
      >
        Log It Now
      </Link>

      {/* Dismiss */}
      <button
        onClick={() => setDismissed(true)}
        className="relative shrink-0 text-white/40 hover:text-white/80 transition-colors"
        aria-label="Dismiss banner"
      >
        <X className="h-4 w-4" />
      </button>
    </div>
  );
}
