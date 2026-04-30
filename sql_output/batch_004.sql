-- ============================================================
-- Batch 4/5 (200 employees)
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
  'abhishek.sahani@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abhishek Sahani', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abhishek.sahani@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shamitha.sagadevan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shamitha Sagadevan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shamitha.sagadevan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'prashanth.jampana@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jampana Prashanth Kumar Varma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'prashanth.jampana@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anubhav.sood@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anubhav Sood', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anubhav.sood@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'madhav.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Madhav Gupta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'madhav.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'hemang.jindal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Hemang Jindal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'hemang.jindal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ujjwal.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ujjwal Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ujjwal.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vijay.akarapu@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Akarapu Vijay Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vijay.akarapu@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'franklin.sagayaraj@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Franklin Queleress Felix Sagayaraj', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'franklin.sagayaraj@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sunaina.karyam@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sunaina Karyam', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sunaina.karyam@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'viveka.tulasi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Tulasi Viveka', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'viveka.tulasi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rajeev.a@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rajeev Agrawal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rajeev.a@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ankur.kaushik@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ankur Kaushik', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ankur.kaushik@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shiva.mugada@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mugada Shiva Prasad', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shiva.mugada@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'alekya.g@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'G Alekya', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'alekya.g@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pranav.ranjan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pranav Ranjan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pranav.ranjan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shivansh.vij@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shivansh Vij', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shivansh.vij@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'raghuveer.alapati@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Alapati Naga Raghuveer', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'raghuveer.alapati@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aditya.a@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aditya Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aditya.a@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'arpit.tyagi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Arpit Tyagi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'arpit.tyagi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'avinash.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Avanish Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'avinash.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'venugopal.bandaru@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Venugopal Bandaru', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'venugopal.bandaru@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'varsha.kumawat@testingXperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Varsha Kumawat', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'varsha.kumawat@testingXperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'duc.nguyen@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nguyen Minh Duc', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'duc.nguyen@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vamsi.yelamanchili@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vamsi Krishna Yelamanchili', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vamsi.yelamanchili@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'viral.parikh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Viral Parikh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'viral.parikh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'akshitha.pothan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Akshitha Pothan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'akshitha.pothan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'swetha.bezawada@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Swetha Bezawada', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'swetha.bezawada@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'yameen.fatima@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Yameen Fatima', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'yameen.fatima@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'arunakar.palati@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Arunakar Palati', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'arunakar.palati@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aishwarya.gowdaiah@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aishwarya Gowdaiah', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aishwarya.gowdaiah@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'lavanya.thummala@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Lavanya Thummala', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'lavanya.thummala@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'tripti.garg@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Tripti Garg', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'tripti.garg@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rachid.kissani@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rachid Kissani', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rachid.kissani@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'damanpreet.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Damanpreet kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'damanpreet.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'karuppasamy.madasamy@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Madasamy Karuppasamy', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'karuppasamy.madasamy@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'praveen.voora@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Praveen Kumar Voora', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'praveen.voora@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sampath.bejugama@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sampath Kumar Bejugama', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sampath.bejugama@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'paulos.michael@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Paulos Gebre Michael', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'paulos.michael@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'azeez.shaik@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shaik Azeez', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'azeez.shaik@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kanaka.manoharan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kanaka Manoharan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kanaka.manoharan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ronald.wilson@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ronald Bruce Wilson Jr.', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ronald.wilson@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'karishma.ahmed@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Karishma Parveen Ahmed', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'karishma.ahmed@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'raghu.siddalingaiah@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Raghu Siddalingaiah', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'raghu.siddalingaiah@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'victor.caleb@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Victor Samuel Caleb', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'victor.caleb@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'talha.masood@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Talha Masood', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'talha.masood@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'alka.kumari@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Alka Kumari', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'alka.kumari@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abilashnie.ramaiha@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ann Abilashnie Ramaiha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abilashnie.ramaiha@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kaleem.arif@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kaleem Arif', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kaleem.arif@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mohammmed.patel@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mohammmed Raashid Patel', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mohammmed.patel@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mohammed.mirash@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mohammed Mirash', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mohammed.mirash@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nazim.najeeb@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nazim Najeeb', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nazim.najeeb@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'muhammad.zubair@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Muhammad Zubair', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'muhammad.zubair@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rakshitha.shetty@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rakshitha Shetty', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rakshitha.shetty@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'leeta.thomas@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Leeta Susan Thomas', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'leeta.thomas@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sushmitha.sandeep@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sushmitha Sandeep', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sushmitha.sandeep@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'joy.ghosh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Joy Ghosh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'joy.ghosh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'dalya.mohammed@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Dalya Osama Osman Mohammed', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'dalya.mohammed@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sithara.faisal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sithara Faisal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sithara.faisal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mohammed.yasharin@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mohamed Yasharin Zakkoor Abdul Zakkoor', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mohammed.yasharin@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'haleema.bibi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Haleema Bibi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'haleema.bibi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'adil.saleem@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Adil Saleem', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'adil.saleem@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'honeyta.gandhi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Honeyta Gandhi Alexander', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'honeyta.gandhi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'zennia.berson@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Zennia Regina Fruto Berson', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'zennia.berson@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'abelardo.advincula@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Abelardo Canlas III Advincula', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'abelardo.advincula@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'arlan.coprada@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Arlan Estremera Coprada', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'arlan.coprada@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ryan.jurada@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ryan Carlo Jungco Jurada', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ryan.jurada@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'monika.leano@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Monika Emma Mari Malamug Leano', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'monika.leano@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'joem.mendoza@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Joem Castillo Mendoza', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'joem.mendoza@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jinky.merenciano@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jinky Torres Merenciano', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jinky.merenciano@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'samson.paden@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Samson Cabaron Jr Paden', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'samson.paden@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'marlon.valda@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Marlon Regino Valda', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'marlon.valda@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kristine.vinarao@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kristine Marie Villarama Vinarao', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kristine.vinarao@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gaspar.agazon@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gaspar Agazon', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gaspar.agazon@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jovan.dadacay@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jovan Sempio (Jovan) Dadacay', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jovan.dadacay@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'reynaldo.duazo@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Reynaldo Manlapig Jr Duazo', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'reynaldo.duazo@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'erwin.flores@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Erwin Anthony Victoria Flores', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'erwin.flores@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mark.megio@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mark Sydric Guzman (Mark) Megio', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mark.megio@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bryan.opena@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bryan Ta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bryan.opena@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'maria.cabrera@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Maria Crisna Manlangit Cabrera', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'maria.cabrera@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jason.ceneciro@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jason PudPud Ceneciro', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jason.ceneciro@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jennylyn.nacion@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jennylyn Bautista Nacion', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jennylyn.nacion@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sarah.aguas@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sarah Doreen Anne Quinones Aguas', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sarah.aguas@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'richard.arce@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Richard Casica Arce', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'richard.arce@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vicente.bacus@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vicente III Tecson (Vic) Bacus', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vicente.bacus@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bethany.cuevas@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bethany Faith Aguilar Cuevas', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bethany.cuevas@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'reiner.lim@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Reiner Chiva Lim', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'reiner.lim@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'dale.madrinan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Dale Francis Madrinan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'dale.madrinan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jeremiah.mistica@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jeremiah Joshue Duran Mistica', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jeremiah.mistica@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jayvin.suyu@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jayvin Soriano Suyu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jayvin.suyu@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'erwin.baldoman@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Erwin Berro Baldoman', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'erwin.baldoman@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'john.clavecilla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'John Francis Reyes Clavecilla', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'john.clavecilla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'markangelo.paez@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mark Angelo Vivar Paez', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'markangelo.paez@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'michael.bacani@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Michael Paguio Bacani', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'michael.bacani@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jolan.mahinay@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jolan Parcon Mahinay', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jolan.mahinay@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'neil.pique@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Neil Grapa Pique', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'neil.pique@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'carolyn.tamesis@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Carolyn Gomba Tamesis', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'carolyn.tamesis@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'marvin.tumang@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Marvin Tumang', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'marvin.tumang@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rj.velasco@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'RJ Velasco', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rj.velasco@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'charlene.lagroma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Charlene Barrogo Lagroma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'charlene.lagroma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'john.tagulao@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'John Christian Llarena (JC) Tagulao', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'john.tagulao@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'joed.ubalde@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Joed Kevin Sermon Ubalde', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'joed.ubalde@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gino.aco@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gino Dela Pena Aco', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gino.aco@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'cecilio.daza@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Cecilio Domingo Jr Daza', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'cecilio.daza@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jim.lee@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jim Postigo Jr Lee', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jim.lee@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'paul.piamonte@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Paul John Alimorom Piamonte', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'paul.piamonte@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'roberto.sanchez@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Roberto Delacruz Jr Sanchez', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'roberto.sanchez@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nandakumar.rajusuma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nandakumar Raju Suma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nandakumar.rajusuma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anil.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anil Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anil.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ashutosh.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ashutosh Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ashutosh.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'chehak.madaan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Chehak Madaan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'chehak.madaan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'harsh.jain@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Harsh Jain', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'harsh.jain@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sharma.harsh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Harsh Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sharma.harsh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'khushi.dhiman@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Khushi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'khushi.dhiman@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'khushi.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Khushi Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'khushi.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kunal.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kunal Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kunal.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'lovepreet.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Lovepreet Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'lovepreet.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'medha.goel@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Medha Goel', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'medha.goel@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'prakash.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Prakash Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'prakash.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'riya.sekhri@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Riya', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'riya.sekhri@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'saloni.sachdeva@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Saloni', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'saloni.sachdeva@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shashwat.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shashwat Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shashwat.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gautam.mehar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shiv Gautam Mehar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gautam.mehar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shubham.thakur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shubham Thakur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shubham.thakur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vansh.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vansh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vansh.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vanshita.garg@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vanshita Garg', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vanshita.garg@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vivek.goyal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vivek Goyal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vivek.goyal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'yash.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Yash', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'yash.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aashira.garg@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aashira Garg', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aashira.garg@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aastha.thakur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aastha Thakur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aastha.thakur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'amardeep.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Amar Deep Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'amardeep.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anju.a@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anju', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anju.a@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ankit.vashisth@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ankit Vashisth', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ankit.vashisth@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'aradhika.a@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Aradhika', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'aradhika.a@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ayush.yadav@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ayush Yadav', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ayush.yadav@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'bipin.negi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bipin Singh Negi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'bipin.negi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'chandan.c@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Chandan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'chandan.c@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'deepak.gupta@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Deepak Kumar Gupta', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'deepak.gupta@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'deepakshi.d@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Deepakshi', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'deepakshi.d@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'dhruv.d@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Dhruv', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'dhruv.d@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'dhruv.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Dhruv Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'dhruv.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'dipanshu.d@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Dipanshu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'dipanshu.d@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'divanshu.garg@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Divanshu Garg', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'divanshu.garg@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'divianshu.chandel@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Divianshu Chandel', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'divianshu.chandel@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ganisha.garg@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ganisha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ganisha.garg@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ganisha.verma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ganisha Verma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ganisha.verma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gursimran.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gursimran Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gursimran.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'hardil.h@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Hardil', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'hardil.h@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'harsh.dev@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Harsh Dev', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'harsh.dev@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ishant.thakur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ishant Thakur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ishant.thakur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'jasneet.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Jasneet Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'jasneet.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'kartik.k@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Kartik', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'kartik.k@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'karuna.k@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Karuna', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'karuna.k@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'lovepreet.k@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Lovepreet Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'lovepreet.k@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'k.manpreet@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Manpreet Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'k.manpreet@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'manya.m@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Manya', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'manya.m@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'meenal.goyal@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Meenal Goyal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'meenal.goyal@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'mehak.m@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Mehak', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'mehak.m@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'prajwal.p@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Prajwal', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'prajwal.p@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rajat.s@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rajat Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rajat.s@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ramanjeet.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ramanjeet Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ramanjeet.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ranjan.singla@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ranjan Singla', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ranjan.singla@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'rohit.k@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Rohit Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'rohit.k@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sahil.sh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sahil', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sahil.sh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sahil.yadav@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sahil Yadav', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sahil.yadav@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'satiksha.choudhary@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Satiksha Choudhary', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'satiksha.choudhary@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sneha.kumari@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sneha Kumari', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sneha.kumari@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'suman.s@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Suman', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'suman.s@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'taney.sharma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Taney Sharma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'taney.sharma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'tanushree.basak@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Tanushree Basak', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'tanushree.basak@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vishu.v@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vishu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vishu.v@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'karan.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Karan Inder Singh Brar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'karan.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'ajitesh.lubana@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Ajitesh Lubana', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'ajitesh.lubana@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'anshika.bharti@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Anshika Bharti', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'anshika.bharti@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'arshdeep.bhangu@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Arshdeep Singh Bhangu', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'arshdeep.bhangu@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'arti.kumari@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Arti Kumari', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'arti.kumari@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'gurneet.kaur@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Gurneet Kaur', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'gurneet.kaur@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'himani.verma@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Himani Verma', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'himani.verma@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'pardeep.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pardeep Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'pardeep.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'parth.arora@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Parth Arora', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'parth.arora@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nihar.pentapalli@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Pentapalli Nihar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nihar.pentapalli@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'prem.kumar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Prem Kumar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'prem.kumar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'raghav.dhir@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Raghav Dhir', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'raghav.dhir@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'raghav.khatri@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Raghav Singh Khatri', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'raghav.khatri@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'samiksha.s@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Samiksha', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'samiksha.s@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shalini.bains@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shalini', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shalini.bains@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'simran.bhatia@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Simran', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'simran.bhatia@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'padmini.challuri@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Padmini Challuri', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'padmini.challuri@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'sudhanshu.singh@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Sudhanshu Singh', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'sudhanshu.singh@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'akshaya.mashankar@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Akshaya Mashankar', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'akshaya.mashankar@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'chaitanya.lakshmi@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Chaitanya Lakshmi Chunduri', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'chaitanya.lakshmi@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'yamuna.kalavalapalli@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Yamuna Kalavapalli', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'yamuna.kalavalapalli@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'harini.thiyagarajan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Harini Thiyagarajan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'harini.thiyagarajan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'balaji.chode@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Balaji Chode', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'balaji.chode@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shweta.mahajan@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shweta Mahajan', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shweta.mahajan@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'shwetha.methuku@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Shwetha Methuku', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'shwetha.methuku@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'siva.chava@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Siva Prasad Chava', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'siva.chava@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'vijaya.dharmagari@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Vijaya Kumar Dharmagari', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'vijaya.dharmagari@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'nagaraja.pathuri@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Nagaraja Pathuri', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'nagaraja.pathuri@testingxperts.com');

