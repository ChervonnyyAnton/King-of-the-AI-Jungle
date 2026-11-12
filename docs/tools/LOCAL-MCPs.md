# 🧰 Local Tools & Environment

Since we are in a sandbox, we simulate the production environment using local tools.

## 🚀 Running the App
To view and test the application, you must run it as a local web server:
```bash
npx serve mock/
# It will run at http://localhost:3000
```

## 🤖 AI Tools (MCPs)
Our agents use the following local tools to interact with the sandbox:

| Tool | Role | Capability |
|------|------|------------|
| **Playwright MCP** | SDET | Visualize the page, simulate clicks, validate UI behavior. |
| **Filesystem** | Analyst | Read requirements (`docs/`), code (`mock/`), and tickets. |
| **ESLint** | Architect | Analyze `mock/index.html` for syntax errors and bad practices. |
| **CLI (Node)** | Dev/QA | Run JSON validation scripts or simple logic checks. |

## 💡 Why this setup?
This mimics a real-world "Local-First" development workflow, ensuring the AI can only test what it can actually see and touch.
