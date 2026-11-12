# 📊 Benchmark Guide: Local vs. Cloud Model Consistency

## Purpose
This guide explains how to interpret the output of `benchmark-models.sh` and how to decide whether offline (local Ollama) output is acceptable for workshop tasks.

## Scoring Scale

The benchmark produces a **Consistency Score** based on structural comparison between the local model (Ollama/llama3.2) and the sovereign cloud model (qwen-3.6-35b-sovereign).

| Score Range | Consistency Level | Action |
|-------------|-------------------|--------|
| **80–100%** | HIGH | Offline work is acceptable. Proceed with local model. |
| **50–79%** | MEDIUM | Review and refine. Consider re-running with a more specific prompt. |
| **<50%** | LOW | Redo with online model. Offline output quality is insufficient. |

## How the Score is Calculated

The benchmark performs two checks:

### 1. Structural Check (Item Count)
Both outputs are parsed for numbered list items. If both models produce ≥3 items and the counts match → **HIGH** structural consistency. If counts differ → **MEDIUM**. If either model produces <3 items → **LOW**.

### 2. Content Check (Keyword Overlap) — Optional
For more detailed analysis, participants can compare keyword overlap:
```bash
# Extract unique words from each output (case-insensitive)
LOCAL_KEYWORDS=$(echo "$LOCAL_OUTPUT" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z\n' '\n' | sort -u)
SOV_KEYWORDS=$(echo "$SOVEREIGN_OUTPUT" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z\n' '\n' | sort -u)

# Calculate Jaccard similarity
OVERLAP=$(comm -12 <(echo "$LOCAL_KEYWORDS") <(echo "$SOV_KEYWORDS") | wc -l)
UNION=$(echo -e "$LOCAL_KEYWORDS\n$SOV_KEYWORDS" | sort -u | wc -l)
SIMILARITY=$((OVERLAP * 100 / UNION))
echo "Keyword similarity: ${SIMILARITY}%"
```

## What Differences Are Acceptable?

| Type of Difference | Acceptable Offline? |
|--------------------|---------------------|
| Different examples used | ✅ Yes — examples vary naturally |
| Different wording but same concepts | ✅ Yes — semantic equivalence is sufficient |
| Missing a category/point | ⚠️ Review — was it intentionally omitted? |
| Completely different topics | ❌ No — local model hallucinated or misunderstood |
| Missing structured format | ❌ No — local model ignored output format instruction |

## When to Use Benchmarks

| Time | Should You Benchmark? |
|------|-----------------------|
| **Workshop Setup** (before tasks begin) | ✅ YES — establish quality baseline |
| **During a time-boxed task** | ❌ NO — benchmarks consume workshop time |
| **After a workshop session** | ✅ YES — compare offline work quality |
| **When trying a new local model** | ✅ YES — e.g., `llama3.1` vs `llama3.2` |

## Common Local Model Limitations

| Limitation | Impact | Mitigation |
|------------|--------|------------|
| Smaller context window (8K vs 32K+) | May truncate long outputs | Use explicit output length limits in prompts |
| Less nuanced reasoning | May miss subtle risk factors | Add "Think about: [specific angle]" to prompt |
| No web search capability | Cannot reference current events | Pre-populate context in the prompt |
| Slower inference | Longer wait times | Use simpler prompts with shorter outputs |
| Format inconsistency | May not follow strict YAML/JSON | Use explicit format instructions: "Output EXACTLY this format: ..." |

## Example Benchmark Output

```
=== AI Model Consistency Benchmark ===
Date: 2025-06-20T10:30:00Z
Prompt: List 5 key risks of using AI to generate test cases for a web application.
---
[Local Model] llama3.2 at http://localhost:11434
1. Hallucination — AI may invent non-existent bugs...
2. Bias — AI may focus on common patterns only...
3. Incompleteness — AI may miss edge cases...
4. Over-reliance — Teams may stop manual testing...
5. Cost — Cloud API costs can exceed manual effort...

[Sovereign Model] at https://api.example.com
1. AI-generated tests may contain hallucinated assertions...
2. Coverage gaps — AI may not test all paths...
3. Maintenance burden — AI tests may be hard to maintain...
4. Security risks — AI may generate insecure test data...
5. Skill erosion — Team may lose manual testing skills...

=== Consistency Analysis ===
Local Model: 387 chars, 5 list items
Sovereign:   412 chars, 5 list items
Similarity: HIGH (same number of items)
```

---

*This guide is maintained by the R&R process. Last updated: Cycles 127–128.*
