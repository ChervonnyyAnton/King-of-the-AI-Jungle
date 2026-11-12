# 🌴 King of the AI Jungle — Workshop v1.2.0 | Last Updated: 2026-11-10

> **Theme:** Agentic AI for QA. Local-First. No Cloud. 2-Axis Competence × AI Expertise Model.

## 📋 Project Dashboard
| Status | Progress | Budget |
|--------|----------|--------|
| 🟢 **Live** | 🟢 **Ready** | 💰 **$50.00** |

## 🚀 Quick Start
1. **Open** this folder in VS Code.
2. **Read** `WORKSHOP-CHALLENGE.md` to find your **Jungle Title** (Path Selector).
3. **Run** `npx serve mock/` in the terminal to start the app.
4. **Start** the "Jungle" by copying your path-specific prompt from `AGENTS.md`.

## 📂 Project Structure
*   **`mock/`**: The "Real App" — Sandbox PDF Configurator **v3.1.0-gamification** (Single HTML file with Debug Mode, Data Grid, Error Simulation, Gamification, Mobile Responsive).
*   **`docs/`**: Requirements, Tickets, Templates, and Instructor Guides.
    *   **`docs/project/`**: R&R Cycle Rules and Cycle Review Logs.
    *   **`docs/requirements/TICKETS/`**: Jira ticket files (JIRA-102, JIRA-103, JIRA-104).
    *   **`docs/tools/`**: Instructor quick reference, setup guides, and workshop templates.
*   **`tests/`**: SDET Automation Target (Playwright).
*   **`skills/`**: AI Agent skills for the Adesso AI Hub (VS Code extension).
    *   **`jungle-prompter/`**: Generate role-specific AI prompts by Jungle Title.
    *   **`artifact-validator/`**: Validate AI-generated artifacts against standards.
    *   **`rr-implementer/`**: Enforce existing R&R rules in a repo.
    *   **`rr-executor/`**: Auto-generate R&R rules for any new repository.
*   **`AGENTS.md`**: Adaptive Prompts by Competence & AI Expertise (14 path-specific prompt templates).
*   **`SKILLS.md`**: AI Maturity Roadmap & Tool Proficiency.
*   **`WORKSHOP-CHALLENGE.md`**: Path Selector & Success Criteria (Steps 1–8).
*   **`instructor-dashboard.html`**: Instructor Analytics Dashboard (real-time monitoring, budget heatmap, alert system).

## 🌐 The 2-Axis Competence Model
Participants select their path based on two axes:

| Axis | Description |
|------|-------------|
| **Competence Level** | Manual Tester → QA Engineer → Automation Engineer → QA Architect |
| **AI Expertise** | New to AI → Comfortable with ChatGPT → Expert at Prompt Engineering → AI System Designer |

**Jungle Titles** (18 total): Trail Explorer, River Ranger, Scout Leader, Camp Builder, Jungle Guide, Tactical Planner, Commander, Gear Caster, Mechanic, Master Tinkerer, Automation Wizard, Explorer, Chief Architect, Visionary, King of the Jungle (plus D1–D4, E1–E4 engineer paths).

## 🏛️ Workshop Flow (3 Hours)
1. **Setup & Onboarding** (0:00–0:15) — AI Hub access, VS Code AI Hub config, mock app
2. **Theory & Guided Demo** (0:15–0:45) — Instructor walks through key concepts
3. **Independent Sprint** (0:45–1:15) — Participants work silently on their path
4. **Peer Review** (1:30–2:15) — Complementary pairing across paths
5. **Automation & Review** (1:15–1:30) — Buffer for debugging
6. **Showdown & Judges** (2:30–2:45) — 3-min presentations per participant
7. **Celebration** (2:45–3:00) — Awards, Kudos, Jungle Crown vote

## 🆕 Key Features
- **Dynamic Data Grid:** Toggle-enabled table component with JSON data binding.
- **Error Simulation:** "Simulate Failure" button for testing error handling.
- **Enhanced Debug Mode:** `?debug=true` activates Prompt History, Session Replay, Hallucination Detector, Resource Monitor, and Interactive Debugger (DBG-1 through DBG-9).
- **Strict JSON Schema:** Validates grid data with detailed error messages.
- **Gamification:** Leaderboard sidebar, badge system, achievement toasts, Boss Battle mode, Kudos system.
- **Accessibility:** WCAG 2.1 AA — skip-nav, `prefers-contrast`, focus rings, ARIA labels.
- **Offline Mode:** Local Ollama fallback (`llama3.2`) with constrained prompt syntax.