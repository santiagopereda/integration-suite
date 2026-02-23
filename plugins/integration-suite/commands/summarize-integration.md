# /summarize-integration - Customer-Facing Summary

Generate a professional, customer-facing summary from integration assessment and scorecard data.

## Quick Reference

| Aspect | Details |
|--------|---------|
| **Invocation** | `/summarize-integration [reference to assessment/scorecard]` |
| **Agent Used** | Works standalone (no external agent dependency) |
| **Template** | `.agent/templates/integration/customer-summary-template.md` |
| **Output** | Professional customer report |

## Usage

```bash
/summarize-integration Summarize the Salesforce-SAP integration assessment
/summarize-integration --executive  # 1-page executive summary
/summarize-integration --detailed   # Full customer report (5-10 pages)
/summarize-integration --from-file .agent/tasks/integration-sfdc-sap/scorecard.md
```

## Workflow

```
Step 1: Load assessment and scorecard data
├── From conversation context or --from-file

Step 2: Load customer summary template
├── .agent/templates/integration/customer-summary-template.md

Step 3: Generate customer report
├── Translate scores to customer-friendly language
├── Present findings as opportunities
├── Structure as executive summary + findings + recommendations + roadmap
└── Exclude internal notes and raw technical details
```

## Options

| Option | Description |
|--------|-------------|
| `--executive` | 1-page executive summary (scores, top 3 recommendations) |
| `--detailed` | Full customer report (all findings, roadmap, benchmarks) |
| `--from-file <path>` | Load assessment/scorecard from specific file |

## Score Translation

| Internal Score | Customer-Facing Label |
|----------------|----------------------|
| 5 (Augmented) | Best-in-class - maintain and innovate |
| 4 (Balanced) | Strong maturity - fine-tuning opportunities |
| 3 (Centralized) | Well-managed - targeted improvements recommended |
| 2 (Enlightened) | Foundation in place - key gaps to address |
| 1 (Ad hoc) | Significant opportunity for improvement |

## Tone Guidelines

- Present findings as **opportunities**, not criticisms
- Acknowledge **strengths** before recommendations
- Use **business language**, minimize technical jargon
- Focus on **business value** of each recommendation
- Frame improvements as **risk reduction** and **efficiency gains**

## Output

Professional customer report with:
- Executive summary
- Integration overview
- Maturity assessment (customer-friendly scores)
- Key findings (strengths + recommendations)
- High-level improvement roadmap
- Expected business impact
- Concrete next steps

---

**Version**: 1.0.0
