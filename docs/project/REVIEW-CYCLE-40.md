# 🔄 Review & Remediation: Cycle 40

## 🎯 Objective
Focus on **Test Design Techniques** — add a rule requiring test cases in `TEST-PLAN.md` to explicitly map to ISTQB-recognized Test Design Techniques (e.g., Equivalence Partitioning, Boundary Value Analysis, Decision Table).

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Missing Technique Taxonomy** | `TEST-PLAN.md` template had no column or guidance for test design techniques. Participants were designing tests ad hoc without awareness of ISTQB's formal technique catalog. | High | **Scouts (A/B/C):** Manual testers need technique guidance to produce diverse, high-coverage test cases. | Added "Test Design Technique" column to `TEST-PLAN.md` template and included a technique reference section mapping common techniques to workshop features. |
| **Coverage Blind Spots** | Without technique-based test design, scenarios tend to be uniformly functional-positive. Boundary conditions, equivalence classes, and negative paths are underrepresented. | High | **Engineers (D/E):** Automation engineers build on weak test designs, producing brittle test suites. | Added a new R&R rule: "Every test plan must use at least 3 different ISTQB Test Design Techniques." Defined acceptable techniques list (EP, BVA, Decision Table, State Transition, Error Guessing). |
| **Technique Documentation** | No instructor reference for explaining techniques to beginner participants. | Medium | **Trail Explorers, Camp Builders:** Beginner paths need guided technique selection. | Added "🧪 Test Design Technique Reference" section to `docs/templates/TEST-PLAN.md` with one-line descriptions and workshop-specific examples. |

## 📂 Updated Files
- `R&R-CYCLE-RULES.md`: Added new rule under section 5 (Workflow) — "Test Design Technique Requirement": Every test plan must use at least 3 different ISTQB techniques.
- `R&R-CYCLE-RULES.md`: Added "Test Design Techniques Reference" as a new subsection listing EP, BVA, Decision Table, State Transition, and Error Guessing with workshop-relevant examples.
- `docs/templates/TEST-PLAN.md`: Added "Technique" column to the test case table and appended a "Test Design Technique Reference" section.
- `STLC-MAP.md`: Updated Phase 2 (Test Planning) output artifact description to include "Mapped to ISTQB Test Design Techniques."

## 🧪 Validation
- [x] Template enforces technique documentation
- [x] Minimum 3 techniques rule is clear and measurable
- [x] Examples are workshop-relevant (JSON import/export, Data Grid)
- [x] Workshop stability maintained

## 📚 ISTQB Reference
> ISTQB FL v4.0, Section 2.3 Test Techniques: Equivalence Partitioning, Boundary Value Analysis, Decision Table Testing, State Transition Testing, and Error Guessing are core black-box techniques that systematic test designers should apply to maximize coverage.

---

*Cycle 40 complete. Test Design Techniques are now a mandatory, documented element of the test planning process.*
