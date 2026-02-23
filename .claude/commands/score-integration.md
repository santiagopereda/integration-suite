# /score-integration - Quick Maturity Scoring

Quick integration maturity assessment and scoring.

## Quick Reference

| Aspect | Details |
|--------|---------|
| **Invocation** | `/score-integration [description]` |
| **Agents Used** | agent-integration-assessor (brief), agent-integration-scorer |
| **Output** | Quick assessment + Maturity scorecard |

## Usage

```bash
/score-integration MuleSoft integration for customer data sync
/score-integration --from-file path/to/existing/assessment.md
```

## Workflow

```
Step 1: agent-integration-assessor (Brief Mode)
├── Quick discovery (key dimensions only)
└── Produces: Brief assessment

Step 2: agent-integration-scorer
├── Applies scoring rubric
├── Identifies top red flags and quick wins
└── Produces: Maturity scorecard with radar chart data
```

## Options

| Option | Description |
|--------|-------------|
| `--from-file <path>` | Score an existing assessment document (skip assessor) |
| `--benchmark <sector>` | Compare against specific sector (financial, healthcare, retail, manufacturing, technology) |

## Output

- Overall maturity score (1-5, Gartner-aligned)
- Per-dimension scores table
- Top 3 red flags with remediation
- Top 3 quick wins with effort estimates
- Radar chart JSON data
- Industry benchmark comparison (if sector specified)

---

**Version**: 1.0.0
