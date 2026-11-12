# 🔄 Review & Remediation: Cycle 121 — Ollama Integration: Missing Model Config

## 🎯 Objective
Address the missing local LLM model configuration in `opencode.json.template` — participants with no internet access have no fallback model defined.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Configuration** | `opencode.json.template` only defines two models (`qwen-sovereign`, `cloud-gpt4`). No local/offline model is configured, making it impossible for participants in offline environments to use AI at all. | High | All Paths — Participants without internet are locked out of AI entirely | Added `local-ollama` model entry to `opencode.json.template` with `llama3.2` as the default local model, pointing to `http://localhost:11434` |

## 📊 Risk Assessment

| Factor | Score |
|--------|-------|
| Probability | 3 (Possible — workshop venues may have unreliable Wi-Fi) |
| Impact | 4 (Specific paths broken for all offline participants) |
| **Risk Score** | **12 (High)** |

## 📂 Updated Files
- `opencode.json.template`: Added `local-ollama` model entry with URL, metadata (type: "local", cost: "$0"), and description.

## 🧪 Validation
- [ ] Workshop Stability Check: `python3 -m json.tool opencode.json.template` passes with no errors
- [ ] Instructor Script Consistency: AI Hub Setup section in comments references the new local model
- [ ] Version Alignment: Model registry version tagged as `v1.0` in `ai_hub_setup.model_registry_version`

## 🔧 R&R Rule Derivation
**Rule AI-MODEL-1 (Ollama Integration):** `opencode.json.template` MUST include a local-ollama model entry as a fallback for offline scenarios. The entry must specify: `url` (http://localhost:11434), `api_key` ("ollama"), `metadata.type` ("local"), and `metadata.cost_per_1k_tokens` ("$0"). A setup instruction comment must reference `brew install ollama` and `ollama pull llama3.2`.

## 📜 Feedback Reference
N/A — this is a proactive remediation based on infrastructure gap analysis.

## ✅ Action Items
1. [x] Add `local-ollama` model entry to `opencode.json.template`
2. [ ] Instructor trains participants on `ollama pull llama3.2` setup
3. [ ] Verify model is reachable: `curl http://localhost:11434/api/tags`
