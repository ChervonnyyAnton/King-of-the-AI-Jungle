---
name: rr-implementer
description: >
  Enforces existing Review & Remediation (R&R) rules in a target repository.
  Use when the repo has an R&R-CYCLE-RULES.md and you want to scan artifacts
  against the rules, remediate findings, log cycles, and run SI-Cycles.
  NOT for repos without R&R rules — use rr-executor instead.
---

# 🔧 Skill: R&R Implementer

**Purpose:** Implements the **Review & Remediation (R&R) rules** from the target repository's own R&R framework document. This agent assumes the target repo **already has** a defined R&R ruleset (e.g., `R&R-CYCLE-RULES.md`) and applies those specific rules to remediate issues in the codebase.

> **Trigger:** Use this skill when the target repository has an existing R&R rules document and the user wants to implement or enforce those rules.
>
> **NOT for** repos without R&R rules — use the **R&R Executor** skill instead.

---

## 🧠 How It Works

1. **Discover** the R&R rules file in the target repository (default: `R&R-CYCLE-RULES.md` or `docs/project/R&R-CYCLE-RULES.md`).
2. **Parse** the rules, severity matrix, quality gates, and domain definitions from the R&R document.
3. **Scan** the target repository's artifacts (code, docs, configs) against the applicable rules.
4. **Remediate** findings by editing files, creating new artifacts, or updating configs.
5. **Log** each remediation as a cycle log in `docs/project/REVIEW-CYCLE-NN.md`.
6. **Self-improve** by running the SI-Cycle protocol after every batch.

---

## 📋 Phase 1: R&R Rules Discovery

### Step 1.1 — Locate the R&R Document
Search for the R&R rules file in these locations (priority order):

```
R&R-CYCLE-RULES.md
docs/R&R-CYCLE-RULES.md
docs/project/R&R-CYCLE-RULES.md
rules/R&R-CYCLE-RULES.md
```

If no R&R file is found, **stop and inform the user**:
> "No R&R rules document found in this repository. Use the R&R Executor skill instead, which can apply a generalized R&R framework."

### Step 1.2 — Parse Rule Categories
Extract from the R&R document:

| Extracted Item | Purpose |
|----------------|---------|
| **Domain List** | Which areas to focus on (pedagogy, technical, security, UX, etc.) |
| **Severity Matrix** | How to classify findings (Critical/High/Medium/Low) |
| **Quality Gates** | Definition of Done criteria for each cycle |
| **Cycle Template** | Format for logging remediation |
| **Section-Specific Rules** | Rule codes (e.g., DP-1, GAM-5, CI-3) with descriptions |
| **Rule Index** | Consolidated table mapping rule codes to sections |

### Step 1.3 — Identify the Last Cycle Number
Read existing cycle logs in `docs/project/` to determine the next cycle number.

```bash
ls docs/project/REVIEW-CYCLE-*.md 2>/dev/null | sort -V | tail -1
```

If no logs exist, start at Cycle 1.

---

## 📋 Phase 2: Artifact Discovery & Baseline

### Step 2.1 — Inventory Target Artifacts
Scan the repository for all artifacts mentioned in the R&R rules. For each domain defined in the R&R document, identify:

| Artifact Type | Common Locations |
|---------------|-----------------|
| **Documentation** | `docs/`, `README.md`, `AGENTS.md`, `SKILLS.md` |
| **Code/Tests** | `src/`, `tests/`, `mock/` |
| **Config** | `opencode.json`, `playwright.config.js`, `.gitlab-ci.yml` |
| **Feedback** | `docs/feedback/`, `BUDGET-LOG.md` |
| **CI/CD** | `docs/ci/`, `.gitlab-ci.yml` |
| **Dashboards** | `*.html` files in the project root |

### Step 2.2 — Establish Baseline
Record the current state of each artifact:
- Line counts
- Version numbers (e.g., `v3.4` in change logs)
- File existence checks
- Cross-reference integrity (links, section numbers)

---

## 📋 Phase 3: Rule Application & Remediation

