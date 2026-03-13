#!/usr/bin/env bash
# run-pipeline.sh - Headless orchestration for the integration assessment pipeline
#
# Runs each of the 6 pipeline phases as independent claude -p invocations
# with gate validation and retry logic between phases.
#
# Usage: ./run-pipeline.sh [flags] <integration-name>
# Run ./run-pipeline.sh --help for full documentation.

set -euo pipefail

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------
readonly VERSION="1.0.0"
readonly MAX_RETRIES=2
readonly MIN_FILE_BYTES=100
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Auto-detect template directory (works in both hub and plugin layouts)
# Plugin layout: skills/integration-pipeline/run-pipeline.sh -> ../../templates/integration/
# Hub layout:    .claude/skills/integration-pipeline/run-pipeline.sh -> ../../../.agent/templates/integration/
detect_template_dir() {
  local plugin_path="$SCRIPT_DIR/../../templates/integration"
  local hub_path="$SCRIPT_DIR/../../../.agent/templates/integration"
  if [[ -d "$plugin_path" ]]; then
    echo "$(cd "$plugin_path" && pwd)"
  elif [[ -d "$hub_path" ]]; then
    echo "$(cd "$hub_path" && pwd)"
  else
    echo ""
  fi
}

# Find project root by walking up from CWD looking for .git or CLAUDE.md
detect_project_root() {
  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -d "$dir/.git" || -f "$dir/CLAUDE.md" ]]; then
      echo "$dir"
      return
    fi
    dir="$(dirname "$dir")"
  done
  # Fallback: use CWD
  echo "$PWD"
}

readonly TEMPLATE_DIR="$(detect_template_dir)"
readonly PROJECT_ROOT="$(detect_project_root)"

readonly PHASE_NAMES=(
  "Analyze"
  "Assess"
  "Score"
  "Design"
  "Review"
  "Summarize"
)
readonly PHASE_FILES=(
  "inventory.md"
  "assessment.md"
  "scorecard.md"
  "design.md"
  "review-report.md"
  "customer-summary.md"
)

# ---------------------------------------------------------------------------
# Defaults
# ---------------------------------------------------------------------------
MODE=""
EXPORT_PATH=""
BRIEF=""
FROM_ASSESSMENT=""
QUICK=false
SECURITY=false
OUTPUT_DIR=""
RESUME=false
MODEL="sonnet"
VERBOSE=false
DRY_RUN=false
INTEGRATION_NAME=""

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
ts() { date -u +"%Y-%m-%dT%H:%M:%SZ"; }

log() {
  local msg="$1"
  echo "$msg"
  if [[ -n "${LOG_FILE:-}" ]]; then
    echo "$msg" >> "$LOG_FILE"
  fi
}

log_phase_start() {
  local phase_num=$1 name=$2
  local line
  line="## Phase $phase_num: $name"
  log ""
  log "$line"
  log "**Started**: $(ts)"
}

log_phase_result() {
  local phase_num=$1 status=$2 file=$3
  local size=""
  if [[ "$status" == "COMPLETE" && -f "$file" ]]; then
    size=" ($(wc -c < "$file" | tr -d ' ')B)"
  fi
  log "**Status**: $status"
  if [[ -n "$size" ]]; then
    log "**Output**: $(basename "$file")$size"
  fi
  log "**Finished**: $(ts)"
}

