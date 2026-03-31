import Image from "next/image";

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

        {/* TX Logo + name */}
        <div className="relative flex items-center gap-3 mb-auto">
          <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-white p-1.5">
            <Image
              src="/txlogo.webp"
              alt="TestingXperts"
              width={40}
              height={40}
              className="object-contain"
              priority
            />
          </div>
          <div>
            <p className="text-white font-bold text-base leading-none tracking-tight">
              TestingXperts
            </p>
            <p className="text-white/60 text-xs mt-0.5 tracking-wide">
              Passion For Perfection
            </p>
          </div>
        </div>

        {/* Hero copy */}
        <div className="relative flex-1 flex flex-col justify-center py-12">
          <p className="text-white/70 text-xs font-semibold tracking-[0.2em] uppercase mb-4">
            Value Portal
          </p>
          <h1 className="text-[2.6rem] font-bold text-white leading-[1.15] mb-5">
            Capture Every
            <br />
            Opportunity.
            <br />
            Drive Real Value.
          </h1>
          <p className="text-white/70 text-[15px] leading-relaxed max-w-xs mb-10">
            A centralised platform for delivery teams to capture, track, and
            measure the business value they generate at client accounts.
          </p>

          {/* Feature pills */}
          <div className="flex flex-col gap-4">
            {[
              {
                label: "Capture Leads & Ideas",
                desc: "Submit opportunities and innovations instantly",
                dot: "bg-white",
              },
              {
                label: "Track Every Stage",
                desc: "Monitor progress with full visibility",
                dot: "bg-white/60",
              },
              {
                label: "Measure Business Impact",
                desc: "Quantify value delivered at every account",
                dot: "bg-white/30",
              },
            ].map((f) => (
              <div key={f.label} className="flex items-start gap-3">
                <span
                  className={`mt-1.5 h-2 w-2 shrink-0 rounded-full ${f.dot}`}
                />
                <div>
                  <p className="text-white font-semibold text-sm leading-snug">
                    {f.label}
                  </p>
                  <p className="text-white/55 text-xs mt-0.5">{f.desc}</p>
                </div>
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
          <div className="flex items-center gap-2.5 mb-8 lg:hidden">
            <div className="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-white border border-[#EDE7E6] shadow-sm p-1">
              <Image
                src="/txlogo.webp"
                alt="TestingXperts"
                width={28}
                height={28}
                className="object-contain"
              />
            </div>
            <div>
              <p className="font-bold text-[#232222] text-sm leading-none">
                Value Portal
              </p>
              <p className="text-[11px] text-[#5D5D5D] mt-0.5">
                TestingXperts
              </p>
            </div>
          </div>

          {children}
        </div>
      </div>
    </div>
  );
}
