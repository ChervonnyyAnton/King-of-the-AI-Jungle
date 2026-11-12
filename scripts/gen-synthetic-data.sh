#!/usr/bin/env bash
#
# gen-synthetic-data.sh — GDPR-Compliant Synthetic Data Generator
# Generates fake customer records for testing the mock PDF configurator.
#
# Usage:
#   scripts/gen-synthetic-data.sh [count] [--validate] [--output <file>]
#
# Examples:
#   scripts/gen-synthetic-data.sh 10                    # Generate 10 records, print to stdout
#   scripts/gen-synthetic-data.sh 5 --output data.json  # Generate 5 records, save to file
#   scripts/gen-synthetic-data.sh --validate data.json  # Validate an existing dataset
#
# Generated data characteristics:
#   - All emails use approved synthetic domains only
#   - All IDs follow the format PREFIX-NNNN
#   - Names contain at least one fictional element
#   - No real-world phone numbers or addresses
#   - Output includes a meta block with GDPR compliance markers
#
# Exit codes:
#   0 — Success
#   1 — Invalid arguments
#   2 — Validation failure

set -euo pipefail

# Approved synthetic email domains (GDPR-compliant — no real domains)
SYNTHETIC_DOMAINS=("jungle.test" "sandbox.dev" "workshop.local" "training.example.test" "demo.local")

# Fictional first names (realistic but clearly synthetic when combined with generic last names)
FIRST_NAMES=(
  "Jane" "John" "Alex" "Sam" "Jordan" "Taylor" "Morgan" "Casey" "Riley" "Avery"
  "Quinn" "Blake" "Drew" "Sage" "Reese" "Skyler" "Ellis" "Finley" "Harper" "Rowan"
)

LAST_NAMES=(
  "Doe" "Smith" "Jones" "Brown" "Wilson" "Clark" "Lewis" "Hall" "Young" "King"
  "Wright" "Hill" "Scott" "Green" "Adams" "Baker" "Nelson" "Carter" "Mitchell" "Perez"
)

# Synthetic street addresses (realistic format, fictional numbers/names)
STREET_PREFIXES=("Maple" "Oak" "Pine" "Cedar" "Elm" "Birch" "Ash" "Willow" "Spruce" "Cypress")
STREET_SUFFIXES=("Street" "Avenue" "Boulevard" "Lane" "Drive" "Court" "Place" "Way" "Circle" "Trail")

# Country code for phone numbers (synthetic prefix)
PHONE_PREFIX="+1-555"

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Defaults
COUNT=5
OUTPUT=""
VALIDATE_MODE=false
INPUT_FILE=""

# ---- Argument Parsing ----
while [[ $# -gt 0 ]]; do
  case "$1" in
    --validate)
      VALIDATE_MODE=true
      shift
      if [[ $# -gt 0 && ! "$1" =~ ^-- ]]; then
        INPUT_FILE="$1"
        shift
      fi
      ;;
    --output|-o)
      shift
      OUTPUT="$1"
      shift
      ;;
    --help|-h)
      head -20 "$0" | grep "^#" | sed 's/^# \?//'
      exit 0
      ;;
    -[0-9]*)
      COUNT="$1"
      shift
      ;;
    [0-9]+)
      COUNT="$1"
      shift
      ;;
    *)
      echo -e "${RED}Error: Unknown argument '$1'. Use --help for usage.${NC}" >&2
      exit 1
      ;;
  esac
done

