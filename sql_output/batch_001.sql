-- ============================================================
-- Batch 1/5 (200 employees)
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
  'manjeet.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Manjeet Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manjeet.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ashwani.narula@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ashwani Narula', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ashwani.narula@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rohit.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rohit Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rohit.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kaur.manpreet@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Manpreet Kaur Sandhu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kaur.manpreet@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'hemant.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Hemant Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'hemant.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shanish.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shanish Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shanish.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gurpreet.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gurpreet Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gurpreet.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pradeep.rathi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pradeep Rathi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pradeep.rathi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ajay.bezawada@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ajay VD Prasad Bezawada', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ajay.bezawada@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'niharika.arelly@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Niharika Arelly', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'niharika.arelly@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rajneesh.kaundal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rajneesh Kaundal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rajneesh.kaundal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'srinivas.somisetti@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Srinivas Somisetti', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'srinivas.somisetti@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'varun.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Varun Gupta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'varun.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jatinder.jain@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jatinder Jain', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jatinder.jain@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sujata.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sujata Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sujata.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ruchika.mehta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ruchika Rani Mehta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ruchika.mehta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nidhi.jassal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nidhi Jassal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nidhi.jassal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rahul.tiwari@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rahul Tiwari', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rahul.tiwari@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'baranwal.priyanka@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Priyanka Baranwal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'baranwal.priyanka@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shastrapani.himanshu@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shastrapani Himanshu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shastrapani.himanshu@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'simran.kaushal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Simran Kaushal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'simran.kaushal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'akanksha.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Akanksha Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'akanksha.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'satyanarayan.busireddy@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Busireddy Satyanarayan Reddy', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'satyanarayan.busireddy@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nishu.goyal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nishu Goyal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nishu.goyal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'prem.panjiyar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Prem Panjiyar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'prem.panjiyar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kartika.devi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kartika Devi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kartika.devi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sakshi.verma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sakshi Verma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sakshi.verma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'monika.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Monika Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'monika.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sanampreet.saggu@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sanampreet Saggu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sanampreet.saggu@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'iqbal.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Iqbal Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'iqbal.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rajat.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rajat Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rajat.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'varsha.jeetram@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Varsha Jeetram', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'varsha.jeetram@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'goldy.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Goldy Gupta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'goldy.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'urja.saxena@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Urja Saxena', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'urja.saxena@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vikas.chandel@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vikas Chandel', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vikas.chandel@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sahiba.rehncy@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sahiba Rehncy', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sahiba.rehncy@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'amar.jamadhiar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Amar Kumar Jamdhiar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'amar.jamadhiar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'viney.sidhu@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Viney Sidhu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'viney.sidhu@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'amit.saini@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Amit Kumar Saini', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'amit.saini@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vishaljeet.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vishaljeet Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vishaljeet.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vikas.gogna@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vikas Gogna', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vikas.gogna@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'hemant.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Hemant Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'hemant.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ram.parshad@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ram Parshad', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ram.parshad@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nitin.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nitin Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nitin.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'manish.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Manish Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manish.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'animesh.patel@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Animesh Singh Patel', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'animesh.patel@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aditya.kaistha@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aditya Kaistha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aditya.kaistha@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shekhar.panwar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shekhar Panwar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shekhar.panwar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kiran.yadav@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kiran Yadav', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kiran.yadav@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shikha.parmar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shikha Parmar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shikha.parmar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'singh.harpreet@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Harpreet Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'singh.harpreet@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'avninder.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Avninder Singh Bedi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'avninder.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'tanvi.uppal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Tanvi Uppal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'tanvi.uppal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mounika.patlolla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mounika Patlolla', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mounika.patlolla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'baljit.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Baljit Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'baljit.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shivam.khosla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shivam Khosla', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shivam.khosla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mehak.chawla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mehak Chawla', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mehak.chawla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sahil.thakur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sahil Thakur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sahil.thakur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vishnuvardhan.gunipati@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gunipati Vishnu Vardhan Reddy', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vishnuvardhan.gunipati@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ishita.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ishita Gupta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ishita.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'santosh.s@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Silari Satish Santosh Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'santosh.s@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'diksha.katoch@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Diksha Katoch', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'diksha.katoch@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kashish.vashistha@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kashish Vashistha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kashish.vashistha@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abhishek.negi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abhishek Negi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abhishek.negi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sarika@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sarika', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sarika@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'manas.biswas@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Manas Kumar Biswas', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manas.biswas@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abhinav.mishra@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abhinav Mishra', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abhinav.mishra@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'khwaish.batish@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Khwaish', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'khwaish.batish@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nikhil.jokta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nikhil Raj Jokta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nikhil.jokta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aarti.kanwar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aarti Kanwar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aarti.kanwar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'monika.thakur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Monika Thakur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'monika.thakur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nunakana.satish@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nunakana Satish Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nunakana.satish@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'megha.mittal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Megha Mittal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'megha.mittal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'babita.bharti@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Babita Bharti', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'babita.bharti@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sugandhna.arora@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sugandhna Arora', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sugandhna.arora@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'madhvi.chauhan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Madhvi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'madhvi.chauhan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abhishek.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abhishek Gupta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abhishek.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pooja.motagi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pooja S Motagi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pooja.motagi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ekta.kumari@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ekta Kumari', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ekta.kumari@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'akashdeep.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Akashdeep Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'akashdeep.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'prabhjot.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Prabhjot Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'prabhjot.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pankaj.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pankaj', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pankaj.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'manjar.alam@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'SK Manjar Alam', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manjar.alam@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bittu.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bittu Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bittu.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gaurav.bhanot@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gaurav Bhanot', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gaurav.bhanot@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'deepali.thakur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Deepali', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'deepali.thakur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jaspreet.cheema@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jaspreet Kaur Cheema', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jaspreet.cheema@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vikash.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vikash Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vikash.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'deepali.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Deepali', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'deepali.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'manisha.gusain@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Manisha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manisha.gusain@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aarzoo.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aarzoo', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aarzoo.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bharat.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bharat', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bharat.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shagun.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shagun Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shagun.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'harmeet.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Harmeet Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'harmeet.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anand.aggarwal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anand Parkash Aggarwal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anand.aggarwal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anmol.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anmol Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anmol.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'diksha.malhotra@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Diksha Malhotra', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'diksha.malhotra@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bharti.thakur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bharti', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bharti.thakur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'siddhant.khanna@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Siddhant Khanna', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'siddhant.khanna@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shaik.nadeem@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shaik Nadeem', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shaik.nadeem@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'amarpreet.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Amarpreet Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'amarpreet.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'atul.bakshi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Atul Bakshi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'atul.bakshi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mansi.soni@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mansi Soni', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mansi.soni@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ankit.mahajan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ankit Mahajan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ankit.mahajan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gargi.chandel@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gargi Chandel', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gargi.chandel@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'isha.kashyap@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Isha Kashyap', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'isha.kashyap@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'singh.sandeep@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sandeep Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'singh.sandeep@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'dhanya.varier@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Dhanya Bharathan Varier', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'dhanya.varier@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gurpreet.s@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gurpreet Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gurpreet.s@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'hitesh.bali@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Hitesh Bali', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'hitesh.bali@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kajal.k@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kajal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kajal.k@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kulwinder.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kulwinder Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kulwinder.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anand.choudhary@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anand Kumar Choudhary', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anand.choudhary@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ekta.talwar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ekta Talwar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ekta.talwar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'natasha.verma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Natasha Verma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'natasha.verma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vivek.punhani@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vivek Punhani', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vivek.punhani@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gurleen.sachdeva@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gurleen Sachdeva', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gurleen.sachdeva@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'tarun.bhatia@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Tarun Bhatia', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'tarun.bhatia@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kishore.pagadala@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pagadala Kishore Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kishore.pagadala@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'simran.kalyan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Simran', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'simran.kalyan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'richa.chawla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Richa Sharma Chawla', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'richa.chawla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'varinder.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Varinder Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'varinder.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ankit.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ankit Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ankit.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'simarpal.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Simarpal Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'simarpal.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rahul.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rahul Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rahul.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anupma.kumari@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anupma Kumari', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anupma.kumari@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ayush.ghosh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ayush Ghosh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ayush.ghosh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'naveen.rana@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Naveen Rana', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'naveen.rana@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nitu.yadav@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nitu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nitu.yadav@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rinky.maurya@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rinky Maurya', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rinky.maurya@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'thakur.priyanka@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Priyanka', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'thakur.priyanka@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gagan.gill@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gagan Gill', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gagan.gill@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pooja.rana@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pooja Rana', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pooja.rana@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shruti.tiwari@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shruti Tiwari', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shruti.tiwari@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'saurabh.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Saurabh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'saurabh.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'swati.pathania@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Swati Pathania', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'swati.pathania@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vaneet.watts@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vaneet Watts', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vaneet.watts@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nadia.jamal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nadia Jamal Rashidomer', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nadia.jamal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shriya.aggarwal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shriya Aggarwal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shriya.aggarwal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shiv.nandan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shiv Nandan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shiv.nandan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'puneet.bharwal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Puneet Bharwal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'puneet.bharwal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'asma.shaik@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shaik Asma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'asma.shaik@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nayan.mahajan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nayan Mahajan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nayan.mahajan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sukhminder.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sukhminder Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sukhminder.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rahul.bakshi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rahul Bakshi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rahul.bakshi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anjali.devi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anjali Devi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anjali.devi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pravalli.bavanam@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bavanam Lakshmi Pravalli', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pravalli.bavanam@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bhupender.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bhupender', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bhupender.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sandeep.patil@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sandeep Patil', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sandeep.patil@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'raminder.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Raminder Preet Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'raminder.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'tushar.dhiman@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Tushar Dhiman', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'tushar.dhiman@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'prasanth.yarramalli@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Yarramalli Prasanth', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'prasanth.yarramalli@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abhishek.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abhishek Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abhishek.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sushant.dhir@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sushant Dhir', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sushant.dhir@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'yuvraj.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Yuvraj Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'yuvraj.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shruthi.bn@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shruthi BN', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shruthi.bn@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'stephen.yendluri@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Yendluri Stephen Raj', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'stephen.yendluri@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ramandeep.sethi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ramandeep Singh Sethi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ramandeep.sethi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'himani.lakhanpal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Himani Lakhanpal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'himani.lakhanpal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'deepika.puri@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Deepika Puri Jagga', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'deepika.puri@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'astha.saini@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Astha Saini', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'astha.saini@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'venu.pasunooti@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pasunooti Venu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'venu.pasunooti@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bhuvan.thapar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bhuvan Thapar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bhuvan.thapar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shikha.s@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shikha Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shikha.s@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shreya.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shreya Gupta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shreya.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'simmy.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Simmy Kumari Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'simmy.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'tarun.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Tarun Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'tarun.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gurpal.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gurpal Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gurpal.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'megha.aggarwal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Megha Aggarwal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'megha.aggarwal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'prachi.khurana@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Prachi Khurana', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'prachi.khurana@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ranjan.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ranjan Kumar Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ranjan.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rohit.thakur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rohit Thakur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rohit.thakur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'varun.verma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Varun Verma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'varun.verma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'harpreet.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Harpreet Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'harpreet.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'riya.verma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Riya', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'riya.verma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jaspreet.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jaspreet Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jaspreet.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'neha.dadwal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Neha Dadwal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'neha.dadwal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rahul.chawla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rahul Chawla', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rahul.chawla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vinod.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vinod Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vinod.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'priya.kochhar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Priya Kochhar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'priya.kochhar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gouthami.palakurthi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Palakurthi Gouthami', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gouthami.palakurthi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rakesh.gandhi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rakesh Gandhi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rakesh.gandhi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'partap.s@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Partap Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'partap.s@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'arzoo.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Arzoo Gupta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'arzoo.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rohit.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rohit Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rohit.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'digvijay.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Digvijay Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'digvijay.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'manisha.rana@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Manisha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manisha.rana@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'atish.jain@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Atish Jain', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'atish.jain@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sanya.jain@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sanya Jain', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sanya.jain@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'subodh.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Subodh Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'subodh.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'naveen.thotakura@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Thotakura Venkata Ranga Naveen Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'naveen.thotakura@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ajit.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ajit Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ajit.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'purti.chopra@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Purti Chopra', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'purti.chopra@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'tinku.rajput@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Tinku Rajput', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'tinku.rajput@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sukun.manak@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sukun Manak', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sukun.manak@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vineet.kalia@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vineet Kalia', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vineet.kalia@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'divanshu.vashisht@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Divanshu Vashisht', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'divanshu.vashisht@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nitin.pandey@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nitin Shekhar Pandey', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nitin.pandey@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sahil.s@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sahil Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sahil.s@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'tanya.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Tanya', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'tanya.sharma@testingxperts.com');

