-- ============================================================
-- Batch 3/5 (200 employees)
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
  'anuj.k@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anuj Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anuj.k@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vaideeswari.yuvaraj@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vaideeswari Yuvaraj', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vaideeswari.yuvaraj@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'saikrishna.busi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Saikrishna Busi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'saikrishna.busi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sanjay.das@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sanjay Kumar Das', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sanjay.das@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vandana.raheja@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vandana', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vandana.raheja@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gayathri.rathinasamy@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gayathri', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gayathri.rathinasamy@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'karan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Karan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'karan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'priyanka.kumari@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Priyanka Kumari', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'priyanka.kumari@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'uday.aravapalli@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aravapalli Uday Sankar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'uday.aravapalli@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'malkiat.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Malkiat Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'malkiat.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rishu.srivastav@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rishu Srivastav', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rishu.srivastav@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'prankur.goyal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Prankur Goyal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'prankur.goyal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mayank.srivastava@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mayank Srivastava', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mayank.srivastava@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sharikh.nayab@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sharikh Kazam Nayab', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sharikh.nayab@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'chandrakesh.vishwakarma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Chandrakesh Vishwakarma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'chandrakesh.vishwakarma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'chander.shekhar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Chander Shekhar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'chander.shekhar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pankaj.menaria@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pankaj Menaria', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pankaj.menaria@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'subham.priyadarshi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Subham Priyadarshi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'subham.priyadarshi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aman.verma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aman Verma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aman.verma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ravi.pandey@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ravi Shankar Pandey', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ravi.pandey@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'diksha.thakur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Diksha Thakur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'diksha.thakur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'diya.s@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Diya Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'diya.s@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'saurabh.patnaik@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Patnaik Saurabh Tirupati', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'saurabh.patnaik@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'subash.gurusamy@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Subash Gurusamy', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'subash.gurusamy@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'raghav.a@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Raghav Aggarwal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'raghav.a@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jashanjit.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jashanjit Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jashanjit.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kumar.anuj@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anuj Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kumar.anuj@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anisha.singla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anisha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anisha.singla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'roop.kota@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Roop Kumar Kota', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'roop.kota@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vasu.mittal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vasu Mittal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vasu.mittal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'lalit.gaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Lalit Kumar Gaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'lalit.gaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vasavi.namlamet@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Namlamet Vasavi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vasavi.namlamet@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shahraj.shaik@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shaik Shahraj Bee', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shahraj.shaik@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'charan.balagouni@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Balagouni Charan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'charan.balagouni@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'priyanka.yerramsetti@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Yerramsetti Devi Priyanka', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'priyanka.yerramsetti@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'chandana.siri@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Siri Chandana', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'chandana.siri@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'akansha.garg@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Akansha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'akansha.garg@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anupam.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anupam', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anupam.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anushka.malhotra@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anushka Malhotra', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anushka.malhotra@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'arin.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Arin Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'arin.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ayush.kohli@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ayush Kohli', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ayush.kohli@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'divansh.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Divansh Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'divansh.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gautam.goel@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gautam Goel', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gautam.goel@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'harsh.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Harsh Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'harsh.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'hemant.wadhwa@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Hemant', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'hemant.wadhwa@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jatin.kurup@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jatin Kurup', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jatin.kurup@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kartik.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kartik Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kartik.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'khyati.singla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Khyati', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'khyati.singla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'manish.shah@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Manish', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manish.shah@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nishant.thakur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nishant Thakur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nishant.thakur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rishab.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rishab Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rishab.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sanvy.verma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sanvy Verma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sanvy.verma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'satyam.shukla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Satyam Shukla', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'satyam.shukla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sunaina.chauhan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sunaina', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sunaina.chauhan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vidit.garg@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vidit Garg', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vidit.garg@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'samridhi.jindal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Samridhi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'samridhi.jindal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aman.budhraja@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aman Budhraja', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aman.budhraja@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'navneet.virdi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Navneet Kaur Virdi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'navneet.virdi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'goutam.goyal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Goutam Goyal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'goutam.goyal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ayush.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ayush Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ayush.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'navyush.rana@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Navyush Rana', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'navyush.rana@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vinay.kannam@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kannam Vinay Siddhartha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vinay.kannam@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vikas.verma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vikas Verma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vikas.verma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ankeet.cheema@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ankeet Singh Cheema', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ankeet.cheema@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'lalit.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Lalit Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'lalit.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'k.pankaj@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pankaj Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'k.pankaj@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shivam.s@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shivam Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shivam.s@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shubham.mittal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shubham Mittal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shubham.mittal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'srujan.vangaru@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vangaru Srujan Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'srujan.vangaru@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'parneet.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Parneet Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'parneet.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vikas.thakur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vikas Thakur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vikas.thakur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rakesh.sr@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rakesh SR', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rakesh.sr@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mayur.pore@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mayur Mahadev Pore', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mayur.pore@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kumar.rahul@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rahul Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kumar.rahul@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sharma.aditya@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aditya Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sharma.aditya@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shubham.sangwan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shubham Sangwan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shubham.sangwan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'subhrajit.sahoo@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Subhrajit Sahoo', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'subhrajit.sahoo@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abhishek.s@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abhishek Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abhishek.s@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mahima.jaiswal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mahima Jaiswal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mahima.jaiswal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mohit.c@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mohit Choudhary', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mohit.c@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nidhi.chauhan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nidhi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nidhi.chauhan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shrey.garg@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shrey Garg', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shrey.garg@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pavan.gondela@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gondela Pavan Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pavan.gondela@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'lovely.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Lovely', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'lovely.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nidhi.garg@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nidhi Garg', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nidhi.garg@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sahil.jasrotia@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sahil Jasrotia', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sahil.jasrotia@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ekta.kaushish@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ekta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ekta.kaushish@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'arun.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Arun Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'arun.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kashish.sharda@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kashish Sharda', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kashish.sharda@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shrikanth.singam@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shrikanth Singam', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shrikanth.singam@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aastha.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aastha Gupta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aastha.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'harleen.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Harleen Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'harleen.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'venkata.raparla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Raparla Venkata Balasubramanyam', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'venkata.raparla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gayathri.malladi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Malladi Gayathri', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gayathri.malladi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shiv.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shiv Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shiv.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ajay.sodhi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ajay Sodhi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ajay.sodhi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'amar.pandey@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Amar Nath Pandey', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'amar.pandey@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'chanchal.warde@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Chanchal Warde', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'chanchal.warde@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bharath.t@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'T Bharath Babu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bharath.t@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  's.shikha@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shikha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 's.shikha@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'arshpreet.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Arshpreet Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'arshpreet.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vikrant.mahajan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vikrant Mahajan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vikrant.mahajan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mohit.dhiman@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mohit Dhiman', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mohit.dhiman@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kartika.vij@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kartika Vij', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kartika.vij@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'dilip.thete@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Dilip Parbhat Thete', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'dilip.thete@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'manoj.padala@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Manoj Anjaneya Prasad Padala', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manoj.padala@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'suma.b@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'B Suma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'suma.b@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sushma.n@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sushma N', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sushma.n@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shivam.verma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shivam Verma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shivam.verma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pavani.sankavarapu@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sankavarapu Pavani', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pavani.sankavarapu@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gourav.sardana@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gourav Sardana', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gourav.sardana@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aakriti.mittal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aakriti Mittal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aakriti.mittal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'birkaran.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Birkaran Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'birkaran.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anand.kishore@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anand Kishore', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anand.kishore@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kumari.pramila@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kumari Pramila', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kumari.pramila@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anindita.das@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anindita Das', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anindita.das@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'raghava.gujjala@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Raghava Gujjala', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'raghava.gujjala@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'dhammapal.dhutraj@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Dhammapal Bhimrao Dhutraj', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'dhammapal.dhutraj@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'apoorv.mittal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Apoorv Mittal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'apoorv.mittal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'janak.raj@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Janak Raj', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'janak.raj@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ravi.haridevara@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Haridevara Ravi Krishna', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ravi.haridevara@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'alka.rauthan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Alka Rauthan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'alka.rauthan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'devi.tamara@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Devi Tamara', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'devi.tamara@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'padmalatha.lakkireddy@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Padmalatha Lakkireddy', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'padmalatha.lakkireddy@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'amruta.magar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Amruta Magar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'amruta.magar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sumit.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sumit Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sumit.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'dinesh.s@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Dinesh S', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'dinesh.s@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'srikanth.deekshitula@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bhima Sai Srikanth Deekshitula', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'srikanth.deekshitula@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kaur.navneet@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Navneet Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kaur.navneet@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'keshav.bhardwaj@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Keshav Bhardwaj', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'keshav.bhardwaj@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'harshini.matlapudi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Matlapudi Harshini SrisushmaSai', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'harshini.matlapudi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nayana.n@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nayana N', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nayana.n@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'deepthi.ks@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'K S Deepthi Narayan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'deepthi.ks@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sureshkrishna.s@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'S Sureshkrishna', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sureshkrishna.s@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'karthickarul.kuppusamy@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Karthickarul Kuppusamy', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'karthickarul.kuppusamy@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gurtej.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gurtej Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gurtej.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bhavya.challagundla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Challagundla Bhavya', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bhavya.challagundla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pavithra.gangireddygari@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gangireddygari Guru Pavithra', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pavithra.gangireddygari@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sreeramulu.ramavath@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ramavath Sreeramulu Naik', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sreeramulu.ramavath@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rabiya.khathoon@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rabiya Khathoon', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rabiya.khathoon@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shubham.shelke@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shubham Shekhar Shelke', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shubham.shelke@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rithik.zogta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rithik Zogta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rithik.zogta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'priyanka.t@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Priyanka Thakur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'priyanka.t@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'neha.r@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Neha Rai', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'neha.r@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rajiv.diwan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rajiv Diwan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rajiv.diwan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'neha.puri@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Neha Puri', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'neha.puri@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'santosh.yadav@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Santosh Kumar Panchamram Yadav', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'santosh.yadav@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gaurang.khanna@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gaurang Khanna', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gaurang.khanna@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'dharm.pratap@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Dharm Pratap', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'dharm.pratap@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'neeraj.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Neeraj Ramesh Gupta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'neeraj.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sayali.joshi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sayali Sanjay Joshi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sayali.joshi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abhinay.nalla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nalla Abhinay Reddy', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abhinay.nalla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'niraj.birje@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Niraj Birje', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'niraj.birje@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'verma.shivani@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shivani Verma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'verma.shivani@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'durga.cherukuri@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Cherukuri Durga Bhavani', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'durga.cherukuri@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'arun.meenathethil@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Arun Bharath Meenathethil', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'arun.meenathethil@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rashmi.m@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rashmi Mahajan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rashmi.m@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anurag.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anurag Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anurag.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'suchithra.ks@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Suchithra K S', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'suchithra.ks@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gayathri.prashanth@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'GAYATHRI', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gayathri.prashanth@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aayush.mishra@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aayush Mishra', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aayush.mishra@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shwetha.voora@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Voora Shwetha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shwetha.voora@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vishal.prabhakar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vishal Prabhakar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vishal.prabhakar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'upendra.chaube@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Upendra Kumar Chaube', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'upendra.chaube@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mrinal.verma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mrinal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mrinal.verma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sai.sharan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'H Sai Sharan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sai.sharan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bhargavi.yadati@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bhargavi Yadati', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bhargavi.yadati@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'radhika.vohra@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Radhika Vohra', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'radhika.vohra@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'varaprasad.dangeti@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Dangeti Lakshmi Manikanta Vara Prasad', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'varaprasad.dangeti@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jagadeesh.tatikondala@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Tatikondala Jagadeesh Babu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jagadeesh.tatikondala@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mahesh.shinde@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mahesh Shinde', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mahesh.shinde@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'archana.kalkaprasad@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Archana Kalkaprasad Sahu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'archana.kalkaprasad@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'lindon.martin@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'S Lindon Philip Martin', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'lindon.martin@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'srija.chelika@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Chelika Srija', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'srija.chelika@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sneha.bhave@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sneha Aniket Bhave', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sneha.bhave@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'siddanth.c@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Chilla Siddanth', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'siddanth.c@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'neeraj.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Neeraj Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'neeraj.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vidya.pakyala@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pakyala Vidya', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vidya.pakyala@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'monika.thapar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Monika Thapar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'monika.thapar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vamsi.challa@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Challa Vamsi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vamsi.challa@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sreejith.kk@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sreejith K K', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sreejith.kk@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jeevadharani.h@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'JEEVADHARANI', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jeevadharani.h@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'yasasvi.maheswaram@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Maheswaram Yasasvi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'yasasvi.maheswaram@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'maheboob.tamboli@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Tamboli Maheboob Nabi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'maheboob.tamboli@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shriraj.potdar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shriraj Vyankatrao Potdar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shriraj.potdar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'chirag.kataria@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Chirag Amar Kataria', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'chirag.kataria@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pradhumn.mali@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pradhumn Mali', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pradhumn.mali@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pashyanthi.vedula@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vedula Balatripura Pashyanthi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pashyanthi.vedula@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'khushaboo.pandey@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Khushaboo Pandey', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'khushaboo.pandey@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ojaswi.malik@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ojaswi Malik', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ojaswi.malik@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'neha.turke@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Neha Yogirajendra Turke', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'neha.turke@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'santosh.ubhale@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Santosh Ubhale', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'santosh.ubhale@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vishal.dhillon@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vishal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vishal.dhillon@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jageshwar.gope@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jageshwar Gope', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jageshwar.gope@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'prasad.kodukulla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'V N K K Prasad Kodukulla', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'prasad.kodukulla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'manikumar.paruchuri@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Paruchuri Manikumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manikumar.paruchuri@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'manohar.malasani@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Malasani Manohar Babu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manohar.malasani@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sampath.borra@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Borra Shanmukha Sampath', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sampath.borra@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'adarsh.yadav@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Adarsh Kumar Yadav', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'adarsh.yadav@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mounika.girineni@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Girineni Mounika', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mounika.girineni@testingxperts.com');

