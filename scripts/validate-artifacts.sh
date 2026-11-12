#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════
# scripts/validate-artifacts.sh
# King of the AI Jungle — Automated Artifact Validation
# Reference: R&R Cycles 111–120, Section 25 of R&R-CYCLE-RULES.md
#
# Validates all workshop artifacts for structural integrity,
# ISTQB compliance, budget constraints, and security posture.
#
# Usage:
#   ./scripts/validate-artifacts.sh              # Validate all
#   ./scripts/validate-artifacts.sh --test-plan   # Validate TEST-PLAN.md only
#   ./scripts/validate-artifacts.sh --budget-log   # Validate BUDGET-LOG.md only
#   ./scripts/validate-artifacts.sh --coverage     # Validate coverage ≥80%
#   ./scripts/validate-artifacts.sh --security     # Run security scan (semgrep)
#   ./scripts/validate-artifacts.sh --format       # Validate artifact format compliance
# ═══════════════════════════════════════════════════════════
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_ROOT"

# ──────────────────────────────────────────────────────────
# Color helpers
# ──────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; NC='\033[0m'

pass()  { printf "${GREEN}  ✅ PASS${NC} %s\n" "$1"; }
fail()  { printf "${RED}  ❌ FAIL${NC} %s\n" "$1"; FAILURES=$((FAILURES + 1)); }
warn()  { printf "${YELLOW}  ⚠️ WARN${NC} %s\n" "$1"; }
info()  { printf "${CYAN}  ℹ️ INFO${NC} %s\n" "$1"; }
section() { printf "\n${BLUE}── %s ──${NC}\n" "$1"; }

TOTAL_CHECKS=0
FAILURES=0

# ──────────────────────────────────────────────────────────
# Helper: count ISTQB techniques in a file
# ──────────────────────────────────────────────────────────
count_istqb_techniques() {
  local file="$1"
  local count=0
  local techniques=(
    "Equivalence Partitioning"
    "Boundary Value Analysis"
    "Decision Table"
    "State Transition"
    "Error Guessing"
    "Pairwise"
    "Cause-Effect"
  )
  for technique in "${techniques[@]}"; do
    if grep -qi "$technique" "$file" 2>/dev/null; then
      count=$((count + 1))
    fi
  done
  echo "$count"
}

