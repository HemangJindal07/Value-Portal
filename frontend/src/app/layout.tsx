import type { Metadata } from "next";
import { Inter } from "next/font/google";
import { Toaster } from "@/components/ui/sonner";
import { AuthProvider } from "@/lib/auth-context";
import { ThemeProvider } from "@/components/theme-provider";
import "./globals.css";

// Server-only: not inlined by Turbopack — always read fresh from .env.local
const apiUrlForClient = process.env.API_URL || "http://localhost:8000";

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-sans",
  display: "swap",
});

export const metadata: Metadata = {
  title: "Value Portal — TestingXperts",
  description:
    "Capture, track, and measure the business value generated at client accounts.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" suppressHydrationWarning>
      <head>
        <script
          dangerouslySetInnerHTML={{
            __html: `window.__VALUE_PORTAL_API_URL__=${JSON.stringify(apiUrlForClient)};`,
          }}
        />
      </head>
      <body className={`${inter.variable} antialiased`} suppressHydrationWarning>
        <ThemeProvider>
          <AuthProvider>
            {children}
            <Toaster richColors position="top-right" />
          </AuthProvider>
        </ThemeProvider>
      </body>
    </html>
  );
}