INSERT INTO auth.users (
  instance_id, id, aud, role,
  email, encrypted_password, email_confirmed_at,
  raw_user_meta_data, raw_app_meta_data,
  created_at, updated_at
)
SELECT
  '00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated',
  'balakrishna.gollapelly@testingxperts.com', crypt('Txcatalyst@123', gen_salt('bf')), now(),
  jsonb_build_object('full_name', 'Bala Krishna Gollapelly', 'role', 'delivery_manager'), '{"provider": "email", "providers": ["email"]}'::jsonb,
  now(), now()
WHERE NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'balakrishna.gollapelly@testingxperts.com');

-- PART B: Populate extra profile fields from CSV

UPDATE public.profiles SET
  full_name        = 'Abhishek Sahani',
  emp_code         = '4625',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'abhishek.sahani@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shamitha Sagadevan',
  emp_code         = '4626',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'shamitha.sagadevan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jampana Prashanth Kumar Varma',
  emp_code         = '4627',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Hyderabad',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'prashanth.jampana@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anubhav Sood',
  emp_code         = '4628',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Akansha Shah',
  project_name     = 'POC-DEV',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'anubhav.sood@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Madhav Gupta',
  emp_code         = '4629',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Akansha Shah',
  project_name     = 'POC-DEV',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'madhav.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Hemang Jindal',
  emp_code         = '4630',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Chandigarh',
  delivery_manager = 'Akansha Shah',
  project_name     = 'POC-DEV',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'hemang.jindal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ujjwal Singh',
  emp_code         = '4631',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Sahil Kapoor',
  project_name     = 'SKEPS',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ujjwal.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Akarapu Vijay Kumar',
  emp_code         = '4632',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Hyderabad',
  delivery_manager = 'Payal Sharma',
  project_name     = 'Alorica-Data',
  original_du      = 'Data',
  assigned_du      = 'Data',
  role             = 'delivery_manager'
