# 🔄 Review & Remediation: Cycle 123 — Offline AI Workflows: Missing Offline Prompts

## 🎯 Objective
Add "Offline Mode" section to `AGENTS.md` with simplified prompt syntax rules optimized for smaller local models (llama3.2).

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Prompts** | `AGENTS.md` has no offline mode guidance. Participants who lose internet access (or choose to work offline) will use the same YAML-based prompt templates that are optimized for larger cloud models. These templates fail or produce poor output with local models. | High | All Paths — Offline participants receive unusable AI output, breaking their entire path | Added "📴 Offline Mode — Local LLM Fallback" section to the Budget & Token Economy area of `AGENTS.md` with: (1) 5 offline prompt syntax rules, (2) model selection guide table, (3) fallback model priority chain. |

## 📊 Risk Assessment

| Factor | Score |
|--------|-------|
| Probability | 4 (Likely — venue Wi-Fi often unreliable in training rooms) |
| Impact | 4 (Offline participants cannot progress with AI) |
| **Risk Score** | **16 (Critical)** |

## 📂 Updated Files
- `AGENTS.md`: Added "📴 Offline Mode — Local LLM Fallback" subsection under the Budget & Token Economy area, after the Complexity Decision Tree.

## 🧪 Validation
- [ ] Workshop Stability Check: Core `AGENTS.md` structure preserved; new section fits logically
- [ ] Instructor Script Consistency: Model selection guide table can be adapted for instructor quick-ref
- [ ] Version Alignment: No prompt templates modified — new section does not change existing prompt versions

## 🔧 R&R Rule Derivation
**Rule AI-WF-1 (Offline Prompt Syntax):** When using the local-ollama model, prompts MUST follow these 5 rules: (1) No YAML blocks — use plain-text instructions. (2) No implicit multi-step reasoning — break tasks into numbered atomic steps. (3) No open-ended analysis — specify exact output format. (4) No CoT — small models produce incoherent reasoning. (5) Be explicit — state all constraints in one instruction.

**Rule AI-WF-2 (Offline Model Selection):** Participants must use the model selection guide to determine task feasibility: simple tasks (test cases, docs) work offline; complex tasks (architecture design, cross-file analysis) must be deferred to online sessions.

## 📜 Feedback Reference
N/A — proactive remediation based on Incident Response Plan (SEC-7) offline mode trigger scenario.

## ✅ Action Items
1. [x] Add offline mode section to `AGENTS.md`
2. [ ] Create offline-optimized prompt templates for each Jungle Title path
3. [ ] Print physical "Offline Prompt Cheat Sheet" cards for instructor
