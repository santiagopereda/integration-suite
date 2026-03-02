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
| **Agents Used** | analyzer, assessor, scorer, designer, reviewer, documentation-specialist |
| **Output** | Complete assessment package in `.agent/tasks/integration-{name}/` |

## Modes

| Mode | Starts At | Use When |
|------|-----------|----------|
| `code-first` | Phase 1 (Analyze) | You have a code export to parse first |
| `new` | Phase 2 (Assess) | New integration requirements |
| `existing` | Phase 2 (Assess) | Evaluating an existing integration |

**Auto-detection**: If a path argument is provided, defaults to `code-first`. Otherwise defaults to `new`.

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
                                   [skip]   [skip]
                                   --quick  --quick
```

### Phase 1: Analyze (code-first mode only)

**Agent**: agent-integration-analyzer
**Input**: Path to code export
**Output**: `inventory.md`

```
- Auto-detect platform (Workato, Talend, MuleSoft, Boomi)
- Parse configuration, jobs/recipes, connections
- Extract schemas, mappings, transformations
- Build dependency graph and data journey map
- Flag observations and red flags
```

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
**Input**: `assessment.md`
**Output**: `scorecard.md`

```
- Apply 8-dimension scoring rubric
- Calculate overall maturity score (1-5, Gartner-aligned)
- Identify top red flags with remediation
- Identify quick wins with effort estimates
- Generate radar chart JSON data
```

**Gate**: Verify `scorecard.md` exists and contains: Overall Score, Per-Dimension Scores, Red Flags, Quick Wins.

### Phase 4: Design (skipped with --quick)

**Agent**: agent-integration-designer
**Input**: `assessment.md` + `scorecard.md`
**Output**: `design.md`

```
- For new: Create architecture design with pattern selection
- For existing: Create improvement roadmap from scorecard gaps
- Cover all 8 dimensions
- Include data flow specifications
```

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

```
- Load customer summary template
- Translate scores to customer-friendly language
- Present findings as opportunities
- Structure as executive summary + findings + roadmap
- Exclude internal notes and raw technical details
```

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

**Version**: 1.1.0
**Status**: Active
