# 👨‍🏫 Instructor Quick-Ref Card: King of the Jungle

## 🧭 Quick Navigation

| Section | Topic | Lines |
|---------|-------|-------|
| 0 | **Immediate Troubleshooting** | 63–107 |
| 1 | **Role Definitions** | 32–62 |
| 2 | **3-Hour Delivery Flow** | 108–122 |
| 3 | **Day-0 Mapping Matrix** | 123–137 |
| 4 | **Judging Checklist** | 138–180 |
| 5 | **Resource Allocation Checklist** | 181–194 |
| 6 | **Token Distribution** | 195–209 |
| 7 | **Automated Day-0 Setup** | 210–229 |
| 8 | **Judging Rubric Validation** | 230–259 |
| 9 | **First 5 Minutes Script** | 260–266 |
| 10 | **Pacing & Energy Management** | 267–280 |
| 11 | **Complementary Pairing** | 281–311 |
| 12 | **Flow State Protection** | 312–334 |
| 13 | **Instructor Presence Levels** | 335–349 |
| 14 | **Learner Autonomy & Hint Cards** | 350–381 |
| 15 | **Celebration & Recognition** | 382–407 |
| 16 | **Post-Workshop Follow-up** | 408–439 |
| 17 | **Continuous Learning Paths** | 440–470 |
| 18 | **Gamification & Leaderboard** | 471–559 |
| 19 | **Analytics Dashboard** | 560–611 |

---

> **Print this card. Keep it visible during delivery. Enforce hard stops.**

## 1. Role Definitions

### Instructor Responsibilities
- **Facilitate, don't participate.** Guide participants to their Jungle Title path; do not write code or produce artifacts for them.
- **Enforce hard stops.** Use the 3-Hour Delivery Flow timer. No extension past scheduled segments.
- **Troubleshoot efficiently.** Use the troubleshooting table (Section 0) — max 3 minutes per issue before escalating to pre-prepared fix.
- **Judge fairly.** Use the Judging Rubric Validation (Section 5) with calibrated scoring.
- **Maintain budget discipline.** Track total workshop AI usage; alert participants at $45.

### Participant Responsibilities
- **Follow their Jungle Title path.** Use the prompt and tooling set for their specific path.
- **Manage their own AI budget.** Track usage in `BUDGET-LOG.md`. No instructor-managed token allocation.
- **Produce their own artifacts.** Risk Analysis, Test Plan, code — all participant-owned.
- **Self-troubleshoot first.** Consult `INSTRUCTOR-QUICK-REF.md` troubleshooting section before raising hand.

### Authority Boundaries
| Scenario | Instructor Action |
|----------|-------------------|
| Participant stuck >10 min | Offer hint, then move on; revisit during wrap-up |
| Budget exceeds $45 | Disable cloud model; switch all to sovereign |
| Technical issue unresolved in 3 min | Apply pre-prepared fix; do not debug live |
| Participant asks for direct answer | Socratic guidance only — "What does the error say?" |
| Off-topic question | Parking Lot technique — address in final 10 min |

### ⚠️ Anti-Patterns (What Instructors Must NOT Do)
- ❌ Writing participant code or prompts
- ❌ Completing participant artifacts on their behalf
- ❌ Extending time beyond hard stops
- ❌ Giving direct answers — always guide with questions
- ❌ Judging based on subjective impressions — use the rubric

## 🚨 Immediate Troubleshooting

### 🔍 Quick Triage Decision Tree
1. **Is it an AI/Chat issue?** → See Section A (AI & Model Issues) below.
2. **Is it a Tooling issue?** → See Section B (Setup & Tooling) below.
3. **Is it an App issue?** → See Section C (Mock App & Data) below.
4. **Is it a Budget issue?** → See Section D (Token & Cost) below.

### A. AI & Model Issues
| Symptom | Action |
|---------|--------|
| **Missing API key** | Open `opencode.json.template`. Copy it to `opencode.json` (or `.vscode/opencode.json`). Replace `{YOUR_SOVEREIGN_KEY}`, `{SOVEREIGN_URL}`, `{YOUR_CLOUD_KEY}`, and `{CLOUD_URL}` with values from your AI Hub admin. No trailing spaces after the key. |
| **AI Hub config syntax error** | Run `cat opencode.json \| python3 -m json.tool` to validate. Fix trailing commas. Check that all `{YOUR_*}` placeholders have been replaced. |
| **AI Chat won't start** | Verify API keys are filled in (not `{YOUR_KEY}`). Check `opencode.json` syntax. Restart VS Code AI extension. |
| AI model switching fails | Verify model ID in `opencode.json`. Check API key validity. |
| API rate limit hit (429) | Wait 30 seconds. Prune context. Switch to sovereign model. |
| Context window overflow | Ask agent to "Summarize previous content to ≤512 tokens." |
| Prompt injection rejection | Normal behavior. Confirm injection detected → correct. If false positive, check for injected pattern in user input. |
| Cloud model unavailable | Budget alert auto-disables cloud. All requests route to sovereign. |

