# Value Portal — UI & Branding Implementation Guide

> **BRD Reference:** Section 8.2 — UI and Branding  
> **Company:** TestingXperts (TX Enterprise)  
> **Priority:** P1  
> **Status:** Pending Implementation

---

## 1. Overview

The current portal uses shadcn's generic dark/black theme. All UI must be updated to reflect the **TestingXperts brand identity** — professional, modern, and enterprise-ready. This document is the single source of truth for every colour, font, spacing, component, and capitalization decision.

---

## 2. Brand Color Tokens

These are the definitive hex values from the Brand Guidelines. All CSS variables in `globals.css` must map to these tokens.

### 2.1 Primary Palette

| Token Name       | Hex       | OKLCH (approx)              | Usage                                          |
|------------------|-----------|-----------------------------|------------------------------------------------|
| Brand Red        | `#B12B35` | `oklch(0.45 0.175 22)`      | Primary CTA, active nav, hero, badges          |
| Brand Black      | `#232222` | `oklch(0.165 0 0)`          | Sidebar background, dark nav, footer           |
| Navy Blue        | `#003466` | `oklch(0.265 0.105 255)`    | Charts, secondary headers, data visualization  |
| Mid Grey         | `#5D5D5D` | `oklch(0.42 0 0)`           | Subtext, muted labels, secondary content       |
| Light Cream      | `#EDE7E6` | `oklch(0.93 0.008 20)`      | Page backgrounds, card fills, light sections   |

### 2.2 Secondary Palette

| Token Name       | Hex       | OKLCH (approx)              | Usage                                          |
|------------------|-----------|-----------------------------|------------------------------------------------|
| Accent Blue      | `#2E75B6` | `oklch(0.52 0.12 240)`      | Links, info states, highlights                 |
| Bright Red       | `#E42525` | `oklch(0.54 0.22 25)`       | Hover on CTA buttons, alert / error states     |
| Light Grey       | `#C5C5C5` | `oklch(0.79 0 0)`           | Dividers, borders, disabled UI                 |
| Off White        | `#F9F9F9` | `oklch(0.98 0 0)`           | Input fills, page backgrounds, card bg        |

---

## 3. Typography

| Property      | Value                                              |
|---------------|----------------------------------------------------|
| Font family   | `Inter` (already loaded via Next.js / shadcn)      |
| Weights used  | Light (300), Regular (400), Medium (500), Semibold (600), Bold (700) |
| H1            | 60 px                                              |
| H2            | 46 px                                              |
| H3            | 36 px                                              |
| H4            | 24 px                                              |
| H5            | 20 px                                              |
| Body          | 14–16 px                                           |

> The `Geist` font loaded in `layout.tsx` must be **replaced with `Inter`** from `next/font/google`.

---

## 4. Capitalization Standard

All visible text in the portal must follow **Title Case for headings/labels** and **Sentence case for body/descriptions**.

| Surface                        | Rule             | Example                                  |
|-------------------------------|------------------|------------------------------------------|
| Page headings (H1–H3)         | Title Case       | "Value Ideas", "My Assignments"          |
| Sidebar nav labels            | Title Case       | "Dashboard", "Value Ideas", "Leaderboard"|
| Table column headers          | Title Case       | "Account Name", "Contract Value"         |
| Form labels                   | Title Case       | "Engagement Start", "Account Status"     |
| Button text                   | Title Case       | "Create Account", "Submit Lead"          |
| Descriptive sub-headings      | Sentence case    | "Manage client accounts and engagements."|
| Toast / notification messages | Sentence case    | "Account created successfully."          |
| Dropdown / select options     | Title Case       | "Active", "Prospect", "Inactive"         |
| Badge / status labels         | Title Case       | "In Progress", "Won", "Pending Review"   |
| Section group labels (nav)    | All caps / small caps | "MAIN", "INSIGHTS", "SYSTEM"        |

---

## 5. CSS Variables — Required Changes (`globals.css`)

The following diff shows what must change in `:root` and `.dark`.

### 5.1 Light Mode (`:root`)

