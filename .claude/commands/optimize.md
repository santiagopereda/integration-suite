# /optimize - Agent Optimization Command

Analyze and optimize agents using structural analysis and telemetry data.

## Quick Reference

| Aspect | Details |
|--------|---------|
| **Invocation** | `/optimize [agent-id]` or `/optimize --all` |
| **Agent Used** | `agent-optimizer` |
| **Version** | 1.0.0 |
| **Data Sources** | `.agent/metrics/`, `.agent/telemetry/`, `.agent/reflection_pool/` |
| **Output** | Optimization plan, metrics update |

## Usage

### Analyze All Agents

```bash
/optimize
```

Runs analysis on all agents and shows optimization opportunities ranked by priority.

### Optimize Specific Agent

```bash
/optimize agent-git-manager
```

Full optimization workflow for a single agent:
1. Measure current state
2. Analyze against patterns
3. Generate recommendations
4. Validate quality gates
5. (Optionally) apply changes

### Status Dashboard

```bash
/optimize status
```

Shows hub-wide optimization summary with all agents' metrics.

### Dry Run

```bash
/optimize agent-git-manager --dry-run
```

Show recommendations without recording metrics or making changes.

## Options

| Option | Description |
|--------|-------------|
| `--all` | Analyze all agents in hub |
| `--dry-run` | Show recommendations only, no metrics recorded |
| `--verbose` | Include detailed pattern matching analysis |
| `--force` | Skip quality gate confirmations |

## Workflow

```
┌─────────┐     ┌─────────┐     ┌───────────┐     ┌──────────┐     ┌───────┐
│ MEASURE │ ──▶ │ ANALYZE │ ──▶ │ RECOMMEND │ ──▶ │ VALIDATE │ ──▶ │ TRACK │
└─────────┘     └─────────┘     └───────────┘     └──────────┘     └───────┘
     │               │                │                 │              │
     ▼               ▼                ▼                 ▼              ▼
  Baseline       Pattern          Optimization     Quality         Record
  Metrics        Matching         Plan             Gates           History
```

## Data Sources

### Structural Analysis
- Agent definition files (`.claude/agents/*.md`)
- Lines, words, estimated tokens
- Section structure, constraints, template references

### Telemetry Data
- Cross-project usage (`.agent/telemetry/aggregated/`)
- Invocation counts, token usage, success rates
- Error patterns and duration metrics

### Proven Patterns
- Reflection pool insights (`.agent/reflection_pool/key-insights.md`)
- Template externalization (51-65% reduction)
- Lazy loading, output modes, section compression

## Quality Gates

All optimizations must pass these gates:

| Gate | Criterion |
|------|-----------|
| QG-1 | 100% test pass rate maintained |
| QG-2 | No fabrication constraints removed |
| QG-3 | Uncertainty acknowledgment preserved |
| QG-4 | All referenced templates exist |
| QG-5 | Critical constraints intact |

## Example Output

### Analysis Mode

```
Agent Optimization Analysis
===========================

| Agent               | Tokens | Invocations | Score | Priority |
|---------------------|--------|-------------|-------|----------|
| agent-cv-optimizer  | 12,400 | 234         | 85    | High     |
| agent-git-manager   | 5,230  | 847         | 72    | High     |
| agent-robotarm      | 8,900  | 156         | 45    | Medium   |

Top Recommendations:
1. agent-cv-optimizer: Template externalization (45-55% reduction)
2. agent-git-manager: Add output modes (user control)
3. agent-robotarm: Section compression (15-20% reduction)
```

### Optimization Plan

```markdown
# Optimization Plan: agent-git-manager

## Summary
- Optimization Score: 72/100
- Estimated Reduction: 35-45%
- Priority: High (847 invocations)

## Recommendations

### 1. Template Externalization (PAT-01)
Current: 946 words embedded
Target: Extract 400+ words
Estimated Reduction: 40%

### 2. Add Output Modes (PAT-03)
Current: Fixed verbosity
Benefit: User control, reduced tokens

## Quality Gate Pre-Check
✓ QG-1: 10/10 test cases preserved
✓ QG-2: Fabrication prevention present
✓ QG-3: Uncertainty acknowledgment present
✓ QG-4: All templates exist
✓ QG-5: 7/7 constraints intact

Result: APPROVED for optimization
```

## Related Commands

- `/agent_reflect` - Generate testimony with telemetry metrics
- `@agent-provisioner: telemetry-sync` - Sync usage data from projects

## Related Documentation

- [Telemetry README](.agent/telemetry/README.md) - Telemetry system overview
- [Metrics README](.agent/metrics/README.md) - Metrics infrastructure
- [Reflection Pool](.agent/reflection_pool/) - Proven patterns

---

**Version**: 1.0.0
**Created**: 2026-01-24