### B. Setup & Tooling Issues
| Symptom | Action |
|---------|--------|
| Playwright fails | Run `npx playwright install`. Check `playwright.config.js`. |
| AI Hub config syntax error | Run `cat opencode.json | python3 -m json.tool` to validate. Fix trailing commas. |
| VS Code extension not loading | Reload window (Cmd+Shift+P → "Developer: Reload Window"). |
| Terminal command not found | Check PATH. Run `which node` to verify Node.js install. |
| Port 3000 in use | Run `lsof -i :3000` to find process. Kill it or use different port: `npx serve mock/ -p 3001`. |

### C. Mock App & Data Issues
| Symptom | Action |
|---------|--------|
| App won't load | Run `npx serve mock/`. Ensure port 3000 is free. |
| JSON import crashes | App now uses strict validation. Check `importConfig()` in console. |
| Data Grid not rendering | Ensure `?debug=true` is in URL to see grid `data-testid`. Check JSON format in sidebar. |
| Browser cache issue | Hard refresh (Cmd+Shift+R). Clear site data in DevTools. |
| JSON validation errors | Verify JSON structure matches mock app expectations. Use `?debug=true` to see parsed data. |

### D. Token & Cost Issues
| Symptom | Action |
|---------|--------|
| Budget warning ($45 alert) | Force switch all agents to `qwen-sovereign`. Verify cloud model disabled in VS Code AI Hub config. |
| Token tracking inaccurate | Participants should log major tasks in `BUDGET-LOG.md` manually as fallback. |
| Cloud model auto-disabled | Normal behavior. All work continues on sovereign model. |

## ⏱ 3-Hour Delivery Flow (Hard Stops)
> **Source of Truth:** See `agenda.md` for the authoritative schedule with phase details. This section provides a high-level timing guide.

| Time | Segment | Buffer |
|------|---------|--------|
| 00:00-00:15 | Setup & Onboarding | +2 min |
| 00:15-00:45 | Theory & Guided Demo | +3 min |
| 00:45-01:15 | Independent Sprint | +5 min |
| 01:15-01:30 | Debug Buffer | +2 min |
| 01:30-02:15 | Peer Review Session | +3 min |
| 02:15-02:30 | Boss Battle | +2 min |
| 02:30-02:45 | Showdown & Judges | +2 min |
| 02:45-03:00 | Celebration & Wrap-up | - |
*Use the "Parking Lot" technique for off-topic questions. Address only in final 10 min.*

## 🗺️ Day-0 Participant Mapping Matrix
Use this to guide participants to their path if they are unsure:

| If they are... | And their AI experience is... | Tell them to pick... |
|----------------|-------------------------------|----------------------|
| Manual Tester | New to AI | **Trail Explorer** (A1) |
| Manual Tester | Comfortable with ChatGPT | **River Ranger** (A2) |
| Manual Tester | Expert at Prompt Engineering | **Scout Leader** (A3) |
| QA Engineer | New to AI | **Camp Builder** (B1) |
| QA Engineer | Intermediate with Tools | **Jungle Guide** (B2) |
| Automation Engineer | New to AI | **Gear Caster** (D1) |
| Automation Engineer | Expert at AI | **Automation Wizard** (D4) |
| Architect | New to AI | **Explorer** (F1) |
| Architect | Expert at AI | **King of the Jungle** (F4) |

## 🏆 Judging Checklist (Path-Relative)
Judging is **relative to the Jungle Title**. Use the 5-point rubric tables below (Scouts, Engineers, Architects) with explicit category weights. Conduct a **Pre-Judging Calibration** (10 min) before scoring any participant.

### Scouts (A/B/C Paths)
*Primary Goal: Strategy, Risk, and Reporting — use AI effectively for brainstorming and planning.*

**Category Weights:** AI Usage 15%, Risk Analysis 25%, Test Plan 25%, Budget Tracking 10%, Peer Review 15%, Cross-Path Contribution 10%.

| Criterion | Unsatisfactory (1) | Below Expectations (2) | Meets Expectations (3) | Above Expectations (4) | Exemplary (5) |
|-----------|--------------------|------------------------|------------------------|------------------------|---------------|
| **AI Usage** | No AI interaction; worked entirely without AI tool | Used ≥1 AI tool with basic prompts; produced basic output | Used AI for brainstorming and formatting; produced structured output | Used AI iteratively — prompted, critiqued, and refined based on AI output | Used AI iteratively — prompted, critiqued, refined, and **validated** AI output against requirements; documented prompt evolution |
| **Risk Analysis** | <3 risk categories; no mitigations for Critical/High risks | ≥3 risk categories identified; ≥1 mitigation per Critical/High risk | All identified risks have mitigations; categories cover technical + security + UX | Risk model includes quantified likelihood/impact scores; cross-references ≥3 tickets | Comprehensive risk model with quantified scores, dependency mapping, and ROI-linked mitigations |
| **Test Plan** | <5 test cases; no ISTQB technique used | ≥5 test cases; ≥1 ISTQB technique used | ≥8 test cases; ≥3 ISTQB techniques; clear expected results | Test cases cover positive, negative, accessibility, and edge cases; traceable to tickets | Test cases include exploratory scenarios; automated where feasible; traceability matrix produced |
| **Budget Tracking** | BUDGET-LOG.md not created or empty | BUDGET-LOG.md created with ≥3 entries | BUDGET-LOG.md tracked throughout; total <$50 | BUDGET-LOG.md includes per-task breakdown; identifies top cost drivers | BUDGET-LOG.md includes cost-benefit analysis of AI tool choices with recommendations |
| **Peer Review** | Did not review peer work or provided no feedback | Checked peer's work against checklist; noted issues | Found ≥2 actionable issues in peer's work | Found ≥2 actionable issues; prioritized by severity | Provided specific improvement suggestions, not just defect reports; peer incorporated suggestions |
| **Cross-Path Contribution** | No cross-path interaction | Shared notes with 1 peer from a different path | Mentored ≥1 peer from a different path with constructive feedback | Quality audit references specific peer artifacts from another path | Proposes process changes that improve the entire team's workflow across paths |