WHERE email = 'vijay.akarapu@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Franklin Queleress Felix Sagayaraj',
  emp_code         = '4633',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Bangalore',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'franklin.sagayaraj@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sunaina Karyam',
  emp_code         = '4634',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'iliad Automation Testing',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sunaina.karyam@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Tulasi Viveka',
  emp_code         = '4635',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'OG&E',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'viveka.tulasi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rajeev Agrawal',
  emp_code         = '4637',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Chandigarh',
  delivery_manager = 'Ajay VD Prasad Bezawada',
  project_name     = 'QE-AI',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rajeev.a@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ankur Kaushik',
  emp_code         = '4639',
  designation      = 'Test Architect',
  level_id         = 'Level-5',
  location         = 'Chandigarh',
  delivery_manager = 'Astha Saini',
  project_name     = 'Alorica',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ankur.kaushik@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mugada Shiva Prasad',
  emp_code         = '4642',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Qvantel',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shiva.mugada@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'G Alekya',
  emp_code         = '4643',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Hyderabad',
  delivery_manager = 'Rali Manikya Girish',
  project_name     = 'Qvantel',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'alekya.g@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pranav Ranjan',
  emp_code         = '4645',
  designation      = 'Lead Software Engineer',
  level_id         = 'Level-3',
  location         = 'Noida',
  delivery_manager = 'Payal Sharma',
  project_name     = 'KingSpan DataWarehousing Services',
  original_du      = 'Data',
  assigned_du      = 'Data',
  role             = 'delivery_manager'
