ALTER TABLE leads ADD COLUMN IF NOT EXISTS ai_summary text;
ALTER TABLE leads ADD COLUMN IF NOT EXISTS ai_suggested_priority text;
ALTER TABLE leads ADD COLUMN IF NOT EXISTS ai_win_probability real;
