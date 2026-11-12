# 🔄 Review & Remediation: Cycle 66

## 🎯 Objective
Handle "Non-Determinism" in AI outputs by introducing checksum-based comparison and diff tools to detect and quantify output variations across agent runs.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Technical — Non-Determinism** | No mechanism exists to compare AI-generated outputs across runs. If an agent modifies `TEST-PLAN.md` or `RISK-ANALYSIS.md`, there is no way to verify whether changes are meaningful or spurious drift. No diff tooling or checksum comparison documented. | **Medium** (Risk Score: 8 = Probability 4 × Impact 2) | **Jungle Guide (B3):** Reliable output comparison. **Tactical Planner (C3):** Consistent critique of requirements. | 1. Created `docs/tools/OUTPUT-CHECKSUM-GUIDE.md` with checksum and diff methodology. 2. Added non-determinism rule to `AGENTS.md` under "Self-Healing Protocol". 3. Appended Rule DXS-4 to `R&R-CYCLE-RULES.md` Section 14. |

### Detailed Findings

1. **No Output Comparison Mechanism:**
   - Agents can generate test cases, risk analyses, and strategies — but if an agent runs twice on the same input, the outputs may differ (due to LLM non-determinism).
   - Without comparison, participants cannot tell if a "change" is a real improvement or random variation.
   - **Risk:** False positives in change detection; inability to measure agent improvement over time.

2. **Proposed Solution: Checksum + Diff Workflow:**

   **Checksum Method:**
   - Every AI-generated artifact gets a SHA-256 checksum computed on its content.
   - Checksums are stored in a companion `.checksum` file alongside each artifact.
   - Example: `TEST-PLAN.md` → `TEST-PLAN.md.checksum`

   **Diff Method:**
   - Use `diff` (Unix) or `git diff` to compare outputs between runs.
   - The `computeChecksum()` function from Cycle 65 serves as a fast pre-filter.

   **Workflow:**
   ```bash
   # Pre-run: compute checksum of current artifact
   sha256sum TEST-PLAN.md > TEST-PLAN.md.checksum

   # Run agent to modify artifact

   # Post-run: compare
   sha256sum TEST-PLAN.md > TEST-PLAN.md.new-checksum
   diff TEST-PLAN.md.checksum TEST-PLAN.md.new-checksum
   ```

3. **AGENTS.md Enhancement:**
   - Added a "Non-Determinism Handling" subsection to the Self-Healing Protocol, instructing agents to:
     - Record a checksum before modifying any artifact.
     - Report the diff summary after modification.
     - Flag outputs where >20% of content changed without explicit instruction (potential drift).

4. **R&R-CYCLE-RULES.md Enhancement:**
   - Appended Rule DXS-4 to Section 14 to formalize the non-determinism policy.

### Risk Assessment

| Risk | Probability | Impact | Score | Level |
|------|-------------|--------|-------|-------|
| AI output drift causes confusion | 4 | 2 | 8 | Medium |
| No way to measure improvement | 3 | 2 | 6 | Medium |
| Checksum files clutter repo | 2 | 1 | 2 | Low |

---

## 📂 Updated Files
- `docs/tools/OUTPUT-CHECKSUM-GUIDE.md`: Created new guide for checksum-based output comparison.
- `AGENTS.md`: Added non-determinism handling to Self-Healing Protocol.
- `docs/project/R&R-CYCLE-RULES.md`: Appended Section 14 — Rule DXS-4.

## 🧪 Validation
- [x] Workshop Stability Check — No changes to app logic; only documentation and protocol additions.
- [x] Checksum files are git-ignored by convention (not committed by default).
- [x] Version Alignment — All references remain at v2.0.

## 📝 Feedback Reference
- This cycle was triggered by the recurring complaint that "the AI gives different answers every time," which undermines confidence in the workshop's repeatable learning objectives.

---

*Cycle 66 complete. Focus: Non-Deterministic Outputs.*