WHERE email = 'pranav.ranjan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shivansh Vij',
  emp_code         = '4646',
  designation      = 'Associate Software Engineer',
  level_id         = 'Level-B',
  location         = 'Noida',
  delivery_manager = 'Subodh Kumar',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'shivansh.vij@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Alapati Naga Raghuveer',
  emp_code         = '4649',
  designation      = 'Associate Director',
  level_id         = 'Level-7',
  location         = 'Chandigarh',
  delivery_manager = 'Manjeet Kumar',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'raghuveer.alapati@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aditya Sharma',
  emp_code         = '4650',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'Iqbal Singh',
  project_name     = 'Safexpress',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'aditya.a@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Arpit Tyagi',
  emp_code         = '4651',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'Noida',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'arpit.tyagi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Avanish Kumar',
  emp_code         = '6011',
  designation      = 'Associate Director',
  level_id         = 'Level-7',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'StateRhodeIsland',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'avinash.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Venugopal Bandaru',
  emp_code         = '6032',
  designation      = 'Test Manager',
  level_id         = 'Level-5',
  location         = 'Hyderabad',
  delivery_manager = 'Yuvraj Singh',
  project_name     = 'Group1001',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'venugopal.bandaru@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Varsha Kumawat',
  emp_code         = '6056',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Netherlands',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'varsha.kumawat@testingXperts.com';

