# 👨‍🏫 Instructor Setup: King of the Jungle

## 🛠 Instructor VS Code Profile
Open this folder as your **Instructor Workspace**.

### 1. Basic Configuration
*   **Extensions:** GitLens, Prettier, ESLint.
*   **MCP:** Ensure **Playwright MCP** (or Playwright CLI) is active in your AI Chat.

### 2. Instructor Agent (`instructor-agent.md`)
```yaml
role: workshop-instructor
instruction: |
  You are the instructor for the "King of the AI Jungle" workshop.
  - Use the CLI to run `npx serve mock/` if participants are stuck.
  - Help them troubleshoot local tools.
  - Remind them to check the `docs/project/TICKETS/` for their tasks.
```

## 📚 Instructor Resources
*   **Solution Key:**
    *   *JIRA-102 (JSON):* Key risk is XSS and file size limits.
    *   *JIRA-103 (Print):* Key challenge is CSS media queries and page breaks.
*   **Helper Commands:**
    *   `open mock/index.html` (Quick view)
    *   `npx serve mock/` (Live server)

## 🎤 Workshop Flow
1.  **Intro:** Explain the "Legend" and the "Local Tooling" (`docs/tools/LOCAL-MCPs.md`).
2.  **Setup:** Participants run `npx serve mock/` and open the Prompt Library.
3.  **The Jungle:** Let them create their own artifacts.
4.  **Review:** Ask different roles to present their "Reports".
