# 🤝 Dev Handoff: Sandbox PDF Generator

## 📦 Deliverables
- `mock/index.html`: Single-file SPA. No dependencies.
- `playwright.config.js`: Ready-to-run test runner.
- `docs/`: Requirements & Specs.

## 🔧 Run Locally
```bash
npx serve mock/
# Open http://localhost:3000
```

## 🚨 Known Constraints
- No backend. All logic client-side.
- Print relies on native `window.print()`. No third-party PDF libs.
- JSON import is untrusted by design (XSS risk mitigation required).

## 📅 Next Steps
1. QA validates JIRA-102 & JIRA-103.
2. SDET writes Playwright suite.
3. Architect reviews CI/CD pipeline (`CICD-HINTS.md`).
4. Dev merges & deploys to staging.