### Engineers (D/E Paths)
*Primary Goal: Execution, Automation, and CI/CD — debug and optimize with AI, not just copy-paste.*

**Category Weights:** AI Usage 15%, Code Quality 30%, CI/CD 25%, Walkthrough 10%, Debugging Effectiveness 20%.

| Criterion | Unsatisfactory (1) | Below Expectations (2) | Meets Expectations (3) | Above Expectations (4) | Exemplary (5) |
|-----------|--------------------|------------------------|------------------------|------------------------|---------------|
| **AI Usage** | Used AI to generate initial boilerplate code only; did not review or modify output | Modified ≥50% of AI-generated code; handled some edge cases | Used AI iteratively — analyzed failures, proposed fixes, validated solutions | Used AI to debug complex failures; benchmarked AI-generated solutions against manual approaches | Used AI as a co-pilot throughout — automated test generation, self-healing selectors, CI optimization |
| **Code Quality** | No tests written; or tests use hardcoded selectors, no edge cases | Tests use `data-testid` selectors; basic assertions present | Tests handle edge cases (empty input, invalid JSON); assertions cover UI + notifications | Tests include data-driven scenarios; reusable helper functions or page objects | Tests use POM pattern; include retry logic, visual validation, and error handling; coverage >80% |
| **CI/CD** | Pipeline design covers basic test execution | Pipeline includes token budget limit and retry strategy for flaky tests | Pipeline includes quality gates (coverage threshold, linting); runs on every PR | Pipeline includes parallel test execution, artifact archival, and slack/email notifications | Full CI/CD: auto-deploy on merge, canary deployments, performance regression detection |
| **Walkthrough** | Cannot explain what any test does | Can explain what each test does | Can explain the user journey the tests cover | Identifies gaps in the user journey that no test covers; proposes new test coverage | Proposes architectural changes to improve testability of the application itself |
| **Debugging Effectiveness** | Cannot diagnose test failures; requires instructor intervention | Identifies surface-level issues (wrong selector, missing element) | Diagnoses root cause (timing issue, state mismatch); fixes independently | Diagnoses complex failures (race conditions, flaky tests); proposes preventive measures | Creates debugging tools or utilities for the team; documents common failure patterns |

### Architects (F Path)
*Primary Goal: System Design and ROI — design systems and optimize the ecosystem.*

**Category Weights:** AI Usage 10%, Quality Model 25%, Strategy 25%, Impact 20%, Presentation 20%.

| Criterion | Unsatisfactory (1) | Below Expectations (2) | Meets Expectations (3) | Above Expectations (4) | Exemplary (5) |
|-----------|--------------------|------------------------|------------------------|------------------------|---------------|
| **AI Usage** | Used AI to generate ideas and draft documents only | Used AI to simulate scenarios and stress-test designs | Used AI to benchmark designs against industry standards and best practices | Used AI to iteratively refine designs based on simulated outcomes | Used AI to run automated scenario analysis across multiple dimensions; produced decision matrix |
| **Quality Model** | Test pyramid documented with ≥3 layers | Coverage targets defined per layer; AI integration points identified at ≥2 STLC stages | Model includes cost-benefit analysis of AI vs. manual effort per layer; defines measurable quality KPIs | Model includes automation ROI forecasts; links quality metrics to business outcomes | Model includes continuous improvement feedback loop; adapts based on deployment data |
| **Strategy** | Risk model covers ≥3 categories with mitigations | Risk model includes likelihood/impact scoring and prioritization | Model includes quantified ROI: quality gain per $ of token spend | Model includes multi-year roadmap with phased AI adoption; identifies risks and dependencies | Model includes competitive benchmarking; proposes strategic initiatives beyond the current team |
| **Impact** | Mentored ≥1 peer with constructive feedback | Quality audit references specific Scout and Engineer artifacts | Proposes process changes that improve the entire team's workflow | Implementable process changes adopted by ≥2 other participants; documented for reuse | Published a reusable framework or tool that the team continues to use post-workshop |
| **Presentation** | Cannot articulate design decisions | Presents design clearly; answers basic questions | Presents design with supporting evidence; engages audience with Q&A | Anticipates objections; adapts presentation based on audience feedback | Persuasive narrative with compelling data; audience takes action on recommendations |

