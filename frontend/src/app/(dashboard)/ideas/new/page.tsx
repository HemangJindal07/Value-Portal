"use client";

/**
 * Value Ideas submission disabled — leads-only portal.
 * Original form commented out in git history.
 */
import Link from "next/link";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";

export default function NewIdeaDisabledPage() {
  return (
    <div className="max-w-lg space-y-4">
      <Card className="border-[#EDE7E6]">
        <CardHeader>
          <CardTitle className="text-[#232222]">Submit Value Idea</CardTitle>
          <CardDescription>
            New value ideas cannot be submitted while this feature is disabled.
          </CardDescription>
        </CardHeader>
        <CardContent className="flex gap-3">
          <Link
            href="/leads/new"
            className="inline-flex rounded-lg bg-[#B12B35] px-4 py-2 text-sm font-semibold text-white hover:bg-[#9a2330]"
          >
            Submit a Lead
          </Link>
          <Link href="/leads" className="text-sm text-[#5D5D5D] hover:underline pt-2">
            Back to Leads
          </Link>
        </CardContent>
      </Card>
    </div>
  );
}
