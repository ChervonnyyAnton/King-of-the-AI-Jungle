# 🌳 King of the AI Jungle: Participant Prerequisites

> **Welcome, Jungle Explorer.** Before you enter the wild, check this list. It covers the hard requirements, domain knowledge, and mindset you'll need to complete your mission and earn your Jungle Title.

---

## 🔑 Hard Technical Prerequisites (Day-0 Must-Haves)

| Item | Requirement | How to Verify |
|------|-------------|---------------|
| **Terminal Access** | Bash/Zsh shell (macOS/Linux) or PowerShell (Windows) | Run `echo $SHELL` or `echo $PROMPT_COMMAND` |
| **VS Code** | Latest stable version | `code --version` |
| **Node.js / npm** | v18+ (LTS recommended) | `node -v` and `npm -v` |
| **AI Hub Access** | AI Hub configured in VS Code with active API key | Run `./setup-checklist.sh` — must show ✅ for all checks |
| **Internet Access** | Required for `websearch`/`webfetch` tool calls (local-first, but research requires outbound) | Ping `example.com` or run `npx websearch "test"` |

> ⚠️ **If any check fails:** Do not enter the jungle. Consult the instructor or open `docs/tools/VS-CODE-AI-HUB-SETUP.md` before the workshop starts.

---

## 📚 Domain Knowledge Requirements

### 1. QA Fundamentals (Required for All Paths)
You do **not** need to be an expert, but you must be comfortable with:
- **Test Case Design:** Writing clear, actionable test steps with expected results.
- **Risk Identification:** Understanding what "High/Critical" means in a QA context (e.g., security, data loss, usability breakage).
- **ISTQB Awareness:** Familiarity with basic test design techniques (Equivalence Partitioning, Boundary Value Analysis, Decision Tables). If you don't know them, the workshop will teach you how to use AI to apply them.
- **Traceability:** Understanding how requirements → test cases → defects connect.

### 2. AI & Prompting Awareness (Required for All Paths)
- **Level 1 (Beginner):** Comfort giving plain-text instructions to an AI chat. Understands that AI output needs verification.
- **Level 2 (Intermediate):** Can attach context to prompts (e.g., "Read file X, then do Y"). Understands token budget basics.
- **Level 3 (Advanced):** Familiar with multi-turn conversations, prompting for critique/simulation, and reading error logs.
- **Level 4 (Expert):** Understands system design, token optimization, and can evaluate AI output against quality standards.

> 💡 **You will be placed on a path matching your *current* level.** The workshop is designed to elevate you to the next level. No prior AI expertise is mandatory, but honesty in self-assessment is critical for your learning path.

### 3. Tooling & Workflow Skills
| Skill | Why It Matters | Minimum Expectation |
|-------|----------------|---------------------|
| **Reading Markdown** | All requirements, prompts, and artifacts use Markdown | Can open `.md` files, read tables, follow checklists |
| **Basic CLI Navigation** | You'll run servers, checklists, and Playwright tests | `cd`, `ls`, `cat`, `code .` |
| **Git Basics** (Optional but recommended) | Track changes, diff artifacts, commit work | `git status`, `git diff`, `git add`, `git commit` |
| **Playwright Fundamentals** (Engineers/SDET only) | Automation paths require writing/running `.spec.ts` files | Understand selectors, assertions, page navigation |
| **JSON Awareness** (All paths) | The sandbox app uses JSON for data binding/grid rendering | Can read basic JSON structure, spot syntax errors |

---

## 🧠 Soft Skills & Mindset

| Skill | Workshop Application |
|-------|----------------------|
| **Time Boxing** | You will have strict time limits per phase. Practice saying "good enough for now" and moving on. |
| **Peer Review Openness** | You will critique and be critiqued. Focus on artifacts, not people. |
| **Budget Discipline** | You have a $50 token budget. Track it. Wasteful prompting will cost you points. |
| **AI Skepticism** | AI hallucinates. Every output must be fact-checked against `docs/requirements/` or `mock/index.html`. |
| **Adaptability** | The sandbox app will intentionally break or behave unexpectedly. Your job is to debug, document, and adapt. |

---

## 🗺️ Self-Assessment Matrix: Pick Your Path

Answer these honestly. Your answers map directly to the **Path Selector** in `WORKSHOP-CHALLENGE.md`.

### A. QA Competence (Select one)
| If you mostly... | You are a... |
|------------------|--------------|
| Execute test cases, do exploratory testing, brainstorm risks | **Manual Tester** |
| Write test plans, analyze requirements, build traceability | **QA / Test Engineer** |
| Manage reports, process, risk registers, coordinate teams | **QA / Test Manager** |
| Write UI/API automation scripts, run test suites | **QA Automation Engineer** |
| Design test frameworks, CI/CD pipelines, deep debugging | **SDET** |
| Define quality strategy, system architecture, ROI modeling | **Architect** |

### B. AI Expertise (Select one)
| If you mostly... | You are a... |
|------------------|--------------|
| Use AI for brainstorming, formatting, basic searches | **Beginner (Level 1)** |
| Give structured prompts, track budget, use `websearch`/`webfetch` | **Intermediate (Level 2)** |
| Orchestrate multi-turn reasoning, critique outputs, debug with AI | **Advanced (Level 3)** |
| Design multi-agent workflows, optimize token economy, mentor others | **Expert (Level 4)** |

> 🎯 **Combine your A + B** → Look up your Jungle Title in the Path Selector table. *Example: Manual Tester + Beginner = Trail Explorer (A1).*

---

## 📋 Recommended Pre-Work (Do This 48h Before)

| Task | Time | Outcome |
|------|------|---------|
| **Install Environment** | 30 min | VS Code, Node.js, AI Hub configured. Run `setup-checklist.sh` successfully. |
| **Read `WORKSHOP-CHALLENGE.md`** | 15 min | Identify your Jungle Title and Primary Goal. |
| **Explore `mock/index.html`** | 10 min | Open `npx serve mock/`. Click buttons. Break things. Notice the Debug Mode (`?debug=true`). |
| **Scan `AGENTS.md`** | 10 min | Read your path's prompt block. Copy it to a scratch file. No need to execute yet. |
| **Prepare Your Mindset** | 5 min | Accept that AI will make mistakes. Your job is to guide, verify, and document. |

---

*You have what it takes. Review this list, pick your path, and step into the jungle.* 🌴