## 2. Resource Allocation Checklist

Run this checklist **before workshop start**. Every participant must pass.

| # | Resource | Verification Step | Pass Condition |
|---|----------|-------------------|----------------|
| 1 | **AI Hub Access** | Ask participant: "Can you chat with AI in VS Code?" | Response received within 10 seconds |
| 2 | **AI Hub Config** | `cat .vscode/opencode.json \| python3 -m json.tool` (or project root) | JSON valid, no syntax errors |
| 3 | **Mock App** | `npx serve mock/` in terminal | App loads at `http://localhost:3000` |
| 4 | **Playwright (Engineer paths)** | `npx playwright --version` | Version number displayed |
| 5 | **Fallback Resources** | Printout of Jungle Title paths, cached JSON samples available | Printed copies ready |

**If any check fails:** Apply pre-prepared fix from the troubleshooting table. If fix takes >3 min, enroll participant in fallback track (Scout path with pre-filled artifacts).

## 3. Token Distribution

Pre-allocate token budgets per path group. Participants manage their own; instructor verifies totals.

| Path Group | Recommended Budget | Cloud Model Allowance | Monitoring |
|------------|-------------------|----------------------|------------|
| **Scouts (A/B/C)** | $15–20 per participant | Minimal (brainstorming only) | `BUDGET-LOG.md` check at Phase 3 |
| **Engineers (D/E)** | $20–30 per participant | Moderate (debugging, code gen) | `BUDGET-LOG.md` check at Phase 3 |
| **Architects (F)** | $25–35 per participant | Higher (architecture design) | `BUDGET-LOG.md` check at Phase 3 |

**Global Caps:**
- Workshop total budget: **$50** (shared AI Hub budget)
- Per-participant soft cap: $10 average
- Cloud model auto-disabled at $45 (configured in `opencode.json`)

## 4. Automated Day-0 Setup

Before Phase 1, have all participants run:
```bash
./setup-checklist.sh
```

This script verifies:
- ✅ Node.js / npm installed
- ✅ `opencode.json` syntax valid
- ✅ `mock/index.html` exists
- ✅ Playwright browsers installed (optional — engineer paths)
- ✅ VS Code AI extension active (visual check)

**Output:** Green checkmarks for passes, red X with specific fix for failures.

**Instructor Action:** Verify all participants show ≥3 green checks before starting Phase 1 (Requirements Analysis).

**Fallback:** If script is unavailable, walk through `VS-CODE-AI-HUB-SETUP.md` manually (allocates 10 min of the 15-minute setup window).

## 5. Judging Rubric Validation

Judging criteria use a **5-point scoring scale** with anchor examples. Conduct a **Pre-Judging Calibration** (10 min) before scoring any participant.

### Scoring Scale
| Score | Meaning | Level |
|-------|---------|-------|
| **1** | Not demonstrated — criterion not met | Unsatisfactory |
| **2** | Minimally demonstrated — meets bare minimum | Below Expectations |
| **3** | Adequately demonstrated — meets expected standard | Meets Expectations |
| **4** | Strongly demonstrated — exceeds expectations | Above Expectations |
| **5** | Exemplary — outstanding, model participant work | Exemplary |

**Anchor Reference:** Use the path-specific 5-point anchor tables (Scouts, Engineers, Architects) for criterion-level examples. The scale-level descriptions above provide the semantic meaning for cross-path comparison.



### Inter-Rater Reliability Protocol
1. **Independent Scoring:** Two instructors independently score each participant using the 5-point rubric tables (Scouts/Engineers/Architects). Both must use the same score definition.
2. **Agreement Check:** Compare scores per criterion. Agreement = scores differ by ≤1 point.
3. **Escalation:** If any criterion differs by >1 point → third-party review (Lead Instructor). The Lead Instructor reviews both judges' justifications and assigns the final score.
4. **Calibration Logging:** Record agreement rate. Target: ≥90% criteria agreement within ±1 point. If agreement <90%, the Lead Instructor conducts a calibration session using sample submissions before resuming judging.
5. **Scale Confirmation:** At the start of each judging session, both instructors verbally confirm they are using the 5-point rubric tables (not the 3-point summaries or any other scale).

### Pre-Judging Calibration Exercise
- **Time:** 10 minutes, before judging begins.
- **Activity:** Score a sample participant submission independently. Compare scores. Discuss discrepancies.
- **Outcome:** All instructors agree on score definitions and anchor examples.
- **Reference:** Use the "Judging Calibration Pack" (sample submissions with known scores) for training new instructors.

## 🗣 First 5 Minutes Script
1. **00:00:** "Welcome to the Jungle. Today, you are the QA team for a new PDF tool."
2. **00:02:** "We have a budget of $50 and access to a Sovereign AI Agent. Your goal is to build the best QA strategy for your specific role."
3. **00:05:** "Open `WORKSHOP-CHALLENGE.md` and find your **Jungle Title**. Then open `AGENTS.md` and copy the prompt that matches your path."

---

## 6. Pacing & Energy Management

