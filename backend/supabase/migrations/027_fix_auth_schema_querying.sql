-- 027: Fix "Database error querying schema" on sign-in.
--
-- The recursive RLS policies on public.profiles can trip Supabase Auth's
-- internal schema queries after the role rename + bulk import. We replace the
-- recursive admin policies with non-recursive ones using a SECURITY DEFINER
-- helper function. We also re-grant execute on handle_new_user to be safe.

-- 1. Helper function: returns the role of the current auth user, bypassing RLS.
create or replace function public.current_user_role()
returns text
language sql
security definer
stable
set search_path = public
as $$
  select role from public.profiles where id = auth.uid();
$$;

grant execute on function public.current_user_role() to authenticated, anon, service_role;

-- 2. Drop the recursive admin policies and recreate them using the helper.
drop policy if exists "Admins can update any profile" on public.profiles;
drop policy if exists "Admins can insert profiles"   on public.profiles;

create policy "Admins can update any profile"
  on public.profiles for update
  using (public.current_user_role() = 'admin');

create policy "Admins can insert profiles"
  on public.profiles for insert
  with check (public.current_user_role() = 'admin');

-- 3. Make sure handle_new_user is owned by postgres and grants are correct.
alter function public.handle_new_user() owner to postgres;
grant execute on function public.handle_new_user() to service_role, supabase_auth_admin;

-- 4. Make sure the trigger still exists and is enabled.
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();
