# 🌴 King of the AI Jungle: Workshop Challenge

> **Welcome to the Jungle.** Today, you are not just a participant—you are a specialist navigating the wilds of Agentic AI.
> This workshop is designed for the **DACH enterprise context**. All examples use European compliance standards (DSGVO/GDPR, BSI IT-Grundschutz) and German corporate terminology.
> Your path through the jungle depends on two factors: your **QA Competence** and your **AI Expertise**.
> Find your combination below to discover your official **Jungle Title** and your specific mission.

---

## 🔑 Resource Prerequisites

**Before starting,** verify your setup by running `./setup-checklist.sh` in your terminal.
You need:
- ✅ VS Code with AI extension installed
- ✅ Node.js / npm available
- ✅ VS Code AI Hub configured
- ✅ Access to the mock app (`mock/index.html`)

If any check fails, consult the instructor or `INSTRUCTOR-QUICK-REF.md` Section 2 (Resource Allocation Checklist) for fixes.

---

## 🧭 Step 1: Find Your Jungle Title

### 📊 Competence Axis (What you do in QA)
| ID | Role | Focus |
|----|------|-------|
| **1** | **Manual Tester** | Test cases, exploratory testing, risk brainstorming. |
| **2** | **QA / Test Engineer** | Test planning, requirement analysis, traceability. |
| **3** | **QA / Test Manager** | Reporting, process, risk management, team coordination. |
| **4** | **QA Automation Engineer** | Test scripts, UI interaction, API testing. |
| **5** | **SDET** | Framework design, CI/CD, advanced debugging. |
| **6** | **Architect** | Strategy, system design, cost/budget modeling. |

### 🤖 AI Expertise Axis (How you use AI)
| ID | Level | Definition |
|----|-------|------------|
| **1** | **Beginner** | AI is a "Scribe". You use it for brainstorming, formatting, and basic searches. |
| **2** | **Intermediate** | AI is an "Assistant". You use structured prompts, track budget, and use `websearch`/`webfetch`. |
| **3** | **Advanced** | AI is a "Co-Pilot". You orchestrate multi-turn reasoning, prune context, and critique outputs. |
| **4** | **Expert** | AI is an "Architect". You design multi-agent workflows, optimize token economy, and mentor others. |

### 🗺️ The Path Selector (Competence × AI Expertise)

| Path ID | Your Role | AI Level | Your Jungle Title | Primary Goal |
|---------|-----------|----------|-------------------|--------------|
| **A1** | 1 | 1 | **Trail Explorer** | Generate high-quality test cases and risk lists with AI guidance. |
| **A2** | 1 | 2 | **River Ranger** | Use AI to find best practices and structure your test plans. |
| **A3** | 1 | 3 | **Scout Leader** | Orchestrate AI to critique requirements and find hidden risks. |
| **A4** | 1 | 4 | **Alpha Scout** | Train AI to act as a junior tester and validate your work. |
| **B1** | 2 | 1 | **Camp Builder** | Use AI to structure test plans and traceability matrices. |
| **B2** | 2 | 2 | **Jungle Guide** | Leverage AI for gap analysis and comprehensive test design. |
| **B3** | 2 | 3 | **Tactical Planner** | Use AI to simulate test execution and predict coverage gaps. |
| **B4** | 2 | 4 | **Grand Strategist** | Design the entire test strategy and automate AI reporting. |
| **C1** | 3 | 1 | **Camp Coordinator** | Use AI to draft reports and track budget efficiently. |
| **C2** | 3 | 2 | **Logistics Chief** | Automate progress tracking and risk reporting with AI. |
| **C3** | 3 | 3 | **Commander** | Manage AI agents to simulate a full QA sprint. |
| **C4** | 3 | 4 | **Jungle King** | Optimize the entire QA workflow and token economy for ROI. |
| **D1** | 4 | 1 | **Gear Caster** | Let AI write boilerplate Playwright/Bruno tests for you. |
| **D2** | 4 | 2 | **Mechanic** | Use AI to debug tests and generate robust selectors. |
| **D3** | 4 | 3 | **Master Tinkerer** | Architect complex automation patterns with AI assistance. |
| **D4** | 4 | 4 | **Automation Wizard** | Design self-healing tests and AI-driven test generation pipelines. |
| **E1** | 5 | 1 | **Pathfinder** | Use AI to scaffold framework architecture and CI/CD steps. |
| **E2** | 5 | 2 | **Trap Architect** | Design advanced debugging and performance testing with AI. |
| **E3** | 5 | 3 | **System Weaver** | Integrate AI into the test lifecycle for continuous quality. |
| **E4** | 5 | 4 | **Code Sorcerer** | Build custom AI tools for test automation and ecosystem analysis. |
| **F1** | 6 | 1 | **Explorer** | Use AI to model risks and propose high-level quality strategies. |
| **F2** | 6 | 2 | **Chief Architect** | Define the QA architecture and AI integration strategy. |
| **F3** | 6 | 3 | **Visionary** | Simulate multi-agent QA systems and forecast quality metrics. |
| **F4** | 6 | 4 | **King of the Jungle** | Master the entire ecosystem: AI, QA, Budget, and People. |

