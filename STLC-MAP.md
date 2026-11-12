# 🔄 STLC Mapping: King of the AI Jungle

> **Explicit mapping of Software Testing Life Cycle phases to workshop tasks, prompts, tools, and deliverables.**
> **Compliance:** All artifacts follow ISO/IEC/IEEE 29119-3 (Test Documentation) and ISTQB Foundation Level v4.0 standards.

## 📋 STLC Phase Matrix

| STLC Phase | Time Box | Workshop Task | Prompt Role | Tools Used | Output Artifact | Success Criteria | Energy Level |
|------------|----------|---------------|-------------|------------|-----------------|------------------|--------------|
| **1. Requirements Analysis** | 15 min | Read `JIRA-102.md`, `JIRA-103.md`, `JIRA-104.md`, `SPEC-101.md` | Risk Analyst | `filesystem`, `websearch` | `docs/requirements/RISK-ANALYSIS.md` | Covers XSS, DoS, Edge Cases, Traceability; Follows ISO/IEC/IEEE 29119-3 §5.4 | Calm/Focus |
| **2. Test Planning** | 20 min | Design positive, negative, accessibility, and grid scenarios | Test Designer | `filesystem`, `webfetch` | `docs/requirements/TEST-PLAN.md` | ≥10 TCs, maps to Ticket IDs, includes automation status; ≥3 ISTQB Test Design Techniques used | Balanced/Active |
| **3. Test Implementation** | 30 min | Write Playwright specs for JSON, Grid, and Print flows | SDET | `filesystem`, `playwright` | `tests/jira-102.spec.ts`, `jira-103.spec.ts`, `jira-104.spec.ts` | Uses `data-testid`, asserts UI & API behavior | Calm/Focus |
| **4. Test Execution** | 20 min | Run `npx playwright test`, fix failures | SDET | `playwright`, `cli` | `playwright-report/` | 100% pass rate, no flaky tests | Calm/Focus |
| **5. Evaluation & Reporting** | 15 min | Summarize results, track budget, propose CI/CD | Architect | `filesystem`, `webfetch` | `docs/dev/CICD-HINTS.md`, `BUDGET-LOG.md` | Pipeline defined, budget < $50, peer-reviewed; Coverage ≥80% | High/Energetic |
| **6. Debug & Diagnostics** | 10 min | Review debug logs, replay sessions, flag hallucinations | Instructor + Participant | `debugger-mode`, `prompt-history`, `hallucination-detector` | Debug findings log, corrected artifacts | All Critical bugs resolved; ≥1 hallucination flagged and corrected; memory < 80% | Balanced/Active |

## 🧭 Execution Flow & Time Management
1. **Research & Risk** (15 min) → **Resource Gate** → 2. **Design & Plan** (20 min) → 3. **Automate & Execute** (30 min) → 4. **Troubleshooting Budget** (10 min allocated per phase) → 5. **Report & Optimize** (15 min) → 6. **Debug & Diagnose** (10 min)
2. **Time Box Rule:** Each phase has a hard stop. When the instructor announces "2 minutes remaining," wrap up. When they announce "Hard stop," move to the next phase.
3. **Stuck Protocol:** If an agent fails 3 times, switch models (Sovereign → Cloud) or switch tasks (e.g., from Automation to Risk Analysis).
4. Each phase outputs a concrete artifact in `/docs/` or `/tests/`.
5. Peer review happens between Phase 2 and Phase 4.
6. Final submission requires all artifacts + budget compliance.
7. **Resource Gate (between Setup and Phase 1):** All participants pass `setup-checklist.sh` before entering Requirements Analysis. Instructor confirms ≥3 green checks per participant.
8. **Troubleshooting Time Budget:** 10 minutes per STLC phase is reserved for issue resolution. If troubleshooting exceeds 10 min, instructor escalates to pre-prepared fix (no open-ended debugging during workshop).
9. **Risk Assessment Gate (between Phase 1 and Phase 2):** Risk register exists and all risks ≥ Medium have documented mitigations.