UPDATE public.profiles SET
  full_name        = 'Nguyen Minh Duc',
  emp_code         = '6057',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'DraftKings-Functional',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'duc.nguyen@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vamsi Krishna Yelamanchili',
  emp_code         = '6088',
  designation      = 'Associate Director',
  level_id         = 'Level-7',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vamsi.yelamanchili@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Viral Parikh',
  emp_code         = '6089',
  designation      = 'Manager',
  level_id         = 'Level-5',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'viral.parikh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Akshitha Pothan',
  emp_code         = '6090',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'akshitha.pothan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Swetha Bezawada',
  emp_code         = '6092',
  designation      = 'Associate Test Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'DraftKings-Functional',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'swetha.bezawada@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Yameen Fatima',
  emp_code         = '6094',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'Zaxby''s- Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'yameen.fatima@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Arunakar Palati',
  emp_code         = '6095',
  designation      = 'Associate Test Manager',
  level_id         = 'Level-4',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'DraftKings-Functional',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'arunakar.palati@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aishwarya Gowdaiah',
  emp_code         = '6097',
  designation      = 'Test Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'InteleosInc',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'aishwarya.gowdaiah@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Lavanya Thummala',
  emp_code         = '6100',
  designation      = 'Senior Delivery Manager',
  level_id         = 'Level-6',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'lavanya.thummala@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Tripti Garg',
  emp_code         = '6107',
  designation      = 'Business Analyst',
  level_id         = 'Level-1',
  location         = 'Netherlands',
  delivery_manager = 'Anuj Kumar',
  project_name     = 'Vopak',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'tripti.garg@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rachid Kissani',
  emp_code         = '6108',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'DraftKings-Functional',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'rachid.kissani@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Damanpreet kaur',
  emp_code         = '6109',
  designation      = 'Software Engineer',
  level_id         = 'Level-1',
  location         = 'Canada',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ManagedServices-2',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'damanpreet.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Madasamy Karuppasamy',
  emp_code         = '6110',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'karuppasamy.madasamy@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Praveen Kumar Voora',
  emp_code         = '6115',
  designation      = 'Test Manager',
  level_id         = 'Level-5',
  location         = 'US',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'CommonwealthCharterAcademy-Onsite',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'praveen.voora@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sampath Kumar Bejugama',
  emp_code         = '6120',
  designation      = 'Senior Software Engineer',
  level_id         = 'Level-2',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'Market Report & Third Party Data',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'sampath.bejugama@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Paulos Gebre Michael',
  emp_code         = '6122',
  designation      = 'Business Analyst',
  level_id         = 'Level-1',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'paulos.michael@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shaik Azeez',
  emp_code         = '6125',
  designation      = 'Senior Test Engineer',
  level_id         = 'Level-2',
  location         = 'UAE',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'azeez.shaik@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kanaka Manoharan',
  emp_code         = '6126',
  designation      = 'Test Engineer',
  level_id         = 'Level-1',
  location         = 'UAE',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kanaka.manoharan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ronald Bruce Wilson Jr.',
  emp_code         = '6132',
  designation      = 'Program Manager',
  level_id         = 'Level-7',
  location         = 'US',
  delivery_manager = 'Amar Nath Pandey',
  project_name     = 'FBITN',
  original_du      = 'INS',
  assigned_du      = 'INS',
  role             = 'delivery_manager'
