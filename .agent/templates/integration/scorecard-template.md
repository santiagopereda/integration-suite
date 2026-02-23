# Integration Maturity Scorecard: [NAME]

**Assessment Date**: [DATE]
**Scorer**: [NAME]
**Assessment Reference**: [Link to assessment document]

---

## Executive Summary

- **Overall Maturity**: [Level X] - [Ad hoc / Enlightened / Centralized / Balanced / Augmented]
- **Weighted Score**: [X.X / 5.0]
- **Risk Level**: [Critical / High / Medium / Low]
- **Red Flags**: [N] critical issues found
- **Quick Wins**: [N] low-effort improvements identified

## Dimension Scores

| # | Dimension | Score | Level | Weight | Weighted | Trend |
|---|-----------|-------|-------|--------|----------|-------|
| 1 | Architecture & Design | [1-5] | [Level] | HIGH (x2) | [X.X] | [New/Up/Same/Down] |
| 2 | Data Quality & Governance | [1-5] | [Level] | HIGH (x2) | [X.X] | |
| 3 | Operational Excellence | [1-5] | [Level] | CRITICAL (x3) | [X.X] | |
| 4 | Reliability & Resilience | [1-5] | [Level] | CRITICAL (x3) | [X.X] | |
| 5 | Security & Compliance | [1-5] | [Level] | CRITICAL (x3) | [X.X] | |
| 6 | Business Impact | [1-5] | [Level] | MEDIUM (x1.5) | [X.X] | |
| 7 | Maintainability & Scalability | [1-5] | [Level] | MEDIUM (x1.5) | [X.X] | |
| 8 | Tool & Platform | [1-5] | [Level] | LOW (x1) | [X.X] | |
| | **Weighted Average** | | | | **[X.X]** | |

## Red Flags (Immediate Attention)

### RF-[N]: [Title]
- **Dimension**: [Which dimension]
- **Current Score**: [1-2]
- **Issue**: [Specific problem]
- **Risk**: [Business/technical impact]
- **Remediation**: [What to do]
- **Effort**: [Hours/Days/Weeks]

## Quick Wins (Low Effort, High Impact)

### QW-[N]: [Title]
- **Dimension**: [Which dimension]
- **Current Score**: [X] -> **Target**: [X+1]
- **Improvement**: [What to do]
- **Effort**: [Hours/Days]
- **Impact**: [Score improvement + business benefit]

## Score Evidence Summary

| Dimension | Key Evidence | Confidence |
|-----------|-------------|------------|
| Architecture | [Key artifacts/findings] | [High/Medium/Low] |
| Data Quality | [Key artifacts/findings] | |
| Operations | [Key artifacts/findings] | |
| Reliability | [Key artifacts/findings] | |
| Security | [Key artifacts/findings] | |
| Business Impact | [Key artifacts/findings] | |
| Maintainability | [Key artifacts/findings] | |
| Platform | [Key artifacts/findings] | |

## Industry Benchmark

| Dimension | Your Score | Industry Avg | Delta |
|-----------|-----------|-------------|-------|
| Architecture | [X] | [X.X] | [+/-X.X] |
| Data Quality | [X] | [X.X] | |
| Operations | [X] | [X.X] | |
| Reliability | [X] | [X.X] | |
| Security | [X] | [X.X] | |
| Business Impact | [X] | [X.X] | |
| Maintainability | [X] | [X.X] | |
| Platform | [X] | [X.X] | |

**Sector**: [Financial Services / Healthcare / Retail / Manufacturing / Technology]
**Complexity**: [Simple / Medium / Complex]

## Radar Chart Data

```json
{
  "integration": "[NAME]",
  "date": "[DATE]",
  "dimensions": [
    "Architecture",
    "Data Quality",
    "Operations",
    "Reliability",
    "Security",
    "Business Impact",
    "Maintainability",
    "Platform"
  ],
  "scores": {
    "current": [0, 0, 0, 0, 0, 0, 0, 0],
    "target": [0, 0, 0, 0, 0, 0, 0, 0],
    "industry_avg": [0, 0, 0, 0, 0, 0, 0, 0]
  }
}
```

## Recommended Next Steps

1. **Immediate** (This week): Address red flags [RF-1, RF-2, ...]
2. **Short-term** (1-4 weeks): Implement quick wins [QW-1, QW-2, ...]
3. **Medium-term** (1-3 months): Raise lowest dimensions to Level 3
4. **Long-term** (3-12 months): Achieve target maturity across all dimensions

## Handoff Notes

- **For Designer**: Key gaps requiring architectural decisions: [list]
- **For Reviewer**: Focus areas for design review: [list]
- **For Customer**: Summary ready for `/summarize-integration`
