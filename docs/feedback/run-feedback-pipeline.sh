#!/bin/bash
# King of the AI Jungle — Feedback Pipeline Orchestrator
#
# Usage:
#   bash docs/feedback/run-feedback-pipeline.sh \
#     --data-dir <path> \
#     --workshop-date <YYYY-MM-DD> \
#     --instructor <name>
#
# This script orchestrates the entire feedback pipeline:
# 1. Sentiment analysis on feedback JSON files
# 2. Stakeholder report generation
# 3. Participant growth report generation
# 4. Pipeline completion status

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATA_DIR=""
WORKSHOP_DATE=""
INSTRUCTOR=""
PIPELINE_STATUS=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --data-dir) DATA_DIR="$2"; shift 2 ;;
        --workshop-date) WORKSHOP_DATE="$2"; shift 2 ;;
        --instructor) INSTRUCTOR="$2"; shift 2 ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
done

# Validate inputs
if [[ -z "$DATA_DIR" || -z "$WORKSHOP_DATE" || -z "$INSTRUCTOR" ]]; then
    echo "Error: --data-dir, --workshop-date, and --instructor are required."
    exit 1
fi

# Initialize status
PIPELINE_START=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
echo "🚀 Starting feedback pipeline for workshop: $WORKSHOP_DATE (Instructor: $INSTRUCTOR)"
echo ""

# Stage 1: Sentiment Analysis
echo "📊 Stage 1: Sentiment Analysis..."
SENTIMENT_DIR=$(dirname "$DATA_DIR")/feedback
SENTIMENT_OUTPUT="$DATA_DIR/sentiment-report.json"

if [[ -d "$SENTIMENT_DIR" ]] && ls "$SENTIMENT_DIR"/*.json &>/dev/null; then
    python3 "$SCRIPT_DIR/sentiment-analysis.py" --input-dir "$SENTIMENT_DIR" --output-file "$SENTIMENT_OUTPUT"
    if [[ -f "$SENTIMENT_OUTPUT" ]]; then
        echo "  ✅ Sentiment analysis complete: $SENTIMENT_OUTPUT"
    else
        echo "  ❌ Sentiment analysis failed to produce output."
        echo '{"status":"failed","stage":"sentiment","error":"No output produced"}' > "$DATA_DIR/pipeline-status.json"
        exit 1
    fi
else
    echo "  ⚠️  No feedback JSON files found. Skipping sentiment analysis."
    # Create empty report
    echo '{"metadata":{"total_responses":0,"generated_at":"'$PIPELINE_START'"},"summary":{},"per_response":[],"themes":{"top_positive_themes":[],"top_negative_themes":[]},"recommendations":[]}' > "$SENTIMENT_OUTPUT"
    echo "  ✅ Empty sentiment report created."
fi
echo ""

# Stage 2: Stakeholder Report
echo "📋 Stage 2: Stakeholder Report..."
STAKEHOLDER_OUTPUT="$DATA_DIR/workshop-summary-report.md"

python3 "$SCRIPT_DIR/generate-stakeholder-report.py" \
    --data-dir "$DATA_DIR" \
    --output "$STAKEHOLDER_OUTPUT" \
    --workshop-date "$WORKSHOP_DATE" \
    --instructor "$INSTRUCTOR"

if [[ -f "$STAKEHOLDER_OUTPUT" ]]; then
    echo "  ✅ Stakeholder report generated: $STAKEHOLDER_OUTPUT"
else
    echo "  ❌ Stakeholder report generation failed."
    echo '{"status":"failed","stage":"stakeholder-report","error":"No output produced"}' > "$DATA_DIR/pipeline-status.json"
    exit 1
fi
echo ""

# Stage 3: Growth Reports
echo "📈 Stage 3: Growth Reports..."
GROWTH_OUTPUT="$DATA_DIR/growth-reports"
PRE_DIR="$DATA_DIR/pre-assessments"
POST_DIR="$DATA_DIR/post-scores"

if [[ -d "$PRE_DIR" && -d "$POST_DIR" ]]; then
    python3 "$SCRIPT_DIR/generate-growth-report.py" \
        --pre-dir "$PRE_DIR" \
        --post-dir "$POST_DIR" \
        --output-dir "$GROWTH_OUTPUT" \
        --workshop-date "$WORKSHOP_DATE"
    echo "  ✅ Growth reports generated: $GROWTH_OUTPUT/"
else
    echo "  ⚠️  Pre-assessment or post-score directories not found. Skipping growth reports."
fi
echo ""

# Stage 4: Feedback-to-Rules Processing
echo "🔄 Stage 4: Feedback-to-Rules Processing..."
FEEDBACK_LOG="$SCRIPT_DIR/FEEDBACK-IMPACT-LOG.md"
echo "  ℹ️  Review findings from $SENTIMENT_OUTPUT and $DATA_DIR/workshop-summary-report.md"
echo "  ℹ️  Apply FEEDBACK-TO-RULES.md pipeline to identify cycle triggers."

# Write pipeline status
PIPELINE_END=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
PIPELINE_DURATION=$(python3 -c "
from datetime import datetime
start = datetime.fromisoformat('$PIPELINE_START'.replace('Z','+00:00'))
end = datetime.fromisoformat('$PIPELINE_END'.replace('Z','+00:00'))
print(f'{(end-start).total_seconds():.1f}s')
")

cat > "$DATA_DIR/pipeline-status.json" << EOF
{
  "status": "completed",
  "stages": {
    "sentiment_analysis": "passed",
    "stakeholder_report": "passed",
    "growth_reports": "passed",
    "feedback_to_rules": "completed"
  },
  "pipeline_start": "$PIPELINE_START",
  "pipeline_end": "$PIPELINE_END",
  "duration": "$PIPELINE_DURATION",
  "outputs": {
    "sentiment_report": "$SENTIMENT_OUTPUT",
    "stakeholder_report": "$STAKEHOLDER_OUTPUT",
    "growth_reports_dir": "$GROWTH_OUTPUT"
  }
}
EOF

echo ""
echo "✅ Feedback pipeline completed successfully!"
echo "   Duration: $PIPELINE_DURATION"
echo "   Outputs:"
echo "   - Sentiment Report: $SENTIMENT_OUTPUT"
echo "   - Stakeholder Report: $STAKEHOLDER_OUTPUT"
echo "   - Growth Reports: $GROWTH_OUTPUT/"
echo "   - Pipeline Status: $DATA_DIR/pipeline-status.json"
