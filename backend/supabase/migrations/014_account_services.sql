-- Migration 014: Add services column to accounts table
-- services stores the list of TX service verticals offered to this account
-- e.g. ["QE", "DE", "AI_Data", "Insurance"]

ALTER TABLE accounts
  ADD COLUMN IF NOT EXISTS services text[] DEFAULT '{}';