-- PART B: Populate extra profile fields from CSV

UPDATE public.profiles SET
  full_name        = 'Anuj Kumar',
  emp_code         = '4298',
  designation      = 'Senior Test Manager',
  level_id         = 'Level-6',
  location         = 'Chandigarh',
  delivery_manager = 'Manjeet Kumar',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'anuj.k@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vaideeswari Yuvaraj',
  emp_code         = '4299',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Bangalore',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Radix IoT',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vaideeswari.yuvaraj@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Saikrishna Busi',
  emp_code         = '4303',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Venugopal Bandaru',
  project_name     = 'Cogitate-Insurance',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'saikrishna.busi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sanjay Kumar Das',
  emp_code         = '4304',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Anand Kishore',
  project_name     = 'VistaXM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sanjay.das@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vandana',
  emp_code         = '4307',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Jatinder Jain',
  project_name     = 'Network18',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vandana.raheja@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gayathri',
  emp_code         = '4308',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Neha Ummat',
  project_name     = 'AIPSO',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'gayathri.rathinasamy@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Karan',
  emp_code         = '4314',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ManagedServices-1',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'karan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Priyanka Kumari',
  emp_code         = '4329',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Brightstar',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'priyanka.kumari@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aravapalli Uday Sankar',
  emp_code         = '4330',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'IFD-Dev',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'uday.aravapalli@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Malkiat Singh',
  emp_code         = '4331',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Fulton County',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'malkiat.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rishu Srivastav',
  emp_code         = '4335',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Noida',
  delivery_manager = 'Pankaj Menaria',
  project_name     = 'Tx-DataPractice',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rishu.srivastav@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Prankur Goyal',
  emp_code         = '4337',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'prankur.goyal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mayank Srivastava',
  emp_code         = '4338',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Pankaj Menaria',
  project_name     = 'Tx-DataPractice',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'mayank.srivastava@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sharikh Kazam Nayab',
  emp_code         = '4339',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'sharikh.nayab@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Chandrakesh Vishwakarma',
  emp_code         = '4341',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Iqbal Singh',
  project_name     = 'Safexpress',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'chandrakesh.vishwakarma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Chander Shekhar',
  emp_code         = '4343',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'Airtel Africa',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'chander.shekhar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pankaj Menaria',
  emp_code         = '4346',
  designation      = 'Test Architect',
  level_id         = 'Level-5',
  location         = 'Noida',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'Tx-DataPractice',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pankaj.menaria@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Subham Priyadarshi',
  emp_code         = '4348',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'OfficerTrak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'subham.priyadarshi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aman Verma',
  emp_code         = '4350',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Iqbal Singh',
  project_name     = 'Safexpress',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'aman.verma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ravi Shankar Pandey',
  emp_code         = '4351',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Iqbal Singh',
  project_name     = 'Safexpress',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ravi.pandey@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Diksha Thakur',
  emp_code         = '4354',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'Hyde Housing Association',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'diksha.thakur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Diya Sharma',
  emp_code         = '4355',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Akansha Shah',
  project_name     = 'POC-DEV',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'diya.s@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Patnaik Saurabh Tirupati',
  emp_code         = '4360',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Hyderabad',
  delivery_manager = 'Santosh Kumar Panchamram Yadav',
  project_name     = 'Axis Securities',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'saurabh.patnaik@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Subash Gurusamy',
  emp_code         = '4361',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'subash.gurusamy@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Raghav Aggarwal',
  emp_code         = '4365',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'EverPaw',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'raghav.a@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jashanjit Singh',
  emp_code         = '4366',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Ajay VD Prasad Bezawada',
  project_name     = 'DES-AI',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'jashanjit.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anuj Kumar',
  emp_code         = '4367',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Iqbal Singh',
  project_name     = 'Safexpress',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kumar.anuj@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anisha',
  emp_code         = '4368',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'Airtel Africa',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'anisha.singla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Roop Kumar Kota',
  emp_code         = '4373',
  designation      = 'Test Manager',
  level_id         = 'Level-5',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Fulton County',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'roop.kota@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vasu Mittal',
  emp_code         = '4374',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Ramandeep Singh Bakshi',
  project_name     = 'VeraCode',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vasu.mittal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Lalit Kumar Gaur',
  emp_code         = '4375',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Noida',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'lalit.gaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Namlamet Vasavi',
  emp_code         = '4376',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Hyderabad',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'vasavi.namlamet@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shaik Shahraj Bee',
  emp_code         = '4377',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shahraj.shaik@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Balagouni Charan',
  emp_code         = '4378',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'TurboHire',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'charan.balagouni@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Yerramsetti Devi Priyanka',
  emp_code         = '4379',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Hyderabad',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'priyanka.yerramsetti@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Siri Chandana',
  emp_code         = '4380',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'chandana.siri@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Akansha',
  emp_code         = '4382',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'akansha.garg@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anupam',
  emp_code         = '4383',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Tarun Bhatia',
  project_name     = 'Tx-DataPractice',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'anupam.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anushka Malhotra',
  emp_code         = '4384',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'anushka.malhotra@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Arin Sharma',
  emp_code         = '4385',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Gleesha Agarwal',
  project_name     = 'TruBridge',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'arin.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ayush Kohli',
  emp_code         = '4386',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Ramandeep Singh Bakshi',
  project_name     = 'Tx-PEARS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ayush.kohli@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Divansh Singh',
  emp_code         = '4387',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'divansh.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gautam Goel',
  emp_code         = '4388',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Nunakana Satish Kumar',
  project_name     = 'DES-AI',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'gautam.goel@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Harsh Kumar',
  emp_code         = '4389',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Gleesha Agarwal',
  project_name     = 'Tx-PEARS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'harsh.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Hemant',
  emp_code         = '4390',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'CommonwealthCharterAcademy-Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'hemant.wadhwa@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jatin Kurup',
  emp_code         = '4391',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Ruchika Rani Mehta',
  project_name     = 'Five9',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'jatin.kurup@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kartik Sharma',
  emp_code         = '4392',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Astha Saini',
  project_name     = 'Apex-Margin&Risk',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kartik.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Khyati',
  emp_code         = '4393',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'Hyde Housing Association',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'khyati.singla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Manish',
  emp_code         = '4394',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'manish.shah@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nishant Thakur',
  emp_code         = '4395',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ManagedServices-2',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'nishant.thakur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rishab Sharma',
  emp_code         = '4396',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Subodh Kumar',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'rishab.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sanvy Verma',
  emp_code         = '4397',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Payal Sharma',
  project_name     = 'Tx-DataPractice',
  original_du      = 'DES',
  assigned_du      = 'INV',
  role             = 'delivery_manager'