---

## 📋 Step 2: Your Mission (By Path Group)

### 🟢 Group 1: The Scouts (Manual & Managerial Paths: A1-A4, B1-B4, C1-C4)
**Focus:** Strategy, Risk, and Reporting.
1.  **Risk & Analysis:** Use AI to analyze `docs/requirements/TICKETS/` and identify gaps, XSS risks, or edge cases. Include a **DSGVO/Compliance** risk category alongside technical, security, and UX risks. Focus on European enterprise scenarios: "ECC-Compliance-Prüfung" (ECC Compliance Check), "DSGVO-Datenschutzanalyse" (GDPR Data Protection Analysis), "Sicherheitsaudit" (Security Audit). Output `docs/requirements/RISK-ANALYSIS.md` (ISO/IEC/IEEE 29119-3 §5.4 compliant). **Phase Exit Gate:** Risk register complete with mitigations for all Critical/High risks.
2.  **Test Design:** Generate test scenarios (Positive, Negative, Accessibility) using at least 3 ISTQB Test Design Techniques. Output `docs/requirements/TEST-PLAN.md` (ISO/IEC/IEEE 29119-3 §5.3 compliant). **Phase Exit Gate:** ≥90% forward traceability, ≥80% requirements coverage.
3.  **Reporting:** Compile findings into a stakeholder summary. Track budget in `BUDGET-LOG.md`. **Final Exit Gate:** Coverage ≥80%, budget < $50, peer review passed.
4.  **Peer Review (Inspection Technique):** Pair with a peer from a **different path** using the Complementary Pairing Strategy (see `INSTRUCTOR-QUICK-REF.md` Section 7). Aim to pair one Manual-focused participant with one Automation-focused participant to maximize learning diversity. Spend 15 minutes.
    - **Scout Inspection Checklist:**
      - [ ] ≥3 risk categories identified (technical, security, UX, or DSGVO/Compliance)
      - [ ] Each Critical/High risk has a documented mitigation
      - [ ] ≥3 ISTQB test design techniques referenced in test plan
      - [ ] ≥5 test cases with clear expected results
      - [ ] Budget tracking present in BUDGET-LOG.md

### 🔵 Group 2: The Engineers (Automation & SDET Paths: D1-D4, E1-E4)
**Focus:** Execution, Automation, and CI/CD.
1.  **Boilerplate Generation:** Ask AI to write initial Playwright specs for the "DACH Enterprise PDF Generator" flow. Generate specs for "Mitarbeiterbericht" (employee report), "Compliance-Bericht" (compliance report), and "Sicherheitsaudit" (security audit). **Phase Exit Gate:** All specs use `data-testid`, ≥80% requirements coverage.
2.  **Debugging:** Use `?debug=true` mode to verify selectors. Fix failing tests with AI assistance. **Phase Exit Gate:** 100% pass rate, Critical defects = 0.
3.  **CI/CD Design:** Propose a pipeline (GitHub Actions/GitLab CI) that runs your AI-generated tests. Output `docs/dev/CICD-HINTS.md`. **Final Exit Gate:** Pipeline defined, budget < $50, peer review passed.
4.  **Peer Review (Walkthrough Technique):** Pair with a peer using the Complementary Pairing Strategy (see `INSTRUCTOR-QUICK-REF.md` Section 7). One Engineer presents their Playwright specs aloud. Others follow along in their own files and ask process questions. Focus: "Does the test flow match the user's actual journey through the app?" Spend 15 minutes (rotate presenter if time allows).
    - **Engineer Walkthrough Checklist:**
      - [ ] Tests navigate the app in user-journey order (not just clicking buttons)
      - [ ] ≥1 negative/edge-case test included (not just happy path)
      - [ ] All `data-testid` selectors match actual HTML attributes
      - [ ] Assertions cover both UI state and toast/notification behavior
      - [ ] CI/CD pipeline includes token budget limit step

