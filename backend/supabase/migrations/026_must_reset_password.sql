-- 026: Force first-login password reset for bulk-imported employees.
-- A profile with must_reset_password = true is blocked from the rest of the
-- portal until they set a new password via /reset-password.

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS must_reset_password boolean NOT NULL DEFAULT false;
