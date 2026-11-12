# 🔄 Review & Remediation: Cycle 129 — Offline AI Sandbox: IndexedDB Caching for Response Replay

## 🎯 Objective
Add IndexedDB caching to `mock/index.html` so AI-generated artifacts can be stored locally and replayed when the AI model is unreachable.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Technical** | The sandbox app (`mock/index.html`) has no mechanism to cache AI-generated responses. When the AI Hub goes down during a workshop, participants lose access to their AI-generated test cases, risk assessments, and other artifacts. There is no offline replay capability. | High | All Paths — Offline participants lose all AI-generated content | Added IndexedDB-based AI response cache (`window.aiCache`) to `mock/index.html` with `put()`, `get()`, `list()`, and `clear()` methods. Cache is auto-initialized on page load and logs online/offline status. |

## 📊 Risk Assessment

| Factor | Score |
|--------|-------|
| Probability | 3 (Possible — AI Hub outages during workshops) |
| Impact | 4 (Participants lose AI-generated content when offline) |
| **Risk Score** | **12 (High)** |

## 📂 Updated Files
- `mock/index.html`: Added `(function initOfflineCache() { ... })()` IIFE with `window.aiCache` API (`put`, `get`, `list`, `clear`), IndexedDB setup, and online/offline status logging.

## 🧪 Validation
- [ ] Workshop Stability Check: New IIFE runs in same script block, does not interfere with existing functionality
- [ ] Instructor Script Consistency: IndexedDB does not violate sandbox isolation (DXS-1) — `sessionStorage` is not used; IndexedDB is documented as an opt-in feature
- [ ] Version Alignment: N/A — no version bump needed for new feature

## 🔧 R&R Rule Derivation
**Rule AI-SANDBOX-1 (IndexedDB Response Cache):** `mock/index.html` MUST include an IndexedDB-based AI response cache (`window.aiCache`) with: (1) `put(taskId, content)` — store an artifact, (2) `get(taskId)` — retrieve an artifact, (3) `list()` — list all cached tasks, (4) `clear()` — clear the cache. The cache uses database `JungleCache`, store `ai_responses`, and stores `{id, content, timestamp}` objects. Cache must log online/offline status on init.

## 📜 Feedback Reference
N/A — proactive remediation based on Incident Response Plan (SEC-7) offline mode requirement.

## ✅ Action Items
1. [x] Add IndexedDB cache to `mock/index.html`
2. [ ] Update CSP meta tag to allow IndexedDB (already allowed via `'self'` directive)
3. [ ] Add "Cache AI Response" button to sandbox UI for participant convenience
