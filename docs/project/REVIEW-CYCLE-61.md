# 🔄 Review & Remediation: Cycle 61

## 🎯 Objective
Enforce **Time-Boxing** in `STLC-MAP.md` to prevent participants from spending excessive time on a single artifact and ensure balanced progress across all STLC phases.

## 📋 Domain: Pedagogy / Andragogy — Time-Boxing & Self-Regulated Learning

### 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **STLC-MAP.md — Time Enforcement** | The STLC phase matrix assigns time boxes (e.g., "15 min," "20 min," "30 min"), but the "Execution Flow & Time Management" section only has a weak rule: "Do not spend more than 10 minutes on a single artifact." This is ambiguous — an artifact could take 15–20 minutes for a beginner. There is no enforcement mechanism, no "hard stop" signal, and no escalation path when a time box is exceeded. | **High** | **All Paths — All Phases:** Without enforcement, participants tend to hyper-focus on tasks they enjoy (e.g., Engineers spending 40 min on Playwright specs) and neglect others (e.g., skipping risk analysis for testing). | Add Section 13.4 — **Time-Boxing Enforcement Rule** to `R&R-CYCLE-RULES.md`. Updated `STLC-MAP.md` to add: (1) explicit hard-stop triggers (visual + instructor), (2) a "Time Exceeded" escalation path (switch task, ask for help, or proceed with placeholder), (3) a time-tracking recommendation (timer visible to all participants). |
| **STLC-MAP.md — Phase Transition Gates** | Phase transitions are gated by exit criteria (Section "Test Exit Criteria") but there is no time-based fallback. If exit criteria are not met in the allocated time, participants are stuck — neither proceeding nor receiving guidance. | **Medium** | **Scouts & Engineers:** Risk analysis and test planning may feel "incomplete" when time runs out, causing anxiety and reduced confidence. | Add a "Minimum Viable Artifact" definition for each phase — if the exit criteria cannot be fully met in time, participants produce a Minimum Viable Artifact and note remaining items in a "Work-In-Progress" section. |

## 🧠 Pedagogical Analysis — Time-Boxing & Self-Regulated Learning

**Self-Regulated Learning (Zimmerman, 2002):** Effective learners plan their time, monitor progress, and adapt strategies. Time-boxing is a critical scaffold that externalizes time awareness for novice learners who lack an internal sense of task duration.

**Parkinson's Law in Workshops:** "Work expands to fill the time available." Without hard stops, participants will consume all allocated time even when the artifact is adequate, leaving insufficient time for later, more valuable phases (execution, reporting, reflection).

**The "Good Enough" Principle:** For workshop participants (not production QA teams), the goal is *learning*, not perfection. Time-boxing forces the "good enough" mindset: produce a functional artifact within constraints, then move on. This mirrors real-world software delivery where "done" is a time-bounded state.

**Enforcement Mechanisms Required:**
1. **Visible Timer:** All participants should see a countdown timer (projector or shared screen).
2. **Instructor Hard Stop:** Instructor announces time change with a consistent phrase ("Hard stop in 2 minutes!").
3. **Escalation Path:** If stuck → switch tasks → proceed with placeholder → note as WIP.

## 📂 Updated Files
- `docs/project/R&R-CYCLE-RULES.md`: Added Section 13.4 — **Time-Boxing Enforcement Rule**.
- `STLC-MAP.md`: Added explicit hard-stop triggers, escalation path, time-tracking recommendation, and "Minimum Viable Artifact" definitions per phase.
- `INSTRUCTOR-QUICK-REF.md`: Updated 3-Hour Delivery Flow table to include "Phase Transition Hard Stop" column with consistent signals.

## 📝 Action Items
1. [ ] Create a "Phase Hard Stop" visual aid (card or slide) for instructors to display during transitions.
2. [ ] Define "Minimum Viable Artifact" criteria for each phase (e.g., Phase 1: ≥3 risk categories identified; Phase 2: ≥5 test cases with ≥1 technique).
3. [ ] After the next workshop, measure: (a) average time spent per phase, (b) % of participants who completed all phases, (c) self-reported time management stress.
4. [ ] If time-boxing causes excessive stress (measured via post-workshop survey), increase phase times by 5 minutes and reduce buffer times accordingly.

## 🧪 Validation
- [ ] Workshop Stability Check — Hard stops fit within existing 3-hour schedule (no phase extension).
- [ ] Instructor Script Consistency — Instructors have the hard-stop script and escalation path.
- [ ] Version Alignment — STLC-MAP.md page count still supports "≤ 2 pages" reporting rule.
