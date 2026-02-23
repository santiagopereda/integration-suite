# Integration Suite Plugin

Claude Code plugin for end-to-end integration maturity assessment. Provides 5 specialized agents, 5 commands, and 19 templates based on the 8-Dimension Integration Maturity Framework (Gartner-aligned).

## What It Does

Evaluate integrations from code analysis through customer-facing reports:

```
Code Export → Inventory → Assessment → Scorecard → Design/Roadmap → Review → Summary
```

Each step is handled by a dedicated agent with deep domain expertise and backed by structured templates.

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

**Manual setup** (if the hook didn't fire or you need to re-initialize):

```bash
/integration-suite:setup
```

## Agents

| Agent | Purpose |
|-------|---------|
| `agent-integration-analyzer` | Parse iPaaS workspace exports (Workato, Talend, MuleSoft, Boomi) into structured inventories |
| `agent-integration-assessor` | Conduct guided discovery interviews across 8 maturity dimensions |
| `agent-integration-scorer` | Score maturity 1-5 per dimension with red flags, quick wins, benchmarks |
| `agent-integration-designer` | Design new integration architecture or improvement roadmaps |
| `agent-integration-reviewer` | Validate designs against best practices, security standards, 8-dimension framework |

## Commands

| Command | Description |
|---------|-------------|
| `/integration-suite:analyze-integration` | Parse a code export into an inventory |
| `/integration-suite:assess-integration` | Full assessment lifecycle (assess → score → design → review) |
| `/integration-suite:score-integration` | Quick maturity scoring from description or existing assessment |
| `/integration-suite:review-integration` | Design review with findings and approval status |
| `/integration-suite:summarize-integration` | Customer-facing summary from assessment/scorecard data |

## Templates

19 templates in `.agent/templates/integration/` provide structure for all outputs:

**Scoring & Assessment**
- `scoring-rubric.md` — 8 dimensions x 5 levels with criteria
- `scorecard-template.md` — Output structure with radar chart data
- `assessment-questionnaire.md` — Interview structure
- `assessment-document.md` — Assessment output structure
- `industry-benchmarks.md` — Sector benchmarks for comparison
- `red-flags-library.md` — Common integration anti-patterns

**Design & Review**
- `design-document.md` — New integration architecture template
- `improvement-roadmap.md` — Existing integration improvement plan
- `pattern-library.md` — Integration patterns reference
- `design-quality-checklist.md` — Pre-delivery validation
- `review-checklist.md` — Structured review framework
- `review-report-template.md` — Review output structure
- `security-review-checklist.md` — OWASP API Top 10, auth, encryption
- `anti-patterns.md` — What to watch for

**Analysis**
- `inventory-document.md` — Code analysis output structure
- `extraction-guide.md` — Universal extraction checklist
- `platform-parsers/talend.md` — Talend-specific parsing guide
- `platform-parsers/workato.md` — Workato-specific parsing guide

**Summary**
- `customer-summary-template.md` — Customer-facing report structure

## Template Customization

Templates are copied to your project's `.agent/templates/integration/` directory. You can edit them freely — the plugin won't overwrite existing files on subsequent sessions.

To reset a template to its default, delete it and restart your session (or run `/integration-suite:setup`).

## Typical Workflows

### Full Lifecycle (new integration)

```bash
/integration-suite:assess-integration new Salesforce-SAP customer master data sync
```

Runs: Assessor (interview) → Scorer (scorecard) → Designer (architecture) → Reviewer (validation)

### Code-First (existing integration)

```bash
/integration-suite:analyze-integration /path/to/talend/export
/integration-suite:assess-integration existing  # uses inventory as starting point
```

### Quick Score

```bash
/integration-suite:score-integration MuleSoft integration for order processing
```

### Customer Report

```bash
/integration-suite:summarize-integration --from-file .agent/tasks/integration-sfdc-sap/scorecard.md
```

## Hub Maintenance

The `scripts/sync-from-hub.sh` script syncs updates from the Agentic Hub to this plugin:

```bash
bash plugins/integration-suite/scripts/sync-from-hub.sh /path/to/agentic-hub
```

This:
- Copies agent files (strips `model:` line)
- Copies command files (skips `summarize-integration.md` which is manually maintained)
- Rsyncs templates

## Version

- **Plugin**: 1.0.0
- **Framework**: 8-Dimension Integration Maturity Framework (Gartner-aligned)
- **Platforms**: Workato, Talend (supported); MuleSoft, Boomi, SAP CPI (planned)