WHERE email = 'sanvy.verma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Satyam Shukla',
  emp_code         = '4398',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'satyam.shukla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sunaina',
  emp_code         = '4399',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'Hazeltree',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sunaina.chauhan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vidit Garg',
  emp_code         = '4400',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'vidit.garg@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Samridhi',
  emp_code         = '4401',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Brightstar',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'samridhi.jindal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aman Budhraja',
  emp_code         = '4402',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'aman.budhraja@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Navneet Kaur Virdi',
  emp_code         = '4403',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Payal Sharma',
  project_name     = 'Tx-DataPractice',
  original_du      = 'DES',
  assigned_du      = 'INV',
  role             = 'delivery_manager'
WHERE email = 'navneet.virdi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Goutam Goyal',
  emp_code         = '4405',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Diljeet Singh Bhalla',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'goutam.goyal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ayush Kumar',
  emp_code         = '4406',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'SRA-DevOps',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'ayush.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Navyush Rana',
  emp_code         = '4407',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Subodh Kumar',
  project_name     = 'Alorica-CMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'navyush.rana@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kannam Vinay Siddhartha',
  emp_code         = '4408',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'BoyleSports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vinay.kannam@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vikas Verma',
  emp_code         = '4409',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'ACS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vikas.verma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ankeet Singh Cheema',
  emp_code         = '4412',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rajul Goyal',
  project_name     = 'DairyTech',
  original_du      = 'QE',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'ankeet.cheema@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Lalit Singh',
  emp_code         = '4413',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Astha Saini',
  project_name     = 'Apex-Margin&Risk',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'lalit.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pankaj Kumar',
  emp_code         = '4414',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Neha Ummat',
  project_name     = 'CM-Performance',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'k.pankaj@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shivam Sharma',
  emp_code         = '4416',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shivam.s@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shubham Mittal',
  emp_code         = '4417',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Fulton County',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shubham.mittal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vangaru Srujan Kumar',
  emp_code         = '4418',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Fulton County',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'srujan.vangaru@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Parneet Kaur',
  emp_code         = '4419',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Santosh Kumar Panchamram Yadav',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'parneet.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vikas Thakur',
  emp_code         = '4420',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'iliad Automation Testing',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vikas.thakur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rakesh SR',
  emp_code         = '4421',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Navitus',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rakesh.sr@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mayur Mahadev Pore',
  emp_code         = '4423',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'mayur.pore@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rahul Kumar',
  emp_code         = '4425',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'City & Guilds',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kumar.rahul@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aditya Sharma',
  emp_code         = '4426',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sharma.aditya@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shubham Sangwan',
  emp_code         = '4427',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Noida',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'OLX',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shubham.sangwan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Subhrajit Sahoo',
  emp_code         = '4431',
  designation      = 'Project Manager',
  level_id         = 'Level-5',
  location         = 'Noida',
  delivery_manager = 'Subhrajit Sahoo',
  project_name     = 'AmeriLife - Automation Testing Services',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'subhrajit.sahoo@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Abhishek Singh',
  emp_code         = '4432',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'abhishek.s@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mahima Jaiswal',
  emp_code         = '4433',
  designation      = 'Business Analyst',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'Avercare',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'mahima.jaiswal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mohit Choudhary',
  emp_code         = '4434',
  designation      = 'Software Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Ajay VD Prasad Bezawada',
  project_name     = 'DES-AI',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'mohit.c@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nidhi',
  emp_code         = '4435',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anand Kishore',
  project_name     = 'AHEAD - Lumicera',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'nidhi.chauhan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shrey Garg',
  emp_code         = '4437',
  designation      = 'Associate Test Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Ramandeep Singh Bakshi',
  project_name     = 'Tx-PEARS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shrey.garg@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gondela Pavan Kumar',
  emp_code         = '4438',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Astha Saini',
  project_name     = 'ZetaTech',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pavan.gondela@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Lovely',
  emp_code         = '4439',
  designation      = 'Software Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'Avercare',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'lovely.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nidhi Garg',
  emp_code         = '4440',
  designation      = 'Software Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'Avercare',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'nidhi.garg@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sahil Jasrotia',
  emp_code         = '4441',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'Avercare',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'sahil.jasrotia@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ekta',
  emp_code         = '4442',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'Avercare',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'ekta.kaushish@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Arun Kumar',
  emp_code         = '4444',
  designation      = 'Software Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Anand Kishore',
  project_name     = 'VistaXM',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'arun.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kashish Sharda',
  emp_code         = '4445',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Subodh Kumar',
  project_name     = 'IFD-Dev',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'kashish.sharda@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shrikanth Singam',
  emp_code         = '4446',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'iliad Automation Testing',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shrikanth.singam@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aastha Gupta',
  emp_code         = '4447',
  designation      = 'Senior Business Analyst',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Venugopal Bandaru',
  project_name     = 'Cogitate-Insurance',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'aastha.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Harleen Kaur',
  emp_code         = '4448',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anand Kishore',
  project_name     = 'VistaXM',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'harleen.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Raparla Venkata Balasubramanyam',
  emp_code         = '4449',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'venkata.raparla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Malladi Gayathri',
  emp_code         = '4450',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Hyderabad',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'gayathri.malladi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shiv Kumar',
  emp_code         = '4452',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Subodh Kumar',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'shiv.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ajay Sodhi',
  emp_code         = '4454',
  designation      = 'Senior Technical Architect',
  level_id         = 'Level-6',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'CoreTeam',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'ajay.sodhi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Amar Nath Pandey',
  emp_code         = '4456',
  designation      = 'Manager',
  level_id         = 'Level-5',
  location         = 'Hyderabad',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'amar.pandey@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Chanchal Warde',
  emp_code         = '4458',
  designation      = 'Project Manager',
  level_id         = 'Level-5',
  location         = 'Chandigarh',
  delivery_manager = 'Ajay VD Prasad Bezawada',
  project_name     = 'DES-AI',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'chanchal.warde@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'T Bharath Babu',
  emp_code         = '4462',
  designation      = 'Associate Director',
  level_id         = 'Level-7',
  location         = 'Hyderabad',
  delivery_manager = 'T Bharath Babu',
  project_name     = 'ZenithBank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'bharath.t@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shikha',
  emp_code         = '4464',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 's.shikha@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Arshpreet Singh',
  emp_code         = '4466',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anand Kishore',
  project_name     = 'VistaXM',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'arshpreet.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vikrant Mahajan',
  emp_code         = '4467',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'EverPaw',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'vikrant.mahajan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mohit Dhiman',
  emp_code         = '4468',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'Avercare',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'mohit.dhiman@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kartika Vij',
  emp_code         = '4470',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'EverPaw',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'kartika.vij@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Dilip Parbhat Thete',
  emp_code         = '4471',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'T Bharath Babu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'dilip.thete@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Manoj Anjaneya Prasad Padala',
  emp_code         = '4472',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Qvantel',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'manoj.padala@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'B Suma',
  emp_code         = '4473',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'BoyleSports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'suma.b@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sushma N',
  emp_code         = '4474',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Bangalore',
  delivery_manager = 'Astha Saini',
  project_name     = 'Apex-Margin&Risk',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sushma.n@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shivam Verma',
  emp_code         = '4477',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Noida',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'WaspBarcodeTechnologies',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shivam.verma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sankavarapu Pavani',
  emp_code         = '4479',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Brightstar',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pavani.sankavarapu@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gourav Sardana',
  emp_code         = '4480',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'ConsumerReports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gourav.sardana@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aakriti Mittal',
  emp_code         = '4481',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'Avercare',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'aakriti.mittal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Birkaran Singh',
  emp_code         = '4482',
  designation      = 'Software Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Akansha Shah',
  project_name     = 'POC-DEV',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'birkaran.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anand Kishore',
  emp_code         = '4486',
  designation      = 'Project Manager',
  level_id         = 'Level-5',
  location         = 'Noida',
  delivery_manager = 'Anand Kishore',
  project_name     = 'VistaXM',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'anand.kishore@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kumari Pramila',
  emp_code         = '4487',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'Sprinklr(Opstree)',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kumari.pramila@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anindita Das',
  emp_code         = '4488',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'Hyde Housing Association',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'anindita.das@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Raghava Gujjala',
  emp_code         = '4489',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Ajay VD Prasad Bezawada',
  project_name     = 'DES-AI',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'raghava.gujjala@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Dhammapal Bhimrao Dhutraj',
  emp_code         = '4490',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Hyderabad',
  delivery_manager = 'Anand Kishore',
  project_name     = 'AHEAD - Lumicera',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'dhammapal.dhutraj@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Apoorv Mittal',
  emp_code         = '4491',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Noida',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'ConsumerReports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'apoorv.mittal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Janak Raj',
  emp_code         = '4492',
  designation      = 'Software Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Anand Kishore',
  project_name     = 'AHEAD - Lumicera',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'janak.raj@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Haridevara Ravi Krishna',
  emp_code         = '4495',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ravi.haridevara@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Alka Rauthan',
  emp_code         = '4497',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'alka.rauthan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Devi Tamara',
  emp_code         = '4498',
  designation      = 'Lead Business Analyst',
  level_id         = 'Level-3',
  location         = 'Hyderabad',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'PreferredMutual',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'devi.tamara@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Padmalatha Lakkireddy',
  emp_code         = '4499',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'padmalatha.lakkireddy@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Amruta Magar',
  emp_code         = '4504',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'T Bharath Babu',
  project_name     = 'ZenithBank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'amruta.magar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sumit Sharma',
  emp_code         = '4507',
  designation      = 'Senior Consultant',
  level_id         = 'Level-6',
  location         = 'Noida',
  delivery_manager = 'Rakesh Pal',
  project_name     = 'Insurance_Consulting_Domain & Platform',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'sumit.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Dinesh S',
  emp_code         = '4508',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'T Bharath Babu',
  project_name     = 'ZenithBank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'dinesh.s@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bhima Sai Srikanth Deekshitula',
  emp_code         = '4509',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'srikanth.deekshitula@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Navneet Kaur',
  emp_code         = '4511',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'Avercare',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'kaur.navneet@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Keshav Bhardwaj',
  emp_code         = '4513',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Brightstar',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'keshav.bhardwaj@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Matlapudi Harshini SrisushmaSai',
  emp_code         = '4515',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Hyderabad',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'PreferredMutual',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'harshini.matlapudi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nayana N',
  emp_code         = '4516',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Bangalore',
  delivery_manager = 'T Bharath Babu',
  project_name     = 'ZenithBank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'nayana.n@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'K S Deepthi Narayan',
  emp_code         = '4517',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Bangalore',
  delivery_manager = 'Akansha Shah',
  project_name     = 'POC-DEV',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'deepthi.ks@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'S Sureshkrishna',
  emp_code         = '4518',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'sureshkrishna.s@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Karthickarul Kuppusamy',
  emp_code         = '4519',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Bangalore',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'karthickarul.kuppusamy@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gurtej Singh',
  emp_code         = '4520',
  designation      = 'Software Engineer',
  level_id         = 'Level-1',
  location         = 'Noida',
  delivery_manager = 'Akansha Shah',
  project_name     = 'POC-DEV',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'gurtej.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Challagundla Bhavya',
  emp_code         = '4521',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'bhavya.challagundla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gangireddygari Guru Pavithra',
  emp_code         = '4522',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Bangalore',
  delivery_manager = 'T Bharath Babu',
  project_name     = 'ZenithBank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pavithra.gangireddygari@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ramavath Sreeramulu Naik',
  emp_code         = '4523',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'T Bharath Babu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sreeramulu.ramavath@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rabiya Khathoon',
  emp_code         = '4525',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'Hyde Housing Association',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rabiya.khathoon@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shubham Shekhar Shelke',
  emp_code         = '4526',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Qvantel',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shubham.shelke@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rithik Zogta',
  emp_code         = '4527',
  designation      = 'Software Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Ajay VD Prasad Bezawada',
  project_name     = 'DES-AI',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'rithik.zogta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Priyanka Thakur',
  emp_code         = '4529',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'Noida',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Brightstar',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'priyanka.t@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Neha Rai',
  emp_code         = '4530',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'Hazeltree',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'neha.r@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rajiv Diwan',
  emp_code         = '4531',
  designation      = 'Vice President',
  level_id         = 'Level-9A',
  location         = 'Noida',
  delivery_manager = 'Adeesh Jain',
  project_name     = 'Bench',
  original_du      = 'Data',
  assigned_du      = 'Data',
  role             = 'delivery_manager'
