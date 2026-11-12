# 🔄 Review & Remediation: Cycle 149 — Mock API Response Schema Validation

## 🎯 Objective
Add schema validation to the mock API responses in `docs/requirements/MOCK-API/` to ensure all mock payloads conform to the expected JSON structure for the sandbox configurator, preventing schema drift between mock data and the app.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Technical — Schema Drift** | The mock API responses in `docs/requirements/MOCK-API/` (from Cycle 143) define JSON structures but have no schema validation. If `mock/index.html`'s configuration structure changes (e.g., new fields added to `DEFAULTS`), the mock responses will silently drift out of sync. Participants using outdated mock data will encounter import failures or incorrect rendering. | **Medium** | **Engineers (D1–D4):** Playwright tests that import mock config files expecting specific fields. When fields are missing, tests fail with misleading errors. **Scouts (A1–A4):** Manual JSON import fails because mock data doesn't match current app schema. | Created `scripts/validate-mock-schema.sh` — a bash script that validates all mock API responses against the schema defined by `mock/index.html`'s `exportConfig()` function. The script checks: (1) Required fields (`meta`, `header`, `body`, `footer`, `layout`, `gridEnabled`, `gridData`); (2) Field types (string, boolean, array); (3) Layout enum values (corporate, startup, clean); (4) Grid data is a non-empty array with consistent keys. Outputs a validation report per file. |

## 📂 Updated Files
- **`scripts/validate-mock-schema.sh`**: New file — schema validation script that checks mock API responses against the sandbox configurator's export/import contract.
- **`docs/requirements/MOCK-API/README.md`**: Updated to include schema validation instructions and pass/fail status for each mock file.

## 📐 Risk Assessment
- **Risk Score:** 2 × 3 = **6** → **Medium**
- **Probability:** Possible (2) — schema drift occurs when the app is updated without regenerating mock data.
- **Impact:** Medium — invalid mock data causes test failures and participant confusion.

## 🔄 R&R Rule Derivation

> **Rule DP-9 — Mock Schema Validation:** After any change to `mock/index.html`'s configuration structure, run `scripts/validate-mock-schema.sh` to verify all mock API responses conform to the updated schema. If any mock file fails validation, regenerate it using `scripts/gen-synthetic-data.sh` or manually update it to match. Mock files that fail schema validation must NOT be used in workshop exercises.

## 📝 Action Items
1. [ ] Run `scripts/validate-mock-schema.sh` against the existing mock API corpus and verify all files pass.
2. [ ] Add schema validation to the CI pipeline (the `csp-audit` stage's sibling).
3. [ ] Document the schema validation workflow in `docs/tools/TEST-DATA-LIFECYCLE-GUIDE.md`.

## 🧪 Validation
- [ ] `scripts/validate-mock-schema.sh` correctly validates `config-export.json` against `mock/index.html`'s export format
- [ ] Schema validator detects missing required fields
- [ ] Schema validator reports clear error messages for type mismatches
