# 🔄 Review & Remediation: Cycle 165 — Gamification: Achievement Unlocks (Step Gating)

## 🎯 Objective
Implement an "achievement unlock" mechanism in the workshop where participants must complete prerequisite steps to access advanced content. This prevents participants from skipping foundational content and ensures progressive skill development.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Gamification** | No content unlocking mechanism exists. Participants can jump to any step in `WORKSHOP-CHALLENGE.md` regardless of whether they've completed prerequisites. This undermines the scaffolding principle (R&R Rule 14.2) — participants who skip Step 1 (Jungle Title selection) may not understand their path, and those who skip Step 2 (mission briefing) may not know what to do. | **High** | **All Paths:** Without step gating, participants self-select into levels they are not prepared for, creating the "competence illusion" (R&R Rule 14.2). Beginners attempting advanced content waste tokens on misaligned tasks. | Added **Step-Gating Mechanism** to `WORKSHOP-CHALLENGE.md`: Step 2 hints are hidden behind Step 1 completion. Step 3 (Showdown) content is gated behind completion of Step 2 (mission). Hints for each step are displayed in a "locked" state with an overlay until the prerequisite step is marked complete. This is implemented as a "Unlock" checkbox in the sandbox app. |
| **Pedagogy** | No connection between achievement unlocks and the badge system. Earning a badge should feel like unlocking new capabilities, not just collecting points. | **Medium** | **Engineers (D1–D4):** Engineers value progress mechanics. Without connection to unlocks, badges feel like decoration rather than meaningful progress indicators. | Linked badges to unlocks: "Earn 3 badges → unlock Advanced Hint Cards." This creates a secondary progression layer (badge count → unlock tier) that rewards sustained engagement. |

## 📂 Updated Files
- **`WORKSHOP-CHALLENGE.md`**: Added "Step 3c: Achievement Unlocks" section with step-gating rules; linked badge count to unlock tiers.
- **`INSTRUCTOR-QUICK-REF.md`**: Added "Step-Gating Facilitation" to Section 14 with instructor procedures for unlocking content.

## 📐 Risk Assessment
- **Risk Score:** 3 × 4 = **12** → **High**
- **Probability:** Likely (3) — without gating, advanced participants will skip foundational steps.
- **Impact:** High — undermines scaffolding principle and token economy for all paths.

## 🔄 R&R Rule Derivation

> **Rule GAM-7 — Achievement Unlock Gating:** Workshop content must be progressively unlocked. Step 2's advanced hints are locked until Step 1 (Jungle Title selection) is confirmed complete. Step 3 content (Showdown preparation) is locked until Step 2 (mission briefing) is confirmed complete. The unlock mechanism is a visible checkbox in `mock/index.html` (instructor-controlled) or a self-certification checkbox in `WORKSHOP-CHALLENGE.md`. Earned badges (≥3) unlock Advanced Hint Cards, which provide more specific guidance than the standard 5-Tier Hint System.

> **Rule GAM-8 — Badge-to-Unlock Progression:** Badge count must map to unlock tiers: 3 badges → Advanced Hint Cards, 5 badges → Boss Battle participation, 7 badges (all badges) → Jungle Crown eligibility. This creates a visible progression from "participant" to "King of the Jungle."

## 📝 Action Items
1. [ ] Implement the unlock checkbox in `mock/index.html` (Cycle 166).
2. [ ] Create "Advanced Hint Cards" content for unlocked participants.
3. [ ] Test the progression: badge → unlock tier → advanced content.

## 🧪 Validation
- [ ] Step 2 hints are locked until Step 1 is complete
- [ ] Step 3 content is locked until Step 2 is complete
- [ ] ≥3 badges unlock Advanced Hint Cards
- [ ] Instructor can manually override unlock status (for accessibility)