-- PART B: Populate extra profile fields from CSV

UPDATE public.profiles SET
  full_name        = 'Manjeet Kumar',
  emp_code         = '2027',
  designation      = 'Vice President',
  level_id         = 'Level-9A',
  location         = 'Chandigarh',
  delivery_manager = 'Adeesh Jain',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'manjeet.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ashwani Narula',
  emp_code         = '2037',
  designation      = 'Associate Vice President',
  level_id         = 'Level-8B',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'FrankCrum-Payroll',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ashwani.narula@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rohit Kumar',
  emp_code         = '2071',
  designation      = 'Test Architect',
  level_id         = 'Level-5',
  location         = 'Chandigarh',
  delivery_manager = 'Rohit Kumar',
  project_name     = 'BeamSuntory',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rohit.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Manpreet Kaur Sandhu',
  emp_code         = '2158',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'T Bharath Babu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kaur.manpreet@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Hemant Kumar',
  emp_code         = '2163',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'hemant.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shanish Singh',
  emp_code         = '2170',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ManagedServices-2',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shanish.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gurpreet Singh',
  emp_code         = '2171',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gurpreet.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pradeep Rathi',
  emp_code         = '2193',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'UK',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'SRA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pradeep.rathi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ajay VD Prasad Bezawada',
  emp_code         = '2209',
  designation      = 'Associate Vice President',
  level_id         = 'Level-8B',
  location         = 'US',
  delivery_manager = 'George Michael Giacometti',
  project_name     = 'Bench',
  original_du      = 'INV',
  assigned_du      = 'INV',
  role             = 'delivery_manager'
