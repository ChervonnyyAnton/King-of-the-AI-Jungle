# 🔄 Review & Remediation: Cycle 211 — Agenda Alignment & Workshop Scope Consistency

## 🎯 Objective
Audit and align the workshop agenda (`agenda.md`) with the actual workshop format documented in `WORKSHOP-CHALLENGE.md` and `README.md`.

## 📋 Findings & Remediation

| # | Area | Finding | Severity | Rule | Remediation |
|---|------|---------|----------|------|-------------|
| 1 | **Agenda vs Workshop Mismatch** | `agenda.md` describes a ~2h15m CLI-agent-building workshop (e.g., "CLI-Befehl → Agentenerstellung", "Eigene/Repo-Agenten ausprobieren", "Claude Desktop Vergleich"). The actual workshop is a 3-hour QA-focused workshop with AGENTS.md prompts, mock app testing, Playwright specs, and gamification. This is a **High** inconsistency — instructors would follow the wrong script. | **High** (P4 × I4 = 16 → Critical) | **DOC-1** (Broken Reference Audit), **Pedagogy** domain | Replace `agenda.md` content with the actual workshop flow from `README.md` Step 5 (3-hour structure): Setup & Onboarding (0:00–0:15), Theory & Guided Demo (0:15–0:45), Independent Sprint (0:45–1:15), Peer Review (1:30–2:15), Automation & Review (1:15–1:30), Showdown & Judges (2:30–2:45), Celebration (2:45–3:00). Add German translations to match DACH context. |
| 2 | **Missing Time Buffers** | The agenda has no explicit buffer time between the Independent Sprint and Peer Review phases. In practice, participants often need 10–15 min extra for debugging. | **Medium** (P3 × I2 = 6) | **Pedagogy** | Add a 15-minute "Debug Buffer" phase between Sprint (ends 1:15) and Peer Review (starts 1:30), explicitly labeled as buffer for debugging and extending Sprint work. |
| 3 | **Agenda Language Inconsistency** | `agenda.md` is in German but all other workshop materials are in English (except `WORKSHOP-CHALLENGE-DE.md`). The workshop is bilingual by design (DACH context), so the agenda should either be fully bilingual or consistently match the English base with a German variant. | **Medium** (P2 × I3 = 6) | **DOC-1** | Create `agenda-de.md` (German version) and keep `agenda.md` in English. Both should share identical timing and structure. The German version aligns with `WORKSHOP-CHALLENGE-DE.md`. |

## 📂 Updated Files
- `agenda.md`: Replaced outdated CLI-agent agenda with the actual 3-hour QA workshop flow, aligned with README.md structure.
- `agenda-de.md`: Created new German-language agenda mirroring the English version.

## 🧪 Validation
- [x] Agenda now matches the actual workshop format described in README.md and WORKSHOP-CHALLENGE.md
- [x] German variant created to support bilingual DACH delivery
- [x] Time buffer added between Sprint and Peer Review phases
- [x] No other artifacts reference the old agenda format

## 📐 Risk Assessment
- **Risk Score:** 2 × 3 = **6** → **Medium**
- **Probability:** Possible (2) — participants may have cached notes from the old agenda format.
- **Impact:** Medium — agenda directly impacts instructor delivery flow; misalignment causes confusion in setup and pacing.
