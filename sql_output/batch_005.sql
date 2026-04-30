-- ============================================================
-- Batch 5/5 (87 employees)
-- Run this in Supabase SQL Editor
-- ============================================================

-- PART A: Create auth.users rows (trigger auto-creates profiles)
INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'karthik.Kannathasan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Karthik Kannathasan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'karthik.Kannathasan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'surinder.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Surinder Ram Sakha Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'surinder.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'priyanka.fmg@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Priyanka Atluri', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'priyanka.fmg@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sandeep.gowni@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sandeep Reddy Gowni', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sandeep.gowni@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'Kavitha.ramakrishnan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kavitha Ramakrishnan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'Kavitha.ramakrishnan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sravankumar.golla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sravan Kumar Golla', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sravankumar.golla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'okasha.momin@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Okasha Momin', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'okasha.momin@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'madhusudhan.erram@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Madhusudhan Reddy Erram', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'madhusudhan.erram@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'senthil.murugan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Senthil Murugan Arumugam', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'senthil.murugan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bharath.jannapureddy@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bharath Kumar Jannapureddy', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bharath.jannapureddy@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'balakrishna.artham@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bala Krishna Artham', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'balakrishna.artham@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'yamini.banothu@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Yamini Banothu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'yamini.banothu@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vijay.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vijay Kumar Tummala', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vijay.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'amaresh.narayanappa@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Amaresh Narayanappa', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'amaresh.narayanappa@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sulochana.peruma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sulochana Rani Perumalla', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sulochana.peruma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mehmet.seker@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mehmet Seker', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mehmet.seker@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bethany.hampton@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bethany Hampton', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bethany.hampton@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'dinesh.vadivel@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Dinesh Kumar Vadivel', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'dinesh.vadivel@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'muhammad.sulman@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Muhammad Sulman', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'muhammad.sulman@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'akshay.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Akshay Kumar Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'akshay.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'padma.vardhineedi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Padma Naresh Vardhineedi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'padma.vardhineedi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sandeep.sandrapati@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sandeep Kumar Sandrapati', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sandeep.sandrapati@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'prem.ravi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Prem Kumar Ravi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'prem.ravi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ameeruddin.mohammed@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ameeruddin Mohammed', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ameeruddin.mohammed@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vijayalaxmi.malladi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vijayalaxmi Malladi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vijayalaxmi.malladi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'lonny.angell@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Lonny Edward Angell', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'lonny.angell@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'john.mande@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'John Darby Mande', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'john.mande@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'akash.patil@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Akash Patil', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'akash.patil@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'madhavi.kagita@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Madhavi Kagita', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'madhavi.kagita@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ramesh.gunisetty@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ramesh Babu Gunisetty', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ramesh.gunisetty@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nikita.malik@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nikita', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nikita.malik@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anshika.srivastava@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anshika Srivastava', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anshika.srivastava@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gayathri.bolineni@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gayathri Bolineni', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gayathri.bolineni@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'tejaswini.vootkur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Tejaswini Vootkur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'tejaswini.vootkur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'akshay.ravikol@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Akshay Ravalkol Krishna', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'akshay.ravikol@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'chiranjeevi.bandla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Chiranjeevi Bandla', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'chiranjeevi.bandla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sonia.batra@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sonia Batra', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sonia.batra@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'maathangi.mahasivam@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Maathangi Mahasivam', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'maathangi.mahasivam@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anil.avvaru@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anil Kumar Avvaru', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anil.avvaru@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anupam.shah@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anupam Shah', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anupam.shah@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'lylas.oestreich@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Lylas Oestreich', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'lylas.oestreich@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shreya.ajmera@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shreya Bhavin Ajmera', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shreya.ajmera@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ankita.suryawanshi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ankita Mohan Suryawanshi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ankita.suryawanshi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'surya.sunkavalli@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Surya Prakash Sunkavalli', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'surya.sunkavalli@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jyoti.nandikonda@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jyothirmai Nandikonda', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jyoti.nandikonda@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vasu.dhana@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vasu Dhana', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vasu.dhana@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'karthik.karumanchi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Karthik Karumanchi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'karthik.karumanchi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vineela.guntuboyina@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vineela Guntuboyina', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vineela.guntuboyina@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'chandana.murittige@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Chandana Anantapadmanabha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'chandana.murittige@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'christopher.ryan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Christopher Patrick Ryan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'christopher.ryan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'hhema.alapati@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Hhema Alapati', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'hhema.alapati@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'dilusha.alponso@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Dilusha Alponso', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'dilusha.alponso@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vikram.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vikram Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vikram.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'amandeep.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Amandeep Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'amandeep.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'yuvaraj.kilari@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Yuvaraj Kilari', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'yuvaraj.kilari@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sourav.pradhan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sourav Kumar Pradhan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sourav.pradhan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'akhil.chimmula@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Akhil Reddy Chimmula', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'akhil.chimmula@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sivakumar.akkili@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sivakumar Akkili', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sivakumar.akkili@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pramod.kodali@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pramod Kodali', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pramod.kodali@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'chandan.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Chandan Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'chandan.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'venkata.puripanda@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Venkata Puripanda Ramesh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'venkata.puripanda@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'samuel.adeniji@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Samuel A Adeniji', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'samuel.adeniji@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'john.alexander@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'John Scott Alexander', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'john.alexander@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'susheel.karne@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Susheel Samanth Kiran', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'susheel.karne@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shriya.kannoj@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shriya Kannoj', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shriya.kannoj@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bharathi.palanisamy@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bharti P Palanisamy', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bharathi.palanisamy@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pravalika.animireddi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pravallika Animireddi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pravalika.animireddi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vignesh.thota@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vignesh Thota', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vignesh.thota@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'swathi.kommareddy@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Swathi Kommareddy', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'swathi.kommareddy@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'piyush.kalra@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Piyush Kalra', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'piyush.kalra@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abinash.dash@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abhinash Das', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abinash.dash@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'chetan.patel@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Chetan Kumar Patel', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'chetan.patel@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mehak.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mehak Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mehak.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'venu.vallapaneni@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Venu Vallapaneni', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'venu.vallapaneni@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abhyuday.lingala@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abhyuday Lingala', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abhyuday.lingala@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'Shiva.Pandiri@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shiva Kumar Pandiri', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'Shiva.Pandiri@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'hemanth.naineni@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Hemanth Rao', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'hemanth.naineni@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rahul.sadhu@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rahul Sadhu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rahul.sadhu@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kenyadah.prime@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kenyadah Shilexis Prime', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kenyadah.prime@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'javier.perez@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Javier Perez Arroyo', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'javier.perez@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sudha.aljapur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sudha Rani Aljapur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sudha.aljapur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rahul.javangula@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rahul Srivatsava Javangula', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rahul.javangula@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'naman.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Naman Gupta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'naman.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'khushal.ghathalia@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Khushal Ghathalia', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'khushal.ghathalia@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'maneesh.potti@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Maneesh Potti', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'maneesh.potti@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'satyajeet.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Satyajeet Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'satyajeet.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gourav.solanki@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gourav Solanki', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gourav.solanki@testingxperts.com');

