-- ============================================================
-- Batch 2/5 (200 employees)
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
  's.gurpreet@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gurpreet Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 's.gurpreet@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kumud.sanghi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kumud Sanghi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kumud.sanghi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'manisha.verma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Manisha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manisha.verma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'archit.jain@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Archit Jain', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'archit.jain@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sachin.agnihotri@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sachin Agnihotri', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sachin.agnihotri@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abhishek.chugh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abhishek Chugh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abhishek.chugh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aditi.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aditi Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aditi.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'akarshit.mahajan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Akarshit Mahajan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'akarshit.mahajan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'akshay.saha@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Akshay Kumar Saha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'akshay.saha@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'amit.chaudhary@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Amit Chaudhary', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'amit.chaudhary@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aniket.tanwar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aniket', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aniket.tanwar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anish.garg@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anish Garg', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anish.garg@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ashish.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ashish Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ashish.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kaur.damanpreet@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Damanpreet Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kaur.damanpreet@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'diksha.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Diksha Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'diksha.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gourav.dhar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gourav Dhar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gourav.dhar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'heena.vashisht@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Heena', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'heena.vashisht@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ishrar.ansari@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ishrar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ishrar.ansari@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jai.upadhyay@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jai Upadhyay', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jai.upadhyay@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kanishk.deshwal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kanishk Deshwal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kanishk.deshwal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'manish.k@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Manish Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manish.k@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mayank.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mayank Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mayank.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'neha.kumari@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Neha Kumari', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'neha.kumari@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nitish.chandel@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nitish Chandel', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nitish.chandel@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'parwinder.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Parwinder Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'parwinder.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ramzan.ali@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ramzan Ali', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ramzan.ali@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ridham.goel@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ridham Goel', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ridham.goel@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ritika.swaraj@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ritika Swaraj', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ritika.swaraj@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shubham.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shubham', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shubham.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shubham.choudhary@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shubham Choudhary', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shubham.choudhary@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'taranjit.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Taranjit Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'taranjit.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vishwajeet.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vishwajeet Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vishwajeet.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gagandeep.kumari@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gagandeep', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gagandeep.kumari@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gurdev.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gurdev Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gurdev.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aayushi.tyagi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aayushi Tyagi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aayushi.tyagi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'narinder.negi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Narinder', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'narinder.negi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rahul.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rahul', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rahul.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'deepti.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Deepti Gupta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'deepti.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shreya.verma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shreya Verma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shreya.verma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'hardeep.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Hardeep Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'hardeep.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abhinav.chaudary@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abhinav Chaudary', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abhinav.chaudary@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'amneet.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Amneet Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'amneet.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ramandeep.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ramandeep Singh Bakshi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ramandeep.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mayank.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mayank Gupta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mayank.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pallavi.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pallavi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pallavi.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pooja.chaudhary@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pooja Chaudhary', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pooja.chaudhary@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abhinandan.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abhinandan Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abhinandan.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sharma.neha@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Neha Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sharma.neha@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abhishek.bhatia@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abhishek Bhatia', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abhishek.bhatia@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gursukhab.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gursukhab Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gursukhab.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'upma.bhatnagar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Upma Bhatnagar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'upma.bhatnagar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'manohar.nayanipeta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Manohar Nayanipeta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manohar.nayanipeta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anchal.nijhara@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anchal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anchal.nijhara@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bhanu.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bhanu Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bhanu.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'madhu.varadi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Varadi Madhu kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'madhu.varadi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'varun.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Varun Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'varun.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'umesh.kake@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kake Umesh Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'umesh.kake@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'veena.malipatel@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'M Veena', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'veena.malipatel@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sairam.vempati@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vempati Sairam', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sairam.vempati@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bharti.t@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bharti Thakur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bharti.t@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mohit.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mohit Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mohit.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jyothi.gandham@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gandham Jyothi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jyothi.gandham@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shaik.jani@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jani Shaik', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shaik.jani@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vinay.nagabheri@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nagabheri Vinay Pavan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vinay.nagabheri@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bharat.bhushan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bharat Bhushan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bharat.bhushan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'baljinder.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Baljinder Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'baljinder.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pooja.verma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pooja Verma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pooja.verma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'naveena.jagi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jagi Naveena', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'naveena.jagi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gaurav.bharadwaj@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gaurav Bharadwaj', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gaurav.bharadwaj@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'awantika.rana@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Awantika Rana', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'awantika.rana@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ramita.sambyal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ramita Devi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ramita.sambyal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'revathi.dharmana@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Dharmana Revathi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'revathi.dharmana@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'balwinder.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Balwinder Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'balwinder.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'akash.bains@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Akash', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'akash.bains@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'danenjay.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Danenjay Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'danenjay.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sharma.priyanka@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Priyanka', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sharma.priyanka@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pankaj.s@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pankaj Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pankaj.s@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bharat.bhatia@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bharat Bhatia', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bharat.bhatia@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shivani.arya@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shivani Arya', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shivani.arya@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shruthi.dharnaik@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shruthi Niranjan Dharnaik', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shruthi.dharnaik@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mandeep.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mandeep Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mandeep.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ramanjit.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ramanjit Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ramanjit.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'singh.shubham@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shubham Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'singh.shubham@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'priya.rana@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Priya Rana', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'priya.rana@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vikrant.kamal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vikrant Kamal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vikrant.kamal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'asra.tabassum@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shaik Asra Tabassum', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'asra.tabassum@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sai.mada@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mada Sai Krishna', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sai.mada@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'umakanth.kutchu@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kutchu Umakanth', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'umakanth.kutchu@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'chitranjan.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Chitranjan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'chitranjan.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'subhopriya.chowdhury@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Subhopriya Chowdhury', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'subhopriya.chowdhury@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kiran.tumati@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Tumati Kiran Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kiran.tumati@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'karishma.malhotra@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Karishma Malhotra', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'karishma.malhotra@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vijay.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vijay Narayan Gupta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vijay.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'manish.shamma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Manish Shamma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manish.shamma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sahil.kapoor@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sahil Kapoor', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sahil.kapoor@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'manveer.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Manveer Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manveer.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nitish.dhiman@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nitish Dhiman', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nitish.dhiman@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pallabi.dutta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pallabi Dutta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pallabi.dutta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sukanya.jagtap@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sukanya Rajendra Jagtap', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sukanya.jagtap@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kumar.amit@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Amit Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kumar.amit@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'himanshu.saluja@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Himanshu Saluja', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'himanshu.saluja@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sushmita.pradhan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sushmita Pradhan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sushmita.pradhan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'davalesh.sadu@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sadu Davalesh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'davalesh.sadu@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'santosh.k@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Santosh Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'santosh.k@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'neelima.boyina@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Boyina Neelima', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'neelima.boyina@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jaganpreet.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jaganpreet Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jaganpreet.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gaurav.tyagi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gaurav Tyagi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gaurav.tyagi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shiva.kandula@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kandula Shiva Reddy', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shiva.kandula@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shaikh.naufil@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Naufil Mohammedsalim Shaikh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shaikh.naufil@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  's.hemavathi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'S Hemavathi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 's.hemavathi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shilpa.lingaraddi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shilpa Lingaraddi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shilpa.lingaraddi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'balasaheb.bidawe@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bidawe Balasaheb Nagoraw', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'balasaheb.bidawe@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'chanderkant.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Chanderkant Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'chanderkant.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'deeksha.sood@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Deeksha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'deeksha.sood@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'poojalin.behera@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Poojalin Behera', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'poojalin.behera@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gulshan.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gulshan Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gulshan.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vikas.saini@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vikas Saini', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vikas.saini@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shivangi.latta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shivangi Latta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shivangi.latta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jyothi.honnappanavar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jyothi M Honnappanavar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jyothi.honnappanavar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'naveen.kaniganti@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'K Naveen', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'naveen.kaniganti@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'neha.u@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Neha Ummat', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'neha.u@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ramya.bejugam@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bejugam Ramya', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ramya.bejugam@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nishita.arora@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nishita Arora', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nishita.arora@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kshitij.sahariya@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kshitij Sahariya', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kshitij.sahariya@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'devashreya.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Devashreya Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'devashreya.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kamalnain.ghuman@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kamalnain Singh Ghuman', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kamalnain.ghuman@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'prabhdeep.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Prabhdeep Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'prabhdeep.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'satya.yadav@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Satya Nirakar Singh Yadav', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'satya.yadav@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ramprasad.guttula@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ramprasad Guttula', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ramprasad.guttula@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'navdeep.ravala@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Navdeep Kaur Ravala', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'navdeep.ravala@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'garima.aggarwal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Garima Aggarwal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'garima.aggarwal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shimla.dubey@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shimla Dubey', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shimla.dubey@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rupali.p@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rupali', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rupali.p@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'manikya.girish@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rali Manikya Girish', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manikya.girish@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nikita.dange@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nikita Moreshwar Dange', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nikita.dange@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gautam.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gautam Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gautam.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gurlove.chopra@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gurlove Chopra', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gurlove.chopra@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'hardeep.negi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Hardeep Singh Negi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'hardeep.negi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'arti.thakur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Arti Thakur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'arti.thakur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abhishek.modi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abhishek Kumar Modi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abhishek.modi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'hemanth.kandalla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kandalla Hemanth', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'hemanth.kandalla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abhishek.mehta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abhishek Mehta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abhishek.mehta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'selvi.balusamy@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Selvi Balusamy', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'selvi.balusamy@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'akansha.shah@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Akansha Shah', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'akansha.shah@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'praveen.k@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Praveen K', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'praveen.k@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'megha.wadhwa@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Megha Wadhwa', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'megha.wadhwa@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gopal.krishan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gopal Krishan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gopal.krishan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nitish.raghav@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nitish Raghav', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nitish.raghav@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'avi.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Avi Gupta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'avi.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jenin.joseph@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jenin Joseph', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jenin.joseph@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ankush.goyal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ankush Goyal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ankush.goyal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ravi.tiwari@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ravi Kant Tiwari', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ravi.tiwari@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anusha.machavarapu@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Machavarapu Anusha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anusha.machavarapu@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rafeeq.mohammed@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mohammed Abdul Rafeeq', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rafeeq.mohammed@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'namit.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Namit', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'namit.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ankita.a@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ankita', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ankita.a@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shweta.dwivedi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shweta Dwivedi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shweta.dwivedi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gurpartap.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gurpartap Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gurpartap.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'tushar.nirman@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Tushar Nirman', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'tushar.nirman@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vikrant.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vikrant Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vikrant.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aakash.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aakash Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aakash.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ritesh.jaswal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ritesh Jaswal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ritesh.jaswal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'parminder.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Parminder Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'parminder.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shivang.seth@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shivang Seth', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shivang.seth@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anurag.pandey@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anurag Pandey', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anurag.pandey@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ravjot.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ravjot Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ravjot.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nagen.panda@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nagen Chandan Panda', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nagen.panda@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'hasrat.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Hasrat Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'hasrat.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mohit@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mohit', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mohit@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'dhriti.kapoor@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Dhriti', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'dhriti.kapoor@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abhay.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abhay Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abhay.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sindhu.punuru@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Punuru Sindhu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sindhu.punuru@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'apurva.s@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Apurva Saini', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'apurva.s@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'neeraj.malhotra@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Neeraj Malhotra', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'neeraj.malhotra@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'surender.m@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Surender M', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'surender.m@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'harvinder.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Harvinder Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'harvinder.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kamlesh.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kamlesh Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kamlesh.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nitin.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nitin Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nitin.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'priyanshu.rawat@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Priyanshu Rawat', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'priyanshu.rawat@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vinay.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vinay Kumar Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vinay.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'simarjeet.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Simarjeet Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'simarjeet.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gowtham.belli@testinxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gowtham', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gowtham.belli@testinxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pankaj.mishra@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pankaj Mishra', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pankaj.mishra@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'navjot.sandhu@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Navjot Kaur Sandhu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'navjot.sandhu@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'naveen.bomma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bomma Naveen', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'naveen.bomma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'santosh.sk@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Santosh S K', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'santosh.sk@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pratyusha.k@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kandikattu Pratyusha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pratyusha.k@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mohammed.riyaz@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mohammed Riyaz', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mohammed.riyaz@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'raghav.tangri@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Raghav Tangri', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'raghav.tangri@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anuj.bisht@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anuj Bisht', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anuj.bisht@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'yugank.anchal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Yugank Anchal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'yugank.anchal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rohit.t@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rohit Thakur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rohit.t@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'payal.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Payal Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'payal.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'peter.velpula@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Peter Velpula', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'peter.velpula@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gaurav.gaikwad@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'GAURAV SANJAY GAIKWAD', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gaurav.gaikwad@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'chetan.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Chetan Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'chetan.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gleesha.agarwal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gleesha Agarwal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gleesha.agarwal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kunal.bhargava@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kunal Bhargava', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kunal.bhargava@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'chennakesava.barakam@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Barakam Chennakesava', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'chennakesava.barakam@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abhishek.kulkarni@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abhishek Jagdish Kulkarni', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abhishek.kulkarni@testingxperts.com');