### 🟡 Group 3: The Architects (Strategic Path: F1-F4)
**Focus:** System Design and ROI.
1.  **Quality Model:** Define the test pyramid and AI integration points. **Phase Exit Gate:** Test pyramid documented, coverage targets defined.
2.  **Cost/Budget Strategy:** Model token usage vs. quality gain. Propose a "Token Economy" for the team.
3.  **Mentorship:** Review and critique the work of Scouts and Engineers. Provide a "Quality Audit" report. **Final Exit Gate:** Coverage ≥80%, budget < $50, peer review passed, traceability audit completed.
4.  **Peer Review (Technical Review Technique):** Pair with a peer using the Complementary Pairing Strategy (see `INSTRUCTOR-QUICK-REF.md` Section 7). Architects evaluate each other's CI/CD and Quality Model designs against the quality model criteria. Focus: "Would this design scale to a team of 10? Is the cost model defensible?" Spend 15 minutes.
    - **Architect Technical Review Checklist:**
      - [ ] Test pyramid includes unit, integration, and E2E layers
      - [ ] AI integration points identified at ≥2 stages of the STLC
      - [ ] Token budget model includes per-role allocation and cap
      - [ ] Quality audit report references at least one Scout and one Engineer artifact
      - [ ] Design can be implemented by a team of ≤10 with existing tooling

---

## 🏆 Step 3: Gamification

The workshop features a **gamification layer** that rewards engagement, quality, and collaboration. Gamification elements are separate from (but complementary to) the formal judging rubric.

### 🏅 Step 3a: Jungle Badges

Earn **Jungle Badges** for demonstrating specific behaviors during the workshop. Badges contribute to your leaderboard score but **do NOT affect your formal 5-point judging score**. Badges are recognition, not grading.

| Badge | Name | Emoji | Unlock Criteria | Points |
|-------|------|-------|-----------------|--------|
| 1 | **Bug Hunter** | 🐛 | Found and documented a bug in the sandbox app (CSS, JS, or logic) | 15 |
| 2 | **Token Saver** | 💰 | Produced ≥3 artifacts while spending ≤$10 on AI tokens | 20 |
| 3 | **Debug King/Queen** | 🔧 | Successfully debugged a failing test or broken UI element with AI assistance | 15 |
| 4 | **Quality Champion** | ✅ | Risk analysis covers ≥4 categories with mitigations for all Critical/High risks | 15 |
| 5 | **Speed Runner** | ⚡ | Completed all mission tasks within the phase time limit with ≥80% quality (per rubric) | 10 |
| 6 | **Team Player** | 🤝 | Actively helped a peer from a different path (verified by peer Kudos) | 10 |
| 7 | **Jungle Explorer** | 🌴 | Completed all 6 workshop steps (including Boss Battle) with ≥70% quality | 20 |

> **Total possible badges:** 7 | **Total possible badge points:** 105

Earn **≥3 badges** → unlock Advanced Hint Cards (more specific guidance than the 5-Tier Hint System).
Earn **≥5 badges** → unlock Boss Battle participation.
Earn **all 7 badges** → eligible for Jungle Crown vote.

### 🔓 Step 3b: Achievement Unlocks

Progressive content unlocking ensures you build skills step-by-step. Some content is locked until you complete prerequisite steps.