print_progress() {
  local current=$1 status=$2
  local total=${#ACTIVE_PHASES[@]}
  local idx=1
  echo ""
  for p in "${ACTIVE_PHASES[@]}"; do
    local name="${PHASE_NAMES[$((p-1))]}"
    local file="${PHASE_FILES[$((p-1))]}"
    local st="PENDING"
    if (( p < current )); then
      st="COMPLETE"
    elif (( p == current )); then
      st="$status"
    fi
    local suffix=""
    if [[ "$st" == "COMPLETE" && -f "$OUTPUT_DIR/$file" ]]; then
      suffix=" $(basename "$file") ($(wc -c < "$OUTPUT_DIR/$file" | tr -d ' ')B)"
    fi
    printf "  [%d/%d] %-10s [%-8s]%s\n" "$idx" "$total" "$name" "$st" "$suffix"
    idx=$((idx + 1))
  done
  echo ""
}

usage() {
  cat <<'USAGE'
Usage: run-pipeline.sh [flags] <integration-name>

Run the 6-phase integration assessment pipeline in headless mode.
Each phase executes as an independent claude -p invocation with gate
validation and retry logic between phases.

Flags:
  --mode <mode>             Pipeline mode: code-first, new, existing
                            (required unless --resume)
  --export <path>           Code export path (required for code-first)
  --brief <text>            Brief description for headless assessment
                            (required for new/existing without --from-assessment)
  --from-assessment <path>  Use existing assessment file, skip Phase 2
  --quick                   Skip Phase 4 (Design) and Phase 5 (Review)
  --security                Security deep-dive in Phase 5 (Review)
  --output <dir>            Override output directory
  --resume                  Resume from first incomplete phase
  --model <model>           Model to use (default: sonnet)
  --verbose                 Print full claude output
  --dry-run                 Show planned phases without executing
  --help                    Show this help message

Exit Codes:
   0     All phases completed successfully
   1     Invalid arguments
   2     Missing dependency (claude CLI not found)
  10-16  Phase 1-6 execution failure (after retry)
  20-26  Phase 1-6 gate validation failure (after retries)

Examples:
  # Full pipeline from code export
  ./run-pipeline.sh --mode code-first --export /path/to/export customer-sync

  # New integration with a brief description
  ./run-pipeline.sh --mode new --brief "Salesforce-SAP customer sync" salesforce-sap

  # Quick score (skip design + review)
  ./run-pipeline.sh --quick --mode new --brief "Quick score needed" my-integration

  # Resume after interruption
  ./run-pipeline.sh --resume customer-sync

  # Dry run to preview phases
  ./run-pipeline.sh --dry-run --mode new --brief "Test" test-run
USAGE
}

# ---------------------------------------------------------------------------
# Argument Parsing
# ---------------------------------------------------------------------------
parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --mode)
        MODE="$2"; shift 2 ;;
      --export)
        EXPORT_PATH="$2"; shift 2 ;;
      --brief)
        BRIEF="$2"; shift 2 ;;
      --from-assessment)
        FROM_ASSESSMENT="$2"; shift 2 ;;
      --quick)
        QUICK=true; shift ;;
      --security)
        SECURITY=true; shift ;;
      --output)
        OUTPUT_DIR="$2"; shift 2 ;;
      --resume)
        RESUME=true; shift ;;
      --model)
        MODEL="$2"; shift 2 ;;
      --verbose)
        VERBOSE=true; shift ;;
      --dry-run)
        DRY_RUN=true; shift ;;
      --help|-h)
        usage; exit 0 ;;
      -*)
        echo "Error: Unknown flag: $1" >&2
        echo "Run with --help for usage." >&2
        exit 1 ;;
      *)
        if [[ -z "$INTEGRATION_NAME" ]]; then
          INTEGRATION_NAME="$1"
        else
          echo "Error: Unexpected argument: $1" >&2
          exit 1
        fi
        shift ;;
    esac
  done
}

validate_args() {
  # Integration name is always required
  if [[ -z "$INTEGRATION_NAME" ]]; then
    echo "Error: <integration-name> is required." >&2
    echo "Run with --help for usage." >&2
    exit 1
  fi

  # Check claude CLI
  if ! command -v claude &>/dev/null; then
    echo "Error: 'claude' CLI not found in PATH." >&2
    exit 2
  fi

  # Verify templates were found
  if [[ -z "$TEMPLATE_DIR" ]]; then
    echo "Error: Could not locate integration templates directory." >&2
    echo "  Searched: $SCRIPT_DIR/../../templates/integration/ (plugin layout)" >&2
    echo "  Searched: $SCRIPT_DIR/../../../.agent/templates/integration/ (hub layout)" >&2
    exit 1
  fi

  # Set default output dir
  if [[ -z "$OUTPUT_DIR" ]]; then
    OUTPUT_DIR="$PROJECT_ROOT/.agent/tasks/integration-$INTEGRATION_NAME"
  fi

  # Resume mode: infer what we can from existing directory
  if $RESUME; then
    if [[ ! -d "$OUTPUT_DIR" ]]; then
      echo "Error: Output directory does not exist for --resume: $OUTPUT_DIR" >&2
      exit 1
    fi
    # Try to detect mode from pipeline-log.md
    if [[ -z "$MODE" && -f "$OUTPUT_DIR/pipeline-log.md" ]]; then
      local detected
      detected=$(grep -oP '(?<=\*\*Mode\*\*: )\S+' "$OUTPUT_DIR/pipeline-log.md" 2>/dev/null || true)
      if [[ -n "$detected" ]]; then
        MODE="$detected"
      fi
    fi
    if [[ -z "$MODE" ]]; then
      # Infer from presence of inventory.md
      if [[ -f "$OUTPUT_DIR/inventory.md" ]]; then
        MODE="code-first"
      else
        MODE="new"
      fi
    fi
    return
  fi

  # Mode is required when not resuming
  if [[ -z "$MODE" ]]; then
    echo "Error: --mode is required (code-first, new, or existing)." >&2
    exit 1
  fi

  case "$MODE" in
    code-first)
      if [[ -z "$EXPORT_PATH" ]]; then
        echo "Error: --export <path> is required for code-first mode." >&2
        exit 1
      fi
      if [[ ! -e "$EXPORT_PATH" ]]; then
        echo "Error: Export path does not exist: $EXPORT_PATH" >&2
        exit 1
      fi
      ;;
    new|existing)
      if [[ -z "$FROM_ASSESSMENT" && -z "$BRIEF" ]]; then
        echo "Error: Either --brief or --from-assessment is required for $MODE mode." >&2
        echo "  Phase 2 (Assessment) cannot run interactively in headless mode." >&2
        echo "  Provide --brief \"description\" for an auto-generated assessment," >&2
        echo "  or --from-assessment path/to/assessment.md to use an existing one." >&2
        exit 1
      fi
      if [[ -n "$FROM_ASSESSMENT" && ! -f "$FROM_ASSESSMENT" ]]; then
        echo "Error: Assessment file not found: $FROM_ASSESSMENT" >&2
        exit 1
      fi
      ;;
    *)
      echo "Error: Invalid mode '$MODE'. Must be code-first, new, or existing." >&2
      exit 1 ;;
  esac
}

