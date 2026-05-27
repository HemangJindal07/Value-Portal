"use client";

import { useEffect, useState, useCallback, useRef } from "react";
import { useQuery } from "@tanstack/react-query";
import { useAuth } from "@/lib/auth-context";
import { api } from "@/lib/api";
import {
  Card, CardContent, CardDescription, CardHeader, CardTitle,
} from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import {
  Target, /* Lightbulb, */ Trophy, ClipboardList, ArrowRight, ShieldCheck,
  TrendingUp, BadgePercent, AlertTriangle, Banknote, Clock, Globe, BarChart3,
  Building2, GitMerge, Activity, ChevronRight,
} from "lucide-react";
import Link from "next/link";
import {
  Dialog, DialogContent, DialogHeader, DialogTitle,
} from "@/components/ui/dialog";
import type { LeadWithRelations, AssignmentWithRelations } from "@/types";
// import type { IdeaWithRelations } from "@/types"; // Value Ideas disabled

// ── Types ──────────────────────────────────────────────────────────────────

type OrgStats = {
  total_leads: number;
  total_ideas: number;
  total_accounts: number;
  active_users: number;
  leads_by_status: Record<string, number>;
  ideas_by_status: Record<string, number>;
  pending_assignments: number;
};

type Activity = {
  type: string;
  title: string;
  from_status: string;
  to_status: string;
  changed_by: string;
  changed_at: string;
};

type StakeholderCompleteness = {
  total_accounts: number;
  mapped_accounts: number;
  unmapped_accounts: string[];
  completion_pct: number;
};

type LeaderboardEntry = {
  rank: number;
  user_id: string;
  total_points: number;
  leads_submitted: number;
  ideas_submitted: number;
  deals_won: number;
  user: { full_name: string; email: string; role: string };
};

// ── Shared helpers ─────────────────────────────────────────────────────────

function timeAgo(dateStr: string) {
  const diff = Date.now() - new Date(dateStr).getTime();
  const mins = Math.floor(diff / 60000);
  if (mins < 1) return "Just now";
  if (mins < 60) return `${mins}m ago`;
  const hrs = Math.floor(mins / 60);
  if (hrs < 24) return `${hrs}h ago`;
  return `${Math.floor(hrs / 24)}d ago`;
}

const STATUS_COLORS: Record<string, string> = {
  submitted:            "#2E75B6",
  routing_pending:      "#f59e0b",
  under_review:         "#003466",
  qualified:            "#B12B35",
  opportunity_created:  "#7c3aed",
  won:                  "#22c55e",
  lost:                 "#C5C5C5",
  rejected:             "#C5C5C5",
};

const STATUS_BADGE: Record<string, string> = {
  submitted:            "bg-[#2E75B6]/10 text-[#2E75B6] border-[#2E75B6]/20",
  routing_pending:      "bg-amber-100 text-amber-700 border-amber-200",
  under_review:         "bg-[#003466]/10 text-[#003466] border-[#003466]/20",
  qualified:            "bg-[#B12B35]/10 text-[#B12B35] border-[#B12B35]/20",
  opportunity_created:  "bg-purple-100 text-purple-700 border-purple-200",
  won:                  "bg-green-100 text-green-700 border-green-200",
  lost:                 "bg-[#C5C5C5]/20 text-[#5D5D5D] border-[#C5C5C5]/40",
  rejected:             "bg-[#C5C5C5]/20 text-[#5D5D5D] border-[#C5C5C5]/40",
};

function StatusBarChart({ data, color = "#B12B35" }: { data: Record<string, number>; color?: string }) {
  // Fixed lifecycle order so the chart always shows the same dynamic stages,
  // each updating live from DB counts. "submitted" and "draft" are excluded —
  // "submitted" rolls into the routing_pending "Awaiting Review" stage.
  const STAGES: { key: string; label: string }[] = [
    { key: "routing_pending",     label: "Awaiting Review (Routing Pending)" },
    { key: "under_review",        label: "Under Review" },
    { key: "qualified",           label: "Qualified" },
    { key: "opportunity_created", label: "Opportunity Created" },
    { key: "won",                 label: "Won" },
    { key: "lost",                label: "Lost" },
    { key: "rejected",            label: "Rejected" },
  ];

  // "Awaiting Review" combines submitted + routing_pending (both pre-review).
  const countFor = (key: string) =>
    key === "routing_pending"
      ? (data["routing_pending"] || 0) + (data["submitted"] || 0)
      : (data[key] || 0);

  const max = Math.max(...STAGES.map((st) => countFor(st.key)), 1);

  return (
    <div className="space-y-2.5">
      {STAGES.map(({ key, label }) => {
        const count = countFor(key);
        const pct = Math.round((count / max) * 100);
        const badge = STATUS_BADGE[key] || "bg-[#C5C5C5]/20 text-[#5D5D5D] border-[#C5C5C5]/40";
        return (
          <div key={key}>
            <div className="flex items-center justify-between mb-1">
              <Badge variant="outline" className={`text-[11px] px-2 py-0.5 ${badge}`}>
                {label}
              </Badge>
              <span className="text-xs font-semibold text-[#232222]">{count}</span>
            </div>
            <div className="h-2 w-full rounded-full bg-[#EDE7E6] overflow-hidden">
              <div
                className="h-full rounded-full transition-all duration-700"
                style={{ width: `${pct}%`, background: color }}
              />
            </div>
          </div>
        );
      })}
    </div>
  );
}

// ── Workflow Pipeline Chart — fixed 4-stage view for user dashboard ──────────
// Shows exactly the 4 stages of the lead lifecycle with real DB counts.
// Each stage groups related statuses: qualified+rejected, won+lost.
function WorkflowPipelineChart({ data }: { data: Record<string, number> }) {
  const stages = [
    {
      label: "Awaiting Review (Routing Pending)",
      count: (data["submitted"] || 0) + (data["routing_pending"] || 0),
      subLabels: [
        { label: "Submitted",       count: data["submitted"]       || 0, color: "#2E75B6" },
        { label: "Routing Pending", count: data["routing_pending"] || 0, color: "#f59e0b" },
      ],
      color: "#2E75B6",
      badge: "bg-[#2E75B6]/10 text-[#2E75B6] border-[#2E75B6]/20",
    },
    {
      label: "Under Review",
      count: data["under_review"] || 0,
      color: "#003466",
      badge: "bg-[#003466]/10 text-[#003466] border-[#003466]/20",
    },
    {
      label: "Qualified / Rejected",
      count: (data["qualified"] || 0) + (data["approved"] || 0) + (data["rejected"] || 0),
      subLabels: [
        { label: "Qualified", count: (data["qualified"] || 0) + (data["approved"] || 0), color: "#B12B35" },
        { label: "Rejected",  count: data["rejected"] || 0, color: "#C5C5C5" },
      ],
      color: "#B12B35",
      badge: "bg-[#B12B35]/10 text-[#B12B35] border-[#B12B35]/20",
    },
    {
      label: "Opportunity Created",
      count: data["opportunity_created"] || 0,
      color: "#7c3aed",
      badge: "bg-purple-100 text-purple-700 border-purple-200",
    },
    {
      label: "Won / Lost",
      count: (data["won"] || 0) + (data["lost"] || 0),
      subLabels: [
        { label: "Won",  count: data["won"]  || 0, color: "#22c55e" },
        { label: "Lost", count: data["lost"] || 0, color: "#C5C5C5" },
      ],
      color: "#22c55e",
      badge: "bg-green-100 text-green-700 border-green-200",
    },
  ];

  const total = stages.reduce((sum, s) => sum + s.count, 0);
  const max = Math.max(...stages.map((s) => s.count), 1);

  return (
    <div className="space-y-3">
      {/* Total count header */}
      <div className="flex items-center justify-between text-xs text-muted-foreground pb-1 border-b border-[#EDE7E6]">
        <span>All leads</span>
        <span className="font-semibold text-[#232222]">{total} total</span>
      </div>
      {stages.map((stage) => {
        const pct = Math.round((stage.count / max) * 100);
        return (
          <div key={stage.label}>
            <div className="flex items-center justify-between mb-1">
              <Badge variant="outline" className={`text-[11px] px-2 py-0.5 ${stage.badge}`}>
                {stage.label}
              </Badge>
              <div className="flex items-center gap-2">
                {stage.subLabels?.map((sub) => (
                  <span key={sub.label} className="text-[11px] text-[#5D5D5D]">
                    {sub.label}: <span className="font-semibold" style={{ color: sub.color }}>{sub.count}</span>
                  </span>
                ))}
                {!stage.subLabels && (
                  <span className="text-xs font-semibold text-[#232222]">{stage.count}</span>
                )}
              </div>
            </div>
            <div className="h-2 w-full rounded-full bg-[#EDE7E6] overflow-hidden">
              <div
                className="h-full rounded-full transition-all duration-700"
                style={{ width: `${pct}%`, background: stage.color }}
              />
            </div>
          </div>
        );
      })}
    </div>
  );
}

function StatCard({
  title, value, desc, icon: Icon, iconColor, iconBg, href, accent,
}: {
  title: string; value: string | number; desc?: string;
  icon: React.ElementType; iconColor: string; iconBg: string; href?: string;
  accent?: string;
}) {
  const inner = (
    <Card className="hover:shadow-md transition-shadow cursor-pointer border-[#EDE7E6] bg-white h-full overflow-hidden">
      {accent && <div className="h-1 w-full" style={{ background: accent }} />}
      <CardHeader className="flex flex-row items-center justify-between pb-2 pt-4">
        <CardTitle className="text-sm font-medium text-[#5D5D5D]">{title}</CardTitle>
        <div className={`flex h-9 w-9 items-center justify-center rounded-xl ${iconBg}`}>
          <Icon className={`h-4 w-4 ${iconColor}`} />
        </div>
      </CardHeader>
      <CardContent>
        <div className="text-3xl font-bold text-[#232222] tracking-tight">{String(value)}</div>
        {desc && <p className="text-xs text-[#5D5D5D] mt-1">{desc}</p>}
      </CardContent>
    </Card>
  );
  return href ? <Link href={href}>{inner}</Link> : inner;
}

