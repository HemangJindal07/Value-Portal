"use client";

import Link from "next/link";
import Image from "next/image";
import { usePathname } from "next/navigation";
import {
  LayoutDashboard,
  Building2,
  // Lightbulb, // Value Ideas nav disabled
  Target,
  ClipboardList,
  Trophy,
  Bell,
  Settings,
  ShieldCheck,
  BarChart3,
  GitMerge,
  Route,
  AlertTriangle,
  Star,
} from "lucide-react";
import {
  Sidebar,
  SidebarContent,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarFooter,
} from "@/components/ui/sidebar";
import { useAuth } from "@/lib/auth-context";

// ─── Admin nav (full access) ──────────────────────────────────────────────
const ADMIN_NAV = [
  {
    label: "Main",
    items: [
      { title: "Dashboard",       href: "/",              icon: LayoutDashboard },
      { title: "Accounts",        href: "/accounts",      icon: Building2 },
      { title: "Leads",           href: "/leads",         icon: Target },
      // { title: "Value Ideas",     href: "/ideas",         icon: Lightbulb },
      { title: "My Assignments",  href: "/assignments",   icon: ClipboardList },
    ],
  },
  {
    label: "Insights",
    items: [
      { title: "Leaderboard", href: "/leaderboard", icon: Trophy },
      { title: "Reports",     href: "/reports",     icon: BarChart3 },
      { title: "Reviews",     href: "/reviews",     icon: ShieldCheck },
    ],
  },
  {
    label: "System",
    items: [
      { title: "Notifications",        href: "/notifications",                icon: Bell },
      { title: "Exception Queue",      href: "/admin/exception-queue",        icon: AlertTriangle },
      { title: "Stakeholder Mapping",  href: "/admin/stakeholder-mapping",    icon: GitMerge },
      { title: "Routing Config",       href: "/admin/routing-config",         icon: Route },
      { title: "Admin",                href: "/admin/users",                  icon: Settings },
    ],
  },
];

// ─── Executive nav (org-wide read access, no system admin) ────────────────
const EXECUTIVE_NAV = [
  {
    label: "Main",
    items: [
      { title: "Dashboard",      href: "/",            icon: LayoutDashboard },
      { title: "Leads",          href: "/leads",       icon: Target },
      // { title: "Value Ideas",    href: "/ideas",       icon: Lightbulb },
      { title: "My Assignments", href: "/assignments", icon: ClipboardList },
    ],
  },
  {
    label: "Insights",
    items: [
      { title: "Leaderboard", href: "/leaderboard", icon: Trophy },
      { title: "Reports",     href: "/reports",     icon: BarChart3 },
      { title: "Reviews",     href: "/reviews",     icon: ShieldCheck },
    ],
  },
  {
    label: "System",
    items: [
      { title: "Notifications", href: "/notifications", icon: Bell },
    ],
  },
];

// ─── End-user nav (delivery_manager / sales / practice_lead) ─────────────
const USER_NAV = [
  {
    label: "Main",
    items: [
      { title: "Dashboard",      href: "/",            icon: LayoutDashboard },
      { title: "Leads",          href: "/leads",       icon: Target },
      // { title: "Value Ideas",    href: "/ideas",       icon: Lightbulb },
      { title: "My Assignments", href: "/assignments", icon: ClipboardList },
    ],
  },
  {
    label: "Insights",
    items: [
      { title: "Leaderboard", href: "/leaderboard", icon: Trophy },
      { title: "My Score",    href: "/leaderboard", icon: Star },
      { title: "Reports",     href: "/reports",     icon: BarChart3 },
    ],
  },
  {
    label: "System",
    items: [
      { title: "Notifications", href: "/notifications", icon: Bell },
    ],
  },
];

function NavGroup({
  label,
  items,
  pathname,
}: {
  label: string;
  items: { title: string; href: string; icon: React.ElementType }[];
  pathname: string;
}) {
  if (items.length === 0) return null;
  return (
    <SidebarGroup>
      <SidebarGroupLabel className="text-[10px] font-semibold tracking-widest text-[#C5C5C5] uppercase px-3 py-2">
        {label}
      </SidebarGroupLabel>
      <SidebarGroupContent>
        <SidebarMenu>
          {items.map((item) => (
            <SidebarMenuItem key={item.title}>
              <SidebarMenuButton
                isActive={
                  item.href === "/"
                    ? pathname === "/"
                    : pathname.startsWith(item.href)
                }
                render={<Link href={item.href} />}
                className="text-[#5D5D5D] hover:text-[#232222] hover:bg-[#F9F9F9] data-[active=true]:bg-[#B12B35]/10 data-[active=true]:text-[#B12B35] data-[active=true]:font-semibold rounded-md mx-1"
              >
                <item.icon className="h-4 w-4" />
                <span>{item.title}</span>
              </SidebarMenuButton>
            </SidebarMenuItem>
          ))}
        </SidebarMenu>
      </SidebarGroupContent>
    </SidebarGroup>
  );
}

export function AppSidebar() {
  const pathname = usePathname();
  const { user } = useAuth();

  const role = user?.role;
  const navGroups =
    role === "admin"
      ? ADMIN_NAV
      : role === "executive"
      ? EXECUTIVE_NAV
      : USER_NAV;

  return (
    <Sidebar className="bg-white border-r border-[#EDE7E6]">
      {/* ── Header — brand red background, white text ── */}
      <SidebarHeader className="bg-[#B12B35] px-4 py-4">
        <Link href="/" className="flex items-center gap-3">
          <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-lg bg-white p-1.5">
            <Image
              src="/txlogo.webp"
              alt="TestingXperts"
              width={44}
              height={44}
              className="object-contain"
              priority
            />
          </div>
          <div>
            <p className="text-sm font-bold text-white leading-none tracking-tight">
              Tx Catalyst
            </p>
            <p className="text-[11px] text-white/70 mt-0.5 tracking-wide">
              TestingXperts
            </p>
          </div>
        </Link>
      </SidebarHeader>

      {/* ── Nav — unchanged white sidebar ── */}
      <SidebarContent className="py-2">
        {navGroups.map((group) => (
          <NavGroup
            key={group.label}
            label={group.label}
            items={group.items}
            pathname={pathname}
          />
        ))}
      </SidebarContent>

      <SidebarFooter className="border-t border-[#EDE7E6] px-4 py-3">
        <p className="text-[11px] text-[#C5C5C5]">
          v0.1.0 &middot; TestingXperts
        </p>
      </SidebarFooter>
    </Sidebar>
  );
}
