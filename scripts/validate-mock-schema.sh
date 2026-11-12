#!/usr/bin/env bash
#
# validate-mock-schema.sh — Mock API Schema Validation
# Validates mock API responses against the sandbox configurator's export/import contract.
#
# Usage:
#   scripts/validate-mock-schema.sh [directory]
#
# Examples:
#   scripts/validate-mock-schema.sh
#   scripts/validate-mock-schema.sh docs/requirements/MOCK-API/
#
# Exit codes:
#   0 — All files pass validation
#   1 — One or more files fail validation

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Get directory argument
TARGET_DIR="${1:-docs/requirements/MOCK-API}"

if [[ ! -d "$TARGET_DIR" ]]; then
  echo -e "${RED}Error: Directory not found: $TARGET_DIR${NC}" >&2
  exit 1
fi

echo -e "${CYAN}================================================${NC}"
echo -e "${CYAN}  Mock API Schema Validation v2.0.0${NC}"
echo -e "${CYAN}  Target: $TARGET_DIR${NC}"
echo -e "${CYAN}================================================${NC}"
echo ""

# Schema requirements based on mock/index.html's exportConfig() function
REQUIRED_FIELDS=("meta" "header" "body" "footer" "layout" "gridEnabled" "gridData")
VALID_LAYOUTS=("corporate" "startup" "clean")

PASS_COUNT=0
FAIL_COUNT=0
TOTAL=0

for json_file in "$TARGET_DIR"/*.json; do
  [[ -f "$json_file" ]] || continue

  filename=$(basename "$json_file")
  TOTAL=$((TOTAL + 1))

  echo -e "${CYAN}Validating: $filename${NC}"

  # Step 1: Check valid JSON
  if ! python3 -c "import json; json.load(open('$json_file'))" 2>/dev/null; then
    echo -e "  ${RED}FAIL: Not valid JSON${NC}"
    FAIL_COUNT=$((FAIL_COUNT + 1))
    continue
  fi
  echo -e "  ${GREEN}✓ Valid JSON${NC}"

  # Step 2: Check required fields and types
  python3 -c "
import json, sys

with open('$json_file') as f:
    data = json.load(f)

errors = []
filename = '$filename'

# Check if it's a config export format (has meta + config fields)
if 'meta' in data and 'header' in data:
    required_fields = ['meta', 'header', 'body', 'footer', 'layout', 'gridEnabled', 'gridData']
    for field in required_fields:
        if field not in data:
            errors.append(f'Missing required field: {field}')
    
    # Validate layout enum
    if 'layout' in data:
        valid_layouts = ['corporate', 'startup', 'clean']
        if data['layout'] not in valid_layouts:
            errors.append(f'Invalid layout value: {data[\"layout\"]} (must be one of {valid_layouts})')
    
    # Validate field types
    if 'header' in data and not isinstance(data['header'], str):
        errors.append(f'\"header\" must be a string, got {type(data[\"header\"]).__name__}')
    if 'body' in data and not isinstance(data['body'], str):
        errors.append(f'\"body\" must be a string, got {type(data[\"body\"]).__name__}')
    if 'footer' in data and not isinstance(data['footer'], str):
        errors.append(f'\"footer\" must be a string, got {type(data[\"footer\"]).__name__}')
    if 'layout' in data and not isinstance(data['layout'], str):
        errors.append(f'\"layout\" must be a string, got {type(data[\"layout\"]).__name__}')
    if 'gridEnabled' in data and not isinstance(data['gridEnabled'], bool):
        errors.append(f'\"gridEnabled\" must be a boolean, got {type(data[\"gridEnabled\"]).__name__}')
    if 'gridData' in data and not isinstance(data['gridData'], list):
        errors.append(f'\"gridData\" must be an array, got {type(data[\"gridData\"]).__name__}')
    elif 'gridData' in data and len(data['gridData']) > 0:
        # Check that all grid rows have consistent keys
        first_keys = set(data['gridData'][0].keys()) if isinstance(data['gridData'][0], dict) else None
        for i, row in enumerate(data['gridData']):
            if isinstance(row, dict):
                row_keys = set(row.keys())
                if first_keys and row_keys != first_keys:
                    errors.append(f'gridData row {i}: inconsistent keys ({row_keys} vs expected {first_keys})')

# Check if it's a synthetic data format (has meta + data array)
if 'meta' in data and 'data' in data:
    if not isinstance(data['data'], list):
        errors.append('\"data\" must be an array in synthetic data format')
    elif len(data['data']) > 0:
        # Check first record has required fields
        sample = data['data'][0]
        for field in ['id', 'first_name', 'last_name', 'email', 'phone']:
            if field not in sample:
                errors.append(f'Synthetic data record missing required field: {field}')

# Check meta block
if 'meta' in data:
    meta = data['meta']
    if not isinstance(meta, dict):
        errors.append('\"meta\" must be an object')
    elif 'generated_by' in meta:
        if not isinstance(meta['generated_by'], str):
            errors.append('\"meta.generated_by\" must be a string')

if errors:
    for err in errors:
        print(f'  {err}')
    sys.exit(1)
else:
    sys.exit(0)
" 2>&1

  if [[ $? -eq 0 ]]; then
    echo -e "  ${GREEN}✓ Schema validation passed${NC}"
    PASS_COUNT=$((PASS_COUNT + 1))
  else
    echo -e "  ${RED}✗ Schema validation failed${NC}"
    FAIL_COUNT=$((FAIL_COUNT + 1))
  fi
done

echo ""
echo -e "${CYAN}------------------------------------------------${NC}"
echo -e "Total files: $TOTAL | Passed: ${GREEN}$PASS_COUNT${NC} | Failed: ${RED}$FAIL_COUNT${NC}"

if [[ $FAIL_COUNT -gt 0 ]]; then
  echo -e "\n${RED}Validation FAILED: $FAIL_COUNT file(s) have schema errors.${NC}"
  exit 1
else
  echo -e "\n${GREEN}✓ All mock API responses conform to the sandbox configurator schema.${NC}"
  exit 0
fi