WHERE email = 'ronald.wilson@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Karishma Parveen Ahmed',
  emp_code         = '6133',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'karishma.ahmed@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Raghu Siddalingaiah',
  emp_code         = '6134',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'raghu.siddalingaiah@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Victor Samuel Caleb',
  emp_code         = '6135',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'UAE',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'victor.caleb@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Talha Masood',
  emp_code         = '6136',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'talha.masood@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Alka Kumari',
  emp_code         = '6139',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'UK',
  delivery_manager = 'Rajneesh Kaundal',
  project_name     = 'Hyde Housing Association',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'alka.kumari@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ann Abilashnie Ramaiha',
  emp_code         = '6140',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'abilashnie.ramaiha@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kaleem Arif',
  emp_code         = '6141',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'kaleem.arif@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mohammmed Raashid Patel',
  emp_code         = '6142',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'mohammmed.patel@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mohammed Mirash',
  emp_code         = '6143',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'mohammed.mirash@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nazim Najeeb',
  emp_code         = '6144',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'nazim.najeeb@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Muhammad Zubair',
  emp_code         = '6146',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'muhammad.zubair@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rakshitha Shetty',
  emp_code         = '6147',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'rakshitha.shetty@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Leeta Susan Thomas',
  emp_code         = '6148',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'leeta.thomas@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sushmitha Sandeep',
  emp_code         = '6149',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'sushmitha.sandeep@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Joy Ghosh',
  emp_code         = '6151',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'joy.ghosh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Dalya Osama Osman Mohammed',
  emp_code         = '6156',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'dalya.mohammed@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sithara Faisal',
  emp_code         = '6157',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sithara.faisal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mohamed Yasharin Zakkoor Abdul Zakkoor',
  emp_code         = '6158',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'mohammed.yasharin@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Haleema Bibi',
  emp_code         = '6159',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'haleema.bibi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Adil Saleem',
  emp_code         = '6160',
  designation      = 'Technical Specialist',
  level_id         = 'Level-1',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'adil.saleem@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Honeyta Gandhi Alexander',
  emp_code         = '6161',
  designation      = 'Test Lead',
  level_id         = 'Level-3',
  location         = 'Dubai',
  delivery_manager = 'Kshitij Sahariya',
  project_name     = 'Sharjah Islamic Bank',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'honeyta.gandhi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Zennia Regina Fruto Berson',
  emp_code         = '6163',
  designation      = 'Director',
  level_id         = 'Level-8A',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'zennia.berson@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Abelardo Canlas III Advincula',
  emp_code         = '6164',
  designation      = 'Business Intelligence Analyst II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'abelardo.advincula@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Arlan Estremera Coprada',
  emp_code         = '6165',
  designation      = 'Sr Manager Reporting & Analytics',
  level_id         = 'Level-6',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'arlan.coprada@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ryan Carlo Jungco Jurada',
  emp_code         = '6166',
  designation      = 'Application Development Analyst III',
  level_id         = 'Level-3',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'ryan.jurada@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Monika Emma Mari Malamug Leano',
  emp_code         = '6167',
  designation      = 'Manager Reporting & Analytics',
  level_id         = 'Level-5',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'monika.leano@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Joem Castillo Mendoza',
  emp_code         = '6168',
  designation      = 'Manager Application Development',
  level_id         = 'Level-5',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'joem.mendoza@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jinky Torres Merenciano',
  emp_code         = '6169',
  designation      = 'Application Developer III',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'jinky.merenciano@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Samson Cabaron Jr Paden',
  emp_code         = '6170',
  designation      = 'Application Developer III',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'samson.paden@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Marlon Regino Valda',
  emp_code         = '6171',
  designation      = 'Manager - Reporting & Analytics',
  level_id         = 'Level-5',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'marlon.valda@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kristine Marie Villarama Vinarao',
  emp_code         = '6172',
  designation      = 'Manager',
  level_id         = 'Level-5',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'kristine.vinarao@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gaspar Agazon',
  emp_code         = '6173',
  designation      = 'Programmer Analyst',
  level_id         = 'Level-1',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'gaspar.agazon@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jovan Sempio (Jovan) Dadacay',
  emp_code         = '6174',
  designation      = 'Programmer Analyst',
  level_id         = 'Level-1',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'jovan.dadacay@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Reynaldo Manlapig Jr Duazo',
  emp_code         = '6175',
  designation      = 'Programmer Analyst',
  level_id         = 'Level-1',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'reynaldo.duazo@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Erwin Anthony Victoria Flores',
  emp_code         = '6176',
  designation      = 'Programmer Analyst II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'erwin.flores@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mark Sydric Guzman (Mark) Megio',
  emp_code         = '6177',
  designation      = 'Programmer Analyst',
  level_id         = 'Level-1',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'mark.megio@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bryan Ta',
  emp_code         = '6178',
  designation      = 'Programmer Analyst',
  level_id         = 'Level-1',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'bryan.opena@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Maria Crisna Manlangit Cabrera',
  emp_code         = '6179',
  designation      = 'Business Intelligence Analyst II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'maria.cabrera@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jason PudPud Ceneciro',
  emp_code         = '6180',
  designation      = 'Application Developer',
  level_id         = 'Level-1',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'jason.ceneciro@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jennylyn Bautista Nacion',
  emp_code         = '6181',
  designation      = 'Business Intelligence Analyst III',
  level_id         = 'Level-3',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'jennylyn.nacion@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sarah Doreen Anne Quinones Aguas',
  emp_code         = '6182',
  designation      = 'Programmer Analyst II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'sarah.aguas@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Richard Casica Arce',
  emp_code         = '6183',
  designation      = 'Programmer Analyst II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'richard.arce@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vicente III Tecson (Vic) Bacus',
  emp_code         = '6184',
  designation      = 'Programmer Analyst III',
  level_id         = 'Level-3',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'vicente.bacus@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bethany Faith Aguilar Cuevas',
  emp_code         = '6185',
  designation      = 'Programmer Analyst II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'bethany.cuevas@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Reiner Chiva Lim',
  emp_code         = '6186',
  designation      = 'Programmer Analyst III',
  level_id         = 'Level-3',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'reiner.lim@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Dale Francis Madrinan',
  emp_code         = '6187',
  designation      = 'Application Developer II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'dale.madrinan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jeremiah Joshue Duran Mistica',
  emp_code         = '6188',
  designation      = 'Programmer Analyst II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'jeremiah.mistica@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jayvin Soriano Suyu',
  emp_code         = '6189',
  designation      = 'Programmer Analyst II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'jayvin.suyu@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Erwin Berro Baldoman',
  emp_code         = '6190',
  designation      = 'Application Developer II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'erwin.baldoman@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'John Francis Reyes Clavecilla',
  emp_code         = '6191',
  designation      = 'Application Developer II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'john.clavecilla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mark Angelo Vivar Paez',
  emp_code         = '6192',
  designation      = 'Application Developer III',
  level_id         = 'Level-3',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'markangelo.paez@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Michael Paguio Bacani',
  emp_code         = '6193',
  designation      = 'Application Developer II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'michael.bacani@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jolan Parcon Mahinay',
  emp_code         = '6194',
  designation      = 'Application Developer III',
  level_id         = 'Level-3',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'jolan.mahinay@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Neil Grapa Pique',
  emp_code         = '6195',
  designation      = 'Application Developer II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'neil.pique@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Carolyn Gomba Tamesis',
  emp_code         = '6196',
  designation      = 'Application Developer II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'carolyn.tamesis@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Marvin Tumang',
  emp_code         = '6197',
  designation      = 'Application Developer II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'marvin.tumang@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'RJ Velasco',
  emp_code         = '6198',
  designation      = 'Application Developer II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'rj.velasco@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Charlene Barrogo Lagroma',
  emp_code         = '6199',
  designation      = 'Reporting Analyst',
  level_id         = 'Level-1',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'charlene.lagroma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'John Christian Llarena (JC) Tagulao',
  emp_code         = '6200',
  designation      = 'Reporting Analyst',
  level_id         = 'Level-1',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'john.tagulao@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Joed Kevin Sermon Ubalde',
  emp_code         = '6201',
  designation      = 'Reporting Analyst',
  level_id         = 'Level-1',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'joed.ubalde@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gino Dela Pena Aco',
  emp_code         = '6202',
  designation      = 'Database Administrator II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'gino.aco@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Cecilio Domingo Jr Daza',
  emp_code         = '6203',
  designation      = 'Database Administrator III',
  level_id         = 'Level-3',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'cecilio.daza@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jim Postigo Jr Lee',
  emp_code         = '6204',
  designation      = 'Database Administrator III',
  level_id         = 'Level-3',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'jim.lee@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Paul John Alimorom Piamonte',
  emp_code         = '6205',
  designation      = 'Database Administrator II',
  level_id         = 'Level-2',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'paul.piamonte@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Roberto Delacruz Jr Sanchez',
  emp_code         = '6206',
  designation      = 'Database Administrator III',
  level_id         = 'Level-3',
  location         = 'Phillipines',
  delivery_manager = 'V N K K Prasad Kodukulla',
  project_name     = 'Alorica AMS',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'roberto.sanchez@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nandakumar Raju Suma',
  emp_code         = '6207',
  designation      = 'Senior Business Analyst',
  level_id         = 'Level-2',
  location         = 'US',
  delivery_manager = 'Vamsi Krishna Yelamanchili',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'nandakumar.rajusuma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anil Kumar',
  emp_code         = '8141',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Micron UiPath Migration',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'anil.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ashutosh Singh',
  emp_code         = '8142',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'ashutosh.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Chehak Madaan',
  emp_code         = '8143',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Neha Ummat',
  project_name     = 'AGIA-Affinity',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'chehak.madaan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Harsh Jain',
  emp_code         = '8144',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'harsh.jain@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Harsh Sharma',
  emp_code         = '8145',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'sharma.harsh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Khushi',
  emp_code         = '8146',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'DES-AI',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'khushi.dhiman@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Khushi Sharma',
  emp_code         = '8147',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Vijay Narayan Gupta',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'khushi.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kunal Sharma',
  emp_code         = '8148',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'kunal.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Lovepreet Kaur',
  emp_code         = '8149',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'lovepreet.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Medha Goel',
  emp_code         = '8150',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'medha.goel@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Prakash Singh',
  emp_code         = '8151',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'prakash.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Riya',
  emp_code         = '8152',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'riya.sekhri@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Saloni',
  emp_code         = '8153',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'saloni.sachdeva@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shashwat Sharma',
  emp_code         = '8154',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shashwat.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shiv Gautam Mehar',
  emp_code         = '8155',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Ruchika Rani Mehta',
  project_name     = 'Cyware-Accessibility',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gautam.mehar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shubham Thakur',
  emp_code         = '8156',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'shubham.thakur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vansh',
  emp_code         = '8157',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'vansh.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vanshita Garg',
  emp_code         = '8158',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vanshita.garg@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vivek Goyal',
  emp_code         = '8159',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Thotakura Venkata Ranga Naveen Kumar',
  project_name     = 'CorpCU-UiPath',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vivek.goyal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Yash',
  emp_code         = '8160',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Neha Ummat',
  project_name     = 'AGIA-Affinity',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'yash.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aashira Garg',
  emp_code         = '8166',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'aashira.garg@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aastha Thakur',
  emp_code         = '8167',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'aastha.thakur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Amar Deep Singh',
  emp_code         = '8168',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'amardeep.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anju',
  emp_code         = '8169',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Ruchika Rani Mehta',
  project_name     = 'Ugro-Accessibility Testing',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'anju.a@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ankit Vashisth',
  emp_code         = '8170',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ankit.vashisth@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Aradhika',
  emp_code         = '8171',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'aradhika.a@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ayush Yadav',
  emp_code         = '8172',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ayush.yadav@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bipin Singh Negi',
  emp_code         = '8173',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Ruchika Rani Mehta',
  project_name     = 'EnableAll-Accessibility Testing',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'bipin.negi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Chandan',
  emp_code         = '8174',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'chandan.c@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Deepak Kumar Gupta',
  emp_code         = '8175',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'deepak.gupta@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Deepakshi',
  emp_code         = '8176',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'deepakshi.d@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Dhruv',
  emp_code         = '8177',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'dhruv.d@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Dhruv Sharma',
  emp_code         = '8178',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'dhruv.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Dipanshu',
  emp_code         = '8179',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'dipanshu.d@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Divanshu Garg',
  emp_code         = '8180',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'divanshu.garg@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Divianshu Chandel',
  emp_code         = '8181',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'divianshu.chandel@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ganisha',
  emp_code         = '8182',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ganisha.garg@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ganisha Verma',
  emp_code         = '8183',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ganisha.verma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gursimran Kaur',
  emp_code         = '8184',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gursimran.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Hardil',
  emp_code         = '8185',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'hardil.h@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Harsh Dev',
  emp_code         = '8186',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'harsh.dev@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ishant Thakur',
  emp_code         = '8187',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'ishant.thakur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Jasneet Singh',
  emp_code         = '8188',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'jasneet.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Kartik',
  emp_code         = '8189',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'kartik.k@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Karuna',
  emp_code         = '8190',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'karuna.k@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Lovepreet Kaur',
  emp_code         = '8191',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'lovepreet.k@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Manpreet Kaur',
  emp_code         = '8192',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'k.manpreet@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Manya',
  emp_code         = '8193',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'manya.m@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Meenal Goyal',
  emp_code         = '8194',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'meenal.goyal@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Mehak',
  emp_code         = '8195',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'mehak.m@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Prajwal',
  emp_code         = '8196',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'prajwal.p@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rajat Sharma',
  emp_code         = '8197',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'rajat.s@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ramanjeet Kaur',
  emp_code         = '8198',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ramanjeet.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ranjan Singla',
  emp_code         = '8199',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ranjan.singla@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Rohit Kumar',
  emp_code         = '8200',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'rohit.k@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sahil',
  emp_code         = '8201',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sahil.sh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sahil Yadav',
  emp_code         = '8202',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sahil.yadav@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Satiksha Choudhary',
  emp_code         = '8203',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'satiksha.choudhary@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sneha Kumari',
  emp_code         = '8204',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'sneha.kumari@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Suman',
  emp_code         = '8205',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'suman.s@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Taney Sharma',
  emp_code         = '8206',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'taney.sharma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Tanushree Basak',
  emp_code         = '8207',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'tanushree.basak@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vishu',
  emp_code         = '8208',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vishu.v@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Karan Inder Singh Brar',
  emp_code         = '8209',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'karan.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Ajitesh Lubana',
  emp_code         = '8210',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'ajitesh.lubana@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Anshika Bharti',
  emp_code         = '8211',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'anshika.bharti@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Arshdeep Singh Bhangu',
  emp_code         = '8212',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'arshdeep.bhangu@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Arti Kumari',
  emp_code         = '8213',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'arti.kumari@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Gurneet Kaur',
  emp_code         = '8214',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'gurneet.kaur@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Himani Verma',
  emp_code         = '8215',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'himani.verma@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pardeep Singh',
  emp_code         = '8216',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'pardeep.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Parth Arora',
  emp_code         = '8217',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'parth.arora@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Pentapalli Nihar',
  emp_code         = '8218',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'nihar.pentapalli@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Prem Kumar',
  emp_code         = '8219',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'prem.kumar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Raghav Dhir',
  emp_code         = '8220',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'raghav.dhir@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Raghav Singh Khatri',
  emp_code         = '8221',
  designation      = 'Software Development Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'raghav.khatri@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Samiksha',
  emp_code         = '8222',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'samiksha.s@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shalini',
  emp_code         = '8223',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shalini.bains@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Simran',
  emp_code         = '8224',
  designation      = 'Software Testing Trainee',
  level_id         = 'Level-T',
  location         = 'Chandigarh',
  delivery_manager = 'Shastrapani Himanshu',
  project_name     = 'Bench',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'simran.bhatia@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Padmini Challuri',
  emp_code         = '9029',
  designation      = 'Test Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'ConsumerReports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'padmini.challuri@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Sudhanshu Singh',
  emp_code         = '9080',
  designation      = 'None',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'sudhanshu.singh@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Akshaya Mashankar',
  emp_code         = '9100',
  designation      = 'Technical Consultant',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Sahiba Rehncy',
  project_name     = 'ASTM',
  original_du      = 'DES',
  assigned_du      = 'DES',
  role             = 'delivery_manager'
