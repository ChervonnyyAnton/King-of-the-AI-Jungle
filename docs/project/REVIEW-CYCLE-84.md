# 🔄 Review & Remediation: Cycle 84

## 🎯 Objective
Test "Error Recovery" behavior in `mock/index.html` — specifically, what happens when the user closes the tab mid-import, reloads the page with unsaved configuration, or cancels the file picker — and ensure the setup checklist (`setup-checklist.sh`) or `VS-CODE-AI-HUB-SETUP.md` fully automates environment setup.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Error Recovery** | `mock/index.html` has no session persistence. If a user: (1) modifies the header/body/footer and closes the tab mid-config, (2) clicks "Import JSON" then closes the tab before the file picker completes, (3) refreshes the page — all configuration is lost with no warning or recovery option. The `simulateError()` button only shows a simulated toast; there is no real error recovery flow. The app uses no `localStorage` (intentionally, per DXS-1 sandbox isolation). However, "no persistence" is not the same as "no recovery" — a brief `sessionStorage` backup that restores on page load would provide resilience without violating sandbox isolation (sessionStorage is per-tab, not cross-tab, and is cleared on tab close). No test case exists for this recovery scenario. | **Medium** | **All Paths:** Every participant will inevitably close tabs or refresh pages. Lost configuration causes frustration and wastes token budget on re-entry. **Scouts (A-C):** Manual paths are most affected — they re-type all configuration. | Added **Rule ER-1** to Section 16 of `R&R-CYCLE-RULES.md`: The app must recover from tab closure and page reload by restoring the last-known configuration via `sessionStorage`. On page load (before `initDebug` and `updatePreview`), the app checks `sessionStorage` for a saved config blob. If present, it restores all fields (header, body, footer, layout, gridEnabled, gridData) and shows a recovery toast: "Configuration restored from previous session." The `sessionStorage` key must be `sandbox-config`. The backup must be debounced (write every 1 second) to avoid performance impact. On explicit "Reset Configuration" click, the `sessionStorage` entry is cleared. |
| **Setup Automation** | `VS-CODE-AI-HUB-SETUP.md` covers setup steps manually (opencode.json config, connectivity check, token reference, model routing). `setup-checklist.sh` exists as a verification script but is a *checklist* — it verifies prerequisites but does not *automate* the setup itself. There is no `setup-complete.sh` that creates `.vscode/opencode.json` from the template, replaces placeholders, and verifies the result. The setup flow relies on participants manually editing JSON files, which introduces errors (trailing spaces, wrong keys, missing values). | **Medium** | **All Paths:** Every participant must complete Day-0 setup. If the setup is error-prone, participants waste time troubleshooting instead of learning. | Added **Rule SA-1** to Section 16 of `R&R-CYCLE-RULES.md`: The `VS-CODE-AI-HUB-SETUP.md` must reference a complete setup automation script (`setup-complete.sh`) that: (1) reads `opencode.json.template`, (2) prompts for `{YOUR_SOVEREIGN_KEY}`, `{SOVEREIGN_URL}`, `{YOUR_CLOUD_KEY}`, `{CLOUD_URL}`, (3) writes `.vscode/opencode.json` with placeholders replaced, (4) runs `setup-checklist.sh` to verify, (5) outputs a setup summary. The script must be idempotent — running it multiple times must not break the configuration. If setup automation is not available, `VS-CODE-AI-HUB-SETUP.md` must include step-by-step copy-paste instructions for each placeholder replacement. |

## 📂 Updated Files
- **`docs/project/R&R-CYCLE-RULES.md`**: Added Section 16 with Rule ER-1 (Error Recovery) and Rule SA-1 (Setup Automation).
- **No changes to `mock/index.html`**: The sandbox isolation rule (DXS-1) intentionally prohibits `localStorage`. `sessionStorage` is per-tab and acceptable. The rule defines the *verification requirement*.
- **No changes to `setup-checklist.sh`**: It exists as a checklist; a full automation script would be a new file created in a future cycle.

## 📐 Risk Assessment
- **Error Recovery Risk Score:** 3 × 3 = **9** → **Medium**
- **Setup Automation Risk Score:** 3 × 3 = **9** → **Medium**
- **Probability:** Likely (3) — Participants will close tabs, refresh, and make setup errors.
- **Impact:** Lost configuration wastes time and token budget; setup errors delay workshop start.

## 🔄 R&R Rule Derivation
This cycle produced **Rule ER-1** and **Rule SA-1** in Section 16 of `R&R-CYCLE-RULES.md`:
> **Rule ER-1 — Error Recovery:** The app must recover configuration after tab closure or page reload using `sessionStorage` (key: `sandbox-config`). On load, restore all fields and show a recovery toast. Debounce writes to every 1s. Clear on "Reset Configuration."
>
> **Rule SA-1 — Setup Automation:** `VS-CODE-AI-HUB-SETUP.md` must reference a complete setup automation script (`setup-complete.sh`) that reads the template, replaces placeholders, writes `.vscode/opencode.json`, runs `setup-checklist.sh`, and outputs a setup summary. The script must be idempotent.

## 🧪 Validation Checklist (Per Section 3 Quality Gates)
- [ ] **2-Axis Alignment:** Supports all Jungle Titles (setup and recovery affect every participant).
- [ ] **Workshop Stability:** No code changes; defines verification rules.
- [ ] **Risk Assessment Gate:** Both risks scored at 9 (Medium); documented with mitigations.
- [ ] **PIR:** Will be validated during first workshop — track how many participants lose config or encounter setup errors.

## 📝 Action Items
1. [ ] Add `sessionStorage` backup/restore to `mock/index.html` (deferred — requires code change, plan for next cycle).
2. [ ] Create `setup-complete.sh` that automates `.vscode/opencode.json` creation from template (deferred — plan for next cycle).
3. [ ] Add error recovery tests to `TEST-PLAN.md`.
4. [ ] Test tab-close recovery: modify config → close tab → reopen → verify recovery toast appears.
5. [ ] Test idempotency: run `setup-complete.sh` twice → verify `.vscode/opencode.json` is valid both times.
