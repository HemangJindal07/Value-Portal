"use client";

/**
 * Value Ideas detail disabled — leads-only portal.
 * Original detail page commented out in git history.
 */
import Link from "next/link";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";

export default function IdeaDetailDisabledPage() {
  return (
    <div className="max-w-lg space-y-4">
      <Card className="border-[#EDE7E6]">
        <CardHeader>
          <CardTitle className="text-[#232222]">Value Idea</CardTitle>
          <CardDescription>
            Idea details are not available while Value Ideas are disabled.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <Link href="/leads" className="text-sm font-semibold text-[#B12B35] hover:underline">
            Go to Leads
          </Link>
        </CardContent>
      </Card>
    </div>
  );
}