// ── Admin analytics types ─────────────────────────────────────────────────

type BreakdownItem = { region?: string; vertical?: string; count: number; value?: number };
type AccountItem   = { account_name: string; leads: number; ideas: number };
type TurnaroundRow = { role: string; avg_days: number; count: number };

type AdminAnalytics = {
  total_leads:          number;
  qualification_ratio:  number;
  win_rate:             number;
  won_count:            number;
  lost_count:           number;
  pipeline_value:       number;
  won_value:            number;
  total_savings:        number;
  leads_by_region:      BreakdownItem[];
  leads_by_vertical:    BreakdownItem[];
  top_accounts:         AccountItem[];
  turnaround:           TurnaroundRow[];
  routing_pending_leads: number;
  routing_pending_ideas: number;
};

// ── Small bar inside analytics tables ─────────────────────────────────────

function MiniBar({ value, max, color }: { value: number; max: number; color: string }) {
  const pct = max > 0 ? Math.round((value / max) * 100) : 0;
  return (
    <div className="h-1.5 w-full rounded-full bg-[#EDE7E6] overflow-hidden mt-1">
      <div className="h-full rounded-full" style={{ width: `${pct}%`, background: color }} />
    </div>
  );
}

// ── Lead Status Breakdown — pipeline-stage data as a donut ──────────────────

function FunnelChart({
  stages,
}: {
  stages: { label: string; count: number; color: string }[];
}) {
  const [hovered, setHovered] = useState<number | null>(null);
  const total = stages.reduce((sum, s) => sum + s.count, 0);

  // Donut geometry
  const size = 180;
  const cx = size / 2;
  const cy = size / 2;
  const r = 70;          // outer radius of the arc stroke
  const stroke = 30;     // donut thickness
  const circumference = 2 * Math.PI * r;

  // Build cumulative arc segments. Each slice is a stroked circle with a
  // dash gap, rotated to its start angle (classic SVG donut technique).
  let cumulative = 0;

  return (
    <div className="flex flex-col sm:flex-row items-center gap-5 py-2">
      {/* Donut */}
      <div className="relative shrink-0">
        <svg width={size} height={size} viewBox={`0 0 ${size} ${size}`}>
          {/* Track */}
          <circle
            cx={cx}
            cy={cy}
            r={r}
            fill="none"
            stroke="#EDE7E6"
            strokeWidth={stroke}
          />
          {total > 0 &&
            stages.map((stage, i) => {
              const fraction = stage.count / total;
              if (fraction <= 0) return null;
              const dash = fraction * circumference;
              const offset = -(cumulative / total) * circumference;
              cumulative += stage.count;
              const isHovered = hovered === i;
              return (
                <circle
                  key={i}
                  cx={cx}
                  cy={cy}
                  r={r}
                  fill="none"
                  stroke={stage.color}
                  strokeWidth={isHovered ? stroke + 6 : stroke}
                  strokeDasharray={`${dash} ${circumference - dash}`}
                  strokeDashoffset={offset}
                  transform={`rotate(-90 ${cx} ${cy})`}
                  className="transition-all duration-200 cursor-pointer"
                  style={{ opacity: hovered === null || isHovered ? 1 : 0.45 }}
                  onMouseEnter={() => setHovered(i)}
                  onMouseLeave={() => setHovered(null)}
                >
                  <title>{`${stage.label}: ${stage.count}`}</title>
                </circle>
              );
            })}
          {/* Center: total, or the hovered slice's label + count */}
          <text
            x={cx}
            y={hovered === null ? cy - 4 : cy - 6}
            textAnchor="middle"
            className="fill-[#232222]"
            style={{ fontSize: 26, fontWeight: 700 }}
          >
            {hovered === null ? total : stages[hovered].count}
          </text>
          <text
            x={cx}
            y={hovered === null ? cy + 16 : cy + 14}
            textAnchor="middle"
            className="fill-[#5D5D5D]"
            style={{ fontSize: 11 }}
          >
            {hovered === null ? "total" : stages[hovered].label}
          </text>
        </svg>
      </div>

      {/* Legend — label + count only */}
      <div className="flex-1 w-full space-y-2">
        {stages.map((stage, i) => (
          <div
            key={i}
            className="flex items-center justify-between px-0.5 rounded-md py-0.5 cursor-pointer transition-colors"
            style={{ background: hovered === i ? "#F9F9F9" : "transparent" }}
            onMouseEnter={() => setHovered(i)}
            onMouseLeave={() => setHovered(null)}
          >
            <div className="flex items-center gap-2 min-w-0">
              <div
                className="h-2.5 w-2.5 rounded-full shrink-0"
                style={{ background: stage.color }}
              />
              <span className="text-[12px] font-semibold text-[#232222] truncate">
                {stage.label}
              </span>
            </div>
            <span
              className="text-[13px] font-bold shrink-0"
              style={{ color: stage.color }}
            >
              {stage.count}
            </span>
          </div>
        ))}
      </div>
    </div>
  );
}

// ── Monthly trend type ────────────────────────────────────────────────────

type MonthlyPoint = {
  label: string;         // "Jan 25"
  pipeline_value: number;
  won_value: number;
  submissions: number;
};

// ── Hover-enabled dual-line chart ────────────────────────────────────────

function MonthlyTrendChart({ data }: { data: MonthlyPoint[] }) {
  const [hovered, setHovered] = useState<number>(-1);
  const svgRef = useRef<SVGSVGElement>(null);

  if (!data.length) {
    return <p className="text-sm text-muted-foreground py-4 text-center">No trend data yet.</p>;
  }

  const W = 520; const H = 120; const padL = 10; const padR = 10; const padT = 14; const padB = 28;
  const chartW = W - padL - padR;
  const chartH = H - padT - padB;

  const maxY = Math.max(...data.map((d) => Math.max(d.pipeline_value, d.won_value)), 1);
  const xPos = (i: number) => padL + (data.length === 1 ? chartW / 2 : (i / (data.length - 1)) * chartW);
  const yPos = (v: number) => padT + chartH - (v / maxY) * chartH;

  const pipelinePath = data.map((d, i) => `${i === 0 ? "M" : "L"} ${xPos(i)} ${yPos(d.pipeline_value)}`).join(" ");
  const wonPath      = data.map((d, i) => `${i === 0 ? "M" : "L"} ${xPos(i)} ${yPos(d.won_value)}`).join(" ");
  const pipelineFill =
    `M ${xPos(0)} ${padT + chartH} ` +
    data.map((d, i) => `L ${xPos(i)} ${yPos(d.pipeline_value)}`).join(" ") +
    ` L ${xPos(data.length - 1)} ${padT + chartH} Z`;

  const fmt = (v: number) =>
    v >= 1_000_000 ? `$${(v / 1_000_000).toFixed(2)}M`
    : v >= 1_000   ? `$${(v / 1_000).toFixed(0)}K`
    : `$${v}`;

  const slotW = chartW / data.length;
  const hd = hovered >= 0 ? data[hovered] : null;

  return (
    <div className="w-full">
      {/* Legend */}
      <div className="flex items-center gap-5 mb-3">
        <div className="flex items-center gap-1.5">
          <div className="h-[3px] w-6 rounded-full bg-[#B12B35]" />
          <span className="text-[11px] text-[#5D5D5D]">Pipeline Value</span>
        </div>
        <div className="flex items-center gap-1.5">
          <div className="h-[3px] w-6 rounded-full bg-[#22c55e]"
               style={{ background: "linear-gradient(90deg,#22c55e 60%,transparent 60%)", backgroundSize: "8px 3px", backgroundRepeat: "repeat-x" }} />
          <span className="text-[11px] text-[#5D5D5D]">Won Value</span>
        </div>
        {hd && (
          <div className="ml-auto flex items-center gap-2">
            <span className="text-[11px] font-semibold text-[#232222] bg-[#F9F9F9] border border-[#EDE7E6] rounded px-2 py-0.5">
              {hd.label}
            </span>
          </div>
        )}
      </div>

      {/* Tooltip (renders above chart when a month is hovered) */}
      {hd && (
        <div className="mb-2 flex items-stretch gap-3 rounded-xl border border-[#EDE7E6] bg-[#FAFAFA] px-4 py-2.5 text-xs">
          <div className="flex-1 text-center">
            <p className="font-bold text-[#B12B35] text-sm">{fmt(hd.pipeline_value)}</p>
            <p className="text-[#5D5D5D]">Pipeline</p>
          </div>
          <div className="w-px bg-[#EDE7E6]" />
          <div className="flex-1 text-center">
            <p className="font-bold text-green-600 text-sm">{fmt(hd.won_value)}</p>
            <p className="text-[#5D5D5D]">Won</p>
          </div>
          <div className="w-px bg-[#EDE7E6]" />
          <div className="flex-1 text-center">
            <p className="font-bold text-[#2E75B6] text-sm">{hd.submissions}</p>
            <p className="text-[#5D5D5D]">Submissions</p>
          </div>
        </div>
      )}

      {/* SVG Chart */}
      <svg
        ref={svgRef}
        viewBox={`0 0 ${W} ${H}`}
        className="w-full"
        style={{ height: 120 }}
        onMouseLeave={() => setHovered(-1)}
      >
        <defs>
          <linearGradient id="pipeGrad2" x1="0" y1="0" x2="0" y2="1">
            <stop offset="0%"   stopColor="#B12B35" stopOpacity="0.14" />
            <stop offset="100%" stopColor="#B12B35" stopOpacity="0" />
          </linearGradient>
        </defs>

        {/* Grid lines */}
        {[0.25, 0.5, 0.75, 1].map((f) => (
          <line key={f}
            x1={padL} x2={W - padR}
            y1={padT + chartH * (1 - f)} y2={padT + chartH * (1 - f)}
            stroke="#EDE7E6" strokeWidth={f === 1 ? 1 : 0.5} strokeDasharray={f === 1 ? undefined : "3,3"}
          />
        ))}

        {/* Pipeline fill */}
        <path d={pipelineFill} fill="url(#pipeGrad2)" />

        {/* Pipeline line */}
        <path d={pipelinePath} fill="none" stroke="#B12B35" strokeWidth="2"
              strokeLinejoin="round" strokeLinecap="round" />

        {/* Won line (dashed) */}
        <path d={wonPath} fill="none" stroke="#22c55e" strokeWidth="2"
              strokeLinejoin="round" strokeLinecap="round" strokeDasharray="5,3" />

        {/* Hovered vertical rule + dots */}
        {hovered >= 0 && (
          <>
            <line
              x1={xPos(hovered)} x2={xPos(hovered)}
              y1={padT} y2={padT + chartH}
              stroke="#232222" strokeWidth="1" strokeDasharray="3,2" opacity="0.25"
            />
            <circle cx={xPos(hovered)} cy={yPos(data[hovered].pipeline_value)}
              r="4.5" fill="#B12B35" stroke="#fff" strokeWidth="1.5" />
            <circle cx={xPos(hovered)} cy={yPos(data[hovered].won_value)}
              r="3.5" fill="#22c55e" stroke="#fff" strokeWidth="1.5" />
          </>
        )}

        {/* Endpoint dots (when not hovering) */}
        {hovered < 0 && (
          <>
            <circle cx={xPos(data.length - 1)} cy={yPos(data[data.length - 1].pipeline_value)}
              r="3.5" fill="#B12B35" stroke="#fff" strokeWidth="1.5" />
            <circle cx={xPos(data.length - 1)} cy={yPos(data[data.length - 1].won_value)}
              r="3" fill="#22c55e" stroke="#fff" strokeWidth="1.5" />
          </>
        )}

        {/* X-axis month labels */}
        {data.map((d, i) => {
          if (i % 2 !== 0 && i !== data.length - 1) return null;
          return (
            <text key={i} x={xPos(i)} y={H - 4}
              textAnchor="middle" fontSize="8" fill={hovered === i ? "#232222" : "#9CA3AF"}
              fontWeight={hovered === i ? "700" : "400"}>
              {d.label}
            </text>
          );
        })}

        {/* Invisible hover zones — one per month column */}
        {data.map((_, i) => (
          <rect
            key={i}
            x={xPos(i) - slotW / 2}
            y={padT}
            width={slotW}
            height={chartH}
            fill="transparent"
            style={{ cursor: "crosshair" }}
            onMouseEnter={() => setHovered(i)}
          />
        ))}
      </svg>

      {/* Summary row */}
      <div className="mt-1 grid grid-cols-3 gap-2 pt-3 border-t border-[#EDE7E6]">
        <div className="text-center">
          <p className="text-sm font-bold text-[#232222]">{fmt(data.reduce((s, d) => s + d.pipeline_value, 0))}</p>
          <p className="text-[11px] text-[#5D5D5D]">Total Pipeline</p>
        </div>
        <div className="text-center border-x border-[#EDE7E6]">
          <p className="text-sm font-bold text-[#232222]">{fmt(data.reduce((s, d) => s + d.won_value, 0))}</p>
          <p className="text-[11px] text-[#5D5D5D]">Total Won</p>
        </div>
        <div className="text-center">
          <p className="text-sm font-bold text-[#232222]">{data.reduce((s, d) => s + d.submissions, 0)}</p>
          <p className="text-[11px] text-[#5D5D5D]">Submissions</p>
        </div>
      </div>
    </div>
  );
}

