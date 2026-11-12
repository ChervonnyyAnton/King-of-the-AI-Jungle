# 📊 Mock API Response Corpus

## Overview

This directory contains **mock API response files** for the King of the AI Jungle workshop. All responses use **synthetic data only** and are designed for testing the sandbox configurator (`mock/index.html`) and Playwright automation exercises.

> **All data in this corpus is fictitious.** No real customer information, email addresses, or organizational data is included.

---

## Files

| File | Description | Used By |
|------|-------------|---------|
| `customer-list.json` | Paginated synthetic customer list (10 records) | Playground: API testing, data grid exercises |
| `config-export.json` | Sandbox config export (matches `exportConfig()` format) | Playground: JSON import/export testing |
| `grid-data.json` | Data grid fixture (20 rows, 4 columns) | Playground: Data Grid rendering, pagination |
| `error-responses.json` | Standardized error payloads (400, 404, 429, 500) | Playground: Error handling, Playwright assertions |
| `health-check.json` | Mock health check response | Playground: Service status, feature flags |

---

## Usage

### In Playwright Tests

```typescript
// Import a mock response from this corpus
import customerList from '../../docs/requirements/MOCK-API/customer-list.json';

// Use in your test
test('verify customer list schema', async ({ page }) => {
  expect(customerList.meta.source).toBe('mock-api-corpus');
  expect(customerList.meta.pii_free).toBe(true);
  expect(customerList.data).toHaveLength(10);
});
```

### In Manual Exercises

1. Copy a file from this directory into `mock/` or your test fixtures folder.
2. Use `⬆ Import JSON` in the sandbox configurator to load it.
3. Verify the UI renders correctly (header, body, footer, grid).

### Validation

After any change to `mock/index.html`, validate the corpus:

```bash
scripts/validate-mock-schema.sh docs/requirements/MOCK-API/
```

---

## PII-Free Guarantee

Every file in this corpus includes:

- A `meta` block with `pii_free: true`
- Synthetic email addresses using approved domains only (`@jungle.test`, `@sandbox.dev`, etc.)
- Fictional names in the "Jane Doe" / "John Smith" pattern family
- Synthetic phone numbers using the `+1-555-XXXX` format
- No real addresses, SSNs, credit card numbers, or organizational identifiers

If you find PII in any mock file, **do not use it** — run `scripts/pii-redact.sh --in-place <file>` to fix it, or regenerate with `scripts/gen-synthetic-data.sh`.

---

## Schema Validation

All mock responses are validated against the sandbox configurator's export/import contract (defined in `mock/index.html`'s `exportConfig()` and `importConfig()` functions). Run the validator:

```bash
scripts/validate-mock-schema.sh docs/requirements/MOCK-API/
```

---

## Data Minimization

These mock files contain the **minimum data required** for workshop exercises. Do not add unnecessary fields (e.g., full address history, social security numbers, financial data) — this would violate the data minimization principle (GDPR Article 5(1)(c)).

---

## Lifecycle

- **Created:** Cycles 141–150 (Data Privacy domain)
- **Last validated:** Run `scripts/validate-mock-schema.sh` after any `mock/index.html` change
- **Retention:** These are workshop artifacts — they are **excluded** from the cleanup script
- **Archive:** If deprecated, move to `docs/requirements/MOCK-API/archive/` with a deprecation note
