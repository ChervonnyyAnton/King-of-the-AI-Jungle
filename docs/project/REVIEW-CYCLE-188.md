# 🔄 Review & Remediation: Cycle 188 — Stakeholder Report Customization

## 🎯 Objective
Add customization options to the stakeholder report generator to support different stakeholder audiences (instructor, QA leadership, executives) with different data granularity levels.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Single-Format Report** | `generate-stakeholder-report.py` (Cycle 183) produces one generic report. However, different stakeholders need different data: instructors need granular per-participant data, QA leaders need aggregate metrics, executives need a high-level summary. Without customization, the same report is sent to everyone. | **Medium** | **Instructor Delivery Domain:** C3/C4 (Commander/Jungle King) — different stakeholders have different information needs. | Added `--audience` flag to `generate-stakeholder-report.py` supporting three levels: `instructor` (full detail with per-participant scores), `qa-leader` (aggregated metrics + sentiment insights), and `executive` (high-level summary with budget, scores, and 3 key recommendations). |
| **Executive Summary Length** | The generated report includes all participant details even when sent to executives who only need a 1-page summary. This wastes attention and obscures key insights. | **Medium** | **Instructor Delivery Domain:** F4 (King of the Jungle) — executives need concise, actionable summaries, not granular data. | Added a `--format` flag supporting `markdown` (default) and `brief` (1-page executive summary). The brief format includes: overall score, budget status, top positive/negative themes, and 3 recommendations only. |
| **Report Distribution** | R&R Rule FB-6 requires reports to be distributed within 24 hours, but no distribution mechanism exists. Manual emailing is error-prone and doesn't scale. | **Low** | **Instructor Delivery Domain:** All Paths — automated distribution would reduce the risk of missed deadlines. | Added `--email` flag for future SMTP integration. For now, the script outputs a `distlist.json` file listing recipients by audience type (instructor, qa-leader, executive) for manual distribution. |

## 📂 Updated Files
- **`docs/feedback/generate-stakeholder-report.py`**: Added `--audience` (instructor/qa-leader/executive) and `--format` (markdown/brief) flags.
- **`docs/feedback/REPORT-TEMPLATE.md`**: Updated to document the audience-specific section variants.
- **`INSTRUCTOR-QUICK-REF.md`**: Section 14 updated with report customization options.

## 📐 Risk Assessment
- **Risk Score:** 2 × 3 = **6** → **Medium**
- **Probability:** Possible (2) — stakeholders may receive irrelevant detail or insufficient information.
- **Impact:** Medium — different audiences have different information needs; a one-size-fits-all report wastes attention.

## 🔄 R&R Rule Derivation

> **Rule FB-15 — Audience-Specific Reports:** The stakeholder report generator MUST support at least two audience-specific output formats: (1) `instructor` — full detail with per-participant scores, budget breakdown, and detailed sentiment analysis; (2) `executive` — 1-page summary with overall metrics, budget status, top themes, and recommendations. Additional audience types may be added as needed.

> **Rule FB-16 — Distribution List Management:** A distribution list (`distlist.json`) must be maintained that maps audience types to recipient contacts. The report generator uses this list to determine which format to produce and who to send it to. Distribution must occur within 24 hours of workshop completion per Rule FB-6.

## 📝 Action Items
1. [ ] Test the `--audience` flag with all three values.
2. [ ] Create `distlist.json` with actual workshop stakeholder contacts.
3. [ ] Pilot the distribution process after the next workshop.
4. [ ] Evaluate SMTP integration for automated email distribution.

## 🧪 Validation
- [ ] `generate-stakeholder-report.py --audience instructor` produces full-detail report
- [ ] `generate-stakeholder-report.py --audience executive` produces 1-page summary
- [ ] `generate-stakeholder-report.py --audience qa-leader` produces aggregated metrics report
- [ ] `INSTRUCTOR-QUICK-REF.md` Section 14 documents the customization options
- [ ] `WORKSHOP-CHALLENGE.md` Step 7 mentions customized stakeholder reports