# ---------------------------------------------------------------------------
# Output Directory
# ---------------------------------------------------------------------------
setup_output_dir() {
  mkdir -p "$OUTPUT_DIR"
  LOG_FILE="$OUTPUT_DIR/pipeline-log.md"

  if ! $RESUME; then
    cat > "$LOG_FILE" <<EOF
# Pipeline Log: $INTEGRATION_NAME
**Started**: $(ts)
**Mode**: $MODE
**Model**: $MODEL
**Quick**: $QUICK
**Security**: $SECURITY
EOF
  else
    log ""
    log "---"
    log "# Resumed: $(ts)"
  fi
}

# ---------------------------------------------------------------------------
# Phase Selection
# ---------------------------------------------------------------------------
ACTIVE_PHASES=()

determine_phases() {
  ACTIVE_PHASES=()

  case "$MODE" in
    code-first) ACTIVE_PHASES+=(1) ;;
  esac

  # Phase 2: skip if --from-assessment is provided
  if [[ -z "$FROM_ASSESSMENT" ]]; then
    ACTIVE_PHASES+=(2)
  fi

  ACTIVE_PHASES+=(3)

  if ! $QUICK; then
    ACTIVE_PHASES+=(4 5)
  fi

  ACTIVE_PHASES+=(6)
}

determine_start_phase() {
  if ! $RESUME; then
    return
  fi

  local new_active=()
  local found_incomplete=false

  for p in "${ACTIVE_PHASES[@]}"; do
    if $found_incomplete; then
      new_active+=("$p")
      continue
    fi

    local file="${PHASE_FILES[$((p-1))]}"
    local filepath="$OUTPUT_DIR/$file"

    if [[ -f "$filepath" ]] && validate_gate_quiet "$p"; then
      log "  Phase $p (${PHASE_NAMES[$((p-1))]}): COMPLETE - skipping"
    else
      found_incomplete=true
      new_active+=("$p")
    fi
  done

  if [[ ${#new_active[@]} -eq 0 ]]; then
    log "All phases already complete. Nothing to resume."
    exit 0
  fi

  ACTIVE_PHASES=("${new_active[@]}")
  log "Resuming from Phase ${ACTIVE_PHASES[0]} (${PHASE_NAMES[$((ACTIVE_PHASES[0]-1))]})"
}

# ---------------------------------------------------------------------------
# Gate Validation
# ---------------------------------------------------------------------------
# Returns the list of missing sections (empty string if all present)
check_sections() {
  local file=$1
  shift
  local patterns=("$@")
  local missing=()

  for pattern in "${patterns[@]}"; do
    if ! grep -qiE "$pattern" "$file" 2>/dev/null; then
      missing+=("$pattern")
    fi
  done

  echo "${missing[*]}"
}

validate_gate() {
  local phase=$1
  local file="$OUTPUT_DIR/${PHASE_FILES[$((phase-1))]}"
  local missing_sections=""
  local errors=()

  # Check file exists and has minimum content
  if [[ ! -f "$file" ]]; then
    errors+=("Output file not found: $(basename "$file")")
    echo "${errors[*]}"
    return 1
  fi

  local size
  size=$(wc -c < "$file" | tr -d ' ')
  if (( size < MIN_FILE_BYTES )); then
    errors+=("Output file too small: ${size}B (minimum ${MIN_FILE_BYTES}B)")
    echo "${errors[*]}"
    return 1
  fi

  # Check for agent failure indicators in first 5 lines
  local head5
  head5=$(head -5 "$file")
  if echo "$head5" | grep -qiE '(^ERROR|I cannot|I apologize|I am unable)'; then
    errors+=("Agent failure detected in output header")
    echo "${errors[*]}"
    return 1
  fi

  # Phase-specific section checks
  case $phase in
    1) missing_sections=$(check_sections "$file" \
         "^#+ .*Connections" "^#+ .*Schemas" "^#+ .*Field Mappings|^#+ .*Mappings") ;;
    2) missing_sections=$(check_sections "$file" \
         "^#+ .*Executive Summary" "^#+ .*Dimension") ;;
    3) missing_sections=$(check_sections "$file" \
         "^#+ .*Dimension Scores|^#+ .*Per.Dimension" "^#+ .*Red Flags" "^#+ .*Quick Wins") ;;
    4) missing_sections=$(check_sections "$file" \
         "^#+ .*Architecture|^#+ .*Roadmap" "^#+ .*Data" "^#+ .*Error Handling") ;;
    5) missing_sections=$(check_sections "$file" \
         "^#+ .*Critical Findings|^#+ .*High Findings|^#+ .*Findings" "^#+ .*Approval Status") ;;
    6) missing_sections=$(check_sections "$file" \
         "^#+ .*Executive Summary" "^#+ .*Key Findings|^#+ .*Findings") ;;
  esac

  if [[ -n "$missing_sections" ]]; then
    echo "Missing sections: $missing_sections"
    return 1
  fi

  return 0
}