| Unlock | Requirement | What's Unlocked |
|--------|-------------|-----------------|
| 🔒 Advanced Hints | Complete Step 1 (find your Jungle Title) | Enhanced step-by-step hints for your path |
| 🔒 Boss Battle Prep | Complete Step 2 (your mission) | Advanced strategy guide for Boss Battle |
| 🔒 Showdown Tips | Earn ≥3 badges | Presentation tips and Q&A preparation guide |
| 🔒 Jungle Crown Vote | Complete Step 2 + earn ≥3 badges | Access to the Jungle Crown voting list |

> **Note:** Your instructor controls unlocks. If you're unsure whether you've completed a step, ask: "Am I ready to unlock?"

### 💀 Step 3c: Boss Battle (Team Challenge)

The **Boss Battle** is the workshop's capstone team challenge. Teams of 3–4 (mixed path groups) must collaboratively diagnose and fix a simulated multi-system bug in the sandbox app.

**Team Formation Rules:**
- Each team includes at least one **Scout**, one **Engineer**, and one **Architect**.
- The instructor forms teams using a "jungle draft" method (randomized but balanced).
- Self-formation is NOT permitted for the Boss Battle.

**The Challenge:**
The sandbox app contains **3 hidden bugs**:
1. 🐛 **CSS Bug:** Header color overrides itself when "Startup" layout is selected.
2. ⚙️ **State Bug:** Grid data doesn't persist after `updatePreview()` is called.
3. 🔒 **Security Bug:** XSS vulnerability in the "Add Row" function.

**Scoring:**
- **Team Score:** Speed (first team to fix all 3 bugs wins) + correctness (all bugs actually fixed, not just hidden).
- **Individual Bonus:** +5 leaderboard points for the first person to identify each bug.

**Time Limit:** 15 minutes.

### ❤️ Step 3d: Kudos & Social Recognition

Each participant receives **3 Kudos Tokens** at workshop start. Use them to acknowledge peers who help you or others.

**Award Kudos for:**
- 🙋 **Helpfulness** — Answered a peer's question clearly
- 💡 **Great Explanation** — Made a complex concept easy to understand
- 🎨 **Creative Solution** — Found an unconventional but effective approach
- 🤝 **Teamwork** — Active collaboration during the Boss Battle

**Rules:**
- Each Kudos = **+10 leaderboard points**.
- Maximum Kudos earned per participant: **5**.
- Kudos are awarded publicly during phase transitions.
- Use your Kudos wisely — you only have 3!

### 👑 Step 3e: The Jungle Crown

At the end of judging, in addition to the path-specific awards, one participant wins the **Jungle Crown** — the workshop's ultimate honor.

- **Eligibility:** Any participant with ≥5 badges.
- **Selection:** Peer-voted. Each participant casts one vote for who they believe "conquered the jungle."
- **Scoring Tiebreak:** If peer votes are tied, the participant with the highest combined leaderboard score (badges + Kudos + token efficiency) wins.
- **Prize:** A printed or digital "Jungle Crown" medal and verbal recognition during the Showdown.

---

## 🏆 Step 4: Success Criteria & Judging

Judging is **relative to your Jungle Title**. You are not judged against Architects if you are a Trail Explorer.
Each criterion maps back to your Primary Goal (see Path Selector table above).

| Path Group | Judging Criteria | Primary Goal Alignment |
|------------|------------------|------------------------|
| **Scouts (A/B/C)** | • **AI Usage:** Used ≥2 AI tools (e.g., websearch, filesystem) with structured prompts and documented reasoning<br>• **Artifacts:** Risk Analysis covers ≥3 categories with mitigations; Test Plan has ≥8 TCs with ≥3 ISTQB techniques<br>• **Budget:** Tracked in BUDGET-LOG.md with ≥5 entries; total < $50 | ✅ "Generate high-quality test cases and risk lists with AI guidance" → Criteria measure AI guidance quality (tools used, documentation), not just output volume |
| **Engineers (D/E)** | • **AI Usage:** Modified ≥50% of AI-generated code to handle edge cases; used AI for debugging, not just generation<br>• **Code Quality:** Tests use `data-testid`; cover positive, negative, and edge cases; include toast/notification assertions<br>• **CI/CD:** Pipeline includes token budget limit, retry strategy for flaky tests, and quality gates | ✅ "Execute, automate, and debug with AI" → Criteria measure debugging depth (modifications vs. copy-paste), not just test count |
| **Architects (F)** | • **AI Usage:** Used AI to simulate scenarios and stress-test designs, not just generate ideas<br>• **Strategy:** Risk model includes likelihood/impact scoring; cost-benefit analysis of AI vs. manual effort<br>• **Impact:** Quality audit references specific Scout and Engineer artifacts; proposes actionable process improvements | ✅ "Design systems and optimize the ecosystem" → Criteria measure systems thinking (scalability, ROI), not just individual artifact quality |

