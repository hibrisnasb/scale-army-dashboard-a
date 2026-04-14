---
name: pipeline-data
description: >
  Load this skill whenever working with Scale Army's weekly pipeline CSV export.
  Use it for any task involving reading, cleaning, or analyzing the sales/AM data —
  including generating role demand counts, active placement stats, channel analysis,
  funnel health reports, or preparing data for Dashboard A or Dashboard B.
  Always load this skill before touching any CSV from the pipeline, even for
  quick questions like "how many active placements this week?"
---

# Pipeline data skill

## CSV location & format

Weekly export lands at `/mnt/user-data/uploads/` — filename varies.  
Always `pd.read_csv()` with default settings. One row = one deal/candidate record.

## Column reference

| Column | Use |
|--------|-----|
| `Job` | Role title requested by client |
| `Company` | Client company name |
| `HS Stage` | Current pipeline stage — always bucket using Stage Map below |
| `Attribution` | Lead source / acquisition channel |
| `Candidate Name` | PII — internal only, never display |
| `HS BOF Reason` | Bottom-of-funnel loss reason — internal only |
| `HS MOF Reason` | Mid-funnel loss reason — internal only |
| `HS Termination Reason` | Post-placement termination reason — internal only |
| `Deel Contract Status` | Contract state via Deel payment platform |
| `Deel Department` | Company the placed talent is contracted to |
| `Deel Match?` | Whether a Deel contract exists for this record |
| `All Sales Status` | Cross-system placement status |

## Stage map — always apply before computing metrics

```python
stage_buckets = {
    'Active':      ['Active','Trial Period','Check-in Needed','Buy Out Complete','Buyout'],
    'In Pipeline': ['Candidates Sent to Clients','Interview Block',
                    'Interview/Presentation Block','Candidate Chosen By Client',
                    'MSA/Addend Signed','Letter of Intent Sent','Letter of Intent Signed',
                    'Kick Off Call Booked','CRS Date Set',
                    'Links Sent: JD/Stripe/Engagement Letter','Invoice Sent','Launch Search Ops'],
    'Paused':      ['Search Paused','Re-engage','Notice'],
    'Lost TOF':    ['Closed Lost TOF'],
    'Lost MOF':    ['Closed Lost MOF'],
    'Lost':        ['Closed Lost'],
    'Won':         ['Closed Won - Post 30 Days (Stripe Recurring Live)'],
}
```

## Data visibility rules — CRITICAL, read before every output

### External-safe (website, LPs, client tools, Dashboard A)
- Role demand counts — `df['Job'].value_counts()`
- Active placement count — records in Active bucket
- Unique companies served — `df[df['Deel Match?']=='Yes']['Deel Department'].nunique()`
- Active Deel contracts — `df[df['Deel Contract Status']=='In Progress'].shape[0]`
- Savings calculations derived from market salary benchmarks (not internal Deel data)

### Internal only — never expose externally (Dashboard B, internal reports only)
- Conversion rates (Active / Total per role)
- TOF / MOF loss rates and reasons
- Attribution channel conversion rates
- `HS BOF Reason`, `HS MOF Reason`, `HS Termination Details`, `HS Termination Reason`
- `Candidate Name` — PII
- Company-specific deal counts

---

## CRM artifact exclusion

Some `Job` values in the CSV are HubSpot pipeline events, not real job titles.
Always filter these out before computing role demand or building Dashboard A role cards.

```python
CRM_ARTIFACTS = ['New Meeting Booked', 'New Deal']
df_roles = df[~df['Job'].isin(CRM_ARTIFACTS)]
```

Apply `df_roles` (not `df`) for all role demand counts and Dashboard A outputs.
Use `df` (unfiltered) only for total pipeline volume and channel analysis.

---

## Standard analysis — run on every new CSV

