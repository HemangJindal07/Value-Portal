"use client";

import Image from "next/image";
import { usePathname, useRouter } from "next/navigation";
import {
  LayoutDashboard,
  Building2,
  // Lightbulb, // Value Ideas nav disabled
  Target,
  ClipboardList,
  Trophy,
  Bell,
  Settings,
  GitMerge,
  Route,
  AlertTriangle,
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
import { useNavigationGuard } from "@/lib/navigation-guard-context";

// ─── Admin nav (full access) ──────────────────────────────────────────────
const ADMIN_NAV = [
  {
    label: "Main",
    items: [
      { title: "Dashboard",         href: "/",              icon: LayoutDashboard },
      { title: "Accounts",          href: "/accounts",      icon: Building2 },
      { title: "Submit New Lead",   href: "/leads/new",     icon: Target },
      // { title: "Value Ideas",     href: "/ideas",         icon: Lightbulb },
      { title: "My Assignments",    href: "/assignments",   icon: ClipboardList },
    ],
  },
  {
    label: "Insights",
    items: [
      { title: "Leaderboard", href: "/leaderboard", icon: Trophy },
      // { title: "Reports",  href: "/reports",     icon: BarChart3 }, // Reports hidden
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
      { title: "Dashboard",        href: "/",            icon: LayoutDashboard },
      { title: "Submit New Lead",  href: "/leads/new",  icon: Target },
      // { title: "Value Ideas",    href: "/ideas",       icon: Lightbulb },
      { title: "My Assignments",   href: "/assignments", icon: ClipboardList },
    ],
  },
  {
    label: "Insights",
    items: [
      { title: "Leaderboard", href: "/leaderboard", icon: Trophy },
      // { title: "Reports",  href: "/reports",     icon: BarChart3 }, // Reports hidden
    ],
  },
  {
    label: "System",
    items: [
      { title: "Notifications", href: "/notifications", icon: Bell },
    ],
  },
];

// ─── End-user nav (user / sales / practice_lead) ─────────────
const USER_NAV = [
  {
    label: "Main",
    items: [
      { title: "Dashboard",        href: "/",            icon: LayoutDashboard },
      { title: "Submit New Lead",  href: "/leads/new",  icon: Target },
      // { title: "Value Ideas",    href: "/ideas",       icon: Lightbulb },
      { title: "My Submissions",   href: "/assignments", icon: ClipboardList },
    ],
  },
  {
    label: "Insights",
    items: [
      { title: "Leaderboard", href: "/leaderboard", icon: Trophy },
      // { title: "Reports",  href: "/reports",     icon: BarChart3 }, // Reports hidden
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
  const router = useRouter();
  const { requestNavigate } = useNavigationGuard();

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
                    : item.href === "/leads/new"
                    ? pathname === "/leads/new"
                    : pathname.startsWith(item.href)
                }
                render={<button type="button" />}
                className="text-[#5D5D5D] hover:text-[#232222] hover:bg-[#F9F9F9] data-[active=true]:bg-[#B12B35]/10 data-[active=true]:text-[#B12B35] data-[active=true]:font-semibold rounded-md mx-1 w-full"
                onClick={() => requestNavigate(() => router.push(item.href))}
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
  const router = useRouter();
  const { user } = useAuth();
  const { requestNavigate } = useNavigationGuard();

  const role = user?.role;
  const navGroups =
    role === "admin"
      ? ADMIN_NAV
      : role === "executive"
      ? EXECUTIVE_NAV
      : USER_NAV;

  return (
    <Sidebar className="bg-white border-r border-[#EDE7E6]">
      {/* ── Header — brand red, white logo card + white text ── */}
      <SidebarHeader className="bg-[#B12B35] px-3 py-3.5">
        <button
          type="button"
          onClick={() => requestNavigate(() => router.push("/"))}
          className="flex items-center gap-2.5 w-full"
        >
          {/* White pill wrapping the logo so its white bg blends in */}
          <div className="shrink-0 rounded-lg bg-white px-2 py-1.5 shadow-sm">
            <Image
              src="/txlogo-full.webp"
              alt="TestingXperts"
              width={110}
              height={26}
              className="h-[26px] w-auto object-contain block"
              priority
            />
          </div>
          {/* Divider */}
          <div className="w-px h-7 bg-white/30 shrink-0" />
          {/* Product name */}
          <div className="min-w-0">
            <p className="text-white text-[13px] font-extrabold leading-none tracking-wider">
              Tx Catalyst
            </p>
          </div>
        </button>
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