The workshop delivery flow uses a **3-tier energy model** to match instructor behavior to the cognitive demands of each segment. No single energy level should persist for more than 30 consecutive minutes to prevent participant fatigue.

| Energy Level | Segments | Instructor Behavior |
|--------------|----------|---------------------|
| **Calm / Focus** | Independent Sprint (00:45-01:15), Debugging time | Low voice, minimal movement, no interruptions. Participants work in silence. Instructor circulates quietly with whiteboard for questions. |
| **Balanced / Active** | Theory (00:15-00:25), Guided Demo (00:25-00:45), Peer Review (02:15-02:30), Wrap-up (02:45-03:00) | Normal speaking volume, active movement between participants, structured interaction (Q&A, walkthroughs). |
| **High / Energetic** | Showdown & Judges (02:30-02:45), Opening welcome (00:00-00:15) | Elevated voice, enthusiastic tone, visible movement, celebratory language. Participants feel the "energy of the jungle." |

**Pacing Rule:** Instructors must consciously shift their energy level when transitioning between segments. The 2-minute buffer between segments is the "transition window" — use it to reset your energy before the next segment begins.

---

## 7. Complementary Pairing Strategy

Peer review sessions should pair participants with **complementary skills** (not identical skill levels) to maximize cross-path learning. The instructor facilitates pairing using the guidelines below.

### Skill Diversity Matrix

| Your Jungle Title | Best Pairing Partners (examples) | Learning Gain |
|-------------------|----------------------------------|---------------|
| Trail Explorer (A1) | Mechanic (D2), Pathfinder (E1) | Learn basic automation concepts |
| River Ranger (A2) | Master Tinkerer (D3), Trap Architect (E2) | Learn debugging techniques |
| Scout Leader (A3) | System Weaver (E3), Code Sorcerer (E4) | Learn advanced patterns |
| Camp Builder (B1) | Gear Caster (D1), Pathfinder (E1) | Learn test automation basics |
| Jungle Guide (B2) | Mechanic (D2), Trap Architect (E2) | Learn debugging and edge cases |
| Tactical Planner (B3) | Automation Wizard (D4), System Weaver (E3) | Learn complex automation |
| Commander (C3) | Automation Wizard (D4), Code Sorcerer (E4) | Learn CI/CD and self-healing |
| Gear Caster (D1) | Trail Explorer (A1), Camp Builder (B1) | Learn test design thinking |
| Mechanic (D2) | River Ranger (A2), Camp Builder (B1) | Learn requirements analysis |
| Master Tinkerer (D3) | Scout Leader (A3), Tactical Planner (B3) | Learn advanced test strategy |
| Automation Wizard (D4) | Commander (C3), Visionary (F3) | Learn systems design |
| Explorer (F1) | Trail Explorer (A1), Gear Caster (D1) | Learn ground-level QA |
| Chief Architect (F2) | Jungle Guide (B2), Mechanic (D2) | Learn practical automation |
| Visionary (F3) | Tactical Planner (B3), Master Tinkerer (D3) | Learn advanced integration |
| King of the Jungle (F4) | Commander (C3), Automation Wizard (D4) | Learn operational excellence |

### Pairing Algorithm (for when participants are unsure)
1. Ask: "Do you know each other's Jungle Title?" If yes, pair them with the matrix above.
2. If neither knows, the instructor assigns based on the "Skill Diversity Matrix."
3. **Rule of thumb:** Pair at least one Manual-focused path with one Automation-focused path. Avoid pairing two participants at the exact same AI level.

---

## 8. Flow State Protection

The Independent Sprint (00:45-01:15) is the longest individual work segment and the core learning experience. **Flow state** — deep cognitive immersion — is essential for skill acquisition. Instructors must protect it using the protocols below.

### No Interruption Rule (Independent Sprint only)
- **Instructors do NOT verbally interrupt participants** during the Sprint.
- Instructors circulate silently and observe progress.
- Participant questions are written on the "Question Parking Lot" whiteboard and addressed as a batch at the phase transition (after "Hard stop on Independent Sprint!").

### Flow Pass System
- Each participant receives one "Flow Pass" card at workshop start.
- If a participant needs help during the Sprint, they place the Flow Pass on their desk (visible to instructor).
- The instructor approaches silently and provides help without disrupting the participant's current train of thought.
- After the Sprint, the Flow Pass is collected (or reused for the next work phase).

### Question Parking Lot
- A whiteboard or flip chart positioned where all participants can see it.
- Instructor writes participant questions during the Sprint.
- At the phase transition, the instructor reads and answers each question as a batch (2-3 minutes max).
- Unanswered questions go into the "Parking Lot" for the final 10-minute wrap-up.

---

## 9. Instructor Presence Levels

The instructor's physical presence and interaction intensity must vary by workshop phase. A "one-size-fits-all" presence either creates dependency (hovering) or abandonment (hiding).