### Block 1: External-safe snapshot
```python
import pandas as pd
df = pd.read_csv('/mnt/user-data/uploads/<filename>.csv')

# Exclude CRM artifacts from role demand
CRM_ARTIFACTS = ['New Meeting Booked', 'New Deal']
df_roles = df[~df['Job'].isin(CRM_ARTIFACTS)]

active = df[df['HS Stage'] == 'Active']

print('=== EXTERNAL-SAFE STATS ===')
print('Active placements:', len(active))
print('Unique companies served:', df[df['Deel Match?']=='Yes']['Deel Department'].nunique())
print('Active Deel contracts:', df[df['Deel Contract Status']=='In Progress'].shape[0])
print('\nDemand by role (top 15 — CRM artifacts excluded):')
print(df_roles['Job'].value_counts().head(15))
```

### Block 2: Creative health signals (internal — Dashboard B only)
```python
tof   = df[df['HS Stage']=='Closed Lost TOF']
mof   = df[df['HS Stage']=='Closed Lost MOF']
reeng = df[df['HS Stage']=='Re-engage']

print('=== TOF LOSSES BY ROLE (top 12) ===')
print(tof['Job'].value_counts().head(12))

print('\n=== MOF LOSSES BY ROLE (top 12) ===')
print(mof['Job'].value_counts().head(12))

print('\n=== RE-ENGAGE POOL BY ROLE (retargeting audience) ===')
print(reeng['Job'].value_counts().head(12))

print('\n=== RE-ENGAGE POOL BY CHANNEL ===')
print(reeng['Attribution'].value_counts())
```

### Block 3: Conversion by role (internal — never share externally)
```python
# Common jobs only (5+ records for statistical relevance)
job_counts = df['Job'].value_counts()
common_jobs = job_counts[job_counts >= 5].index
df_common = df[df['Job'].isin(common_jobs)]
active_common = df_common[df_common['HS Stage']=='Active']

job_total  = df_common.groupby('Job').size()
job_active = active_common.groupby('Job').size().reindex(job_total.index, fill_value=0)
conv       = (job_active / job_total * 100).round(1)

summary = pd.DataFrame({
    'demand':   job_total,
    'active':   job_active,
    'conv_pct': conv
}).sort_values('demand', ascending=False)
print(summary)
```

### Block 4: Channel analysis (internal)
```python
attr_total  = df.groupby('Attribution').size()
attr_active = active.groupby('Attribution').size().reindex(attr_total.index, fill_value=0)
attr_conv   = (attr_active / attr_total * 100).round(1)

attr_summary = pd.DataFrame({
    'total':    attr_total,
    'active':   attr_active,
    'conv_pct': attr_conv
}).sort_values('total', ascending=False)
print(attr_summary)
```

---

## Role category map (use consistently across all outputs)

| Category | Roles |
|----------|-------|
| Design & Creative | Graphic Designer, Video Editor, UI/UX Designer, Photo Retoucher, Brand Marketing Associate, Creative Assistant, Digital Content Producer, Brand & Marketing Designer |
| Marketing | Email Marketing Specialist, Marketing Assistant, Marketing Manager, Digital Marketing Specialist, Growth Marketing Manager, Content Creator, Marketing Project Manager, Marketing Associate, SEO Specialist |
| Social Media | Social Media Manager, Social Media Specialist, Social Media Coordinator, Social Media Account Manager, Social Media Content Creator |
| Paid Media | Paid Media Specialist, Paid Media Buyer |
| Sales & BD | Cold Caller, SDR, BDR, AE, Account Executive, Sales Rep, Sales Representative, Inside Sales Rep, Appointment Setter, Business Development Representative |
| Operations | Project Manager, Digital Project Manager, Virtual Assistant, Executive Assistant, Account Manager, Operations Specialist, Customer Service Rep, Bookkeeper, Controller, Client Success Associate |

---

## Notes for future data versions

- If new columns appear, classify visibility before using in any output
- `HS Stage` values may be renamed — re-map to Stage buckets before computing
- Role titles may vary slightly (e.g. "Graphic Designer II") — normalize to category for trend tracking; use exact title for role cards
- If a `Date` column is added, enable week-over-week trend analysis