# Quiet version for resume detection - same checks, no output
validate_gate_quiet() {
  local phase=$1
  local file="$OUTPUT_DIR/${PHASE_FILES[$((phase-1))]}"

  [[ -f "$file" ]] || return 1

  local size
  size=$(wc -c < "$file" | tr -d ' ')
  (( size >= MIN_FILE_BYTES )) || return 1

  local head5
  head5=$(head -5 "$file")
  if echo "$head5" | grep -qiE '(^ERROR|I cannot|I apologize|I am unable)'; then
    return 1
  fi

  local missing
  case $phase in
    1) missing=$(check_sections "$file" \
         "^#+ .*Connections" "^#+ .*Schemas" "^#+ .*Field Mappings|^#+ .*Mappings") ;;
    2) missing=$(check_sections "$file" \
         "^#+ .*Executive Summary" "^#+ .*Dimension") ;;
    3) missing=$(check_sections "$file" \
         "^#+ .*Dimension Scores|^#+ .*Per.Dimension" "^#+ .*Red Flags" "^#+ .*Quick Wins") ;;
    4) missing=$(check_sections "$file" \
         "^#+ .*Architecture|^#+ .*Roadmap" "^#+ .*Data" "^#+ .*Error Handling") ;;
    5) missing=$(check_sections "$file" \
         "^#+ .*Critical Findings|^#+ .*High Findings|^#+ .*Findings" "^#+ .*Approval Status") ;;
    6) missing=$(check_sections "$file" \
         "^#+ .*Executive Summary" "^#+ .*Key Findings|^#+ .*Findings") ;;
  esac

  [[ -z "$missing" ]]
}

# ---------------------------------------------------------------------------
# Claude Invocation
# ---------------------------------------------------------------------------
run_claude() {
  local prompt="$1"
  local log_file="$2"

  # Required for nested invocation - prevent CLAUDECODE env var interference
  unset CLAUDECODE 2>/dev/null || true

  local exit_code=0
  if $VERBOSE; then
    claude -p "$prompt" \
      --model "$MODEL" \
      --permission-mode bypassPermissions \
      --allowedTools "Read,Write,Grep,Glob,Task,WebFetch" \
      --no-session-persistence \
      2>&1 | tee "$log_file" || exit_code=$?
  else
    claude -p "$prompt" \
      --model "$MODEL" \
      --permission-mode bypassPermissions \
      --allowedTools "Read,Write,Grep,Glob,Task,WebFetch" \
      --no-session-persistence \
      > "$log_file" 2>&1 || exit_code=$?
  fi

  return $exit_code
}