```css
:root {
  --background: oklch(0.98 0 0);            /* Off White #F9F9F9 */
  --foreground: oklch(0.165 0 0);           /* Brand Black #232222 */
  --card: oklch(1 0 0);                     /* Pure white cards */
  --card-foreground: oklch(0.165 0 0);
  --popover: oklch(1 0 0);
  --popover-foreground: oklch(0.165 0 0);
  --primary: oklch(0.45 0.175 22);          /* Brand Red #B12B35 */
  --primary-foreground: oklch(1 0 0);       /* White text on red */
  --secondary: oklch(0.93 0.008 20);        /* Light Cream #EDE7E6 */
  --secondary-foreground: oklch(0.165 0 0);
  --muted: oklch(0.93 0.008 20);            /* Light Cream */
  --muted-foreground: oklch(0.42 0 0);      /* Mid Grey #5D5D5D */
  --accent: oklch(0.93 0.008 20);
  --accent-foreground: oklch(0.165 0 0);
  --destructive: oklch(0.54 0.22 25);       /* Bright Red #E42525 */
  --border: oklch(0.79 0 0);               /* Light Grey #C5C5C5 */
  --input: oklch(0.79 0 0);
  --ring: oklch(0.45 0.175 22);             /* Brand Red for focus rings */
  --radius: 0.5rem;

  /* Charts — Navy + brand palette */
  --chart-1: oklch(0.265 0.105 255);        /* Navy Blue #003466 */
  --chart-2: oklch(0.45 0.175 22);          /* Brand Red */
  --chart-3: oklch(0.52 0.12 240);          /* Accent Blue #2E75B6 */
  --chart-4: oklch(0.42 0 0);              /* Mid Grey */
  --chart-5: oklch(0.79 0 0);              /* Light Grey */

  /* Sidebar — Brand Black */
  --sidebar: oklch(0.165 0 0);             /* Brand Black #232222 */
  --sidebar-foreground: oklch(0.98 0 0);   /* Near white text */
  --sidebar-primary: oklch(0.45 0.175 22); /* Brand Red for active items */
  --sidebar-primary-foreground: oklch(1 0 0);
  --sidebar-accent: oklch(0.22 0 0);       /* Slightly lighter black hover */
  --sidebar-accent-foreground: oklch(0.98 0 0);
  --sidebar-border: oklch(0.25 0 0);       /* Subtle border on dark bg */
  --sidebar-ring: oklch(0.45 0.175 22);
}
```

### 5.2 Dark Mode (`.dark`)

```css
.dark {
  --background: oklch(0.13 0 0);
  --foreground: oklch(0.95 0 0);
  --card: oklch(0.165 0 0);
  --card-foreground: oklch(0.95 0 0);
  --primary: oklch(0.45 0.175 22);         /* Keep Brand Red in dark mode */
  --primary-foreground: oklch(1 0 0);
  --secondary: oklch(0.22 0 0);
  --secondary-foreground: oklch(0.95 0 0);
  --muted: oklch(0.22 0 0);
  --muted-foreground: oklch(0.65 0 0);
  --destructive: oklch(0.54 0.22 25);
  --border: oklch(1 0 0 / 12%);
  --input: oklch(1 0 0 / 15%);
  --ring: oklch(0.45 0.175 22);
  --sidebar: oklch(0.11 0 0);              /* Even darker in dark mode */
  --sidebar-foreground: oklch(0.95 0 0);
  --sidebar-primary: oklch(0.45 0.175 22);
  --sidebar-primary-foreground: oklch(1 0 0);
  --sidebar-accent: oklch(0.18 0 0);
  --sidebar-accent-foreground: oklch(0.95 0 0);
  --sidebar-border: oklch(1 0 0 / 10%);
  --sidebar-ring: oklch(0.45 0.175 22);
}
```

---

## 6. Component-by-Component Changes

### 6.1 Sidebar (`app-sidebar.tsx`)

| Current | Target |
|---------|--------|
| Generic "VP" box logo | TK monogram or "TK" in Brand Red on Brand Black |
| `bg-primary` (black) on logo box | `bg-[#B12B35]` |
| "Value Portal" label | Keep; add "TestingXperts" as sub-label |
| Active state: generic dark | Active state: Brand Red background + white text |
| Group labels: "Main", "Insights", "System" | Uppercase: "MAIN", "INSIGHTS", "SYSTEM" |
| Nav item text casing: already Title Case | ✅ Already correct |