# ──────────────────────────────────────────────────────────
# Cycle 111: TEST-PLAN.md Artifact Validation
# ──────────────────────────────────────────────────────────
validate_test_plan() {
  section "TEST-PLAN.md Validation (Cycle 111)"

  local file="docs/requirements/TEST-PLAN.md"

  if [[ ! -f "$file" ]]; then
    fail "TEST-PLAN.md not found at $file"
    return
  fi

  pass "TEST-PLAN.md exists"
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Required sections (ISO/IEC/IEEE 29119-3 §5.3)
  local required_sections=(
    "Identifier"
    "Title"
    "Introduction"
    "Test Items"
    "Features to test"
    "Approach"
    "Test Environment"
    "Schedule"
    "Deliverables"
    "Risks"
    "Approval"
  )
  local missing_sections=()
  for section_name in "${required_sections[@]}"; do
    if ! grep -qi "$section_name" "$file" 2>/dev/null; then
      missing_sections+=("$section_name")
    fi
  done

  if [[ ${#missing_sections[@]} -eq 0 ]]; then
    pass "All required ISO 29119-3 sections present"
  else
    fail "Missing sections in TEST-PLAN.md: ${missing_sections[*]}"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # ISTQB technique diversity (≥3 required per Rule 10.3)
  local tech_count
  tech_count=$(count_istqb_techniques "$file")
  if [[ $tech_count -ge 3 ]]; then
    pass "ISTQB technique diversity: $tech_count techniques found (≥3 required)"
  else
    fail "ISTQB technique diversity: only $tech_count techniques found (≥3 required per Rule 10.3)"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check for ≥5 test cases (Scout judging criterion)
  local test_case_count
  test_case_count=$(grep -c "^\| \|ID-" "$file" 2>/dev/null | tail -1 || echo "0")
  if [[ $test_case_count -ge 5 ]]; then
    pass "Minimum test cases: $test_case_count found (≥5 required for Scouts)"
  else
    warn "Low test case count: $test_case_count (Scouts need ≥5, Engineers ≥10)"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check for traceability links to tickets
  if grep -qi "JIRA-\|REQ-\|TICKET" "$file" 2>/dev/null; then
    pass "Traceability links to tickets found"
  else
    warn "No ticket traceability links found (expected JIRA-*, REQ-*, or TICKET-*)"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
}

# ──────────────────────────────────────────────────────────
# Cycle 112: BUDGET-LOG.md Compliance Check
# ──────────────────────────────────────────────────────────
validate_budget_log() {
  section "BUDGET-LOG.md Compliance (Cycle 112)"

  local file="BUDGET-LOG.md"

  if [[ ! -f "$file" ]]; then
    warn "BUDGET-LOG.md not found — participant has not started budget tracking"
    return
  fi

  # Verify template structure
  if grep -q "Operator" "$file" && grep -q "Timestamp" "$file" && \
     grep -q "Est. Cost" "$file" && grep -q "Cumulative Cost" "$file"; then
    pass "BUDGET-LOG.md has required audit columns"
  else
    fail "BUDGET-LOG.md missing required audit columns (Operator, Timestamp, Est. Cost, Cumulative Cost)"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check for entries
  local entry_count
  entry_count=$(grep -c "^|.*~\$" "$file" 2>/dev/null || echo "0")
  if [[ $entry_count -gt 0 ]]; then
    info "Found $entry_count logged task entries"
  else
    warn "No task entries found in BUDGET-LOG.md"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Extract cumulative cost and check against $50 cap
  # Look for the last "Cumulative Cost" entry pattern
  local cumulative
  cumulative=$(grep "Cumulative Cost" "$file" 2>/dev/null | tail -1 | grep -oP '~?\$[\d.]+' | head -1 || echo "")
  if [[ -n "$cumulative" ]]; then
    # Strip $ and ~, convert to number for comparison
    local num
    num=$(echo "$cumulative" | sed 's/~\?\$//')
    local exceeded
    exceeded=$(awk "BEGIN {print ($num > 50) ? 1 : 0}")
    if [[ "$exceeded" -eq 1 ]]; then
      fail "Budget exceeded: cumulative cost \$$num exceeds $50 cap"
    else
      pass "Budget compliance: \$$num / $50 cap"
    fi
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

    # Alert threshold at $45
    local near_cap
    near_cap=$(awk "BEGIN {print ($num >= 45) ? 1 : 0}")
    if [[ "$near_cap" -eq 1 ]]; then
      warn "Budget warning: \$$num is within $5 of the $50 cap"
    fi
  else
    warn "Could not determine cumulative cost from BUDGET-LOG.md"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check for cost per artifact summary table
  if grep -q "Cost per Artifact Summary" "$file"; then
    pass "Cost per Artifact Summary table present"
  else
    fail "Cost per Artifact Summary table missing (required by Rule 12.3)"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
}

# ──────────────────────────────────────────────────────────
# Cycle 113: Playwright Coverage Gates
# ──────────────────────────────────────────────────────────
validate_coverage() {
  section "Playwright Coverage Gates (Cycle 113)"

  local coverage_file="coverage/lcov.info"

  # Check if coverage data exists
  if [[ ! -f "$coverage_file" ]]; then
    warn "No coverage data found at $coverage_file — run tests first: npx playwright test"
    return
  fi

  # Parse coverage percentage from lcov.info
  local total_lines covered_lines coverage_pct
  total_lines=$(grep '^TN:' "$coverage_file" 2>/dev/null | wc -l || echo "0")
  if [[ $total_lines -gt 0 ]]; then
    covered_lines=$(grep '^DA:' "$coverage_file" 2>/dev/null | awk -F: '{sum+=$2; count++} END {print count+0}')
    local lines_total
    lines_total=$(grep '^DA:' "$coverage_file" 2>/dev/null | awk -F: '{sum+=$2} END {print sum+0}')
    if [[ $lines_total -gt 0 ]]; then
      coverage_pct=$(awk "BEGIN {printf \"%.1f\", ($covered_lines / $lines_total) * 100}")
    else
      coverage_pct="0.0"
    fi
  else
    coverage_pct="0.0"
  fi

  if [[ "$coverage_pct" != "0.0" ]]; then
    info "Current coverage: ${coverage_pct}%"
    local meets_threshold
    meets_threshold=$(awk "BEGIN {print ($coverage_pct >= 80) ? 1 : 0}")
    if [[ "$meets_threshold" -eq 1 ]]; then
      pass "Coverage ${coverage_pct}% meets the ≥80% threshold (Rule 10.4, Gate 6)"
    else
      fail "Coverage ${coverage_pct}% is below the ≥80% threshold (Rule 10.4, Gate 6)"
    fi
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  else
    fail "No coverage data available — ensure Playwright is configured with coverage reporting"
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  fi

  # Verify playwright.config.js has coverage reporter
  if grep -q "html\|lcov\|coverage" playwright.config.js 2>/dev/null; then
    pass "Playwright config includes coverage reporter"
  else
    warn "No coverage reporter found in playwright.config.js — add HTML or lcov reporter"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
}

# ──────────────────────────────────────────────────────────
# Cycle 114: Security Scanning (XSS & Static Analysis)
# ──────────────────────────────────────────────────────────
validate_security() {
  section "Security Scan (Cycle 114)"

  local html_file="mock/index.html"

  if [[ ! -f "$html_file" ]]; then
    fail "mock/index.html not found — sandbox artifact missing"
    return
  fi

  # Check 1: XSS prevention — escapeHtml function exists
  if grep -q "escapeHtml" "$html_file"; then
    pass "XSS prevention: escapeHtml() function present"
  else
    fail "XSS vulnerability: escapeHtml() function missing — user data may be injected into DOM"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check 2: XSS prevention — innerHTML usage is safe
  if grep -q "innerHTML" "$html_file"; then
    # innerHTML is used, check if escapeHtml guards it
    if grep -A5 "innerHTML" "$html_file" | grep -q "escapeHtml"; then
      pass "innerHTML usage is guarded by escapeHtml()"
    else
      fail "XSS risk: innerHTML found without escapeHtml guard"
    fi
  else
    pass "No innerHTML usage — safe from direct XSS via DOM manipulation"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check 3: CSP compliance
  if grep -q "Content-Security-Policy" "$html_file"; then
    local csp_pass=true
    local directives=("connect-src 'self'" "frame-src 'none'" "object-src 'none'" "base-uri 'self'")
    for dir in "${directives[@]}"; do
      if ! grep -q "$dir" "$html_file"; then
        fail "CSP missing directive: '$dir'"
        csp_pass=false
      fi
    done
    if $csp_pass; then
      pass "CSP defense-in-depth: all required directives present"
    fi
  else
    fail "CSP meta tag missing — no content security policy enforcement"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check 4: No external URLs / fetch calls
  if grep -qE "fetch\(|new WebSocket|http[s]?://[a-zA-Z]" "$html_file" 2>/dev/null; then
    fail "External API calls detected — sandbox must be isolated (Rule DXS-1)"
  else
    pass "No external API calls — sandbox isolation verified"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check 5: semgrep analysis (if available)
  if command -v semgrep &>/dev/null; then
    info "Running semgrep static analysis..."
    local semgrep_results
    if semgrep --quiet --config "auto" --json mock/index.html 2>/dev/null | grep -q '"id"'; then
      local vuln_count
      vuln_count=$(semgrep --quiet --config "auto" --json mock/index.html 2>/dev/null | grep '"id"' | wc -l || echo "0")
      if [[ $vuln_count -gt 0 ]]; then
        fail "semgrep found $vuln_count security issue(s) in mock/index.html"
      else
        pass "semgrep scan: no security issues found"
      fi
      TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    else
      warn "semgrep ran but found no issues (or returned empty)"
    fi
  else
    warn "semgrep not installed — skipping static analysis (install via: brew install semgrep)"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check 6: trivy scan (if available)
  if command -v trivy &>/dev/null; then
    info "Running trivy filesystem scan on mock/..."
    local trivy_results
    if trivy fs --severity HIGH,CRITICAL --format table mock/ 2>/dev/null | grep -qi "VULNERABILITY\|HIGH\|CRITICAL"; then
      warn "trivy found vulnerability findings in mock/ — review results above"
    else
      pass "trivy scan: no HIGH/CRITICAL vulnerabilities found"
    fi
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  else
    warn "trivy not installed — skipping filesystem scan (install via: brew install trivy)"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
}

# ──────────────────────────────────────────────────────────
# Cycle 115: Prompt Version & Consistency Validation
# ──────────────────────────────────────────────────────────
validate_prompt_versions() {
  section "Prompt Version & Consistency (Cycle 115)"

  # Check 1: All prompt templates in AGENTS.md have version tags
  local prompt_blocks
  prompt_blocks=$(grep -c '<!-- prompt:' AGENTS.md 2>/dev/null || echo "0")
  local total_prompts
  total_prompts=$(grep -c 'role:' AGENTS.md 2>/dev/null || echo "0")

  if [[ $prompt_blocks -eq $total_prompts && $prompt_blocks -gt 0 ]]; then
    pass "All $prompt_blocks prompt templates have version tags (Rule 12.1)"
  else
    fail "Prompt version mismatch: $prompt_blocks tagged / $total_prompts total templates (Rule 12.1)"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check 2: Prompt version format validation
  local invalid_versions
  invalid_versions=$(grep '<!-- prompt:' AGENTS.md 2>/dev/null | grep -cvP '<!-- prompt: v\d+\.\d+ -->' || echo "0")
  if [[ $invalid_versions -eq 0 ]]; then
    pass "All prompt versions follow semantic format (vX.Y)"
  else
    fail "$invalid_versions prompt version(s) do not follow vX.Y format"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check 3: Safety filters present
  if grep -q "No Malicious Code" AGENTS.md && \
     grep -q "No System Prompt Disclosure" AGENTS.md && \
     grep -q "No Rule Disregard" AGENTS.md; then
    pass "Safety filters: all 3 guard clauses present (Rule 12.5)"
  else
    fail "Safety filters: missing guard clauses (Rule 12.5 requires all 3)"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
}

# ──────────────────────────────────────────────────────────
# Cycle 116: Cross-Artifact Consistency
# ──────────────────────────────────────────────────────────
validate_cross_artifact() {
  section "Cross-Artifact Consistency (Cycle 116)"

  # Check 1: BUDGET-LOG.md references in participant docs
  if grep -q "BUDGET-LOG" WORKSHOP-CHALLENGE.md 2>/dev/null; then
    pass "WORKSHOP-CHALLENGE.md references BUDGET-LOG.md"
  else
    warn "WORKSHOP-CHALLENGE.md does not reference BUDGET-LOG.md"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check 2: AGENTS.md prompt versions match Rule 12.1
  local version_tags
  version_tags=$(grep -oP 'v\d+\.\d+' AGENTS.md 2>/dev/null | sort -u | wc -l || echo "0")
  info "Found $version_tags unique prompt version(s) in AGENTS.md"
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check 3: SEED_VERSION consistency
  if grep -q "SEED_VERSION" mock/index.html; then
    local seed_version
    seed_version=$(grep -oP 'SEED_VERSION.*?"[^"]*"' mock/index.html | grep -oP 'v\d+\.\d+.\d+' || echo "")
    if [[ -n "$seed_version" ]]; then
      pass "SEED_VERSION present: $seed_version (Rule DXS-3)"
    else
      fail "SEED_VERSION field exists but has no version string"
    fi
  else
    fail "SEED_VERSION not found in mock/index.html (Rule DXS-3)"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check 4: Version consistency between mock/app and README
  local app_version readme_version
  app_version=$(grep -oP 'v\d+\.\d+\.\d+' mock/index.html | head -1 || echo "")
  readme_version=$(grep -oP 'v\d+\.\d+\.\d+' README.md 2>/dev/null | head -1 || echo "")
  if [[ -n "$app_version" && -n "$readme_version" && "$app_version" == "$readme_version" ]]; then
    pass "Version alignment: app ($app_version) matches README ($readme_version)"
  else
    warn "Version mismatch: app='$app_version' vs README='$readme_version'"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
}

# ──────────────────────────────────────────────────────────
# Cycle 117: CI Pipeline Completeness
# ──────────────────────────────────────────────────────────
validate_ci_pipeline() {
  section "CI Pipeline Completeness (Cycle 117)"

  local ci_file="docs/ci/CI-PIPELINE-TEMPLATE.yml"

  if [[ ! -f "$ci_file" ]]; then
    fail "CI pipeline template not found at $ci_file"
    return
  fi

  pass "CI pipeline template exists"
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check required stages
  local required_stages=("lint" "security" "test" "report")
  for stage in "${required_stages[@]}"; do
    if grep -q "^  - $stage$" "$ci_file"; then
      pass "Pipeline stage present: $stage"
    else
      fail "Pipeline stage missing: $stage (required by Rule DXS-2)"
    fi
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  done

  # Check required jobs
  local required_jobs=("validate-agents-md" "csp-audit" "validate-sandbox-isolation" "sandbox-render-check")
  for job in "${required_jobs[@]}"; do
    if grep -q "^$job:" "$ci_file"; then
      pass "Pipeline job present: $job"
    else
      fail "Pipeline job missing: $job (required by Rule DXS-2)"
    fi
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  done

  # Check for artifact validation job (new, from this cycle batch)
  if grep -q "validate-artifacts" "$ci_file" 2>/dev/null; then
    pass "Artifact validation job included in CI pipeline"
  else
    warn "Artifact validation job not yet added to CI pipeline (remediation in Cycle 117)"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
}

# ──────────────────────────────────────────────────────────
# Cycle 118: Coverage Threshold Gate in CI
# ──────────────────────────────────────────────────────────
validate_coverage_gate() {
  section "Coverage Threshold Gate (Cycle 118)"

  local ci_file="docs/ci/CI-PIPELINE-TEMPLATE.yml"

  # Check if coverage gate job exists in CI
  if grep -q "coverage-gate\|coverage-threshold" "$ci_file" 2>/dev/null; then
    pass "Coverage threshold gate job exists in CI pipeline"
  else
    fail "Coverage threshold gate job missing from CI pipeline (Rule CIG-3)"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check playwright.config.js for coverage reporter
  if grep -q "html\|lcov\|json\|coverage" playwright.config.js 2>/dev/null; then
    pass "Playwright configured with coverage reporter"
  else
    fail "Playwright config missing coverage reporter (use: report: [['html'], ['lcov']] )"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Verify coverage >= 80% threshold is enforceable
  if [[ -f "coverage/lcov.info" ]]; then
    local pct
    pct=$(grep '^SF:' coverage/lcov.info 2>/dev/null | wc -l || echo "0")
    if [[ $pct -gt 0 ]]; then
      info "Coverage data files present — threshold enforcement via coverage report tooling"
      pass "Coverage data available for threshold validation"
    fi
  else
    warn "No coverage data yet — threshold gate will be effective after first test run"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
}

# ──────────────────────────────────────────────────────────
# Cycle 119: Feedback Loop Mechanism
# ──────────────────────────────────────────────────────────
validate_feedback_loop() {
  section "Feedback Loop Mechanism (Cycle 119)"

  # Check for CI badge support in README
  if grep -qi "gitlab.*badge\|gitlab-ci\.com\|pipeline.*badge\|![.*CI" README.md 2>/dev/null; then
    pass "CI badges referenced in README.md"
  else
    warn "No CI badges in README.md — consider adding GitLab pipeline status badges for instant feedback"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check for webhook/notification documentation
  if grep -qi "webhook\|notification\|slack\|email.*report" README.md docs/project/*.md 2>/dev/null; then
    pass "Notification/webhook mechanism documented"
  else
    warn "No notification mechanism found — consider GitLab CI badges or webhook for instant feedback"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check for GitLab CI auto-run on push/PR
  if grep -q "rules:" "$ci_file" 2>/dev/null; then
    pass "CI pipeline has trigger rules (push/PR-based)"
  else
    warn "CI pipeline missing trigger rules — no automatic validation on push"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Verify GitLab CI file is referenced
  if grep -qi "gitlab-ci.yml" README.md AGENTS.md 2>/dev/null; then
    pass "GitLab CI pipeline referenced in documentation"
  else
    warn "GitLab CI not referenced in participant docs — add to README.md"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
}

# ──────────────────────────────────────────────────────────
# Cycle 120: Full Artifact Suite Validation
# ──────────────────────────────────────────────────────────
validate_full_suite() {
  section "Full Artifact Suite Validation (Cycle 120)"

  # Required artifacts checklist
  local required_files=(
    "AGENTS.md"
    "BUDGET-LOG.md"
    "README.md"
    "SKILLS.md"
    "WORKSHOP-CHALLENGE.md"
    "mock/index.html"
    "playwright.config.js"
    "docs/ci/CI-PIPELINE-TEMPLATE.yml"
  )

  local missing=0
  for f in "${required_files[@]}"; do
    if [[ -f "$f" ]]; then
      pass "Artifact present: $f"
    else
      fail "Artifact missing: $f"
      missing=$((missing + 1))
    fi
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  done

  # Check docs/project directory
  if [[ -f "docs/project/R&R-CYCLE-RULES.md" ]]; then
    pass "R&R-CYCLE-RULES.md present"
  else
    fail "R&R-CYCLE-RULES.md missing"
    missing=$((missing + 1))
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Check scripts directory
  if [[ -f "scripts/validate-artifacts.sh" ]]; then
    pass "validate-artifacts.sh present"
  else
    fail "validate-artifacts.sh missing"
    missing=$((missing + 1))
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

  # Summary
  if [[ $missing -eq 0 ]]; then
    pass "All required artifacts present — suite is complete"
  else
    fail "$missing artifact(s) missing from required suite"
  fi
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
}

# ──────────────────────────────────────────────────────────
# Main dispatch
# ──────────────────────────────────────────────────────────
ci_file="docs/ci/CI-PIPELINE-TEMPLATE.yml"

if [[ $# -eq 0 ]]; then
  validate_test_plan
  validate_budget_log
  validate_coverage
  validate_security
  validate_prompt_versions
  validate_cross_artifact
  validate_ci_pipeline
  validate_coverage_gate
  validate_feedback_loop
  validate_full_suite
else
  for arg in "$@"; do
    case "$arg" in
      --test-plan)    validate_test_plan ;;
      --budget-log)   validate_budget_log ;;
      --coverage)     validate_coverage ;;
      --security)     validate_security ;;
      --format)       validate_prompt_versions ;;
      --consistency)  validate_cross_artifact ;;
      --pipeline)     validate_ci_pipeline ;;
      --coverage-gate) validate_coverage_gate ;;
      --feedback)     validate_feedback_loop ;;
      --full-suite)   validate_full_suite ;;
      --help)
        echo "Usage: $0 [--test-plan|--budget-log|--coverage|--security|--format|--consistency|--pipeline|--coverage-gate|--feedback|--full-suite]"
        echo "  (no args = validate all)"
        ;;
      *)
        echo "Unknown option: $arg. Use --help for usage."
        exit 1
        ;;
    esac
  done
fi

# ──────────────────────────────────────────────────────────
# Summary
# ──────────────────────────────────────────────────────────
printf "\n${BLUE}═══════════════════════════════════════════════════════════${NC}\n"
printf "${BLUE}  Validation Complete: ${TOTAL_CHECKS} checks, ${FAILURES} failures${NC}\n"
printf "${BLUE}═══════════════════════════════════════════════════════════${NC}\n"

if [[ $FAILURES -gt 0 ]]; then
  printf "${RED}  Status: FAILED — $FAILURES issue(s) require remediation${NC}\n"
  exit 1
else
  printf "${GREEN}  Status: PASSED — all checks successful${NC}\n"
  exit 0
fi