# ---------------------------------------------------------------------------
# Prompt Builders
# ---------------------------------------------------------------------------
build_prompt_phase1() {
  cat <<PROMPT
You are running Phase 1 (Analyze) of an integration assessment pipeline.

**Integration**: $INTEGRATION_NAME
**Working Directory**: $OUTPUT_DIR

**Templates to load** (Read these before parsing):
- $TEMPLATE_DIR/extraction-guide.md (universal extraction checklist)
- $TEMPLATE_DIR/inventory-document.md (expected output structure)
- After detecting the platform, also read: $TEMPLATE_DIR/platform-parsers/[platform].md

**Task**: Parse the code export at $EXPORT_PATH using this workflow:

1. **Detect Platform** - Glob scan for file patterns:
   - Workato: .json files with "adapter" and "action" keys
   - Talend: .item files, talend.properties, /process/ directory
   - MuleSoft: mule-artifact.json, .xml with <mule> root, .dwl files
   - Boomi: Component XML with <bns:Component> namespace

2. **Scan & Parse** - Glob all relevant files, Read each to extract:
   - Connections (source/target systems, connectors, auth type)
   - Schemas (input/output field definitions with types)
   - Field mappings (field-to-field with transformation type)
   - Error handling (try-catch, retry, DLQ config)
   - Sub-job/recipe calls with parameters

3. **Build Call Graph** - Grep for inter-job/recipe references:
   - Workato: "call_recipe" / "recipe_function"
   - Talend: "tRunJob" componentName in .item files

4. **Trace Data Journey** - Follow call graph depth-first from entry points, track fields through transformations

5. **Flag Issues** - Hardcoded values, missing error handling/logging, circular dependencies

6. **Classify Confidence** - HIGH (code confirms), MEDIUM (code implies), LOW (runtime only)

**Critical constraints**:
- Never fabricate field mappings or schemas - only document what's in the code
- Code shows WHAT, not WHY - flag as "Code shows [X], intent unclear"
- If 2-3 parsing approaches fail for a file type, flag as "Requires manual review" and move on
- Recipes/jobs are source of truth over config files (configs may be stale)

Add this note before the summary: "This inventory reflects static analysis only. Findings marked MEDIUM or LOW confidence should be verified with runtime data and a domain owner walkthrough before scoring."

**Output**: Write your complete output to $OUTPUT_DIR/inventory.md

**Critical**: Your output MUST include these sections with content:
- ## Connections (or similar heading with connection details)
- ## Schemas (or similar heading with schema definitions)
- ## Field Mappings (or ## Mappings - with field-level mapping details)
PROMPT
}

build_prompt_phase2() {
  local inventory_context=""
  if [[ -f "$OUTPUT_DIR/inventory.md" ]]; then
    inventory_context="- $OUTPUT_DIR/inventory.md (code analysis inventory from Phase 1)"
  fi

  cat <<PROMPT
You are running Phase 2 (Assess) of an integration assessment pipeline in HEADLESS mode.

**Integration**: $INTEGRATION_NAME
**Working Directory**: $OUTPUT_DIR
**Template**: Read $TEMPLATE_DIR/assessment-document.md for the expected output structure.

**Input files** (read these if they exist):
$inventory_context

**Integration Brief**: $BRIEF

**Task**: Generate a headless assessment based on available context. Use the integration brief and any inventory data to populate the 8 integration dimensions as completely as possible. For any dimensions where information is insufficient, explicitly mark them as "UNKNOWN - requires further discovery" rather than guessing. Produce a structured assessment document.

**Output**: Write your complete output to $OUTPUT_DIR/assessment.md

**Critical**: Your output MUST include these sections with content:
- ## Executive Summary
- ## Dimension Assessments (or individual dimension sections covering all 8 dimensions)
PROMPT
}

build_prompt_phase3() {
  local inventory_context=""
  if [[ -f "$OUTPUT_DIR/inventory.md" ]]; then
    inventory_context="- $OUTPUT_DIR/inventory.md (code analysis inventory from Phase 1)"
  fi

  cat <<PROMPT
You are running Phase 3 (Score) of an integration assessment pipeline.

**Integration**: $INTEGRATION_NAME
**Working Directory**: $OUTPUT_DIR
**Template**: Read $TEMPLATE_DIR/scorecard-template.md for the expected output structure.
**Rubric**: Read $TEMPLATE_DIR/scoring-rubric.md for the scoring criteria.

**Input files** (read these first):
- $OUTPUT_DIR/assessment.md (assessment from Phase 2)
$inventory_context

**Task**: Score this integration using this workflow:

1. **Classify Input Quality** - Determine what evidence is available and add classification as the FIRST line of the scorecard:
   - Description only (no assessment/inventory): "PRELIMINARY - Description Only" (LOW confidence cap)
   - Assessment from interview (no code/runtime): "ASSESSMENT-BASED" (MEDIUM max confidence)
   - Assessment + code inventory (no runtime): "STATIC ANALYSIS" (HIGH for code-confirmed)
   - Assessment + runtime data (logs, metrics): "RUNTIME-VALIDATED" (HIGH on all supported)

2. **Score Each Dimension** - Apply the rubric to score all 8 dimensions 1-5. For each:
   - Score based on evidence, not potential or intentions
   - Use the lowest applicable score when criteria span multiple levels
   - Document the specific evidence supporting each score
   - Mark confidence: HIGH (direct evidence), MEDIUM (inferred), LOW (assumed/unknown)

3. **Calculate Overall Score** using weighted average:
   Overall = (Arch*2 + Data*2 + OpEx*3 + Reliability*3 + Security*3 + Business*1.5 + Maintain*1.5 + Platform*1) / 17

4. **Map to Maturity Level**:
   4.5-5.0 = Augmented, 3.5-4.4 = Balanced, 2.5-3.4 = Centralized, 1.5-2.4 = Enlightened, 1.0-1.4 = Ad hoc

5. **Identify Red Flags** (any dimension 1.0-1.5 AND weighted CRITICAL/HIGH) and **Quick Wins** (improvements <1 day that raise a dimension by 0.5+)

6. **Runtime Validation Required Table** - List which dimensions and scores would change with runtime data, expected direction, and what data is needed. This is critical because static analysis scores can swing 10%+ after runtime enrichment.

**Output**: Write your complete output to $OUTPUT_DIR/scorecard.md

**Critical**: Your output MUST include these sections with content:
- ## Dimension Scores (or ## Per-Dimension Scores)
- ## Red Flags
- ## Quick Wins
PROMPT
}

