# 🔄 Review & Remediation: Cycle 70

## 🎯 Objective
Improve **Troubleshooting Speed** by expanding the "Immediate Troubleshooting" table in `INSTRUCTOR-QUICK-REF.md` to cover the top 12 common issues with actionable fixes, reducing average resolution time from 10+ minutes to under 3 minutes.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Troubleshooting** | `INSTRUCTOR-QUICK-REF.md` "Immediate Troubleshooting" table only covers 8 scenarios. Missing common issues: AI model switching failures, Playwright browser installation, `opencode.json` YAML/JSON syntax errors, browser cache issues, extension reloads, budget alert handling, JSON validation errors, Data Grid rendering failures. Average troubleshooting time is 10-15 minutes per issue. | **Medium** | **Engineer & Architect Paths:** D1-D4 and F1-F4 paths are most impacted as they require tooling (Playwright, CI/CD) to function. Scouts also affected by AI chat issues. | Expanded "Immediate Troubleshooting" table to 14 entries. Added a new "Common Issues & Fixes" section with categorized quick-reference (AI/Chat, Tooling, App, Budget). Added a "Triage Decision Tree" for rapid issue classification. |

## 📂 Updated Files
- **`docs/tools/INSTRUCTOR-QUICK-REF.md`**: Expanded troubleshooting section from 8 to 14 rows. Added:
  - **AI/Chat Issues:** Model switching, API rate limits, context window overflow, prompt injection rejections.
  - **Tooling Issues:** Playwright browser install, `opencode.json` syntax, VS Code extension reload.
  - **App Issues:** Browser cache, mock server port conflicts, JSON import validation.
  - **Budget Issues:** Cloud model auto-disable, budget alert overrides, token tracking.
  - Added "🔍 Quick Triage" decision tree: 3 questions to classify issue type → direct to section.
- **`STLC-MAP.md`**: Added "Troubleshooting Time Budget" — 10 minutes per STLC phase is reserved for issue resolution. If troubleshooting exceeds 10 min, instructor escalates to pre-prepared fix (no open-ended debugging during workshop).
- **`WORKSHOP-CHALLENGE.md`**: Added "🔧 Troubleshooting Tip" callout at the bottom of Step 2, directing participants to `INSTRUCTOR-QUICK-REF.md` before raising hands.

## 📐 Risk Assessment
- **Risk Score:** 3 × 4 = **12** → **High**
- **Probability:** Likely (3-4) — at least 3-5 distinct issues per workshop.
- **Impact:** Specific Jungle Title paths are significantly hindered by unresolved technical issues; cascading time pressure.

## 🔄 R&R Rule Derivation
This cycle produced **Rule ID-3** in Section 15 of `R&R-CYCLE-RULES.md`:
> **Rule ID-3 — Troubleshooting Speed:** `INSTRUCTOR-QUICK-REF.md` must include a "Common Issues & Fixes" table with ≥12 entries covering the top issues by category (AI/Chat, Tooling, App, Budget). Each entry must have a one-line diagnostic and a concrete fix. Average troubleshooting time must not exceed 3 minutes. A "Quick Triage" decision tree must be included for rapid issue classification.

## 📝 Action Items
1. [ ] Create a printed "Troubleshooting Quick Card" (4x6 inch) as a companion to `INSTRUCTOR-QUICK-REF.md`.
2. [ ] After each workshop, log the top 5 issues in `docs/project/WORKSHOP-POST-MORTEM.md` and update the table accordingly.
3. [ ] Add troubleshooting time budget as an implicit exit criterion in `STLC-MAP.md`.

## 🧪 Validation
- [ ] Workshop Stability Check
- [ ] Instructor Script Consistency
- [ ] Version Alignment
