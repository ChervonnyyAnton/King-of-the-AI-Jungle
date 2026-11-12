# 🔄 Review & Remediation: Cycle 125 — Model Roaming: Context Preservation Gap

## 🎯 Objective
Address the context preservation gap when roaming between models. Currently, the roaming protocol asks participants to manually summarize progress, but there is no standardized format for the summary that guarantees completeness.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Workflow** | The model roaming protocol (added in Cycle 124) requires a "1-paragraph summary of progress" but does not specify the format or content requirements. Participants may produce summaries that omit critical details (file paths, partial results, error messages), causing the new model to re-do work or fail on the task. | Medium | All Paths — Lost context leads to redundant AI calls, burning budget | Enhanced the Model Roaming Protocol in `AGENTS.md` to specify a structured summary format with 4 required fields: Current Task, What's Done, What's Blocked, File Path. |

## 📊 Risk Assessment

| Factor | Score |
|--------|-------|
| Probability | 3 (Possible — participants forget to summarize or omit key details) |
| Impact | 3 (Wasted budget from redundant work; frustrated participants) |
| **Risk Score** | **9 (Medium)** |

## 📂 Updated Files
- `AGENTS.md`: Enhanced the "Model Roaming Protocol" to include a structured summary format with 4 fields.

## 🧪 Validation
- [ ] Workshop Stability Check: Existing content preserved; only enhanced the roaming protocol
- [ ] Instructor Script Consistency: Structured format is easy for instructors to teach
- [ ] Version Alignment: No prompt version changes

## 🔧 R&R Rule Derivation
**Rule AI-MR-1 (Structured Context Summary):** When switching models, the progress summary MUST include these 4 fields: (1) **Current Task:** What the model is currently working on. (2) **What's Done:** Completed steps or artifacts. (3) **What's Blocked:** Errors, ambiguities, or questions. (4) **File Path:** The exact file being worked on. Summary format: "Continuing from previous model. Current Task: [X]. Done: [Y]. Blocked: [Z]. File: [path]. Now do: [next step]."

## 📜 Feedback Reference
N/A — derived from Roaming Protocol (Cycle 124) follow-up inspection.

## ✅ Action Items
1. [x] Add structured summary format to Model Roaming Protocol
2. [ ] Create a "Context Summary Card" template for participants to fill out
3. [ ] Test the summary format with a real model switch (sovereign → ollama)
