-- 033: Signup OTP store for the email-verified registration flow.
-- A prospective user (only @testingxperts.com addresses) requests a code,
-- receives a 6-digit OTP by email, then submits the code together with their
-- name and password to create the account. Codes are stored hashed (sha256)
-- and short-lived. Mirrors 031_password_reset_otps.
--
-- Written/read only by the backend service-role client, so RLS is enabled with
-- no policies — anon/authenticated clients cannot touch it.

create table public.signup_otps (
  otp_id uuid primary key default gen_random_uuid(),
  email text not null,
  code_hash text not null,
  expires_at timestamptz not null,
  consumed_at timestamptz,
  attempts integer not null default 0,
  created_at timestamptz not null default now()
);

create index signup_otps_email_idx on public.signup_otps(email);
create index signup_otps_expires_idx on public.signup_otps(expires_at);

alter table public.signup_otps enable row level security;
-- No policies: only the service-role key (which bypasses RLS) may access this table.
