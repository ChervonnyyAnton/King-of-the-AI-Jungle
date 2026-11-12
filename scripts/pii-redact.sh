#!/usr/bin/env bash
#
# pii-redact.sh — PII Detection and Redaction CLI Tool
# Scans files for common PII patterns and replaces them with safe placeholders.
#
# Usage:
#   scripts/pii-redact.sh [--dry-run] [--in-place] [--workshop-mode] <file> [file ...]
#
# Options:
#   --dry-run          Show what would be redacted without modifying files (default)
#   --in-place         Redact PII in-place (modifies the file)
#   --workshop-mode    Enable workshop-specific PII patterns (Jira IDs, internal URLs)
#   --report           Generate a detailed PII report (implies --dry-run)
#   --help, -h         Show this help message
#
# Examples:
#   scripts/pii-redact.sh --dry-run AGENTS.md
#   scripts/pii-redact.sh --in-place docs/tools/INSTRUCTOR-QUICK-REF.md
#   scripts/pii-redact.sh --workshop-mode --report docs/requirements/
#
# Exit codes:
#   0 — No PII found (dry-run) or redaction successful (in-place)
#   1 — PII detected (dry-run/report mode)
#   2 — Error (file not found, invalid arguments)

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Defaults
DRY_RUN=true
IN_PLACE=false
WORKSHOP_MODE=false
REPORT_MODE=false
FILES=()

# ---- PII Pattern Definitions ----

# General PII patterns
EMAIL_PATTERN='[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'
PHONE_PATTERN='\+?1?[-.\s]?\(?[0-9]{3}\)?[-.\s]?[0-9]{3}[-.\s]?[0-9]{4}'
SSN_PATTERN='[0-9]{3}-[0-9]{2}-[0-9]{4}'
CREDIT_CARD_PATTERN='\b[0-9]{4}[-\s]?[0-9]{4}[-\s]?[0-9]{4}[-\s]?[0-9]{4}\b'
NAME_TITLE_PATTERN='(Mr\.|Mrs\.|Ms\.|Dr\.|Prof\.)\s+[A-Z][a-z]+ [A-Z][a-z]+'
IP_PATTERN='\b[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\b'

# Workshop-specific patterns (enabled with --workshop-mode)
JIRA_PATTERN='\b(WISO|WIM|JIRA|TICKET)-[0-9]+\b'
INTERNAL_URL_PATTERN='https?://[a-zA-Z0-9.-]*\.(internal|corp|adesso|local|test|dev)\.[a-zA-Z0-9.-]+'
SESSION_COOKIE_PATTERN='(JSESSIONID|connect\.sid|PHPSESSID|AWSLB|SESSION)=\w{8,}'
API_KEY_PATTERN='(api[_-]?key|apikey|access[_-]?token)\s*[:=]\s*["\x27]?[a-zA-Z0-9_/+=-]{16,}'

# Placeholders
EMAIL_PLACEHOLDER='[EMAIL-REDACTED]'
PHONE_PLACEHOLDER='[PHONE-REDACTED]'
SSN_PLACEHOLDER='[SSN-REDACTED]'
CC_PLACEHOLDER='[CC-REDACTED]'
NAME_TITLE_PLACEHOLDER='[NAME-TITLE-REDACTED]'
IP_PLACEHOLDER='[IP-REDACTED]'
JIRA_PLACEHOLDER='[JIRA-REDACTED]'
INTERNAL_URL_PLACEHOLDER='[INTERNAL-URL-REDACTED]'
SESSION_PLACEHOLDER='[SESSION-REDACTED]'
API_KEY_PLACEHOLDER='[API-KEY-REDACTED]'

# ---- Argument Parsing ----
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
    --workshop-mode)
      WORKSHOP_MODE=true
      shift
      ;;
    --report)
      REPORT_MODE=true
      DRY_RUN=true
      shift
      ;;
    --help|-h)
      head -25 "$0" | grep "^#" | sed 's/^# \?//'
      exit 0
      ;;
    -*)
      echo -e "${RED}Error: Unknown option '$1'. Use --help for usage.${NC}" >&2
      exit 2
      ;;
    *)
      FILES+=("$1")
      shift
      ;;
  esac
done

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo -e "${RED}Error: No files specified. Use --help for usage.${NC}" >&2
  exit 2
fi

# ---- Redaction Functions ----

# Collect PII findings for reporting
declare -A PII_FINDINGS

