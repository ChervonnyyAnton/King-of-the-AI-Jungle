# King of the AI Jungle — Feedback Pipeline Guide

## Overview

This guide describes the end-to-end post-workshop feedback pipeline, from Day-0 self-assessment collection through stakeholder report delivery and feedback-to-rules processing.

## Pipeline Architecture

```
Day-0                    Workshop Wrap-up               Day+1 (24h)                Day+2 (48h)
┌─────────────────┐  ┌──────────────────────┐  ┌───────────────────┐  ┌─────────────────┐
│ Self-Assessment │  │ Survey Form (HTML)   │  │ Pipeline Run      │  │ Feedback-to-    │
│ Collection      │→ │ → JSON Output        │→ │ → Reports         │→ │ Rules Processing│
└─────────────────┘  └──────────────────────┘  └───────────────────┘  └─────────────────┘
       │                      │                        │                        │
       ▼                      ▼                        ▼                        ▼
  pre-assessments/    feedback/*.json         sentiment +            R&R Cycle triggers
  (structured JSON)                       stakeholder reports      (≥Medium severity)
```

---

## Phase 1: Day-0 Self-Assessment Collection

### When
At workshop kickoff, before participants begin their Jungle Title path.

### How
1. Instructor distributes the self-assessment form (paper or digital).
2. Participants complete `SELF-ASSESSMENT-FORM.json` fields:
   - `session_id`, `participant_name`, `path_id`
   - Self-rated skills: `qa_fundamentals`, `ai_awareness`, `tooling_skills`, `test_design`, `risk_analysis` (1–5 scale)
   - Unique `participant_id` (format: `{session}-{path_id}-{index}`)
3. Instructor collects forms and saves to `data/growth/before/<session-id>.json`.

### Output
- One JSON file per participant (or one combined JSON file) in `data/growth/before/`.

---

## Phase 2: Post-Workshop Survey Deployment

### When
During the wrap-up segment (02:45–03:00), after the Showdown.

### How
1. Instructor displays `SURVEY-FORM.html` on the main screen.
2. Participants submit feedback on their own devices (laptop/phone).
3. For each submission:
   - The form validates required fields.
   - On submit, JSON is generated and auto-copied to clipboard.
   - Participant confirms submission via toast notification.
4. Instructor collects JSON submissions (from clipboard) and saves to `data/feedback/`.

### Fallback
If the digital form is unavailable, use paper feedback cards with the same 5 Likert + 2 open-text questions. Convert to JSON manually.

### Output
- `data/feedback/<participant-name>.json` (one file per submission)

---

## Phase 3: Automated Pipeline Execution

### When
Within 24 hours of workshop completion (Day+1).

### How
Run the pipeline orchestrator:
```bash
bash docs/feedback/run-feedback-pipeline.sh \
  --data-dir data/ \
  --workshop-date 2026-11-10 \
  --instructor "John Doe"
```

### What It Does
1. **Sentiment Analysis:** Reads all `data/feedback/*.json` files, analyzes sentiment, produces `data/sentiment-report.json`.
2. **Stakeholder Report:** Generates `data/workshop-summary-report.md` with scores, budget, feedback summary, sentiment insights, and recommendations.
3. **Growth Reports:** Generates individual growth reports (if pre/post data is available) in `data/growth-reports/`.
4. **Pipeline Status:** Writes `data/pipeline-status.json` with completion status.

### Output
- `data/sentiment-report.json`
- `data/workshop-summary-report.md`
- `data/growth-reports/` (individual growth reports)
- `data/pipeline-status.json`

---

## Phase 4: Report Distribution

### When
Within 24 hours of workshop completion (same Day+1).

### How
1. **Instructor:** Receives the full-detail stakeholder report (markdown).
2. **QA Leaders:** Receive the aggregated metrics report (from `--audience qa-leader`).
3. **Executives:** Receive the 1-page executive summary (from `--audience executive`).
4. **Participants:** Receive their individual growth report via email or shared drive link.

### Distribution List
Maintain `data/distlist.json` with:
```json
{
  "instructor": ["instructor@example.com"],
  "qa-leader": ["qa-lead@example.com"],
  "executive": ["vp-engineering@example.com"],
  "participants": [
    {"name": "Alice", "email": "alice@example.com", "growth_report": "growth-alice.json"}
  ]
}
```

---

## Phase 5: Feedback-to-Rules Processing

### When
Within the next R&R cycle batch (or immediately for Critical/High findings).

### How
1. Review `sentiment-report.json` for negative sentiment themes.
2. Review `workshop-summary-report.md` for low Likert scores (<3.0).
3. Apply the FEEDBACK-TO-RULES.md pipeline:
   - Categorize each finding (Pedagogy/Technical/Documentation/UX/Security).
   - Prioritize using the R&R Severity Matrix.
   - Trigger dedicated R&R cycles for ≥High findings.
   - Add to backlog for Medium findings.
4. Update R&R-CYCLE-RULES.md Change Log with any rule amendments.
5. Close the loop: notify participants who provided feedback.

---

## Quick Reference

| Step | Command/Action | Output |
|------|---------------|--------|
| Day-0: Self-Assessment | Paper or digital form | `data/growth/before/*.json` |
| Wrap-up: Survey | `npx serve docs/feedback/` | `data/feedback/*.json` |
| Day+1: Pipeline | `bash docs/feedback/run-feedback-pipeline.sh` | Reports + status |
| Day+1: Distribution | Email/link reports | Reports delivered |
| Next batch: Feedback-to-Rules | Review sentiment + scores | New R&R cycles |

---

*Guide version 1.0 — King of the AI Jungle Feedback & Reporting Engine*
