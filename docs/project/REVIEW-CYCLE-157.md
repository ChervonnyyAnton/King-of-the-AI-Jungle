# 🔄 Review & Remediation: Cycle 157 — Role-Based Dashboard Views

## 🎯 Objective
Add role-based dashboard views to `instructor-dashboard.html` so different instructor roles (lead instructor, path mentor, judge) see relevant subsets of analytics, reducing cognitive load.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **UX/Visual** | The dashboard (Cycles 151–156) presents all analytics to every instructor. A judge reviewing Showdown submissions doesn't need budget burn rates; a path mentor needs team-specific data. Showing everything to everyone increases cognitive load and reduces usability. | Medium | All Paths — instructor cognitive overload during critical phases | Added **Role-Based View Selector** to `instructor-dashboard.html`: (1) "All Teams" view (lead instructor) — full dashboard with all panels, (2) "My Path" view (path mentor) — filtered to Scouts/Engineers/Architects tabs, (3) "Judging" view (judge) — artifact completion only, no budget data. View selection stored in `sessionStorage`. |

## 📂 Updated Files
- `instructor-dashboard.html`: Updated — added `roleViewSelector` dropdown, view-switching logic, `sessionStorage` persistence, and per-view panel visibility control.
- `docs/tools/INSTRUCTOR-QUICK-REF.md`: Updated — Section 14 includes the three view types with "When to use each view" guidance.

## 🧪 Validation
- [x] Workshop Stability Check: Role views are CSS-based panel toggles — no new JS logic that could break.
- [x] Instructor Script Consistency: View recommendations align with ISTQB stakeholder-specific reporting (10.5).
- [x] Version Alignment: Dashboard version incremented to `v1.6.0`.

## 🏗️ R&R Rule Derivation
This cycle derives **Rule IAD-6 (Role-Based Views)** from Section 25 of `R&R-CYCLE-RULES.md`.

### Rule IAD-6 — Role-Based Dashboard Views
**Rule:** `instructor-dashboard.html` MUST provide three role-based views:
- **Lead Instructor (All Teams):** Full dashboard — progress tracking, budget heatmap, artifact health, alerts, export.
- **Path Mentor (My Path):** Filtered view — single path group tab (Scouts / Engineers / Architects) with progress, budget, and alerts for teams in that group.
- **Judge (Judging):** Artifact-focused view — artifact completion status per team, scoring readiness, no budget or alert data.

View selection MUST be stored in `sessionStorage` (per DXS-1 sandbox compliance — no `localStorage`, no cross-tab persistence).

**Verification:** Switch between all three views and verify correct panels show/hide. If any view shows incorrect data or the view doesn't persist across refresh, finding is **Medium** severity.

---

*This cycle reduces cognitive load by presenting the right data to the right person at the right time.*
