"use client";

import Link from "next/link";
import Image from "next/image";
import { usePathname } from "next/navigation";
import {
  LayoutDashboard,
  Building2,
  Lightbulb,
  Target,
  ClipboardList,
  Trophy,
  Bell,
  Settings,
  ShieldCheck,
  BarChart3,
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

const mainNav = [
  { title: "Dashboard", href: "/", icon: LayoutDashboard },
  { title: "Accounts", href: "/accounts", icon: Building2 },
  { title: "Leads", href: "/leads", icon: Target },
  { title: "Value Ideas", href: "/ideas", icon: Lightbulb },
  { title: "My Assignments", href: "/assignments", icon: ClipboardList },
];

const insightsNav = [
  { title: "Leaderboard", href: "/leaderboard", icon: Trophy },
  { title: "Reports", href: "/reports", icon: BarChart3 },
  { title: "Reviews", href: "/reviews", icon: ShieldCheck },
];

const systemNav = [
  { title: "Notifications", href: "/notifications", icon: Bell },
  { title: "Admin", href: "/admin/users", icon: Settings },
];

function NavGroup({
  label,
  items,
  pathname,
}: {
  label: string;
  items: typeof mainNav;
  pathname: string;
}) {
  return (
    <SidebarGroup>
      <SidebarGroupLabel className="text-[10px] font-semibold tracking-widest text-white/40 uppercase px-3 py-2">
        {label}
      </SidebarGroupLabel>
      <SidebarGroupContent>
        <SidebarMenu>
          {items.map((item) => (
            <SidebarMenuItem key={item.href}>
              <SidebarMenuButton
                isActive={pathname === item.href}
                render={<Link href={item.href} />}
                className="text-white/70 hover:text-white hover:bg-white/10 data-[active=true]:bg-[#B12B35] data-[active=true]:text-white rounded-md mx-1"
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

  return (
    <Sidebar className="bg-[#232222] border-r border-white/10">
      {/* Header — TX logo + brand name */}
      <SidebarHeader className="border-b border-white/10 px-4 py-4">
        <Link href="/" className="flex items-center gap-3">
          <div className="flex h-8 w-8 shrink-0 items-center justify-center rounded-md bg-white p-1">
            <Image
              src="/txlogo.webp"
              alt="TestingXperts"
              width={24}
              height={24}
              className="object-contain"
            />
          </div>
          <div>
            <p className="text-sm font-semibold text-white leading-none">
              Value Portal
            </p>
            <p className="text-[11px] text-white/50 mt-0.5">TestingXperts</p>
          </div>
        </Link>
      </SidebarHeader>

      <SidebarContent className="py-2">
        <NavGroup label="Main" items={mainNav} pathname={pathname} />
        <NavGroup label="Insights" items={insightsNav} pathname={pathname} />
        <NavGroup label="System" items={systemNav} pathname={pathname} />
      </SidebarContent>

      <SidebarFooter className="border-t border-white/10 px-4 py-3">
        <p className="text-[11px] text-white/30">
          v0.1.0 &middot; TestingXperts
        </p>
      </SidebarFooter>
    </Sidebar>
  );
}
