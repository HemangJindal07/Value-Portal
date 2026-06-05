"use client";

import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { FileText, ExternalLink } from "lucide-react";

const POLICY_DOC_URL = "/Tx-Catalyst-Policy.pdf";

export default function PolicyPage() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">Policy &amp; Guidelines</h1>
        <p className="text-muted-foreground">
          Official policy documents for the Tx Catalyst platform. Click a
          document to open it in a new tab.
        </p>
      </div>

      <Card className="max-w-2xl">
        <CardHeader>
          <CardTitle className="text-base">Documents</CardTitle>
          <CardDescription>1 document available</CardDescription>
        </CardHeader>
        <CardContent>
          <a
            href={POLICY_DOC_URL}
            target="_blank"
            rel="noopener noreferrer"
            className="group flex items-center gap-4 rounded-lg border border-[#EDE7E6] p-4 transition-colors hover:border-[#B12B35]/40 hover:bg-[#FBF4F5]"
          >
            <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-lg bg-[#B12B35]/10 text-[#B12B35]">
              <FileText className="h-5 w-5" />
            </span>
            <div className="min-w-0 flex-1">
              <p className="font-medium text-[#232222] group-hover:text-[#B12B35]">
                Tx-Catalyst Policy Document
              </p>
              <p className="text-sm text-muted-foreground">
                Version 1.0 (Soft Launch) &middot; PDF
              </p>
            </div>
            <ExternalLink className="h-4 w-4 shrink-0 text-[#8A8A8A] group-hover:text-[#B12B35]" />
          </a>
        </CardContent>
      </Card>
    </div>
  );
}
