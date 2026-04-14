---
name: dashboard-visual
description: >
  Load this skill whenever building, rebuilding, or updating Dashboard A
  (the client-facing ROI & Roles Explorer) or any Scale Army client-facing
  interactive asset. Use it to look up component specifications, color token
  assignments per role category, grid layout rules, dark mode requirements,
  and the calculator widget design. Load alongside pipeline-data and role-copy
  when doing a full Dashboard A rebuild.
---

# Dashboard visual skill

## Design principles

- Flat, clean surfaces. No gradients, no drop shadows, no decorative effects.
- Dark mode mandatory — every color uses CSS variables or approved hex pairs.
- Client-facing tone: professional, minimal, data-confident. Not startup-flashy.
- Interactive elements must work on mobile (touch targets min 44px, readable at 375px wide).

---

## Color tokens per role category

These assignments are fixed. Do not re-assign without updating this file.

| Category | Background | Text | Border accent |
|----------|-----------|------|---------------|
| Design & Creative | `#E6F1FB` | `#0C447C` | `#185FA5` |
| Marketing | `#EAF3DE` | `#27500A` | `#3B6D11` |
| Social Media | `#FAEEDA` | `#633806` | `#854F0B` |
| Paid Media | `#FBEAF0` | `#72243E` | `#993556` |
| Sales & BD | `#EEEDFE` | `#26215C` | `#534AB7` |
| Operations | `#F1EFE8` | `#444441` | `#5F5E5A` |

Dark mode pairs (use when `prefers-color-scheme: dark`):

| Category | Background (dark) | Text (dark) |
|----------|------------------|-------------|
| Design & Creative | `#0C447C` | `#B5D4F4` |
| Marketing | `#27500A` | `#C0DD97` |
| Social Media | `#633806` | `#FAC775` |
| Paid Media | `#72243E` | `#F4C0D1` |
| Sales & BD | `#26215C` | `#CECBF6` |
| Operations | `#444441` | `#D3D1C7` |

---

## Component specifications

### Hero stat bar
- 3 metric cards in a row: active placements, companies served, savings %
- Each card: `background: var(--color-background-secondary)`, no border, `border-radius: 8px`, padding `12px 14px`
- Label: 12px, `var(--color-text-secondary)`, above the number
- Number: 22px, weight 500, `var(--color-text-primary)`
- Gap between cards: 10px
- Data source: external-safe dataset from pipeline-data skill only

### Role card
- Background: `var(--color-background-primary)`
- Border: `0.5px solid var(--color-border-tertiary)`
- Border radius: `var(--border-radius-lg)` (12px)
- Padding: `14px 16px`
- Selected state: `border: 2px solid #1D9E75`
- Hover state: `border-color: var(--color-border-secondary)`
- Height: auto (content-driven)
- Min width: 200px

**Card anatomy (top to bottom):**
1. Category badge pill — 10px, font-weight 500, pill border-radius, color from category token table
2. Role name — 14px, font-weight 500, `var(--color-text-primary)`, margin-bottom 6px
3. Demand stat — 12px, `var(--color-text-secondary)` label + number. Format: `"X companies hired this role"` (Variant A) or `"Currently placing candidates"` (Variant B — see role-copy skill)
4. Role description — 12px, `var(--color-text-secondary)`, one sentence from role-copy skill
5. No conversion rates. No channel data. No internal metrics.

### Filter pills row
- Sits between hero bar and role grid
- Pills: 12px, padding `5px 12px`, border-radius 20px
- Default state: `border: 0.5px solid var(--color-border-secondary)`, transparent bg, `var(--color-text-secondary)`
- Active state: `background: var(--color-background-secondary)`, `var(--color-text-primary)`, font-weight 500, `border-color: var(--color-border-primary)`
- Labels: "All roles", "Sales & BD", "Design & Creative", "Marketing", "Social Media", "Paid Media", "Operations"
- "Sales & BD" sits first after "All roles" — it is the highest-demand category in the current dataset and should lead the filter row

### Role grid layout
- `display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 12px`
- Use `minmax(0, 1fr)` not `1fr` to prevent grid blowout on long role names

### ROI calculator
- Container: `background: var(--color-background-secondary)`, `border-radius: var(--border-radius-lg)`, padding `20px 22px`
- Title: 14px, font-weight 500
- Subtitle: 12px, `var(--color-text-secondary)`
- Two-column layout at desktop: sliders left, results right
- Slider rows: label (12px, 100px wide, flex-shrink 0) + range input (flex 1) + value readout (12px, font-weight 500)
- Result cards: 2×2 grid. The two savings cards use `border-color: #1D9E75` and `color: #0F6E56` for the value
- CTA button: primary style (green bg `#1D9E75`, white text, same border-color)
- CTA note: 11px, `var(--color-text-secondary)`, inline after button

**Calculator behavior:**
- Clicking a role card pre-selects that role in the dropdown and updates salary sliders to benchmarks from role-copy skill
- Headcount slider: min 1, max 10, step 1
- US salary slider: min $2,000, max $10,000, step $500
- SA rate slider: min $1,000, max $5,000, step $100
- All displayed numbers must use `toLocaleString()` — no raw floats on screen

---

## Page layout order

```
[hero stat bar — 3 proof numbers]
[16px gap]
[filter pills row]
[12px gap]
[role card grid]
[24px gap]
[ROI calculator widget]
```

---

## Rebuild checklist (run before every deploy)

- [ ] No conversion rates visible anywhere
- [ ] No channel data visible anywhere
- [ ] No internal stage names visible anywhere
- [ ] All role descriptions pulled from role-copy skill (not improvised)
- [ ] Hero stats updated from latest external-safe dataset
- [ ] Dark mode tested — all text readable on near-black background
- [ ] Calculator correctly pre-fills when a role card is clicked
- [ ] Mobile: role grid collapses to 1 column at 375px, calculator stacks vertically
- [ ] CTA button present and functional
