---
name: integration-pipeline
description: End-to-end integration assessment pipeline orchestrating all 6 phases from analysis to customer summary
disable-model-invocation: true
---

# /integration-pipeline - End-to-End Integration Assessment

Orchestrate the full 6-phase integration assessment pipeline from code analysis through customer-facing summary.

## Quick Reference

| Aspect | Details |
|--------|---------|
| **Invocation** | `/integration-pipeline [options] <integration-name>` |
| **Agents Used** | assessor, scorer, reviewer, documentation-specialist |
| **Output** | Complete assessment package in `.agent/tasks/integration-{name}/` |

## Modes

| Mode | Starts At | Use When |
|------|-----------|----------|
| `code-first` | Phase 1 (Analyze) | You have a code export to parse first |
| `new` | Phase 2 (Assess) | New integration requirements |
| `existing` | Phase 2 (Assess) | Evaluating an existing integration |

**Auto-detection**: If a path argument is provided, defaults to `code-first`. Otherwise defaults to `new`.

### Mode-Phase Matrix

Which phases run for each mode (before applying `--quick`):

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
# Output: .agent/tasks/integration-customer-sync/
/integration-pipeline --mode code-first /path/to/export customer-sync

# New integration assessment (skip code analysis)
# Output: .agent/tasks/integration-salesforce-sap-sync/
/integration-pipeline --mode new salesforce-sap-sync

# Quick pipeline (skip design + review phases)
# Output: .agent/tasks/integration-order-processing/
/integration-pipeline --quick --mode existing order-processing

# With security deep-dive in review phase
# Output: .agent/tasks/integration-pii-data-integration/
/integration-pipeline --security --mode new pii-data-integration
```

## Flags

| Flag | Description |
|------|-------------|
| `--mode <mode>` | Override auto-detection: `code-first`, `new`, `existing` |
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

Phase 1 is skipped for `new` and `existing` modes (no code export to analyze). Phases 4-5 are skipped when `--quick` is set.

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
   - `.agent/templates/integration/platform-parsers/[platform].md` (platform-specific)
   - `.agent/templates/integration/inventory-document.md` (output structure)

3. **Scan & Parse** - Glob to find all relevant files, Read to parse each:
   - Connections: source/target systems, connectors, auth type
   - Schemas: input/output field definitions with types
   - Mappings: field-to-field with transformation type
   - Error handling: try-catch, retry, DLQ config
   - Sub-job/recipe calls with parameters passed

4. **Build Call Graph** - Grep for inter-job/recipe references:
   - Workato: `"call_recipe"` / `"recipe_function"` across recipes
   - Talend: `"tRunJob"` componentName across `.item` files
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

#### Critical constraints
- **Never fabricate** field mappings or schemas - only document what's in the code
- **Code shows WHAT, not WHY** - flag findings as "Code shows [X], intent unclear"
- **Stop when parsing fails repeatedly** - if 2-3 approaches fail, flag as "Requires manual review"
- **Recipes/jobs are source of truth** over config files (configs may be stale)

#### Output structure
Write `inventory.md` with sections: Connections, Schemas, Field Mappings, Transformations, Dependency Graph, Data Journey Map, Observations/Red Flags, Runtime Validation Required table.

Add this note before the summary: "This inventory reflects static analysis only. Findings marked MEDIUM or LOW confidence should be verified with runtime data and a domain owner walkthrough before scoring."

**Gate**: Verify `inventory.md` exists and contains sections: Connections, Schemas, Mappings.

### Phase 2: Assess (INTERACTIVE)

**Agent**: agent-integration-assessor
**Input**: Inventory (if Phase 1 ran) + user context
**Output**: `assessment.md`

```
- Guided interview across 8 dimensions
- For code-first: pre-populate dimensions from inventory
- For new/existing: full discovery interview
- Produces structured assessment document
```

**Gate**: Verify `assessment.md` exists and contains all 8 dimension sections.

**Note**: This is the only interactive pause point. The assessor conducts a conversational interview with the user. All other phases run automatically.

### Phase 3: Score

**Agent**: agent-integration-scorer
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

Apply the scoring rubric from `.agent/templates/integration/scoring-rubric.md`. For each dimension:
- Score based on **evidence**, not potential or intentions
- Use the **lowest applicable score** when criteria span multiple levels
- Document the specific evidence supporting each score
- Mark confidence: HIGH (direct evidence), MEDIUM (inferred from context), LOW (assumed/unknown)

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

#### Step 6: Runtime Validation Required Table

Add a table listing which dimensions and scores would change with runtime data. This is critical because static analysis scores can swing 10%+ after runtime enrichment (proven across multiple engagements).

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

#### Step 2: Design Approach

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

#### Step 3: Classify Action Items (SOLO/PAIR)

Every recommendation or action item must be classified:

- **SOLO**: Implementable directly from the design document and existing code/documentation alone
- **PAIR**: Requires domain owner present - undocumented runtime behavior, live system state, business rules not in code

**Why**: PAIR items attempted as SOLO have a 43% false positive rate - teams build the wrong thing. A 30-minute walkthrough prevents days of rework. When uncertain, default to PAIR.

Format: `[Phase X.Y] Action title - [SOLO|PAIR] - Verify: [specific check]`

#### Step 4: Quality Validation

Before writing output, validate:
- All 8 dimensions from assessment are addressed
- Security findings are phased as feature work (Phase 1 critical tier), not "later enhancements"
- Each phase has clear exit criteria
- Load `.agent/templates/integration/design-quality-checklist.md` and check against it

#### Critical constraints
- **Lead with complete approach** (pattern choice, phases, trade-offs) before diving into details
- **Design for actual requirements**, not theoretical ideals - acknowledge budget/timeline/skills constraints
- **Never fabricate platform capabilities** - if uncertain: "Verify with [Platform] documentation"
- Provide patterns and approaches, not platform-specific implementation code

**Gate**: Verify `design.md` exists and contains: Architecture/Roadmap, Data Flows, Error Handling.

### Phase 5: Review (skipped with --quick)

**Agent**: agent-integration-reviewer
**Input**: `design.md` + `assessment.md`
**Output**: `review-report.md`

```
- Validate design against best practices
- Check 8-dimension coverage
- Classify findings (Critical/High/Medium/Low)
- If --security: OWASP API Top 10, encryption, auth deep-dive
- Produce approval status
```

**Gate**: Verify `review-report.md` exists and contains: Findings, Approval Status.

### Phase 6: Summarize

**Agent**: documentation-specialist
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
| Agent invocation fails | Retry once, then pause for user |
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

**Version**: 1.4.0
**Status**: Active