**Logo markup target:**
```tsx
<div className="flex h-8 w-8 items-center justify-center rounded-lg bg-[#B12B35] text-white font-bold text-sm">
  TK
</div>
<div>
  <p className="text-sm font-semibold text-white leading-none">Value Portal</p>
  <p className="text-xs text-[#C5C5C5]">TestingXperts</p>
</div>
```

### 6.2 Login Page (`(auth)/login/page.tsx`)

| Current | Target |
|---------|--------|
| Plain white card, centered | Left: Brand Red hero panel; Right: login form |
| "VP" logo box | "TK" logo in Brand Red |
| "Welcome back" heading | "Welcome Back" (Title Case) |
| Generic primary button | Brand Red filled, white text |
| Auth layout: plain white background | Split layout: red left panel + white right |

**Auth layout target pattern** (from image reference Template 1 / Template 3):
- Left 40%: `bg-[#B12B35]` with TK logo, tagline "Passion For Perfection", and value proposition copy
- Right 60%: white, contains the login/register card

### 6.3 Buttons (`button.tsx`)

| Variant | Current | Target |
|---------|---------|--------|
| `default` | `bg-primary` (black) | Brand Red `#B12B35` |
| `default` hover | `bg-primary/90` | `#E42525` (Bright Red) |
| `outline` | generic border | `border-[#B12B35]` text `#B12B35` |
| `outline` hover | generic muted | light red tint `bg-[#B12B35]/5` |
| `destructive` | generic red tint | Bright Red `#E42525` |

### 6.4 Dashboard Page (`(dashboard)/page.tsx`)

| Current | Target |
|---------|--------|
| Stat cards: generic colors | KPI icon colored with Brand Red / Navy Blue |
| Card titles: sentence case mix | Title Case for all card/section headings |
| Activity feed: no branding | Keep clean; activity type badges in brand colors |

Reference (Template 2 in image):
- Stats row: "Ideas Submitted", "In Progress", "Ideas Submitted" — numbers large, label small below
- Activity feed below stats
- Clean card layout, white background, subtle grey border

### 6.5 Forms (all `new/page.tsx` files)

| Current | Target |
|---------|--------|
| Labels: mixed case | All form labels: Title Case |
| Submit button: generic black | Brand Red primary button |
| Cancel/back button: outline | Brand Red outline variant |
| Required asterisk: `*` | Keep, but style in Brand Red |

### 6.6 Tables

| Current | Target |
|---------|--------|
| Column headers: Title Case | ✅ Already correct — verify all pages |
| Row hover: default muted | Subtle cream `#EDE7E6` on hover |
| Status badges: generic blue/green/grey | Map to brand palette: Active=green-ish, Prospect=Accent Blue, Inactive=Mid Grey |

### 6.7 Notification Badges / Toasts

| Surface | Target |
|---------|--------|
| Unread badge on bell | `bg-[#B12B35]` white text |
| Success toast | Green ✅ (keep default sonner success) |
| Error toast | Bright Red `#E42525` |
| Info toast | Accent Blue `#2E75B6` |

---

## 7. Logo Usage Rules

Per Brand Guidelines:

| Context | Logo Version |
|---------|-------------|
| Sidebar (dark `#232222` bg) | White version of TK mark |
| Login page left panel (red bg) | White version of TK mark |
| Login page right panel (white bg) | Colour version of TK mark |
| Reports / print export | Colour version |

**Clear space:** 0.5× logo width on all four sides (do not crowd with text or other elements).

---

## 8. File Change Checklist

