# 🛠️ Workshop Execution Guide: Skills & Tool Usage

> **Use this guide alongside `AGENTS.md` to execute roles effectively in the Adesso AI Hub (VS Code extension).**

## 🖥️ VS Code AI UI Navigation
1. **Open AI Chat:** `Ctrl+Shift+I` (Win/Linux) or `Cmd+Shift+I` (Mac)
2. **Open Agent Panel:** Click `🤖` icon in sidebar → Select `adesso.qwen-sovereign`
3. **Open Tool Panel:** Click `🔧` icon in AI chat → Shows `websearch`, `webfetch`, `filesystem`, `playwright`
4. **Switch Context:** Click `📁` → Select project root `King-of-the-AI-Jungle`

## 🔌 Tool Invocation in VS Code AI
Our agents use these MCP/CLI tools. Invoke them explicitly when needed:

| Tool | VS Code Invocation | Purpose |
|------|-------------------|---------|
| **Filesystem** | `Read /mock/index.html` | Inspect code, verify `data-testid`, check CSS |
| **Playwright** | `Run: npx playwright test` | Execute automation suite |
| **Web Search** | `Search: "Playwright window.print() best practices 2024"` | Find current best practices |
| **Web Fetch** | `Fetch: https://playwright.dev/docs/api/class-playwright` | Read official documentation |
| **CLI** | `Run: npx serve mock/` | Start local dev server |

---

## 📈 AI Maturity Roadmap

This roadmap helps you level up your AI expertise throughout the workshop.

### Level 1: Beginner (The Scribe)
**Goal:** Use AI to format, brainstorm, and search.
- ✅ **Tools to Master:** Basic text prompts, `websearch` for facts.
- ✅ **Skills:** Copy-pasting AI output, asking for "5 examples", "write a table".
- 🎯 **Workshop Task:** Generate a list of test cases or risks using simple prompts.

### Level 2: Intermediate (The Assistant)
**Goal:** Use AI as a structured tool with context.
- ✅ **Prerequisites:** You can use basic text prompts and `websearch` to find facts (Level 1).
- ✅ **Tools to Master:** `webfetch` for docs, `filesystem` to read/write files, budget tracking.
- ✅ **Skills:** Providing context (e.g., "Read JIRA-102.md then do X"), using prompt templates, tracking `BUDGET-LOG.md`.
- 🔗 **Bridging Insight:** At Level 1, you asked AI to do things. At Level 2, you give AI *context* about what to do and *where* to find the information. This transforms AI from a scribe into a tool you direct.
- 🎯 **Workshop Task:** Create a Test Plan by feeding requirements to AI and formatting the output.

### Level 3: Advanced (The Co-Pilot)
**Goal:** Orchestrate AI for complex reasoning and debugging.
- ✅ **Prerequisites:** You can provide context and use structured prompts with budget tracking (Level 2).
- ✅ **Tools to Master:** Multi-turn prompts, context pruning, error handling.
- ✅ **Skills:** Asking "Why did this fail?", "Critique this test plan", "Simulate a user flow".
- 🔗 **Bridging Insight:** At Level 2, you gave AI a single task with context. At Level 3, you engage in *dialogue* with AI — asking follow-up questions, critiquing outputs, and simulating scenarios. This is where AI becomes a thinking partner.
- 🎯 **Workshop Task:** Debug a failing test by analyzing logs and AI suggestions, or critique requirements for gaps.

### Level 4: Expert (The Architect)
**Goal:** Design systems, optimize economy, and mentor.
- ✅ **Prerequisites:** You can orchestrate multi-turn AI reasoning, critique outputs, and debug failures (Level 3).
- ✅ **Tools to Master:** Token optimization, multi-agent workflows, CI/CD integration.
- ✅ **Skills:** Designing prompt libraries, defining ROI models, creating reusable automation patterns.
- 🔗 **Bridging Insight:** At Level 3, you used AI to solve problems. At Level 4, you *design systems* that use AI — optimizing for cost, scalability, and team-wide reuse. You become the mentor who elevates others.
- 🎯 **Workshop Task:** Design a CI/CD pipeline or a "Token Economy" strategy for the team.

### ✅ Level Gateway Self-Assessment
Before advancing to the next level, confirm you can do the following *without AI assistance*:
- **Level 1 → 2:** Can you explain what "context" means in a prompt? Can you describe 2 things AI tracked in BUDGET-LOG.md?
- **Level 2 → 3:** Can you articulate why a test failed and propose a fix? Can you write a prompt that asks AI to critique something?
- **Level 3 → 4:** Can you explain your token usage patterns? Can you design a reusable prompt template that others could use?

---

## 💡 Context Management Rules
- **Prune Context:** If the agent struggles, ask it to "Summarize only relevant sections of `docs/requirements/TICKETS/`".
- **Tool-First:** Prefer direct tool calls over long descriptive prompts.
- **Chain-of-Thought:** Enable only for complex risk analysis or architecture decisions.

## 🌐 Internet Research Protocol
When using the **Researcher** role:
1. Start with `websearch` to identify authoritative sources.
2. Use `webfetch` to extract exact specs or examples.
3. Output a structured summary to `docs/project/RESEARCH-FINDINGS.md`.
4. **Budget Rule:** Max 2 research queries per session. Use Sovereign model.

## 🧪 Playwright in VS Code (SDET Focus)
1. Install extension: `@playwright/test`
2. Open `tests/jira-102.spec.ts` → Click `▶ Run Test` or `🐛 Debug Test`
3. View report: `npx playwright show-report` → Opens in browser
4. Add breakpoints: Click left gutter → Set red dot → Step through UI interaction

---

*Execute tools precisely. Respect context limits. Stay within budget.*