build_prompt_phase4() {
  local design_type design_template design_approach
  if [[ "$MODE" == "new" ]]; then
    design_type="New Architecture"
    design_template="$TEMPLATE_DIR/design-document.md"
    design_approach="1. Analyze requirements from assessment
2. Select pattern from pattern library (justify choice, state alternatives rejected)
3. Design data model (canonical, mappings, validation)
4. Design flows (normal + error paths)
5. Define NFRs (error handling, monitoring, security, resilience)
6. Phase the implementation (MVP -> hardening -> optimization)"
  else
    design_type="Improvement Roadmap"
    design_template="$TEMPLATE_DIR/improvement-roadmap.md"
    design_approach="1. Analyze gaps from scorecard (dimensions below target)
2. Prioritize: Critical (security, reliability) -> High (ops, data) -> Medium (maintainability)
3. Phase: Critical fixes (1-2 weeks) -> Quick wins (2-6 weeks) -> Strategic (1-3 months) -> Optimization (ongoing)
4. Define migration strategy (zero-downtime where possible)
5. Set milestones and success criteria per phase"
  fi

  cat <<PROMPT
You are running Phase 4 (Design) of an integration assessment pipeline.

**Integration**: $INTEGRATION_NAME
**Working Directory**: $OUTPUT_DIR
**Design Type**: $design_type

**Templates to load** (Read these before designing):
- $design_template (output structure)
- $TEMPLATE_DIR/pattern-library.md (pattern selection reference)
- $TEMPLATE_DIR/design-quality-checklist.md (validation before delivery)

**Input files** (read these first):
- $OUTPUT_DIR/assessment.md (assessment from Phase 2)
- $OUTPUT_DIR/scorecard.md (scorecard from Phase 3)

**Design Approach**:
$design_approach

**Action Item Classification** - Every recommendation must be classified:
- SOLO: Implementable directly from the design document and existing code/documentation alone
- PAIR: Requires domain owner present - undocumented runtime behavior, live system state, business rules not in code
- Why: PAIR items attempted as SOLO have a 43% false positive rate. A 30-minute walkthrough prevents days of rework. When uncertain, default to PAIR.
- Format: [Phase X.Y] Action title - [SOLO|PAIR] - Verify: [specific check]

**Quality Validation** before writing output:
- All 8 dimensions from assessment are addressed
- Security findings are phased as feature work (Phase 1 critical tier), not "later enhancements"
- Each phase has clear exit criteria
- Check against design-quality-checklist.md

**Critical constraints**:
- Lead with complete approach (pattern choice, phases, trade-offs) before diving into details
- Design for actual requirements, not theoretical ideals - acknowledge budget/timeline/skills constraints
- Never fabricate platform capabilities - if uncertain: "Verify with [Platform] documentation"
- Provide patterns and approaches, not platform-specific implementation code

**Output**: Write your complete output to $OUTPUT_DIR/design.md

**Critical**: Your output MUST include these sections with content:
- ## Architecture Pattern (or ## Roadmap for existing integrations)
- ## Data Design (or ## Data Flows or similar data section)
- ## Error Handling
PROMPT
}

