#!/usr/bin/env bash
#
# cleanup-test-data.sh — Test Data Lifecycle Cleanup Script
# Removes synthetic test data files older than 30 days from designated directories.
#
# Usage:
#   scripts/cleanup-test-data.sh [--dry-run] [--days <N>]
#
# Examples:
#   scripts/cleanup-test-data.sh --dry-run
#   scripts/cleanup-test-data.sh --days 14
#   scripts/cleanup-test-data.sh --in-place

set -euo pipefail

# Defaults
DRY_RUN=true
DAYS=30
IN_PLACE=false

# Directories containing test data (not workshop artifacts)
TEST_DATA_DIRS=(
  "docs/requirements/MOCK-API/temp"
  "tests/fixtures"
  "docs/tools/temp-data"
)

# Files to EXCLUDE from cleanup (workshop artifacts, not exercise data)
EXCLUDE_PATTERNS=(
  "docs/requirements/MOCK-API/README.md"
  "docs/requirements/MOCK-API/customer-list.json"
  "docs/requirements/MOCK-API/config-export.json"
  "docs/requirements/MOCK-API/grid-data.json"
  "docs/requirements/MOCK-API/error-responses.json"
  "docs/requirements/MOCK-API/health-check.json"
)

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --in-place)
      IN_PLACE=true
      DRY_RUN=false
      shift
      ;;
    --days|-d)
      DAYS="$2"
      shift 2
      ;;
    --help|-h)
      head -20 "$0" | grep "^#" | sed 's/^# \?//'
      exit 0
      ;;
    *)
      echo -e "${RED}Error: Unknown argument '$1'. Use --help for usage.${NC}" >&2
      exit 1
      ;;
  esac
done

echo -e "${CYAN}================================================${NC}"
echo -e "${CYAN}  Test Data Cleanup Tool v2.0.0${NC}"
echo -e "${CYAN}  Mode: $(if $DRY_RUN; then echo 'Dry Run'; else echo 'In-Place'; fi)${NC}"
echo -e "${CYAN}  Retention period: $DAYS days${NC}"
echo -e "${CYAN}================================================${NC}"
echo ""

# Build exclude list for find
EXCLUDE_ARGS=()
for pattern in "${EXCLUDE_PATTERNS[@]}"; do
  EXCLUDE_ARGS+=("-not" "-path" "$pattern")
done

# Find and report stale files
STALE_COUNT=0
STALE_FILES=()

for dir in "${TEST_DATA_DIRS[@]}"; do
  if [[ ! -d "$dir" ]]; then
    continue
  fi

  echo -e "${CYAN}Scanning: $dir${NC}"

  # Find files older than $DAYS days, excluding workshop artifacts
  while IFS= read -r -d '' file; do
    STALE_FILES+=("$file")
    STALE_COUNT=$((STALE_COUNT + 1))

    if [[ "$DRY_RUN" == true ]]; then
      echo -e "  ${YELLOW}[STALE]${NC} $file ($(stat -f '%Sm' -t '%Y-%m-%d' "$file" 2>/dev/null || echo 'unknown')"
    else
      echo -e "  ${RED}[REMOVING]${NC} $file"
    fi
  done < <(find "$dir" -type f \( -name "*.json" -o -name "*.csv" -o -name "*.txt" -o -name "*.md" \) -mtime +"$DAYS" -print0 2>/dev/null || true)
done

echo ""
echo -e "${CYAN}------------------------------------------------${NC}"
echo -e "Stale files found: $STALE_COUNT"

if [[ $STALE_COUNT -gt 0 ]]; then
  if [[ "$IN_PLACE" == true ]]; then
    # Remove stale files
    for file in "${STALE_FILES[@]}"; do
      rm -f "$file"
    done
    echo -e "\n${GREEN}✓ Removed $STALE_COUNT stale file(s).${NC}"
  else
    echo -e "\n${YELLOW}[DRY RUN] No files removed. Use --in-place to delete stale files.${NC}"
  fi
else
  echo -e "\n${GREEN}✓ No stale test data found. All files are within retention period.${NC}"
fi

# Print retention policy reminder
echo ""
echo -e "${CYAN}Retention Policy:${NC}"
echo -e "  - Synthetic data older than $DAYS days should be removed."
echo -e "  - Mock API corpus files are EXCLUDED (they are workshop artifacts)."
echo -e "  - To archive data instead of deleting, move files to docs/requirements/MOCK-API/archive/"
echo -e "  - Run this script at the end of each workshop session."
