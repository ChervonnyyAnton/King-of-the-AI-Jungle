# 🔄 Review & Remediation: Cycle 122 — Ollama Integration: Model Registry Documentation

## 🎯 Objective
Add model registry documentation to `opencode.json.template` so participants understand all available models, their costs, and their roles in the fallback chain.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Documentation** | Participants see three models in `opencode.json.template` but have no documentation explaining which model to use when. There is no model selection guide, no cost comparison, and no fallback priority list. | Medium | All Paths — Participants waste tokens choosing the wrong model | Added `ai_hub_setup.model_registry_version` and `ai_hub_setup.available_models` array documenting each model's type, cost, and role. Added `ai_hub_setup.setup_instructions` with prerequisite, verify, and usage steps. |

## 📊 Risk Assessment

| Factor | Score |
|--------|-------|
| Probability | 3 (Possible — participants may try cloud model out of curiosity) |
| Impact | 3 (Budget drain from incorrect model selection) |
| **Risk Score** | **9 (Medium)** |

## 📂 Updated Files
- `opencode.json.template`: Added `ai_hub_setup` object with model registry (version, available_models array, setup_instructions).

## 🧪 Validation
- [ ] Workshop Stability Check: JSON remains valid (`python3 -m json.tool`)
- [ ] Instructor Script Consistency: Model registry info can be directly copied into `INSTRUCTOR-QUICK-REF.md` Model Selection guide
- [ ] Version Alignment: `model_registry_version` set to `"v1.0"`

## 🔧 R&R Rule Derivation
**Rule AI-MODEL-2 (Model Registry):** `opencode.json.template` MUST include an `ai_hub_setup` configuration block with: (1) `model_registry_version` (semantic version string), (2) `available_models` (array of objects with `name`, `type`, `cost`, `role`), and (3) `setup_instructions` (object with `prerequisite`, `verify`, `usage`). This ensures participants understand model selection without guessing.

## 📜 Feedback Reference
N/A — proactive remediation based on DX feedback pattern from earlier cycles (DXS-5).

## ✅ Action Items
1. [x] Add model registry block to `opencode.json.template`
2. [ ] Update `VS-CODE-AI-HUB-SETUP.md` to reference the model registry
3. [ ] Add model selection guide to `INSTRUCTOR-QUICK-REF.md`
