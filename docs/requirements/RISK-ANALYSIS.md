<!-- Template: RISK-ANALYSIS.md -->
<!-- Created during workshop — fill in with risk assessment -->

# ⚠️ Risk Analysis — JSON Import Feature

> **Status:** Template (unfilled)
> **Created:** Workshop exercise
> **Related Tickets:** JIRA-102, JIRA-103

## Risk Register

| ID | Category | Description | Probability (1-5) | Impact (1-5) | Risk Score | Mitigation | Verification |
|----|----------|-------------|-------------------|--------------|------------|------------|--------------|
| RISK-001 | Security | XSS via crafted JSON content | 3 | 5 | 15 (High) | All grid cell content passes through escapeHtml() | Manual test with XSS payload in JSON keys/values |
| RISK-002 | Reliability | Malformed JSON crashes the app | 2 | 4 | 8 (Medium) | Try-catch around JSON.parse(), error toast | Upload malformed JSON file |
| RISK-003 | Data Privacy | PII embedded in JSON config | 3 | 3 | 9 (Medium) | Warn participants about PII; run pii-redact.sh before sharing | Review exported configs with dry-run |
| RISK-004 | Usability | No feedback during long imports | 3 | 2 | 6 (Medium) | Show loading spinner during import | Import large JSON file, verify spinner appears |

## Risk Assessment Criteria

- **Critical (16-25):** Workshop cannot run or is broken for all paths
- **High (10-15):** Specific Jungle Title is significantly hindered
- **Medium (4-9):** Quality gap or aesthetic issue
- **Low (1-3):** Cosmetic or nice-to-have

## Notes

- Probability and Impact scoring follows ISTQB FL v4.0 §1.3.6 Risk-Based Testing.
- All High+ risks must have documented mitigations before workshop deployment.
