"use client";

import { useState } from "react";
import { MessageSquareWarning } from "lucide-react";
import { useAuth } from "@/lib/auth-context";
import { ReportIssueDialog } from "@/components/report-issue-dialog";

export function ReportIssueButton() {
  const { user } = useAuth();
  const [open, setOpen] = useState(false);

  if (!user) return null;

  return (
    <>
      <button
        type="button"
        onClick={() => setOpen(true)}
        aria-label="Report an issue"
        className="fixed bottom-6 right-6 z-50 flex items-center gap-2 rounded-full bg-[#B12B35] px-4 py-3 text-sm font-semibold text-white shadow-lg hover:bg-[#9a2330] transition-colors"
      >
        <MessageSquareWarning className="h-5 w-5" />
        <span className="hidden sm:inline">Report Issue</span>
      </button>
      <ReportIssueDialog open={open} onOpenChange={setOpen} />
    </>
  );
}
