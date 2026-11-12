# 🔄 Review & Remediation: Cycle 143 — Mock API Response Corpus

## 🎯 Objective
Create a corpus of mock API responses in `docs/requirements/MOCK-API/` that simulate real-world JSON payloads used by the sandbox configurator and related integrations, ensuring test data contains no sensitive information.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Technical — Mock Data** | The `mock/index.html` app accepts JSON configuration via import/export, but there is no standardized mock API response corpus for participants to use in Playwright tests or SDET automation exercises. Currently, participants either invent JSON structures or copy-paste from real APIs (risking PII exposure). | **Medium** | **Engineers (D1–D4):** Need realistic JSON fixtures for Playwright E2E tests. **Architects (F1–F4):** Need API contract examples for integration design exercises. | Created `docs/requirements/MOCK-API/` directory with 5 standardized mock response files: (1) `customer-list.json` — paginated customer list; (2) `config-export.json` — sandbox config export payload; (3) `grid-data.json` — data grid fixture; (4) `error-responses.json` — standardized error payload examples; (5) `health-check.json` — mock health check response. All responses use synthetic data and include `meta` blocks with GDPR compliance markers. |

## 📂 Updated Files
- **`docs/requirements/MOCK-API/customer-list.json`**: New file — paginated synthetic customer list with 10 records.
- **`docs/requirements/MOCK-API/config-export.json`**: New file — sandbox configuration export payload matching `mock/index.html` export format.
- **`docs/requirements/MOCK-API/grid-data.json`**: New file — data grid JSON fixture with 20 rows across 4 columns.
- **`docs/requirements/MOCK-API/error-responses.json`**: New file — standardized error payload examples (validation errors, 404, 500, rate limit).
- **`docs/requirements/MOCK-API/health-check.json`**: New file — mock health check response simulating service status.
- **`docs/requirements/MOCK-API/README.md`**: New file — documentation for the mock API corpus, including usage instructions and PII-free guarantees.

## 📐 Risk Assessment
- **Risk Score:** 2 × 3 = **6** → **Medium**
- **Probability:** Possible (2) — participants may create their own test data without standardized mocks.
- **Impact:** Medium — inconsistent test data creates unreliable test results across workshop sessions.

## 🔄 R&R Rule Derivation

> **Rule DP-3 — Mock API Standardization:** All API test data must be sourced from the mock API corpus in `docs/requirements/MOCK-API/`. Each response file must include a `meta` block with `source: "mock-api-corpus"`, `generated_date`, and `pii_free: true`. Real API responses must never be used directly in workshop exercises without first passing through `scripts/pii-redact.sh`.

## 📝 Action Items
1. [ ] Verify all mock API responses are valid JSON and match the schema expected by `mock/index.html`.
2. [ ] Run `scripts/pii-redact.sh --dry-run` on each mock API response to confirm zero PII.
3. [ ] Add `docs/requirements/MOCK-API/README.md` to the participant reading list in `WORKSHOP-CHALLENGE.md`.

## 🧪 Validation
- [ ] All 5 mock API JSON files parse without errors
- [ ] `config-export.json` matches the export format from `mock/index.html`'s `exportConfig()` function
- [ ] `grid-data.json` matches the structure of `DEFAULTS.gridData` in `mock/index.html`
