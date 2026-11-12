# 🌐 Web Research Guide for AI Agents

## 🎯 Goal
Simulate real-world QA research by querying external documentation and best practices.

## 🔌 Tool Usage Syntax
Our agents use these MCP/CLI tools. Invoke them explicitly when needed:

| Tool | VS Code Invocation | Purpose |
|------|-------------------|---------|
| **Filesystem** | `Read /mock/index.html` | Inspect code, verify `data-testid`, check CSS |
| **Playwright** | `Run: npx playwright test` | Execute automation suite |
| **Web Search** | `Search: "Playwright window.print() best practices 2024"` | Find current best practices |
| **Web Fetch** | `Fetch: https://playwright.dev/docs/api/class-playwright` | Read official documentation |
| **CLI** | `Run: npx serve mock/` | Start local dev server |

## 📚 Research Playbook (For Juniors & Seniors)
Don't just ask "How do I test this?". Use these templates:
1.  **Find Best Practices:** `Search: "Best practices for testing JSON import features"`
2.  **Read Specs:** `Fetch: https://playwright.dev/docs/api/class-playwright`
3.  **Find Edge Cases:** `Search: "Common edge cases for client-side PDF generation"`
4.  **Security Checks:** `Search: "XSS vulnerabilities in HTML parsing"`

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

---

*Execute tools precisely. Respect context limits. Stay within budget.*