```
frontend/src/app/globals.css
  ☐ Replace all --primary, --sidebar, --background, --muted, --ring, --chart-* values
  ☐ Add Inter font in @layer base if not already present

frontend/src/app/layout.tsx
  ☐ Replace Geist font import with Inter from next/font/google

frontend/src/app/(auth)/layout.tsx
  ☐ Implement split-panel layout (red left + white right)

frontend/src/app/(auth)/login/page.tsx
  ☐ Replace "VP" with "TK" logo
  ☐ Add left panel copy (tagline, value prop)
  ☐ "Welcome back" → "Welcome Back"

frontend/src/app/(auth)/register/page.tsx
  ☐ Same split-panel treatment as login
  ☐ All labels Title Case

frontend/src/components/layout/app-sidebar.tsx
  ☐ Replace "VP" → "TK" mark, bg-[#B12B35]
  ☐ Add "TestingXperts" as sub-label
  ☐ Group labels → uppercase ("MAIN", "INSIGHTS", "SYSTEM")

frontend/src/components/ui/button.tsx
  ☐ default variant → Brand Red
  ☐ default hover → Bright Red
  ☐ outline variant → Brand Red border + text

frontend/src/components/layout/topbar.tsx
  ☐ Notification badge → bg-[#B12B35]
  ☐ Avatar fallback bg → Brand Red

frontend/src/app/(dashboard)/page.tsx
  ☐ KPI card icon colors → Brand Red / Navy Blue
  ☐ Section headings — Title Case audit

frontend/src/app/(dashboard)/accounts/page.tsx
  ☐ "All Accounts" title — Title Case ✅
  ☐ Status badge colors → brand palette

frontend/src/app/(dashboard)/leads/page.tsx
  ☐ Status badge colors → brand palette
  ☐ Label/heading audit

frontend/src/app/(dashboard)/ideas/page.tsx
  ☐ Status badge colors → brand palette
  ☐ "Value Ideas" heading ✅

frontend/src/app/(dashboard)/leads/new/page.tsx
frontend/src/app/(dashboard)/ideas/new/page.tsx
frontend/src/app/(dashboard)/accounts/new/page.tsx
  ☐ All form labels → Title Case audit
  ☐ Submit buttons → Brand Red
  ☐ Cancel buttons → Brand Red outline
```

---

## 9. Status Badge Color Mapping

| Status Value       | Background       | Text color       |
|--------------------|------------------|------------------|
| `active`           | `#B12B35/10`     | `#B12B35`        |
| `won`              | `#003466/10`     | `#003466`        |
| `prospect`         | `#2E75B6/10`     | `#2E75B6`        |
| `in_progress`      | `#003466/10`     | `#003466`        |
| `approved`         | `#B12B35/10`     | `#B12B35`        |
| `implemented`      | `#003466/15`     | `#003466`        |
| `inactive`         | `#C5C5C5/30`     | `#5D5D5D`        |
| `rejected`         | `#E42525/10`     | `#E42525`        |
| `pending_review`   | `#EDE7E6`        | `#5D5D5D`        |
| `lost`             | `#C5C5C5/30`     | `#5D5D5D`        |

---

## 10. Reference Templates (from image (3).png)

| Template | Description | Key Elements |
|----------|-------------|--------------|
| Template 1 | App Landing / Login Screen | Red left panel, TK logo, "Got an idea?" headline, white right panel with form |
| Template 2 | Dashboard | KPI stat cards (126 / 38 / 24), line chart, activity feed, clean card layout |
| Template 3 | Campaign Banner | Full Brand Red background, TK logo, bold white headline, CTA button |
| Template 4 | App Cards | White cards, TK logo header, card grid for portal navigation |
| Template 5 | Form UI | Clean form inputs, red "Submit" button, outlined "Cancel" button |
| Template 6 | Storytelling Banner | Full red bg, large white italic quote text |
| Template 7 | Color Palette + Typography | Primary Red, Dark, Accent Blue, Light Grey, Dash Grey swatches; Inter typeface |

---

## 11. Do Not Change

- Layout structure (sidebar + topbar + content area)
- Shadcn component API (only override CSS variables and className overrides)
- Dark mode toggle functionality
- Any backend or API code
- Route structure
- Form validation logic

---

## 12. Implementation Order (Recommended)

1. **`globals.css`** — Update all CSS variables (unblocks everything)
2. **`layout.tsx`** — Swap font to Inter
3. **`button.tsx`** — Brand Red primary/outline variants
4. **`app-sidebar.tsx`** — TK logo, brand black, active red state
5. **`(auth)/layout.tsx` + `login/page.tsx`** — Split panel login
6. **`topbar.tsx`** — Notification badge, avatar
7. **Dashboard + list pages** — Status badge colors, heading audits
8. **Form pages** — Label casing, button colors
9. **Full capitalization audit** — All pages, labels, toasts
