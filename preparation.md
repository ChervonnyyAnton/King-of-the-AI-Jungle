# 🌴 Pre-Workshop Preparation: King of the AI Jungle

Welcome to the **King of the AI Jungle**! 🦁
This workshop is **Local-First**, **Cloud-Agnostic**, and **Self-Contained**.

## 📋 Day-0 Checklist
- [ ] Install VS Code & latest Node.js
- [ ] Clone/Extract `King-of-the-AI-Jungle` folder
- [ ] Configure the AI Hub in VS Code (see `docs/tools/VS-CODE-AI-HUB-SETUP.md`)
- [ ] Run `npx serve mock/` → Verify app loads (default port 3000, or check terminal output for actual port)
- [ ] Read `WORKSHOP-CHALLENGE.md` & find your **Jungle Title**

## 🧠 AI Hub & Budget Strategy ($50 Limit)
We use the **Adesso AI Hub** in VS Code. Strict budget rules apply:
1. **Sovereign First:** `qwen-3.6-35b-sovereign` handles 90% of tasks.
2. **Cloud Fallback:** `gpt-4-turbo` only for web research or complex reasoning.
3. **Token Limits:** `max_tokens: 8192`. Avoid long context dumps.
4. **Tracking:** Log usage in `BUDGET-LOG.md`. Alert at $45.
5. **Optimization:** Use CoT sparingly. Prefer structured prompts.

## 📂 Project Structure
- `mock/`: Production App (Single HTML file)
- `docs/`: Jira/Confluence Sandbox (Requirements, Specs, Tickets)
- `tests/`: SDET Automation Target
- `AGENTS.md`: Master Configuration (Start Here)
- `SKILLS.md`: VS Code Execution & Tool Usage Guide

## 🚀 Quick Start
1. Open folder in VS Code.
2. Load role from `AGENTS.md`.
3. Execute STLC phases per `STLC-MAP.md`.
4. Track budget in `BUDGET-LOG.md`.

## 🏆 Success Metrics (By Path)
- **Scouts (A/B/C Paths):** Clear test plans, risk analysis, and budget tracking.
- **Engineers (D/E Paths):** Robust Playwright suite, 100% pass rate, CI/CD design.
- **Architects (F Path):** Comprehensive quality model, AI integration strategy, and team impact.

---

*Good luck. Build the Jungle. Win the Jungle.* 🌿