### Step 3.1 — Select Target Domain
Ask the user which domain to focus on, or if unspecified, process all domains in priority order:

1. **Critical** findings (workshop broken for all paths)
2. **High** findings (specific domain affected)
3. **Medium** findings (quality gaps)
4. **Low** findings (cosmetic improvements)

### Step 3.2 — Apply Rules Within Domain
For each applicable rule in the selected domain:

1. **Check compliance** — Does the artifact satisfy the rule?
2. **If compliant** — Log as PASS in the cycle log.
3. **If non-compliant** — Determine severity using the severity matrix.
4. **Remediate** — Edit the artifact to satisfy the rule.
5. **Re-validate** — Confirm the remediation passes.

### Step 3.3 — 2-Axis Alignment Check
Every remediation must state which role/title benefits:

> "This helps [Jungle Title or role equivalent] by [specific benefit]."

For non-workshop repos, map the 2-Axis concept to the repo's own roles or personas.

### Step 3.4 — Quality Gate Verification
After each remediation batch, verify against all Quality Gates:

| Gate | Check |
|------|-------|
| **Stability** | Core artifacts remain functional |
| **Traceability** | Every change maps to a rule |
| **Coverage** | ≥80% of rules verified per domain |
| **Documentation** | Updated if required by the rule |
| **Versioning** | Versions consistent across files |

---

## 📋 Phase 4: Logging & Traceability

### Step 4.1 — Write Cycle Log
Use the standardized template from the R&R document. Default template:

```markdown
# 🔄 Review & Remediation: Cycle NN

## 🎯 Objective
[One sentence: which domain, which rules, which artifact]

## 📋 Findings & Remediation

| # | Area | Finding | Severity | Rule | Remediation |
|---|------|---------|----------|------|-------------|
| 1 | [Domain] | [What was found] | [Critical/High/Med/Low] | [Rule-Code] | [What was changed] |

## 📂 Updated Files
- `[path]`: [Brief description of change]

## 🧪 Validation
- [ ] Workshop Stability Check (core artifacts still work)
- [ ] Instructor Script Consistency (if applicable)
- [ ] Version Alignment
- [ ] 2-Axis Alignment (maps to role benefit)
```

### Step 4.2 — Update Rule Index
After adding new rules or updating existing ones, update the Consolidated Rule Index in the R&R document.

### Step 4.3 — Update Change Log
Add an entry to the Change Log table at the top of the R&R document:

| Version | Date | Change | Authoring Cycle |
|---------|------|--------|-----------------|
| vX.Y | YYYY-MM-DD | [Summary of changes] | Cycles NN-NN |

---

## 📋 Phase 5: Self-Improvement Cycle (SI-Cycle)

After every batch of 10 remediation cycles, execute an SI-Cycle:

### Step 5.1 — Retrospective Questions
Ask:

1. **Which rules were hardest to verify?** (Simplify or reword if needed.)
2. **Was the document too long?** (Compress if >1500 lines.)
3. **Did we create any redundancy?** (Remove duplicate rules.)
4. **Are any rules "too theoretical" or "hard to apply"?** (Make them more concrete.)
5. **Did any remediation create new issues?** (Roll back or adjust.)

### Step 5.2 — Self-Healing Actions
Based on retrospective answers:

| Finding | Action |
|---------|--------|
| Document > 1500 lines | Compress Rule Index to single table; remove verbose "Principle" paragraphs |
| Redundant rules detected | Merge duplicate rules into a single rule with multiple attributes |
| Rules hard to verify | Replace abstract criteria with concrete, testable checks |
| Missing cross-references | Update all internal references to new section numbers |
| Outdated rules | Mark as ⚠️ Deprecated and propose replacement |

### Step 5.3 — SI-Cycle Log
Write `docs/project/REVIEW-CYCLE-NI.md` (where NI = 10×batch number, e.g., 10, 20, 30):

