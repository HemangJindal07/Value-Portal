-- 032: Admin-managed currency exchange rates.
-- Used to normalize lead estimated_value (stored in its native currency) to USD
-- for dashboard Pipeline Value / Won to Date totals. `rate_to_usd` is the value
-- of one unit of `currency` expressed in USD (e.g. INR rate_to_usd = 0.012).
--
-- Written only by the backend service-role client (admin endpoint); RLS is
-- enabled with no policies so anon/authenticated clients cannot touch it.

create table public.exchange_rates (
  currency text primary key,
  rate_to_usd numeric(18, 8) not null,
  updated_at timestamptz not null default now(),
  updated_by uuid references public.profiles(id)
);

-- Seed with the supported currency shortlist + OTH. Values are illustrative
-- defaults; admins overwrite them from the FX Rates page.
insert into public.exchange_rates (currency, rate_to_usd) values
  ('USD', 1.0),
  ('GBP', 1.27),
  ('INR', 0.012),
  ('AED', 0.272),
  ('ZAR', 0.054),
  ('CAD', 0.73),
  ('SGD', 0.74),
  ('AUD', 0.66),
  ('NZD', 0.60),
  ('SAR', 0.266),
  ('OTH', 1.0);

alter table public.exchange_rates enable row level security;
-- No policies: only the service-role key (which bypasses RLS) may access this table.
