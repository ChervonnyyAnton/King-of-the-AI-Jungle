# 📝 Filled Example: Test Plan (Gold Standard)

> **This is an example of what a high-quality Test Plan looks like. Use this as a reference.**

## 🎯 Objective
Validate the "JSON Configuration Module" (`JIRA-102.md`), "Print & Accessibility" (`JIRA-103.md`), and "Dynamic Data Grid" (`JIRA-104.md`).

## 🧪 Test Scope
- **In Scope:** `mock/index.html` (UI), JSON validation logic, Data Grid, Toast notifications.
- **Out of Scope:** Backend API (N/A in sandbox), Database persistence.

## 📋 Scenarios

| ID | Scenario Type | Description | Steps | Expected Result | Priority | Automation Status | Traceability |
|----|---------------|-------------|-------|-----------------|----------|-------------------|--------------|
| TC-01 | Positive | Valid JSON Export & Re-import | 1. Change header to "Test". 2. Click Export. 3. Import the file. | Header updates to "Test" | High | Automated | `docs/requirements/TICKETS/JIRA-102.md` |
| TC-02 | Negative | Malformed JSON Import | 1. Create a file with `{ header: "test" }` (missing quotes). 2. Click Import. | Error Toast: "Invalid JSON" | High | Automated | `docs/requirements/TICKETS/JIRA-102.md` |
| TC-03 | Edge Case | JSON with Emoji & Unicode | 1. Set body to "🌴 King of the Jungle". 2. Export/Import. | Characters are preserved exactly | Medium | Manual | `docs/requirements/TICKETS/JIRA-102.md` |
| TC-04 | Accessibility | ARIA Labels on Inputs | 1. Open NVDA/VoiceOver. 2. Focus on "Export". | Screen reader announces "Export configuration as JSON" | High | Manual | `docs/requirements/TICKETS/JIRA-102.md` |
| TC-05 | Layout | Invalid Layout Enum | 1. Import JSON with `layout: "unknown"`. 2. Update Preview. | Layout reverts to "corporate" (Default) | Medium | Automated | `docs/requirements/TICKETS/JIRA-102.md` |
| TC-06 | Grid | Enable Data Grid | 1. Toggle "Enable Data Grid". 2. Verify grid appears. | Grid component is visible | High | Automated | `docs/requirements/TICKETS/JIRA-104.md` |
| TC-07 | Grid Data | Valid JSON Grid Data | 1. Input valid JSON array. 2. Update Preview. | Grid renders with correct rows/columns | High | Automated | `docs/requirements/TICKETS/JIRA-104.md` |
| TC-08 | Grid Negative | Invalid JSON Grid Data | 1. Input invalid JSON. 2. Update Preview. | Error Toast, grid doesn't render | High | Automated | `docs/requirements/TICKETS/JIRA-104.md` |
| TC-09 | Error Sim | Simulate Failure | 1. Click "Simulate Failure". 2. Wait 1 second. | Error Toast displays, no crash | Medium | Manual | `docs/requirements/TICKETS/JIRA-104.md` |
| TC-10 | Print | Print with Grid | 1. Enable grid with data. 2. Click "Generate PDF". | Grid prints correctly on PDF | High | Manual | `docs/requirements/TICKETS/JIRA-104.md` |

## 🛠 Automation Strategy
- **Target:** `http://localhost:3000?debug=true` (Use debug mode to verify selectors).
- **Tools:** Playwright (`data-testid` selectors).
- **Runner:** `npx playwright test --project=chromium`

---

*Example created by AI Agent | Last Updated: 2024-11-10*