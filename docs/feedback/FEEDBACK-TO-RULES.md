# 🔄 Feedback-to-Rules Pipeline

## Purpose

This document defines the process for converting workshop feedback into R&R rule amendments. It closes the continuous improvement loop: participants provide feedback → feedback is categorized and prioritized → feedback drives R&R rule changes → ruleset evolves for the next workshop iteration.

## Process Overview

```
Feedback Collected → Categorize → Prioritize → Act → Log → Close Loop
```

## Step 1: Categorize

Each feedback finding is categorized using the R&R Domain Matrix (Section 1, R&R-CYCLE-RULES.md):

| Category | Applies to |
|----------|------------|
| **Pedagogy** | Alignment with 2-Axis model, task difficulty, instructor scripts, Day-0 onboarding |
| **Final Pedagogy & Workshop Flow** | Pacing, group dynamics, flow state, instructor presence, learner autonomy |
| **Technical** | Sandbox app stability, Playwright, tooling, code quality |
| **Documentation** | Cross-references, formatting, consistency, Lernunterlagen quality |
| **Security & Budget** | XSS, injection risks, token economy, opencode.json safety |
| **UX/Visual** | Instructor materials aesthetics, app UI, readability |

## Step 2: Prioritize

Each finding is scored using the R&R Severity & Impact Matrix (Section 2, R&R-CYCLE-RULES.md):

| Severity | Risk Score | Action |
|----------|-----------|--------|
| **Critical** (16–25) | Probability 4–5 × Impact 4–5 | Immediate R&R cycle within same session |
| **High** (10–15) | Probability 3–4 × Impact 3–4 | Dedicated R&R cycle in next batch |
| **Medium** (4–9) | Probability 2–3 × Impact 2–3 | Add to R&R backlog |
| **Low** (1–3) | Probability 1 × Impact 1–3 | Log but defer |

## Step 3: Act

| Severity | Action |
|----------|--------|
| **Critical/High** | Trigger a dedicated R&R cycle. Log the feedback as the cycle's origin in the "Feedback Reference" field. |
| **Medium** | Add to the R&R backlog. Review during the next cycle batch planning session. |
| **Low** | Log in the Feedback Impact Log. Review during the 10-cycle Feedback Impact Report. |

## Step 4: Log

All feedback-driven changes must be logged in two places:

1. **The Cycle Log:** Include a "Feedback Reference" field citing the workshop session date, the participant (or "anonymous"), and the specific feedback text that triggered the cycle.
2. **The Change Log (CR-4):** Update R&R-CYCLE-RULES.md Section 4 Change Log with the cycle numbers that produced the change.

## Step 5: Close Loop

When a feedback-driven cycle is completed and the ruleset is updated, the instructor notifies the participant (if identified) and describes the action taken. This closes the loop and demonstrates to participants that their feedback is valued and actionable.

## Feedback Impact Log

Create `docs/feedback/FEEDBACK-IMPACT-LOG.md` to track:

| Session Date | Feedback Item | Category | Severity | Cycle(s) Triggered | Status |
|--------------|--------------|----------|----------|-------------------|--------|
| 2026-11-10 | Scoring rubric confusing | Pedagogy | High | 186 | ✅ Resolved |
| 2026-11-10 | More time needed for Showdown | UX | Medium | — | Backlogged |

## Feedback-Driven Cycle Trigger

Any feedback finding that scores ≥Medium on the R&R matrix **automatically triggers a new R&R cycle**. The trigger is:
1. Logged in the Feedback Impact Log.
2. Added to the cycle batch planning agenda (Section 5 of R&R-CYCLE-RULES.md).
3. Assigned the next available cycle number in the batch.
4. Tagged with "Feedback-Driven" in the cycle log.

## Verification

During each cycle batch:
- [ ] All feedback items ≥Medium severity have been assigned to a cycle.
- [ ] All feedback-driven cycles have a "Feedback Reference" field.
- [ ] The Change Log includes the feedback origin for each rule change.
- [ ] Participants who provided feedback received a close-loop notification.