---

## 📊 Judging Transparency

Judging uses a **5-point scoring scale** (1 = Not demonstrated, 3 = Adequately demonstrated, 5 = Exemplary) with anchor examples per path group. Two instructors independently score each participant. Disagreements >1 point require third-party review. See `INSTRUCTOR-QUICK-REF.md` Section 5 for the full rubric validation protocol.

---

## 🔧 Troubleshooting Tip

Encountering an issue? Before raising your hand, check `INSTRUCTOR-QUICK-REF.md` Section 1 for quick fixes. Most common issues (AI chat, Playwright, JSON validation) have one-line solutions.

---

## 🏆 Step 5: Showdown Presentation

After the judging segment, you will present your work in the **Showdown & Judges** (15 minutes total).

### Format
Each participant gets **3 minutes to present + 2 minutes for Q&A** (grouped by ~5 participants).

### Structure (Mandatory)
1. **Jungle Title & Path** (15 seconds) — State your title and path ID.
2. **Key Artifact** (30 seconds) — What did you produce? What are the key points?
3. **AI Usage** (45 seconds) — Which AI tools did you use? How did you refine prompts?
4. **Result & Reflection** (60 seconds) — What was your outcome? What insight surprised you?

### Tips
- **Practice with a timer** — 3 minutes goes faster than you think.
- **Prepare a 60-second summary** of your entire work — if the Q&A runs short, you'll have it ready.
- **Don't read slides** — speak naturally, use the time limit as a guide.
- **Questions from the audience are welcome during Q&A** — be ready to explain your decisions.

### Fallback
If you're too nervous or have technical issues, the instructor will read a summary of your artifact on your behalf. **You will still be scored** — presentation skill is not a judging criterion.

---

## 🏆 Step 6: Awards & Recognition

At the end of judging, an **Award Ceremony** recognizes outstanding work across three categories:

| Award | Category |
|-------|----------|
| 🏆 **Scout Champion** | Best risk analysis and test strategy among A/B/C paths |
| ⚙️ **Engineer Excellence** | Best automation approach and code quality among D/E paths |
| 🔮 **Architect Visionary** | Best system design and ROI thinking among F paths |
| 👑 **Jungle Crown** | Peer-voted winner with highest combined leaderboard score (badges + Kudos + token efficiency). Eligibility: ≥5 badges. The ultimate honor of the workshop. |

**Note:** Every participant receives verbal recognition of a specific strength during their presentation — not just the award winners. Your effort matters, jungle explorer.

---

## 📚 Step 7: Continue Your Journey

After the workshop, you don't have to stop using AI in QA. Choose your learning track:

| Track | For | Progression |
|-------|-----|-------------|
| 🟢 **Scout Track** | A/B/C paths | AI for Test Cases → AI for Risk Analysis → AI for Reporting |
| 🔵 **Engineer Track** | D/E paths | AI-Assisted Debugging → AI Test Frameworks → AI CI/CD |
| 🟡 **Architect Track** | F path | Token Economy → Multi-Agent Systems → AI Quality Strategy |

**Start the 30-Day AI QA Challenge:**
- **Week 1:** Use AI to generate 10 test cases for a new feature.
- **Week 2:** Produce a risk analysis with ≥5 categories and mitigations.
- **Week 3:** Use AI to review and critique an existing test suite.
- **Week 4:** Document what worked, what didn't, and what to improve.

Your instructor will provide a printable challenge card and link to recommended resources (AI tutorials, QA blogs, community forums).

---

*Pick your path. Train your AI. Win the Jungle.* 🌿