// ── Submissions bar chart with hover tooltip ─────────────────────────────

const MONTH_ORDER = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

function MonthlySubmissionsChart({ data: rawData }: { data: MonthlyPoint[] }) {
  const [hovered, setHovered] = useState<number>(-1);

  // Reorder the 12-month window into calendar order (Jan → Dec) for display.
  const data = [...rawData].sort(
    (a, b) => MONTH_ORDER.indexOf(a.label) - MONTH_ORDER.indexOf(b.label)
  );

  if (!data.length) return null;

  const maxS  = Math.max(...data.map((d) => d.submissions), 1);
  const W = 520; const H = 90; const padL = 8; const padR = 8; const padB = 22; const padT = 8;
  const chartW = W - padL - padR;
  const chartH = H - padT - padB;
  const gap    = chartW / data.length;
  const barW   = Math.max(gap * 0.6, 4);

  const fmt = (v: number) =>
    v >= 1_000_000 ? `$${(v / 1_000_000).toFixed(1)}M`
    : v >= 1_000   ? `$${(v / 1_000).toFixed(0)}K`
    : `$${v}`;

  const hd = hovered >= 0 ? data[hovered] : null;

  return (
    <div className="w-full">
      {/* Tooltip row — appears instantly when a bar is hovered */}
      <div className="mb-2" style={{ minHeight: 48 }}>
        {hd && (
          <div className="flex items-stretch gap-3 rounded-xl border border-[#EDE7E6] bg-[#FAFAFA] px-4 py-2.5 text-xs">
            <div className="flex-1 text-center">
              <p className="font-bold text-[#2E75B6] text-sm">{hd.submissions}</p>
              <p className="text-[#5D5D5D]">Submissions</p>
            </div>
            <div className="w-px bg-[#EDE7E6]" />
            <div className="flex-1 text-center">
              <p className="font-bold text-[#B12B35] text-sm">{fmt(hd.pipeline_value)}</p>
              <p className="text-[#5D5D5D]">Pipeline Value</p>
            </div>
            <div className="w-px bg-[#EDE7E6]" />
            <div className="flex-1 text-center">
              <p className="font-bold text-green-600 text-sm">{fmt(hd.won_value)}</p>
              <p className="text-[#5D5D5D]">Won Value</p>
            </div>
            <div className="w-px bg-[#EDE7E6]" />
            <div className="flex-1 text-center">
              <p className="font-bold text-[#232222] text-sm">{hd.label}</p>
              <p className="text-[#5D5D5D]">Month</p>
            </div>
          </div>
        )}
      </div>

      {/* Bar chart */}
      <svg
        viewBox={`0 0 ${W} ${H}`}
        className="w-full"
        style={{ height: 90 }}
        onMouseLeave={() => setHovered(-1)}
      >
        {data.map((d, i) => {
          const bH    = Math.max((d.submissions / maxS) * chartH, d.submissions > 0 ? 3 : 0);
          const bX    = padL + i * gap + (gap - barW) / 2;
          const bY    = padT + chartH - bH;
          const isHov = hovered === i;
          const isEmpty = d.submissions === 0;

          return (
            <g
              key={i}
              style={{ cursor: isEmpty ? "default" : "pointer" }}
              onMouseEnter={() => setHovered(i)}
            >
              {/* Hover highlight column (full height, subtle) */}
              {isHov && (
                <rect
                  x={padL + i * gap}
                  y={padT}
                  width={gap}
                  height={chartH}
                  fill="#2E75B6"
                  opacity="0.06"
                  rx="2"
                />
              )}

              {/* Bar */}
              <rect
                x={bX}
                y={bY}
                width={barW}
                height={Math.max(bH, 2)}
                rx="3"
                fill={isEmpty ? "#EDE7E6" : isHov ? "#003466" : "#2E75B6"}
                opacity={isHov ? 1 : 0.82}
              />

              {/* Count label above bar when hovered */}
              {isHov && !isEmpty && (
                <text
                  x={bX + barW / 2}
                  y={bY - 3}
                  textAnchor="middle"
                  fontSize="8.5"
                  fontWeight="700"
                  fill="#003466"
                >
                  {d.submissions}
                </text>
              )}

              {/* X-axis month labels — every month, just the abbreviated name */}
              <text
                x={bX + barW / 2}
                y={H - 4}
                textAnchor="middle"
                fontSize="7.5"
                fill={isHov ? "#232222" : "#9CA3AF"}
                fontWeight={isHov ? "700" : "400"}
              >
                {d.label}
              </text>
            </g>
          );
        })}
      </svg>
    </div>
  );
}

// ── Section divider ────────────────────────────────────────────────────────

function SectionLabel({ icon: Icon, label, color }: { icon: React.ElementType; label: string; color: string }) {
  return (
    <div className="flex items-center gap-2 pt-2">
      <Icon className="h-4 w-4" style={{ color }} />
      <span className="text-xs font-semibold uppercase tracking-widest" style={{ color }}>
        {label}
      </span>
      <div className="flex-1 h-px bg-[#EDE7E6]" />
    </div>
  );
}

// ── Mini Leaderboard widget ───────────────────────────────────────────────

