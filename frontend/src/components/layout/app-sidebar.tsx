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
      <SidebarGroupLabel className="text-[10px] font-semibold tracking-widest text-[#C5C5C5] uppercase px-3 py-2">
        {label}
      </SidebarGroupLabel>
      <SidebarGroupContent>
        <SidebarMenu>
          {items.map((item) => (
            <SidebarMenuItem key={item.href}>
              <SidebarMenuButton
                isActive={pathname === item.href}
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

  return (
    <Sidebar className="bg-white border-r border-[#EDE7E6]">
      {/* Header — TX logo + brand name */}
      <SidebarHeader className="border-b border-[#EDE7E6] px-4 py-4">
        <Link href="/" className="flex items-center gap-3">
          <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-[#B12B35]/8 border border-[#B12B35]/20 p-1">
            <Image
              src="/txlogo.webp"
              alt="TestingXperts"
              width={36}
              height={36}
              className="object-contain"
              priority
            />
          </div>
          <div>
            <p className="text-sm font-semibold text-[#232222] leading-none tracking-tight">
              Value Portal
            </p>
            <p className="text-[11px] text-[#5D5D5D] mt-0.5 tracking-wide">TestingXperts</p>
          </div>
        </Link>
      </SidebarHeader>

      <SidebarContent className="py-2">
        <NavGroup label="Main" items={mainNav} pathname={pathname} />
        <NavGroup label="Insights" items={insightsNav} pathname={pathname} />
        <NavGroup label="System" items={systemNav} pathname={pathname} />
      </SidebarContent>

      <SidebarFooter className="border-t border-[#EDE7E6] px-4 py-3">
        <p className="text-[11px] text-[#C5C5C5]">
          v0.1.0 &middot; TestingXperts
        </p>
      </SidebarFooter>
    </Sidebar>
  );
}
