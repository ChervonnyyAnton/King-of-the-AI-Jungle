#!/usr/bin/env bash
# validate-rules.sh — R&R Rules Validation Script
# Parses rr-schema.json and checks R&R-CYCLE-RULES.md for compliance.
# Run from the repository root:
#   ./scripts/validate-rules.sh
# Exit codes: 0 = PASS, 1 = FAIL (one or more violations found)
# Compatible with macOS (uses grep -E instead of grep -P)

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
RULES_FILE="$PROJECT_DIR/docs/project/R&R-CYCLE-RULES.md"
SCHEMA_FILE="$PROJECT_DIR/docs/project/rr-schema.json"
CYCLE_DIR="$PROJECT_DIR/docs/project"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

PASS=0
FAIL=0
WARN=0

pass() {
    echo -e "${GREEN}✅ PASS${NC}: $1"
    PASS=$((PASS+1))
}

fail() {
    echo -e "${RED}❌ FAIL${NC}: $1"
    FAIL=$((FAIL+1))
}

warn() {
    echo -e "${YELLOW}⚠️  WARN${NC}: $1"
    WARN=$((WARN+1))
}

echo "═══════════════════════════════════════════════════════"
echo "  R&R Rules Validator — $(date '+%Y-%m-%d %H:%M:%S')"
echo "═══════════════════════════════════════════════════════"
echo ""

# ─── Check 1: Schema File Exists ──────────────────────
echo "📋 Check 1: Schema validation"
if [[ -f "$SCHEMA_FILE" ]]; then
    pass "rr-schema.json exists"
    if command -v python3 &>/dev/null; then
        if python3 -c "import json,sys; json.load(open(sys.argv[1]))" "$SCHEMA_FILE" 2>/dev/null; then
            pass "rr-schema.json is valid JSON"
        else
            fail "rr-schema.json is not valid JSON"
        fi
    else
        warn "python3 not available — skipping JSON validation"
    fi
else
    fail "rr-schema.json not found at $SCHEMA_FILE"
fi

# ─── Check 2: Rules File Exists & Under 3000 Lines ────
echo ""
echo "📋 Check 2: Document health"
if [[ -f "$RULES_FILE" ]]; then
    LINES=$(wc -l < "$RULES_FILE" | tr -d ' ')
    if (( LINES <= 3000 )); then
        pass "R&R-CYCLE-RULES.md is $LINES lines (<=3000)"
    else
        fail "R&R-CYCLE-RULES.md is $LINES lines (exceeds 3000-line limit)"
    fi
else
    fail "R&R-CYCLE-RULES.md not found at $RULES_FILE"
    exit 1
fi

# ─── Check 3: Section Continuity (CR-1) ──────────────
echo ""
echo "📋 Check 3: Section numbering continuity"
# Extract section numbers from ## headers with emoji prefix and trailing dot
SECTIONS=$(grep -E '^## ' "$RULES_FILE" | grep -oE '[0-9]+[.]' | sed 's/\.$//' | sort -n | uniq)
EXPECTED=1
CONTINUOUS=true
for S in $SECTIONS; do
    if (( S != EXPECTED )); then
        fail "Section gap: expected $EXPECTED, found $S"
        CONTINUOUS=false
    fi
    EXPECTED=$((EXPECTED+1))
done
if $CONTINUOUS; then
    pass "All section numbers are continuous (no gaps)"
fi

# ─── Check 4: Last Verified Annotations ──────────────
echo ""
echo "📋 Check 4: Last Verified annotations"
SECTION_HEADERS=$(grep -E '^## .*[0-9]+\.' "$RULES_FILE")
TOTAL_SECTIONS=$(echo "$SECTION_HEADERS" | wc -l | tr -d ' ')
VERIFIED_SECTIONS=$(echo "$SECTION_HEADERS" | grep -ci 'Last Verified' || true)
if (( VERIFIED_SECTIONS == TOTAL_SECTIONS )); then
    pass "All $TOTAL_SECTIONS sections have Last Verified annotations"
elif (( VERIFIED_SECTIONS > 0 )); then
    WARN_SECTIONS=$(( TOTAL_SECTIONS - VERIFIED_SECTIONS ))
    warn "$WARN_SECTIONS sections missing Last Verified annotations"
else
    fail "No sections have Last Verified annotations"
fi

