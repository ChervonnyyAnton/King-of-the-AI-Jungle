# 🎫 JIRA-102: JSON Configuration Module

**Status:** In Progress  
**Priority:** Medium  
**Component:** `mock/index.html`  
**Dependencies:** JIRA-101  
**Sprint:** Sprint 2  
**Test Case ID:** TC-102-001 through TC-102-004  

---

## 📝 Description
Implement the ability to export current document settings as a JSON file and import them back to restore the state.

## 🎯 Acceptance Criteria
1. **Export:** Clicking "Export" downloads a `.json` file with current values.
2. **Import:** Clicking "Import" parses a JSON file and updates the UI fields.
3. **Validation:** Importing a malformed JSON file must show a clear error message without crashing the app.
4. **Special Characters:** Importing JSON with emojis, accented letters, and Unicode characters preserves them correctly through export/import cycles.

## 🔗 Test Preconditions
- JIRA-101 (Initial Setup) is complete and the app is running via `npx serve mock/`.
- Browser developer tools are available for inspecting network requests.

## 📋 Test Steps (TC-102-001: Happy Path Export/Import)
1. Modify the header text to "Test Export".
2. Modify the body text to "Test Body".
3. Click "Export JSON" button.
4. Verify a `.json` file is downloaded.
5. Open the downloaded file and verify header="Test Export", body="Test Body".
6. Reset header to default "Sandbox Project Report".
7. Click "Import JSON" and select the downloaded file.
8. Verify header is restored to "Test Export" and body to "Test Body".

## 🎯 Expected Results
1. File downloads immediately.
2. UI fields update to reflect the imported values.
3. Error toast appears with clear message (e.g., "Invalid JSON syntax").
4. All Unicode characters (emojis, äöü, ß, etc.) appear correctly after export/import.

## 📋 Test Steps (TC-102-002: Malformed JSON)
1. Create a file `invalid.json` containing `{ header: "unclosed string`.
2. Click "Import JSON" and select `invalid.json`.
3. Verify the app does not crash.

## 🎯 Expected Results (TC-102-002)
1. Error toast displays "Invalid JSON".
2. All existing UI fields retain their pre-import values.

## 🔗 Traceability
- **Parent Requirement:** JSON Configuration (WORKSHOP-CHALLENGE.md § Step 1)
- **Test Plan:** `docs/requirements/TEST-PLAN.md` → TC-102-001 through TC-102-004
- **Related Tickets:** JIRA-101 (Setup), JIRA-104 (Grid — gridData in export)

