-- 025: Rename role 'delivery_manager' to 'user'
--
-- Updates the profiles.role CHECK constraint to allow 'user' instead of
-- 'delivery_manager', migrates existing rows, and updates the default new-row
-- value used by the auth signup trigger.

-- 1. Drop the old check constraint
alter table public.profiles drop constraint if exists profiles_role_check;

-- 2. Migrate existing rows
update public.profiles
set role = 'user'
where role = 'delivery_manager';

-- 2b. Migrate stale role metadata in auth.users so Supabase Auth's JWT
--     claim resolution doesn't fail on sign-in for legacy accounts.
update auth.users
set raw_user_meta_data = jsonb_set(
  raw_user_meta_data,
  '{role}',
  '"user"'::jsonb
)
where raw_user_meta_data ->> 'role' = 'delivery_manager';

-- 3. Re-add the constraint with the new role list
alter table public.profiles
  add constraint profiles_role_check
  check (role in ('user', 'sales', 'practice_lead', 'admin', 'executive'));

-- 4. Change the column default for new rows
alter table public.profiles alter column role set default 'user';

-- 5. Update the signup trigger so new auth.users default to 'user'
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, full_name, email, role)
  values (
    new.id,
    coalesce(new.raw_user_meta_data ->> 'full_name', ''),
    new.email,
    coalesce(new.raw_user_meta_data ->> 'role', 'user')
  );
  return new;
end;
$$ language plpgsql security definer;
