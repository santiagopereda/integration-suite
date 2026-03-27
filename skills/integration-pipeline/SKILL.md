---
name: integration-pipeline
description: End-to-end integration assessment pipeline - single entry point for all integration work. Run the full 6-phase pipeline or target individual phases with --phase.
disable-model-invocation: true
---

# /integration-pipeline - Integration Assessment Pipeline

Single entry point for all integration assessment work. Run the full 6-phase pipeline or target individual phases.

## Quick Reference

| Aspect | Details |
|--------|---------|
| **Invocation** | `/integration-pipeline [options] <integration-name>` |
| **Output** | Complete assessment package in `.agent/tasks/integration-{name}/` |
| **Phases** | Analyze, Assess, Score, Design, Review, Summarize |

## Modes

| Mode | Starts At | Use When |
|------|-----------|----------|
| `code-first` | Phase 1 (Analyze) | You have a code export to parse first |
| `new` | Phase 2 (Assess) | New integration requirements |
| `existing` | Phase 2 (Assess) | Evaluating an existing integration |

**Auto-detection**: If a path argument is provided, defaults to `code-first`. Otherwise defaults to `new`.

### Mode-Phase Matrix

| Phase | code-first | new | existing |
|-------|-----------|-----|----------|
| 1. Analyze | RUN | SKIP | SKIP |
| 2. Assess | RUN | RUN | RUN |
| 3. Score | RUN | RUN | RUN |
| 4. Design | RUN | RUN | RUN |
| 5. Review | RUN | RUN | RUN |
| 6. Summarize | RUN | RUN | RUN |

Phase 1 only runs in `code-first` mode. Adding `--quick` additionally skips Phases 4 and 5 regardless of mode.

## Usage

```bash
# Full pipeline from code export
/integration-pipeline --mode code-first /path/to/export customer-sync

# New integration assessment (skip code analysis)
/integration-pipeline --mode new salesforce-sap-sync

# Quick pipeline (skip design + review phases)
/integration-pipeline --quick --mode existing order-processing

# With security deep-dive in review phase
/integration-pipeline --security --mode new pii-data-integration
```

### Standalone Phase Usage

Run individual phases with `--phase` for targeted work:

```bash
# Analyze only
/integration-pipeline --phase analyze /path/to/export

# Score from an existing assessment
/integration-pipeline --phase score --from-file assessment.md

# Review with security deep-dive
/integration-pipeline --phase review --from-file design.md --security

# Generate customer summary
/integration-pipeline --phase summarize --from-file scorecard.md
```

## Flags

| Flag | Description |
|------|-------------|
| `--mode <mode>` | Override auto-detection: `code-first`, `new`, `existing` |
| `--phase <phase>` | Run a single phase: `analyze`, `assess`, `score`, `design`, `review`, `summarize` |
| `--from-file <path>` | Input file for standalone phase (previous phase output) |
| `--quick` | Skip Phase 4 (Design) and Phase 5 (Review) |
| `--security` | Add security deep-dive in Phase 5 (Review) |
| `--output <dir>` | Override output directory (default: `.agent/tasks/integration-{name}/`) |

## Pipeline Phases

```
Phase 1    Phase 2      Phase 3    Phase 4    Phase 5     Phase 6
ANALYZE -> ASSESS    -> SCORE   -> DESIGN  -> REVIEW  -> SUMMARIZE
  |          |           |          |          |           |
  v          v           v          v          v           v
inventory  assessment  scorecard  design    review     customer
  .md        .md         .md       .md      report.md  summary.md
[SKIP]                            [SKIP]   [SKIP]
new/existing                      --quick  --quick
```

### Phase 1: Analyze (code-first mode only)

**Runs inline** (no agent delegation - uses Read, Grep, Glob directly)
**Input**: Path to code export
**Output**: `inventory.md`

#### Step-by-step workflow

1. **Detect Platform** - Glob scan for file patterns, auto-detect:
   - **Workato**: `.json` files with `"adapter"` and `"action"` keys
   - **Talend**: `.item` files, `talend.properties`, `/process/` directory
   - **MuleSoft**: `mule-artifact.json`, `.xml` with `<mule>` root, `.dwl` files
   - **Boomi**: Component XML with `<bns:Component>` namespace

