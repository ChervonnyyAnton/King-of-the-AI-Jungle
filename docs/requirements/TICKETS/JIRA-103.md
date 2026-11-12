# 🎫 JIRA-103: Print & Accessibility Optimization

**Project:** Sandbox PDF Generator  
**Issue Type:** Story  
**Priority:** High  
**Assignee:** QA Team  
**Status:** To Do  

---

## 📝 Description
Ensure the "Preview" pane differs from the "Print" pane. The Preview should look like a desktop app, while the Print view must be optimized for A4 paper and accessibility standards.

## 🎯 Acceptance Criteria
1. **CSS Media Queries:** `@media print` must hide the sidebar and remove shadows.
2. **Formatting:** Print margins must match `@page { margin: 20mm; }`.
3. **Accessibility:** All UI inputs must have `aria-label`. Print view must pass WCAG 2.1 AA contrast ratios.
4. **Empty State:** Printing when empty must show toast error and abort.
5. **Overflow:** Long text must wrap correctly without breaking layout.

## 🧪 QA Notes
- Verify `data-testid` attributes exist for Playwright automation.
- Check print output in Chrome, Firefox, and Safari.
- Test with screen reader (VoiceOver/NVDA) in Preview mode.

---

*Created by AI Agent during Workshop*
