---
name: rr-executor
description: >
  Executes a generalized Review & Remediation (R&R) framework on any repository,
  even if it has no existing R&R rules. Analyzes the repo, infers its type and
  structure, applies best-practice rules from ISTQB, ISO/IEC 25010, and software
  engineering standards, and builds a tailorable R&R framework for the repo.
  Use when the target repo has no R&R rules document and the user wants quality
  assurance and continuous improvement governance.
---

# 🏃 Skill: R&R Executor

**Purpose:** Executes a **generalized Review & Remediation (R&R) framework** on **any repository**, even if it has no existing R&R rules. This agent analyzes the repo, infers its type and structure, applies best-practice rules from ISTQB, ISO/IEC 25010, and software engineering standards, and builds a tailorable R&R framework for the repo.

> **Trigger:** Use this skill when the target repository has **no R&R rules document** and the user wants quality assurance and continuous improvement governance.
>
> **Output:** After the first run, the repo will have `R&R-CYCLE-RULES.md` — after which the **R&R Implementer** skill can take over for domain-specific enforcement.

---

## 🧠 How It Works

1. **Analyze** the repository structure, language, frameworks, and existing artifacts.
2. **Classify** the repo type (Web App, API, CLI Tool, Workshop, Documentation, etc.).
3. **Infer** applicable quality rules from industry standards (ISTQB, ISO 25010, WCAG, OWASP).
4. **Generate** a tailored `R&R-CYCLE-RULES.md` for this specific repo.
5. **Execute** the first set of R&R cycles to remediate high-impact issues.
6. **Hand over** to the R&R Implementer skill for ongoing rule-based governance.

---

## 📋 Phase 1: Repository Analysis

### Step 1.1 — Structural Scan
Examine the repo to determine:

```
┌─ Language / Runtime ──────┐
│ package.json, *.kt, *.go  │
│ *.cs, Cargo.toml, ...     │
└───────────────────────────┘

┌─ Framework / Stack ───────┐
│ React, Spring Boot, etc.  │
│ Playwright, Jest, etc.    │
└───────────────────────────┘

┌─ Existing Artifacts ──────┐
│ tests/, docs/, src/       │
│ README.md, LICENSE        │
│ CI config, Dockerfile     │
└───────────────────────────┘

┌─ Current Quality State ───┐
│ Coverage %, linter errors  │
│ Test count & types        │
│ Documentation coverage    │
└───────────────────────────┘
```

### Step 1.2 — Repo Classification
Classify the repo using this decision matrix:

| Indicator | Repo Type |
|-----------|-----------|
| `mock/index.html`, `WORKSHOP-CHALLENGE.md`, `AGENTS.md` | Workshop / Training |
| `playwright.config.js`, `*.spec.ts`, test directories | Test Automation |
| `src/` with API routes, no UI | API / Backend Service |
| `src/` with UI components, HTML templates | Web Application |
| `docs/` only, no `src/` | Documentation Only |
| `Dockerfile`, `docker-compose.yml`, K8s manifests | Infrastructure / Platform |
| Mix of the above | Full-Stack Application |

### Step 1.3 — Identify Gaps
For each quality dimension, check what exists and what's missing:

| Dimension | Checks |
|-----------|--------|
| **Testing** | Are there automated tests? What type (unit, integration, e2e)? Coverage %? |
| **Documentation** | README, API docs, architecture docs, change logs? |
| **CI/CD** | Pipeline config, linting, testing, security scanning? |
| **Security** | Dependency audit, secrets scan, input validation, CSP? |
| **Accessibility** | ARIA attributes, keyboard nav, color contrast, screen reader testing? |
| **Observability** | Logging, metrics, error tracking, health checks? |
| **Versioning** | Semantic versioning, changelog, release process? |

---

## 📋 Phase 2: Infer R&R Rules

### Step 2.1 — Generate Domain-Specific Rules
Based on the repo classification, generate applicable R&R rules. Here are the default rule sets:

#### For Web Applications:

| Rule | Domain | Focus |
|------|--------|-------|
| **WEB-1** | Security | XSS protection, CSP headers, input sanitization |
| **WEB-2** | Accessibility | WCAG 2.1 AA: color contrast, ARIA roles, keyboard navigation |
| **WEB-3** | Performance | Page load < 3s, lazy loading, image optimization |
| **WEB-4** | Reliability | Error boundaries, graceful degradation, loading states |
| **WEB-5** | UX Consistency | Shared design tokens, responsive layout, cross-browser |

#### For API / Backend Services:

| Rule | Domain | Focus |
|------|--------|-------|
| **API-1** | Security | Authentication, authorization, input validation, rate limiting |
| **API-2** | Reliability | Error handling, retry logic, circuit breakers, health checks |
| **API-3** | Performance | Response time < 200ms, caching, pagination |
| **API-4** | Documentation | OpenAPI/Swagger spec, request/response examples |
| **API-5** | Testing | Contract tests, integration tests, fault injection |

#### For Test Automation:

| Rule | Domain | Focus |
|------|--------|-------|
| **TST-1** | Reliability | Flaky test detection, retry logic, stabilization |
| **TST-2** | Coverage | Requirements-to-test traceability ≥90% |
| **TST-3** | Performance | Test execution time < 10min for full suite |
| **TST-4** | Maintainability | Page Object / Component Abstraction, no hardcoded selectors |
| **TST-5** | Reporting | Test reports with evidence (screenshots, logs) |

#### For Infrastructure / Platform:

| Rule | Domain | Focus |
|------|--------|-------|
| **INF-1** | Security | Secrets management, least privilege, network policies |
| **INF-2** | Reliability | Health checks, auto-recovery, backup/restore |
| **INF-3** | Observability | Metrics, logging, alerting, dashboards |
| **INF-4** | Documentation | Architecture diagrams, runbooks, escalation paths |
| **INF-5** | Compliance | Podsecurity, resource limits, network segmentation |

#### For Documentation Only:

| Rule | Domain | Focus |
|------|--------|-------|
| **DOC-1** | Completeness | All public APIs/CLI commands documented |
| **DOC-2** | Accuracy | Examples work, code snippets compile/run |
| **DOC-3** | Cross-references | No broken links, consistent terminology |
| **DOC-4** | Searchability | Table of contents, searchable, indexed |
| **DOC-5** | Versioning | Version-specific docs, migration guides |

### Step 2.2 — Generate Severity Matrix
Adopt a standardized severity matrix:

| Severity | Definition | Action |
|----------|------------|--------|
| **Critical** | System broken, security vulnerability, data loss risk | Immediate fix |
| **High** | Major feature broken, significant UX gap | Fix within current sprint |
| **Medium** | Quality gap, inconsistency, minor UX issue | Fix if time / next sprint |
| **Low** | Cosmetic, typo, nice-to-have | Fix if time |

### Step 2.3 — Generate Quality Gates
Standard Definition of Done:

- [ ] **Code Quality:** Linting passes, no new warnings
- [ ] **Test Coverage:** ≥80% for new code
- [ ] **Security:** No new vulnerabilities (SAST/DAST pass)
- [ ] **Accessibility:** WCAG 2.1 AA (for UI changes)
- [ ] **Documentation:** Updated where applicable
- [ ] **Performance:** No regression in key metrics
- [ ] **Backward Compatibility:** No breaking changes (unless version bump)

---

## 📋 Phase 3: Generate R&R Document

### Step 3.1 — Create `R&R-CYCLE-RULES.md`
Write a tailored R&R document with:

1. **Objective** — Based on repo type and purpose.
2. **Domain & Scope** — Only the domains applicable to this repo.
3. **Severity Matrix** — The standardized matrix from Phase 2.2.
4. **Quality Gates** — The gates from Phase 2.3.
5. **Inferred Rules** — The rules from Phase 2.1, formatted per the R&R standard.
6. **Cycle Template** — The standard logging template.
7. **Consolidated Rule Index** — Table of all generated rules.
8. **Change Log** — Initial entry documenting generation.