2. **Load Templates** - Read these before parsing:
   - `.agent/templates/integration/extraction-guide.md` (universal checklist)
   - `.agent/templates/integration/inventory-document.md` (output structure)
   - Platform-specific parser guide(s):
     - **Talend DI**: `platform-parsers/talend.md` + `platform-parsers/talend-jobs.md`
     - **Talend ESB**: `platform-parsers/talend.md` + `platform-parsers/talend-jobs.md` + `platform-parsers/talend-routes.md`
     - **Workato**: `platform-parsers/workato.md`
   - Detect workspace type for Talend: check for `routes/` directory to determine DI vs ESB

3. **Scan & Parse** - Glob to find all relevant files, Read to parse each:
   - Connections: source/target systems, connectors, auth type
   - Schemas: input/output field definitions with types
   - Mappings: field-to-field with transformation type
   - Error handling: try-catch, retry, DLQ config
   - Sub-job/recipe calls with parameters passed

4. **Build Call Graph** - Grep for inter-job/recipe references:
   - Workato: `"call_recipe"` / `"recipe_function"` across recipes
   - Talend: `"tRunJob"` componentName across `.item` files; for ESB also `"cTalendJob"` in routes
   - Result: dependency graph (parent -> [children])

5. **Trace Data Journey** - Follow call graph depth-first from entry points:
   - Track data fields through each transformation step
   - Track context/variables passed between jobs
   - Map complete source-to-target data flow

6. **Flag Issues** - Check for:
   - Hardcoded endpoints, credentials, magic numbers
   - Missing error handling, logging, idempotency
   - Complex transformations without documentation
   - Circular dependencies

7. **Classify Confidence** - For each finding:
   - **HIGH**: Code directly confirms (hardcoded value, missing component)
   - **MEDIUM**: Code implies but cannot confirm (structural intent)
   - **LOW**: Cannot determine from code alone (scheduling, error rates, runtime routing)

#### Output modes

- **Brief** (~500-1,000 words): Connections, schemas, key mappings, top-level observations. Trigger: "quick analysis", "what connectors", "summary"
- **Standard** (~2,000-4,000 words): Full inventory with all sections and data journey map. DEFAULT.
- **Detailed** (~4,000-8,000 words): Full inventory + all sub-flows + every transformation + file manifest.

#### Critical constraints
- **Never fabricate** field mappings or schemas - only document what's in the code
- **Code shows WHAT, not WHY** - flag findings as "Code shows [X], intent unclear"
- **Stop when parsing fails repeatedly** - if 2-3 approaches fail, flag as "Requires manual review"
- **Recipes/jobs are source of truth** over config files (configs may be stale)

#### Output structure
Write `inventory.md` with sections: Connections, Schemas, Field Mappings, Transformations, Dependency Graph, Data Journey Map, Observations/Red Flags, Confidence Classification, Runtime Validation Required table.

Add this note before the summary: "This inventory reflects static analysis only. Findings marked MEDIUM or LOW confidence should be verified with runtime data and a domain owner walkthrough before scoring."

**Gate**: Verify `inventory.md` exists and contains sections: Connections, Schemas, Mappings.

### Phase 2: Assess (INTERACTIVE)

**Runs inline** - for interactive mode, spawn a general-purpose subagent with the assessment methodology. For headless mode (run-pipeline.sh), generate assessment inline.
**Input**: Inventory (if Phase 1 ran) + user context
**Output**: `assessment.md`

#### Interactive mode

Spawn a **general-purpose subagent** with this prompt:

> You are conducting an integration assessment interview. Read `.agent/templates/integration/assessment-questionnaire.md` for the methodology and interview structure, and `.agent/templates/integration/assessment-document.md` for the output format. Follow the Methodology & Constraints section: use the 5-step conversational flow, apply adaptive questioning based on context (new/existing/inventory-available), classify evidence using the T2 bias table, and apply the runtime data gate before finalizing. Ask WHY, not just WHAT. Write the completed assessment to `{output_dir}/assessment.md`.

The subagent conducts a conversational interview with the user.

