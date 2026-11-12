# 🔄 Review & Remediation: Cycle 36

## 🎯 Objective
Focus on **Agentic AI & GenAI — Self-Healing Prompts** to ensure agents suggest concrete fixes before reporting failures.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Failure Reporting Gap** | When a test or task fails, the current prompts instruct the agent to report the error but do not require it to suggest a remediation. | High | **Engineers (D/E):** SDET participants receive errors without actionable next steps, slowing learning. | Added a "Self-Healing Protocol" to all prompt templates: *"When a test, script, or validation step fails, the agent MUST: (1) State the exact failure, (2) Propose at least one concrete fix with code/selector changes, (3) Explain the root cause in ≤2 sentences, (4) Only then report the final status."* |
| **simulateError() Surface** | `mock/index.html` has a `simulateError()` button that throws "Connection reset" errors. AI agents testing this will see deterministic failures. | Low | **Engineers (E):** Self-healing agents need a safe failure surface to practice on. | Documented as a known test surface — agents should recognize `simulateError()` as an intentional failure injection point and verify that their test suite handles it gracefully (not as a genuine bug). |
| **Self-Healing for Architects** | The F4 (King of the Jungle) "Self-Healing Test Suite" concept is mentioned in `AGENTS.md` but lacks a concrete implementation plan for workshop use. | Medium | **Architects (F):** The stretch goal is aspirational but not actionable. | Added a "Self-Healing Implementation Starter" block to the F4 prompt: a minimal selector-retry pattern using Playwright's `locator.first()` with `waitFor()` and a suggested fallback selector strategy. |

## 📂 Updated Files
- `AGENTS.md`: Added "Self-Healing Protocol" to all prompt templates (Scouts, Engineers, Architects); added F4 implementation starter for selector-retry pattern.

## 🧪 Validation
- [x] Workshop Stability Check
- [x] Instructor Script Consistency
- [x] Version Alignment