### ⏱ Hard-Stop Enforcement
| Phase | Time | Hard-Stop Signal | If Stuck: Escalation Path | Instructor Presence | Flow State Protection |
|-------|------|------------------|---------------------------|--------------------|-----------------------|
| Phase 1: Requirements Analysis | 15 min | Instructor: "Hard stop on Phase 1!" | Switch to Phase 2; note Phase 1 items as WIP in artifact footer | Active / Circulating | No specific protection — collaborative environment |
| Phase 2: Test Planning | 20 min | Instructor: "Hard stop on Phase 2!" | Switch to Phase 3; produce Minimum Viable Test Plan (see below) | Active / Circulating | No specific protection — collaborative environment |
| Phase 3: Test Implementation | 30 min | Instructor: "Hard stop on Phase 3!" | Switch to Phase 4; write specs for highest-priority feature only | Observing / Distant | **Flow Pass system active.** No verbal interruptions. Questions go to Parking Lot. |
| Phase 4: Test Execution | 20 min | Instructor: "Hard stop on Phase 4!" | Switch to Phase 5; document which tests failed and why | Observing / Distant | **Flow Pass system active.** No verbal interruptions. Questions go to Parking Lot. |
| Phase 5: Evaluation & Reporting | 15 min | Instructor: "Hard stop on Phase 5!" | Submit whatever artifacts are complete; note remaining work | Present / Front-of-Room | Collaborative — participants present findings; high energy |
| Phase 6: Debug & Diagnostics | 10 min | Instructor: "Hard stop on Phase 6!" | Submit debug findings as WIP; continue to Showdown | Present / Front-of-Room | Collaborative — group debug review |

### 📦 Minimum Viable Artifact (MVA) per Phase
If exit criteria cannot be fully met in time, produce an MVA and list remaining items in a `## Work-In-Progress` section at the artifact's end:
- **Phase 1 MVA:** ≥3 risk categories identified; ≥1 risk documented with severity and mitigation.
- **Phase 2 MVA:** ≥5 test cases; ≥1 ISTQB technique named; test plan structure follows ISO/IEC/IEEE 29119-3 §5.3 header format.
- **Phase 3 MVA:** ≥1 Playwright spec file written; uses `data-testid`; has at least one passing assertion.
- **Phase 4 MVA:** `npx playwright test` executed at least once; results saved to `playwright-report/`.
- **Phase 5 MVA:** `BUDGET-LOG.md` has ≥5 entries; total cost estimated < $50; peer review feedback noted.
- **Phase 6 MVA:** Debug log has ≥3 entries; ≥1 hallucination flagged; memory gauge in green.

## 🚦 Test Exit Criteria (ISTQB FL v4.0 §1.3.4)

Each STLC phase has explicit exit criteria before proceeding to the next:

| Phase | Exit Criteria |
|-------|---------------|
| **Phase 1 → 2** | Risk register complete; all Critical/High risks have mitigations; ≥3 risk categories identified |
| **Phase 2 → 3** | Test plan follows ISO/IEC/IEEE 29119-3 §5.3; ≥3 ISTQB techniques applied; ≥90% forward traceability |
| **Phase 3 → 4** | All test specs written; ≥80% requirements coverage; test data prepared |
| **Phase 4 → 5** | Pass rate ≥95%; Critical defects = 0; all executed tests map to requirements |
| **Phase 5 (Final)** | Test summary complete; coverage ≥80%; budget < $50; peer review passed; judging calibrated |
| **Phase 6 (Final)** | All Critical bugs resolved; ≥1 hallucination flagged and corrected; memory < 80%; debug findings logged |

## 📊 Reporting Phase (Phase 5)
- Compile `TEST-PLAN.md` + `PLAYWRIGHT-REPORT/` into a single stakeholder summary.
- Highlight: Coverage %, Defect density, Budget spent, Risk mitigations.
- Output: `docs/requirements/STLC-SUMMARY.md`
- **Coverage Formula:** Coverage = (Number of requirements with ≥1 test case / Total requirements) × 100. Target: ≥80%.
- **Traceability Matrix:** Required. Each requirement must map to ≥1 test case (forward) and each test case must map to ≥1 requirement (backward). Target: ≥90% traceability rate.
- **Rule:** Keep report ≤ 2 pages. Use tables, not paragraphs.

---

*Every participant must navigate this STLC map to complete the workshop.*