-- PART B: Populate extra profile fields from CSV

UPDATE public.profiles SET
  full_name        = 'Gurpreet Singh',
  emp_code         = '3615',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 's.gurpreet@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kumud Sanghi',
  emp_code         = '3616',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'M3Tech-Development',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'kumud.sanghi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Manisha',
  emp_code         = '3617',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'manisha.verma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Archit Jain',
  emp_code         = '3622',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'CorpCU-UiPath',
  original_du      = 'DES',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'archit.jain@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sachin Agnihotri',
  emp_code         = '3624',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Micron UiPath Migration',
  original_du      = 'DES',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sachin.agnihotri@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Abhishek Chugh',
  emp_code         = '3628',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Gleesha Agarwal',
  project_name     = 'TruBridge',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'abhishek.chugh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aditi Sharma',
  emp_code         = '3630',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ruchika Rani Mehta',
  project_name     = 'Five9',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'aditi.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Akarshit Mahajan',
  emp_code         = '3631',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Micron UiPath Migration',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'akarshit.mahajan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Akshay Kumar Saha',
  emp_code         = '3632',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Ruchika Rani Mehta',
  project_name     = 'Five9',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'akshay.saha@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Amit Chaudhary',
  emp_code         = '3635',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'City & Guilds',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'amit.chaudhary@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aniket',
  emp_code         = '3636',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'City & Guilds',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'aniket.tanwar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anish Garg',
  emp_code         = '3639',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'City & Guilds',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'anish.garg@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ashish Kumar',
  emp_code         = '3645',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Navitus',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ashish.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Damanpreet Kaur',
  emp_code         = '3648',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'Apex-SilverManagement',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kaur.damanpreet@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Diksha Sharma',
  emp_code         = '3650',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'Apex-SilverManagement',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'diksha.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gourav Dhar',
  emp_code         = '3651',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ramandeep Singh Bakshi',
  project_name     = 'Tx-PEARS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gourav.dhar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Heena',
  emp_code         = '3654',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ramandeep Singh Bakshi',
  project_name     = 'VeraCode',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'heena.vashisht@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ishrar',
  emp_code         = '3655',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Jatinder Jain',
  project_name     = 'Network18',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ishrar.ansari@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jai Upadhyay',
  emp_code         = '3656',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'DES',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'jai.upadhyay@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kanishk Deshwal',
  emp_code         = '3657',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'Hyde Housing Association',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kanishk.deshwal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Manish Kumar',
  emp_code         = '3659',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'Airtel Africa',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'manish.k@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mayank Sharma',
  emp_code         = '3661',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Navitus',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'mayank.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Neha Kumari',
  emp_code         = '3664',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'CommonwealthCharterAcademy-Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'neha.kumari@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nitish Chandel',
  emp_code         = '3668',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Goldy Gupta',
  project_name     = '211SanDiego',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'nitish.chandel@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Parwinder Singh',
  emp_code         = '3670',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'CommonwealthCharterAcademy-Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'parwinder.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ramzan Ali',
  emp_code         = '3672',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'SRA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ramzan.ali@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ridham Goel',
  emp_code         = '3673',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'CommonwealthCharterAcademy-Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ridham.goel@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ritika Swaraj',
  emp_code         = '3674',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'CorporateOneFederalCreditUnion',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ritika.swaraj@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shubham',
  emp_code         = '3681',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'BoyleSports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shubham.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shubham Choudhary',
  emp_code         = '3682',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Iqbal Singh',
  project_name     = 'Sagicor',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shubham.choudhary@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Taranjit Kaur',
  emp_code         = '3684',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'SRA',
  original_du      = 'DES',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'taranjit.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vishwajeet Singh',
  emp_code         = '3685',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ruchika Rani Mehta',
  project_name     = 'Keystone-Accessibility Testing',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vishwajeet.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gagandeep',
  emp_code         = '3690',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'PreferredMutual',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gagandeep.kumari@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gurdev Kumar',
  emp_code         = '3695',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'DeluxeCorporation-UiPath',
  original_du      = 'DES',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gurdev.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aayushi Tyagi',
  emp_code         = '3697',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Ruchika Rani Mehta',
  project_name     = 'EnableAll-Accessibility Testing',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'aayushi.tyagi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Narinder',
  emp_code         = '3699',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'ACS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'narinder.negi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rahul',
  emp_code         = '3700',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rahul.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Deepti Gupta',
  emp_code         = '3709',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'ACS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'deepti.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shreya Verma',
  emp_code         = '3712',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'ACS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shreya.verma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Hardeep Singh',
  emp_code         = '3714',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Zaxby',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'hardeep.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Abhinav Chaudary',
  emp_code         = '3719',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ManagedServices-1',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'abhinav.chaudary@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Amneet Kaur',
  emp_code         = '3725',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'USA',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'amneet.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ramandeep Singh Bakshi',
  emp_code         = '3728',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Manjeet Kumar',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ramandeep.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mayank Gupta',
  emp_code         = '3743',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'Hazeltree',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'mayank.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pallavi',
  emp_code         = '3750',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'OfficerTrak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pallavi.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pooja Chaudhary',
  emp_code         = '3754',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pooja.chaudhary@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Abhinandan Sharma',
  emp_code         = '3756',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Astha Saini',
  project_name     = 'Apex-Margin&Risk',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'abhinandan.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Neha Sharma',
  emp_code         = '3757',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Rohit Kumar',
  project_name     = 'SWG',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sharma.neha@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Abhishek Bhatia',
  emp_code         = '3763',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'SKEPS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'abhishek.bhatia@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gursukhab Singh',
  emp_code         = '3764',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'EverPaw',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'gursukhab.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Upma Bhatnagar',
  emp_code         = '3774',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'Hazeltree',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'upma.bhatnagar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Manohar Nayanipeta',
  emp_code         = '3776',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'DeluxeCorporation-UiPath',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'manohar.nayanipeta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anchal',
  emp_code         = '3779',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'City & Guilds',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'anchal.nijhara@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bhanu Sharma',
  emp_code         = '3788',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Noida',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'bhanu.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Varadi Madhu kumar',
  emp_code         = '3802',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'DES',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'madhu.varadi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Varun Sharma',
  emp_code         = '3805',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'varun.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kake Umesh Kumar',
  emp_code         = '3806',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Neha Ummat',
  project_name     = 'AIPSO',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'umesh.kake@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'M Veena',
  emp_code         = '3812',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Astha Saini',
  project_name     = 'Alorica',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'veena.malipatel@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vempati Sairam',
  emp_code         = '3814',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Neha Ummat',
  project_name     = 'AGIA-Affinity',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'sairam.vempati@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bharti Thakur',
  emp_code         = '3817',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'bharti.t@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mohit Kumar',
  emp_code         = '3819',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'Sagri',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'mohit.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gandham Jyothi',
  emp_code         = '3823',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Subhrajit Sahoo',
  project_name     = 'AmeriLife - Automation Testing Services',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'jyothi.gandham@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jani Shaik',
  emp_code         = '3825',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'MTFBiologics-Dev',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'shaik.jani@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nagabheri Vinay Pavan',
  emp_code         = '3832',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Zaxby',
  original_du      = 'DES',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vinay.nagabheri@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bharat Bhushan',
  emp_code         = '3833',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'bharat.bhushan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Baljinder Singh',
  emp_code         = '3839',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'baljinder.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pooja Verma',
  emp_code         = '3841',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'CommonwealthCharterAcademy-Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pooja.verma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jagi Naveena',
  emp_code         = '3846',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'DES',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'naveena.jagi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gaurav Bharadwaj',
  emp_code         = '3850',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gaurav.bharadwaj@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Awantika Rana',
  emp_code         = '3854',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'Group1001',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'awantika.rana@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ramita Devi',
  emp_code         = '3855',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ramita.sambyal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Dharmana Revathi',
  emp_code         = '3860',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Navitus',
  original_du      = 'DES',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'revathi.dharmana@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Balwinder Kaur',
  emp_code         = '3861',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'balwinder.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Akash',
  emp_code         = '3863',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'City & Guilds',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'akash.bains@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Danenjay Singh',
  emp_code         = '3868',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Iqbal Singh',
  project_name     = 'Safexpress',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'danenjay.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Priyanka',
  emp_code         = '3869',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'FAMA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sharma.priyanka@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pankaj Sharma',
  emp_code         = '3876',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Starzplay',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pankaj.s@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bharat Bhatia',
  emp_code         = '3888',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Navitus',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'bharat.bhatia@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shivani Arya',
  emp_code         = '3889',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Fiserv',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shivani.arya@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shruthi Niranjan Dharnaik',
  emp_code         = '3890',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shruthi.dharnaik@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mandeep Singh',
  emp_code         = '3900',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Fiserv',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'mandeep.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ramanjit Singh',
  emp_code         = '3901',
  designation      = 'Associate Project Manager',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'MTFBiologics-Dev',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'ramanjit.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shubham Singh',
  emp_code         = '3912',
  designation      = 'Software Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Anand Kishore',
  project_name     = 'VistaXM',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'singh.shubham@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Priya Rana',
  emp_code         = '3920',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ManagedServices-1',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'priya.rana@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vikrant Kamal',
  emp_code         = '3923',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'OfficerTrak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vikrant.kamal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shaik Asra Tabassum',
  emp_code         = '3931',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rajul Goyal',
  project_name     = 'MCS-Dev',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'asra.tabassum@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mada Sai Krishna',
  emp_code         = '3932',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Neha Ummat',
  project_name     = 'AGIA-Affinity',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'sai.mada@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kutchu Umakanth',
  emp_code         = '3936',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'DES',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'umakanth.kutchu@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Chitranjan',
  emp_code         = '3940',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ManagedServices-1',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'chitranjan.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Subhopriya Chowdhury',
  emp_code         = '3945',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Dominos',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'subhopriya.chowdhury@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Tumati Kiran Kumar',
  emp_code         = '3950',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Hyderabad',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'Apex-SilverManagement',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kiran.tumati@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Karishma Malhotra',
  emp_code         = '3953',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'karishma.malhotra@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vijay Narayan Gupta',
  emp_code         = '3975',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'City & Guilds',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vijay.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Manish Shamma',
  emp_code         = '3980',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'KFC',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'manish.shamma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sahil Kapoor',
  emp_code         = '3981',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'City & Guilds',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sahil.kapoor@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Manveer Kaur',
  emp_code         = '3987',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'manveer.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nitish Dhiman',
  emp_code         = '3988',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Mercedez-MBSA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'nitish.dhiman@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pallabi Dutta',
  emp_code         = '3990',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'Hazeltree',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pallabi.dutta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sukanya Rajendra Jagtap',
  emp_code         = '3995',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Jatinder Jain',
  project_name     = 'Tandem Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sukanya.jagtap@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Amit Kumar',
  emp_code         = '3998',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kumar.amit@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Himanshu Saluja',
  emp_code         = '4002',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'ConsumerReports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'himanshu.saluja@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sushmita Pradhan',
  emp_code         = '4003',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sushmita.pradhan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sadu Davalesh',
  emp_code         = '4007',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'CorporateOneFederalCreditUnion',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'davalesh.sadu@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Santosh Kumar',
  emp_code         = '4009',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'BTP Prod Support',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'santosh.k@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Boyina Neelima',
  emp_code         = '4018',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Jatinder Jain',
  project_name     = 'Tandem Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'neelima.boyina@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jaganpreet Singh',
  emp_code         = '4023',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'Zaxby''s- Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'jaganpreet.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gaurav Tyagi',
  emp_code         = '4027',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Noida',
  delivery_manager = 'Rajul Goyal',
  project_name     = 'MCS-Dev',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'gaurav.tyagi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kandula Shiva Reddy',
  emp_code         = '4049',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ManagedServices-2',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shiva.kandula@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Naufil Mohammedsalim Shaikh',
  emp_code         = '4050',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-LegacyProductRetirementPhase-2',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'shaikh.naufil@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'S Hemavathi',
  emp_code         = '4051',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'ACS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 's.hemavathi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shilpa Lingaraddi',
  emp_code         = '4053',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'CovantageCreditUnion',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shilpa.lingaraddi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bidawe Balasaheb Nagoraw',
  emp_code         = '4054',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Ruchika Rani Mehta',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'balasaheb.bidawe@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Chanderkant Sharma',
  emp_code         = '4059',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'M3Tech-Development',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'chanderkant.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Deeksha',
  emp_code         = '4060',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anand Kishore',
  project_name     = 'AHEAD - Lumicera',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'deeksha.sood@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Poojalin Behera',
  emp_code         = '4062',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Bangalore',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'PreferredMutual',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'poojalin.behera@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gulshan Kumar',
  emp_code         = '4066',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'PreferredMutual',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'gulshan.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vikas Saini',
  emp_code         = '4072',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'ACS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vikas.saini@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shivangi Latta',
  emp_code         = '4073',
  designation      = 'Associate Project Manager',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'M3Tech-Development',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'shivangi.latta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jyothi M Honnappanavar',
  emp_code         = '4076',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Bangalore',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'BoyleSports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'jyothi.honnappanavar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'K Naveen',
  emp_code         = '4077',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Goldy Gupta',
  project_name     = 'UrbanBuzz-Functional',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'naveen.kaniganti@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Neha Ummat',
  emp_code         = '4080',
  designation      = 'Test Manager',
  level_id         = 'Level-5',
  location         = 'Chandigarh',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'neha.u@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bejugam Ramya',
  emp_code         = '4082',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Neha Ummat',
  project_name     = 'CM-Performance',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'ramya.bejugam@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nishita Arora',
  emp_code         = '4084',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'nishita.arora@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kshitij Sahariya',
  emp_code         = '4086',
  designation      = 'Senior Test Manager',
  level_id         = 'Level-6',
  location         = 'Noida',
  delivery_manager = 'Manjeet Kumar',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kshitij.sahariya@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Devashreya Sharma',
  emp_code         = '4090',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Astha Saini',
  project_name     = 'Alorica',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'devashreya.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kamalnain Singh Ghuman',
  emp_code         = '4096',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kamalnain.ghuman@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Prabhdeep Singh',
  emp_code         = '4098',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Bangalore',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-LegacyProductRetirementPhase-2',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'prabhdeep.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Satya Nirakar Singh Yadav',
  emp_code         = '4099',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Astha Saini',
  project_name     = 'Alorica',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'satya.yadav@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ramprasad Guttula',
  emp_code         = '4100',
  designation      = 'Senior Technical Architect',
  level_id         = 'Level-7',
  location         = 'USA',
  delivery_manager = 'Subodh Kumar',
  project_name     = 'ChurchMutual',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'ramprasad.guttula@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Navdeep Kaur Ravala',
  emp_code         = '4108',
  designation      = 'Associate Test Architect',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Goldy Gupta',
  project_name     = 'Clinigen',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'navdeep.ravala@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Garima Aggarwal',
  emp_code         = '4111',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Noida',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'EverPaw',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'garima.aggarwal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shimla Dubey',
  emp_code         = '4113',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'SKEPS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shimla.dubey@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rupali',
  emp_code         = '4114',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rupali.p@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rali Manikya Girish',
  emp_code         = '4125',
  designation      = 'Director',
  level_id         = 'Level-8A',
  location         = 'Hyderabad',
  delivery_manager = 'Manjeet Kumar',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'manikya.girish@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nikita Moreshwar Dange',
  emp_code         = '4128',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Hyderabad',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Mercedez-MBSA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'nikita.dange@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gautam Sharma',
  emp_code         = '4137',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gautam.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gurlove Chopra',
  emp_code         = '4139',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Subodh Kumar',
  project_name     = 'ChurchMutual',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'gurlove.chopra@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Hardeep Singh Negi',
  emp_code         = '4140',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'hardeep.negi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Arti Thakur',
  emp_code         = '4141',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'SRA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'arti.thakur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Abhishek Kumar Modi',
  emp_code         = '4142',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'City & Guilds',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'abhishek.modi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kandalla Hemanth',
  emp_code         = '4143',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'CommonwealthCharterAcademy-Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'hemanth.kandalla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Abhishek Mehta',
  emp_code         = '4145',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'abhishek.mehta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Selvi Balusamy',
  emp_code         = '4148',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Micron UiPath Migration',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'selvi.balusamy@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Akansha Shah',
  emp_code         = '4149',
  designation      = 'Technical Architect',
  level_id         = 'Level-5',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'Avercare',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'akansha.shah@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Praveen K',
  emp_code         = '4155',
  designation      = 'Associate Technical Architect',
  level_id         = 'Level-4',
  location         = 'Hyderabad',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'praveen.k@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Megha Wadhwa',
  emp_code         = '4156',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'megha.wadhwa@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gopal Krishan',
  emp_code         = '4167',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'Avercare',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'gopal.krishan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nitish Raghav',
  emp_code         = '4168',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'Avercare',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'nitish.raghav@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Avi Gupta',
  emp_code         = '4171',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Iqbal Singh',
  project_name     = 'Safexpress',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'avi.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jenin Joseph',
  emp_code         = '4174',
  designation      = 'Team Lead',
  level_id         = 'Level-3',
  location         = 'Bangalore',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'iliad Automation Testing',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'jenin.joseph@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ankush Goyal',
  emp_code         = '4181',
  designation      = 'Test Manager',
  level_id         = 'Level-5',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'iliad Automation Testing',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ankush.goyal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ravi Kant Tiwari',
  emp_code         = '4182',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'ravi.tiwari@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Machavarapu Anusha',
  emp_code         = '4184',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'CorporateOneFederalCreditUnion',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'anusha.machavarapu@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mohammed Abdul Rafeeq',
  emp_code         = '4187',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'UK',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Freemans Grattan Holdings',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rafeeq.mohammed@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Namit',
  emp_code         = '4190',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'namit.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ankita',
  emp_code         = '4191',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Akansha Shah',
  project_name     = 'POC-DEV',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'ankita.a@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shweta Dwivedi',
  emp_code         = '4199',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'SRA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shweta.dwivedi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gurpartap Singh',
  emp_code         = '4202',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gurpartap.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Tushar Nirman',
  emp_code         = '4204',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'CommonwealthCharterAcademy-Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'tushar.nirman@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vikrant Kumar',
  emp_code         = '4208',
  designation      = 'Lead Business Analyst',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Neha Ummat',
  project_name     = 'AGIA-Affinity',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'vikrant.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aakash Kumar',
  emp_code         = '4209',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-LegacyProductRetirementPhase-2',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'aakash.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ritesh Jaswal',
  emp_code         = '4213',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Navjot Kaur Sandhu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'ritesh.jaswal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Parminder Kumar',
  emp_code         = '4216',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'parminder.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shivang Seth',
  emp_code         = '4219',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Nunakana Satish Kumar',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'shivang.seth@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anurag Pandey',
  emp_code         = '4220',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Manas Kumar Biswas',
  project_name     = 'ASTM-SQC',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'anurag.pandey@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ravjot Kaur',
  emp_code         = '4222',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ravjot.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nagen Chandan Panda',
  emp_code         = '4227',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Iqbal Singh',
  project_name     = 'Safexpress',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'nagen.panda@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Hasrat Singh',
  emp_code         = '4230',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Payal Sharma',
  project_name     = 'Xcelerator Groups',
  original_du      = 'Data',
  assigned_du      = 'Data',
  role             = 'delivery_manager'
