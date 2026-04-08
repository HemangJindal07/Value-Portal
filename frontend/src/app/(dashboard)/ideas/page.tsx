"use client";

/**
 * Value Ideas feature is disabled — leads-only portal.
 * Original list UI commented out in git history; re-enable `/api/ideas` + sidebar link to restore.
 */
import Link from "next/link";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";

export default function IdeasDisabledPage() {
  return (
    <div className="max-w-lg space-y-4">
      <Card className="border-[#EDE7E6]">
        <CardHeader>
          <CardTitle className="text-[#232222]">Value Ideas</CardTitle>
          <CardDescription>
            This area is turned off. The portal currently supports leads only.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <Link
            href="/leads"
            className="text-sm font-semibold text-[#B12B35] hover:underline"
          >
            Go to Leads
          </Link>
        </CardContent>
      </Card>
    </div>
  );
}
