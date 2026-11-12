# 🔄 Review & Remediation: Cycle 127 — Local Model Benchmarking: Missing Consistency Check

## 🎯 Objective
Create a benchmarking script to compare local model (Ollama/llama3.2) output against the cloud model (sovereign) for consistency, ensuring participants know the quality delta.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| **Tooling** | There is no mechanism to measure how closely the local model's output matches the cloud model's output. Without this, participants cannot know if their offline work is comparable in quality to online work. This is essential for the Model Drift Detection (Rule 12.2) concept applied to local vs. cloud models. | Medium | All Paths — No quality baseline for offline work | Created `docs/tools/benchmark-models.sh` — a simple bash script that runs a standardized prompt against both models and outputs a consistency comparison. |

## 📊 Risk Assessment

| Factor | Score |
|--------|-------|
| Probability | 2 (Unlikely — not many participants will run this script) |
| Impact | 3 (Moderate — helps instructors and advanced participants understand quality differences) |
| **Risk Score** | **6 (Medium)** |

## 📂 Updated Files
- `docs/tools/benchmark-models.sh`: Created new benchmarking script.

## 🧪 Validation
- [ ] Workshop Stability Check: Script is optional, not required for workshop operation
- [ ] Instructor Script Consistency: Script output can be used to calibrate instructor expectations for offline work
- [ ] Version Alignment: N/A — new file

## 🔧 R&R Rule Derivation
**Rule AI-BENCH-1 (Local vs. Cloud Consistency Benchmark):** A benchmarking script MUST exist that: (1) sends the same prompt to both the sovereign model and the local Ollama model, (2) captures both outputs, (3) performs a basic consistency check (structure, key terms, completeness), and (4) reports a similarity score. The script must be idempotent and safe (no side effects on workshop files). Location: `docs/tools/benchmark-models.sh`.

## 📜 Feedback Reference
N/A — proactive DX tooling addition.

## ✅ Action Items
1. [x] Create `docs/tools/benchmark-models.sh`
2. [ ] Run the script to verify it works with a live Ollama instance
3. [ ] Publish results in `docs/strategy/BENCHMARK-RESULTS.md`
