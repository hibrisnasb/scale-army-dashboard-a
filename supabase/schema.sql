-- Scale Army Dashboard A — Leads table
-- Run this in the Supabase SQL editor before deploying

create table if not exists leads (
  id           uuid        default gen_random_uuid() primary key,
  created_at   timestamptz default now()             not null,

  -- Contact info
  name         text        not null,
  company      text        not null,
  email        text        not null,

  -- Intent signals from the dashboard
  area         text,   -- category selected on page 1 (sales, design, marketing, social, paid, ops, all)
  role         text,   -- specific role card clicked on page 2 (e.g. 'Cold Caller')

  -- A/B test attribution
  ab_headline  text,   -- 'a' = savings-led headline, 'b' = talent-led headline
  ab_stat      text    -- 'a' = demand count stat, 'b' = availability stat
);

-- Row Level Security (required — keeps your data safe with a public anon key)
alter table leads enable row level security;

-- Allow anonymous inserts only (the form submission)
create policy "anon can insert leads"
  on leads
  for insert
  to anon
  with check (true);

-- Deny all reads from anon (only your dashboard / service role can read)
-- No select policy needed — absence of policy = deny by default