WHERE email = 'ajay.bezawada@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Niharika Arelly',
  emp_code         = '2357',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Hyderabad',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'niharika.arelly@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rajneesh Kaundal',
  emp_code         = '2388',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'ConsumerReports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rajneesh.kaundal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Srinivas Somisetti',
  emp_code         = '2402',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Bangalore',
  delivery_manager = 'Neha Ummat',
  project_name     = 'AGIA-Affinity',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'srinivas.somisetti@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Varun Gupta',
  emp_code         = '2415',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'SRA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'varun.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jatinder Jain',
  emp_code         = '2422',
  designation      = 'Test Manager',
  level_id         = 'Level-5',
  location         = 'Chandigarh',
  delivery_manager = 'Jatinder Jain',
  project_name     = 'Tandem Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'jatinder.jain@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sujata Sharma',
  emp_code         = '2425',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'ACS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sujata.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ruchika Rani Mehta',
  emp_code         = '2452',
  designation      = 'Associate Test Architect',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Ruchika Rani Mehta',
  project_name     = 'PowerSchool-Accessibility Testing',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ruchika.mehta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nidhi Jassal',
  emp_code         = '2468',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'nidhi.jassal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rahul Tiwari',
  emp_code         = '2471',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rahul.tiwari@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Priyanka Baranwal',
  emp_code         = '2474',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Iqbal Singh',
  project_name     = 'Sagicor',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'baranwal.priyanka@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shastrapani Himanshu',
  emp_code         = '2513',
  designation      = 'Associate Director',
  level_id         = 'Level-7',
  location         = 'Hyderabad',
  delivery_manager = 'Manjeet Kumar',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shastrapani.himanshu@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Simran Kaushal',
  emp_code         = '2539',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'simran.kaushal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Akanksha Singh',
  emp_code         = '2573',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Noida',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'DataFlowGroup',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'akanksha.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Busireddy Satyanarayan Reddy',
  emp_code         = '2614',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'satyanarayan.busireddy@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nishu Goyal',
  emp_code         = '2617',
  designation      = 'Director',
  level_id         = 'Level-8A',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'DraftKings-Functional',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'nishu.goyal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Prem Panjiyar',
  emp_code         = '2645',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Intermax',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'prem.panjiyar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kartika Devi',
  emp_code         = '2646',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'PreferredMutual',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kartika.devi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sakshi Verma',
  emp_code         = '2683',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Noida',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'PreferredMutual',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sakshi.verma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Monika Sharma',
  emp_code         = '2688',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'Acadaca',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'monika.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sanampreet Saggu',
  emp_code         = '2695',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Dubai',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'SmartDubai',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sanampreet.saggu@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Iqbal Singh',
  emp_code         = '2706',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'ConsumerReports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'iqbal.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rajat Kumar',
  emp_code         = '2733',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Tarun Bhatia',
  project_name     = 'DeluxeCorporation-Data',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rajat.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Varsha Jeetram',
  emp_code         = '2734',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'varsha.jeetram@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Goldy Gupta',
  emp_code         = '2747',
  designation      = 'Test Manager',
  level_id         = 'Level-5',
  location         = 'Bangalore',
  delivery_manager = 'T Bharath Babu',
  project_name     = 'ZenithBank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'goldy.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Urja Saxena',
  emp_code         = '2750',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'PreferredMutual',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'urja.saxena@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vikas Chandel',
  emp_code         = '2791',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'Anewgo',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vikas.chandel@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sahiba Rehncy',
  emp_code         = '2824',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sahiba.rehncy@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Amar Kumar Jamdhiar',
  emp_code         = '2865',
  designation      = 'VP Delivery',
  level_id         = 'Level-9A',
  location         = 'US',
  delivery_manager = 'JOSEPH DONALD UNDERWOOD',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'amar.jamadhiar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Viney Sidhu',
  emp_code         = '2880',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Canada',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'Market Report & Third Party Data',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'viney.sidhu@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Amit Kumar Saini',
  emp_code         = '2888',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'US',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'ConsumerReports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'amit.saini@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vishaljeet Singh',
  emp_code         = '2904',
  designation      = 'Project Manager',
  level_id         = 'Level-5',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'Avercare',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'vishaljeet.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vikas Gogna',
  emp_code         = '2933',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Ruchika Rani Mehta',
  project_name     = 'Cyware-Accessibility',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vikas.gogna@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Hemant Sharma',
  emp_code         = '2936',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Subodh Kumar',
  project_name     = 'ChurchMutual',
  original_du      = 'QE',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'hemant.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ram Parshad',
  emp_code         = '2943',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'NeoGov-QA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ram.parshad@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nitin Sharma',
  emp_code         = '2965',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'Veracross',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'nitin.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Manish Kumar',
  emp_code         = '2969',
  designation      = 'Test Manager',
  level_id         = 'Level-5',
  location         = 'Noida',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'ACS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'manish.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Animesh Singh Patel',
  emp_code         = '2979',
  designation      = 'Test Manager',
  level_id         = 'Level-5',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'animesh.patel@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aditya Kaistha',
  emp_code         = '2983',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Noida',
  delivery_manager = 'Neha Ummat',
  project_name     = 'AIPSO',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'aditya.kaistha@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shekhar Panwar',
  emp_code         = '2992',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shekhar.panwar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kiran Yadav',
  emp_code         = '2999',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Noida',
  delivery_manager = 'Ruchika Rani Mehta',
  project_name     = 'Five9',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kiran.yadav@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shikha Parmar',
  emp_code         = '3004',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'ACS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shikha.parmar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Harpreet Singh',
  emp_code         = '3008',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Manpreet Kaur Sandhu',
  project_name     = 'BOSS 5.1',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'singh.harpreet@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Avninder Singh Bedi',
  emp_code         = '3019',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Neha Ummat',
  project_name     = 'AIPSO',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'avninder.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Tanvi Uppal',
  emp_code         = '3022',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'PreferredMutual',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'tanvi.uppal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mounika Patlolla',
  emp_code         = '3032',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'BoyleSports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'mounika.patlolla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Baljit Singh',
  emp_code         = '3034',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Tarun Bhatia',
  project_name     = 'DeluxeCorporation-Data',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'baljit.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shivam Khosla',
  emp_code         = '3035',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shivam.khosla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mehak Chawla',
  emp_code         = '3040',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Santosh Kumar Panchamram Yadav',
  project_name     = 'SmartKarma',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'mehak.chawla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sahil Thakur',
  emp_code         = '3043',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sahil.thakur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gunipati Vishnu Vardhan Reddy',
  emp_code         = '3046',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'Apex-SilverManagement',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vishnuvardhan.gunipati@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ishita Gupta',
  emp_code         = '3054',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'Apex-SilverManagement',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ishita.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Silari Satish Santosh Kumar',
  emp_code         = '3057',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Hyderabad',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'NeoGov-QA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'santosh.s@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Diksha Katoch',
  emp_code         = '3059',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'City & Guilds',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'diksha.katoch@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kashish Vashistha',
  emp_code         = '3069',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'Airtel Africa',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kashish.vashistha@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Abhishek Negi',
  emp_code         = '3070',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'DataFlowGroup',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'abhishek.negi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sarika',
  emp_code         = '3074',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Ruchika Rani Mehta',
  project_name     = 'Five9',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sarika@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Manas Kumar Biswas',
  emp_code         = '3082',
  designation      = 'Senior Technical Architect',
  level_id         = 'Level-6',
  location         = 'Chandigarh',
  delivery_manager = 'Rajul Goyal',
  project_name     = 'ASTM-Sharepoint',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'manas.biswas@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Abhinav Mishra',
  emp_code         = '3085',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'SRA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'abhinav.mishra@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Khwaish',
  emp_code         = '3088',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'Apex-SilverManagement',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'khwaish.batish@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nikhil Raj Jokta',
  emp_code         = '3089',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'M3Tech-Development',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'nikhil.jokta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aarti Kanwar',
  emp_code         = '3104',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Rajul Goyal',
  project_name     = 'Vaultex-Dev',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'aarti.kanwar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Monika Thakur',
  emp_code         = '3108',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Zaxby',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'monika.thakur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nunakana Satish Kumar',
  emp_code         = '3120',
  designation      = 'Associate Technical Architect',
  level_id         = 'Level-4',
  location         = 'Bangalore',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'nunakana.satish@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Megha Mittal',
  emp_code         = '3126',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Jatinder Jain',
  project_name     = 'Network18',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'megha.mittal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Babita Bharti',
  emp_code         = '3138',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'SRA-DevOps',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'babita.bharti@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sugandhna Arora',
  emp_code         = '3146',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'NeoGov-QA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sugandhna.arora@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Madhvi',
  emp_code         = '3150',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'SRA-DevOps',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'madhvi.chauhan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Abhishek Gupta',
  emp_code         = '3152',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'M3Tech-Development',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'abhishek.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pooja S Motagi',
  emp_code         = '3163',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pooja.motagi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ekta Kumari',
  emp_code         = '3171',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'BoyleSports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ekta.kumari@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Akashdeep Sharma',
  emp_code         = '3173',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Astha Saini',
  project_name     = 'Koozie',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'akashdeep.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Prabhjot Kaur',
  emp_code         = '3175',
  designation      = 'Technical Architect',
  level_id         = 'Level-5',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ManagedServices-1',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'prabhjot.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pankaj',
  emp_code         = '3182',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'ACS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pankaj.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'SK Manjar Alam',
  emp_code         = '3192',
  designation      = 'Director',
  level_id         = 'Level-8A',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'manjar.alam@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bittu Kumar',
  emp_code         = '3201',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Neha Ummat',
  project_name     = 'Bench',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'bittu.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gaurav Bhanot',
  emp_code         = '3202',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'VitaMojo',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gaurav.bhanot@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Deepali',
  emp_code         = '3219',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'deepali.thakur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jaspreet Kaur Cheema',
  emp_code         = '3225',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'MTFBiologics-Functional',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'jaspreet.cheema@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vikash Kumar',
  emp_code         = '3226',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Goldy Gupta',
  project_name     = 'Clinigen',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vikash.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Deepali',
  emp_code         = '3229',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'deepali.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Manisha',
  emp_code         = '3232',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Neha Ummat',
  project_name     = 'CM-Performance',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'manisha.gusain@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aarzoo',
  emp_code         = '3233',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'PreferredMutual',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'aarzoo.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bharat',
  emp_code         = '3235',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Neha Ummat',
  project_name     = 'AIPSO',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'bharat.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shagun Sharma',
  emp_code         = '3243',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Brightstar',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shagun.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Harmeet Singh',
  emp_code         = '3246',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'AMCS(UtilityCloud)',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'harmeet.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anand Parkash Aggarwal',
  emp_code         = '3247',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Canada',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'BTP Prod Support',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'anand.aggarwal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anmol Sharma',
  emp_code         = '3255',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Subhrajit Sahoo',
  project_name     = 'AmeriLife - Automation Testing Services',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'anmol.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Diksha Malhotra',
  emp_code         = '3256',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'PreferredMutual',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'diksha.malhotra@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bharti',
  emp_code         = '3260',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Manpreet Kaur Sandhu',
  project_name     = 'BOSS 5.1',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'bharti.thakur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Siddhant Khanna',
  emp_code         = '3261',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Neha Ummat',
  project_name     = 'Acko',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'siddhant.khanna@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shaik Nadeem',
  emp_code         = '3265',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'Apex-SilverManagement',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shaik.nadeem@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Amarpreet Singh',
  emp_code         = '3267',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'SRA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'amarpreet.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Atul Bakshi',
  emp_code         = '3268',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'atul.bakshi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mansi Soni',
  emp_code         = '3276',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Jatinder Jain',
  project_name     = 'Tandem Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'mansi.soni@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ankit Mahajan',
  emp_code         = '3279',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Zaxby',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ankit.mahajan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gargi Chandel',
  emp_code         = '3281',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ruchika Rani Mehta',
  project_name     = 'PowerSchool-Accessibility Testing',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gargi.chandel@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Isha Kashyap',
  emp_code         = '3283',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Micron UiPath Migration',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'isha.kashyap@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sandeep Singh',
  emp_code         = '3286',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'singh.sandeep@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Dhanya Bharathan Varier',
  emp_code         = '3292',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'dhanya.varier@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gurpreet Singh',
  emp_code         = '3296',
  designation      = 'Associate Test Architect',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gurpreet.s@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Hitesh Bali',
  emp_code         = '3302',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'hitesh.bali@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kajal',
  emp_code         = '3303',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kajal.k@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kulwinder Singh',
  emp_code         = '3304',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Astha Saini',
  project_name     = 'Alorica',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kulwinder.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anand Kumar Choudhary',
  emp_code         = '3316',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Subodh Kumar',
  project_name     = 'ChurchMutual',
  original_du      = 'QE',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'anand.choudhary@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ekta Talwar',
  emp_code         = '3317',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Jatinder Jain',
  project_name     = 'Network18',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ekta.talwar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Natasha Verma',
  emp_code         = '3320',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Dubai',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'SmartDubai',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'natasha.verma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vivek Punhani',
  emp_code         = '3321',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vivek.punhani@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gurleen Sachdeva',
  emp_code         = '3324',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'AMCS(UtilityCloud)',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gurleen.sachdeva@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Tarun Bhatia',
  emp_code         = '3327',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'Tx-DataPractice',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'tarun.bhatia@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pagadala Kishore Kumar',
  emp_code         = '3334',
  designation      = 'Lead',
  level_id         = 'Level-3',
  location         = 'Hyderabad',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kishore.pagadala@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Simran',
  emp_code         = '3335',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Revalize',
  original_du      = 'DES',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'simran.kalyan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Richa Sharma Chawla',
  emp_code         = '3342',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'SRA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'richa.chawla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Varinder Singh',
  emp_code         = '3352',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Neha Ummat',
  project_name     = 'AIPSO',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'varinder.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ankit Kumar',
  emp_code         = '3355',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ManagedServices-2',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'ankit.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Simarpal Singh',
  emp_code         = '3359',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'CoreTeam',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'simarpal.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rahul Sharma',
  emp_code         = '3361',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'City & Guilds',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rahul.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anupma Kumari',
  emp_code         = '3363',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'Group1001',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'anupma.kumari@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ayush Ghosh',
  emp_code         = '3364',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'CorpCU-UiPath',
  original_du      = 'DES',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ayush.ghosh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Naveen Rana',
  emp_code         = '3368',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Zaxby',
  original_du      = 'DES',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'naveen.rana@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nitu',
  emp_code         = '3370',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'nitu.yadav@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rinky Maurya',
  emp_code         = '3374',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rinky.maurya@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Priyanka',
  emp_code         = '3376',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'iliad Automation Testing',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'thakur.priyanka@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gagan Gill',
  emp_code         = '3382',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gagan.gill@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pooja Rana',
  emp_code         = '3383',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pooja.rana@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shruti Tiwari',
  emp_code         = '3384',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'Apex-SilverManagement',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shruti.tiwari@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Saurabh',
  emp_code         = '3392',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'saurabh.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Swati Pathania',
  emp_code         = '3395',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Jatinder Jain',
  project_name     = 'Network18',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'swati.pathania@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vaneet Watts',
  emp_code         = '3397',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vaneet.watts@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nadia Jamal Rashidomer',
  emp_code         = '3398',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'BoyleSports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'nadia.jamal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shriya Aggarwal',
  emp_code         = '3410',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Subhrajit Sahoo',
  project_name     = 'AmeriLife - Automation Testing Services',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'shriya.aggarwal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shiv Nandan',
  emp_code         = '3417',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'CommonwealthCharterAcademy-Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shiv.nandan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Puneet Bharwal',
  emp_code         = '3421',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Jatinder Jain',
  project_name     = 'Tandem Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'puneet.bharwal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shaik Asma',
  emp_code         = '3427',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'Hyde Housing Association',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'asma.shaik@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nayan Mahajan',
  emp_code         = '3432',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Goldy Gupta',
  project_name     = 'UrbanBuzz-Functional',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'nayan.mahajan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sukhminder Kaur',
  emp_code         = '3437',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'UK',
  delivery_manager = 'Rohit Kumar',
  project_name     = 'SWG',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sukhminder.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rahul Bakshi',
  emp_code         = '3438',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'SRA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rahul.bakshi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anjali Devi',
  emp_code         = '3444',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'anjali.devi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bavanam Lakshmi Pravalli',
  emp_code         = '3445',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'FrankCrum-Payroll',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pravalli.bavanam@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bhupender',
  emp_code         = '3450',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'bhupender.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sandeep Patil',
  emp_code         = '3454',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'MTFBiologics-Functional',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'sandeep.patil@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Raminder Preet Kaur',
  emp_code         = '3456',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Zaxby',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'raminder.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Tushar Dhiman',
  emp_code         = '3458',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Jatinder Jain',
  project_name     = 'Tandem Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'tushar.dhiman@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Yarramalli Prasanth',
  emp_code         = '3459',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Ramandeep Singh Bakshi',
  project_name     = 'Tx-PEARS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'prasanth.yarramalli@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Abhishek Singh',
  emp_code         = '3461',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'UK/EU',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'SRA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'abhishek.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sushant Dhir',
  emp_code         = '3468',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Zaxby',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sushant.dhir@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Yuvraj Singh',
  emp_code         = '3469',
  designation      = 'Director',
  level_id         = 'Level-8A',
  location         = 'Chandigarh',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'yuvraj.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shruthi BN',
  emp_code         = '3472',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'Avercare',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shruthi.bn@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Yendluri Stephen Raj',
  emp_code         = '3474',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'stephen.yendluri@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ramandeep Singh Sethi',
  emp_code         = '3475',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'Scholarship America',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ramandeep.sethi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Himani Lakhanpal',
  emp_code         = '3476',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Freemans Grattan Holdings',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'himani.lakhanpal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Deepika Puri Jagga',
  emp_code         = '3493',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'deepika.puri@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Astha Saini',
  emp_code         = '3495',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'FrankCrum-Payroll',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'astha.saini@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pasunooti Venu',
  emp_code         = '3500',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Navitus',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'venu.pasunooti@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bhuvan Thapar',
  emp_code         = '3501',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'CommonwealthCharterAcademy-Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'bhuvan.thapar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shikha Sharma',
  emp_code         = '3503',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'ACS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shikha.s@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shreya Gupta',
  emp_code         = '3504',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'MTFBiologics-Functional',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shreya.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Simmy Kumari Singh',
  emp_code         = '3505',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ManagedServices-2',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'simmy.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Tarun Kumar',
  emp_code         = '3507',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'iliad Automation Testing',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'tarun.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gurpal Kaur',
  emp_code         = '3526',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gurpal.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Megha Aggarwal',
  emp_code         = '3527',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'PreferredMutual',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'megha.aggarwal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Prachi Khurana',
  emp_code         = '3528',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'Hazeltree',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'prachi.khurana@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ranjan Kumar Singh',
  emp_code         = '3529',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ranjan.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rohit Thakur',
  emp_code         = '3530',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Jatinder Jain',
  project_name     = 'Tandem Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rohit.thakur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Varun Verma',
  emp_code         = '3533',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'BoyleSports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'varun.verma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Harpreet Kaur',
  emp_code         = '3536',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'harpreet.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Riya',
  emp_code         = '3540',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'ACS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'riya.verma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jaspreet Kaur',
  emp_code         = '3544',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'BoyleSports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'jaspreet.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Neha Dadwal',
  emp_code         = '3548',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'neha.dadwal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rahul Chawla',
  emp_code         = '3550',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rahul.chawla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vinod Kumar',
  emp_code         = '3551',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vinod.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Priya Kochhar',
  emp_code         = '3553',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'MTFBiologics-Functional',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'priya.kochhar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Palakurthi Gouthami',
  emp_code         = '3554',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Subhrajit Sahoo',
  project_name     = 'AmeriLife - Automation Testing Services',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'gouthami.palakurthi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rakesh Gandhi',
  emp_code         = '3559',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Neha Ummat',
  project_name     = 'CM-Performance',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'rakesh.gandhi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Partap Singh',
  emp_code         = '3562',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'USA',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'partap.s@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Arzoo Gupta',
  emp_code         = '3566',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'BoyleSports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'arzoo.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rohit Sharma',
  emp_code         = '3568',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'PreferredMutual',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rohit.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Digvijay Sharma',
  emp_code         = '3573',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rohit Kumar',
  project_name     = 'SWG',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'digvijay.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Manisha',
  emp_code         = '3574',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Jatinder Jain',
  project_name     = 'Tandem Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'manisha.rana@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Atish Jain',
  emp_code         = '3576',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'WaspBarcodeTechnologies',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'atish.jain@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sanya Jain',
  emp_code         = '3577',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'CorporateOneFederalCreditUnion',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sanya.jain@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Subodh Kumar',
  emp_code         = '3578',
  designation      = 'Senior Delivery Manager',
  level_id         = 'Level-6',
  location         = 'Noida',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ManagedServices-2',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'subodh.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Thotakura Venkata Ranga Naveen Kumar',
  emp_code         = '3579',
  designation      = 'Associate Director',
  level_id         = 'Level-7',
  location         = 'Hyderabad',
  delivery_manager = 'Manjeet Kumar',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'naveen.thotakura@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ajit Singh',
  emp_code         = '3583',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'CorporateOneFederalCreditUnion',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ajit.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Purti Chopra',
  emp_code         = '3586',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'CorporateOneFederalCreditUnion',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'purti.chopra@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Tinku Rajput',
  emp_code         = '3587',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'BoyleSports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'tinku.rajput@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sukun Manak',
  emp_code         = '3598',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Subhrajit Sahoo',
  project_name     = 'AmeriLife - Automation Testing Services',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sukun.manak@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vineet Kalia',
  emp_code         = '3601',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Jatinder Jain',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vineet.kalia@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Divanshu Vashisht',
  emp_code         = '3603',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'M3Tech-Development',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'divanshu.vashisht@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nitin Shekhar Pandey',
  emp_code         = '3609',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ManagedServices-2',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'nitin.pandey@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sahil Sharma',
  emp_code         = '3610',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ManagedServices-1',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'sahil.s@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Tanya',
  emp_code         = '3611',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ManagedServices-2',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'tanya.sharma@testingxperts.com';