### Step 3.2 — Version the Document
Use `v1.0` as the initial version. Include:

```markdown
| Version | Date | Change | Authoring Cycle |
|---------|------|--------|-----------------|
| v1.0 | 2026-11-10 | Generated by R&R Executor — auto-inferred rules from repo structure | Executor-1 |
```

### Step 3.3 — Store in Canonical Location
Default: `R&R-CYCLE-RULES.md` (project root).
If a `docs/` directory exists: `docs/project/R&R-CYCLE-RULES.md`.

---

## 📋 Phase 4: Execute First Remediation Cycles

### Step 4.1 — Run Critical & High Priority Checks
Before logging, immediately scan for Critical and High findings:

1. **Security Vulnerabilities:** Check for hardcoded secrets, outdated dependencies, missing CSP.
2. **Broken Artifacts:** Check that documented examples actually work.
3. **Missing Core Docs:** README missing? API docs absent?
4. **Test Infrastructure:** No tests at all? Broken CI?

### Step 4.2 — Remediate Critical Issues
For each Critical/High finding:

1. **Read** the affected file(s).
2. **Apply** the fix (e.g., add missing README, fix broken link, add CSP header).
3. **Verify** the fix doesn't break anything.
4. **Log** the remediation.

### Step 4.3 — Log First Cycle (Executor-1)
Write the first cycle log:

```markdown
# 🔄 Review & Remediation: Executor-1 (Auto-Generated)

## 🎯 Objective
Initial R&R execution — analyze repository, infer rules, remediate critical issues.

## 📋 Repository Analysis

| Attribute | Value |
|-----------|-------|
| Repo Type | [Classified type] |
| Language/Runtime | [Detected language] |
| Framework/Stack | [Detected framework] |
| Test Coverage | [If available, else "Unknown"] |
| CI/CD | [Present / Absent] |
| Documentation | [Present / Partial / Absent] |

## 📋 Findings & Remediation

| # | Area | Finding | Severity | Rule | Remediation |
|---|------|---------|----------|------|-------------|
| 1 | [Domain] | [Finding] | Critical/High | [Rule-1] | [Remediation] |

## 📂 Generated Artifacts
- `R&R-CYCLE-RULES.md`: Initial R&R framework with [X] rules across [Y] domains
- `docs/project/REVIEW-CYCLE-Executor-1.md`: This log

## 🧪 Validation
- [ ] Critical issues remediated
- [ ] R&R document generated and consistent
- [ ] Rule index complete
```

---

## 📋 Phase 5: Ongoing Cycle Execution

### Step 5.1 — Cycle Numbering
After the initial Executor-1 cycle, switch to numbered cycles:
- **Executor-1** = Initial setup (done once)
- **Cycle 1–10** = First batch
- **Cycle 11–20** = Second batch
- etc.

### Step 5.2 — Batch Processing
Each batch follows the same pattern:

