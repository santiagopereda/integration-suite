# 6-Week Agent Improvement Cycle

Formal process for continuous agent improvement using telemetry data, user feedback, and cross-project learnings.

## Overview

**Purpose**: Systematically improve agents through data-driven iteration.

**Cadence**: 6-week cycles (aligned with typical project sprints).

**Data Sources**:
- OTEL telemetry (token usage, error rates, timing)
- User feedback (quality ratings 1-5)
- Cross-project testimonies
- Test case results

## Cycle Timeline

```
Week 1-2: COLLECT
    ↓
Week 3-4: ANALYZE
    ↓
Week 5-6: IMPROVE
    ↓
[Next Cycle]
```

---

## Week 1-2: COLLECT

**Goal**: Gather comprehensive data from deployed agents.

### Daily Tasks

- [ ] Monitor OTEL telemetry dashboard
- [ ] Review any error logs or failures
- [ ] Note user feedback submissions

### Weekly Tasks

- [ ] Run `/agent-status --metrics` for hub dashboard
- [ ] Export telemetry data: `./query-telemetry.sh --week`
- [ ] Sync feedback from projects: `jq '.ratings' .agent/telemetry/data/feedback.jsonl`

### Data Collection Checklist

| Data Type | Source | Format | Frequency |
|-----------|--------|--------|-----------|
| Token usage | OTEL collector | JSONL | Real-time |
| Error rates | OTEL spans | JSONL | Real-time |
| User ratings | feedback_capture.sh | JSONL | Per-invocation |
| Testimonies | /agent_reflect | Markdown | End of project |
| Test results | /agent-test | Markdown | On-demand |

### Telemetry Commands

```bash
# Check OTEL collector is running
docker compose ps

# View recent telemetry
tail -100 .agent/telemetry/otel/data/telemetry.jsonl | jq .

# Query metrics by agent
./query-telemetry.sh --today | grep "agent-git-manager"

# Calculate quality scores
jq -s 'group_by(.agent_id) | map({
  agent: .[0].agent_id,
  count: length,
  avg_rating: (map(.rating) | add / length)
})' .agent/telemetry/data/feedback.jsonl
```

---

## Week 3-4: ANALYZE

**Goal**: Identify patterns, problems, and improvement opportunities.

### Analysis Framework

#### 1. Performance Analysis

Run `/optimize status` to get hub-wide optimization dashboard.

**Key Metrics**:
| Metric | Good | Warning | Critical |
|--------|------|---------|----------|
| Token usage | < 5K | 5-10K | > 10K |
| Error rate | < 1% | 1-5% | > 5% |
| Quality score | > 4.0 | 3.0-4.0 | < 3.0 |
| Test pass rate | 100% | 90-99% | < 90% |

#### 2. Pattern Identification

Review reflection pool for patterns:

```bash
# Check for new insights
cat .agent/reflection_pool/key-insights.md

# Review recent testimonies
ls -la .agent/reflection_pool/testimonies/
```

**Pattern Categories**:
- Success patterns → Document and replicate
- Failure patterns → Root cause and fix
- Optimization opportunities → Add to backlog

#### 3. Quality Gate Analysis

Run `/agent-test` on all agents:

```bash
/agent-test all
```

Review any failures against quality gates:
- QG-1: Test pass rate (should be 100%)
- QG-2: Fabrication constraints (must be present)
- QG-3: Uncertainty acknowledgment (must be present)
- QG-4: Template existence (all referenced files exist)
- QG-5: Critical constraints (no removals)
- QG-6: Quality score (>= 4.0)

### Analysis Outputs

Create analysis summary:

```markdown
# Improvement Cycle Analysis: Cycle {N}
## Period: {start-date} to {end-date}

## Performance Summary

| Agent | Invocations | Tokens/Inv | Errors | Quality |
|-------|-------------|------------|--------|---------|
| agent-git-manager | 45 | 3,200 | 0 | 4.5 |
| agent-cv-optimizer | 12 | 8,500 | 1 | 4.2 |

## Patterns Identified

### Success Patterns
- [Pattern 1]

### Issues Found
- [Issue 1]: Root cause and impact

## Improvement Candidates

| Agent | Opportunity | Expected Impact |
|-------|-------------|-----------------|
| agent-cv-optimizer | Template externalization | 50% token reduction |

## Recommendations

1. [Recommendation 1]
2. [Recommendation 2]
```

