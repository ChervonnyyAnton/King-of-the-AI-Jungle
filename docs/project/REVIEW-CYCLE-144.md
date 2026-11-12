# 🔄 Review & Remediation: Cycle 144 — Data Residency Policy

## 🎯 Objective
Add an explicit data residency policy to `AGENTS.md` ensuring no participant data, workshop artifacts, or synthetic data leaves the local sandbox environment unless explicitly authorized.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Documentation — Data Residency** | `AGENTS.md` includes PII protection (telling participants not to paste PII into AI prompts) but has no explicit **data residency** policy. The `Budget & Token Economy` section mentions `websearch`/`webfetch` but does not state that these tools must never be used to transmit workshop data to external services. This creates ambiguity: participants might inadvertently upload workshop materials to a cloud LLM for analysis. | **High** | **All Paths** — Every participant using a cloud model (gpt-4-turbo) or external research tool risks data exfiltration. **Architects (F1–F4):** System design prompts that reference organizational data structures. | Added **Section 4.7: Data Residency & Local-Only Enforcement** to `AGENTS.md`. The policy states: (1) All workshop data must remain in the local project directory; (2) `websearch` and `webfetch` are permitted ONLY for general research, NEVER for uploading or transmitting workshop data; (3) Cloud model API calls must not include workshop artifact content (only the prompt instruction, not the source files); (4) A "Data Residency Violation" is classified as a **Critical** finding under the risk matrix. |

## 📂 Updated Files
- **`AGENTS.md`**: Added "Data Residency & Local-Only Enforcement" (Section 4.7) to the Budget & Token Economy area, with 4 explicit sub-rules and a Critical severity classification.

## 📐 Risk Assessment
- **Risk Score:** 4 × 5 = **20** → **Critical**
- **Probability:** Likely (4) — participants using cloud models may paste workshop content into prompts.
- **Impact:** Critical — data exfiltration violates GDPR and could expose workshop IP, participant data, and proprietary test configurations to external models.

## 🔄 R&R Rule Derivation

> **Rule DP-4 — Data Residency & Local-Only Enforcement:** All workshop data (artifacts, test data, participant outputs, synthetic data) MUST remain within the local project directory (`King-of-the-AI-Jungle/`). No workshop content may be: (a) transmitted to external APIs via `webfetch`; (b) pasted into cloud model prompts in full (only prompt instructions, not source files); (c) stored in cloud storage, shared drives, or third-party services. Violations are classified as **Critical** severity. The only exception is `websearch`/`webfetch` for external research, provided the query contains NO workshop-specific data.

## 📝 Action Items
1. [ ] Review all prompt templates in `AGENTS.md` to ensure none include instructions that would cause participants to paste full source files into a cloud model.
2. [ ] Add a data residency reminder to the instructor's Day-0 kickoff script.
3. [ ] Create a "Data Residency Checklist" item for `setup-checklist.sh`.

## 🧪 Validation
- [ ] Workshop Stability Check — `AGENTS.md` remains valid with the new section
- [ ] Instructor Script Consistency — data residency reminder is included in kickoff
- [ ] Version Alignment — data residency policy aligns with SEC-5 (PII Protection)