#### Headless mode (--brief)

Generate assessment inline from the brief description and any inventory data. For dimensions where information is insufficient, mark as "UNKNOWN - requires further discovery".

#### Domain Owner Verification Gate

Before finalizing:
- Distinguish findings from direct evidence vs inference
- If no domain owner walkthrough has occurred: mark as "Preliminary - Static Analysis Only"
- Operational dimensions (D3, D4, D7, D8) are almost always inference without runtime data - flag explicitly

**Gate**: Verify `assessment.md` exists and contains all 8 dimension sections.

**Note**: This is the only interactive pause point. The assessor conducts a conversational interview with the user. All other phases run automatically.

### Phase 3: Score

**Runs inline** (no agent delegation)
**Input**: `assessment.md` (+ `inventory.md` if Phase 1 ran)
**Output**: `scorecard.md`

#### Step 1: Classify Input Quality

Before scoring, determine what evidence is available and label the scorecard accordingly:

| Input Available | Classification | Confidence Cap |
|----------------|---------------|----------------|
| Description only (no assessment/inventory) | `PRELIMINARY - Description Only` | LOW on all dimensions |
| Assessment from interview (no code/runtime) | `ASSESSMENT-BASED` | MEDIUM max, HIGH if specific evidence cited |
| Assessment + code inventory (no runtime) | `STATIC ANALYSIS` | HIGH for code-confirmed, MEDIUM for inferred |
| Assessment + runtime data (logs, metrics) | `RUNTIME-VALIDATED` | HIGH on all evidence-supported dimensions |

Add the classification as the first line of the scorecard, before any scores.

#### Step 2: Score Each Dimension

Read `.agent/templates/integration/scoring-rubric.md` for criteria. Apply the Confidence Levels by Dimension Type table from the rubric. For each dimension:
- Score based on **evidence**, not potential or intentions
- Use the **lowest applicable score** when criteria span multiple levels
- Document the specific evidence supporting each score
- Mark confidence: HIGH (direct evidence), MEDIUM (inferred from context), LOW (assumed/unknown)
- Append `(INFERRED)` to dimension scores based on code structure vs runtime confirmation when assessment is static-only

#### Step 3: Calculate Overall Score

Weighted average (CRITICAL dimensions weighted 3x, HIGH 2x, MEDIUM 1.5x, LOW 1x):

```
Overall = (Arch*2 + Data*2 + OpEx*3 + Reliability*3 + Security*3 + Business*1.5 + Maintain*1.5 + Platform*1) / 17
```

#### Step 4: Map to Maturity Level

| Score Range | Level | Label |
|-------------|-------|-------|
| 4.5 - 5.0 | 5 | Augmented |
| 3.5 - 4.4 | 4 | Balanced |
| 2.5 - 3.4 | 3 | Centralized |
| 1.5 - 2.4 | 2 | Enlightened |
| 1.0 - 1.4 | 1 | Ad hoc |

#### Step 5: Identify Red Flags and Quick Wins

- Red flags: any dimension scoring 1.0-1.5 AND weighted CRITICAL or HIGH
- Quick wins: improvements achievable in <1 day that raise a dimension by 0.5+
- For each, include: severity, affected dimension, remediation, effort estimate

#### Step 6: Score Revision Log

When any score is revised from a previous version, record the change:

| Date | Dimension | Score Before | Score After | Reason |
|------|-----------|-------------|-------------|--------|
| [date] | [dimension] | [X.X] | [X.X] | [what new evidence changed the score] |

Never silently update scores. **Never present static scores as final** to stakeholders.

#### Step 7: Runtime Validation Required Table

Add a table listing which dimensions and scores would change with runtime data. Critical because static analysis scores can swing 10%+ after runtime enrichment.

| Dimension | Current Score | Confidence | Would Change With | Expected Direction |
|-----------|--------------|------------|-------------------|-------------------|
| (example) | 2.0 | MEDIUM | Execution logs showing actual retry behavior | Could increase to 3.0 if retries are configured at platform level |

**Gate**: Verify `scorecard.md` exists and contains: Overall Score, Per-Dimension Scores, Red Flags, Quick Wins.

