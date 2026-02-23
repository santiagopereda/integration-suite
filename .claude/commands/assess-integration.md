# /assess-integration - Full Integration Assessment

Run a complete integration assessment lifecycle from discovery through review.

## Quick Reference

| Aspect | Details |
|--------|---------|
| **Invocation** | `/assess-integration [new\|existing] [description]` |
| **Agents Used** | agent-integration-assessor, agent-integration-scorer, agent-integration-designer, agent-integration-reviewer |
| **Output** | Assessment + Scorecard + Design/Roadmap + Review Report |

## Usage

### Full Lifecycle (Default)

```bash
/assess-integration new Salesforce-SAP customer master data sync
/assess-integration existing Workday-ServiceNow employee onboarding
```

### Quick Assessment + Score Only

```bash
/assess-integration --quick Order processing integration between Shopify and ERP
```

### With Security Deep-Dive

```bash
/assess-integration --security Customer data integration with PII handling
```

## Workflow

```
Step 1: agent-integration-assessor
├── Guided interview across 8 dimensions
├── Produces: Assessment document
└── Saved to: .agent/tasks/integration-{name}/assessment.md

Step 2: agent-integration-scorer
├── Applies scoring rubric to assessment
├── Produces: Maturity scorecard with red flags and quick wins
└── Saved to: .agent/tasks/integration-{name}/scorecard.md

Step 3: agent-integration-designer (skipped with --quick)
├── For new: Creates architecture design
├── For existing: Creates improvement roadmap
└── Saved to: .agent/tasks/integration-{name}/design.md

Step 4: agent-integration-reviewer (skipped with --quick)
├── Validates design against best practices
├── Security deep-dive if --security flag
└── Saved to: .agent/tasks/integration-{name}/review-report.md
```

## Options

| Option | Description |
|--------|-------------|
| `new` | New integration (requirements gathering + design) |
| `existing` | Existing integration (current state assessment + roadmap) |
| `--quick` | Assessment + scoring only (skip designer + reviewer) |
| `--security` | Add security deep-dive in review phase |

## Output

All artifacts saved to `.agent/tasks/integration-{name}/`:
- `assessment.md` - Structured assessment across 8 dimensions
- `scorecard.md` - Maturity scores, red flags, quick wins, radar chart data
- `design.md` - Architecture design or improvement roadmap
- `review-report.md` - Design review with findings and approval status

## Examples

### New Integration

```bash
/assess-integration new Real-time inventory sync between Shopify and SAP
```

### Existing Integration Improvement

```bash
/assess-integration existing Customer master data sync between SFDC and ERP - currently experiencing frequent failures
```

### Quick Score for Stakeholder Meeting

```bash
/assess-integration --quick Order processing pipeline
```

---

**Version**: 1.0.0