WHERE email = 'rajiv.diwan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Neha Puri',
  emp_code         = '4532',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Chandigarh',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'neha.puri@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Santosh Kumar Panchamram Yadav',
  emp_code         = '4534',
  designation      = 'Senior Test Manager',
  level_id         = 'Level-6',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Brightstar',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'santosh.yadav@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gaurang Khanna',
  emp_code         = '4536',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Ajay VD Prasad Bezawada',
  project_name     = 'DES-AI',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'gaurang.khanna@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Dharm Pratap',
  emp_code         = '4538',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'dharm.pratap@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Neeraj Ramesh Gupta',
  emp_code         = '4539',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'Hyde Housing Association',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'neeraj.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sayali Sanjay Joshi',
  emp_code         = '4540',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Mumbai',
  delivery_manager = 'Neha Ummat',
  project_name     = 'AIPSO',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'sayali.joshi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nalla Abhinay Reddy',
  emp_code         = '4546',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Hyderabad',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'CommonwealthCharterAcademy-Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'abhinay.nalla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Niraj Birje',
  emp_code         = '4548',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'T Bharath Babu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'niraj.birje@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shivani Verma',
  emp_code         = '4549',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'BFS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'verma.shivani@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Cherukuri Durga Bhavani',
  emp_code         = '4550',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Micron UiPath Migration',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'durga.cherukuri@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Arun Bharath Meenathethil',
  emp_code         = '4551',
  designation      = 'Director',
  level_id         = 'Level-8A',
  location         = 'Hyderabad',
  delivery_manager = 'Rakesh Pal',
  project_name     = 'Insurance_Consulting_Domain & Platform',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'arun.meenathethil@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rashmi Mahajan',
  emp_code         = '4552',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'CommonwealthCharterAcademy-Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rashmi.m@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anurag Sharma',
  emp_code         = '4554',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'Avercare',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'anurag.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Suchithra K S',
  emp_code         = '4555',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Iqbal Singh',
  project_name     = 'Safexpress',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'suchithra.ks@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'GAYATHRI',
  emp_code         = '4556',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Navitus',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gayathri.prashanth@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aayush Mishra',
  emp_code         = '4557',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'Hyde Housing Association',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'aayush.mishra@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Voora Shwetha',
  emp_code         = '4559',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Hyderabad',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'CommonwealthCharterAcademy-Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shwetha.voora@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vishal Prabhakar',
  emp_code         = '4560',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'Hyde Housing Association',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vishal.prabhakar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Upendra Kumar Chaube',
  emp_code         = '4561',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Noida',
  delivery_manager = 'Payal Sharma',
  project_name     = 'KingSpan DataWarehousing Services',
  original_du      = 'Data',
  assigned_du      = 'Data',
  role             = 'delivery_manager'
