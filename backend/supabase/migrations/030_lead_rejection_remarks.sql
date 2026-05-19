-- AC-06: Reviewer should be able to add rejection remarks when rejecting a lead,
-- and the submitter should see them on the lead detail page.

alter table public.leads
  add column if not exists rejection_remarks text;