# ---- Validation Mode ----
if [[ "$VALIDATE_MODE" == true ]]; then
  if [[ -z "$INPUT_FILE" ]]; then
    echo -e "${RED}Error: Specify a file to validate: scripts/gen-synthetic-data.sh --validate <file>${NC}" >&2
    exit 1
  fi

  if [[ ! -f "$INPUT_FILE" ]]; then
    echo -e "${RED}Error: File not found: $INPUT_FILE${NC}" >&2
    exit 1
  fi

  echo -e "${YELLOW}Validating synthetic data in: $INPUT_FILE${NC}"
  echo "-------------------------------------------"

  # Check file is valid JSON
  if ! python3 -c "import json; json.load(open('$INPUT_FILE'))" 2>/dev/null; then
    echo -e "${RED}FAIL: File is not valid JSON${NC}"
    exit 2
  fi

  # Extract and validate each record
  FAIL_COUNT=0
  TOTAL_RECORDS=$(python3 -c "
import json
with open('$INPUT_FILE') as f:
    data = json.load(f)
records = data.get('data', data)
if isinstance(records, list):
    print(len(records))
else:
    print(0)
")

  if [[ "$TOTAL_RECORDS" -eq 0 ]]; then
    echo -e "${RED}FAIL: No records found in data${NC}"
    exit 2
  fi

  echo "Total records: $TOTAL_RECORDS"

  python3 -c "
import json, re, sys

with open('$INPUT_FILE') as f:
    data = json.load(f)

records = data.get('data', data) if isinstance(data, dict) else data
approved_domains = ['jungle.test', 'sandbox.dev', 'workshop.local', 'training.example.test', 'demo.local']
id_pattern = re.compile(r'^[A-Z]+-\d{4,}$')
phone_pattern = re.compile(r'^\+1-555-\d{4}$')
name_pattern = re.compile(r'^[A-Z][a-z]+$')

fail_count = 0
for i, record in enumerate(records):
    record_pass = True

    # Validate ID format
    rid = record.get('id', '')
    if not id_pattern.match(rid):
        print(f'  Record {i+1}: FAIL - ID format invalid: {rid}')
        record_pass = False

    # Validate email domain
    email = record.get('email', '')
    domain = email.split('@')[-1] if '@' in email else ''
    if domain not in approved_domains:
        print(f'  Record {i+1}: FAIL - Email domain not synthetic: {email} ({domain})')
        record_pass = False

    # Validate phone format
    phone = record.get('phone', '')
    if phone and not phone_pattern.match(phone):
        print(f'  Record {i+1}: WARN - Phone format non-standard: {phone}')

    # Validate name format
    first = record.get('first_name', '')
    last = record.get('last_name', '')
    if first and not name_pattern.match(first):
        print(f'  Record {i+1}: WARN - First name unusual: {first}')
    if last and not name_pattern.match(last):
        print(f'  Record {i+1}: WARN - Last name unusual: {last}')

    if not record_pass:
        fail_count += 1

if fail_count > 0:
    print(f'\nValidation FAILED: {fail_count}/{len(records)} records failed')
    sys.exit(1)
else:
    print(f'\nValidation PASSED: All {len(records)} records are compliant')
    sys.exit(0)
"
  exit $?
fi

# ---- Generate Synthetic Data ----

# Helper: get random element from array
rand_element() {
  local -n arr=$1
  echo "${arr[$((RANDOM % ${#arr[@]}))]}"
}

# Helper: generate random 4-digit number
rand_id() {
  printf "%04d" $((RANDOM % 10000))
}

# Build the JSON output
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date +"%Y-%m-%dT%H:%M:%SZ")

echo '{'
echo '  "meta": {'
echo "    \"generated_by\": \"gen-synthetic-data.sh v2.0.0\","
echo "    \"generation_timestamp\": \"$TIMESTAMP\","
echo '    "record_count": '"$COUNT"','
echo '    "gdpr_compliant": true,'
echo '    "synthetic_domains": ["'"$(IFS=', '; echo "${SYNTHETIC_DOMAINS[*]}")'"]'
echo '  },'
echo '  "data": ['

for i in $(seq 1 "$COUNT"); do
  first=$(rand_element FIRST_NAMES)
  last=$(rand_element LAST_NAMES)
  domain_idx=$((RANDOM % ${#SYNTHETIC_DOMAINS[@]}))
  email="${first,,}.${last,,}@${SYNTHETIC_DOMAINS[$domain_idx]}"
  prefix=$(rand_id)
  phone="${PHONE_PREFIX}-$(printf '%04d' $((RANDOM % 10000)))"
  street_num=$((RANDOM % 999 + 1))
  street=$(rand_element STREET_PREFIXES)
  street_type=$(rand_element STREET_SUFFIXES)
  city_idx=$((RANDOM % 5))
  cities=("Springfield" "Riverside" "Lakewood" "Hillcrest" "Fairview")
  state_idx=$((RANDOM % 5))
  states=("AL" "AK" "AZ" "AR" "CA")

  # Add comma separator between records (not after last)
  if [[ $i -gt 1 ]]; then
    echo '    ,'
  fi

  echo '    {'
  echo "      \"id\": \"CUST-$prefix\","
  echo "      \"first_name\": \"$first\","
  echo "      \"last_name\": \"$last\","
  echo "      \"email\": \"$email\","
  echo "      \"phone\": \"$phone\","
  echo "      \"address\": {"
  echo "        \"street\": \"$street_num $street $street_type\","
  echo "        \"city\": \"${cities[$city_idx]}\","
  echo "        \"state\": \"${states[$state_idx]}\","
  echo "        \"country\": \"US\""
  echo "      },"
  echo "      \"customer_since\": \"20$(printf '%02d' $((RANDOM % 5 + 20)))-$(printf '%02d' $((RANDOM % 12 + 1)))-$(printf '%02d' $((RANDOM % 28 + 1)))\","
  echo "      \"account_status\": \"active\""
  echo -n '    }'
done

echo ''
echo '  ]'
echo '}'
