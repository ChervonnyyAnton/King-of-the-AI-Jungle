# 🔄 Review & Remediation: Cycle 204 — Gamification UI (Instructor Dashboard Badges)

## 🎯 Objective
Ensure the Gamification rules (from Cycles 161–170) are properly visualized in `instructor-dashboard.html` — specifically that Jungle Badges are visible and actionable.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Dashboard Badges** | The instructor dashboard only displays `status-badge` (for team status: Active/Stuck/Blocked/Completed). There are NO gamification badges visible. GAM-1 (Jungle Badges on Profile Cards) is not implemented in the dashboard. | **High** | All Paths — gamification rules from Cycles 161–170 not visible to instructor | Add a "Gamification Panel" card to the dashboard showing badge counts per team, Kudos counts, and the leaderboard summary. |
| **Kudos Visibility** | The dashboard has no Kudos tracking or display. GAM-10 (Kudos Button & Award System) and GAM-11 (Kudos Count Display) are sandbox-only, not visible in the instructor dashboard. | **Medium** | All Paths — instructor cannot track Kudos | Add Kudos tracking columns to the team status table and a Kudos summary in the Gamification Panel. |
| **Boss Battle Display** | The dashboard has no Boss Battle status display. GAM-5/Boss Battle Mode Activation is not reflected in instructor analytics. | **Medium** | All Paths — boss battle is invisible to instructor | Add a "Boss Battle Status" indicator to the dashboard header (active/inactive with countdown). |
| **Integration with Sandbox** | The sandbox (`mock/index.html`) has the full gamification module (leaderboard, badges, Kudos, Boss Battle), but the instructor dashboard doesn't pull from or display this data. | **Medium** | All Paths — data silo between sandbox and dashboard | Add a "Sync with Sandbox" button to the dashboard that reads leaderboard data from the sandbox's sessionStorage (same origin). |

## 📂 Updated Files
- `instructor-dashboard.html`: Added "Gamification Panel" card with badge/Kudos summary table. Added "Boss Battle Status" header indicator. Added "Sync from Sandbox" button.

## 📐 Risk Assessment
- **Risk Score:** 3 × 4 = **12** → **High**
- **Probability:** Likely (3) — gamification rules are visible in the sandbox but not the dashboard, creating a significant gap.
- **Impact:** High — instructor cannot enforce or track gamification, which is a core workshop engagement mechanism.
