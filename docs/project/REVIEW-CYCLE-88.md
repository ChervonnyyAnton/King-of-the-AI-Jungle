# 🔄 Review & Remediation: Cycle 88

## 🎯 Objective
Define **Instructor Presence** levels per workshop phase and establish **Learner Autonomy** principles (Hint Cards) to prevent over-guidance while maintaining support.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Instructor Presence** | `INSTRUCTOR-QUICK-REF.md` Section 1 defines Instructor Responsibilities but does not specify varying levels of instructor presence/visibility across workshop phases. Instructors either hover (too visible during Independent Sprint, breaking flow) or hide (not visible during Guided Demo, causing confusion). The workshop has 5 distinct phases, each requiring a different instructor proximity: Guided Demo (high presence), Independent Sprint (low presence), Break (invisible), Automation & Review (medium presence), Showdown (high presence). | **Medium** | **All Paths:** Instructor presence affects participant comfort and learning. Too much presence → dependency; too little → abandonment. Each phase has different needs. | Added **Section 9 — Instructor Presence Levels** to `INSTRUCTOR-QUICK-REF.md` with a 4-level presence model (Present/Front-of-Room, Active/Circulating, Observing/Distant, Invisible) mapped to each workshop phase, with rationale and specific behaviors expected at each level. |
| **Learner Autonomy** | The "Anti-Patterns" list in `INSTRUCTOR-QUICK-REF.md` says "Giving direct answers — always guide with questions" but provides no structured scaffolding for *how* to guide with questions. Instructors fall back to either direct answers (anti-pattern) or vague questions that don't help. No "Hint Card" system exists — a structured tier of hints from "nudge" to "near-answer" that instructors can deploy progressively. | **Medium** | **All Paths:** Learner autonomy is the core pedagogical principle of the workshop ("participants produce their own artifacts"). Without structured hinting, instructors either over-help (robbing learning) or under-help (causing frustration). | Added **Section 10 — Learner Autonomy & Hint Cards** to `INSTRUCTOR-QUICK-REF.md` with a 4-tier Hint Card system: Tier 1 (Nudge — "What have you tried?"), Tier 2 (Resource — point to a relevant section in docs), Tier 3 (Scaffold — "What does the error message say?"), Tier 4 (Hint — "Check the data-testid attribute"). Each tier must be attempted before the next. Direct answers are only allowed as Tier 5 (Answer) when all 4 tiers are exhausted and time is running out. |

## 📂 Updated Files
- **`docs/tools/INSTRUCTOR-QUICK-REF.md`**: Added "9. Instructor Presence Levels" and "10. Learner Autonomy & Hint Cards" sections (see remediation below).
- **`STLC-MAP.md`**: Added "Instructor Presence" column to the execution flow table to track expected instructor proximity per phase.

## 📐 Risk Assessment
- **Risk Score:** 3 × 4 = **12** → **High**
- **Probability:** Likely (3) — instructors without facilitation training default to either hovering or answering directly.
- **Impact:** Undermines the workshop's core learning design. Participants either become dependent on the instructor or feel abandoned. Both outcomes reduce skill acquisition and participant satisfaction.

## 🔄 R&R Rule Derivation
This cycle produced two rules in Section 19 of `R&R-CYCLE-RULES.md`:

> **Rule PW-4 — Instructor Presence Levels:** The instructor must adjust their physical presence and interaction intensity to match the workshop phase: (1) Present/Front-of-Room during Guided Demo and Showdown — visible, vocal, leading; (2) Active/Circulating during Automation & Review and Peer Review — moving between pairs, offering guidance; (3) Observing/Distant during Independent Sprint — visible in the room but not approaching unless a Flow Pass is presented; (4) Invisible during Break. Each level's expected behaviors are defined in the Instructor Presence Table.

> **Rule PW-5 — Learner Autonomy & Hint Cards:** When participants ask for help, instructors must deploy the 4-tier Hint Card system before providing any direct answer: Tier 1 (Nudge) → Tier 2 (Resource) → Tier 3 (Scaffold) → Tier 4 (Hint). Only after all 4 tiers are exhausted may the instructor provide a direct answer (Tier 5). This ensures participants develop autonomous problem-solving skills and the workshop achieves its learning objectives rather than becoming a facilitated coding session.

## 📝 Action Items
1. [ ] Create a "Hint Card" physical deck — one card per tier, printed on colored paper (e.g., green = Nudge, yellow = Resource, orange = Scaffold, red = Hint) for the instructor to hand to participants.
2. [ ] Print "Instructor Presence" reference cards for each phase to keep on the instructor's desk.
3. [ ] After each workshop, survey participants: "Did you feel supported without being spoon-fed?" Track the autonomy balance.

## 🧪 Validation
- [ ] Workshop Stability Check
- [ ] Instructor Script Consistency
- [ ] Version Alignment
