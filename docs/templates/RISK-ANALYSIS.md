# 🛡️ Risk Analysis Template (ISO/IEC/IEEE 29119-3 §5.4 Compliant)

> **Use this template for `docs/requirements/RISK-ANALYSIS.md`**
> **Standard:** ISO/IEC/IEEE 29119-3:2013, Section 5.4 Risk Product
> **Risk Assessment Methodology:** ISO 31010 (Risk Breakdown Structure, Fault Tree Analysis)

## ⚠️ Executive Summary
<!-- Brief summary of the biggest risks found. -->

## 📐 Assessment Methodology
- **Risk Identification Method:** Checklists + Expert judgment + AI-assisted brainstorming
- **Risk Assessment Technique:** Probability × Impact matrix (5×5 scale)
- **Risk Categories:** Security, Functional, Performance, Usability, Operational
- **Risk Acceptance Threshold:** All Critical (16–25) and High (10–15) risks must have documented mitigations before proceeding

## 🔍 Detailed Risks

| ID | Category | Description | Probability (1-5) | Impact (1-5) | Risk Score | Risk Level | Mitigation | Verification Step | Test Case(s) |
|----|----------|-------------|-------------------|--------------|------------|------------|------------|-------------------|--------------|
| R-01 | <!-- Security --> | <!-- XSS in Import --> | <!-- 3 --> | <!-- 4 --> | <!-- 12 --> | <!-- High --> | <!-- Sanitize Inputs --> | <!-- Upload injection.json --> | <!-- TC-05, TC-06 --> |

## 🔮 Edge Cases
- <!-- List of edge cases (e.g. Empty JSON, Large files, Long strings) -->

## 📊 Risk Summary
- **Total Risks Identified:** [N]
- **Critical (16–25):** [N]
- **High (10–15):** [N]
- **Medium (4–9):** [N]
- **Low (1–3):** [N]
- **Mitigated:** [N]
- **Accepted (with justification):** [N]

## ✅ Risk Acceptance
- [ ] All Critical/High risks mitigated or accepted by stakeholder with documented justification.
- [ ] Mitigation steps verified against `mock/index.html`.
- [ ] Risk register reviewed and approved by instructor.

---

*Created by AI Agent | Last Updated: [Date] | Standard: ISO/IEC/IEEE 29119-3:2013 §5.4*
