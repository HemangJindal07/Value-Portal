-- 031: Password-reset OTP store for the "Forgot password" flow.
-- A user requests a reset, receives a 6-digit code by email, verifies it,
-- then sets a new password. Codes are stored hashed (sha256) and short-lived.
--
-- This table is written/read only by the backend service-role client, so RLS
-- is enabled with no policies — anon/authenticated clients cannot touch it.

create table public.password_reset_otps (
  otp_id uuid primary key default gen_random_uuid(),
  email text not null,
  code_hash text not null,
  expires_at timestamptz not null,
  consumed_at timestamptz,
  attempts integer not null default 0,
  created_at timestamptz not null default now()
);

create index password_reset_otps_email_idx on public.password_reset_otps(email);
create index password_reset_otps_expires_idx on public.password_reset_otps(expires_at);

alter table public.password_reset_otps enable row level security;
-- No policies: only the service-role key (which bypasses RLS) may access this table.
