# Dashboard A — Client ROI & Roles Explorer
**Scale Army · Multimedia Designer · April 2026**

---

## Dashboard Goal

Dashboard A is a client-facing interactive tool embedded on the Scale Army website. It lets prospective clients browse in-demand roles, understand what talent is available, and calculate exactly how much they would save compared to a US hire.

Every element uses only publicly safe data — demand counts, proof-of-supply numbers, and market-rate salary benchmarks. No internal conversion rates, channel data, or pipeline metrics are exposed.

---

## Data Sources

| File | Location | Purpose |
|------|----------|---------|
| `Scale Army Mock data 2026 training purposes - Sales_AM.csv` | `data/` | Primary pipeline data — role demand counts, placement stages, Deel contract status. Source for all external-safe stats on Dashboard A. |

### CSV columns used (external-safe only)

| Data Point | Safe for Clients? | Used In |
|---|---|---|
| Role demand counts | Yes | Dashboard A — role cards |
| Active placements count | Yes | Dashboard A — hero stat |
| Companies served count | Yes | Dashboard A — hero stat |
| Active Deel contracts | Yes | Dashboard A — hero stat |
| Salary benchmarks | Yes (market rates only) | Dashboard A — calculator |
| Conversion rates | **No — internal only** | Dashboard B |
| TOF / MOF loss rates | **No — internal only** | Dashboard B |
| Channel conversion rates | **No — internal only** | Dashboard B |
| Termination reasons | **No — internal only** | Dashboard B |
| Candidate names (PII) | **Never** | Not used in any output |

---

## Skill Files

Four markdown skill files are installed as part of this project. The master skill routes all tasks to the correct sub-skill. Begin every session with: **use the scale army designer skill**.

| Skill | Path | Purpose |
|-------|------|---------|
| MASTER | `skills/scale-army-designer/SKILL.md` | Role context, data safety rules, routing table to sub-skills |
| DATA | `skills/pipeline-data/SKILL.md` | CSV columns, stage buckets, visibility rules, analysis scripts |
| COPY | `skills/role-copy/SKILL.md` | Role descriptions, salary benchmarks, A/B copy variants |
| VISUAL | `skills/dashboard-visual/SKILL.md` | Component specs, color tokens, layout rules, rebuild checklist |

**Skill loading order:**
- Full Dashboard A rebuild: `pipeline-data` → `role-copy` → `dashboard-visual`
- Copy edits only: `role-copy` alone
- Weekly data refresh: `pipeline-data` → `dashboard-visual` (if role cards change)

---

## Feature Checklist

Build features one at a time. Mark each checkbox when complete before moving to the next.

### Phase 1 — Foundation: Skill Files
> Nothing else gets built until these files exist and are installed.

- [ ] **Write `pipeline-data/SKILL.md`** — CSV column definitions, HS Stage bucket map, internal-vs-external visibility rules, standard Python analysis scripts
- [ ] **Write `role-copy/SKILL.md`** — Approved category map, prospect-facing role descriptions, salary benchmark table, copy rules
- [ ] **Write `dashboard-visual/SKILL.md`** — Component specs for role cards, filter pills, hero stats, calculator; color tokens; dark mode rules; rebuild checklist
- [ ] **Write `scale-army-designer/SKILL.md` (master)** — References all three sub-skills, designer role context, trigger phrase, routing table
- [ ] **Install all four skill files** — Place at correct paths. Confirm trigger works: start a new session and say: *use the scale army designer skill*

---

### Phase 2 — Data Layer: Extraction & Safety Checks

- [ ] **Run Block 1 — external-safe snapshot** *(DATA SKILL)* — Active placements count, unique companies served, active Deel contracts, role demand by job title (top 15). This becomes the source dataset for Dashboard A
- [ ] **Run Blocks 2–4 — internal only** *(DATA SKILL)* — Creative health signals, conversion by role, channel analysis. For Dashboard B and internal reporting only — never referenced in client-facing assets
- [ ] **Human review: validate external-safe dataset** — Manually confirm no conversion rates, termination reasons, stage labels, or attribution data appears in the external-safe output. One-time review before UI build begins

---

### Phase 3 — Content Layer: Role Copy & Benchmarks

- [ ] **Write approved descriptions for top 12 roles** *(COPY SKILL)* — One prospect-facing sentence per role using the role-copy skill. Describes what the role delivers to the client — not pipeline language
- [ ] **Review and confirm salary benchmarks with manager** *(COPY SKILL)* — Approve benchmark table in `role-copy/SKILL.md` (US monthly vs Scale Army monthly per category). Values must be defensible in a client conversation and must not be derived from internal Deel contract data
- [ ] **Document A/B test copy variants in skill file** *(COPY SKILL)* — Record both headline variants (savings-led vs talent-led) and both role card stat variants (demand count vs availability) before launch

---

### Phase 4 — Build: Dashboard Components
> Build in component order, not page order. Test each component independently before starting the next.

- [ ] **Hero stats bar** *(VISUAL SKILL)* — 3 proof numbers: active placements, companies served, savings %. All values from external-safe dataset only. Three metric cards in a row: 12px label above, 22px/500 number below, background-secondary fill
- [ ] **Role cards grid with filter pills** *(VISUAL + COPY)* — One card per role: category badge, role name, demand count stat (Variant A), one-sentence description from role-copy skill. Six filter pills using the category map from pipeline-data. No conversion rates anywhere
- [ ] **ROI calculator widget** *(VISUAL + COPY)* — Headcount slider + role-type selector drives live savings output (monthly and annual). Clicking a role card auto-selects that role and pre-fills salary benchmarks from role-copy skill. CTA button at bottom. This component gets the most design polish — it is the conversion mechanism
- [ ] **Integrate and QA full page layout** *(VISUAL SKILL)* — Assemble hero → filter row → role grid → calculator. Run the dashboard-visual rebuild checklist: dark mode, mobile at 375px, card-to-calculator linking, no internal data visible. Get manager sign-off before handing to web dev

---

### Phase 5 — A/B Testing Setup

- [ ] **Hero headline test — savings-led vs talent-led** *(COPY SKILL)*
  - Variant A: *"Cut your hiring cost by 60%"*
  - Variant B: *"Hire world-class creative talent, fully remote"*
  - Success metric: CTA click-through rate. Run minimum 2 weeks. Log winner back to role-copy skill

- [ ] **Role card stat test — demand count vs availability** *(DATA + COPY)*
  - Variant A: *"X companies have hired this role"*
  - Variant B: *"Currently placing candidates"*
  - Success metric: calculator interactions per card click. Pipeline-data skill tracks demand counts weekly — winning stat gets locked in

---

## Weekly Data Refresh Loop
> Once all skill files are installed, this workflow takes 15–20 minutes every Monday.

1. New CSV arrives — start session with: **use the scale army designer skill** — pipeline-data skill auto-loads
2. Run Block 1 (external-safe snapshot) — note any changes in top-12 role demand vs previous week
3. If roles changed: load role-copy skill — generate descriptions for any new roles entering the top 12
4. Load dashboard-visual skill — update hero stats and any changed role cards — run rebuild checklist
5. Separately: run Blocks 2–4 (internal) — produce Dashboard B creative health report — these outputs stay internal

---

*Prepared by: Multimedia Designer · Scale Army · April 2026*
