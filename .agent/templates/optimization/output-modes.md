# Optimization Output Modes

Format templates for agent-optimizer responses. Referenced by `agent-optimizer` for consistent output formatting.

---

## Analysis Mode

Use when running `analyze` command - shows optimization opportunities across agents.

**Format**:
```
Agent Optimization Analysis

| Agent | Tokens | Invocations | Score | Priority |
|-------|--------|-------------|-------|----------|
| agent-cv-optimizer | 12,400 | 234 | 85 | High |
| agent-git-manager | 5,230 | 847 | 72 | High |
| agent-robotarm-tester | 8,900 | 156 | 45 | Medium |

Top Recommendations:
1. agent-cv-optimizer: Template externalization (45-55% reduction)
2. agent-git-manager: Output modes (user control)
3. agent-robotarm-tester: Section compression (15-20% reduction)

Agents Analyzed: 7
Optimization Opportunities: 3 High, 2 Medium, 2 Low
```

**Components**:
- Table: Agent name, token count, usage frequency, optimization score, priority
- Recommendations: Top 3-5 ranked by impact
- Summary: Total counts by priority tier

---

## Optimization Mode

Use when generating full optimization plans.

**Components**:
1. **Summary Section**
   - Optimization score
   - Estimated token reduction
   - Priority level
   - Category (FULL/HYBRID/MINIMAL)

2. **Recommendations Section**
   - Pattern ID and name
   - Current state vs target state
   - Estimated reduction percentage
   - Risk level
   - Specific sections to externalize/compress

3. **Quality Gate Pre-Check**
   - All 6 gates listed
   - Status for each (PASS/PENDING/N/A)
   - Evidence or rationale

4. **Implementation Steps**
   - Numbered steps with clear actions
   - File paths and specific changes
   - Validation checkpoints

5. **Expected Outcome**
   - Before/After comparison
   - Metrics (words, tokens, reduction %)
   - Risk assessment

---

## Status Mode (Dashboard)

Use when showing hub-wide optimization status.

**Format**:
```markdown
# Hub Optimization Status

**Last Updated**: 2026-02-22
**Total Agents**: 17
**Optimized**: 5 (29%)
**Pending**: 12

## Summary

| Agent | Baseline | Current | Reduction | Last Optimized |
|-------|----------|---------|-----------|----------------|
| agent-sap-bp | 15,000 | 6,300 | 58% | 2025-11-28 |
| agent-ansible | 16,000 | 6,493 | 59% | 2025-11-28 |
| agent-cv-optimizer | 7,800 | 3,700 | 52.5% | 2026-02-22 |
| agent-optimizer | 3,183 | 2,400 | 24.6% | 2026-02-22 |
| agent-robotarm-tester | 4,320 | 4,060 | 6% | 2026-02-22 |

## Optimization Pipeline

### Tier 1: High Impact (Completed)
- agent-cv-optimizer: 52.5% reduction ✓
- agent-optimizer: 24.6% reduction ✓
- agent-robotarm-tester: 6% reduction ✓

### Tier 2: High Usage (Pending)
- agent-git-manager: Est. 30-40% reduction
- agent-provisioner: Est. 15-25% reduction

### Tier 3: Deferred
- Low usage agents: 7 agents

## Next Actions
1. Review Tier 1 results
2. Assess Tier 2 approach based on patterns
3. Schedule monthly optimization review
```

**Components**:
- Header: Date, totals, completion percentage
- Summary Table: All optimized agents with metrics
- Pipeline: Organized by tier (completed/pending/deferred)
- Next Actions: Clear prioritized steps

---

## Validation Mode

Use when running quality gate validation.

**Format**:
```markdown
# Validation Report: agent-optimizer

## Quality Gates

| Gate | Status | Evidence |
|------|--------|----------|
| QG-1 | N/A | Hub-only agent, no test cases |
| QG-2 | PASS | 6 fabrication constraints preserved |
| QG-3 | PASS | "Never fabricate patterns" at line 340 |
| QG-4 | PASS | 3 templates created and verified |
| QG-5 | PASS | 6 constraints before, 6 after |
| QG-6 | N/A | No telemetry data available |

**Result**: APPROVED

All critical gates passed. Templates externalized successfully with no constraint degradation.
```

---

## Brief Mode (Quick Response)

Use for simple status queries.

**Format**:
```
agent-optimizer: 3,183 → 2,400 tokens (24.6% reduction)
Status: Optimized 2026-02-22
Pattern: PAT-01 (Template Externalization - HYBRID)
Templates: 3 (pattern-library, quality-gates, output-modes)
```

---

**Maintained By**: agent-optimizer
**Version**: 1.0
