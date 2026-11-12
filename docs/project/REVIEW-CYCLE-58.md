# 🔄 Review & Remediation: Cycle 58

## 🎯 Objective
Address **Cognitive Load** for "Beginner AI" participants by applying **Chunking** principles to AGENTS.md prompt templates, preventing information overload during the workshop.

## 📋 Domain: Pedagogy / Andragogy — Cognitive Load Theory

### 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **AGENTS.md — Beginner Prompts** | Beginner AI prompts (Trail Explorer, Camp Builder, Camp Coordinator, Gear Caster, Pathfinder, Explorer) contain 3–4 multi-step instructions in a single YAML block. For participants who describe themselves as "AI is a Scribe" (AI Level 1), this creates excessive cognitive load. Novice learners struggle when presented with multiple sequential tasks they have never encountered before. | **High** | **Scouts (A/B/C) & Engineers (D) — Level 1 Paths:** Trail Explorer, Camp Builder, Camp Coordinator, Gear Caster, Pathfinder, Explorer — participants may abandon the task out of confusion rather than complete it. | Add Section 13.1 — **Cognitive Load & Chunking Rule** to `R&R-CYCLE-RULES.md`. Updated the "Beginner AI" prompt templates in `AGENTS.md` to use single-step instructions (max 2 steps per block), with clear sequential numbering and optional "next step" references. |
| **AGENTS.md — Prompt Density** | The AGENTS.md file itself is ~250 lines long. A Beginner participant must scan the entire document to find their Jungle Title block, increasing extraneous cognitive load before even starting a task. | **Medium** | **All Level-1 Paths:** Extraneous load from navigating a dense document. | Add guidance in the Start Here Checklist to point participants to `WORKSHOP-CHALLENGE.md` first, then jump directly to their specific prompt block via section heading rather than scanning the full file. |

## 🧠 Pedagogical Analysis — Cognitive Load Theory (Sweller, 1988)

**Intrinsic Load** (task complexity): The workshop tasks themselves are appropriately scoped — generating test cases, reading requirements, writing simple Playwright scripts.

**Extraneous Load** (poor design): The current Beginner AI prompts in AGENTS.md ask participants to:
1. Read a file
2. Execute a tool call
3. Generate output
4. Save to a file

Four sequential steps in a single prompt block overwhelm novice users who lack mental models for these concepts. This violates the **Chunking Principle**: information should be presented in small, self-contained units that match the learner's current expertise level.

**Germane Load** (schema construction): Participants should spend their cognitive capacity building schemas for QA concepts (test case design, risk analysis) — not figuring out how to use the AI tool.

## 📂 Updated Files
- `docs/project/R&R-CYCLE-RULES.md`: Added Section 13.1 — **Cognitive Load & Chunking Rule**.
- `AGENTS.md`: Beginner AI prompt blocks simplified to 1–2 steps maximum per block. Added a "How to Use This Block" helper line to each.

## 📝 Action Items
1. [ ] Pilot the simplified Beginner prompts in the next workshop delivery with Trail Explorer (A1) and Camp Builder (B1) participants.
2. [ ] Survey participants on prompt clarity using a 5-point Likert scale ("The prompt instructions were easy to follow").
3. [ ] If ≥80% rate clarity ≥4/5, propagate the chunking pattern to Intermediate and Advanced blocks in a subsequent cycle.

## 🧪 Validation
- [ ] Workshop Stability Check — Simplified prompts still produce valid artifacts.
- [ ] Instructor Script Consistency — Instructor can explain the new block format in <30 seconds.
- [ ] Version Alignment — AGENTS.md start checklist still points participants correctly.