WHERE email = 'akshaya.mashankar@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Chaitanya Lakshmi Chunduri',
  emp_code         = '9102',
  designation      = 'Senior QA Analyst',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'chaitanya.lakshmi@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Yamuna Kalavapalli',
  emp_code         = '9121',
  designation      = 'QA Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'ConsumerReports',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'yamuna.kalavalapalli@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Harini Thiyagarajan',
  emp_code         = '9128',
  designation      = 'Database Administrator',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Ashwani Narula',
  project_name     = 'PreferredMutual',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'harini.thiyagarajan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Balaji Chode',
  emp_code         = '9139',
  designation      = NULL,
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'balaji.chode@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shweta Mahajan',
  emp_code         = '9149',
  designation      = 'QA Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'DraftKings-Functional',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shweta.mahajan@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Shwetha Methuku',
  emp_code         = '9167',
  designation      = NULL,
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'StateRhodeIsland',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'shwetha.methuku@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Siva Prasad Chava',
  emp_code         = '9184',
  designation      = 'Contractor',
  level_id         = 'None',
  location         = 'US',
  delivery_manager = 'Nishu Goyal',
  project_name     = 'StateRhodeIsland',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'siva.chava@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Vijaya Kumar Dharmagari',
  emp_code         = '9189',
  designation      = 'Senior Test Manager',
  level_id         = 'Consultant',
  location         = 'Hyderabad',
  delivery_manager = 'Neha Ummat',
  project_name     = 'CM-Performance',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'vijaya.dharmagari@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Nagaraja Pathuri',
  emp_code         = '9191',
  designation      = NULL,
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'nagaraja.pathuri@testingxperts.com';

UPDATE public.profiles SET
  full_name        = 'Bala Krishna Gollapelly',
  emp_code         = '9206',
  designation      = 'Software Engineer',
  level_id         = 'Consultant',
  location         = 'US',
  delivery_manager = 'SK Manjar Alam',
  project_name     = 'FMG-ContingentWorkers',
  original_du      = 'QE',
  assigned_du      = 'QE',
  role             = 'delivery_manager'
WHERE email = 'balakrishna.gollapelly@testingxperts.com';