```markdown
# 🔄 Review & Remediation: SI-Cycle NI (Self-Improvement)

## 🎯 Objective
Post-batch self-improvement retrospective for Cycles (N-9)–N.

## 📋 Retrospective Findings

| Question | Finding | Action Taken |
|----------|---------|--------------|
| Which rules were hard to verify? | [Answer] | [Action] |
| Was the document too long? | [Answer] | [Action] |
| Were there redundancies? | [Answer] | [Action] |
| Are any rules too theoretical? | [Answer] | [Action] |
| Did remediation create issues? | [Answer] | [Action] |

## 🧪 Health Check
- [ ] Line count under threshold (< 1500 target, < 3000 hard limit)
- [ ] Consolidated Rule Index complete
- [ ] Change Log updated
- [ ] No duplicate section numbers
- [ ] No stale cross-references
```

---

## 📋 Phase 6: Final Reporting

### Step 6.1 — Batch Summary
After completing a batch (10 cycles + SI-Cycle), produce:

```markdown
## 📊 Batch Summary — Cycles NN–(NN+9)

| Metric | Value |
|--------|-------|
| Cycles Completed | 10 (+ 1 SI-Cycle) |
| Rules Implemented | X |
| Rules Verified (Already Passing) | Y |
| Findings Resolved | Z |
| Remaining Open Findings | W |
| Document Size (lines) | N |
| Health Status | ✅ Pass / ⚠️ Warning / ❌ Fail |
```

### Step 6.2 — Recommendations
Provide a prioritized list of remaining work:

1. **Critical:** What must be fixed before the next batch?
2. **High:** What should be addressed in the next 10-cycle batch?
3. **Low:** Nice-to-have improvements.

---

## 🧰 Tooling & Patterns

### Detecting Artifact Types
Use file extensions and directory structure to classify artifacts:

```
*.md   → Documentation
*.html → Web/Sandbox/App artifacts
*.json → Config, schema, or data artifacts
*.js   → Scripts, tests, or app logic
*.yml  → CI/CD pipelines
*.sh   → Build or validation scripts
```

### Verifying Rule Compliance (Examples)

| Rule Code | Verification Method |
|-----------|-------------------|
| **DP-1** (Data Privacy) | Check that all test data files use synthetic/fake data; no real PII |
| **CI-3** (CI/CD) | Verify CI pipeline includes the required validation job |
| **GAM-5** (Gamification) | Check HTML for Boss Battle UI elements and toggle |
| **UX-2** (UX Consistency) | Verify CSS variables match across all HTML files |
| **DOC-3** (Documentation) | Check cross-references resolve; no broken links |
| **CR-1** (Section Continuity) | Verify section numbers are sequential with no gaps |

### Editing Pattern
When remediating, follow this pattern:

1. **Read** the affected file.
2. **Locate** the issue (line number, section, artifact).
3. **Apply** a minimal, targeted edit.
4. **Re-read** to confirm the change is correct.
5. **Log** the change in the cycle log.

---

## ⚠️ Guardrails

- **Never modify** `AGENTS.md` or `opencode.json` without explicit user confirmation.
- **Never push** to a remote repository — all changes are local.
- **Never** change version numbers without matching all files that reference the version.
- **Always** preserve the original R&R rules document structure (headers, tables, formatting).
- **Escalate** any finding that would require deleting core artifacts (e.g., `AGENTS.md`, `mock/index.html`).
- **Stay within budget** — track token usage; stop if approaching the limit.

---

## 🚦 When to Use This Skill vs. R&R Executor

| Condition | Use |
|-----------|-----|
| Target repo has `R&R-CYCLE-RULES.md` | ✅ **R&R Implementer** (this skill) |
| Target repo has no R&R document | ⬜ **R&R Executor** (generalized) |
| User wants to create new R&R rules for the repo | ⬜ **R&R Executor** (first) → **R&R Implementer** (then) |
| User wants to audit an existing R&R document | ✅ **R&R Implementer** (CR-1, CR-2, CR-3 checks) |

---

*Implement with precision. Remediate with traceability. Stay within budget.* 🔧
