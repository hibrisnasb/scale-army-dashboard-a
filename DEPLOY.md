# Deployment guide — Dashboard A

## Stack
- **GitHub** — source control
- **Supabase** — lead capture database
- **Vercel** — static hosting (auto-deploys on every push to main)

---

## Step 1 — GitHub

1. Create a new repo at github.com (e.g. `scale-army-dashboard-a`)
2. From the project folder, run:
   ```bash
   git init
   git add .
   git commit -m "Initial commit — Dashboard A"
   git remote add origin https://github.com/YOUR_USERNAME/scale-army-dashboard-a.git
   git push -u origin main
   ```

---

## Step 2 — Supabase

1. Go to [supabase.com](https://supabase.com) → New project
2. Name it `scale-army-dashboard-a`, choose a region close to your users
3. Open the **SQL editor** and run the contents of `supabase/schema.sql`
4. Go to **Project Settings → API** and copy:
   - **Project URL** (looks like `https://xxxx.supabase.co`)
   - **anon / public key** (safe to use in client-side code with RLS enabled)
5. In `dashboard/index.html`, find these two lines and paste your values:
   ```js
   const SUPABASE_URL  = '';   // paste your Project URL here
   const SUPABASE_ANON = '';   // paste your anon key here
   ```
6. Commit and push:
   ```bash
   git add dashboard/index.html
   git commit -m "Add Supabase credentials"
   git push
   ```

---

## Step 3 — Vercel

1. Go to [vercel.com](https://vercel.com) → New project → Import from GitHub
2. Select your `scale-army-dashboard-a` repo
3. **Framework preset**: leave as "Other" (static site, no build step)
4. **Root directory**: leave as `/` (default)
5. Click **Deploy**

Vercel will:
- Serve `dashboard/index.html` as the main page
- Auto-redeploy every time you push to `main`

> To set a custom domain: Vercel dashboard → your project → Settings → Domains

---

## How data flows

```
User fills form on page 2
        ↓
JS validates + builds lead object:
  { name, company, email, area, role, ab_headline, ab_stat }
        ↓
Supabase insert → leads table (primary)
        ↓
localStorage backup (always, even if Supabase fails)
```

---

## Viewing leads in Supabase

Go to **Table Editor → leads** in your Supabase project.

Useful queries for Supabase SQL editor:

```sql
-- All leads
select * from leads order by created_at desc;

-- A/B headline breakdown
select ab_headline, count(*) from leads group by ab_headline;

-- A/B stat breakdown
select ab_stat, count(*) from leads group by ab_stat;

-- Top areas of interest
select area, count(*) from leads group by area order by count desc;

-- Top roles of interest
select role, count(*) from leads where role is not null group by role order by count desc;
```

---

## A/B test — how it works

Both tests run automatically with no configuration needed:
- **Test 1 (headline)**: 50/50 random assignment on first visit, stored in `localStorage`
  - Variant A = Woman photo + "Cut your hiring cost by 60%"
  - Variant B = Man photo + "Hire world-class creative talent, fully remote"
- **Test 2 (card stat)**: 50/50 independent assignment
  - Variant A = "X companies hiring this role"
  - Variant B = "Currently placing candidates"

Every lead submission records `ab_headline` and `ab_stat` so you can analyse
conversion rates per variant directly in Supabase.