-- PART B: Populate extra profile fields from CSV

UPDATE public.profiles SET
  full_name        = 'Karthik Kannathasan',
  emp_code         = '9209',
  designation      = 'Senior SDET',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'karthik.Kannathasan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Surinder Ram Sakha Singh',
  emp_code         = '9222',
  designation      = 'Senior Software Engineer',
  level_id         = 'Consultant',
  location         = 'India',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ManagedServices-1',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'surinder.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Priyanka Atluri',
  emp_code         = '9223',
  designation      = NULL,
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'priyanka.fmg@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sandeep Reddy Gowni',
  emp_code         = '9242',
  designation      = 'Software Engineer',
  level_id         = 'Consultant',
  location         = 'US/CA',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sandeep.gowni@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kavitha Ramakrishnan',
  emp_code         = '9253',
  designation      = 'Senior Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'Kavitha.ramakrishnan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sravan Kumar Golla',
  emp_code         = '9254',
  designation      = 'Full Stack Developer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'Market Report & Third Party Data',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sravankumar.golla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Okasha Momin',
  emp_code         = '9263',
  designation      = NULL,
  level_id         = 'Consultant',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'MTFBiologics-Dev',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'okasha.momin@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Madhusudhan Reddy Erram',
  emp_code         = '9266',
  designation      = 'Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'madhusudhan.erram@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Senthil Murugan Arumugam',
  emp_code         = '9271',
  designation      = NULL,
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'senthil.murugan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bharath Kumar Jannapureddy',
  emp_code         = '9302',
  designation      = 'Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'bharath.jannapureddy@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bala Krishna Artham',
  emp_code         = '9303',
  designation      = 'Senior Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'BTP Prod Support',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'balakrishna.artham@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Yamini Banothu',
  emp_code         = '9305',
  designation      = 'Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'BTP Prod Support',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'yamini.banothu@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vijay Kumar Tummala',
  emp_code         = '9307',
  designation      = 'Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'Market Report & Third Party Data',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'vijay.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Amaresh Narayanappa',
  emp_code         = '9312',
  designation      = NULL,
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'Market Report & Third Party Data',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'amaresh.narayanappa@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sulochana Rani Perumalla',
  emp_code         = '9316',
  designation      = 'Senior Test Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'DraftKings-Functional',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sulochana.peruma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mehmet Seker',
  emp_code         = '9320',
  designation      = 'SDET',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'Market Report & Third Party Data',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'mehmet.seker@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bethany Hampton',
  emp_code         = '9339',
  designation      = 'SDET',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'bethany.hampton@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Dinesh Kumar Vadivel',
  emp_code         = '9341',
  designation      = 'Senior Software Developer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'dinesh.vadivel@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Muhammad Sulman',
  emp_code         = '9345',
  designation      = 'Software Developer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'Market Report & Third Party Data',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'muhammad.sulman@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Akshay Kumar Singh',
  emp_code         = '9347',
  designation      = 'Software Developer',
  level_id         = 'Consultant',
  location         = 'Pune',
  delivery_manager = 'Rajul Goyal',
  project_name     = 'DairyTech',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'akshay.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Padma Naresh Vardhineedi',
  emp_code         = '9349',
  designation      = 'Senior Developer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'padma.vardhineedi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sandeep Kumar Sandrapati',
  emp_code         = '9351',
  designation      = 'Software Developer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'sandeep.sandrapati@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Prem Kumar Ravi',
  emp_code         = '9359',
  designation      = 'SDET',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'Market Report & Third Party Data',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'prem.ravi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ameeruddin Mohammed',
  emp_code         = '9364',
  designation      = 'Tech Lead',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'ameeruddin.mohammed@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vijayalaxmi Malladi',
  emp_code         = '9375',
  designation      = 'Senior Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'Market Report & Third Party Data',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'vijayalaxmi.malladi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Lonny Edward Angell',
  emp_code         = '9379',
  designation      = 'Lead',
  level_id         = 'Consultant',
  location         = 'US/CA',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'lonny.angell@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'John Darby Mande',
  emp_code         = '9383',
  designation      = 'Software Engineer',
  level_id         = 'Consultant',
  location         = 'US/CA',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'john.mande@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Akash Patil',
  emp_code         = '9384',
  designation      = 'DotNet Developer',
  level_id         = 'Consultant',
  location         = 'US/CA',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'akash.patil@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Madhavi Kagita',
  emp_code         = '9385',
  designation      = 'Data Tester',
  level_id         = 'Consultant',
  location         = 'US/CA',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Dominos',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'madhavi.kagita@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ramesh Babu Gunisetty',
  emp_code         = '9390',
  designation      = 'Software Engineer',
  level_id         = 'Consultant',
  location         = 'US/CA',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'ramesh.gunisetty@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nikita',
  emp_code         = '9395',
  designation      = 'Test Engineer',
  level_id         = 'Consultant',
  location         = 'Singapore',
  delivery_manager = 'Astha Saini',
  project_name     = 'ScootAirlines',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'nikita.malik@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anshika Srivastava',
  emp_code         = '9405',
  designation      = 'Test Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'DraftKings-Functional',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'anshika.srivastava@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gayathri Bolineni',
  emp_code         = '9407',
  designation      = 'QA Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gayathri.bolineni@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Tejaswini Vootkur',
  emp_code         = '9408',
  designation      = 'Product Technical Business Analyst',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'tejaswini.vootkur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Akshay Ravalkol Krishna',
  emp_code         = '9413',
  designation      = 'Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'akshay.ravikol@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Chiranjeevi Bandla',
  emp_code         = '9414',
  designation      = 'Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'chiranjeevi.bandla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sonia Batra',
  emp_code         = '9415',
  designation      = 'Senior Test Engineer',
  level_id         = 'Consultant',
  location         = 'Singapore',
  delivery_manager = 'Astha Saini',
  project_name     = 'ScootAirlines',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sonia.batra@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Maathangi Mahasivam',
  emp_code         = '9417',
  designation      = 'Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'Market Report & Third Party Data',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'maathangi.mahasivam@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anil Kumar Avvaru',
  emp_code         = '9418',
  designation      = 'Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'anil.avvaru@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anupam Shah',
  emp_code         = '9422',
  designation      = 'PeopleSoft Financials Functional Analyst',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'anupam.shah@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Lylas Oestreich',
  emp_code         = '9430',
  designation      = 'Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'ChurchMutual',
  original_du      = 'QE',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'lylas.oestreich@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shreya Bhavin Ajmera',
  emp_code         = '9440',
  designation      = 'Automation Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Radix IoT',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shreya.ajmera@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ankita Mohan Suryawanshi',
  emp_code         = '9446',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'SmartDubai',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ankita.suryawanshi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Surya Prakash Sunkavalli',
  emp_code         = '9456',
  designation      = 'Power BI Developer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'surya.sunkavalli@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jyothirmai Nandikonda',
  emp_code         = '9457',
  designation      = 'Senior Business Analyst',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'jyoti.nandikonda@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vasu Dhana',
  emp_code         = '9458',
  designation      = 'POS Tester',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'Zaxby''s- Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vasu.dhana@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Karthik Karumanchi',
  emp_code         = '9459',
  designation      = 'Platform Engineer',
  level_id         = 'Consultant',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'karthik.karumanchi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vineela Guntuboyina',
  emp_code         = '9462',
  designation      = NULL,
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'ChurchMutual',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vineela.guntuboyina@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Chandana Anantapadmanabha',
  emp_code         = '9464',
  designation      = 'Manual Tester',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'DraftKings-Functional',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'chandana.murittige@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Christopher Patrick Ryan',
  emp_code         = '9465',
  designation      = 'None',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'christopher.ryan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Hhema Alapati',
  emp_code         = '9469',
  designation      = 'PeopleSoft Financials Functional Analyst',
  level_id         = 'Level-1',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'hhema.alapati@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Dilusha Alponso',
  emp_code         = '9471',
  designation      = 'Test Engineer',
  level_id         = 'Consultant',
  location         = 'Canada',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Radix IoT',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'dilusha.alponso@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vikram Singh',
  emp_code         = '9480',
  designation      = 'Database Administrator',
  level_id         = 'Consultant',
  location         = 'Canada',
  delivery_manager = 'Rajul Goyal',
  project_name     = 'RadixIoT',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'vikram.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Amandeep Kaur',
  emp_code         = '9483',
  designation      = 'QA Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Radix IoT',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'amandeep.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Yuvaraj Kilari',
  emp_code         = '9489',
  designation      = 'Senior Business Analyst',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'yuvaraj.kilari@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sourav Kumar Pradhan',
  emp_code         = '9490',
  designation      = 'Test Manager',
  level_id         = 'Consultant',
  location         = 'Canada',
  delivery_manager = 'Neha Ummat',
  project_name     = 'AGIA-Affinity',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'sourav.pradhan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Akhil Reddy Chimmula',
  emp_code         = '9494',
  designation      = 'Data Analyst',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'Scholarship America',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'akhil.chimmula@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sivakumar Akkili',
  emp_code         = '9495',
  designation      = 'Data Analyst',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'Scholarship America',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sivakumar.akkili@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pramod Kodali',
  emp_code         = '9500',
  designation      = 'Senior Test Engineer',
  level_id         = 'Contractor',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'FourHands',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pramod.kodali@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Chandan Singh',
  emp_code         = '9501',
  designation      = 'Test Manager',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'chandan.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Venkata Puripanda Ramesh',
  emp_code         = '9502',
  designation      = '.Net Architect',
  level_id         = 'Consultant',
  location         = 'India',
  delivery_manager = 'Anand Kishore',
  project_name     = 'AHEAD - Lumicera',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'venkata.puripanda@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Samuel A Adeniji',
  emp_code         = '9504',
  designation      = 'Technical Specialist',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'PTC',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'samuel.adeniji@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'John Scott Alexander',
  emp_code         = '9505',
  designation      = 'Consultant',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'George Michael Giacometti',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'john.alexander@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Susheel Samanth Kiran',
  emp_code         = '9506',
  designation      = 'Senior Test Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'ChurchMutual',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'susheel.karne@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shriya Kannoj',
  emp_code         = '9508',
  designation      = 'Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'Scholarship America',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'shriya.kannoj@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bharti P Palanisamy',
  emp_code         = '9510',
  designation      = 'Lead Software Engineer',
  level_id         = 'Consultant',
  location         = 'Hyderabad',
  delivery_manager = 'Rajul Goyal',
  project_name     = 'ASTM-Sharepoint',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'bharathi.palanisamy@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pravallika Animireddi',
  emp_code         = '9511',
  designation      = 'Senior Test Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'ChurchMutual',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pravalika.animireddi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vignesh Thota',
  emp_code         = '9512',
  designation      = 'Senior Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'Zaxby''s- Onsite',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'vignesh.thota@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Swathi Kommareddy',
  emp_code         = '9513',
  designation      = 'Senior Software Engineer',
  level_id         = 'Consultant',
  location         = 'Canada',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'InteleosInc',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'swathi.kommareddy@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Piyush Kalra',
  emp_code         = '9514',
  designation      = 'Senior Architect',
  level_id         = 'Consultant',
  location         = 'Netherlands',
  delivery_manager = 'Rajul Goyal',
  project_name     = 'Kingspan SF DevOps',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'piyush.kalra@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Abhinash Das',
  emp_code         = '9515',
  designation      = 'Junior Architect',
  level_id         = 'Consultant',
  location         = 'Netherlands',
  delivery_manager = 'Rajul Goyal',
  project_name     = 'Kingspan SF DevOps',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'abinash.dash@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Chetan Kumar Patel',
  emp_code         = '9516',
  designation      = 'Solution Architect',
  level_id         = 'Consultant',
  location         = 'Chandigarh',
  delivery_manager = 'Anand Kishore',
  project_name     = 'VistaXM',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'chetan.patel@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mehak Sharma',
  emp_code         = '9517',
  designation      = 'Senior Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'Zaxby''s- Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'mehak.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Venu Vallapaneni',
  emp_code         = '9518',
  designation      = 'Test Architect',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'venu.vallapaneni@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Abhyuday Lingala',
  emp_code         = '9519',
  designation      = 'Senior Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'Scholarship America',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'abhyuday.lingala@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shiva Kumar Pandiri',
  emp_code         = '9520',
  designation      = 'Senior Data Analyst',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'Scholarship America',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'Shiva.Pandiri@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Hemanth Rao',
  emp_code         = '9521',
  designation      = 'Senior Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'Scholarship America',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'hemanth.naineni@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rahul Sadhu',
  emp_code         = '9522',
  designation      = 'Senior Test Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'Scholarship America',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rahul.sadhu@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kenyadah Shilexis Prime',
  emp_code         = '9523',
  designation      = 'QA Lead',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Fulton County',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kenyadah.prime@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Javier Perez Arroyo',
  emp_code         = '9524',
  designation      = 'Technical Specialist',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'PTC',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'javier.perez@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sudha Rani Aljapur',
  emp_code         = '9525',
  designation      = 'Technical Specialist',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'PTC',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sudha.aljapur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rahul Srivatsava Javangula',
  emp_code         = '9526',
  designation      = 'Sr. Data Analyst',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'Scholarship America',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rahul.javangula@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Naman Gupta',
  emp_code         = '9527',
  designation      = 'AI Data Engineer',
  level_id         = 'Consultant',
  location         = 'Chandigarh',
  delivery_manager = 'Manas Kumar Biswas',
  project_name     = 'DeluxeCorporation',
  original_du      = 'Data',
  assigned_du      = 'Data',
  role             = 'delivery_manager'
