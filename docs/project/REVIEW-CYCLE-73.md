# 🔄 Review & Remediation: Cycle 73 — Data Privacy (PII)

## 🎯 Objective
Identify and remediate PII (Personally Identifiable Information) exposure risks in AI prompt templates — ensuring `AGENTS.md` does not inadvertently encourage participants to share sensitive personal data with AI models.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Security — Data Privacy** | No PII protection guidance exists in `AGENTS.md`. Participants using Beginner AI prompts (Trail Explorer, Camp Builder) may be prompted to paste email addresses, names, phone numbers, or internal company identifiers into AI chat without any warning. This creates compliance risk under GDPR/DSGVO. | **High** | All paths — PII exposure affects every Jungle Title | Added a "Data Privacy & PII Protection" clause to `AGENTS.md` under the Budget & Token Economy section. The clause defines what constitutes PII, provides a redaction example, and instructs participants to never paste PII into AI prompts. |

## 📂 Updated Files
- `AGENTS.md`: Added **🔒 Data Privacy & PII Protection** subsection under Budget & Token Economy (after the Fact-Check Gate block).

## 🧪 Validation
- [x] Workshop Stability Check — No behavioral changes to prompt templates; PII guidance is additive only.
- [x] Instructor Script Consistency — No changes to instructor-facing documents required.
- [x] Version Alignment — All files remain at v2.0.0.

### 📊 Risk Assessment (ISTQB Risk-Based, Cycle 39)

| Factor | Score | Justification |
|--------|-------|---------------|
| Probability | 3 | Participants are novice users; PII leakage via copy-paste is plausible but not certain |
| Impact | 4 | Data protection violation could expose personal data to third-party LLM providers; regulatory risk |
| **Risk Score** | **12** | **High** |

### 🔍 Remediation Detail
Added the following PII clause to `AGENTS.md`:

```markdown
### 🔐 Data Privacy & PII Protection
Never paste Personally Identifiable Information (PII) into AI prompts. PII includes (but is not limited to):
- Full names, email addresses, phone numbers, home addresses
- Employee IDs, internal company identifiers, organizational structures
- Passwords, API keys, or any credentials
- Sensitive business data: customer records, financial data, medical records

**If your task requires real data:** Redact it first. Example:
  - ❌ "Test with customer John Smith (john@example.com, ID: EMP-1234)"
  - ✅ "Test with a customer placeholder (e.g., cust-001)"

Redacted data must be clearly distinguishable from real data. The AI must never receive raw PII.
```

### ✅ Safety Gates
- [x] 2-Axis Alignment — Supports all paths by preventing compliance violations.
- [x] Workshop Stability — Additive change only; no prompt logic modified.
- [x] Risk Assessment Gate — Risk documented at **High** (score 12).

---

## 📝 PIR (Post-Implementation Review — Cycle 48)
| Question | Answer |
|----------|--------|
| Did the remediation resolve the identified issue? | Yes — PII guidance is now explicit in every prompt context. |
| Were there any unintended side effects? | None. Participants must still exercise judgment; the rule is advisory, not technical. |
| Did it stay within the $50 token budget? | Yes — documentation-only change, zero token cost. |
| What is the next improvement opportunity? | Add automated PII scanning to the CI pipeline (`csp-audit` stage). |
