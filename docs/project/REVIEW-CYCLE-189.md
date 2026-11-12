# 🔄 Review & Remediation: Cycle 189 — Growth Report Data Integration

## 🎯 Objective
Ensure the participant growth report generator (`generate-growth-report.py`) properly integrates pre-workshop self-assessment data with post-workshop judging scores, and that the growth reports are delivered to participants within the post-workshop timeline.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Data Matching Ambiguity** | `generate-growth-report.py` (Cycle 185) matches pre and post data by participant name or path_id, but the matching logic is not robust: two participants at the same path ID would produce incorrect matches, and name variations (e.g., "Sarah" vs "Sarah J.") would cause misses. | **High** | **Instructor Delivery Domain:** All Paths — incorrect data matching produces misleading growth reports that confuse participants. | Added a unique `participant_id` field to the self-assessment form (`SELF-ASSESSMENT-FORM.json`). The growth report generator now matches on `participant_id` (primary) and falls back to path_id (secondary). The instructor assigns IDs at Day-0 using the format `{session}-{path_id}-{index}` (e.g., "2026-11-10-A1-01"). |
| **Missing Post-Workshop Score Integration** | The growth report generator reads post-workshop data from a directory, but the judging scores from `INSTRUCTOR-QUICK-REF.md` rubrics are not in a standardized JSON format. Instructors record scores on paper or in a custom tracker, which must be converted before the growth report generator can process them. | **High** | **Instructor Delivery Domain:** All Paths — without standardized post-score data, growth reports cannot be generated. | Created `docs/feedback/SCORING-EXPORT-TEMPLATE.json` — a JSON template that instructors fill out after judging with participant IDs, scores per criterion, and total scores. The `generate-growth-report.py` generator accepts this template as its post-data source. |
| **Delivery Timeline** | Rule FB-10 requires growth reports to be delivered within 48 hours of workshop completion, but there is no automated delivery mechanism. Manual distribution risks missing the deadline. | **Low** | **Instructor Delivery Domain:** C3/C4 (Commander/Jungle King) — growth reports are most impactful when delivered promptly; delays reduce perceived value. | Added a `--deliver` flag to `generate-growth-report.py` that outputs a `deliver-list.json` with participant emails (or contact info) and the report file paths for each participant. This enables batch distribution via email or a shared drive link. |

## 📂 Updated Files
- **`docs/feedback/generate-growth-report.py`**: Added `participant_id` matching, `SCORING-EXPORT-TEMPLATE.json` support, and `--deliver` flag.
- **`docs/feedback/SELF-ASSESSMENT-FORM.json`**: Added `participant_id` field.
- **`docs/feedback/SCORING-EXPORT-TEMPLATE.json`**: JSON template for post-workshop judging scores.
- **`INSTRUCTOR-QUICK-REF.md`**: Section 14 updated with scoring export instructions.
- **`WORKSHOP-CHALLENGE.md`**: Step 7 updated with growth report delivery information.

## 📐 Risk Assessment
- **Risk Score:** 3 × 4 = **12** → **High**
- **Probability:** Likely (3) — without robust data matching, growth reports would contain errors.
- **Impact:** High — incorrect growth data undermines participant trust in the workshop's assessment validity.

## 🔄 R&R Rule Derivation

> **Rule FB-17 — Unique Participant Identification:** Every participant must have a unique `participant_id` assigned at Day-0. The ID format is `{session-date}-{path_id}-{sequential_number}` (e.g., "2026-11-10-A1-01"). This ID is recorded in both the self-assessment form and the scoring export template, enabling reliable data matching for growth reports.

> **Rule FB-18 — Scoring Export Standardization:** After judging, instructors must export scores using the template in `SCORING-EXPORT-TEMPLATE.json`. The template requires: participant_id, path_id, jungle_title, and scores for each judging criterion (AI Usage, Risk Analysis, Test Plan, Budget Tracking, Peer Review). This standardized export is the input for `generate-growth-report.py`.

## 📝 Action Items
1. [ ] Update Day-0 onboarding to assign participant IDs.
2. [ ] Create a scoring export helper (script or form) for instructors.
3. [ ] Test the growth report pipeline end-to-end with sample data.
4. [ ] Add `participant_id` to the `SURVEY-FORM.html` as well (for consistency).

## 🧪 Validation
- [ ] `SELF-ASSESSMENT-FORM.json` includes `participant_id` field
- [ ] `SCORING-EXPORT-TEMPLATE.json` has all required scoring fields
- [ ] `generate-growth-report.py` matches on `participant_id` (primary) and path_id (fallback)
- [ ] `INSTRUCTOR-QUICK-REF.md` Section 14 includes scoring export instructions
- [ ] `WORKSHOP-CHALLENGE.md` Step 7 mentions growth report delivery
