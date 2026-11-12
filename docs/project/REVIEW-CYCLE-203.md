# 🔄 Review & Remediation: Cycle 203 — Cross-Reference Audit (AGENTS.md & SKILLS.md)

## 🎯 Objective
Audit `AGENTS.md` and `SKILLS.md` for broken links, stale references, and missing artifacts.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **AGENTS.md** — Missing Files | References 6 files that don't exist: `docs/strategy/QA-PLAN.md`, `docs/strategy/AI-INTEGRATION.md`, `docs/simulations/SPRINT-0.md`, `docs/strategy/JUNGLE-OS.md`, `tests/fixtures/`, `tests/ci/pipeline.yml`, `tests/helpers/`. | **Medium** | All Paths — participants may waste time searching for these | Mark them as "template references" with a comment noting they are created during the workshop as deliverables. |
| **AGENTS.md** — Inline References | References `BUDGET-LOG.md` (exists ✅), `mock/index.html` (exists ✅), `docs/requirements/TICKETS/JIRA-102.md` (exists ✅), `docs/requirements/MOCK-API/` (exists ✅). No broken references in existing files. | **Low** | All Paths — clean | No changes needed for existing file references. |
| **SKILLS.md** — Missing References | References `docs/project/RESEARCH-FINDINGS.md` which doesn't exist. | **Low** | All Paths — template artifact | Add a note that this is a deliverable created during Level 3 tasks. |
| **Cross-Reference Completeness** | `AGENTS.md` references `INSTRUCTOR-QUICK-REF.md` Section 3, but the quick-ref no longer has a "Section 3" (it was renumbered in Cycle 201). | **Medium** | All Paths — stale section reference | Update the reference to point to the new section number (Section 0, "Day-0 Quick-Start"). |

## 📂 Updated Files
- `AGENTS.md`: Added "Template references" comments for 6 missing files. Updated `INSTRUCTOR-QUICK-REF.md` reference to point to the renumbered section.
- `SKILLS.md`: Added note for `docs/project/RESEARCH-FINDINGS.md` as a workshop deliverable.

## 📐 Risk Assessment
- **Risk Score:** 2 × 3 = **6** → **Medium**
- **Probability:** Possible (2) — some participants may not have the referenced tools installed.
- **Impact:** Medium — stale references create confusion but don't break the workshop.
