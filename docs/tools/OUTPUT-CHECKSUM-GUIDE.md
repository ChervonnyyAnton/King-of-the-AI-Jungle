# 📊 Output Checksum & Diff Guide

> Reference: REVIEW-CYCLE-66.md | Rule DXS-4

This guide describes how to detect and handle non-determinism in AI-generated outputs across agent runs.

## 🎯 Goal

When an AI agent modifies a project artifact (e.g., `TEST-PLAN.md`, `RISK-ANALYSIS.md`), verify whether the changes are meaningful or spurious drift caused by LLM non-determinism.

## 🔧 Method 1: SHA-256 Checksum (Fast Pre-Filter)

### Before Modification

```bash
# Compute checksum of the original artifact
sha256sum TEST-PLAN.md > TEST-PLAN.md.checksum
echo "Pre-change checksum: $(cat TEST-PLAN.md.checksum)"
```

### After Modification

```bash
# Compute checksum of the modified artifact
sha256sum TEST-PLAN.md > TEST-PLAN.md.new-checksum

# Compare
diff TEST-PLAN.md.checksum TEST-PLAN.md.new-checksum

# If checksums differ, the file changed
if ! diff -q TEST-PLAN.md.checksum TEST-PLAN.md.new-checksum >/dev/null 2>&1; then
  echo "⚠️ Artifact changed — reviewing diff..."
  git diff --no-index TEST-PLAN.md.checksum TEST-PLAN.md.new-checksum || true
fi
```

### Checksum Files

- Store checksums alongside artifacts: `TEST-PLAN.md.checksum`
- Add `.checksum` files to `.gitignore` (they are transient, not source artifacts).
- In CI pipelines, checksums are computed on-the-fly and discarded after the run.

## 🔧 Method 2: Diff Comparison (Detailed Analysis)

```bash
# After agent modifies the artifact:
git diff TEST-PLAN.md

# Or, if not using git:
diff -u TEST-PLAN.md.bak TEST-PLAN.md

# Count changed lines
diff TEST-PLAN.md.bak TEST-PLAN.md | grep -c '^[<>]'
total_lines=$(wc -l < TEST-PLAN.md.bak)
changed_lines=$(diff TEST-PLAN.md.bak TEST-PLAN.md | grep -c '^[<>]')
echo "Change ratio: $(echo "scale=2; $changed_lines / $total_lines * 100" | bc)%"
```

### Drift Threshold

- **≤20% change**: Likely intentional modification.
- **>20% change without explicit instruction**: Potential drift — flag and investigate.
- **0% change**: No modification — verify the agent did not silently fail.

## 🔧 Method 3: Checksum Utility in mock/index.html

The `computeChecksum()` function (added in Cycle 65) provides a deterministic JavaScript-based checksum:

```javascript
// Usage: verify DEFAULTS haven't drifted
const seed = computeChecksum(DEFAULTS);
console.log("Current seed:", seed);

// Compare against expected seed
const EXPECTED_SEED = "seed-a1b2c3d4";
if (seed !== EXPECTED_SEED) {
    console.error("⚠️ DEFAULTS have drifted from expected seed!");
    showToast("Seed mismatch — using potentially modified defaults", "warning");
}
```

## 📋 Workflow Summary

| Step | Action | Command |
|------|--------|---------|
| 1. Record | Compute pre-change checksum | `sha256sum <file> > <file>.checksum` |
| 2. Modify | Let agent work on the artifact | (agent action) |
| 3. Compare | Compute and compare checksums | `diff <file>.checksum <file>.new-checksum` |
| 4. Analyze | If changed, review diff | `git diff <file>` or `diff -u` |
| 5. Report | Document in cycle log | "Checksum changed from X to Y; diff: ..." |

## ⚠️ Limitations

1. **SHA-256 is order-dependent**: Whitespace changes produce different checksums even if the semantic content is the same.
2. **Not a correctness check**: A checksum verifies *that* something changed, not *whether* the change is correct.
3. **LLM non-determinism is inherent**: Even with the same prompt, outputs may differ. Use checksums to detect changes, not to prevent them.

## 📚 References

- Cycle 65: Reproducibility (SEED_VERSION in DEFAULTS)
- Cycle 66: Non-Deterministic Outputs (this guide)
- AGENTS.md: Seed Values & Non-Determinism Handling section
- `mock/index.html`: `computeChecksum()` function

---

*Deterministic outputs are an ideal; checksums help us measure our distance from it.*