# Scan and redact a single file
redact_file() {
  local file="$1"
  local found=false
  local count=0

  if [[ ! -f "$file" ]]; then
    echo -e "${RED}Error: File not found: $file${NC}" >&2
    return 2
  fi

  echo -e "${CYAN}Scanning: $file${NC}"

  # Build the combined pattern list
  local -a patterns=("$EMAIL_PATTERN" "$PHONE_PATTERN" "$SSN_PATTERN" "$CREDIT_CARD_PATTERN" "$NAME_TITLE_PATTERN" "$IP_PATTERN")
  local -a placeholders=("$EMAIL_PLACEHOLDER" "$PHONE_PLACEHOLDER" "$SSN_PLACEHOLDER" "$CC_PLACEHOLDER" "$NAME_TITLE_PLACEHOLDER" "$IP_PLACEHOLDER")
  local -a category_names=("Email" "Phone" "SSN" "Credit Card" "Name/Title" "IP Address")

  if [[ "$WORKSHOP_MODE" == true ]]; then
    patterns+=("$JIRA_PATTERN" "$INTERNAL_URL_PATTERN" "$SESSION_COOKIE_PATTERN" "$API_KEY_PATTERN")
    placeholders+=("$JIRA_PLACEHOLDER" "$INTERNAL_URL_PLACEHOLDER" "$SESSION_PLACEHOLDER" "$API_KEY_PLACEHOLDER")
    category_names+=("Jira ID" "Internal URL" "Session Cookie" "API Key")
  fi

  # Scan file content
  for i in "${!patterns[@]}"; do
    local pattern="${patterns[$i]}"
    local placeholder="${placeholders[$i]}"
    local category="${category_names[$i]}"

    if grep -qE "$pattern" "$file" 2>/dev/null; then
      found=true
      count=$((count + 1))
      local matches
      matches=$(grep -oE "$pattern" "$file" 2>/dev/null | head -5 | tr '\n' ', ')
      echo -e "  ${YELLOW}[$category]${NC} ${matches}... → ${GREEN}$placeholder${NC}"
      PII_FINDINGS["$category"]=$(( ${PII_FINDINGS["$category"]:-0} + 1 ))
    fi
  done

  if [[ "$found" == true ]]; then
    echo -e "  Found $count PII category(ies) in this file."

    if [[ "$DRY_RUN" == true ]]; then
      echo -e "  ${YELLOW}[DRY RUN] No changes made. Use --in-place to apply redactions.${NC}"
      return 1
    else
      # Perform in-place redaction
      local tmpfile
      tmpfile=$(mktemp)
      cp "$file" "$tmpfile"

      for i in "${!patterns[@]}"; do
        local pattern="${patterns[$i]}"
        local placeholder="${placeholders[$i]}"
        sed -i '' "s/$pattern/$placeholder/g" "$file" 2>/dev/null || \
        perl -pi -e "s/$pattern/$placeholder/g" "$file" 2>/dev/null
      done

      rm -f "$tmpfile"
      echo -e "  ${GREEN}✓ Redaction applied.${NC}"
      return 0
    fi
  else
    echo -e "  ${GREEN}✓ No PII detected.${NC}"
    return 0
  fi
}

# ---- Main ----

echo -e "${CYAN}================================================${NC}"
echo -e "${CYAN}  PII Detection & Redaction Tool v2.0.0${NC}"
echo -e "${CYAN}  Mode: $(if $DRY_RUN; then echo 'Dry Run'; else echo 'In-Place'; fi)$(if $WORKSHOP_MODE; then echo ' + Workshop Mode'; fi)${NC}"
echo -e "${CYAN}================================================${NC}"
echo ""

total_findings=0
total_files=0

for file in "${FILES[@]}"; do
  if redact_file "$file"; then
    : # No PII found
  else
    total_findings=$((total_findings + $? == 1 ? 0 : 1))
  fi
  total_files=$((total_files + 1))
done

echo ""
echo -e "${CYAN}------------------------------------------------${NC}"
if [[ "$REPORT_MODE" == true ]]; then
  echo -e "${CYAN}PII Report Summary${NC}"
  echo -e "Files scanned: $total_files"
  echo -e "PII categories found:"
  for category in "${!PII_FINDINGS[@]}"; do
    echo -e "  $category: ${PII_FINDINGS[$category]}"
  done
fi

if [[ $total_findings -gt 0 ]]; then
  echo -e "\n${RED}PII detected in $total_findings file(s). Review findings above.${NC}"
  exit 1
else
  echo -e "\n${GREEN}✓ No PII detected in any scanned files.${NC}"
  exit 0
fi