# ─── Check 5: Cycle Log Traceability (CR-3) ──────────
echo ""
echo "📋 Check 5: Cycle log traceability"
# Extract single cycle references (not ranges like "Cycles 73-76")
CYCLES_IN_RULES=$(grep -oE 'Cycle [0-9]+' "$RULES_FILE" | grep -v '^Cycles ' | sort -u || true)
if [[ -n "$CYCLES_IN_RULES" ]]; then
    for CYCLE_REF in $CYCLES_IN_RULES; do
        # Skip empty entries
        [[ -z "$CYCLE_REF" ]] && continue
        NUM=${CYCLE_REF#Cycle }
        [[ -z "$NUM" ]] && continue
        # Check if the file exists (skip special cycles > 1000)
        if [[ "$NUM" =~ ^[0-9]+$ ]] && (( NUM >= 1 && NUM < 1000 )); then
            FOUND=false
            for F in "$CYCLE_DIR"/REVIEW-CYCLE-*.md; do
                BASENAME=$(basename "$F")
                if [[ "$BASENAME" == "REVIEW-CYCLE-$NUM.md" ]]; then
                    FOUND=true
                    break
                fi
            done
            if $FOUND; then
                pass "Cycle $NUM log exists"
            else
                warn "Cycle $NUM referenced but log not found"
            fi
        fi
    done
else
    pass "No cycle references found (document may be empty)"
fi

# ─── Check 6: Rule Code References ──────────────────
echo ""
echo "📋 Check 6: Rule code validation"
# Extract rule codes using grep -oE (POSIX extended regex)
RULE_CODE_COUNT=$(grep -oE '(FRS|RLB|USB|SEC|PEF|ID|PW|DXS|ONS|SC|CR|EC|CB|ER|SA|PFT|RR)-[0-9]+' "$RULES_FILE" 2>/dev/null | sort -u | wc -l | tr -d ' ')
pass "Found $RULE_CODE_COUNT unique rule codes"

# ─── Check 7: Severity Consistency ──────────────────
echo ""
echo "📋 Check 7: Severity level validation"
for SEV in "Critical" "High" "Medium" "Low"; do
    COUNT=$(grep -c "$SEV" "$RULES_FILE" || true)
    echo "   Severity '$SEV' referenced: $COUNT times"
done

# ─── Check 8: 2-Axis Alignment ──────────────────────
echo ""
echo "📋 Check 8: 2-Axis Alignment references"
ALIGNMENT_REFS=$(grep -cE "Jungle Title|2-Axis|helps.*by" "$RULES_FILE" || true)
if (( ALIGNMENT_REFS > 0 )); then
    pass "2-Axis Alignment referenced $ALIGNMENT_REFS times"
else
    warn "No explicit 2-Axis Alignment references found"
fi

# ─── Check 9: Formula Non-Duplication (CR-2) ────────
echo ""
echo "📋 Check 9: Formula non-duplication"
# Count lines with the formula definition pattern (Coverage = ...) not just the term
COVERAGE_COUNT=$(grep -c "Coverage (%) = (" "$RULES_FILE" || true)
if (( COVERAGE_COUNT <= 1 )); then
    pass "Coverage formula defined in exactly one location"
else
    fail "Coverage formula duplicated $COVERAGE_COUNT times — should be 1"
fi

TRACE_FWD=$(grep -c "Forward Traceability (%) = (" "$RULES_FILE" || true)
if (( TRACE_FWD <= 1 )); then
    pass "Forward traceability formula defined in exactly one location"
else
    fail "Forward traceability formula duplicated $TRACE_FWD times — should be 1"
fi

# ─── Check 10: Change Log ────────────────────────────
echo ""
echo "📋 Check 10: Change Log maintenance"
if grep -qE "Change Log|Version.*Date.*Change" "$RULES_FILE"; then
    CHANGE_ENTRIES=$(grep -cE '^\| v[0-9]+\.' "$RULES_FILE" || true)
    if (( CHANGE_ENTRIES >= 1 )); then
        pass "Change Log has $CHANGE_ENTRIES entries"
    else
        warn "Change Log header found but no version entries"
    fi
else
    warn "No Change Log table found"
fi

# ─── Summary ─────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════════════════"
echo "  Results: ${GREEN}${PASS} PASS${NC} | ${RED}${FAIL} FAIL${NC} | ${YELLOW}${WARN} WARN${NC}"
echo "═══════════════════════════════════════════════════════"

if (( FAIL > 0 )); then
    exit 1
fi
exit 0
