# 🔄 Review & Remediation: Cycle 142 — PII Redaction CLI Tool

## 🎯 Objective
Address the gap in automated PII detection and redaction — participants currently rely on manual redaction when handling artifacts that may contain PII (e.g., screenshots of real Jira tickets, copied customer emails).

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Technical — PII Detection** | The `AGENTS.md` Data Privacy section (§Data Privacy & PII Protection) describes what PII is and provides a redaction example, but there is no automated tool to detect and redact PII from text files before they are committed or shared. Participants must manually identify and redact PII — a high-friction, error-prone process. | **High** | **Engineers (D1–D4):** SDET tests that capture real user data in Playwright screenshots. **Architects (F1–F4):** System designs referencing real organizational structures. | Created `scripts/pii-redact.sh` — a lightweight CLI tool that scans files for common PII patterns (email addresses, phone numbers, SSN-like patterns, full names with titles, credit card numbers) and replaces them with safe placeholders. Supports dry-run mode (`--dry-run`) and in-place redaction (`--in-place`). |

## 📂 Updated Files
- **`scripts/pii-redact.sh`**: New file — PII detection and redaction CLI tool with regex-based pattern matching for emails, phones, SSNs, credit cards, and common name patterns.
- **`AGENTS.md`**: Updated "Data Privacy & PII Protection" section to reference `scripts/pii-redact.sh` as the recommended redaction tool.

## 📐 Risk Assessment
- **Risk Score:** 3 × 4 = **12** → **High**
- **Probability:** Likely (3) — workshop artifacts (screenshots, copied tickets, exported configs) may contain PII.
- **Impact:** High — PII in committed files creates a persistent data leak and violates GDPR.

## 🔄 R&R Rule Derivation

> **Rule DP-2 — PII Redaction Gate:** Before committing any artifact that may contain participant data, screenshots, or copied content, run `scripts/pii-redact.sh --dry-run <file>` to check for PII. If PII is detected, run `scripts/pii-redact.sh --in-place <file>` to redact it. This gate applies to all Markdown files in `docs/`, test fixtures in `tests/`, and exported configurations in `mock/`. Artifacts with unresolved PII findings must NOT be committed.

## 📝 Action Items
1. [ ] Run `scripts/pii-redact.sh --dry-run AGENTS.md` to verify no false positives in workshop documentation.
2. [ ] Add `scripts/pii-redact.sh` to the pre-commit hook or developer workflow documentation.
3. [ ] Create a VS Code snippet (`pii-redact.json`) for quick PII redaction of selected text.

## 🧪 Validation
- [ ] `pii-redact.sh` is executable and produces correct redaction patterns
- [ ] Dry-run mode does not modify files
- [ ] Workshop Stability Check — redaction tool does not modify non-PII content
