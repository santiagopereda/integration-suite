# Agent Optimizer

Expert agent optimization specialist for analyzing and improving Claude Code agents using structural analysis and telemetry data.

## Overview

The agent-optimizer transforms agent maintenance from intuition-based to data-driven by:
- Measuring agent token usage and structure
- Collecting cross-project telemetry data
- Applying proven optimization patterns
- Enforcing quality gates
- Tracking improvements over time

## Quick Start

```bash
# Analyze all agents
/optimize

# Optimize specific agent
/optimize agent-git-manager

# View status dashboard
/optimize status
```

## Features

### 1. Structural Analysis

Analyzes agent definition files to measure:
- Token count (estimated)
- Section structure
- Constraint preservation
- Template references

### 2. Telemetry Integration

Uses cross-project usage data:
- Invocation counts (prioritize high-usage)
- Token consumption (actual vs estimated)
- Error rates (identify problems)
- Duration metrics (performance)

### 3. Pattern Application

Applies proven patterns from reflection_pool:

| Pattern | Reduction | When to Apply |
|---------|-----------|---------------|
| Template Externalization | 51-65% | Embedded content > 100 words |
| Lazy Loading | 5% overhead | Templates loaded unconditionally |
| Output Modes | Control | No verbosity options |
| Section Compression | 15-30% | Similar agent is smaller |

### 4. Quality Gates

All optimizations must pass:

| Gate | Criterion |
|------|-----------|
| QG-1 | 100% test pass rate |
| QG-2 | Fabrication prevention preserved |
| QG-3 | Uncertainty acknowledgment preserved |
| QG-4 | Templates exist and accessible |
| QG-5 | Critical constraints intact |

### 5. Time-Series Tracking

Records metrics for comparison:
- Before/after measurements
- Optimization log with dates
- Hub-wide summary dashboard

## Workflow

```
MEASURE → ANALYZE → RECOMMEND → VALIDATE → TRACK
   │          │          │           │         │
   ▼          ▼          ▼           ▼         ▼
Baseline  Pattern    Generate    Quality   Record
Metrics   Matching   Plan        Gates     History
```

## Commands

| Command | Description |
|---------|-------------|
| `/optimize` | Analyze all agents |
| `/optimize {agent-id}` | Full workflow for one agent |
| `/optimize status` | Hub-wide dashboard |
| `/optimize --dry-run` | Preview without recording |

## Data Sources

### Input

| Source | Location | Purpose |
|--------|----------|---------|
| Agent definitions | `.claude/agents/*.md` | Structural metrics |
| Telemetry data | `.agent/telemetry/aggregated/` | Usage metrics |
| Pattern library | `.agent/reflection_pool/` | Optimization patterns |
| Test cases | `agents/*/test-cases.md` | Quality validation |

### Output

| Output | Location | Purpose |
|--------|----------|---------|
| Optimization plans | `.agent/metrics/agents/{id}/` | Recommendations |
| Measurements | `.agent/metrics/agents/{id}/current.json` | Baseline/current |
| Hub summary | `.agent/metrics/optimization-summary.md` | Dashboard |

## Example: Optimization Plan

```markdown
# Optimization Plan: agent-cv-optimizer

## Summary
- Optimization Score: 85/100
- Estimated Reduction: 45-55%
- Priority: High (234 invocations, 12,400 tokens)

## Recommendations

### 1. Template Externalization (PAT-01)
**Current**: 2,100 words embedded
**Target**: Extract 1,200+ words to templates
**Estimated Reduction**: 50%

Sections to externalize:
- JD analysis template → `.agent/templates/jd-analysis.md`
- Interview questions → `.agent/templates/interview-prep.md`
- Cover letter format → `.agent/templates/cover-letter.md`

### 2. Add Output Modes (PAT-03)
**Current**: Always detailed output
**Target**: Brief/Standard/Detailed modes

## Quality Gate Validation
✓ QG-1: 12/12 test cases preserved
✓ QG-2: Fabrication prevention present
✓ QG-3: Uncertainty acknowledgment present
✓ QG-4: Template paths valid
✓ QG-5: 8/8 constraints intact

Result: APPROVED
```

## Metrics Schema

```json
{
  "agent_id": "agent-git-manager",
  "measurement_date": "2026-01-24",
  "structural": {
    "lines": 108,
    "words": 946,
    "estimated_tokens": 6300,
    "sections": 5,
    "constraints": 7
  },
  "telemetry": {
    "total_invocations": 847,
    "avg_tokens": 5230,
    "success_rate": 0.992,
    "avg_duration_ms": 1200
  },
  "optimization_score": 72,
  "recommendations": ["PAT-01", "PAT-03"]
}
```

## Integration

### With agent-provisioner

```bash
# Collect telemetry from downstream projects
@agent-provisioner: telemetry-sync

# Then run optimization with fresh data
/optimize
```

### With /agent_reflect

Testimonies now include quantitative metrics:

```markdown
## Quantitative Metrics

### Agent Usage (from telemetry)
- Total Invocations: 47
- Most Active: agent-git-manager (68%)
- Avg Duration: 1.8s
- Success Rate: 98.2%
```

## Best Practices

1. **Sync telemetry first** - Run `telemetry-sync` before optimizing
2. **Start with high-usage agents** - Highest ROI
3. **Validate before applying** - Always check quality gates
4. **Track changes** - Record before/after metrics
5. **Review patterns** - Check reflection_pool for new insights

## Troubleshooting

### No telemetry data

```
Note: No telemetry data available for agent-foo
Analysis based on structural metrics only.
```

**Solution**: Run `@agent-provisioner: telemetry-sync` to collect usage data.

### Quality gate failed

```
Warning: Quality gate QG-2 failed
```

**Solution**: Review the proposed change - it may remove critical constraints.

### Agent not found

```
Error: Agent 'agent-foo' not found
```

**Solution**: Check agent name matches file in `.claude/agents/`.

## Related Documentation

- [Telemetry System](.agent/telemetry/README.md)
- [Metrics Infrastructure](.agent/metrics/README.md)
- [Reflection Pool](.agent/reflection_pool/)
- [Test Cases](test-cases.md)

---

**Version**: 1.0.0
**Status**: Production
**Created**: 2026-01-24