| Presence Level | Segments | Expected Behaviors |
|----------------|----------|--------------------|
| **Present / Front-of-Room** | Guided Demo (00:25-00:45), Showdown & Judges (02:30-02:45) | Visible at front, leading the room, speaking to all, controlling the narrative. |
| **Active / Circulating** | Peer Review (02:15-02:30), Automation & Review (01:30-02:15) | Moving between pairs/tables, offering guidance, answering questions, observing collaboration. |
| **Observing / Distant** | Independent Sprint (00:45-01:15) | Visible in the room but NOT approaching unless a Flow Pass is presented. Silently note issues. |
| **Invisible** | Break (01:15-01:30), Setup (00:00-00:15) | Off-camera / side of room. Only engaged when participants seek out the instructor. |

**Presence Transition Rule:** Before switching presence levels, announce the transition clearly: "In 2 minutes, we enter the Independent Sprint. For the next 30 minutes, please work silently. Place a Flow Pass on your desk if you need help."

---

## 10. Learner Autonomy & Hint Cards

The workshop's core pedagogical principle is **learner autonomy**: participants must solve problems themselves to build durable skills. Instructors support this through the **5-Tier Hint System**, which provides structured guidance without giving away answers.

### 5-Tier Hint System

When a participant asks for help, deploy hints **progressively** — one tier at a time. Do not skip tiers.

| Tier | Name | Instructor Action | Example Wording |
|------|------|-------------------|-----------------|
| **1** | **Nudge** | Prompt self-reflection | "What have you tried so far?" / "What do you expect to happen?" |
| **2** | **Resource** | Direct to documentation | "Check the troubleshooting table in INSTRUCTOR-QUICK-REF.md, Section A." / "Look at the data-testid attribute in mock/index.html." |
| **3** | **Scaffold** | Ask guiding questions | "What does the error message say?" / "Which part of the user journey is failing?" |
| **4** | **Hint** | Provide a specific clue | "Check the `gridData` field in the JSON — it should be an array." / "Try adding `waitFor()` before clicking the export button." |
| **5** | **Answer** | Only after all 4 tiers exhausted | "The selector should be `[data-testid='export-button']`. Now try running the test again." |

### Rule: Do Not Skip Tiers
- Each tier represents increasing specificity and decreasing autonomy.
- If you provide Tier 4 but the participant didn't get Tier 2, you robbed them of the learning opportunity.
- **Exception:** Tier 5 (Answer) is allowed when all 4 tiers are exhausted AND time is running out (e.g., participant has been stuck >10 min on a critical path task).

### Visual Hint Cards (Recommended)
Print colored cards for the instructor to hand to participants:
- 🟢 Green = "Nudge" (Tier 1)
- 🟡 Yellow = "Resource" (Tier 2)
- 🟠 Orange = "Scaffold" (Tier 3)
- 🔴 Red = "Hint" (Tier 4)

**Note:** Tier 5 (Answer) is delivered verbally by the instructor — not printed on a card, since it is exception-only. Participants can see which tier they're at by the card they hold and self-escalate by placing the returned card back on their desk.

---

## 11. Celebration & Recognition

The Showdown includes a Celebration & Recognition element to maintain motivation and reinforce the "King of the Jungle" theme.

### Award Ceremony (2 minutes)
At the end of judging, the instructor announces:

| Award | Category | Description |
|-------|----------|-------------|
| 🏆 **Scout Champion** | A/B/C paths | Best risk analysis and test strategy among Scouts |
| ⚙️ **Engineer Excellence** | D/E paths | Best automation approach and code quality among Engineers |
| 🔮 **Architect Visionary** | F path | Best system design and ROI thinking among Architects |

> **Note:** One winner per category. If a category has no participants, the award is withheld — do not fabricate a winner.

### Inclusive Recognition (During Each Presentation)
Every participant receives **verbal acknowledgment of one specific strength** during their presentation. Examples:
- "Great use of AI for brainstorming — Sarah, your risk categories were insightful."
- "Clean code structure — Mike, your POM pattern is a real-world approach."
- "Bold design choice — Alex, your token economy model shows systems thinking."

**Why:** This ensures every participant leaves feeling valued and recognized, regardless of their final score. Generic praise ("good job") is not enough — acknowledgment must reference a specific artifact or action.

### Theme Language
Use jungle-themed language throughout: "You've conquered the requirements jungle," "Your AI usage has earned you the Ranger title," "This is how Kings approach quality."

## 12. Post-Workshop Follow-up

After the workshop ends, structured follow-up activities maintain engagement and capture learning outcomes.

### Artifact Sharing (24 hours)
Within 24 hours, the instructor sends a summary email to all participants containing:
1. **Their completed artifacts** (Risk Analysis, Test Plan, Budget Log, etc.) — collected or copied from participant submissions.
2. **Session recap** with key learnings and common themes observed during judging.
3. **Link to the feedback survey** for participants who did not complete it in-session.

### Testimonial Collection
Use the following template for video or text testimonials:
- "What was your biggest takeaway from the workshop?"
- "How do you plan to apply AI tools in your daily QA work?"
- "Would you recommend this workshop to others? Why or why not?"

**When:** Collect during the wrap-up (02:50–03:00) or via the 24-hour follow-up email.

