# 👨‍🏫 Instructor Delivery Checklist: King of the AI Jungle

## ⏱ Workshop Timeline (3 Hours)
| Time | Segment | Action |
|------|---------|--------|
| 00:00-00:15 | Setup & Check | Run `npx serve mock/`, verify local access, collect pre-work checklist. |
| 00:15-00:25 | Theory & Legend | Explain `WORKSHOP-CHALLENGE.md`, budget rules, and role tiers. |
| 00:25-00:45 | Guided Demo | Run **Risk Analyst** prompt on `JIRA-102.md`. Show output in `RISK-ANALYSIS.md`. |
| 00:45-01:15 | Independent Sprint | Participants pick tier. Instructor circulates, answers questions, tracks budget. |
| 01:15-01:30 | Break | 15 min pause. |
| 01:30-02:15 | Automation & Review | SDETs run Playwright. Others review artifacts. Swap roles for peer feedback. |
| 02:15-02:45 | Showdown & Judges | 3 teams present. Score on: Traceability, Code Quality, Budget Compliance. |
| 02:45-03:00 | Wrap-up & Feedback | Collect `BUDGET-LOG.md`, distribute feedback QR, close. |

## 🎯 Judging Criteria
1. **Completeness:** All deliverables from `WORKSHOP-CHALLENGE.md` present.
2. **Traceability:** Every test case links to a ticket ID.
3. **Budget:** `BUDGET-LOG.md` under $50, clear model usage.
4. **Code Quality:** Playwright tests use `data-testid`, assertions are robust.
5. **Risk Depth:** Identifies XSS, DoS, and edge cases, not just UI bugs.

## 🆘 Instructor Fallback Scripts
- **Agent hangs?** Restart VS Code AI Chat. Check `opencode.json` syntax.
- **Budget warning?** Force switch all agents to `qwen-sovereign`.
- **Playwright fails?** Verify `npx playwright install` ran. Check `playwright.config.js`.
- **App not loading?** Run `npx serve mock/` in a new terminal. Ensure port 3000 is free.

---

*Print this checklist. Keep it visible during delivery.*