build_prompt_phase5() {
  local security_context=""
  if $SECURITY; then
    security_context="**Security Focus**: Perform a security deep-dive including OWASP API Top 10 analysis, encryption validation, authentication pattern review, and audit logging assessment."
  fi

  cat <<PROMPT
You are running Phase 5 (Review) of an integration assessment pipeline.

**Integration**: $INTEGRATION_NAME
**Working Directory**: $OUTPUT_DIR
**Template**: Read $TEMPLATE_DIR/review-report-template.md for the expected output structure.

**Input files** (read these first):
- $OUTPUT_DIR/design.md (design from Phase 4)
- $OUTPUT_DIR/assessment.md (assessment from Phase 2)

$security_context

**Task**: Validate the design against best practices and the 8-dimension integration framework. Classify findings as Critical, High, Medium, or Low severity. Check for architectural anti-patterns, security gaps, and missing error handling. Produce a clear approval status (Approved, Conditionally Approved, or Not Approved).

**Output**: Write your complete output to $OUTPUT_DIR/review-report.md

**Critical**: Your output MUST include these sections with content:
- ## Critical Findings or ## High Findings or ## Findings (with severity-classified items)
- ## Approval Status
PROMPT
}

build_prompt_phase6() {
  local input_files="- $OUTPUT_DIR/assessment.md (assessment)\n- $OUTPUT_DIR/scorecard.md (scorecard)"
  if [[ -f "$OUTPUT_DIR/design.md" ]]; then
    input_files="$input_files\n- $OUTPUT_DIR/design.md (design)"
  fi
  if [[ -f "$OUTPUT_DIR/review-report.md" ]]; then
    input_files="$input_files\n- $OUTPUT_DIR/review-report.md (review report)"
  fi

  cat <<PROMPT
You are running Phase 6 (Summarize) of an integration assessment pipeline.

**Integration**: $INTEGRATION_NAME
**Working Directory**: $OUTPUT_DIR
**Template**: Read $TEMPLATE_DIR/customer-summary-template.md for the expected output structure.

**Input files** (read these first):
$(echo -e "$input_files")

**Task**: Generate a customer-facing summary document.

**Score Translation Table** - Use these prescribed labels when translating scores:
| Score Range | Internal Label | Customer-Facing Label |
|-------------|---------------|----------------------|
| 4.5 - 5.0 | Augmented | Industry-Leading |
| 3.5 - 4.4 | Balanced | Well-Established |
| 2.5 - 3.4 | Centralized | Progressing |
| 1.5 - 2.4 | Enlightened | Early-Stage |
| 1.0 - 1.4 | Ad hoc | Foundation-Building |

**Guidelines**:
- Present findings as improvement opportunities, not criticisms
- List strengths before recommendations
- Structure as: Executive Summary -> Key Findings -> Recommended Next Steps
- Exclude internal scoring notes and raw technical details
- Use business language throughout (no jargon without explanation)

**Output**: Write your complete output to $OUTPUT_DIR/customer-summary.md

**Critical**: Your output MUST include these sections with content:
- ## Executive Summary
- ## Key Findings (or ## Findings)
PROMPT
}

build_prompt() {
  local phase=$1
  case $phase in
    1) build_prompt_phase1 ;;
    2) build_prompt_phase2 ;;
    3) build_prompt_phase3 ;;
    4) build_prompt_phase4 ;;
    5) build_prompt_phase5 ;;
    6) build_prompt_phase6 ;;
  esac
}

augment_prompt() {
  local original_prompt="$1"
  local missing="$2"
  cat <<PROMPT
$original_prompt

IMPORTANT: A previous attempt at this phase produced output that was missing required sections: $missing
You MUST include ALL required sections listed above. Double-check your output before finishing.
PROMPT
}

