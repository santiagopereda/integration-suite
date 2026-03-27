# Integration Suite Plugin

Claude Code plugin for end-to-end integration maturity assessment. Provides a single pipeline skill and 19 templates based on the 8-Dimension Integration Maturity Framework (Gartner-aligned).

## What It Does

Evaluate integrations from code analysis through customer-facing reports:

```
Code Export -> Inventory -> Assessment -> Scorecard -> Design/Roadmap -> Review -> Summary
```

All 6 phases are handled by the `/integration-pipeline` skill, which embeds domain expertise directly in its prompts and references structured templates for each output.

## Installation

### From GitHub (plugin install)

```bash
claude plugin install <org>/integration-suite
```

### Local development

```bash
claude --plugin-dir /path/to/plugins/integration-suite
```

## Setup

Templates are auto-copied to your project on first session start via the `SessionStart` hook. The hook checks for `.agent/templates/integration/` and copies templates there if missing.

## Usage

### Full Pipeline (code-first)

```bash
/integration-suite:integration-pipeline code-first /path/to/export customer-sync
```

Runs all 6 phases: Analyze -> Assess -> Score -> Design -> Review -> Summarize

### Full Pipeline (new integration)

```bash
/integration-suite:integration-pipeline new "Salesforce-SAP customer master data sync" salesforce-sap
```

### Quick Score (skip design + review)

```bash
/integration-suite:integration-pipeline new --quick "MuleSoft order processing" order-sync
```

### Standalone Phases

Run individual phases with `--phase`:

```bash
# Score an existing assessment
/integration-suite:integration-pipeline --phase score --from-file assessment.md my-integration

# Review a design with security deep-dive
/integration-suite:integration-pipeline --phase review --from-file design.md --security my-integration

# Generate customer summary
/integration-suite:integration-pipeline --phase summarize --from-file scorecard.md my-integration
```

### Headless Mode (CI/scripts)

```bash
./skills/integration-pipeline/run-pipeline.sh --mode code-first --export /path/to/export customer-sync
./skills/integration-pipeline/run-pipeline.sh --mode new --brief "Description" --quick my-integration
./skills/integration-pipeline/run-pipeline.sh --phase score --from-file assessment.md my-integration
```

## Templates

19 templates in `.agent/templates/integration/` provide structure for all outputs:

**Scoring & Assessment**
- `scoring-rubric.md` - 8 dimensions x 5 levels with criteria and confidence guidance
- `scorecard-template.md` - Output structure with radar chart data
- `assessment-questionnaire.md` - Interview structure with methodology section
- `assessment-document.md` - Assessment output structure
- `industry-benchmarks.md` - Sector benchmarks for comparison
- `red-flags-library.md` - Common integration anti-patterns

**Design & Review**
- `design-document.md` - New integration architecture template
- `improvement-roadmap.md` - Existing integration improvement plan
- `pattern-library.md` - Integration patterns reference
- `validation-checklist.md` - Pre-delivery and peer review validation
- `review-report-template.md` - Review output structure
- `security-review-checklist.md` - OWASP API Top 10, auth, encryption
- `anti-patterns.md` - What to watch for

**Analysis**
- `inventory-document.md` - Code analysis output structure with confidence classification
- `extraction-guide.md` - Universal extraction checklist with config baseline
- `platform-parsers/talend.md` - Talend core workspace parsing
- `platform-parsers/talend-jobs.md` - Talend DI job parsing (t* components)
- `platform-parsers/talend-routes.md` - Talend ESB route parsing (c* components)
- `platform-parsers/workato.md` - Workato recipe parsing

**Summary**
- `customer-summary-template.md` - Customer-facing report structure

## Template Customization

Templates are copied to your project's `.agent/templates/integration/` directory. You can edit them freely - the plugin won't overwrite existing files on subsequent sessions.

## Hub Maintenance

The `scripts/sync-from-hub.sh` script syncs updates from the Agentic Hub to this plugin:

```bash
bash plugins/integration-suite/scripts/sync-from-hub.sh /path/to/agentic-hub
```

This copies the pipeline skill files and rsyncs all templates.

## Version

- **Plugin**: 2.0.0
- **Framework**: 8-Dimension Integration Maturity Framework (Gartner-aligned)
- **Platforms**: Workato, Talend (supported); MuleSoft, Boomi, SAP CPI (planned)