WHERE email = 'naman.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Khushal Ghathalia',
  emp_code         = '9528',
  designation      = 'AI Data Engineer',
  level_id         = 'Consultant',
  location         = 'Chandigarh',
  delivery_manager = 'Manas Kumar Biswas',
  project_name     = 'DeluxeCorporation',
  original_du      = 'Data',
  assigned_du      = 'Data',
  role             = 'delivery_manager'
WHERE email = 'khushal.ghathalia@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Maneesh Potti',
  emp_code         = '9529',
  designation      = 'AI Data Engineer',
  level_id         = 'Consultant',
  location         = 'Chandigarh',
  delivery_manager = 'Manas Kumar Biswas',
  project_name     = 'DeluxeCorporation',
  original_du      = 'Data',
  assigned_du      = 'Data',
  role             = 'delivery_manager'
WHERE email = 'maneesh.potti@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Satyajeet Kumar',
  emp_code         = '9530',
  designation      = 'AI Data Engineer',
  level_id         = 'Consultant',
  location         = 'Chandigarh',
  delivery_manager = 'Manas Kumar Biswas',
  project_name     = 'DeluxeCorporation',
  original_du      = 'Data',
  assigned_du      = 'Data',
  role             = 'delivery_manager'
WHERE email = 'satyajeet.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gourav Solanki',
  emp_code         = '9531',
  designation      = 'AI Data Engineer',
  level_id         = 'Consultant',
  location         = 'Chandigarh',
  delivery_manager = 'Manas Kumar Biswas',
  project_name     = 'DeluxeCorporation',
  original_du      = 'Data',
  assigned_du      = 'Data',
  role             = 'delivery_manager'
WHERE email = 'gourav.solanki@testingxperts.com';