1. **Select domain** (rotate through all domains if user doesn't specify).
2. **Scan artifacts** against the domain's rules.
3. **Remediate** findings.
4. **Log** each cycle.
5. **Every 10th cycle** = SI-Cycle (self-improvement).

### Step 5.3 — SI-Cycle (Self-Improvement)
After every batch of 10 cycles:

1. **Retrospective:** Ask if rules need refinement.
2. **Compress:** If the R&R document exceeds 1500 lines, compress it.
3. **Update:** New rules from observations go into the R&R document.
4. **Log:** Write `REVIEW-CYCLE-NI.md` (SI-Cycle log).

---

## 📋 Phase 6: Evolution & Handover

### Step 6.1 — Rule Evolution
As the R&R Executor runs more cycles, rules evolve:

| State | Action |
|-------|--------|
| **Rule rarely triggered** | Mark as ⚠️ Low Priority — review for removal |
| **Rule frequently triggered** | Upgrade severity or add sub-rules |
| **New pattern discovered** | Add new rule or domain |
| **Rule obsolete** | Mark as Deprecated, remove in next SI-Cycle |

### Step 6.2 — Handover to R&R Implementer
After the R&R Executor has:
1. Generated `R&R-CYCLE-RULES.md` (Phase 3), and
2. Completed at least 2 remediation batches (20 cycles),

**Inform the user:**

> "The R&R Executor has completed its initial setup and [X] batches. The repository now has a tailored R&R framework with [X] rules. You can now use the **R&R Implementer** skill for ongoing, rule-based remediation. The R&R Executor remains available for new repo analysis or rule evolution."

### Step 6.3 — Transition Checklist
Before handover:

- [ ] `R&R-CYCLE-RULES.md` exists and is comprehensive
- [ ] All Critical and High findings from initial scan are resolved
- [ ] At least 10 cycle logs exist in `docs/project/`
- [ ] Consolidated Rule Index is complete
- [ ] Change Log has accurate history
- [ ] Document is under 1500 lines (or compressed)

---

## 🧰 Default Rule Sets by Repo Type

### Quick Reference: Which Rules Apply

| Repo Has... | Apply These Rules |
|-------------|------------------|
| `*.html` + `*.css` + JS | WEB-1 through WEB-5 |
| `src/` with API routes | API-1 through API-5 |
| `tests/` with specs | TST-1 through TST-5 |
| `Dockerfile` + K8s YAML | INF-1 through INF-5 |
| `docs/` only | DOC-1 through DOC-5 |
| Workshop files | Use King-of-the-AI-Jungle rules (R&R Implementer) |
| Multiple types | Combine applicable rule sets |

### Custom Rule Generation
If the repo has unique characteristics not covered by the defaults, generate new rules:

1. **Identify the unique pattern** (e.g., custom error handling, specific compliance requirement).
2. **Name the rule code** using a 3-letter prefix + number (e.g., `CUST-1`).
3. **Define the principle, rule, and verification** in the standard format.
4. **Add to the Consolidated Rule Index.**

---

## ⚠️ Guardrails

- **Never modify** files outside the target repository.
- **Never push** to a remote — all changes are local.
- **Never** assume the repo's security posture — scan first, fix second.
- **Always** preserve existing versioning conventions (check `CHANGELOG.md`, `package.json`, etc.).
- **Always** create a new cycle log for every remediation — never skip logging.
- **Escalate** any finding that would require architectural changes (not just edits).
- **Stay within budget** — track token usage; stop if approaching the limit.

---

## 🚦 When to Use This Skill vs. R&R Implementer

| Condition | Use |
|-----------|-----|
| Target repo has **no** R&R document | ✅ **R&R Executor** (this skill) |
| Target repo has `R&R-CYCLE-RULES.md` | ⬜ **R&R Implementer** |
| User wants to **create** R&R rules for a new repo | ✅ **R&R Executor** |
| User wants to **enforce** existing R&R rules | ⬜ **R&R Implementer** |
| User wants to **audit** an existing R&R document | ⬜ **R&R Implementer** (CR checks) |

---

## 🔄 Executor vs. Implementer — Relationship

```
User Request: "Run R&R on repo X"
         │
         ▼
  Has R&R-CYCLE-RULES.md?
    ┌────┴────┐
    Yes       No
    │         │
    ▼         ▼
Implementer  Executor
(executes    (analyzes,
 existing    infers,
 rules)      generates
             rules,
             then runs
             them)
             │
             ▼
     R&R-CYCLE-RULES.md
         exists now
             │
             ▼
     Handover to
   R&R Implementer
     for ongoing
      governance
```

---

*Analyze comprehensively. Remediate strategically. Evolve continuously.* 🏃
