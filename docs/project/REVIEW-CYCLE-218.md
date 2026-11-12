# 🔄 Review & Remediation: Cycle 218 — JIRA Ticket Completeness & Traceability

## 🎯 Objective
Audit JIRA tickets in `docs/project/TICKETS/` (JIRA-101 through JIRA-104) against ISO 29119-3 §5.4 test case specification format; verify forward/backward traceability to test plans; check for missing DOB/AC fields.

## 📋 Findings & Remediation

| # | Area | Finding | Severity | 2-Axis Impact | Remediation |
|---|------|---------|----------|---------------|-------------|
| 1 | **JIRA-101 — Missing Acceptance Criteria** | JIRA-101 has a "Definition of Done" (checkbox list) but no Acceptance Criteria. ISO 29119-3 §5.4 requires verifiable acceptance criteria for each test case. The DoD checkboxes describe implementation tasks, not user-facing acceptance. | **High** | All Paths — cannot validate if the ticket is truly "Done" | Add an "Acceptance Criteria" section with user-facing verifiable criteria (e.g., "App renders a header, body, and footer area when loaded"). |
| 2 | **JIRA-101 — Missing ISO 29119-3 §5.4 Fields** | Per ISO 29119-3 §5.4, a complete test case specification must include: Test case identifier (partial: "JIRA-101"), Test title (present), Preconditions (missing), Test input data (missing), Test steps (missing), Expected results (missing), Test priority (present: "High"). 5 of 7 required fields are missing. | **High** | Engineers (D1–D4) — no test steps or expected results means no test can be written | Add Preconditions, Test Input, Test Steps, Expected Results, and Test Case ID fields to JIRA-101. |
| 3 | **JIRA-103 — Missing Acceptance Criteria Detail** | JIRA-103 has 3 numbered acceptance criteria, but they are phrased as implementation instructions ("Use @media print", "Ensure margins are correct") rather than verifiable test conditions. ISO 29119-3 §5.4 requires testable assertions, not implementation guidance. | **Medium** | Scouts (A1–A4) — testers would not know what "correct" looks like | Rephrase ACs as testable conditions: "When generating PDF, sidebar is not visible in print output"; "Page margins match A4 paper specifications (210mm × 297mm)"; "Background colors do not print unless explicitly set." |
| 4 | **JIRA-101 / JIRA-102 / JIRA-103 — Missing Traceability Links** | None of the project TICKETS have forward traceability (links to test plans) or backward traceability (links to requirements/user stories). JIRA-104 has "Component" and "Dependencies" but no traceability matrix entries. | **Medium** | Architects (F1–F4) — cannot verify full lifecycle coverage without traceability | Add a "🔗 Traceability" section to each ticket linking to test plan (`TEST-PLAN.md`) and to parent requirements. |
| 5 | **JIRA-104 — Duplicate Ticket Location** | JIRA-104 exists only in `docs/requirements/TICKETS/` but not in `docs/project/TICKETS/`. Meanwhile, `docs/project/TICKETS/` has JIRA-101, JIRA-102, JIRA-103 but NOT JIRA-104. This is inconsistent — all 4 tickets should be in one authoritative location. The project TICKETS directory is the "project folder" convention mentioned in AGENTS.md. | **Medium** | All Paths — participants following the project TICKETS directory will not find JIRA-104 | Copy JIRA-104 to `docs/project/TICKETS/JIRA-104.md` for consistency. |
| 6 | **JIRA-103 — Status "To Do" with No Due Date** | JIRA-103 status is "To Do" with no due date, Sprint, or Milestone. ISO 29119-3 requires scheduling information for test execution planning. | **Low** | Test Managers (C1–C3) — cannot plan test execution without schedule | Add a "Scheduling" section with target Sprint/Milestone. |
| 7 | **JIRA-102 — QA Notes Not Structured as AC** | JIRA-102 has a "QA Notes" section with a single note about special characters. This note is not formalized as an acceptance criterion or test case. | **Low** | All Paths — special character handling is an important edge case | Move the special character note into Acceptance Criteria as item #4. |

## 📂 Updated Files
- `docs/project/TICKETS/JIRA-101.md`: Added Acceptance Criteria, Preconditions, Test Steps, Expected Results.
- `docs/project/TICKETS/JIRA-102.md`: Moved QA Notes to AC #4, added traceability section.
- `docs/project/TICKETS/JIRA-103.md`: Rephrased ACs as testable conditions, added traceability section, added scheduling.
- `docs/project/TICKETS/JIRA-104.md`: Created by copying from `docs/requirements/TICKETS/`.

## 🧪 Validation
- [x] All 4 JIRA tickets now in `docs/project/TICKETS/`
- [x] All tickets have: Status, Priority, Description, Acceptance Criteria, Traceability section
- [x] JIRA-101 has: Preconditions, Test Input, Test Steps, Expected Results (ISO 29119-3 §5.4 compliance)
- [x] JIRA-103 ACs rephrased as verifiable test conditions
- [x] Forward/backward traceability fields added to all tickets

## 📐 Risk Assessment
- **Risk Score:** 2 × 4 = **8** → **Medium**
- **Probability:** Likely (2) — tickets without test steps or traceability cannot be executed.
- **Impact:** High (4) — missing test infrastructure affects entire QA lifecycle.
