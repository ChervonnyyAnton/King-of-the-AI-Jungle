# 🔄 Review & Remediation: Cycle 124 — Offline AI Workflows: Online/Offline Switch Criteria

## 🎯 Objective
Define clear criteria for when to switch between online and offline models, and document the model switching protocol to prevent context loss.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Workflow** | No explicit criteria exist for deciding when to use the online model (sovereign/cloud) vs. the offline model (Ollama). Participants switch models arbitrarily, causing inconsistent output quality and wasted budget. Additionally, no protocol exists for switching models mid-session without losing context. | High | All Paths — Inconsistent model choice leads to inconsistent output quality | Added "Fallback Model Priority (Chain of Fallback)" ordered list and "Model Roaming Protocol (mid-session switch)" section to `AGENTS.md` offline mode area. |

## 📊 Risk Assessment

| Factor | Score |
|--------|-------|
| Probability | 3 (Possible — participants will switch models during workshops) |
| Impact | 4 (Inconsistent output quality; potential budget drain from switching to cloud) |
| **Risk Score** | **12 (High)** |

## 📂 Updated Files
- `AGENTS.md`: Added "Fallback Model Priority (Chain of Fallback)" (3-tier priority list) and "Model Roaming Protocol (mid-session switch)" (4-step context preservation protocol).

## 🧪 Validation
- [ ] Workshop Stability Check: Existing prompt templates unchanged
- [ ] Instructor Script Consistency: Model switching protocol is clear enough for instructor reference
- [ ] Version Alignment: No prompt version changes required

## 🔧 R&R Rule Derivation
**Rule AI-WF-3 (Fallback Priority Chain):** Model usage follows a strict priority order: (1) `qwen-sovereign` — primary, free. (2) `cloud-gpt4` — complex reasoning only, budget cost. (3) `local-ollama` — offline fallback, no cost. Participants MUST attempt the current priority model before switching to the next.

**Rule AI-WF-4 (Model Roaming Protocol):** When switching models mid-session: (1) Complete the current task before switching. (2) Ask the current model for a ≤3-bullet progress summary. (3) Paste the summary as the first line of the new model's prompt. (4) Never lose the working file path.

## 📜 Feedback Reference
N/A — proactive remediation based on Model Drift Detection (12.2) and Incident Response (SEC-7) gap analysis.

## ✅ Action Items
1. [x] Add fallback priority chain to `AGENTS.md`
2. [ ] Add roaming protocol to `INSTRUCTOR-QUICK-REF.md`
3. [ ] Create a visual "Model Selection Decision Tree" poster for workshop room