### Phase 4: Design (skipped with --quick)

**Runs inline** (no agent delegation)
**Input**: `assessment.md` + `scorecard.md`
**Output**: `design.md`

#### Step 1: Determine Design Type

| Input Context | Design Type | Template |
|--------------|-------------|----------|
| Mode = `new` or scorecard shows no existing system | New Architecture | `.agent/templates/integration/design-document.md` |
| Mode = `existing` or `code-first` with scorecard gaps | Improvement Roadmap | `.agent/templates/integration/improvement-roadmap.md` |

Always also load: `.agent/templates/integration/pattern-library.md`

#### Step 2: Front-Load the Model (T6)

Lead with the complete approach (pattern choice, phases, trade-offs) before diving into details. Present alternatives considered and why they were rejected. State assumptions and dependencies upfront.

Structure: Overview -> Pattern Choice -> Phases -> Details (not Details -> Pattern -> Overview)

#### Step 3: Design Approach

**For New Integrations**:
1. Analyze requirements from assessment
2. Select pattern from pattern library (justify choice, state alternatives rejected)
3. Design data model (canonical, mappings, validation)
4. Design flows (normal + error paths)
5. Define NFRs (error handling, monitoring, security, resilience)
6. Phase the implementation (MVP -> hardening -> optimization)

**For Improvement Roadmaps**:
1. Analyze gaps from scorecard (dimensions below target)
2. Prioritize: Critical (security, reliability) -> High (ops, data) -> Medium (maintainability)
3. Phase: Critical fixes (1-2 weeks) -> Quick wins (2-6 weeks) -> Strategic (1-3 months) -> Optimization (ongoing)
4. Define migration strategy (zero-downtime where possible)
5. Set milestones and success criteria per phase

#### Step 4: Classify Action Items (SOLO/PAIR)

Every recommendation or action item must be classified:

- **SOLO**: Implementable directly from the design document and existing code/documentation alone
- **PAIR**: Requires domain owner present - undocumented runtime behavior, live system state, business rules not in code

**Why**: PAIR items attempted as SOLO have a 43% false positive rate - teams build the wrong thing. A 30-minute walkthrough prevents days of rework. When uncertain, default to PAIR.

Format: `[Phase X.Y] Action title - [SOLO|PAIR] - Verify: [specific check]`

#### Step 5: Quality Validation

Before writing output, validate against `.agent/templates/integration/validation-checklist.md` Section A:
- All 8 dimensions from assessment are addressed
- Security findings are phased as feature work (Phase 1 critical tier), not "later enhancements"
- Each phase has clear exit criteria

#### Critical constraints
- **Lead with complete approach** (pattern choice, phases, trade-offs) before diving into details
- **Design for actual requirements**, not theoretical ideals - acknowledge budget/timeline/skills constraints
- **Never fabricate platform capabilities** - if uncertain: "Verify with [Platform] documentation"
- Provide patterns and approaches, not platform-specific implementation code

**Gate**: Verify `design.md` exists and contains: Architecture/Roadmap, Data Flows, Error Handling.

### Phase 5: Review (skipped with --quick)

**Runs inline** (no agent delegation)
**Input**: `design.md` + `assessment.md`
**Output**: `review-report.md`

#### Step 1: Load Review Framework

Read `.agent/templates/integration/validation-checklist.md` Section B for the structured review checklist. Also read `.agent/templates/integration/review-report-template.md` for the output structure.

If `--security` flag is set, also load `.agent/templates/integration/security-review-checklist.md` for OWASP API Top 10 analysis and `.agent/templates/integration/anti-patterns.md` for pattern validation.

#### Step 2: Validate Design

- Parse design document: extract architecture, patterns, data flows, NFRs
- Validate 8-dimension coverage using checklist
- Check for architectural anti-patterns (distributed monolith, cascading failures, chatty interfaces)
- Note strengths alongside gaps

#### Step 3: Classify Findings

