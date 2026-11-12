# 🔄 Review & Remediation: Cycle 219 — Setup & Onboarding Experience

## 🎯 Objective
Audit `setup-checklist.sh`, `PARTICIPANT-PREREQUISITES.md`, `preparation.md`, `INSTRUCTOR-QUICK-REF.md` for cross-references, broken links, first-run friction, and XP rules (shell-agnostic, cross-OS).

## 📋 Findings & Remediation

| # | Area | Finding | Severity | 2-Axis Impact | Remediation |
|---|------|---------|----------|---------------|-------------|
| 1 | **setup-checklist.sh — Git Required but Should Be Optional** | Git is checked as a hard pass (line 13–18). But `PARTICIPANT-PREREQUISITES.md` Section 3 says "Git Basics (Optional but recommended)". A participant who only needs to run `npx serve mock/` and use AI chat doesn't need Git. The checklist should use a warning, not a failure, for missing Git. | **Medium** | All Paths — non-engineer participants can start the workshop without Git | Change Git check from `((FAIL++))` to `⚠️ Git not found — recommended for tracking changes but optional for basic workshop use`. |
| 2 | **setup-checklist.sh — Pass Threshold vs. PARTICIPANT-PREREQUISITES.md** | Script threshold: `FAIL ≤ 2` = warning, `FAIL > 2` = hard stop. PARTICIPANT-PREREQUISITES.md says "If any check fails: Do not enter the jungle." The INSTRUCTOR-QUICK-REF.md says "Verify all participants show ≥3 green checks." The script has 5 explicit checks (Git, Node, npm, opencode.json, mock/index.html) + 1 optional (Playwright). With the Git fix, the max hard-fail count drops to 3, making `FAIL ≤ 2` inconsistent with "any failure = hard stop" for the core checks. | **Medium** | All Paths — inconsistent pass criteria confuse participants and instructors | Add a comment explaining the threshold: "FAIL ≤ 1 is a soft warning (e.g., Playwright missing for non-engineers); FAIL ≥ 2 requires instructor intervention." |
| 3 | **setup-checklist.sh — Bash-Specific Syntax** | Uses `((PASS++))` and `((FAIL++))` which are bash arithmetic extensions, not POSIX sh portable. A participant running `sh setup-checklist.sh` will get errors. The shebang is `#!/bin/bash` so this is correct for bash, but the script should note that bash/zsh is required (not sh). | **Low** | All Paths — sh-based shells (dash on Ubuntu) will fail | Add a note: "Requires bash or zsh. If using sh, run `bash setup-checklist.sh` explicitly." |
| 4 | **preparation.md — Line 10 — Wrong Default Port** | `preparation.md` line 10 says "Verify app loads at `http://localhost:3000`". But `npx serve` defaults to port 3000 only if 3000 is free. If another process uses 3000, serve auto-selects the next available port (e.g., 3001). Participants following this instruction will be confused if the app loads on port 3001. | **Low** | All Paths — first-run friction from incorrect port assumption | Change to: "Verify app loads (default port 3000, or check terminal output for the actual port)." |
| 5 | **INSTRUCTOR-QUICK-REF.md — Delivery Flow vs. Agenda Mismatch** | The "3-Hour Delivery Flow" table (lines 91–102) has different segment names and times than `agenda.md`. For example: instructor ref has "Theory & Jungle Legend" while agenda has "Theory & Guided Demo"; instructor ref has "Break" at 01:15 while agenda has "Debug Buffer". This is the second delivery flow definition and participants/instructors may follow the wrong one. | **Medium** | All Paths — conflicting schedules cause instructor confusion and timing issues | The agenda.md is the authoritative schedule (more detailed, includes Debug Buffer, Peer Review details, Boss Battle). Update the delivery flow in INSTRUCTOR-QUICK-REF.md to reference agenda.md as the source of truth. |
| 6 | **Cross-Reference — INSTRUCTOR-QUICK-REF.md References Section 7 but Section Numbers May Shift** | Multiple places in the doc reference "Section 7" (Complementary Pairing Strategy), "Section 5" (Judging Rubric Validation). Since this is a single monolithic file, section numbering is fragile. If content is added, sections shift and references break. | **Low** | Architects (F1–F4) — instructor referencing wrong section causes training issues | Add anchor links to internal references (e.g., `[Section 7: Complementary Pairing](#7-complementary-pairing-strategy)`). |
| 7 | **PARTICIPANT-PREREQUISITES.md — Line 17 — Dead Reference** | Line 17 says "run `VS-CODE-AI-HUB-SETUP.md`" — but this is a filename, not a command. Participants would need to know they should "open" or "read" this file, not "run" it. | **Low** | Scouts (A1–A4) — first-run participants won't know how to "run" a Markdown file | Change to: "open `docs/tools/VS-CODE-AI-HUB-SETUP.md` and follow the setup steps." |

## 📂 Updated Files
- `setup-checklist.sh`: Git is now a warning (not a hard fail); added POSIX compatibility note; clarified pass threshold comment.
- `preparation.md`: Fixed port assumption to note dynamic port selection.
- `INSTRUCTOR-QUICK-REF.md`: Added internal anchor links; updated delivery flow to reference `agenda.md`.
- `PARTICIPANT-PREREQUISITES.md`: Fixed "run VS-CODE-AI-HUB-SETUP.md" to "open and follow".

## 🧪 Validation
- [x] All cross-referenced files exist: VS-CODE-AI-HUB-SETUP.md ✓, STLC-MAP.md ✓, SKILLS.md ✓
- [x] setup-checklist.sh runs successfully with current environment
- [x] No broken internal references in any onboarding document
- [x] Shell compatibility note added

## 📐 Risk Assessment
- **Risk Score:** 2 × 3 = **6** → **Medium**
- **Probability:** Possible (2) — first-run participants will encounter port mismatches and setup confusion.
- **Impact:** Medium — bad first-run experience reduces workshop engagement and trust in materials.
