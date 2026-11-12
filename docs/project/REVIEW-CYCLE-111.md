# 🔄 Review & Remediation: Cycle 111 — Artifact Validation: TEST-PLAN.md Structure

## 🎯 Objective
Create automated artifact validation infrastructure by designing the core `validate-artifacts.sh` script and defining the TEST-PLAN.md structural validation checks that enforce ISO/IEC/IEEE 29119-3 compliance and ISTQB technique diversity.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Technical** | No automated script exists to validate workshop artifacts against R&R rules. Manual cycle reviews are the only mechanism for checking TEST-PLAN.md structure and ISTQB technique diversity. | **High** | **Engineer paths (D/E):** Engineers need automated validation to catch non-compliant test plans before submitting artifacts. Without it, the ISTQB technique diversity requirement (Rule 10.3) can only be checked manually. | Created `scripts/validate-artifacts.sh` with a `--test-plan` mode that checks: (1) ISO 29119-3 required sections, (2) ≥3 ISTQB techniques, (3) test case count, (4) traceability links to tickets. |
| **Documentation** | Rule 10.3 mandates ≥3 ISTQB techniques but has no automated verification — the rule is "paper-only" until a script exists. | **Medium** | **All Paths:** Participants cannot self-validate their test plan structure before submission. | Added ISTQB technique counting function (`count_istqb_techniques`) to `validate-artifacts.sh` that recognizes all 5 standard techniques. |

## 📂 Updated Files
- **`scripts/validate-artifacts.sh`**: Created — core validation script with `validate_test_plan()` function implementing Cycle 111 checks.
- **`AGENTS.md`**: Not modified — the script is a tool artifact, not a prompt template.

## 📐 Risk Assessment
- **Risk Score:** 3 × 4 = **12** → **High**
- **Probability:** Likely (3) — manual-only validation means non-compliant artifacts will be missed.
- **Impact:** High — without automated checks, ISTQB technique diversity gaps go undetected until the judging phase.

## 🔄 R&R Rule Derivation
This cycle derives a new rule in the upcoming **Section 25** (CI/CD Pipeline & Automated Artifact Grading):

> **Rule CA-1 — Artifact Validation Script:** A shell script (`scripts/validate-artifacts.sh`) must exist that validates TEST-PLAN.md against ISO/IEC/IEEE 29119-3 section requirements and ISTQB technique diversity (≥3 techniques). The script must be run as part of the self-healing protocol before artifact submission.

> **Rule CA-2 — Required Sections:** Every TEST-PLAN.md must contain: Identifier, Title, Introduction, Test Items, Features to test, Approach, Test Environment, Schedule, Deliverables, Risks, and Approval — matching ISO/IEC/IEEE 29119-3 §5.3.

## 📝 Action Items
1. [ ] Test `scripts/validate-artifacts.sh --test-plan` against an existing TEST-PLAN.md.
2. [ ] Add CI pipeline job to run artifact validation on every push.
3. [ ] Document the validation script in AGENTS.md as part of the engineer workflow.
4. [ ] Verify ISTQB technique counting recognizes all 5 standard techniques.

## 🧪 Validation
- [ ] Script is executable and runs without errors
- [ ] All required ISO 29119-3 sections are checked
- [ ] ISTQB technique diversity counting works correctly
- [ ] Traceability link detection functions properly
