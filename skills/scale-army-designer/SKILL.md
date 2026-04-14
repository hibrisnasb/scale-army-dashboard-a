---
name: scale-army-designer
description: >
  Master skill for Scale Army's Multimedia Designer. Load this skill at the start
  of any session involving Scale Army pipeline data, dashboard work, paid media
  analysis, landing page assets, role copy, or creative reporting. This skill
  provides role context and routes tasks to the correct sub-skills. Use it
  whenever the user mentions Scale Army, uploads a pipeline CSV, asks about
  role demand, wants to update Dashboard A or Dashboard B, needs copy for a
  role or ad, or wants to analyze which creatives are working. If in doubt, load it.
---

# Scale Army — Multimedia Designer master skill

## Role context

The person using this skill is the Multimedia Designer at Scale Army. Their work spans:
- Organic content and paid media creative assets (Meta, Twitter, Reddit, Google)
- Website management — design and A/B testing
- Landing page creation and prioritization by role
- Dashboard A: client-facing ROI & Roles Explorer (external, on website)
- Dashboard B: internal creative health tracker (internal, weekly)
- Reporting on which roles need new LPs and which channels need new creatives

Scale Army is a talent placement company connecting companies with remote talent
across creative, marketing, social media, paid media, and operations roles.

---

## Sub-skill routing — always read the relevant skill before working

| Task | Load this skill |
|------|----------------|
| Reading or analyzing the weekly CSV | `pipeline-data/SKILL.md` |
| Writing role descriptions, ad copy, LP headlines | `role-copy/SKILL.md` |
| Building or updating Dashboard A components | `dashboard-visual/SKILL.md` + `role-copy/SKILL.md` |
| Full Dashboard A rebuild with new data | All three: `pipeline-data` → `role-copy` → `dashboard-visual` |
| Dashboard B (internal creative health report) | `pipeline-data/SKILL.md` (internal blocks only) |
| A/B test variant copy | `role-copy/SKILL.md` |
| Salary benchmarks for calculator | `role-copy/SKILL.md` |

**Rule:** Never start a data task without loading `pipeline-data` first.  
**Rule:** Never write client-facing copy without loading `role-copy` first.  
**Rule:** Never build a UI component without loading `dashboard-visual` first.

---

## Data visibility — top-level reminder

Two hard categories. These never mix.

**External-safe** (website, LPs, client dashboards):
role demand counts · active placements count · companies served count · savings calculator values

**Internal only** (Dashboard B, creative reports, channel analysis):
conversion rates · TOF/MOF loss data · attribution channel conversion · termination reasons · candidate names

See `pipeline-data/SKILL.md` for the full list and SQL-style field-by-field classification.

---

## Weekly workflow summary

Every Monday when new CSV arrives:

1. Load `pipeline-data/SKILL.md` → run all four analysis blocks
2. Note changes vs. last week: new roles in top 12? roles that dropped out?
3. If role cards need updating → load `role-copy/SKILL.md` → generate new descriptions
4. If stats changed → load `dashboard-visual/SKILL.md` → rebuild affected components
5. Separately: generate Dashboard B internal report (pipeline-data internal blocks only)
6. Output a one-paragraph creative brief: top 3 roles to prioritize, which channel needs new creative, re-engage pool size

---

## Project: Dashboard A build order

Phase 1 — Skill files (complete before anything else)  
Phase 2 — Data layer: run pipeline-data analysis, validate external-safe dataset  
Phase 3 — Content layer: role descriptions + benchmark review via role-copy skill  
Phase 4 — Build: hero bar → role cards → calculator → full page QA  
Phase 5 — A/B: headline variant test + role card stat variant test  

See the full project plan document for detailed task breakdown.
