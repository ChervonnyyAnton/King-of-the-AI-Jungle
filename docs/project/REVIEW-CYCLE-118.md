# 🔄 Review & Remediation: Cycle 118 — Artifact Validation: Coverage Threshold Gate

## 🎯 Objective
Design and document the coverage threshold gate — ensuring the CI pipeline fails if test coverage drops below 80%, and configuring the infrastructure for coverage enforcement.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Technical** | `playwright.config.js` has no coverage reporter configured. The `playwright test` command can produce coverage, but the config needs `report: [['html'], ['lcov']]` to generate parseable coverage data. Without this, the coverage gate cannot function. | **High** | **Engineer paths (D/E):** Engineers are judged on code quality including coverage. Without coverage reporting, there is no data to validate against the ≥80% threshold. | Designed `validate_coverage_gate()` function in `scripts/validate-artifacts.sh` that: (1) checks for coverage gate job in CI pipeline, (2) verifies playwright config includes coverage reporter, (3) checks for coverage data availability. The gate will enforce ≥80% threshold once reporters are added. |
| **Technical** | The CI pipeline template has no `coverage-gate` or `coverage-threshold` job. The coverage threshold from Gate 6 (Section 3) is not enforced by CI. | **High** | **All Paths:** Coverage below 80% means requirements are not adequately tested. Without a CI gate, this is invisible to participants until the judging phase. | The `validate_coverage_gate()` function explicitly checks for the coverage gate job in the CI file and reports whether it exists. This establishes the baseline for remediation. |

## 📂 Updated Files
- **`scripts/validate-artifacts.sh`**: Extended — added `validate_coverage_gate()` function with coverage gate job detection and playwright config reporter check.

## 📐 Risk Assessment
- **Risk Score:** 4 × 4 = **16** → **Critical**
- **Probability:** Certain (4) — without coverage reporters, the gate is unenforceable.
- **Impact:** High — sub-80% coverage is a Gate 6 violation per Rule 10.4.

## 🔄 R&R Rule Derivation
This cycle reinforces rules from Cycles 113 and 117 and adds:

> **Rule CTG-1 — Coverage Reporter Configuration:** `playwright.config.js` must include coverage reporters (at minimum `lcov` for machine parsing). The `validate_coverage_gate()` function verifies this.

> **Rule CTG-2 — Coverage Gate CI Job:** A `coverage-gate` job must exist in the CI pipeline that: (a) runs tests with coverage, (b) parses coverage percentage, (c) fails if <80%. The job should run in the test or security stage.

## 📝 Action Items
1. [ ] Update `playwright.config.js` to add `report: [['html'], ['lcov']]`.
2. [ ] Run `npx playwright test` to generate initial coverage data.
3. [ ] Add `coverage-gate` job to `docs/ci/CI-PIPELINE-TEMPLATE.yml`.
4. [ ] Update `scripts/validate-artifacts.sh` to parse the generated coverage data automatically.
5. [ ] Document coverage requirements in AGENTS.md engineer prompts.

## 🧪 Validation
- [ ] `playwright.config.js` includes lcov reporter
- [ ] Coverage data generated on test run
- [ ] `validate_coverage_gate()` correctly identifies missing coverage gate job
- [ ] ≥80% threshold enforcement is documented
