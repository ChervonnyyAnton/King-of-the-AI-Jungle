# 🔄 Test Data Lifecycle Management Guide

## Overview

This guide defines the lifecycle management policy for all synthetic and mock data used in the King of the AI Jungle workshop. It covers creation, storage, versioning, cleanup, and retention — implementing the data minimization principle (GDPR Article 5(1)(c)).

---

## 1. Creation

All test data must be generated using **approved tools only**. Manual data entry is permitted only for simple placeholder values.

### Approved Tools

| Tool | Purpose | Command |
|------|---------|---------|
| `scripts/gen-synthetic-data.sh` | Generate synthetic customer records | `scripts/gen-synthetic-data.sh 10 --output data.json` |
| `docs/requirements/MOCK-API/` corpus | Use pre-built mock API responses | Copy desired file to test fixtures |
| `mock/index.html` DEFAULTS | Use the app's built-in seed data | No command — data is embedded |

### Creation Rules

1. **Only use synthetic data** — never real customer data, employee records, or production data.
2. **Include a `meta` block** in every generated dataset with: `generated_by`, `generation_timestamp`, and `gdpr_compliant: true`.
3. **Generate the minimum amount of data** needed for the exercise (data minimization).
4. **Validate generated data** using `scripts/gen-synthetic-data.sh --validate <file>`.

---

## 2. Storage

Synthetic data must be stored in **designated directories only**:

| Directory | Contents | Cleanup Policy |
|-----------|----------|----------------|
| `docs/requirements/MOCK-API/` | Workshop-approved mock API responses | **NEVER** — these are workshop artifacts |
| `tests/fixtures/` | Test fixtures for Playwright exercises | 30 days (via `cleanup-test-data.sh`) |
| `docs/tools/temp-data/` | Temporary data for instructor exercises | 30 days (via `cleanup-test-data.sh`) |

### Storage Rules

1. **No synthetic data** may be stored in `docs/agent-logs/` (agent output directory) unless explicitly needed for a cycle log.
2. **No synthetic data** may be stored in `.vscode/`, `node_modules/`, or other tooling directories.
3. **File naming convention:** `<purpose>-<date>-<version>.json` (e.g., `customer-list-2026-11-10-v1.json`).

---

## 3. Versioning

Every synthetic dataset must include version information to enable traceability:

```json
{
  "meta": {
    "version": "1.0.0",
    "generated_by": "gen-synthetic-data.sh v2.0.0",
    "generation_timestamp": "2026-11-10T12:00:00Z",
    "gdpr_compliant": true,
    "schema_version": "1.0"
  }
}
```

### Versioning Rules

1. **Major version** (1.0 → 2.0): Schema changes (new fields, renamed fields).
2. **Minor version** (1.0 → 1.1): New records added, existing records unchanged.
3. **Patch version** (1.0.0 → 1.0.1): Record content changes only.
4. **Track version changes** in `BUDGET-LOG.md` when updating mock API corpus files.

---

## 4. Cleanup

Stale test data must be removed to maintain data minimization and prevent schema drift.

### Cleanup Procedure

```bash
# Dry run: see what would be deleted
scripts/cleanup-test-data.sh --dry-run

# Actual cleanup: remove files older than 30 days
scripts/cleanup-test-data.sh --in-place

# Custom retention period (e.g., 14 days)
scripts/cleanup-test-data.sh --in-place --days 14
```

### Cleanup Rules

1. **Run cleanup at the end of each workshop session.**
2. **The mock API corpus is excluded from cleanup** (it is a workshop artifact, not exercise data).
3. **Archived data** can be moved to `docs/requirements/MOCK-API/archive/` for reference.
4. **Never delete** files with `meta.pii_free: true` from the mock API corpus.

---

## 5. Retention

### Retention Periods

| Data Type | Retention | Rationale |
|-----------|-----------|-----------|
| Workshop synthetic data | 30 days post-workshop | Enough for post-workshop review and evaluation |
| Mock API corpus | Indefinite | Workshop artifact — always needed for exercises |
| Agent-generated test data | 30 days | Part of agent session output; reviewed and archived |

### Retention Rules

1. **After 30 days**, synthetic data is considered stale and must be deleted.
2. **Before deletion**, verify the data is not referenced in any active cycle log.
3. **For data retention beyond 30 days**, obtain instructor approval and document the reason.
4. **Deletion is secure**: files are permanently removed (not moved to trash/recycle bin).

---

## 6. Validation

All synthetic data must pass validation before being used in workshop exercises:

```bash
# Validate a dataset
scripts/gen-synthetic-data.sh --validate data.json

# Validate mock API schema
scripts/validate-mock-schema.sh docs/requirements/MOCK-API/
```

### Validation Criteria

1. **Email domains** must be from the approved synthetic list.
2. **IDs** must follow the `PREFIX-NNNN` format.
3. **Phone numbers** must match the synthetic pattern `+1-555-XXXX`.
4. **Names** must follow realistic but fictional patterns.
5. **JSON structure** must match the expected schema for the target use case.

---

## 7. Compliance

This lifecycle guide implements the following GDPR and R&R rules:

| Rule | Reference | Implementation |
|------|-----------|----------------|
| Data Minimization | GDPR Art. 5(1)(c) | Only necessary data generated and stored |
| PII Protection | R&R Rule SEC-5 / DP-1 | Synthetic data only, no real PII |
| Data Residency | R&R Rule DP-4 | Local storage only, no cloud transmission |
| Consent | R&R Rule DP-5 | Participant consent form required |
| Synthetic Data Validation | R&R Rule DP-6 | `gen-synthetic-data.sh --validate` |
| PII Redaction | R&R Rule DP-2, DP-7 | `pii-redact.sh` with workshop mode |
| Mock API Standards | R&R Rule DP-3 | Standardized corpus in MOCK-API/ |
| Mock Schema Validation | R&R Rule DP-9 | `validate-mock-schema.sh` |
| Lifecycle Management | R&R Rule DP-8 | This document |
| Data Minimization | R&R Rule DP-10 | Export filtering, artifact sanitization |

---

*This guide is derived from R&R Cycles 141–150 (Data Privacy & Synthetic Data Generation domain).*