WHERE email = 'hasrat.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mohit',
  emp_code         = '4235',
  designation      = 'Software Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Payal Sharma',
  project_name     = 'Tx-DataPractice',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'mohit@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Dhriti',
  emp_code         = '4236',
  designation      = 'Software Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'SRA-DevOps',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'dhriti.kapoor@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Abhay Singh',
  emp_code         = '4239',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Subodh Kumar',
  project_name     = 'IFD-Dev',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'abhay.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Punuru Sindhu',
  emp_code         = '4240',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'NeoGov-QA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sindhu.punuru@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Apurva Saini',
  emp_code         = '4241',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'apurva.s@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Neeraj Malhotra',
  emp_code         = '4242',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Noida',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'ACS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'neeraj.malhotra@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Surender M',
  emp_code         = '4243',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Bangalore',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Brightstar',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'surender.m@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Harvinder Singh',
  emp_code         = '4246',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'harvinder.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kamlesh Kumar',
  emp_code         = '4249',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Noida',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'CommonwealthCharterAcademy-Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kamlesh.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nitin Kumar',
  emp_code         = '4250',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'nitin.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Priyanshu Rawat',
  emp_code         = '4251',
  designation      = 'Software Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Anand Kishore',
  project_name     = 'Intermax-DEV',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'priyanshu.rawat@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vinay Kumar Sharma',
  emp_code         = '4260',
  designation      = 'Technical Architect',
  level_id         = 'Level-5',
  location         = 'Chandigarh',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'POC-DEV',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vinay.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Simarjeet Singh',
  emp_code         = '4262',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'simarjeet.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gowtham',
  emp_code         = '4264',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'gowtham.belli@testinxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pankaj Mishra',
  emp_code         = '4265',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Noida',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'CommonwealthCharterAcademy-Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pankaj.mishra@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Navjot Kaur Sandhu',
  emp_code         = '4266',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Subodh Kumar',
  project_name     = 'ChurchMutual',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'navjot.sandhu@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bomma Naveen',
  emp_code         = '4272',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Air Canada-UiPath',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'naveen.bomma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Santosh S K',
  emp_code         = '4273',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Bangalore',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'santosh.sk@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kandikattu Pratyusha',
  emp_code         = '4274',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Hyderabad',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'City & Guilds',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pratyusha.k@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mohammed Riyaz',
  emp_code         = '4278',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Akansha Shah',
  project_name     = 'DES-AI',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'mohammed.riyaz@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Raghav Tangri',
  emp_code         = '4279',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Akansha Shah',
  project_name     = 'DES-AI',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'raghav.tangri@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anuj Bisht',
  emp_code         = '4280',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Noida',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'CoreTeam',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'anuj.bisht@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Yugank Anchal',
  emp_code         = '4281',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Rajul Goyal',
  project_name     = 'ASTM-Sharepoint',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'yugank.anchal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rohit Thakur',
  emp_code         = '4282',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Rajul Goyal',
  project_name     = 'DairyTech',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'rohit.t@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Payal Sharma',
  emp_code         = '4285',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anand Kishore',
  project_name     = 'VistaXM',
  original_du      = 'Data',
  assigned_du      = 'Data',
  role             = 'delivery_manager'
WHERE email = 'payal.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Peter Velpula',
  emp_code         = '4286',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'iliad Automation Testing',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'peter.velpula@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'GAURAV SANJAY GAIKWAD',
  emp_code         = '4287',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'T Bharath Babu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gaurav.gaikwad@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Chetan Singh',
  emp_code         = '4290',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Noida',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'SRA-DevOps',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'chetan.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gleesha Agarwal',
  emp_code         = '4291',
  designation      = 'Test Architect',
  level_id         = 'Level-5',
  location         = 'Chandigarh',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gleesha.agarwal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kunal Bhargava',
  emp_code         = '4293',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'MTFBiologics-Dev',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'kunal.bhargava@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Barakam Chennakesava',
  emp_code         = '4295',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'chennakesava.barakam@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Abhishek Jagdish Kulkarni',
  emp_code         = '4296',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'abhishek.kulkarni@testingxperts.com';