| Severity | Definition | Action |
|----------|-----------|--------|
| **Critical** | Security vulnerability, data loss risk, SPOF with no DR | Must fix before implementation |
| **High** | Missing resilience pattern, inadequate monitoring, no retry | Should fix before implementation |
| **Medium** | Suboptimal pattern, documentation gap, optimization opportunity | Improve after MVP |
| **Low** | Enhancement, additional testing, nice-to-have | Backlog |

#### Step 4: Static vs Verified Findings (T3)

Before classifying any finding, note its basis:
- **From Design Document** (design states this explicitly): Classify normally
- **Inferred from Design** (design implies but doesn't state): Append "- Requires Confirmation" to the finding

**43% false positive rate in assessments** - nearly half of inferred findings may be documentation gaps, not actual design flaws. Don't penalize designs for what they don't explicitly state unless it's a required element.

If the input assessment is marked "Preliminary - Static Analysis Only," note this in the review header and treat all operational findings as requiring confirmation.

#### Step 5: Determine Approval

| Status | Criteria |
|--------|----------|
| **Approved** | No critical or high findings. Design is implementation-ready. |
| **Approved with Conditions** | Has high findings that must be resolved. Can start implementation in parallel with fixes. |
| **Revisions Required** | Has critical findings. Must re-design and re-review before implementation. |

Security gaps (missing OAuth, unencrypted channels, exposed credentials) must be classified as CRITICAL, not Medium. Security findings must block approval.

#### Critical constraints
- **Constructive over critical**: Focus on risks and improvements, not just flaws. Suggest alternatives when flagging issues.
- **Accuracy over fabrication**: Never fabricate security vulnerabilities. Base findings on evidence in the design.
- **Acknowledge limitations**: Platform-specific details = "validate with platform expert"; performance claims = "requires load testing"

**Gate**: Verify `review-report.md` exists and contains: Findings, Approval Status.

### Phase 6: Summarize

**Runs inline** (no agent delegation)
**Input**: `assessment.md` + `scorecard.md` + `design.md` (if exists) + `review-report.md` (if exists)
**Output**: `customer-summary.md`

#### Score Translation Table

Use these prescribed labels when translating scores to customer-friendly language:

| Score Range | Internal Label | Customer-Facing Label |
|-------------|---------------|----------------------|
| 4.5 - 5.0 | Augmented | Industry-Leading |
| 3.5 - 4.4 | Balanced | Well-Established |
| 2.5 - 3.4 | Centralized | Progressing |
| 1.5 - 2.4 | Enlightened | Early-Stage |
| 1.0 - 1.4 | Ad hoc | Foundation-Building |

#### Guidelines
- Load `.agent/templates/integration/customer-summary-template.md`
- Present findings as improvement opportunities, not criticisms
- List strengths before recommendations
- Structure as: Executive Summary -> Key Findings -> Recommended Next Steps
- Exclude internal scoring notes and raw technical details
- Use business language throughout (no jargon without explanation)

**Gate**: Verify `customer-summary.md` exists.

## Progress Display

```
## Integration Pipeline: customer-sync

**Mode**: code-first
**Output**: .agent/tasks/integration-customer-sync/

Phase 1: Analyze    [COMPLETE] inventory.md (47 connections, 12 jobs)
Phase 2: Assess     [COMPLETE] assessment.md (8 dimensions)
Phase 3: Score      [RUNNING]  Applying scoring rubric...
Phase 4: Design     [PENDING]
Phase 5: Review     [PENDING]
Phase 6: Summarize  [PENDING]
```

## Output Directory Structure

```
.agent/tasks/integration-{name}/
- inventory.md          (Phase 1 - code-first only)
- assessment.md         (Phase 2)
- scorecard.md          (Phase 3)
- design.md             (Phase 4 - skipped with --quick)
- review-report.md      (Phase 5 - skipped with --quick)
- customer-summary.md   (Phase 6)
```

## Gate Validation

Between each phase, the pipeline validates:

1. **Output file exists**: The expected `.md` file was created
2. **Required sections present**: Key sections are in the document (checked via Grep)
3. **No empty sections**: Main sections contain content beyond headers

If a gate fails:
```
Gate check failed after Phase 3 (Score):
- Missing section: "Quick Wins" in scorecard.md
- Action: Re-running Phase 3 with explicit instruction to include Quick Wins

Retry 1/2...
```

After 2 retries, the pipeline pauses and asks the user whether to continue or abort.

## Error Handling

| Error | Action |
|-------|--------|
| Phase execution fails | Retry once, then pause for user |
| Gate validation fails | Retry phase (max 2), then pause |
| User cancels during Phase 2 | Save partial assessment, exit cleanly |
| Output directory not writable | Error with recovery instructions |

## Examples

### Full Pipeline from Workato Export

```bash
/integration-pipeline --mode code-first /home/user/workato-export customer-sync-v2
```

Runs all 6 phases. Pauses at Phase 2 for interactive assessment interview.

### Quick Score for Stakeholder Meeting

```bash
/integration-pipeline --quick --mode existing order-processing
```

Runs Phases 2-3 and 6 only (Assess -> Score -> Summarize). Produces assessment, scorecard, and customer summary.

### New Integration with Security Focus

```bash
/integration-pipeline --security --mode new pii-customer-integration
```

Runs Phases 2-6 with security deep-dive in Phase 5 review.

### Single Phase: Score from Existing Assessment

```bash
/integration-pipeline --phase score --from-file .agent/tasks/integration-sfdc/assessment.md
```

Runs only Phase 3 (Score) using the provided assessment file.

## Headless Mode

For long pipelines or CI/CD contexts, use the companion shell script `run-pipeline.sh` to orchestrate the pipeline outside of an interactive Claude Code session. Each phase runs as an independent `claude -p` invocation with gate validation and automatic retry between phases.

### Setup

```bash
# From the skill directory
chmod +x .claude/skills/integration-pipeline/run-pipeline.sh

# Or run directly
bash .claude/skills/integration-pipeline/run-pipeline.sh --help
```

### Usage

```bash
# Full pipeline from code export
./run-pipeline.sh --mode code-first --export /path/to/export customer-sync

# New integration with brief description (generates assessment automatically)
./run-pipeline.sh --mode new --brief "Salesforce-SAP customer sync" salesforce-sap

# Use an existing assessment file (skip interactive Phase 2)
./run-pipeline.sh --mode existing --from-assessment path/to/assessment.md order-proc

# Quick pipeline (skip Design + Review)
./run-pipeline.sh --quick --mode new --brief "Quick score needed" my-integration

# Single phase
./run-pipeline.sh --phase score --from-file assessment.md my-integration

# Resume after interruption
./run-pipeline.sh --resume customer-sync

# Preview what would run without executing
./run-pipeline.sh --dry-run --mode new --brief "Test" test-run
```

### Headless-Only Flags

These flags are specific to headless mode and are not available in the interactive `/integration-pipeline` skill:

| Flag | Description |
|------|-------------|
| `--brief <text>` | Provides context for auto-generating Phase 2 (Assessment) without interactive interview |
| `--from-assessment <path>` | Copies an existing assessment file, skipping Phase 2 entirely |
| `--resume` | Detects completed phases and resumes from the first incomplete one |
| `--model <model>` | Override which model each phase uses (default: `sonnet`) |
| `--verbose` | Stream full claude output to the console (default: status lines only) |
| `--dry-run` | Show planned phases and prompts without invoking claude |

### Key Differences from Interactive Mode

| Aspect | Interactive (`/integration-pipeline`) | Headless (`run-pipeline.sh`) |
|--------|---------------------------------------|------------------------------|
| Phase 2 | Conversational interview with user | Auto-generated from `--brief` or `--from-assessment` |
| Context | Single session, shared context | Each phase is a fresh invocation |
| Retry | Asks user on failure | Automatic retry (max 2), then exits with error code |
| Resume | Not supported | `--resume` flag detects completed phases |
| Logging | Inline progress display | `pipeline-log.md` + per-phase output logs |

### Exit Codes

| Code | Meaning |
|------|---------|
| 0 | All phases completed successfully |
| 1 | Invalid arguments |
| 2 | Missing dependency (`claude` CLI not found) |
| 10-16 | Phase 1-6 execution failure (after retry) |
| 20-26 | Phase 1-6 gate validation failure (after retries) |

---

**Version**: 2.0.0
**Status**: Active
