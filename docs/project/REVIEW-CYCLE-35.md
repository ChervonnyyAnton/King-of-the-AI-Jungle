# 🔄 Review & Remediation: Cycle 35

## 🎯 Objective
Focus on **Agentic AI & GenAI — Hallucination Mitigation** to enforce fact-checking against `docs/requirements/` before accepting AI-generated output.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **No Fact-Check Rule** | No rule requires AI output to be verified against source-of-truth requirement files before being treated as correct. | High | **All Paths:** Hallucinated requirements or non-existent JIRA tickets could mislead every participant. | Added a mandatory "Fact-Check Gate" to the Quality Gates section of `R&R-CYCLE-RULES.md` and a verification instruction to every prompt template in `AGENTS.md`: *"Cite the exact source file (e.g., `docs/requirements/TICKETS/JIRA-102.md`) for every factual claim. If a claim cannot be traced to a file in `docs/requirements/`, flag it as 'Unverified' and do not include it in the final output."* |
| **Mock App Claims** | `mock/index.html` header states "Enterprise PDF Generator v2.0" — an AI might hallucinate enterprise features that do not exist. | Medium | **Engineers (D/E):** Automated tests could assert non-existent enterprise features. | Added to the prompt templates: *"Never assert features not present in `mock/index.html` source code. If the user asks for an unimplemented feature, respond with 'Not currently available — flag for roadmap discussion.'"* |
| **Websearch Fallback** | `websearch`/`webfetch` instructions lack a verification step — AI could surface outdated or incorrect external information. | Medium | **Scouts (A/B):** Beginners using `websearch` may adopt incorrect best practices. | Updated the Research Limits rule: *"After a `websearch` or `webfetch`, summarize the findings and cross-reference them with `docs/requirements/` before incorporating into any artifact. Flag any external information that contradicts project requirements."* |

## 📂 Updated Files
- `AGENTS.md`: Added "Fact-Check Gate" instruction to all prompt templates; updated Research Limits rule.
- `R&R-CYCLE-RULES.md`: Added "Fact-Check Gate" to the Quality Gates (Definition of Done) checklist.

## 🧪 Validation
- [x] Workshop Stability Check
- [x] Instructor Script Consistency
- [x] Version Alignment
