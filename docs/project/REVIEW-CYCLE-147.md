# 🔄 Review & Remediation: Cycle 147 — Workshop-Specific PII Patterns

## 🎯 Objective
Extend the PII redaction tool (`scripts/pii-redact.sh`) with workshop-specific PII patterns that are common in QA workshop artifacts, such as Jira ticket IDs, internal test environment URLs, and browser session identifiers.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Technical — PII Detection Gaps** | `scripts/pii-redact.sh` (from Cycle 142) covers general PII (emails, phones, SSNs, credit cards) but misses workshop-specific patterns that are commonly leaked in QA artifacts: (1) Jira ticket IDs (e.g., `JIRA-12345`, `WISO-6789`); (2) Internal test environment URLs (e.g., `test-env.internal.company.com`); (3) Browser session identifiers (`JSESSIONID=...`, `connect.sid=...`); (4) API keys in test configurations. | **High** | **Engineers (D1–D4):** Playwright test traces that capture internal URLs and session cookies. **Architects (F1–F4):** System designs referencing internal architecture diagrams with real URLs. | Extended `scripts/pii-redact.sh` with a `--workshop-mode` flag that adds workshop-specific PII patterns: (1) Jira ticket ID patterns (`WISO-\d+`, `WIM-\d+`, `JIRA-\d+`); (2) Internal domain patterns (`*.internal.*`, `*.corp.*`, `*.adesso.*`); (3) Session cookie patterns; (4) API key patterns in JSON configs. Workshop mode runs by default when invoked from within the project. |

## 📂 Updated Files
- **`scripts/pii-redact.sh`**: Extended with `--workshop-mode` flag and 4 additional PII pattern categories specific to QA workshop artifacts.

## 📐 Risk Assessment
- **Risk Score:** 3 × 4 = **12** → **High**
- **Probability:** Likely (3) — workshop artifacts (screenshots, exported configs, test traces) frequently contain internal URLs and ticket IDs.
- **Impact:** High — internal URLs and Jira IDs, while not PII in the traditional sense, can expose organizational structure and project information to unauthorized parties.

## 🔄 R&R Rule Derivation

> **Rule DP-7 — Workshop-Specific PII Redaction:** When any artifact originates from an internal system (Jira, Confluence, test environment, CI/CD dashboard), it MUST be processed through `scripts/pii-redact.sh --workshop-mode` before being included in workshop materials. This redacts internal URLs, Jira ticket IDs, session identifiers, and API keys. The workshop mode is the default mode when the script is run from within the workshop project directory.

## 📝 Action Items
1. [ ] Test `--workshop-mode` against a sample Jira export containing ticket IDs and internal URLs.
2. [ ] Update the PII redaction CLI help text to document workshop-specific patterns.
3. [ ] Add a note in `WORKSHOP-CHALLENGE.md` instructing participants to use `--workshop-mode` when importing Jira data.

## 🧪 Validation
- [ ] `scripts/pii-redact.sh --workshop-mode --dry-run` correctly identifies Jira ticket patterns
- [ ] Internal URLs (test-env.internal, *.corp, *.adesso) are redacted in workshop mode
- [ ] Session cookie patterns are detected and redacted
