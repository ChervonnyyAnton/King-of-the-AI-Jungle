# 🔄 Review & Remediation: Cycle 126 — Model Roaming: Emergency Switch Procedure

## 🎯 Objective
Define an emergency model switch procedure for when the current model becomes completely unreachable (timeout, 503, rate limit) — participants need a fast-path procedure to keep the workshop moving.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Workflow** | The Model Roaming Protocol (Cycles 124-125) assumes a deliberate, controlled model switch. But in an emergency (AI Hub timeout, 503 error, rate limit), participants cannot afford the 30-second context summary process. There is no "emergency switch" procedure documented. | High | All Paths — Participants stall when the model is unreachable, wasting workshop time | Added "Emergency Switch Procedure" subsection to `AGENTS.md` offline mode area: a 2-step fast-path for when the current model is completely unreachable. |

## 📊 Risk Assessment

| Factor | Score |
|--------|-------|
| Probability | 3 (Possible — AI Hub can experience outages during workshops) |
| Impact | 4 (Workshop stalls; all participants affected simultaneously) |
| **Risk Score** | **12 (High)** |

## 📂 Updated Files
- `AGENTS.md`: Added "Emergency Switch Procedure" to the Offline Mode section.

## 🧪 Validation
- [ ] Workshop Stability Check: Emergency procedure fits within offline mode section
- [ ] Instructor Script Consistency: Emergency procedure mirrors Incident Response (SEC-7) cloud model unreachable scenario
- [ ] Version Alignment: No prompt version changes

## 🔧 R&R Rule Derivation
**Rule AI-MR-2 (Emergency Switch):** When the current model is unreachable (timeout, 503, or connection refused): (1) **Immediately** switch to the next model in the priority chain — do NOT retry the failed model. (2) **Do NOT write a context summary** — start with a fresh prompt using the same task description. (3) **Log the failure** in `BUDGET-LOG.md` with timestamp and error type. (4) **Retry the failed model** only after completing the current task.

## 📜 Feedback Reference
N/A — derived from Incident Response Plan (SEC-7) gap analysis. The emergency switch procedure complements the cloud unreachable response.

## ✅ Action Items
1. [x] Add emergency switch procedure to `AGENTS.md`
2. [ ] Add emergency switch to `INSTRUCTOR-QUICK-REF.md` troubleshooting section
3. [ ] Simulate an AI Hub outage during instructor dry-run to validate procedure
