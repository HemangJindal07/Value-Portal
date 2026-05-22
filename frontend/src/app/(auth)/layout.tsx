import Image from "next/image";
import { Crosshair, Layers, TrendingUp } from "lucide-react";

export default function AuthLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="flex min-h-screen">
      {/* ── Left panel — Brand Red ── */}
      <div className="hidden lg:flex lg:w-[45%] flex-col bg-[#B12B35] px-12 py-10 relative overflow-hidden">

        {/* Subtle geometric decoration */}
        <div className="pointer-events-none absolute inset-0">
          <div className="absolute -top-40 -right-40 w-[480px] h-[480px] rounded-full bg-white/5" />
          <div className="absolute bottom-0 -left-20 w-[360px] h-[360px] rounded-full bg-black/10" />
          <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] rounded-full border border-white/10" />
        </div>

        {/* TX Logo + app name */}
        <div className="relative mb-auto flex flex-col gap-3">
          <div className="bg-white px-4 py-2.5 inline-block shadow-sm" style={{ borderRadius: "8px" }}>
            <Image
              src="/txlogo-full.webp"
              alt="TestingXperts"
              width={180}
              height={42}
              className="h-[42px] w-auto object-contain block"
              priority
            />
          </div>
          <div className="flex items-center gap-2">
            <div className="h-px w-5 bg-white/40" />
            <p className="text-white text-lg font-extrabold tracking-[0.12em]">
              Tx Catalyst
            </p>
            <div className="h-px flex-1 bg-white/20" />
          </div>
        </div>

        {/* Hero copy */}
        <div className="relative flex-1 flex flex-col justify-center py-8">
          <h1 className="text-[2.6rem] font-bold text-white leading-[1.15] mb-3">
            Capture Every Lead.
            <br />
            <span className="text-white/80">Log it. Track it.</span>
            <br />
            Win More.
          </h1>
          <p className="text-white/70 text-[15px] leading-relaxed max-w-xs mb-8">
            A centralised platform for delivery teams to capture and track every opportunity.
          </p>

          {/* Hero illustration (lightbulb icon is decorative only) */}
          <div className="relative mb-8 flex items-center justify-center">
            <div className="relative w-48 h-32">
              {/* Upward trend line SVG */}
              <svg viewBox="0 0 200 100" className="absolute inset-0 w-full h-full opacity-20" fill="none">
                <polyline points="0,80 40,60 80,65 120,30 160,20 200,5" stroke="white" strokeWidth="2.5" strokeLinejoin="round" strokeLinecap="round"/>
                <circle cx="120" cy="30" r="4" fill="white"/>
                <circle cx="160" cy="20" r="4" fill="white"/>
                <circle cx="200" cy="5" r="4" fill="white"/>
              </svg>
              {/* Central lightbulb glow */}
              <div className="absolute inset-0 flex items-center justify-center">
                <div className="relative">
                  <div className="absolute inset-0 rounded-full bg-white/10 blur-xl scale-150" />
                  <div className="relative flex h-16 w-16 items-center justify-center rounded-full bg-white/15 border border-white/20">
                    <svg viewBox="0 0 24 24" className="h-8 w-8 text-white" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
                      <path d="M9 21h6M12 3a6 6 0 0 1 6 6c0 2.22-1.21 4.16-3 5.2V17a1 1 0 0 1-1 1H10a1 1 0 0 1-1-1v-2.8C7.21 13.16 6 11.22 6 9a6 6 0 0 1 6-6z"/>
                      <path d="M10 17h4"/>
                    </svg>
                  </div>
                </div>
              </div>
              {/* Floating mini-cards */}
              <div className="absolute top-0 right-0 bg-white/15 border border-white/20 rounded-lg px-2.5 py-1.5 text-xs text-white font-medium backdrop-blur-sm">
                +42 leads
              </div>
              <div className="absolute bottom-0 left-0 bg-white/15 border border-white/20 rounded-lg px-2.5 py-1.5 text-xs text-white font-medium backdrop-blur-sm">
                £2.4M value
              </div>
            </div>
          </div>

          {/* Feature icon trio — matches Template 1 */}
          <div className="grid grid-cols-3 gap-3">
            {[
              { icon: Crosshair, label: "Capture", desc: "Log Leads Instantly" },
              { icon: Layers,    label: "Track",   desc: "Full Pipeline Visibility" },
              { icon: TrendingUp,label: "Build",   desc: "Measure Real Business Impact" },
            ].map((f) => (
              <div key={f.label} className="flex flex-col items-center text-center gap-2 bg-white/10 border border-white/15 rounded-xl p-3">
                <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-white/15">
                  <f.icon className="h-4 w-4 text-white" />
                </div>
                <p className="text-white font-semibold text-xs leading-snug">{f.label}</p>
                <p className="text-white/55 text-[10px] leading-tight">{f.desc}</p>
              </div>
            ))}
          </div>
        </div>

        {/* Footer */}
        <p className="relative text-white/30 text-xs">
          &copy; {new Date().getFullYear()} TestingXperts. All rights reserved.
        </p>
      </div>

      {/* ── Right panel — form area ── */}
      <div className="flex-1 flex flex-col items-center justify-center bg-[#F9F9F9] px-6 py-12">
        <div className="w-full max-w-[420px]">
          {/* Mobile-only logo */}
          <div className="flex flex-col gap-1 mb-8 lg:hidden">
            <Image
              src="/txlogo-full.webp"
              alt="TestingXperts"
              width={200}
              height={48}
              className="h-10 w-auto object-contain object-left"
            />
            <p className="text-[10px] font-bold text-[#B12B35] tracking-[0.18em] uppercase">
              Tx&nbsp;Catalyst&nbsp;Portal
            </p>
          </div>

          {children}
        </div>
      </div>
    </div>
  );
}
