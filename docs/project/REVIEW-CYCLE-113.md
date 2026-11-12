# 🔄 Review & Remediation: Cycle 113 — Artifact Validation: Playwright Coverage Gates

## 🎯 Objective
Design and implement Playwright code coverage gate validation — ensuring the CI pipeline fails if test coverage drops below 80%, and configuring coverage reporting infrastructure.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Technical** | `playwright.config.js` exists but has no coverage reporter configured (no HTML, lcov, or JSON reporters). The coverage directory and `coverage/lcov.info` file do not exist yet. Without coverage reporting, the ≥80% threshold from Rule 10.4 / Gate 6 cannot be enforced. | **High** | **Engineer paths (D/E):** Engineers are judged on code quality and coverage. Without coverage enforcement in CI, there is no automated gate preventing sub-80% coverage submissions. | Added `validate_coverage()` and `validate_coverage_gate()` functions to `scripts/validate-artifacts.sh`. Coverage validation: (1) checks for lcov.info, (2) parses coverage percentage, (3) enforces ≥80% threshold, (4) verifies playwright config includes coverage reporter. |
| **Technical** | The CI pipeline template (`docs/ci/CI-PIPELINE-TEMPLATE.yml`) has no coverage gate job. All 4 required stages exist (lint, security, test, report) but none validate coverage metrics. | **High** | **All Paths:** Without a CI coverage gate, sub-80% coverage tests pass silently. This violates Gate 6 of the Quality Gates framework. | Designed coverage gate job structure for the CI pipeline (documented in the script's `validate_coverage_gate()` function). The script checks for coverage gate job existence in the CI file. |

## 📂 Updated Files
- **`scripts/validate-artifacts.sh`**: Extended — added `validate_coverage()` (parses lcov.info, enforces ≥80% threshold, verifies config reporter) and `validate_coverage_gate()` (checks CI pipeline for coverage gate job).

## 📐 Risk Assessment
- **Risk Score:** 4 × 4 = **16** → **Critical**
- **Probability:** Certain (4) — without coverage reporting configured, the threshold is unenforceable.
- **Impact:** High — sub-80% coverage means requirements are not adequately tested, violating Gate 6.

## 🔄 R&R Rule Derivation
This cycle derives rules for the upcoming **Section 25**:

> **Rule CIG-1 — Coverage Reporting Configuration:** Playwright must be configured with a coverage reporter (HTML or lcov) in `playwright.config.js`. Without a reporter, coverage data cannot be generated.

> **Rule CIG-2 — Coverage Threshold Enforcement:** The CI pipeline must include a coverage gate job that fails if coverage is below 80%. The threshold is defined in Section 3 (Quality Gates, Gate 6).

> **Rule CIG-3 — Coverage Gate Job in CI:** A dedicated `coverage-gate` or `coverage-threshold` job must exist in the CI pipeline (Stage 2: security or Stage 3: test) that parses coverage data and fails on <80%.

## 📝 Action Items
1. [ ] Update `playwright.config.js` to include lcov and HTML reporters.
2. [ ] Run tests once to generate initial coverage data.
3. [ ] Add `coverage-gate` job to `docs/ci/CI-PIPELINE-TEMPLATE.yml`.
4. [ ] Document coverage reporting requirements in AGENTS.md engineer prompts.

## 🧪 Validation
- [ ] `playwright.config.js` includes coverage reporters
- [ ] `validate_coverage()` correctly parses lcov.info
- [ ] ≥80% threshold is enforced
- [ ] Coverage gate job exists in CI pipeline template
