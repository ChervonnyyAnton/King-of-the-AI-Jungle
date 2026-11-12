# 🔄 Review & Remediation: Cycle 185 — Participant Growth Reports

## 🎯 Objective
Generate individual growth reports for each participant showing their skills before vs. after the workshop, enabling personalized learning feedback and longitudinal skill tracking.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **No Individual Growth Tracking** | The workshop collects individual scoring data (judging rubrics in `INSTRUCTOR-QUICK-REF.md`), but there is no mechanism to compare a participant's pre-workshop skill level (self-assessed via `PARTICIPANT-PREREQUISITES.md`) with their post-workshop performance (judged scores). Without before/after comparison, participants cannot see their growth, and instructors cannot demonstrate the workshop's learning value. | **High** | **Instructor Delivery Domain:** All Paths — personalized growth feedback is a powerful motivator and learning reinforcement. | Created `docs/feedback/generate-growth-report.py` — a Python script that reads pre-workshop self-assessment data (from `PARTICIPANT-PREREQUISITES.md` submissions) and post-workshop judging scores, then generates an individual growth report in Markdown format showing before/after skill comparison per path group. |
| **Pre-Workshop Baseline Missing** | `PARTICIPANT-PREREQUISITES.md` documents prerequisites but does not capture a pre-workshop skill baseline that can be compared post-workshop. Self-assessment at Day-0 is not recorded in a structured, machine-readable format. | **High** | **Instructor Delivery Domain:** All Paths — without a structured baseline, "before" data cannot be programmatically compared to "after" scores. | Created `docs/feedback/SELF-ASSESSMENT-FORM.json` — a JSON schema for pre-workshop self-assessment that captures the participant's self-rated skill level across the 2-Axis model (Competence Axis × AI Expertise Axis) with specific skill indicators. This form is collected at Day-0 kickoff and serves as the "before" baseline. |
| **Growth Report Format** | No standardized report format for individual growth reports. Without a template, instructors would write free-text feedback that is inconsistent and non-comparable. | **Medium** | **Instructor Delivery Domain:** C3/C4 (Commander/Jungle King) — growth reports are key deliverables for these strategic leadership paths. | Created `docs/feedback/GROWTH-REPORT-TEMPLATE.md` — a Markdown template for individual growth reports with sections: Participant Profile, Pre-Workshop Self-Assessment, Post-Workshop Judging Scores, Skill Delta (improvement per dimension), AI Maturity Growth, and Personalized Recommendations. |

## 📂 Updated Files
- **`docs/feedback/generate-growth-report.py`**: Python script that generates individual growth reports from pre/post data.
- **`docs/feedback/SELF-ASSESSMENT-FORM.json`**: JSON schema for pre-workshop self-assessment.
- **`docs/feedback/GROWTH-REPORT-TEMPLATE.md`**: Markdown template for individual growth reports.
- **`INSTRUCTOR-QUICK-REF.md`**: Section 14 updated to include the growth report generation workflow.
- **`WORKSHOP-CHALLENGE.md`**: Step 7 updated to mention growth reports as a post-workshop deliverable.

## 📐 Risk Assessment
- **Risk Score:** 3 × 4 = **12** → **High**
- **Probability:** Likely (3) — without growth tracking, participants cannot see their learning progress, reducing motivation and workshop perceived value.
- **Impact:** High — growth reports are key differentiators for workshop quality and participant satisfaction.

## 🔄 R&R Rule Derivation

> **Rule FB-9 — Pre-Workshop Self-Assessment Baseline:** A structured self-assessment form (`SELF-ASSESSMENT-FORM.json`) must be collected from each participant at Day-0 kickoff. The form captures self-rated skill levels on both axes of the 2-Axis model (Competence Axis: Manual Tester → Architect; AI Expertise Axis: Beginner → Expert) with at least 3 specific skill indicators per axis. The baseline data must be stored in a structured format (`data/growth/before/<participant-id>.json`) for later comparison.

> **Rule FB-10 — Individual Growth Report:** An individual growth report (`generate-growth-report.py` + `GROWTH-REPORT-TEMPLATE.md`) must be generated for each participant within 48 hours of workshop completion. The report MUST include: (1) Participant Profile (name, path, AI level); (2) Pre-Workshop Self-Assessment (skills rated 1–5); (3) Post-Workshop Judging Scores (per-criterion scores from rubric); (4) Skill Delta — visual comparison of before vs. after per dimension; (5) AI Maturity Growth — movement across AI Expertise levels; (6) Personalized Recommendations — 3 specific actions for continued growth. The report must be delivered to the participant via email or a secure link.

## 📝 Action Items
1. [ ] Create `data/growth/` directory structure for before/after data storage.
2. [ ] Test `generate-growth-report.py` with sample self-assessment and judging data.
3. [ ] Integrate the self-assessment form collection into Day-0 kickoff procedure.
4. [ ] Add growth report generation to the post-workshop automated pipeline.

## 🧪 Validation
- [ ] `SELF-ASSESSMENT-FORM.json` covers both axes with ≥3 skill indicators per axis
- [ ] `generate-growth-report.py` produces valid Markdown output matching the template
- [ ] Report includes all 6 required sections from Rule FB-10
- [ ] `INSTRUCTOR-QUICK-REF.md` Section 14 references growth report generation
- [ ] `WORKSHOP-CHALLENGE.md` Step 7 mentions growth reports
