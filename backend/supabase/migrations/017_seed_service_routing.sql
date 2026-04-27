-- Migration 017: Seed service_routing table with TX SME assignments
-- Maps each TX service vertical to the correct DU (first reviewer) by email.
-- Safe to re-run: uses INSERT ... ON CONFLICT DO UPDATE.
--
-- Service → Reviewer mapping:
--   QE        → Manjeet Kumar   (manjeet.kumar@testingxperts.com)
--   DE        → Vivek Gupta     (vivek.gupta@testingxperts.com)
--   AI        → Vivek Gupta     (vivek.gupta@testingxperts.com)
--   Data      → Rajiv Diwan     (rajiv.diwan@testingxperts.com)
--   Insurance → Manjeet Kumar   (manjeet.kumar@testingxperts.com)

insert into public.service_routing (service_name, du_user_id)
select 'QE', id from public.profiles where email = 'manjeet.kumar@testingxperts.com' limit 1
on conflict (service_name) do update set du_user_id = excluded.du_user_id;

insert into public.service_routing (service_name, du_user_id)
select 'DE', id from public.profiles where email = 'vivek.gupta@testingxperts.com' limit 1
on conflict (service_name) do update set du_user_id = excluded.du_user_id;

insert into public.service_routing (service_name, du_user_id)
select 'AI', id from public.profiles where email = 'vivek.gupta@testingxperts.com' limit 1
on conflict (service_name) do update set du_user_id = excluded.du_user_id;

insert into public.service_routing (service_name, du_user_id)
select 'Data', id from public.profiles where email = 'rajiv.diwan@testingxperts.com' limit 1
on conflict (service_name) do update set du_user_id = excluded.du_user_id;

insert into public.service_routing (service_name, du_user_id)
select 'Insurance', id from public.profiles where email = 'manjeet.kumar@testingxperts.com' limit 1
on conflict (service_name) do update set du_user_id = excluded.du_user_id;
