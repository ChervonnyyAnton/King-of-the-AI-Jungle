# 🎫 JIRA-103: Print & PDF Optimization

**Status:** To Do  
**Priority:** High  
**Component:** `mock/index.html`  
**Dependencies:** JIRA-101  
**Sprint:** Sprint 2  
**Test Case ID:** TC-103-001 through TC-103-003  
**Target Date:** Sprint 2, Day 3  

---

## 📝 Description
Ensure the "Preview" pane looks different from the "Print" pane. The Preview should look like a desktop app, while the Print view should be optimized for A4 paper.

## 🎯 Acceptance Criteria
1. **Sidebar Hidden in Print:** When generating a PDF/print, the sidebar is not visible in the output.
2. **A4 Margins:** Page margins match A4 paper specifications (210mm × 297mm).
3. **Background Colors:** Background colors do not print unless explicitly set via `@media print` rules.
4. **Content Fits Page:** Header, body, and footer content fits within the printable area without overflow or cut-off.

## 🔗 Test Preconditions
- JIRA-101 (Initial Setup) is complete.
- JIRA-102 (JSON Config) is complete (to ensure export/import works alongside print).
- A PDF viewer or browser print preview is available.

## 📋 Test Steps (TC-103-001: Print Layout)
1. Set header, body, and footer with substantial text content.
2. Click "Generate PDF" or use browser Print preview (Ctrl+P / Cmd+P).
3. Verify the sidebar is not visible in the print preview.
4. Verify margins are appropriate for A4 paper.

## 🎯 Expected Results (TC-103-001)
1. Sidebar is absent from print preview.
2. Content fits within A4 margins with adequate white space.
3. Background colors from sidebar are not printed.
4. All content is readable and on one or more pages without overflow.

## 📋 Test Steps (TC-103-002: Background Colors)
1. Set a dark background color on the body.
2. Open Print preview.
3. Verify background color is white (or the print-specific color).

## 🎯 Expected Results (TC-103-002)
1. Print output has a white/light background.
2. Text remains readable (contrast ratio ≥ 4.5:1 per WCAG 2.1).

## 🔗 Traceability
- **Parent Requirement:** PDF Output (WORKSHOP-CHALLENGE.md § Step 1)
- **Test Plan:** `docs/requirements/TEST-PLAN.md` → TC-103-001 through TC-103-003
- **Related Tickets:** JIRA-101 (Setup), JIRA-104 (Grid — grid in print)

