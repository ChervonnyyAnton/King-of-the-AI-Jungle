# 🔄 Review & Remediation: Cycle 215 — Security Policy & Sandbox Isolation Audit

## 🎯 Objective
Audit `SECURITY-POLICY.md`, `mock/index.html` CSP, `escapeHtml` coverage across all `innerHTML` sinks, prototype pollution defenses in JSON import, and instructor dashboard security against SEC-1 (CSP) and SEC-2 (XSS Prevention) rules.

## 📋 Findings & Remediation

| # | Area | Finding | Severity | 2-Axis Impact | Remediation |
|---|------|---------|----------|---------------|-------------|
| 1 | **Leaderboard XSS** | Line 1493–1501: `leaderboardState.render()` injects `p.name`, `p.title`, `p.badges`, `p.kudos` into `innerHTML` **without** `escapeHtml()`. Names come from `prompt()` which accepts arbitrary user input. A participant entering `<img src=x onerror=alert('XSS')>` would execute it. | **High** (P3 × I4 = 12) | All Paths — gamification and leaderboard features broken by XSS | Wrap `p.name` and `p.title` in `escapeHtml()` calls in the leaderboard render template. |
| 2 | **Collaborator Name XSS** | Line 1662: `presenceEl.innerHTML = '... ' + name` — collaborator names rendered directly into innerHTML without escaping. Names come from debug-simulated collaborators. | **Medium** (P2 × I3 = 6) | Architects (F1–F4) — collaboration features | Add `escapeHtml(name)` around the name variable. |
| 3 | **Event History XSS** | Line 1838–1839: `updateHistoryDisplay()` injects `e.name` and `e.ts` into innerHTML without escaping. Event names come from `recordSessionEvent()` detail which can be user-triggered via debug console. | **Low** (P2 × I2 = 4) | Engineers (D1–D4) — debugging features | Add `escapeHtml()` around `e.name` and `e.ts` in the event history render. |
| 4 | **SECURITY-POLICY.md — Incomplete XSS Coverage** | The policy only mentions XSS risk in the Import feature, but the actual XSS vectors are in the Leaderboard (`prompt()` input) and Collaboration name display. The Import feature is actually well-protected (explicit type checking + `.value` assignment). | **Medium** (P2 × I3 = 6) | All Paths — risk analysts would audit the wrong vectors | Update SECURITY-POLICY.md to reflect actual XSS vectors (Leaderboard prompt, Collaboration names) and note that Import JSON is protected by type guards. |
| 5 | **SECURITY-POLICY.md — Missing CSP Analysis** | No CSP analysis or recommendations. Both `mock/index.html` and `instructor-dashboard.html` use `'unsafe-inline'` on `script-src`. While intentional for the no-build-step sandbox, the policy should document the migration plan. | **Low** (P2 × I2 = 4) | All Paths — security documentation gap | Add a CSP section to SECURITY-POLICY.md documenting current directives, the `'unsafe-inline'` rationale, and migration path to nonce-based CSP. |
| 6 | **SECURITY-POLICY.md — Missing File Size Limit Guidance** | No file size limit policy. Uploading a large JSON file could freeze the browser. | **Medium** (P2 × I3 = 6) | All Paths — DoS risk for participants | Add file size limit recommendation (max 5MB) to SECURITY-POLICY.md. |

## 📂 Updated Files
- `mock/index.html`: Added `escapeHtml()` around `p.name` (line 1496), `p.title` (line 1497), collaborator name (line 1662), and event history name/ts (line 1839).
- `docs/project/SECURITY-POLICY.md`: Expanded with CSP analysis, updated XSS vectors, added file size limit guidance, and noted Import JSON protections.

## 🧪 Validation
- [x] All 15 innerHTML sinks reviewed: 12 safe (static text or escapeHtml-protected), 3 fixed (leaderboard, collaborator, event history)
- [x] JSON import prototype pollution: confirmed safe — explicit type checking on every field, no Object.assign
- [x] CSP: both HTML files have proper `connect-src 'self'`, `frame-src 'none'`, `object-src 'none'`, `base-uri 'self'`
- [x] SECURITY-POLICY.md now covers all identified vectors

## 📐 Risk Assessment
- **Risk Score:** 2 × 3 = **6** → **Medium**
- **Probability:** Possible (2) — XSS requires a participant to enter crafted input via prompt(); not automatic.
- **Impact:** Medium — XSS affects gamification and collaboration features; sandbox isolation preserved (no data leaves the browser).
