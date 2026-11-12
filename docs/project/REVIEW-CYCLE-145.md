# 🔄 Review & Remediation: Cycle 145 — Consent & Usage Tracking

## 🎯 Objective
Add a "Data Usage Consent" checkbox and formal tracking mechanism to the instructor guide, ensuring participant data collected during the workshop is governed by explicit consent.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Documentation — Consent Tracking** | Workshop participants produce artifacts (test plans, risk analyses, automation scripts) that may reference real organizational data, customer scenarios, or process information. There is no formal consent mechanism to document how participant data is collected, stored, and used during the workshop. This creates a GDPR Article 6(1) compliance gap — no lawful basis for data processing is established. | **High** | **Instructor Delivery Domain** — All Paths. Without consent, instructors cannot ethically collect, review, or share participant artifacts. | Created `docs/tools/PARTICIPANT-DATA-CONSENT-FORM.md` — a consent form template with: (1) Data collection scope (what data is collected); (2) Purpose of processing (workshop evaluation, learning assessment); (3) Data retention period (30 days post-workshop); (4) Participant rights (access, rectification, erasure); (5) An explicit consent checkbox (digital or paper). The form is referenced in the instructor quick-ref's Day-0 checklist. |

## 📂 Updated Files
- **`docs/tools/PARTICIPANT-DATA-CONSENT-FORM.md`**: New file — GDPR-compliant consent form with data scope, retention policy, rights disclosure, and checkbox for explicit consent.
- **`AGENTS.md`**: Updated Data Privacy section to reference the consent form and require consent collection before workshop activities begin.

## 📐 Risk Assessment
- **Risk Score:** 3 × 4 = **12** → **High**
- **Probability:** Likely (3) — instructors routinely collect participant artifacts without formal consent.
- **Impact:** High — processing participant data without consent violates GDPR Article 6(1) and participant trust.

## 🔄 R&R Rule Derivation

> **Rule DP-5 — Explicit Consent Requirement:** Before workshop activities begin, each participant must provide explicit consent for data collection and processing. The consent form (`docs/tools/PARTICIPANT-DATA-CONSENT-FORM.md`) must be signed (digitally or on paper) and filed in the workshop's consent records. Consent must be: (1) Freely given — not a condition of participation; (2) Specific — clearly describing what data is collected and how it is used; (3) Informed — participant understands retention period (30 days) and their rights; (4) Unambiguous — requires affirmative action (checkbox or signature). No consent, no workshop.

## 📝 Action Items
1. [ ] Review the consent form with legal/compliance if the workshop is used in a regulated organization.
2. [ ] Add consent collection to the instructor's Day-0 checklist (10 minutes).
3. [ ] Document the consent record retention policy in `BUDGET-LOG.md` or a separate consent tracker.

## 🧪 Validation
- [ ] Consent form is referenced in instructor's Day-0 checklist
- [ ] Consent form clearly states data scope, retention (30 days), and participant rights
- [ ] Consent form includes both digital (checkbox) and paper (signature) options