function MiniLeaderboard({ token }: { token: string }) {
  const [open, setOpen] = useState(false);
  const [allEntries, setAllEntries] = useState<LeaderboardEntry[]>([]);
  const [loadingAll, setLoadingAll] = useState(false);

  // Cached top-10 — instant on revisit, refreshed in the background.
  const { data: entriesData, isLoading: loading } = useQuery({
    queryKey: ["mini-leaderboard"],
    queryFn: async () => {
      const data = await api<LeaderboardEntry[]>("/api/scores/leaderboard?limit=10", { token });
      return Array.isArray(data) ? data.slice(0, 10) : [];
    },
    enabled: !!token,
    refetchInterval: 15_000,
  });
  const entries = entriesData ?? [];

  const openModal = async () => {
    setOpen(true);
    if (allEntries.length === 0) {
      setLoadingAll(true);
      try {
        const data = await api<LeaderboardEntry[]>("/api/scores/leaderboard?limit=100", { token });
        setAllEntries(Array.isArray(data) ? data : []);
      } catch { /* silent */ }
      finally { setLoadingAll(false); }
    }
  };

  const RANK_COLORS = ["text-amber-500", "text-[#5D5D5D]", "text-[#B12B35]"];

  const renderRow = (e: LeaderboardEntry) => (
    <div
      key={e.user_id}
      className="grid grid-cols-[28px_1fr_auto] items-center gap-x-3 px-4 py-2.5 border-b border-[#EDE7E6] last:border-0 hover:bg-[#F9F9F9]"
    >
      <span className={`text-center font-bold text-[13px] ${RANK_COLORS[e.rank - 1] || "text-[#9CA3AF]"}`}>
        {e.rank <= 3 ? ["🥇","🥈","🥉"][e.rank - 1] : `#${e.rank}`}
      </span>
      <p className="text-[15px] font-semibold text-[#232222] truncate">{e.user.full_name || e.user.email}</p>
      <span className="text-[15px] font-bold text-[#B12B35] tabular-nums whitespace-nowrap">
        {e.total_points.toLocaleString()}<span className="text-[11px] font-normal text-[#5D5D5D] ml-1">pts</span>
      </span>
    </div>
  );

  return (
    <>
      <Card className="border-[#EDE7E6] bg-white">
        <CardHeader className="pb-2 px-4 pt-4">
          <div className="flex items-center justify-between">
            <CardTitle className="text-sm font-semibold text-[#232222] flex items-center gap-2">
              <Trophy className="h-4 w-4 text-amber-500" />
              Leaderboard
            </CardTitle>
            <button
              onClick={openModal}
              className="text-xs font-medium text-[#B12B35] hover:underline flex items-center gap-1"
            >
              View all <ChevronRight className="h-3 w-3" />
            </button>
          </div>
          <CardDescription className="text-[11px]">Top contributors by value points</CardDescription>
        </CardHeader>
        <CardContent className="p-0 pb-1">
          {loading ? (
            <p className="text-sm text-muted-foreground px-4 py-3">Loading…</p>
          ) : entries.length === 0 ? (
            <p className="text-sm text-muted-foreground px-4 py-3">No scores yet.</p>
          ) : (
            <div>{entries.map((e) => renderRow(e))}</div>
          )}
        </CardContent>
      </Card>

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent className="max-w-lg max-h-[80vh] flex flex-col p-0">
          <DialogHeader className="px-6 pt-5 pb-3 border-b border-[#EDE7E6] shrink-0">
            <DialogTitle className="flex items-center gap-2 text-[#232222]">
              <Trophy className="h-4 w-4 text-amber-500" />
              Full Leaderboard
            </DialogTitle>
            <p className="text-xs text-muted-foreground mt-1">Points: Submit +10 · Qualified +20 · Opportunity +50 · Won +100</p>
          </DialogHeader>
          <div className="overflow-y-auto flex-1">
            {loadingAll ? (
              <p className="text-sm text-muted-foreground text-center py-10">Loading…</p>
            ) : allEntries.length === 0 ? (
              <p className="text-sm text-muted-foreground text-center py-10">No scores yet.</p>
            ) : (
              <div>{allEntries.map((e) => renderRow(e))}</div>
            )}
          </div>
        </DialogContent>
      </Dialog>
    </>
  );
}

// ── Stakeholder Completeness Card ─────────────────────────────────────────

function StakeholderCompletenessCard({
  token, showList,
}: {
  token: string; showList: boolean;
}) {
  const [data, setData] = useState<StakeholderCompleteness | null>(null);

  useEffect(() => {
    api<StakeholderCompleteness>("/api/dashboard/stakeholder-completeness", { token })
      .then(setData)
      .catch(() => {});
  }, [token]);

  if (!data) return null;

  const pct = data.completion_pct;
  const barColor = pct >= 90 ? "#22c55e" : pct >= 60 ? "#2E75B6" : "#B12B35";

  return (
    <Card className="border-[#EDE7E6] bg-white">
      <CardHeader className="pb-3">
        <CardTitle className="text-base font-semibold text-[#232222] flex items-center gap-2">
          <GitMerge className="h-4 w-4 text-[#2E75B6]" />
          Stakeholder Mapping
        </CardTitle>
        <CardDescription>Accounts with reviewers mapped</CardDescription>
      </CardHeader>
      <CardContent className="space-y-3">
        {/* Stat row */}
        <div className="flex items-end gap-2">
          <span className="text-3xl font-bold text-[#232222]">{data.mapped_accounts}</span>
          <span className="text-sm text-[#5D5D5D] mb-1">of {data.total_accounts} accounts</span>
          <span className="ml-auto text-2xl font-bold" style={{ color: barColor }}>{pct}%</span>
        </div>

        {/* Progress bar */}
        <div className="h-2 w-full rounded-full bg-[#EDE7E6] overflow-hidden">
          <div className="h-full rounded-full transition-all duration-700" style={{ width: `${pct}%`, background: barColor }} />
        </div>

        {/* Unmapped list — admin only */}
        {showList && data.unmapped_accounts.length > 0 && (
          <div className="pt-2">
            <p className="text-[11px] font-semibold text-[#5D5D5D] uppercase tracking-wide mb-2">
              Accounts missing reviewers ({data.unmapped_accounts.length})
            </p>
            <div className="max-h-40 overflow-y-auto space-y-1">
              {data.unmapped_accounts.map((name) => (
                <div key={name} className="flex items-center gap-2 rounded-md bg-[#F9F9F9] px-3 py-1.5 text-xs">
                  <AlertTriangle className="h-3 w-3 text-amber-400 shrink-0" />
                  <span className="text-[#232222] truncate">{name}</span>
                </div>
              ))}
            </div>
            <Link
              href="/admin/stakeholder-mapping"
              className="mt-2 inline-flex items-center gap-1 text-xs font-medium text-[#B12B35] hover:underline"
            >
              Fix mappings <ChevronRight className="h-3 w-3" />
            </Link>
          </div>
        )}

        {!showList && data.unmapped_accounts.length > 0 && (
          <p className="text-xs text-[#5D5D5D]">
            {data.total_accounts - data.mapped_accounts} account{data.total_accounts - data.mapped_accounts !== 1 ? "s" : ""} need{data.total_accounts - data.mapped_accounts === 1 ? "s" : ""} reviewer mapping
          </p>
        )}
      </CardContent>
    </Card>
  );
}

// ── Admin dashboard ────────────────────────────────────────────────────────

