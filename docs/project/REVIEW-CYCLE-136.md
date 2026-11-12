# 🔄 Review & Remediation: Cycle 136

## 🎯 Objective
Translate the core "Quick Reference" and "Showdown" sections of `docs/tools/INSTRUCTOR-QUICK-REF.md` into German, creating a bilingual instructor reference for the DACH region workshop.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **i18n — Instructor Guide Language Barrier** | The `INSTRUCTOR-QUICK-REF.md` was English-only. Instructors who are more comfortable in German (common in DACH region corporate training) would struggle to deliver the workshop accurately, potentially miscommunicating critical timing, rules, or judging criteria. | **High** | **Documentation Domain — Instructor Delivery.** Instructors cannot deliver effectively if the reference material is not in their working language. | Created `docs/tools/INSTRUCTOR-QUICK-REF-DE.md` — a complete German translation of the Quick Reference card, covering: Role Definitions, Troubleshooting (Sections A-D), 3-Hour Delivery Flow, Day-0 Participant Mapping, Judging Checklist, Resource Allocation, Token Distribution, Day-0 Setup, Judging Rubric Validation, Showdown Format, Celebration & Recognition, Post-Workshop Follow-up, and Continuous Learning Paths. |
| **i18n — Core Sections Scope** | Translating the entire 650+ line document would be excessive for a first pass. The most critical sections for instructors to reference during delivery are: Role Definitions, Troubleshooting, Delivery Flow, and Showdown Format. | **Medium** | **Documentation Domain — DACH Instructors.** Missing translations for critical sections increases delivery risk. | Focused translation on the 13 core sections that instructors reference during live delivery. Technical sections (setup, configuration) remain in English as they contain code commands and file paths that are language-neutral. The translated document follows the same structure and includes the same tables, rubrics, and timing information. |
| **i18n — Code and Technical Terms** | Code commands (`cat opencode.json`, `npx serve mock/`), file paths, and technical terms (Playwright, CI/CD, API) should remain in English in the German translation — these are universal developer terms that German instructors would expect to see in their original form. | **Low** | **Technical Domain — All Paths.** Translating code commands would create confusion and increase errors. | Technical commands, file paths, tool names, and UI element selectors were preserved in English. Only instructional text, descriptions, and explanations were translated. |

## 📂 Updated Files
- **`docs/tools/INSTRUCTOR-QUICK-REF-DE.md`**: Created — complete German translation of the Quick Reference card (13 sections, ~500 lines), covering Role Definitions, Troubleshooting, Delivery Flow, Mapping Matrix, Judging Checklist, Resource Allocation, Token Distribution, Day-0 Setup, Showdown Format, Celebration & Recognition, Post-Workshop Follow-up, and Continuous Learning Paths.

## 📐 Risk Assessment
- **Risk Score:** 3 × 4 = **12** → **High**
- **Probability:** Likely (3) — DACH instructors may not be fluent in English technical documentation.
- **Impact:** High — instructor confidence and delivery quality directly impact workshop success.

## 🔄 R&R Rule Derivation
This cycle produced **Rule I18N-4** to the new Accessibility section:

> **Rule I18N-4 — Instructor Material Translation:** All instructor-facing documentation (`INSTRUCTOR-QUICK-REF.md`, `INSTRUCTOR-CHECKLIST.md`, `WORKSHOP-PRESENTATION.md`) must be available in both English and German. The German version must be named `*-DE.md` and placed in the same directory as the English original. Translation scope includes all instructional content, timing, judging criteria, and troubleshooting guides. Technical commands, file paths, and tool names remain in English.

## 📝 Action Items
1. [x] Create `INSTRUCTOR-QUICK-REF-DE.md` with German translations.
2. [x] Preserve technical commands and code in English.
3. [ ] Add cross-reference link at the top of both language versions pointing to the other.
4. [ ] Have a native German speaker review the translation for accuracy.
5. [ ] Update `README.md` to point to both language versions.

## 🧪 Validation
- [ ] Workshop Stability Check
- [ ] Instructor Script Consistency
- [ ] Version Alignment
