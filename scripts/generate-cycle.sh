#!/usr/bin/env bash
# generate-cycle.sh — Auto-generate R&R cycle log boilerplate
# Usage: ./scripts/generate-cycle.sh <cycle-number> [domain]
# Example: ./scripts/generate-cycle.sh 191 "Technical"
# Outputs to: docs/project/REVIEW-CYCLE-NN.md

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CYCLE_DIR="$PROJECT_DIR/docs/project"

CYCLE_NUM="${1:?Usage: generate-cycle.sh <cycle-number> [domain]}"
DOMAIN="${2:-General}"
DATE=$(date '+%Y-%m-%d')

# Validate cycle number
if ! [[ "$CYCLE_NUM" =~ ^[0-9]+$ ]]; then
    echo "Error: cycle number must be a positive integer"
    exit 1
fi

OUTPUT="$CYCLE_DIR/REVIEW-CYCLE-${CYCLE_NUM}.md"
if [[ -f "$OUTPUT" ]]; then
    echo "Error: $OUTPUT already exists. Remove it first."
    exit 1
fi

# Domain-to-emoji mapping
declare -A DOMAIN_EMOJIS=(
    [Pedagogy]="🎓"
    [Technical]="🔧"
    [Documentation]="📄"
    [Security]="🛡️"
    [Security and Budget]="💰"
    ["UX/Visual"]="🎨"
    [Instructor Delivery]="👨‍🏫"
    [Developer Experience]="🧑‍💻"
    [Agentic AI]="🤖"
    [Meta-Enhancement]="🔄"
    [General]="📋"
)

EMOJI="${DOMAIN_EMOJIS[$DOMAIN]:-📋}"

cat > "$OUTPUT" << EOF
# 🔄 Review & Remediation: Cycle $CYCLE_NUM

## 🎯 Objective
Review and remediation cycle focused on the **$DOMAIN** domain.

## 📋 Findings & Remediation

| Area | Finding | Severity | 2-Axis Impact | Remediation |
|------|---------|----------|---------------|-------------|
| [Domain] | [What was found during inspection] | [Critical/High/Medium/Low] | [Jungle Title: Benefit] | [What was changed] |

## 📂 Updated Files
- `[path]`: [Brief description of change]

## 📐 Risk Assessment
- **Risk Score:** [P] × [I] = [Score] → **[Risk Level]**
- **Probability:** [1-5: Unlikely/Possible/Likely/Certain]
- **Impact:** [1-5: Minor/Moderate/Significant/Critical]

## 🔄 R&R Rule Derivation
> [New or updated rule derived from this cycle, if applicable]

## 📝 Action Items
1. [ ] [Action item 1]
2. [ ] [Action item 2]
3. [ ] [Action item 3]

## 🧪 Validation
- [ ] Workshop Stability Check
- [ ] Instructor Script Consistency
- [ ] Version Alignment
- [ ] 2-Axis Alignment Verified
EOF

echo "✅ Cycle log generated: $OUTPUT"
echo "   Domain: $DOMAIN"
echo "   Date: $DATE"
echo ""
echo "Next steps:"
echo "  1. Fill in the findings table"
echo "  2. Apply remediations"
echo "  3. Update the Change Log in R&R-CYCLE-RULES.md"
echo "  4. Run ./scripts/validate-rules.sh to verify"