function AdminDashboard({ token }: { token: string; userName: string }) {
  const [stats, setStats] = useState<OrgStats | null>(null);
  const [activity, setActivity] = useState<Activity[]>([]);
  const [analytics, setAnalytics] = useState<AdminAnalytics | null>(null);
  const [loading, setLoading] = useState(true);

  const load = useCallback(async () => {
    try {
      const [s, a, an] = await Promise.all([
        api<OrgStats>("/api/dashboard/stats", { token }),
        api<Activity[]>("/api/dashboard/recent-activity?limit=8", { token }),
        api<AdminAnalytics>("/api/dashboard/admin-analytics", { token }),
      ]);
      setStats(s);
      setActivity(a);
      setAnalytics(an);
    } catch { /* silent */ }
    finally { setLoading(false); }
  }, [token]);

  useEffect(() => {
    load();
    const interval = setInterval(load, 30_000);
    return () => clearInterval(interval);
  }, [load]);

  if (loading) return <div className="flex items-center justify-center py-20 text-muted-foreground">Loading dashboard…</div>;

  const s = stats ?? { total_leads: 0, total_ideas: 0, total_accounts: 0, active_users: 0, leads_by_status: {}, ideas_by_status: {}, pending_assignments: 0 };
  const an = analytics;
  // Leads only: ignore routing_pending_ideas
  const routingExceptions = an ? an.routing_pending_leads : 0;

  return (
    <div className="space-y-6">

      {/* ── Header ── */}
      <div className="flex items-start justify-between">
        <div>
          <div className="flex items-center gap-2 mb-1">
            <ShieldCheck className="h-4 w-4 text-[#B12B35]" />
            <span className="text-[11px] font-semibold text-[#B12B35] uppercase tracking-widest">
              Admin Dashboard
            </span>
          </div>
          <h1 className="text-2xl font-bold tracking-tight text-[#232222]">
            Lead Dashboard
          </h1>
          <p className="text-sm text-[#5D5D5D] mt-1 max-w-xl">
            Centralized access to account insights, and operational updates to manage priorities efficiently
          </p>
        </div>
        <Badge className="bg-[#232222] text-white border-0 text-[11px] px-3 py-1">Full Access</Badge>
      </div>

      {/* ── 4 Primary KPIs ── */}
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <StatCard
          title="Total Leads"
          value={s.total_leads}
          desc={`${s.leads_by_status["qualified"] || 0} qualified · ${s.leads_by_status["opportunity_created"] || 0} in progress · ${s.leads_by_status["won"] || 0} won`}
          icon={Target}
          iconColor="text-[#B12B35]"
          iconBg="bg-[#B12B35]/10"
          accent="#B12B35"
          href="/leads"
        />
        {/* Value Ideas KPI disabled — leads-only portal
        <StatCard
          title="Total Value Ideas"
          value={s.total_ideas}
          desc={...}
          icon={Lightbulb}
          href="/ideas"
        />
        */}
        <StatCard
          title="Routing Exceptions"
          value={routingExceptions}
          desc={`${an?.routing_pending_leads ?? 0} leads unrouted`}
          icon={AlertTriangle}
          iconColor="text-amber-500"
          iconBg="bg-amber-50"
          accent="#f59e0b"
          href="/admin/exception-queue"
        />
        <StatCard
          title="Pending Reviews"
          value={s.pending_assignments}
          desc="Awaiting stakeholder action"
          icon={ClipboardList}
          iconColor="text-[#2E75B6]"
          iconBg="bg-[#2E75B6]/10"
          accent="#2E75B6"
          href="/assignments"
        />
      </div>

      {/* ── Pipeline Health + Routing Issues ── */}
      <div className="grid gap-4 lg:grid-cols-2">
        {/* Lead Pipeline Health */}
        <Card className="border-[#EDE7E6] bg-white">
          <CardHeader className="pb-4">
            <CardTitle className="text-base font-semibold text-[#232222] flex items-center gap-2">
              <Activity className="h-4 w-4 text-[#B12B35]" />
              Lead Pipeline Health
            </CardTitle>
            <CardDescription>All leads by current status</CardDescription>
          </CardHeader>
          <CardContent className="space-y-1">
            <StatusBarChart data={s.leads_by_status} color="#B12B35" />
            {/* Ideas Pipeline disabled
            <div className="pt-3 border-t border-[#EDE7E6] mt-4">
              <p className="text-[11px] text-[#5D5D5D] font-medium uppercase tracking-wider mb-2">Ideas Pipeline</p>
              <StatusBarChart data={s.ideas_by_status} color="#003466" />
            </div>
            */}
          </CardContent>
        </Card>

        {/* Routing & Mapping Issues */}
        <Card className="border-[#EDE7E6] bg-white flex flex-col">
          <CardHeader className="pb-4">
            <CardTitle className="text-base font-semibold text-[#232222] flex items-center gap-2">
              <GitMerge className="h-4 w-4 text-amber-500" />
              Routing and Mapping Pending
            </CardTitle>
            <CardDescription>Submissions that could not be auto-routed</CardDescription>
          </CardHeader>
          <CardContent className="flex-1 flex flex-col">
            {routingExceptions === 0 ? (
              <div className="flex-1 flex flex-col items-center justify-center text-center py-8">
                <div className="h-12 w-12 rounded-full bg-green-50 flex items-center justify-center mb-3">
                  <ShieldCheck className="h-6 w-6 text-green-500" />
                </div>
                <p className="text-sm font-medium text-[#232222]">All submissions routed</p>
                <p className="text-xs text-[#5D5D5D] mt-1">No pending routing exceptions</p>
              </div>
            ) : (
              <div className="flex-1 flex flex-col">
                {/* Hero tile — fills available vertical space */}
                <div className="flex-1 flex flex-col items-center justify-center rounded-xl bg-[#B12B35]/5 border border-[#B12B35]/10 py-8 text-center">
                  <div className="h-12 w-12 rounded-full bg-[#B12B35]/10 flex items-center justify-center mb-3">
                    <AlertTriangle className="h-6 w-6 text-[#B12B35]" />
                  </div>
                  <p className="text-4xl font-bold text-[#B12B35] leading-none">
                    {an?.routing_pending_leads ?? 0}
                  </p>
                  <p className="text-sm text-[#5D5D5D] mt-2">Leads unrouted</p>
                  <p className="text-xs text-[#5D5D5D] mt-0.5 max-w-[16rem]">
                    These submissions need a stakeholder or routing rule before review can begin.
                  </p>
                </div>

                <div className="flex gap-2 mt-4">
                  <Link
                    href="/admin/exception-queue"
                    className="flex-1 flex items-center justify-center gap-1.5 rounded-lg bg-[#B12B35] px-3 py-2.5 text-xs font-semibold text-white hover:bg-[#9a2330] transition-colors"
                  >
                    View Exception Queue <ChevronRight className="h-3 w-3" />
                  </Link>
                  <Link
                    href="/admin/stakeholder-mapping"
                    className="flex-1 flex items-center justify-center gap-1.5 rounded-lg border border-[#EDE7E6] bg-white px-3 py-2.5 text-xs font-semibold text-[#5D5D5D] hover:border-[#B12B35]/30 transition-colors"
                  >
                    Fix Mappings
                  </Link>
                </div>
              </div>
            )}
          </CardContent>
        </Card>
      </div>

      {/* ── Analytics Section ── */}
      {an && (
        <>
          <SectionLabel icon={BarChart3} label="Analytics" color="#B12B35" />

          {/* Ratio KPIs */}
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
            <Card className="border-[#EDE7E6] bg-white overflow-hidden">
              <div className="h-1 bg-[#B12B35]" />
              <CardHeader className="flex flex-row items-center justify-between pb-2 pt-4">
                <CardTitle className="text-sm font-medium text-[#5D5D5D]">Qualification Rate</CardTitle>
                <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-[#B12B35]/10">
                  <BadgePercent className="h-4 w-4 text-[#B12B35]" />
                </div>
              </CardHeader>
              <CardContent>
                <div className="text-3xl font-bold text-[#232222]">{an.qualification_ratio}%</div>
              </CardContent>
            </Card>

            <Card className="border-[#EDE7E6] bg-white overflow-hidden">
              <div className="h-1 bg-green-500" />
              <CardHeader className="flex flex-row items-center justify-between pb-2 pt-4">
                <CardTitle className="text-sm font-medium text-[#5D5D5D]">Win Rate</CardTitle>
                <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-green-50">
                  <TrendingUp className="h-4 w-4 text-green-600" />
                </div>
              </CardHeader>
              <CardContent>
                <div className="text-3xl font-bold text-[#232222]">{an.win_rate}%</div>
              </CardContent>
            </Card>

            <Card className="border-[#EDE7E6] bg-white overflow-hidden">
              <div className="h-1 bg-[#003466]" />
              <CardHeader className="flex flex-row items-center justify-between pb-2 pt-4">
                <CardTitle className="text-sm font-medium text-[#5D5D5D]">Pipeline Value</CardTitle>
                <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-[#003466]/10">
                  <Banknote className="h-4 w-4 text-[#003466]" />
                </div>
              </CardHeader>
              <CardContent>
                <div className="text-2xl xl:text-3xl font-bold text-[#232222] break-all leading-tight">
                  ${an.pipeline_value.toLocaleString(undefined, { maximumFractionDigits: 0 })}
                </div>
              </CardContent>
            </Card>

            <Card className="border-[#EDE7E6] bg-white overflow-hidden">
              <div className="h-1 bg-[#2E75B6]" />
              <CardHeader className="flex flex-row items-center justify-between pb-2 pt-4">
                <CardTitle className="text-sm font-medium text-[#5D5D5D]">Active Accounts</CardTitle>
                <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-[#2E75B6]/10">
                  <Building2 className="h-4 w-4 text-[#2E75B6]" />
                </div>
              </CardHeader>
              <CardContent>
                <div className="text-3xl font-bold text-[#232222]">{s.total_accounts}</div>
              </CardContent>
            </Card>
          </div>

          {/* Region · Vertical · Top Accounts */}
          <div className="grid gap-4 lg:grid-cols-3">
            <Card className="border-[#EDE7E6] bg-white">
              <CardHeader className="pb-3">
                <CardTitle className="text-sm font-semibold text-[#232222] flex items-center gap-2">
                  <Globe className="h-4 w-4 text-[#2E75B6]" /> Leads by Region
                </CardTitle>
                <CardDescription>Geographic pipeline distribution</CardDescription>
              </CardHeader>
              <CardContent>
                {an.leads_by_region.length === 0 ? (
                  <p className="text-sm text-muted-foreground">No region data yet.</p>
                ) : (() => {
                  const maxR = Math.max(...an.leads_by_region.map((r) => r.count), 1);
                  return (
                    <div className="space-y-3">
                      {an.leads_by_region.map((r) => (
                        <div key={r.region}>
                          <div className="flex items-center justify-between text-sm">
                            <span className="font-medium text-[#232222] truncate max-w-[65%]">{r.region}</span>
                            <span className="text-[#5D5D5D] text-xs font-semibold">{r.count}</span>
                          </div>
                          <MiniBar value={r.count} max={maxR} color="#2E75B6" />
                        </div>
                      ))}
                    </div>
                  );
                })()}
              </CardContent>
            </Card>

            <Card className="border-[#EDE7E6] bg-white">
              <CardHeader className="pb-3">
                <CardTitle className="text-sm font-semibold text-[#232222] flex items-center gap-2">
                  <BarChart3 className="h-4 w-4 text-[#B12B35]" /> Leads by Vertical
                </CardTitle>
                <CardDescription>Industry / Practice coverage</CardDescription>
              </CardHeader>
              <CardContent>
                {an.leads_by_vertical.length === 0 ? (
                  <p className="text-sm text-muted-foreground">No vertical data yet.</p>
                ) : (() => {
                  const maxV = Math.max(...an.leads_by_vertical.map((v) => v.count), 1);
                  return (
                    <div className="space-y-3">
                      {an.leads_by_vertical.map((v) => (
                        <div key={v.vertical}>
                          <div className="flex items-center justify-between text-sm">
                            <span className="font-medium text-[#232222] truncate max-w-[65%]">{v.vertical}</span>
                            <span className="text-[#5D5D5D] text-xs font-semibold">{v.count}</span>
                          </div>
                          <MiniBar value={v.count} max={maxV} color="#B12B35" />
                        </div>
                      ))}
                    </div>
                  );
                })()}
              </CardContent>
            </Card>

            <Card className="border-[#EDE7E6] bg-white">
              <CardHeader className="pb-3">
                <CardTitle className="text-sm font-semibold text-[#232222] flex items-center gap-2">
                  <Building2 className="h-4 w-4 text-[#003466]" /> Top Accounts
                </CardTitle>
                <CardDescription>By total leads submitted</CardDescription>
              </CardHeader>
              <CardContent>
                {an.top_accounts.length === 0 ? (
                  <p className="text-sm text-muted-foreground">No account data yet.</p>
                ) : (
                  <div className="divide-y divide-[#EDE7E6]">
                    {an.top_accounts.map((a, idx) => (
                      <div key={`${a.account_name}-${idx}`} className="flex items-center justify-between py-2 text-sm">
                        <span className="font-medium text-[#232222] truncate max-w-[55%]">{a.account_name}</span>
                        <div className="flex items-center gap-2">
                          <Badge variant="outline" className="text-[10px] px-1.5 py-0 bg-[#B12B35]/10 text-[#B12B35] border-[#B12B35]/20">{a.leads}L</Badge>
                          {/* <Badge ...>{a.ideas}I</Badge> — Value Ideas disabled */}
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>
          </div>

          {/* Reviewer Turnaround */}
          <Card className="border-[#EDE7E6] bg-white">
            <CardHeader>
              <CardTitle className="text-base font-semibold text-[#232222] flex items-center gap-2">
                <Clock className="h-4 w-4 text-[#5D5D5D]" /> Reviewer Turnaround
              </CardTitle>
              <CardDescription>Average days from assignment to action, per reviewer role</CardDescription>
            </CardHeader>
            <CardContent>
              {an.turnaround.length === 0 ? (
                <p className="text-sm text-muted-foreground">No completed reviews yet — turnaround data will appear once assignments are acted on.</p>
              ) : (() => {
                const maxDays = Math.max(...an.turnaround.map((t) => t.avg_days), 1);
                return (
                  <div className="space-y-4">
                    {an.turnaround.map((t) => (
                      <div key={t.role}>
                        <div className="flex items-center justify-between text-sm mb-1">
                          <span className="font-medium text-[#232222] capitalize">{t.role.replace(/_/g, " ")}</span>
                          <div className="flex items-center gap-3">
                            <span className="text-xs text-[#5D5D5D]">{t.count} reviews</span>
                            <span className="font-bold text-[#232222] w-16 text-right">
                              {t.avg_days < 1 ? `${Math.round(t.avg_days * 24)}h` : `${t.avg_days}d`}
                            </span>
                          </div>
                        </div>
                        <div className="h-2 w-full rounded-full bg-[#EDE7E6] overflow-hidden">
                          <div
                            className="h-full rounded-full"
                            style={{
                              width: `${Math.round((t.avg_days / maxDays) * 100)}%`,
                              background: t.avg_days <= 2 ? "#22c55e" : t.avg_days <= 5 ? "#2E75B6" : "#B12B35",
                            }}
                          />
                        </div>
                      </div>
                    ))}
                  </div>
                );
              })()}
            </CardContent>
          </Card>
        </>
      )}

      {/* ── User/Account Management + Completeness + Leaderboard ── */}
      <SectionLabel icon={Building2} label="Management & Engagement" color="#2E75B6" />
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <StatCard
          title="Active Users"
          value={s.active_users}
          desc="Portal contributors"
          icon={ShieldCheck}
          iconColor="text-[#2E75B6]"
          iconBg="bg-[#2E75B6]/10"
          accent="#2E75B6"
          href="/admin/users"
        />
        <StatCard
          title="Total Accounts"
          value={s.total_accounts}
          desc="Client accounts tracked"
          icon={Building2}
          iconColor="text-[#003466]"
          iconBg="bg-[#003466]/10"
          accent="#003466"
          href="/accounts"
        />
      </div>

      <div className="grid gap-4 lg:grid-cols-2">
        <StakeholderCompletenessCard token={token} showList={true} />
        <MiniLeaderboard token={token} />
      </div>

      {/* ── Recent Activity ── */}
      <SectionLabel icon={Activity} label="Recent Activity" color="#5D5D5D" />
      <Card className="border-[#EDE7E6] bg-white">
        <CardContent className="pt-4">
          {activity.length === 0 ? (
            <p className="text-sm text-muted-foreground">No recent activity.</p>
          ) : (
            <div className="divide-y divide-[#EDE7E6]">
              {activity.map((a, idx) => (
                <div key={idx} className="flex items-start gap-3 py-3 text-sm">
                  <div className="mt-2 h-2 w-2 shrink-0 rounded-full" style={{ background: STATUS_COLORS[a.to_status] || "#C5C5C5" }} />
                  <div className="flex-1 min-w-0">
                    <p className="font-semibold truncate text-[#232222]">{a.title}</p>
                    <p className="text-xs text-[#5D5D5D] mt-0.5 flex items-center flex-wrap gap-1">
                      <span>{a.changed_by}</span>
                      <span className="text-[#C5C5C5]">moved {a.type}</span>
                      <Badge variant="outline" className={`capitalize text-[10px] px-1.5 py-0 ${STATUS_BADGE[a.from_status] || ""}`}>{a.from_status?.replace(/_/g, " ")}</Badge>
                      <ArrowRight className="h-3 w-3 text-[#C5C5C5]" />
                      <Badge variant="outline" className={`capitalize text-[10px] px-1.5 py-0 ${STATUS_BADGE[a.to_status] || ""}`}>{a.to_status?.replace(/_/g, " ")}</Badge>
                    </p>
                  </div>
                  <span className="text-[11px] text-[#C5C5C5] whitespace-nowrap pt-0.5">{timeAgo(a.changed_at)}</span>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}

// ── Executive / Leadership dashboard ──────────────────────────────────────

function ExecutiveDashboard({ token, userName }: { token: string; userName: string }) {
  const [stats, setStats] = useState<OrgStats | null>(null);
  const [analytics, setAnalytics] = useState<AdminAnalytics | null>(null);
  const [topLeads, setTopLeads] = useState<AssignmentWithRelations[]>([]);
  const [monthlyTrend, setMonthlyTrend] = useState<MonthlyPoint[]>([]);
  const [activity, setActivity] = useState<Activity[]>([]);
  const [loading, setLoading] = useState(true);

  const load = useCallback(async () => {
    try {
      const [s, an, myAssignments, trend, act] = await Promise.all([
        api<OrgStats>("/api/dashboard/stats", { token }),
        api<AdminAnalytics>("/api/dashboard/admin-analytics", { token }),
        api<AssignmentWithRelations[]>("/api/assignments/mine", { token }),
        api<MonthlyPoint[]>("/api/dashboard/monthly-trend", { token }),
        api<Activity[]>("/api/dashboard/recent-activity?limit=20", { token }),
      ]);
      setStats(s);
      setAnalytics(an);
      // "Needing Attention" — only leads THIS reviewer is actually assigned to
      // and can action: their own pending lead-assignments still in the
      // pre-qualified stage. Same source as the Pending Review tab, so the
      // card and that tab never disagree. Oldest assignment first.
      setTopLeads(
        Array.isArray(myAssignments)
          ? [...myAssignments]
              .filter(
                (a) =>
                  a.action_taken === "pending" &&
                  a.submission_type === "lead" &&
                  (!a.submission_status ||
                    ["submitted", "routing_pending", "under_review"].includes(
                      a.submission_status
                    ))
              )
              .sort(
                (a, b) =>
                  new Date(a.assignment_date || a.created_at).getTime() -
                  new Date(b.assignment_date || b.created_at).getTime()
              )
              .slice(0, 5)
          : []
      );
      setMonthlyTrend(Array.isArray(trend) ? trend : []);
      // Strategic highlights: only status transitions that matter to leadership
      const STRATEGIC = ["qualified", "opportunity_created", "won", "lost", "rejected"];
      setActivity(
        Array.isArray(act)
          ? act.filter((a) => STRATEGIC.includes(a.to_status)).slice(0, 8)
          : []
      );
    } catch { /* silent */ }
    finally { setLoading(false); }
  }, [token]);

  useEffect(() => {
    load();
    const interval = setInterval(load, 30_000);
    return () => clearInterval(interval);
  }, [load]);

  if (loading) return <div className="flex items-center justify-center py-20 text-muted-foreground">Loading dashboard…</div>;

  const s = stats ?? { total_leads: 0, total_ideas: 0, total_accounts: 0, active_users: 0, leads_by_status: {}, ideas_by_status: {}, pending_assignments: 0 };
  const an = analytics;

  // Funnel stages — all real pipeline stages from DB
  const totalActive =
    (s.leads_by_status["submitted"] || 0) +
    (s.leads_by_status["routing_pending"] || 0) +
    (s.leads_by_status["under_review"] || 0) +
    (s.leads_by_status["qualified"] || 0) +
    (s.leads_by_status["opportunity_created"] || 0) +
    (s.leads_by_status["won"] || 0);

  // BRD §5.2.2 — pipeline reflects the 5 high-level stages
  const funnelStages = [
    { label: "Awaiting Review (Routing Pending)",     count: (s.leads_by_status["submitted"] || 0) + (s.leads_by_status["routing_pending"] || 0), color: "#2E75B6" },
    { label: "Under Review",        count: s.leads_by_status["under_review"] || 0,        color: "#003466" },
    { label: "Qualified",           count: (s.leads_by_status["qualified"] || 0) + (s.leads_by_status["approved"] || 0), color: "#0d9488" },
    { label: "Rejected",            count: s.leads_by_status["rejected"] || 0,            color: "#B12B35" },
    { label: "Opportunity Created", count: s.leads_by_status["opportunity_created"] || 0, color: "#7c3aed" },
    { label: "Won / Lost",          count: (s.leads_by_status["won"] || 0) + (s.leads_by_status["lost"] || 0), color: "#22c55e" },
  ].filter((stage) => totalActive === 0 || stage.count > 0 || stage.label === "Awaiting Review (Routing Pending)");

  return (
    <div className="space-y-6">

      {/* ── Header ── */}
      <div className="flex items-start justify-between">
        <div>
          {/* <div className="flex items-center gap-2 mb-1">
            <BarChart3 className="h-4 w-4 text-[#003466]" />
            <span className="text-[11px] font-semibold text-[#003466] uppercase tracking-widest">
              Leadership Dashboard
            </span>
          </div> */}
          <h1 className="text-2xl font-bold tracking-tight text-[#232222]">
            Leadership Dashboard
          </h1>
          <p className="text-sm text-[#5D5D5D] mt-1 max-w-2xl leading-relaxed">
            Welcome, {userName.split(" ")[0]}. A Unified View of Leadership Priorities, Key Metrics,
            and Progress to Support Faster Alignment and Informed Decision-Making.
          </p>
        </div>
        <Badge className="bg-[#003466] text-white border-0 text-[11px] px-3 py-1">Leadership View</Badge>
      </div>

      {/* ── 5 Primary KPIs ── */}
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-2 xl:grid-cols-4">
        <Card className="border-[#EDE7E6] bg-white overflow-hidden hover:shadow-md transition-shadow">
          <div className="h-1 bg-[#B12B35]" />
          <CardHeader className="flex flex-row items-center justify-between pb-2 pt-4">
            <CardTitle className="text-sm font-medium text-[#5D5D5D]">Pipeline Value</CardTitle>
            <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-[#B12B35]/10">
              <Banknote className="h-4 w-4 text-[#B12B35]" />
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-[#232222] tracking-tight">
              ${(an?.pipeline_value ?? 0).toLocaleString(undefined, { maximumFractionDigits: 0 })}
            </div>
            <p className="text-xs text-[#5D5D5D] mt-1">Total active pipeline</p>
          </CardContent>
        </Card>

        <Card className="border-[#EDE7E6] bg-white overflow-hidden hover:shadow-md transition-shadow">
          <div className="h-1 bg-green-500" />
          <CardHeader className="flex flex-row items-center justify-between pb-2 pt-4">
            <CardTitle className="text-sm font-medium text-[#5D5D5D]">Won to Date</CardTitle>
            <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-green-50">
              <Trophy className="h-4 w-4 text-green-600" />
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-[#232222] tracking-tight">
              ${(an?.won_value ?? 0).toLocaleString(undefined, { maximumFractionDigits: 0 })}
            </div>
            <p className="text-xs text-[#5D5D5D] mt-1">
              {s.leads_by_status["won"] || 0} deal{(s.leads_by_status["won"] || 0) !== 1 ? "s" : ""} closed
            </p>
          </CardContent>
        </Card>

        <Card className="border-[#EDE7E6] bg-white overflow-hidden hover:shadow-md transition-shadow">
          <div className="h-1 bg-green-500" />
          <CardHeader className="flex flex-row items-center justify-between pb-2 pt-4">
            <CardTitle className="text-sm font-medium text-[#5D5D5D]">Win Rate</CardTitle>
            <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-green-50">
              <TrendingUp className="h-4 w-4 text-green-600" />
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#232222] tracking-tight">
              {an?.win_rate ?? 0}%
            </div>
            <p className="text-xs text-[#5D5D5D] mt-1">
              {an?.won_count ?? 0}W / {an?.lost_count ?? 0}L closed
            </p>
          </CardContent>
        </Card>

        <Card className="border-[#EDE7E6] bg-white overflow-hidden hover:shadow-md transition-shadow">
          <div className="h-1 bg-[#003466]" />
          <CardHeader className="flex flex-row items-center justify-between pb-2 pt-4">
            <CardTitle className="text-sm font-medium text-[#5D5D5D]">Conversion Rate</CardTitle>
            <div className="flex h-9 w-9 items-center justify-center rounded-xl bg-[#003466]/10">
              <BadgePercent className="h-4 w-4 text-[#003466]" />
            </div>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-[#232222] tracking-tight">
              {an?.qualification_ratio ?? 0}%
            </div>
            <p className="text-xs text-[#5D5D5D] mt-1">leads reaching qualified+</p>
          </CardContent>
        </Card>
      </div>

      {/* ── Lead Status Breakdown + Monthly Value Realization ── */}
      <div className="grid gap-4 lg:grid-cols-2">
        {/* Lead Status Breakdown */}
        <Card className="border-[#EDE7E6] bg-white">
          <CardHeader className="pb-3">
            <CardTitle className="text-base font-semibold text-[#232222] flex items-center gap-2">
              <Activity className="h-4 w-4 text-[#B12B35]" />
              Lead Status Breakdown
            </CardTitle>
            <CardDescription>Leads across all pipeline stages</CardDescription>
          </CardHeader>
          <CardContent>
            <FunnelChart stages={funnelStages} />
            {/* Lost / dropped row below chart */}
            <div className="mt-4 pt-3 border-t border-[#EDE7E6] grid grid-cols-2 gap-2">
              <div className="flex items-center gap-2 text-xs">
                <div className="h-2.5 w-2.5 rounded-sm bg-[#C5C5C5]" />
                <span className="text-[#5D5D5D]">Lost</span>
                <span className="font-semibold text-[#232222] ml-auto">{s.leads_by_status["lost"] || 0}</span>
              </div>
              <div className="flex items-center gap-2 text-xs">
                <div className="h-2.5 w-2.5 rounded-sm bg-[#EDE7E6]" />
                <span className="text-[#5D5D5D]">Rejected</span>
                <span className="font-semibold text-[#232222] ml-auto">{s.leads_by_status["rejected"] || 0}</span>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Monthly Value Realization — real data */}
        <Card className="border-[#EDE7E6] bg-white">
          <CardHeader className="pb-3">
            <div className="flex items-center justify-between">
              <div>
                <CardTitle className="text-base font-semibold text-[#232222] flex items-center gap-2">
                  <TrendingUp className="h-4 w-4 text-[#B12B35]" />
                  Monthly Value Realization
                </CardTitle>
                <CardDescription>Pipeline vs won value — last 12 months</CardDescription>
              </div>
              {monthlyTrend.length > 0 && (
                <Badge variant="outline" className="text-[10px] text-[#5D5D5D] border-[#EDE7E6]">
                  Live
                </Badge>
              )}
            </div>
          </CardHeader>
          <CardContent>
            <MonthlyTrendChart data={monthlyTrend} />
          </CardContent>
        </Card>
      </div>

      {/* ── Monthly Submissions Volume ── */}
      {monthlyTrend.length > 0 && (
        <Card className="border-[#EDE7E6] bg-white">
          <CardHeader className="pb-2">
            <CardTitle className="text-base font-semibold text-[#232222] flex items-center gap-2">
              <BarChart3 className="h-4 w-4 text-[#2E75B6]" />
              Monthly Submission Volume
            </CardTitle>
            <CardDescription>Leads submitted per month (last 12 months)</CardDescription>
          </CardHeader>
          <CardContent>
            <MonthlySubmissionsChart data={monthlyTrend} />
            <div className="flex items-center justify-between mt-1">
              <span className="text-[11px] text-[#5D5D5D]">
                Peak month: <span className="font-semibold text-[#232222]">
                  {monthlyTrend.reduce((p, c) => c.submissions > p.submissions ? c : p, monthlyTrend[0]).label}
                </span>
              </span>
              <span className="text-[11px] text-[#5D5D5D]">
                Avg/month: <span className="font-semibold text-[#232222]">
                  {Math.round(monthlyTrend.reduce((s, d) => s + d.submissions, 0) / monthlyTrend.length)}
                </span>
              </span>
            </div>
          </CardContent>
        </Card>
      )}

      {/* ── Top Opportunities Needing Attention ── */}
      <Card className="border-[#EDE7E6] bg-white">
        <CardHeader className="flex flex-row items-center justify-between pb-3">
          <div>
            <CardTitle className="text-base font-semibold text-[#232222]">
              Top Opportunities Needing Attention
            </CardTitle>
            <CardDescription>Your pending reviews — click to take action</CardDescription>
          </div>
          <Link
            href="/assignments?tab=pending"
            className="text-xs font-medium text-[#B12B35] hover:underline flex items-center gap-1"
          >
            View all <ChevronRight className="h-3 w-3" />
          </Link>
        </CardHeader>
        <CardContent className="p-0">
          {topLeads.length === 0 ? (
            <p className="text-sm text-muted-foreground px-6 pb-4">
              No leads pending your review.
            </p>
          ) : (
            <div className="divide-y divide-[#EDE7E6]">
              {/* Table header */}
              <div className="grid grid-cols-[2fr_1.5fr_1fr_1fr] gap-3 px-6 py-2 bg-[#F9F9F9] text-[11px] font-semibold text-[#5D5D5D] uppercase tracking-wider">
                <span>Opportunity</span>
                <span>Account</span>
                <span>Assigned</span>
                <span className="text-right">Status</span>
              </div>
              {topLeads.map((a, i) => {
                const status = a.submission_status || "under_review";
                return (
                  <Link
                    key={a.assignment_id}
                    href={`/assignments?tab=pending&highlight=${a.submission_id}`}
                  >
                    <div className="grid grid-cols-[2fr_1.5fr_1fr_1fr] gap-3 px-6 py-3 items-center hover:bg-[#F9F9F9] transition-colors text-sm">
                      {/* Title + number */}
                      <div className="flex items-center gap-2 min-w-0">
                        <span className="text-[11px] text-[#C5C5C5] font-mono w-5 shrink-0">{i + 1}</span>
                        <span className="font-medium text-[#232222] truncate">
                          {a.submission_title || "Untitled"}
                        </span>
                      </div>
                      {/* Account */}
                      <span className="text-xs text-[#5D5D5D] truncate">
                        {a.account_name || "—"}
                      </span>
                      {/* Time ago */}
                      <span className="text-xs text-[#5D5D5D]">
                        {a.assignment_date ? timeAgo(a.assignment_date) : "—"}
                      </span>
                      {/* Status */}
                      <div className="text-right">
                        <Badge
                          variant="outline"
                          className={`capitalize text-[10px] px-1.5 py-0 ${STATUS_BADGE[status] || "bg-[#C5C5C5]/20 text-[#5D5D5D]"}`}
                        >
                          {status.replace(/_/g, " ")}
                        </Badge>
                      </div>
                    </div>
                  </Link>
                );
              })}
            </div>
          )}
        </CardContent>
      </Card>

      {/* Review Cycle Performance removed */}

      {/* ── Breakdown ── */}
      {an && (an.leads_by_region.length > 0 || an.leads_by_vertical.length > 0) && (
        <>
          <SectionLabel icon={Globe} label="Regional & Vertical Breakdown" color="#2E75B6" />
          <div className="grid gap-4 lg:grid-cols-2">
            <Card className="border-[#EDE7E6] bg-white">
              <CardHeader className="pb-3">
                <CardTitle className="text-sm font-semibold text-[#232222] flex items-center gap-2">
                  <Globe className="h-4 w-4 text-[#2E75B6]" /> Leads by Region
                </CardTitle>
              </CardHeader>
              <CardContent>
                {(() => {
                  const maxR = Math.max(...an.leads_by_region.map((r) => r.count), 1);
                  return (
                    <div className="space-y-3">
                      {an.leads_by_region.map((r) => (
                        <div key={r.region}>
                          <div className="flex items-center justify-between text-sm">
                            <span className="font-medium text-[#232222] truncate max-w-[65%]">{r.region}</span>
                            <span className="text-[#5D5D5D] text-xs font-semibold">{r.count}</span>
                          </div>
                          <MiniBar value={r.count} max={maxR} color="#2E75B6" />
                        </div>
                      ))}
                    </div>
                  );
                })()}
              </CardContent>
            </Card>
            <Card className="border-[#EDE7E6] bg-white">
              <CardHeader className="pb-3">
                <CardTitle className="text-sm font-semibold text-[#232222] flex items-center gap-2">
                  <BarChart3 className="h-4 w-4 text-[#B12B35]" /> Leads by Vertical
                </CardTitle>
              </CardHeader>
              <CardContent>
                {(() => {
                  const maxV = Math.max(...an.leads_by_vertical.map((v) => v.count), 1);
                  return (
                    <div className="space-y-3">
                      {an.leads_by_vertical.map((v) => (
                        <div key={v.vertical}>
                          <div className="flex items-center justify-between text-sm">
                            <span className="font-medium text-[#232222] truncate max-w-[65%]">{v.vertical}</span>
                            <span className="text-[#5D5D5D] text-xs font-semibold">{v.count}</span>
                          </div>
                          <MiniBar value={v.count} max={maxV} color="#B12B35" />
                        </div>
                      ))}
                    </div>
                  );
                })()}
              </CardContent>
            </Card>
          </div>
        </>
      )}

      {/* ── Exception Queue Summary + Stakeholder Completeness + Leaderboard ── */}
      <SectionLabel icon={ShieldCheck} label="Operations & Engagement" color="#5D5D5D" />
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {/* Exception Queue summary card — executive read-only view */}
        <StatCard
          title="Routing Exceptions"
          value={an ? an.routing_pending_leads : 0}
          desc="Submissions pending routing"
          icon={AlertTriangle}
          iconColor="text-amber-500"
          iconBg="bg-amber-50"
          accent="#f59e0b"
          href="/executive/exception-queue"
        />
        {/* Placeholder to keep grid alignment */}
        <div className="hidden lg:block" />
        <div className="hidden lg:block" />
      </div>

      <div className="grid gap-4 lg:grid-cols-2">
        <div className="hidden" />{/* Stakeholder Completeness removed */}
        <MiniLeaderboard token={token} />
      </div>

      {/* ── Strategic Highlights ── */}
      <SectionLabel icon={Activity} label="Strategic Highlights" color="#003466" />
      <Card className="border-[#EDE7E6] bg-white">
        <CardContent className="pt-4">
          {activity.length === 0 ? (
            <p className="text-sm text-muted-foreground">No key status transitions yet.</p>
          ) : (
            <div className="divide-y divide-[#EDE7E6]">
              {activity.map((a, idx) => (
                <div key={idx} className="flex items-start gap-3 py-3 text-sm">
                  <div className="mt-2 h-2 w-2 shrink-0 rounded-full" style={{ background: STATUS_COLORS[a.to_status] || "#C5C5C5" }} />
                  <div className="flex-1 min-w-0">
                    <p className="font-semibold truncate text-[#232222]">{a.title}</p>
                    <p className="text-xs text-[#5D5D5D] mt-0.5 flex items-center flex-wrap gap-1">
                      <span>{a.changed_by}</span>
                      <span className="text-[#C5C5C5]">moved {a.type}</span>
                      <Badge variant="outline" className={`capitalize text-[10px] px-1.5 py-0 ${STATUS_BADGE[a.from_status] || ""}`}>{a.from_status?.replace(/_/g, " ")}</Badge>
                      <ArrowRight className="h-3 w-3 text-[#C5C5C5]" />
                      <Badge variant="outline" className={`capitalize text-[10px] px-1.5 py-0 ${STATUS_BADGE[a.to_status] || ""}`}>{a.to_status?.replace(/_/g, " ")}</Badge>
                    </p>
                  </div>
                  <span className="text-[11px] text-[#C5C5C5] whitespace-nowrap pt-0.5">{timeAgo(a.changed_at)}</span>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}

// ── User dashboard (personal data only) ────────────────────────────────────

type UserDashData = {
  myLeads: number;
  myScore: number;
  myUnderReview: number;
  leadsByStatus: Record<string, number>;
};

async function fetchUserDashData(
  token: string,
  userId: string
): Promise<UserDashData> {
  const [leadsRaw, scoreRaw] = await Promise.all([
    api<LeadWithRelations[]>("/api/leads", { token }),
    // api<IdeaWithRelations[]>("/api/ideas", { token }), // Value Ideas disabled
    api<{ total_points: number }>("/api/scores/me", { token }),
  ]);

  const myLeads = leadsRaw.filter((l) => l.submitted_by === userId);

  const leadsByStatus = myLeads.reduce<Record<string, number>>((acc, l) => {
    acc[l.status] = (acc[l.status] || 0) + 1;
    return acc;
  }, {});

  const myUnderReview = myLeads.filter((l) =>
    ["submitted", "routing_pending", "under_review"].includes(l.status)
  ).length;

  return {
    myLeads: myLeads.length,
    myScore: scoreRaw.total_points || 0,
    myUnderReview,
    leadsByStatus,
  };
}

function UserDashboard({
  token, userName, userId,
}: {
  token: string; userName: string; userId: string;
}) {
  // React Query caches this result. On revisit the cached data renders
  // instantly (no spinner) while a background refetch keeps it current.
  // refetchInterval polls every 15s so newly routed leads surface quickly.
  const { data, isLoading } = useQuery({
    queryKey: ["user-dashboard", userId],
    queryFn: () => fetchUserDashData(token, userId),
    enabled: !!token && !!userId,
    refetchInterval: 15_000,
  });

  // Only show the full-page loader on the very first load, when there is
  // no cached data yet. On every later visit `data` is already populated.
  if (isLoading && !data) {
    return <div className="flex items-center justify-center py-20 text-muted-foreground">Loading dashboard…</div>;
  }

  const d = data ?? { myLeads: 0, myScore: 0, myUnderReview: 0, leadsByStatus: {} };

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight text-[#232222]">
          Welcome, {userName.split(" ")[0]}
        </h1>
        <p className="text-muted-foreground text-sm mt-1">
          Track your leads and see your impact.
        </p>
      </div>

      {/* BRD §5.2.1 — exactly 3 KPI cards: Leads Submitted, Score, Under Review */}
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        <StatCard
          title="Leads Submitted"
          value={d.myLeads}
          icon={Target}
          iconColor="text-[#B12B35]"
          iconBg="bg-[#B12B35]/10"
          accent="#B12B35"
          href="/leads"
        />
        <StatCard
          title="Score"
          value={d.myScore.toLocaleString()}
          icon={Trophy}
          iconColor="text-[#B12B35]"
          iconBg="bg-[#B12B35]/10"
          accent="#B12B35"
          href="/leaderboard"
        />
        <StatCard
          title="Under Review"
          value={d.leadsByStatus["under_review"] || 0}
          desc="Leads currently being reviewed"
          icon={ClipboardList}
          iconColor="text-[#2E75B6]"
          iconBg="bg-[#2E75B6]/10"
          accent="#2E75B6"
          href="/leads?status=under_review"
        />
      </div>

      {/* My lead pipeline only — Value Ideas pipeline disabled */}
      <div className="grid gap-4 lg:grid-cols-1">
        <Card className="border-[#EDE7E6] bg-white">
          <CardHeader>
            <CardTitle className="text-base text-[#232222]">My Lead Pipeline</CardTitle>
            <CardDescription>Your leads by current status</CardDescription>
          </CardHeader>
          <CardContent>
            {Object.keys(d.leadsByStatus).length === 0 ? (
              <div className="py-6 text-center">
                <p className="text-sm text-muted-foreground mb-3">No leads submitted yet.</p>
                <Link href="/leads/new" className="inline-flex items-center gap-1.5 rounded-lg bg-[#B12B35] px-4 py-2 text-sm font-semibold text-white hover:bg-[#9a2330] transition-colors">
                  <Target className="h-4 w-4" /> Submit a Lead
                </Link>
              </div>
            ) : (
              <WorkflowPipelineChart data={d.leadsByStatus} />
            )}
          </CardContent>
        </Card>
      </div>


      {/* Quick actions */}
      <Card className="border-[#EDE7E6] bg-white">
        <CardHeader>
          <CardTitle className="text-base text-[#232222]">Quick Actions</CardTitle>
          <CardDescription>Submit and track your contributions</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="flex flex-wrap gap-3">
            <Link href="/leads/new" className="inline-flex items-center gap-2 rounded-lg border border-[#B12B35] bg-[#B12B35]/5 px-4 py-2 text-sm font-semibold text-[#B12B35] hover:bg-[#B12B35]/10 transition-colors">
              <Target className="h-4 w-4" /> Submit New Lead
            </Link>
            {/* View My Assignments removed from quick actions */}
            {/* Submit Value Idea link disabled
            <Link href="/ideas/new" ...>Submit Value Idea</Link>
            */}
          </div>
        </CardContent>
      </Card>

      {/* Mini leaderboard */}
      <MiniLeaderboard token={token} />
    </div>
  );
}

// ── Root page ──────────────────────────────────────────────────────────────

export default function DashboardPage() {
  const { user, token } = useAuth();

  if (!token || !user) {
    return <div className="flex items-center justify-center py-20 text-muted-foreground">Loading…</div>;
  }

  if (user.role === "admin") {
    return <AdminDashboard token={token} userName={user.full_name || user.email} />;
  }

  if (user.role === "executive") {
    return <ExecutiveDashboard token={token} userName={user.full_name || user.email} />;
  }

  return <UserDashboard token={token} userName={user.full_name || user.email} userId={user.id} />;
}
