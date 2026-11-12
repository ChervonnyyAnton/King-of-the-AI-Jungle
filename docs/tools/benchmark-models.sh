#!/bin/bash
# benchmark-models.sh — Local Model Consistency Benchmark
# 
# Compares output from the local Ollama model (llama3.2) against the 
# sovereign cloud model (qwen-3.6-35b-sovereign) using the same prompt.
#
# Usage: ./docs/tools/benchmark-models.sh
# Requires: ollama (running), sovereign model API access
#
# Exit codes:
#   0 — Benchmark completed successfully
#   1 — One or more model endpoints unreachable
#   2 — Benchmark prompt not provided

set -euo pipefail

# === Configuration ===
PROMPT="List 5 key risks of using AI to generate test cases for a web application. Format as a numbered list."
OLLAMA_URL="${OLLAMA_URL:-http://localhost:11434}"
OLLAMA_MODEL="${OLLAMA_MODEL:-llama3.2}"
SOVEREIGN_URL="${SOVEREIGN_URL:-}"
SOVEREIGN_KEY="${SOVEREIGN_KEY:-}"

# === Output Files ===
OUTPUT_FILE="docs/tools/benchmark-output-$(date +%Y%m%d-%H%M%S).txt"

echo "=== AI Model Consistency Benchmark ==="
echo "Date: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo "Prompt: $PROMPT"
echo "---"

# --- Local Ollama ---
echo ""
echo "→ Testing local model: $OLLAMA_MODEL at $OLLAMA_URL"
LOCAL_OUTPUT=""
if curl -sf "$OLLAMA_URL/api/tags" >/dev/null 2>&1; then
    LOCAL_OUTPUT=$(curl -sf "$OLLAMA_URL/api/generate" \
        -d "{\"model\": \"$OLLAMA_MODEL\", \"prompt\": \"$PROMPT\", \"stream\": false}" 2>/dev/null | \
        python3 -c "import sys, json; print(json.load(sys.stdin).get('response', ''))" 2>/dev/null || echo "ERROR: Ollama returned empty or malformed response")
    echo "[Local Model] Output:"
    echo "$LOCAL_OUTPUT" | head -20
else
    echo "[Local Model] ⚠️ UNREACHABLE — Ollama not running at $OLLAMA_URL"
    LOCAL_OUTPUT="UNREACHABLE"
fi

# --- Sovereign Cloud ---
echo ""
echo "→ Testing sovereign model at $SOVEREIGN_URL"
SOVEREIGN_OUTPUT=""
if [ -n "$SOVEREIGN_URL" ] && [ -n "$SOVEREIGN_KEY" ]; then
    SOVEREIGN_OUTPUT=$(curl -sf -X POST "$SOVEREIGN_URL/v1/chat/completions" \
        -H "Authorization: Bearer $SOVEREIGN_KEY" \
        -H "Content-Type: application/json" \
        -d "{\"model\": \"qwen-3.6-35b-sovereign\", \"messages\": [{\"role\": \"user\", \"content\": \"$PROMPT\"}], \"max_tokens\": 1024}" 2>/dev/null | \
        python3 -c "import sys, json; print(json.load(sys.stdin)['choices'][0]['message']['content'])" 2>/dev/null || echo "ERROR: Sovereign API returned empty or malformed response")
    echo "[Sovereign Model] Output:"
    echo "$SOVEREIGN_OUTPUT" | head -20
else
    echo "[Sovereign Model] ⚠️ SKIPPED — SOVEREIGN_URL or SOVEREIGN_KEY not set"
    SOVEREIGN_OUTPUT="SKIPPED"
fi

# --- Consistency Check ---
echo ""
echo "=== Consistency Analysis ==="
if [ "$LOCAL_OUTPUT" = "UNREACHABLE" ] && [ "$SOVEREIGN_OUTPUT" = "SKIPPED" ]; then
    echo "⚠️ Both models unreachable or skipped. No comparison possible."
    exit 1
fi

if [ "$LOCAL_OUTPUT" != "UNREACHABLE" ] && [ "$SOVEREIGN_OUTPUT" != "SKIPPED" ]; then
    # Simple structural comparison: count list items, keywords, and length
    LOCAL_ITEMS=$(echo "$LOCAL_OUTPUT" | grep -cE '^\d+\.?' || echo "0")
    SOV_ITEMS=$(echo "$SOVEREIGN_OUTPUT" | grep -cE '^\d+\.?' || echo "0")
    LOCAL_CHARS=${#LOCAL_OUTPUT}
    SOV_CHARS=${#SOVEREIGN_OUTPUT}
    
    echo "Local Model: $LOCAL_CHARS chars, $LOCAL_ITEMS list items"
    echo "Sovereign:   $SOV_CHARS chars, $SOV_ITEMS list items"
    
    # Similarity heuristic: item count match + length ratio
    if [ "$LOCAL_ITEMS" -ge 3 ] && [ "$SOV_ITEMS" -ge 3 ]; then
        if [ "$LOCAL_ITEMS" -eq "$SOV_ITEMS" ]; then
            SIMILARITY="HIGH (same number of items)"
        else
            SIMILARITY="MEDIUM (different number of items: $LOCAL_ITEMS vs $SOV_ITEMS)"
        fi
    else
        SIMILARITY="LOW (insufficient structured output from one or both models)"
    fi
    
    echo "Similarity: $SIMILARITY"
    echo ""
    echo "=== Scoring Thresholds (from BENCHMARK-GUIDE.md) ==="
    echo "  ≥80% = Offline work acceptable"
    echo "  50–79% = Review and refine"
    echo "  <50% = Redo with online model"
else
    echo "⚠️ Cannot compare: one model is unavailable."
    echo "  Run this benchmark with both models reachable for a full consistency check."
fi

# Save to file
echo "" >> "$OUTPUT_FILE"
echo "=== Benchmark Results ===" >> "$OUTPUT_FILE"
echo "Date: $(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$OUTPUT_FILE"
echo "Prompt: $PROMPT" >> "$OUTPUT_FILE"
echo "---" >> "$OUTPUT_FILE"
echo "[Local Model] $OLLAMA_MODEL" >> "$OUTPUT_FILE"
echo "$LOCAL_OUTPUT" >> "$OUTPUT_FILE"
echo "---" >> "$OUTPUT_FILE"
echo "[Sovereign Model]" >> "$OUTPUT_FILE"
echo "$SOVEREIGN_OUTPUT" >> "$OUTPUT_FILE"

echo ""
echo "Results saved to: $OUTPUT_FILE"
exit 0