### Follow-Up Timeline
| Timeframe | Action | Purpose |
|-----------|--------|---------|
| **24 hours** | Summary email with artifacts and survey link | Ensure everyone receives materials |
| **1 week** | Check-in survey (3 questions on AI usage in daily work) | Measure immediate application |
| **1 month** | Alumni poll (AI adoption metrics, challenges, suggestions) | Longitudinal impact tracking |

### Jungle Alumni Community (Optional)
Create a Slack/Discord channel or mailing list for past participants to:
- Share AI-in-QA experiences and tips
- Discuss ongoing challenges
- Network across organizations
- Receive invitations to future workshop sessions

## 13. Continuous Learning Paths

Participants should continue their AI-in-QA learning journey after the workshop. `INSTRUCTOR-QUICK-REF.md` defines three progressive learning tracks.

### Learning Tracks

| Track | For Path Group | Progression |
|-------|----------------|-------------|
| 🟢 **Scout Track** | A/B/C (Scouts) | AI for Test Case Design → AI for Risk Analysis → AI for Quality Reporting |
| 🔵 **Engineer Track** | D/E (Engineers) | AI-Assisted Debugging → AI-Generated Test Frameworks → CI/CD Pipeline Optimization with AI |
| 🟡 **Architect Track** | F (Architects) | Token Economy Optimization → Multi-Agent QA System Design → AI Quality Strategy for Enterprise |

### Recommended Resources
- **AI Tool Tutorials:** Playwright with AI, Bruno CLI for API testing, AI prompt engineering guides
- **QA Blog Subscriptions:** ISTQB blog, Ministry of Testing, Test Automation University
- **Community Forums:** r/QualityAssurance, local QA meetups, professional QA associations

### 30-Day AI QA Challenge
A self-directed weekly challenge for participants to practice AI skills independently:

| Week | Focus | Deliverable |
|------|-------|-------------|
| **Week 1** | AI for Test Case Generation | Generate 10 test cases for a new feature using AI |
| **Week 2** | AI for Risk Brainstorming | Produce a risk analysis with ≥5 categories and mitigations |
| **Week 3** | AI for Test Review | Use AI to review and critique an existing test suite |
| **Week 4** | Reflection | Document learnings: what worked, what didn't, what to improve |

**How to Start:** At the end of the workshop, participants choose their learning track and receive the challenge card (printable or digital). The instructor collects commitment cards (name + chosen track) as a follow-up reminder.

---

## 14. Gamification & Interactive Leaderboard

This section covers the gamification layer: Jungle Badges, the Interactive Leaderboard, Achievement Unlocks, Boss Battle facilitation, and the Kudos system. These elements enhance engagement but are separate from the formal judging rubric.

### 14.1 Jungle Badge Tracking

At workshop start, give each participant a **Badge Tracking Card** (printed or digital). As participants earn badges, stamp or mark them on the card.

| Badge | Emoji | When to Award | Max per Participant |
|-------|-------|---------------|---------------------|
| Bug Hunter | 🐛 | Participant finds/fixes a sandbox bug | 1 |
| Token Saver | 💰 | ≥3 artifacts for ≤$10 spend | 1 |
| Debug King/Queen | 🔧 | Successfully debugs with AI assistance | 1 |
| Quality Champion | ✅ | ≥4 risk categories with all mitigations | 1 |
| Speed Runner | ⚡ | Completes all tasks on time with ≥80% quality | 1 |
| Team Player | 🤝 | Helps peer from different path (Kudos confirms) | 1 |
| Jungle Explorer | 🌴 | Completes all 6 steps with ≥70% quality | 1 |

**Announcement Timing:** Announce badges at phase transitions (end of Independent Sprint, end of Peer Review, end of Boss Battle).

### 14.2 Leaderboard Management

The leaderboard is displayed in `mock/index.html` (collapsible panel in sidebar). You control updates:

- **Badge award:** Click the badge icon next to the participant name in the leaderboard widget.
- **Kudos award:** Click the ❤️ "Award Kudos" button. Each Kudos = +10 points.
- **Token efficiency:** Calculate as `artifacts / tokens_spent`. Update manually (or let participants self-report from their `BUDGET-LOG.md`).
- **Leaderboard sorts automatically** by total points. Refresh after each update.

### 14.3 Achievement Unlock Facilitation

Step-gating controls content access:

| Unlock | Instructor Action |
|--------|-------------------|
| **Advanced Hints** (≥3 badges) | Click "Unlock" on Step 1 lock panel in the sandbox |
| **Boss Battle Prep** (Step 2 complete) | Click "Unlock" on Step 2 lock panel |
| **Showdown Tips** (≥3 badges) | Click "Unlock" on Step 3 lock panel |
| **Jungle Crown Vote** (Step 2 + ≥3 badges) | Enable voting in the leaderboard widget |

**Accessibility note:** If a participant falls behind due to technical issues, you may manually unlock steps to ensure they are not penalized for setup problems.

### 14.4 Boss Battle Facilitation

**Before Boss Battle (2 min):**
1. Form teams: 3–4 participants each, with at least one Scout, one Engineer, and one Architect.
2. Use "jungle draft": call participants one by one, alternating teams until balanced.
3. Distribute Boss Battle Cards (bug descriptions — anonymized).

