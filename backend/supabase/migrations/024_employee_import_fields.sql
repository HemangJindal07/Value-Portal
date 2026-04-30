-- Migration 024: Add employee import fields to profiles
-- Run this ONCE before importing employees.

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS emp_code         text,
  ADD COLUMN IF NOT EXISTS designation      text,
  ADD COLUMN IF NOT EXISTS level_id         text,
  ADD COLUMN IF NOT EXISTS location         text,
  ADD COLUMN IF NOT EXISTS delivery_manager text,
  ADD COLUMN IF NOT EXISTS project_name     text,
  ADD COLUMN IF NOT EXISTS original_du      text,
  ADD COLUMN IF NOT EXISTS assigned_du      text;
