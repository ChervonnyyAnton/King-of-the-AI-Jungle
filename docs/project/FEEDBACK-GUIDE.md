# 📬 DX Feedback Collection Guide

> Reference: REVIEW-CYCLE-67.md | Rule DXS-5

This guide defines the structured feedback collection process for workshop onboarding documentation.

## 🎯 Goal

Continuously improve the Developer Experience (DX) of `opencode.json.template` (config template) and `VS-CODE-AI-HUB-SETUP.md` (setup guide) by collecting, categorizing, and acting on participant feedback.

## 📋 Feedback Categories

| Category | Examples |
|----------|----------|
| **Setup Friction** | "Step 3 was confusing," "Placeholder {URL} unclear" |
| **Documentation Gaps** | "Missing explanation for," "No example for" |
| **Configuration Errors** | "Got 401 even with correct key," "CSP blocked inline scripts" |
| **Suggestion** | "Add a video tutorial," "Include a Docker setup" |
| **Praise** | "Clear instructions," "Love the checksum guide" |

## 📝 Feedback Template

Save feedback as `FEEDBACK-<NAME>.md` in `docs/feedback/`:

```markdown
# DX Feedback: <Your Name>
Date: <YYYY-MM-DD>
Workshop Role: <Trail Explorer / River Ranger / etc.>

## Setup Experience
- Connectivity check: ☐ Success  ☐ Failed
- Placeholder clarity: ☐ Clear  ☐ Unclear
- Onboarding difficulty (1-5): <score>

## Issues Encountered
1. <Issue description>
2. <Issue description>

## Suggestions
1. <Suggestion>

## Overall Assessment
<Free-text summary>
```

## 🔄 Feedback Lifecycle

```
Collect → Categorize → Prioritize → Act → Close Loop
```

### Step 1: Collect
- Gather feedback at defined points:
  - After Day-0 setup (VS-CODE-AI-HUB-SETUP.md feedback form)
  - After first agent run (AGENTS.md prompt experience)
  - End of workshop (WORKSHOP-CHALLENGE.md survey)

### Step 2: Categorize
Tag each feedback item with one of the 5 categories above.

### Step 3: Prioritize
Map to the Severity & Impact Matrix (R&R-CYCLE-RULES.md Section 2):

| Severity | DX Issue Example |
|----------|-----------------|
| **Critical** | Workshop cannot start due to broken setup |
| **High** | Specific Jungle Title path blocked by configuration issue |
| **Medium** | Documentation inconsistency or unclear step |
| **Low** | Cosmetic suggestion or "nice-to-have" |

### Step 4: Act
- **High/Critical**: Immediate R&R cycle.
- **Medium/Low**: Backlog for next cycle batch.

### Step 5: Close Loop
Acknowledge each contributor and describe the action taken in the relevant R&R cycle log:

> *"Feedback Reference: FEEDBACK-<NAME>.md — Addressed in Cycle <NN>. The {YOUR_KEY} placeholder was clarified with a usage example in VS-CODE-AI-HUB-SETUP.md."*

## 📊 DX Impact Reporting

Every 10 R&R cycles, produce a DX Impact Report:

```markdown
# DX Impact Report: Cycles 63-67

## Summary
- Total feedback items collected: <N>
- Issues resolved: <M>
- Average onboarding difficulty: <X>/5

## Top Issues
1. <Issue> → <Resolution>
2. <Issue> → <Resolution>

## Trends
- <Observation about recurring themes>

## Next Steps
- <Planned improvements>
```

## 📚 References

- ITIL v4 Continual Improvement: Section 11.1 (PIR), 11.5 (Participant Feedback Loop)
- R&R-CYCLE-RULES.md: Section 2 (Severity Matrix), Section 3 (Quality Gates)
- Cycle 67: DX Feedback Loop

---

*Feedback is not a bug report — it is the fuel for continual improvement.*
