<!-- Template: TEST-PLAN.md -->
<!-- Created during workshop — fill in with test cases -->

# 📋 Test Plan — JIRA-102: JSON Import Feature

> **Status:** Template (unfilled)
> **Created:** Workshop exercise
> **Related Tickets:** JIRA-102, JIRA-103

## Scope

- [ ] Import valid JSON configuration
- [ ] Reject invalid JSON with error toast
- [ ] Handle empty file upload
- [ ] Validate field types after import

## Test Cases

| ID | Title | Precondition | Steps | Expected Result | Severity |
|----|-------|-------------|-------|-----------------|----------|
| TC-001 | Valid JSON import | App is running | 1. Click "Import JSON" 2. Select valid config file 3. Confirm | Configuration loads, toast shows success | High |
| TC-002 | Invalid JSON rejection | App is running | 1. Click "Import JSON" 2. Select malformed JSON file 3. Confirm | Error toast shown, app remains stable | High |
| TC-003 | Empty file handling | App is running | 1. Click "Import JSON" 2. Select empty file 3. Confirm | Warning toast shown | Medium |
| TC-004 | Type mismatch handling | App is running with valid JSON containing wrong types | 1. Import JSON 2. Check field types | Fields with type mismatches get defaults, warning toast | Medium |

## Notes

- Use seed data from `mock/index.html` DEFAULTS.gridData for consistent test inputs.
- Validate with checksum: run `computeChecksum()` before and after import.
