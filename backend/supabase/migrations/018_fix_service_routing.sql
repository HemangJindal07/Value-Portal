-- Migration 018: Rename service_routing keys to full names + fix Insurance → Yuvraj Singh
-- Safe to re-run.

-- Rename short keys to full names (only if short keys still exist)
update public.service_routing set service_name = 'Quality Engineering'    where service_name = 'QE';
update public.service_routing set service_name = 'Digital Engineering'    where service_name = 'DE';
update public.service_routing set service_name = 'Artificial Intelligence' where service_name = 'AI';
update public.service_routing set service_name = 'Data Engineering'       where service_name = 'Data';
-- Insurance key stays 'Insurance'

-- Fix Insurance reviewer: Manjeet → Yuvraj Singh
update public.service_routing
set du_user_id = (select id from public.profiles where email = 'yuvraj.singh@testingxperts.com' limit 1)
where service_name = 'Insurance';

-- Seed all entries (safe re-run with ON CONFLICT DO NOTHING)
insert into public.service_routing (service_name, du_user_id)
select 'Quality Engineering', id from public.profiles where email = 'manjeet.kumar@testingxperts.com' limit 1
on conflict (service_name) do nothing;

insert into public.service_routing (service_name, du_user_id)
select 'Digital Engineering', id from public.profiles where email = 'vivek.gupta@testingxperts.com' limit 1
on conflict (service_name) do nothing;

insert into public.service_routing (service_name, du_user_id)
select 'Artificial Intelligence', id from public.profiles where email = 'vivek.gupta@testingxperts.com' limit 1
on conflict (service_name) do nothing;

insert into public.service_routing (service_name, du_user_id)
select 'Data Engineering', id from public.profiles where email = 'rajiv.diwan@testingxperts.com' limit 1
on conflict (service_name) do nothing;

insert into public.service_routing (service_name, du_user_id)
select 'Insurance', id from public.profiles where email = 'yuvraj.singh@testingxperts.com' limit 1
on conflict (service_name) do update set du_user_id = excluded.du_user_id;