**During Boss Battle (15 min):**
1. Activate Boss Battle Mode in the sandbox (toggle in `mock/index.html`).
2. Watch for teams discovering bugs. Announce discoveries: "Team Alpha found the CSS bug!"
3. Track individual bonus points for first discoverers.

**After Boss Battle (5 min):**
1. Each team presents their fixes (2 min per team).
2. Announce team winner (first + most correct) and individual bonus point winners.
3. Award +5 leaderboard points to the winning team.

### 14.5 Kudos System

**At workshop start:**
1. Give each participant 3 physical Kudos tokens (or digital tokens on their tracking card).
2. Explain: "Use your tokens to acknowledge peers who helped you. Each token = +10 leaderboard points. You can only give, never receive, 5 Kudos max."

**During workshop:**
- Announce Kudos at phase transitions: "Who received Kudos today?"
- Track Kudos on the leaderboard widget.
- Remind participants with unused tokens: "You have 1 Kudos left — use it wisely!"

**At Showdown:**
- Announce Kudos recipients (top 3 by Kudos count).
- Each Kudos = +10 leaderboard points (affect Jungle Crown eligibility).

### 14.6 Jungle Crown Selection

**Eligibility:** Participants with ≥5 badges.
**Selection Method:** Peer-voted. Each eligible participant casts one vote.
**Tiebreak:** Highest combined leaderboard score (badges + Kudos + token efficiency).
**Award:** Printed or digital Jungle Crown medal + verbal recognition.

**Announcement:** After path-specific awards, announce: "The Jungle Crown goes to..." with jungle-themed language.

---

*Print this card. Keep it visible during delivery. Enforce hard stops.*

---

## 15. Instructor Analytics Dashboard & Real-Time Monitoring

This section provides real-time analytics tools for the instructor to monitor workshop progress, budget health, and artifact completion. The primary tool is `instructor-dashboard.html` — a standalone HTML file that runs locally with zero external dependencies (compliant with DXS-1).

### 14.1 Dashboard Quick Start

1. **Launch:** Open `instructor-dashboard.html` in any modern browser.
2. **Enable Notifications:** Click the "🔔 Alerts" button to allow browser push notifications.
3. **Select View:** Use the role dropdown to choose between Lead Instructor (all teams), Path Mentor (single path group), or Judge (artifact readiness only).
4. **Monitor:** The dashboard refreshes every 15 seconds. No server required.

### 14.2 Dashboard Panels

| Panel | What It Shows | When to Check |
|-------|--------------|---------------|
| **Workshop Overview** | Summary stats: total teams, active teams, budget used %, artifact completion %, active alerts | Every 10 minutes |
| **Budget Burn Heatmap** | Color-coded grid showing each team's budget consumption (green <50%, yellow 50–80%, red >80%, dark red >100%) | Monitor continuously; intervene on red |
| **Participant Progress** | Table of all teams with status (Active/Stuck/Blocked/Completed), last active time, budget spent | When a team's status changes |
| **Artifact Health** | Completion rate bars per artifact type (Test Plan, Risk Analysis, Budget Log) + "At Risk" team list | Before phase transitions |
| **Alert Feed** | Color-coded alerts: budget exceeded, stuck flag, artifact completed | Respond immediately to red alerts |

### 14.3 Alert Types & Response Procedures

| Alert Type | Color | Trigger | Instructor Action |
|-----------|-------|---------|-------------------|
| **Budget Exceeded** | 🔴 Red | Team's logged cost exceeds path budget threshold (Scouts $20, Engineers $30, Architects $35) | Disable cloud model for that team; switch to sovereign only |
| **Stuck Flag** | 🟡 Yellow | No file change for >10 minutes | Circulate silently; check for Flow Pass; offer Tier 1–2 hint if needed |
| **Artifact Missing** | 🟡 Yellow | Active >20 min with zero artifacts | Verify team is on correct path; check if they need a fresh start |

### 14.4 Post-Workshop Reporting

1. Click "📊 Export CSV" to download a complete analytics report.
2. The CSV includes team-level data (status, budget, artifacts, alerts) and summary statistics.
3. Share the CSV with workshop organizers and stakeholders within 24 hours.
4. File naming convention: `workshop-analytics-IAD-{YYYY-MM-DD}.csv`

### 14.5 Troubleshooting the Dashboard

| Symptom | Action |
|---------|--------|
| Dashboard shows zero teams | Ensure `docs/teams/` directory structure exists; the dashboard uses simulated data by default |
| Notifications not working | Click "🔔 Alerts" button; browser may require explicit permission |
| CSV export not downloading | Check browser pop-up blocker; allow downloads for the local file |
| Data not refreshing | Dashboard refreshes every 15 seconds automatically; check browser console for JS errors |

### 14.6 Data Privacy (GDPR Compliance)

- **No PII displayed:** Team identifiers are anonymized (Team A, Team B, etc.). No participant names appear.
- **Session-only storage:** All dashboard state is stored in `sessionStorage` and clears on tab close.
- **Export compliance:** CSV exports contain team IDs only — no names, emails, or personal identifiers.
- **Privacy notice:** Visible at the top of the dashboard at all times.

---