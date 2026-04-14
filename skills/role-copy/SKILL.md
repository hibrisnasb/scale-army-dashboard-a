---
name: role-copy
description: >
  Load this skill whenever writing or updating copy for Scale Army's client-facing
  assets — including Dashboard A role cards, landing pages, paid ad headlines,
  website copy, or any content describing roles to potential clients.
  Use it to look up approved role descriptions, salary benchmarks for the ROI
  calculator, and the rules for what language is appropriate externally.
  Load alongside pipeline-data when rebuilding Dashboard A role cards with new data.
---

# Role copy skill

## Purpose

Defines approved copy for every client-facing surface. Copy here is written for
a prospect audience — companies considering hiring through Scale Army. It describes
what a role *delivers*, not how Scale Army's pipeline tracks it internally.

**Rule:** If a description uses the words "conversion", "stage", "TOF", "MOF",
"pipeline", or "Deel" — it does not belong on a client-facing surface. Rewrite it.

---

## Approved role descriptions (client-facing)

One sentence per role. Describes value delivered to the client.

| Role | Approved description |
|------|----------------------|
| Social Media Manager | Owns your brand voice across platforms — creates, schedules, and optimizes content that builds audience and drives engagement. |
| Graphic Designer | Delivers production-ready visual assets for digital and print — from social content to brand collateral. |
| Video Editor | Transforms raw footage into polished, platform-ready content for ads, social, and branded video. |
| UI/UX Designer | Designs intuitive, conversion-focused interfaces — from wireframes to final visual specs ready for dev. |
| Email Marketing Specialist | Plans and executes email campaigns — list management, copywriting, A/B testing, and performance reporting. |
| Marketing Assistant | Supports campaign execution, content scheduling, and reporting across your marketing channels. |
| Paid Media Specialist | Manages paid campaigns across Meta, Google, and emerging platforms — focused on ROAS and cost-per-lead. |
| Paid Media Buyer | Executes media buys, manages budgets, and optimizes targeting for performance-driven campaigns. |
| Digital Marketing Specialist | Covers the full digital marketing mix — SEO, paid, email, and analytics — as a generalist campaign operator. |
| Marketing Manager | Leads campaign strategy, coordinates creative and channel teams, and owns marketing performance metrics. |
| Growth Marketing Manager | Runs data-driven growth experiments across acquisition and retention channels. |
| Content Creator | Produces written, visual, and short-form video content aligned to your brand strategy and content calendar. |
| Social Media Specialist | Executes day-to-day social content, community management, and platform-specific strategy. |
| Cold Caller | Drives high-volume outbound prospecting through scripted calling campaigns — building your pipeline at a fraction of in-house cost. |
| SDR | Qualifies inbound and outbound leads and books discovery calls so your closers spend time selling, not chasing. |
| BDR | Identifies and engages new business opportunities through outbound prospecting — from cold outreach to first meetings. |
| Appointment Setter | Fills your sales calendar with qualified prospect meetings so your team focuses on closing, not scheduling. |
| Project Manager | Keeps cross-functional work on track — timelines, task ownership, and stakeholder communication. |
| Virtual Assistant | Handles administrative tasks, scheduling, research, and communication management. |
| Account Manager | Owns client relationships, renewals, and upsell conversations post-placement. |
| SEO Specialist | Improves organic search visibility through technical SEO, content strategy, and keyword optimization. |

---

## Salary benchmarks for ROI calculator

These are market-rate estimates used in the client-facing savings calculator.
**Never derive from internal Deel contract data.** These are public market benchmarks.
Review and confirm with management quarterly.

| Category | US market est. / month | Scale Army est. / month | Savings |
|----------|------------------------|-------------------------|---------|
| Design & Creative | $4,500 – $6,000 | $1,800 – $2,400 | ~60% |
| Marketing | $4,000 – $7,500 | $1,600 – $3,000 | ~60% |
| Social Media | $3,500 – $4,500 | $1,400 – $1,800 | ~60% |
| Paid Media | $5,000 – $6,000 | $2,000 – $2,400 | ~60% |
| Operations | $3,000 – $6,000 | $1,200 – $2,400 | ~60% |
| Sales & BD | $3,500 – $5,000 | $1,400 – $2,000 | ~60% |

**Default calculator values per specific role** (used when a role card is selected):

| Role | US monthly default | SA monthly default |
|------|--------------------|--------------------|
| Social Media Manager | $4,500 | $1,800 |
| Graphic Designer | $5,000 | $2,000 |
| Video Editor | $5,000 | $2,000 |
| UI/UX Designer | $6,000 | $2,400 |
| Email Marketing Specialist | $4,000 | $1,600 |
| Paid Media Specialist | $5,500 | $2,200 |
| Paid Media Buyer | $5,500 | $2,200 |
| Digital Marketing Specialist | $5,000 | $2,000 |
| Marketing Manager | $7,000 | $2,800 |
| Growth Marketing Manager | $7,500 | $3,000 |
| Content Creator | $4,000 | $1,600 |
| Marketing Assistant | $3,500 | $1,400 |
| Cold Caller | $3,500 | $1,400 |
| SDR | $4,500 | $1,800 |
| BDR | $4,500 | $1,800 |
| Appointment Setter | $3,500 | $1,400 |

---

## A/B test variants (active)

Track which variant is live and results to date. Update when test concludes.

### Hero headline test
- **Variant A (savings-led):** "Cut your hiring cost by 60%"
- **Variant B (talent-led):** "Hire world-class creative talent, fully remote"
- Status: **live** — 50/50 random assignment, persisted in localStorage
- Success metric: CTA click-through rate (`cta_click` event)
- Min run: 2 weeks. Log winner back to this file when concluded.

### Role card stat test
- **Variant A:** "X companies have hired this role" (demand count)
- **Variant B:** "Currently placing candidates" (availability signal)
- Status: **live** — 50/50 random assignment, persisted in localStorage
- Success metric: calculator interactions per card click (`card_to_calc` event)
- Min run: 2 weeks. Winning stat gets locked into role cards permanently.

---

## Copy rules summary

- Always write for a prospect (company decision-maker), not a recruiter
- Use present tense and active voice: "Owns your brand voice", not "Will be owning"
- Never use pipeline terminology: stage, funnel, TOF, MOF, conversion rate
- Never use internal platform names: HubSpot stage labels, Deel, Ashby, All Sales
- Savings percentages must be prefixed with "up to" or "~" — never stated as guaranteed
- Role descriptions are one sentence max in the card view; expand on dedicated LPs