---

## Week 5-6: IMPROVE

**Goal**: Apply improvements and validate quality.

### Improvement Workflow

#### Step 1: Prioritize

Rank improvements by:
1. **Impact**: Token savings × invocation frequency
2. **Risk**: Quality degradation probability
3. **Effort**: Implementation complexity

#### Step 2: Implement

For each improvement:

```bash
# 1. Create backup
cp .claude/agents/{agent-id}.md .agent/backups/{agent-id}-pre-{date}.md

# 2. Apply changes
# (Manual edits or /optimize pattern application)

# 3. Validate quality gates
/agent-test {agent-id}
```

#### Step 3: Validate

Run full validation:

```bash
# Structural validation
/agent-test {agent-id}

# Quality gate check
# - QG-1: 100% test pass
# - QG-2: Fabrication constraints present
# - QG-3: Uncertainty acknowledgment present
# - QG-4: All templates exist
# - QG-5: Critical constraints intact
```

#### Step 4: Deploy

If validation passes:

```bash
# Update version in registry
# Edit agents-registry.json

# Sync to deployed projects
@agent-provisioner: sync-updated {agent-id}

# Update metrics
# Record optimization in .agent/metrics/optimization-log.json
```

### Improvement Checklist

- [ ] Backup created
- [ ] Changes applied
- [ ] Tests pass (100%)
- [ ] Fabrication constraints verified
- [ ] Uncertainty acknowledgment verified
- [ ] Templates exist
- [ ] Critical constraints intact
- [ ] Quality score maintained (>= 4.0)
- [ ] Version updated in registry
- [ ] Deployed to projects
- [ ] Metrics recorded

---

## Cycle Documentation

### Cycle Summary Template

Store in `.agent/metrics/cycles/`:

```markdown
# Improvement Cycle {N}: {start-date} to {end-date}

## Summary
- Agents analyzed: {count}
- Improvements applied: {count}
- Token savings: {total} tokens/cycle
- Quality maintained: Yes/No

## Changes Applied

| Agent | Change | Before | After | Validation |
|-------|--------|--------|-------|------------|
| agent-cv-optimizer | Template ext. | 12K | 6K | ✓ All gates |

## Key Learnings
- [Learning 1]
- [Learning 2]

## Carry Forward
- [Item for next cycle]
```

### Registry Updates

After each cycle, update:
1. `agents-registry.json` - Version numbers, metrics
2. `.agent/metrics/optimization-log.json` - Changes applied
3. `.agent/reflection_pool/key-insights.md` - New patterns

---

## Automation

### Scheduled Tasks

| Task | Command | Frequency |
|------|---------|-----------|
| Collect telemetry | `./query-telemetry.sh --week > weekly-report.md` | Weekly |
| Quality check | `/agent-test all` | Weekly |
| Status dashboard | `/agent-status --metrics` | Weekly |
| Cycle summary | Manual | Every 6 weeks |

### Future Automation (Planned)

- GitHub Action for weekly telemetry reports
- Automated quality gate checks on PR
- Slack notifications for quality degradation

---

## Quality Gates Reference

| Gate | Requirement | Check |
|------|-------------|-------|
| QG-1 | 100% test pass rate | `/agent-test {agent-id}` |
| QG-2 | Fabrication constraints | `grep -i "never fabricate" .claude/agents/{agent-id}.md` |
| QG-3 | Uncertainty acknowledgment | `grep -i "acknowledges" .claude/agents/{agent-id}.md` |
| QG-4 | Templates exist | Check all `.agent/templates/` references |
| QG-5 | Critical constraints | Manual review |
| QG-6 | Quality score >= 4.0 | `jq '.ratings' feedback.jsonl` |

---

**Version**: 1.0.0
**Created**: 2026-01-25
**Cycle Duration**: 6 weeks
