# 🔄 Review & Remediation: Cycle 96

## 🎯 Objective
Fix **Terminology Inconsistency** in Rule PW-5 (Learner Autonomy & Hint Cards): the principle paragraph describes a "4-Tier Hint Card System" while the detailed table lists 5 tiers (1–5), creating ambiguity about the correct system design.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Hint Card System Tier Count** | Section 17 (Final Pedagogy & Workshop Flow), Rule PW-5 (17.5) uses inconsistent tier counting: (1) The principle paragraph states "4-Tier Hint Card System" and "one tier at a time. No skipping tiers." (2) The table lists 5 rows: Tier 1 (Nudge), Tier 2 (Resource), Tier 3 (Scaffold), Tier 4 (Hint), Tier 5 (Answer). (3) The principle paragraph clarifies "Only after all 4 tiers are exhausted may the instructor provide a direct answer (Tier 5)." This creates ambiguity: is the system 4 tiers or 5 tiers? For workshop delivery, instructors must know the exact structure to implement it correctly. | **High** | **All Paths:** Learner autonomy is the core pedagogical principle of the workshop. If instructors are confused about the hint system structure, they will either skip tiers (giving answers too early) or refuse to give answers (leaving students stuck). The ambiguity undermines the entire autonomy framework. | Clarified the Hint Card System as a **5-Tier Progressive Hinting System**: Tiers 1–4 are the progressive hint levels (Nudge → Resource → Scaffold → Hint), and Tier 5 (Answer) is the emergency fallback that may only be used when (a) all 4 tiers are exhausted AND (b) time is running out. The principle paragraph now explicitly states "5-Tier" and clarifies that Tier 5 is an exception, not part of the progressive sequence. |
| **Terminology Alignment** | The section title "Learner Autonomy & Hint Cards" (PW-5) did not mention tier count, making it impossible to tell from the title alone which system is defined. This is compounded by the summary table in §17 which also omits tier count. | **Medium** | **Documentation:** Inconsistent terminology across the section title, principle paragraph, rule table, and summary table reduces document usability in a live workshop setting. | Updated the principle paragraph to consistently use "5-Tier Progressive Hinting System" throughout. Added a one-line clarifier: "Tiers 1–4 form the progressive sequence; Tier 5 (Answer) is a restricted exception, not a regular tier." |

## 📂 Updated Files
- **`docs/project/R&R-CYCLE-RULES.md`**: Fixed PW-5 terminology — principle paragraph now uses "5-Tier Progressive Hinting System" consistently; clarified Tier 5 as an exception not part of the progressive sequence.

## 📐 Risk Assessment
- **Risk Score:** 4 × 3 = **12** → **High**
- **Probability:** Very Likely (4) — in a live workshop, instructors will read the principle paragraph before the table. If the principle says "4-tier" but the table shows 5 rows, confusion is inevitable.
- **Impact:** Affects ALL paths. The learner autonomy framework is the workshop's defining pedagogical commitment (per the PW-5 verification criteria: "autonomy is the workshop's defining pedagogical commitment"). Ambiguity in the hint system undermines this commitment.

## 🔄 R&R Rule Derivation
This cycle refined **Rule PW-5** in Section 17:

> **Rule PW-5 — Learner Autonomy & Hint Cards:** When participants ask for help, instructors must deploy the 5-Tier Progressive Hinting System one tier at a time. No skipping tiers. Tiers 1–4 (Nudge → Resource → Scaffold → Hint) form the progressive sequence. Tier 5 (Answer) is a restricted exception: only available when all 4 tiers are exhausted AND time is running out. This ensures participants develop autonomous problem-solving skills and the workshop achieves its learning objectives rather than becoming a facilitated coding session.

## 📝 Action Items
1. [ ] Create a physical "Hint Card" deck for instructors — 5 cards (one per tier) on colored paper for quick visual reference during workshops.
2. [ ] Include the 5-Tier structure in the instructor training checklist (INSTRUCTOR-QUICK-REF.md).
3. [ ] After each workshop, survey participants: "Did instructors follow the hint progression?" Track compliance.

## 🧪 Validation
- [ ] Workshop Stability Check
- [ ] Instructor Script Consistency
- [ ] Version Alignment
- [ ] Terminology consistency: `grep -i "tier" R&R-CYCLE-RULES.md` → all references use "5-Tier" ✅