WHERE email = 'upendra.chaube@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mrinal',
  emp_code         = '4562',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Noida',
  delivery_manager = 'Payal Sharma',
  project_name     = 'KingSpan DataWarehousing Services',
  original_du      = 'Data',
  assigned_du      = 'Data',
  role             = 'delivery_manager'
WHERE email = 'mrinal.verma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'H Sai Sharan',
  emp_code         = '4563',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Qvantel',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sai.sharan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bhargavi Yadati',
  emp_code         = '4564',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'Hyde Housing Association',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'bhargavi.yadati@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Radhika Vohra',
  emp_code         = '4565',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'Airtel Africa',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'radhika.vohra@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Dangeti Lakshmi Manikanta Vara Prasad',
  emp_code         = '4566',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'BFS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'varaprasad.dangeti@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Tatikondala Jagadeesh Babu',
  emp_code         = '4567',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Bangalore',
  delivery_manager = 'T Bharath Babu',
  project_name     = 'STC-QA',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'jagadeesh.tatikondala@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mahesh Shinde',
  emp_code         = '4568',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'Ajay VD Prasad Bezawada',
  project_name     = 'DES-AI',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'mahesh.shinde@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Archana Kalkaprasad Sahu',
  emp_code         = '4570',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Hyderabad',
  delivery_manager = 'T Bharath Babu',
  project_name     = 'ZenithBank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'archana.kalkaprasad@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'S Lindon Philip Martin',
  emp_code         = '4573',
  designation      = 'Associate Director',
  level_id         = 'Level-7',
  location         = 'Hyderabad',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'lindon.martin@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Chelika Srija',
  emp_code         = '4580',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Hyderabad',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Micron UiPath Migration',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'srija.chelika@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sneha Aniket Bhave',
  emp_code         = '4582',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sneha.bhave@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Chilla Siddanth',
  emp_code         = '4583',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'siddanth.c@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Neeraj Kumar',
  emp_code         = '4584',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'neeraj.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pakyala Vidya',
  emp_code         = '4586',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Gleesha Agarwal',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vidya.pakyala@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Monika Thapar',
  emp_code         = '4587',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'Anand Kishore',
  project_name     = 'VistaXM',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'monika.thapar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Challa Vamsi',
  emp_code         = '4588',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Micron UiPath Migration',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vamsi.challa@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sreejith K K',
  emp_code         = '4589',
  designation      = 'Test Architect',
  level_id         = 'Level-5',
  location         = 'Hyderabad',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Air Canada-UiPath',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sreejith.kk@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'JEEVADHARANI',
  emp_code         = '4591',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Bangalore',
  delivery_manager = 'Neha Ummat',
  project_name     = 'AIPSO',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'jeevadharani.h@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Maheswaram Yasasvi',
  emp_code         = '4593',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'yasasvi.maheswaram@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Tamboli Maheboob Nabi',
  emp_code         = '4594',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Subhrajit Sahoo',
  project_name     = 'AmeriLife - Automation Testing Services',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'maheboob.tamboli@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shriraj Vyankatrao Potdar',
  emp_code         = '4595',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shriraj.potdar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Chirag Amar Kataria',
  emp_code         = '4596',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'Hyde Housing Association',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'chirag.kataria@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pradhumn Mali',
  emp_code         = '4598',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Hyderabad',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Zaxby',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pradhumn.mali@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vedula Balatripura Pashyanthi',
  emp_code         = '4599',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'iliad Automation Testing',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'pashyanthi.vedula@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Khushaboo Pandey',
  emp_code         = '4602',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Noida',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'iliad Automation Testing',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'khushaboo.pandey@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ojaswi Malik',
  emp_code         = '4603',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Noida',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Micron UiPath Migration',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ojaswi.malik@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Neha Yogirajendra Turke',
  emp_code         = '4604',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'neha.turke@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Santosh Ubhale',
  emp_code         = '4605',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'Bangalore',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'Hyde Housing Association',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'santosh.ubhale@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vishal',
  emp_code         = '4610',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'Hyde Housing Association',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vishal.dhillon@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jageshwar Gope',
  emp_code         = '4613',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Draftkings - Offshore',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'jageshwar.gope@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'V N K K Prasad Kodukulla',
  emp_code         = '4615',
  designation      = 'Director',
  level_id         = 'Level-8A',
  location         = 'Hyderabad',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'prasad.kodukulla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Paruchuri Manikumar',
  emp_code         = '4618',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Chandigarh',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'manikumar.paruchuri@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Malasani Manohar Babu',
  emp_code         = '4621',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Qvantel',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'manohar.malasani@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Borra Shanmukha Sampath',
  emp_code         = '4622',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Qvantel',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sampath.borra@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Adarsh Kumar Yadav',
  emp_code         = '4623',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Vishaljeet Singh',
  project_name     = 'EverPaw',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'adarsh.yadav@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Girineni Mounika',
  emp_code         = '4624',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'mounika.girineni@testingxperts.com';

