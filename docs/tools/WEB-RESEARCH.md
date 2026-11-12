# 🌐 Internet Research Guide for AI Agents

## 🎯 Goal
To simulate a real-world QA scenario where agents must research **Best Practices** and **Potential Pitfalls** before executing tests.

## 🛠 How to Research
Our agents use the following tools to gather information:

| Tool | Purpose | Example Usage |
|------|---------|---------------|
| **`websearch`** | Find general info or documentation | "Search for 'client-side PDF generation best practices'." |
| **`webfetch`** | Read a specific URL | "Fetch the contents of 'https://playwright.dev/docs/api/class-playwright'." |

## 📚 Research Topics for the Sandbox
Participants should ask their "Researcher" Agent to investigate:
1.  **PDF Generation:** "What are the best libraries for client-side PDF generation in 2024?"
2.  **Playwright Printing:** "How to handle `window.print()` in Playwright?"
3.  **Security:** "What are common XSS vulnerabilities in JSON Import features?"

## ⚠️ Budget Note
Research can be **token-expensive**.
- **Tip:** Ask the agent to "Summarize the top 3 points" rather than "Fetch the whole page."
- **Strategy:** Use the **Sovereign Model** for research queries whenever possible.
