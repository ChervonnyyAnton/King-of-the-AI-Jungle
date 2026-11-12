# 🚀 Implementation Guide: The "Markdown Sandbox"

Welcome to the **King of the AI Jungle**.
In this workshop, we simulate a real project using **Markdown files** as our source of truth.

## 🏗 The Sandbox Architecture
*   **`mock/index.html`**: The "Application". It is a client-side PDF generator tool.
*   **`docs/requirements/`**: The "Jira/Confluence". This is where you will create your artifacts.
*   **`AGENTS.md`**: The "Brain". This contains all Agent Roles (Skills) mapped to your Jungle Title.

## 🛠 Step-by-Step Setup

### 1. Open the Project
Open the `King-of-the-AI-Jungle` folder in VS Code.

### 2. Load a Persona
Find your Jungle Title in `WORKSHOP-CHALLENGE.md` (or `WORKSHOP-CHALLENGE-DE.md` for German), then copy the corresponding prompt block from `AGENTS.md` into your AI Chat.

### 3. Your Mission (The "Jungle")
*   **Manager:** Analyze the HTML file for risks. Create `docs/requirements/RISK-ANALYSIS.md`.
*   **Designer:** Read the HTML logic. Create a test suite in `docs/requirements/TEST-PLAN.md`.
*   **SDET:** Write a Playwright script to test the "Export" flow in `docs/automation/test.spec.ts`.
*   **Architect:** Create a `TEST-STRATEGY.md` defining the Test Pyramid.

## 💡 Pro-Tip
Since we are simulating a real environment, treat your Markdown files like real tickets. Use IDs like `TEST-001` or `DOC-001` to link your artifacts together.

---

*No real data is stored or sent. This is a safe, local simulation.*
