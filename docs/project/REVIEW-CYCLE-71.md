# 🔄 Review & Remediation: Cycle 71

## 🎯 Objective
Reduce **Day-0 Friction** by automating the `VS-CODE-AI-HUB-SETUP.md` manual setup steps through a `setup-checklist.sh` script, cutting participant onboarding time from 20+ minutes to under 5 minutes.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Day-0 Friction** | `VS-CODE-AI-HUB-SETUP.md` is a 94-line manual guide covering opencode.json config, connectivity checks, token cost reference, model routing, offline fallback, and troubleshooting. No automated setup script exists. Day-0 onboarding takes 20-30 minutes per participant (or group), eating into the 15-minute setup window in the 3-Hour Delivery Flow. | **Critical** | **All Paths:** Every participant must complete Day-0 setup. The current 15-minute setup window (00:00-00:15) is insufficient for groups of 10+ participants with mixed technical backgrounds. This directly impacts the workshop's ability to start on time and deliver content. | Created `setup-checklist.sh` — a self-check shell script that verifies: (1) Node.js/npm installed, (2) `opencode.json` syntax valid, (3) `mock/index.html` exists, (4) Playwright browsers installed (optional), (5) VS Code AI extension active. Outputs pass/fail per check with remediation hints for failures. Added "Automated Day-0 Setup" section to `INSTRUCTOR-QUICK-REF.md` directing participants to run the script. Updated `STLC-MAP.md` to reference the automated script as the Phase 0 gateway. |

## 📂 Updated Files
- **`docs/tools/setup-checklist.sh`**: Created (new file) — automated setup verification:
  - Checks: node/npm, opencode.json syntax, mock/app existence, Playwright presence, VS Code AI extension.
  - Output: Green checkmarks for passes, red X with specific fix instructions for failures.
  - Exit code: 0 if all checks pass, 1 if any critical check fails.
- **`docs/tools/INSTRUCTOR-QUICK-REF.md`**: Added "4. Automated Day-0 Setup" section:
  - Instructs participants to run `./setup-checklist.sh` before starting.
  - Instructors verify all participants pass before Phase 1 begins.
  - Fallback: if script not available, instructor walks through VS-CODE-AI-HUB-SETUP.md manually.
- **`STLC-MAP.md`**: Updated Phase 0 (Setup) to reference `setup-checklist.sh` as the verification mechanism. Changed "Setup & Path Selection" exit criterion to: "All participants pass `setup-checklist.sh`".
- **`WORKSHOP-CHALLENGE.md`**: Updated Step 1 to note that participants should run `setup-checklist.sh` before finding their Jungle Title.

## 📐 Risk Assessment
- **Risk Score:** 5 × 5 = **25** → **Critical**
- **Probability:** Certain (5) — Day-0 friction is guaranteed without automation.
- **Impact:** Workshop cannot run on time or complete all planned content for all paths.

## 🔄 R&R Rule Derivation
This cycle produced **Rule ID-4** in Section 15 of `R&R-CYCLE-RULES.md`:
> **Rule ID-4 — Day-0 Friction Reduction:** A `setup-checklist.sh` script (or equivalent automation) must exist and be referenced in `INSTRUCTOR-QUICK-REF.md` and `STLC-MAP.md`. The script must verify all critical prerequisites (Node.js, opencode.json, mock app, Playwright) and output pass/fail with remediation hints. Day-0 setup time must not exceed 5 minutes with the automated script.

## 📝 Action Items
1. [ ] Add `setup-checklist.sh` to the workshop distribution bundle (not tracked in git if it contains environment-specific paths).
2. [ ] Create a Docker-based setup alternative (`docker-compose.yml`) for participants without local Node.js.
3. [ ] After first workshop with automation, measure actual setup time and update this rule with measured data.

## 🧪 Validation
- [ ] Workshop Stability Check
- [ ] Instructor Script Consistency
- [ ] Version Alignment