# ---------------------------------------------------------------------------
# Phase Execution
# ---------------------------------------------------------------------------
run_phase() {
  local phase=$1
  local phase_name="${PHASE_NAMES[$((phase-1))]}"
  local output_file="$OUTPUT_DIR/${PHASE_FILES[$((phase-1))]}"
  local phase_log="$OUTPUT_DIR/phase-${phase}-output.log"

  log_phase_start "$phase" "$phase_name"
  print_progress "$phase" "RUNNING"

  # Handle Phase 2 with --from-assessment
  if (( phase == 2 )) && [[ -n "$FROM_ASSESSMENT" ]]; then
    log "Using existing assessment: $FROM_ASSESSMENT"
    cp "$FROM_ASSESSMENT" "$output_file"
    log_phase_result "$phase" "COMPLETE" "$output_file"
    return 0
  fi

  local prompt
  prompt=$(build_prompt "$phase")

  if $DRY_RUN; then
    log "[DRY RUN] Would execute claude -p with model=$MODEL"
    log "[DRY RUN] Output: $output_file"
    log_phase_result "$phase" "SKIPPED (dry-run)" "$output_file"
    return 0
  fi

  # Execution with retry on claude failure
  local attempt=1
  local max_exec_attempts=2
  local exec_exit=0

  while (( attempt <= max_exec_attempts )); do
    exec_exit=0
    local start_time=$SECONDS
    run_claude "$prompt" "$phase_log" || exec_exit=$?
    local duration=$(( SECONDS - start_time ))
    log "**Duration**: ${duration}s"

    if (( exec_exit == 0 )); then
      break
    fi

    log "**Error**: claude exited with code $exec_exit (attempt $attempt/$max_exec_attempts)"
    if (( attempt >= max_exec_attempts )); then
      log "**Status**: FAILED (execution)"
      log_phase_result "$phase" "FAILED" "$output_file"
      return $(( 10 + phase ))
    fi
    attempt=$((attempt + 1))
    log "Retrying..."
  done

  # Gate validation with retry
  local gate_attempt=0
  while (( gate_attempt <= MAX_RETRIES )); do
    local gate_result
    gate_result=$(validate_gate "$phase") && {
      log_phase_result "$phase" "COMPLETE" "$output_file"
      print_progress "$phase" "COMPLETE"
      return 0
    }

    gate_attempt=$((gate_attempt + 1))
    if (( gate_attempt > MAX_RETRIES )); then
      log "**Status**: FAILED (gate validation after $MAX_RETRIES retries)"
      log "**Gate Failure**: $gate_result"
      log_phase_result "$phase" "FAILED (gate)" "$output_file"
      return $(( 20 + phase ))
    fi

    log "**Gate Check**: FAILED (attempt $gate_attempt/$((MAX_RETRIES + 1)))"
    log "**Missing**: $gate_result"
    log "Retrying with augmented prompt..."

    local augmented
    augmented=$(augment_prompt "$prompt" "$gate_result")
    local retry_exit=0
    local start_time=$SECONDS
    run_claude "$augmented" "$phase_log" || retry_exit=$?
    local duration=$(( SECONDS - start_time ))
    log "**Duration**: ${duration}s"

    if (( retry_exit != 0 )); then
      log "**Error**: claude exited with code $retry_exit during retry"
    fi
  done

  # Should not reach here, but safety net
  log_phase_result "$phase" "FAILED" "$output_file"
  return $(( 20 + phase ))
}

# ---------------------------------------------------------------------------
# Pipeline Runner
# ---------------------------------------------------------------------------
run_pipeline() {
  for phase in "${ACTIVE_PHASES[@]}"; do
    local result=0
    run_phase "$phase" || result=$?
    if (( result != 0 )); then
      log ""
      log "Pipeline stopped at Phase $phase (${PHASE_NAMES[$((phase-1))]})"
      log "Exit code: $result"
      return $result
    fi
  done
  return 0
}

print_summary() {
  local exit_code=$1
  log ""
  log "---"
  log "## Summary"
  log "**Finished**: $(ts)"

  if (( exit_code == 0 )); then
    log "**Result**: All phases completed successfully"
    log ""
    log "Output files:"
    for p in "${ACTIVE_PHASES[@]}"; do
      local file="$OUTPUT_DIR/${PHASE_FILES[$((p-1))]}"
      if [[ -f "$file" ]]; then
        log "  - $(basename "$file") ($(wc -c < "$file" | tr -d ' ')B)"
      fi
    done
  else
    log "**Result**: Pipeline failed (exit code $exit_code)"
    if (( exit_code >= 20 )); then
      local failed_phase=$((exit_code - 20))
      log "**Failed Phase**: $failed_phase (${PHASE_NAMES[$((failed_phase-1))]}) - gate validation"
    elif (( exit_code >= 10 )); then
      local failed_phase=$((exit_code - 10))
      log "**Failed Phase**: $failed_phase (${PHASE_NAMES[$((failed_phase-1))]}) - execution failure"
    fi
    log ""
    log "To resume: ./run-pipeline.sh --resume $INTEGRATION_NAME"
  fi

  log ""
  log "**Output Directory**: $OUTPUT_DIR"
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
  parse_args "$@"
  validate_args
  setup_output_dir

  log ""
  log "# Integration Pipeline: $INTEGRATION_NAME"
  log "**Mode**: $MODE"
  log "**Output**: $OUTPUT_DIR"

  determine_phases

  # Handle --from-assessment: copy file early so resume can detect it
  if [[ -n "$FROM_ASSESSMENT" && ! -f "$OUTPUT_DIR/assessment.md" ]]; then
    cp "$FROM_ASSESSMENT" "$OUTPUT_DIR/assessment.md"
    log "Copied assessment from: $FROM_ASSESSMENT"
  fi

  if $RESUME; then
    log ""
    log "Checking existing phase outputs..."
    determine_start_phase
  fi

  if $DRY_RUN; then
    log ""
    log "**DRY RUN** - showing planned phases without executing"
  fi

  log ""
  log "Active phases: ${ACTIVE_PHASES[*]}"

  local result=0
  run_pipeline || result=$?
  print_summary "$result"

  exit "$result"
}

main "$@"
