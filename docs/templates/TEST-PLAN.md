# 📝 Test Plan Template (ISO/IEC/IEEE 29119-3 §5.3 Compliant)

> **Use this template for `docs/requirements/TEST-PLAN.md`**
> **Standard:** ISO/IEC/IEEE 29119-3:2013, Section 5.3 Test Plan Format

## 🆔 Test Plan Identifier
- **Plan ID:** TP-[JIRA-ID]-[Version]
- **Date:** [YYYY-MM-DD]
- **Author:** [Participant Role / Jungle Title]
- **Approval:** [Instructor / Peer Reviewer]

## 📖 1. Introduction
<!-- What is the goal of this test plan? (e.g., Validate JSON Import/Export) -->

## 📋 2. General Description of Test Cases

### 2.1 Test Items (Features to be Tested)
- <!-- List features/requirements to be tested, reference JIRA ticket IDs -->

### 2.2 Features to be Tested
- <!-- Specific features under test -->

### 2.3 Features Not to be Tested
- <!-- Out-of-scope features and rationale -->

### 2.4 Test Approach
- <!-- Overall strategy: manual vs automated, test techniques used -->

### 2.5 Items Out of Scope
- <!-- Specific test items excluded and justification -->

## 📊 3. Scenarios

| ID | Scenario Type | Description | Steps | Expected Result | Priority | Automation Status | Traceability | Technique |
|----|---------------|-------------|-------|-----------------|----------|-------------------|--------------|-----------|
| TC-01 | <!-- e.g. Functional --> | <!-- e.g. Export with valid JSON --> | <!-- 1. Load Config --> | <!-- File downloads --> | High | <!-- Manual --> | `docs/requirements/TICKETS/JIRA-102.md` | <!-- EP --> |
| TC-02 | <!-- Negative --> | <!-- Malformed JSON --> | <!-- 1. Upload bad JSON --> | <!-- Error Toast --> | High | <!-- Automated --> | `docs/requirements/TICKETS/JIRA-102.md` | <!-- BVA --> |

## 🌐 4. Test Environment
- **Target:** `http://localhost:3000`
- **Tools:** Playwright / Bruno
- **Runner:** `npx playwright test`

## 📅 5. Schedule
- **Test Design Start:** [Date]
- **Test Execution Start:** [Date]
- **Expected Completion:** [Date]

## 📦 6. Test Deliverables
- [ ] `TEST-PLAN.md` (this document)
- [ ] `RISK-ANALYSIS.md`
- [ ] Playwright test specs
- [ ] `STLC-SUMMARY.md`

## ⚠️ 7. Test Risks and Contingencies
- <!-- Key risks and fallback plans -->

## ✅ 8. Coverage Summary
- **Total Requirements:** [N]
- **Covered Requirements (≥1 TC):** [N]
- **Coverage Percentage:** [Calculation = Covered / Total × 100]%
- **Target Threshold:** ≥80%
- **Uncovered Requirements & Justification:** [If any]

## ✅ 9. Traceability Summary
- **Forward Traceability:** [Coverage]% — Requirements with ≥1 test case
- **Backward Traceability:** [Coverage]% — Tests with ≥1 requirement mapping
- **Target Threshold:** ≥90% for both

## ✍️ 10. Approval Signatures
- [ ] **Instructor Approval:** ____________________ Date: ______
- [ ] **Peer Review Approval:** ____________________ Date: ______

---

## 🧪 Test Design Technique Reference (ISTQB FL v4.0 §2.3)

| Technique | Description | Workshop Example |
|-----------|-------------|-----------------|
| **Equivalence Partitioning (EP)** | Divide input domain into classes; test one value per class | Valid JSON / Malformed JSON / Empty input |
| **Boundary Value Analysis (BVA)** | Test at boundaries of input domains | File size: 0 bytes, 1 byte, max size, >max size |
| **Decision Table** | Map combinations of conditions to actions | JSON valid × Grid enabled × Export format = test matrix |
| **State Transition** | Model system states and valid/invalid transitions | Idle → Grid Enabled → Export → Import → Validate |
| **Error Guessing** | Use experience to anticipate failure modes | XSS payloads, special characters, truncated JSON |

> **Rule:** Every test plan must use at least **3 distinct techniques** from the table above.

---

*Created by AI Agent | Last Updated: [Date] | Standard: ISO/IEC/IEEE 29119-3:2013 §5.3*
