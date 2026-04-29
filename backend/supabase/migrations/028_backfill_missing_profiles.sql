-- 028: Backfill profiles for any auth.users row that doesn't have one.
--
-- After the bulk import, ~561 auth.users rows ended up without a corresponding
-- profile row, which causes Supabase Auth to fail with "Database error
-- querying schema" on sign-in. This creates the missing profile rows from
-- auth.users metadata (full_name + email), defaulting to role='user' and
-- must_reset_password=true so they go through the forced reset on first login.

INSERT INTO public.profiles (id, full_name, email, role, must_reset_password, is_active)
SELECT
  u.id,
  COALESCE(NULLIF(u.raw_user_meta_data ->> 'full_name', ''), split_part(u.email, '@', 1)) AS full_name,
  u.email,
  'user' AS role,
  true   AS must_reset_password,
  true   AS is_active
FROM auth.users u
LEFT JOIN public.profiles p ON p.id = u.id
WHERE p.id IS NULL
  AND u.email IS NOT NULL;
