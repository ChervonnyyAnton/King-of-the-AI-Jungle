# 🔄 Review & Remediation: Cycle 146 — Synthetic Data Validation Rules

## 🎯 Objective
Establish validation rules for synthetic data to ensure generated test data is always distinguishable from real data and meets quality criteria for workshop exercises.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Technical — Synthetic Data Quality** | The synthetic data generator (`scripts/gen-synthetic-data.sh`) creates fake records, but there is no automated validation to verify that generated data meets the "synthetic data quality criteria": (1) no real domain emails; (2) no sequential real-world patterns; (3) clear synthetic markers. Without validation, participants might modify the generator and accidentally introduce real data. | **Medium** | **Engineers (D1–D4):** Synthetic test data that passes validation but contains subtle real-world patterns could be flagged as suspicious by compliance tools. **Scouts (A1–A4):** Manual review of synthetic data without validation rules leads to inconsistent quality. | Extended `scripts/gen-synthetic-data.sh` with a `--validate` flag that runs a validation suite against generated data. The validator checks: (1) All email domains are from the approved synthetic list (@jungle.test, @sandbox.dev, @workshop.local); (2) No phone numbers match real-world format patterns; (3) All IDs follow the synthetic pattern (prefix-NNNN); (4) Names contain at least one clearly fictional element. Failed validation produces a red report listing violations. |

## 📂 Updated Files
- **`scripts/gen-synthetic-data.sh`**: Added `--validate` flag and validation functions that check email domains, ID patterns, phone formats, and name fictionality. Generates a validation report with pass/fail per record.

## 📐 Risk Assessment
- **Risk Score:** 2 × 3 = **6** → **Medium**
- **Probability:** Possible (2) — participants modifying the generator may introduce real data patterns.
- **Impact:** Medium — synthetic data that looks real defeats the purpose of synthetic data generation.

## 🔄 R&R Rule Derivation

> **Rule DP-6 — Synthetic Data Validation:** Every synthetic dataset used in workshop exercises must pass validation via `scripts/gen-synthetic-data.sh --validate`. Validation criteria: (1) All email addresses use approved synthetic domains only; (2) All IDs follow the format `PREFIX-NNNN` (e.g., `CUST-0001`, `EMP-1234`); (3) All names contain at least one fictional element (e.g., "Jane Doe", "John Smith" patterns); (4) No phone numbers match real-world format patterns. Datasets failing validation must be regenerated and never used in workshop exercises.

## 📝 Action Items
1. [ ] Run `scripts/gen-synthetic-data.sh 20 --validate` and verify all 20 records pass validation.
2. [ ] Test the validator against known bad data (e.g., a CSV with real email addresses) to confirm it detects violations.
3. [ ] Add validation to the pre-commit hook: auto-validate synthetic data files in `docs/requirements/MOCK-API/`.

## 🧪 Validation
- [ ] `scripts/gen-synthetic-data.sh --validate` returns 0 exit code for valid synthetic data
- [ ] Validator correctly rejects datasets containing real email domains
- [ ] Validation report is human-readable and actionable
