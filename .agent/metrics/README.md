# Agent Performance Metrics

This directory tracks performance metrics for all agents in the repository, enabling data-driven optimization and quality monitoring.

## Purpose

Track and measure:
- **Token Usage**: Prompt sizes and reduction progress
- **Performance**: Response times and optimization impact
- **Quality**: Test pass rates and documentation scores
- **Usage**: Invocation frequency and patterns

## Directory Structure

```
metrics/
├── README.md                           ← This file
├── token-usage-baseline.json          ← Pre-optimization baseline
├── token-usage-current.json           ← Current measurements
├── optimization-log.md                ← History of optimizations
├── phase2-validation-summary.md       ← Phase 2 test case validation
└── test-history/                      ← Test results over time
    ├── agent-sap-businesspartner-integration/
    │   ├── 2025-11-28.json
    │   └── baseline.json
    └── agent-ansible-automation/
        ├── 2025-11-28.json
        └── baseline.json
```

## Metrics Tracked

### Token Usage Metrics

**Baseline** (`token-usage-baseline.json`):
- Original agent prompt word count
- Original agent prompt line count
- Estimated token count (pre-optimization)
- Externalizablecontent identified
- Reduction potential percentage

**Current** (`token-usage-current.json`):
- Current prompt word count
- Current prompt line count
- Current estimated token count
- Actual reduction achieved
- Template loading overhead

### Performance Metrics

- Agent invocation count
- Average response time
- Token cost per invocation
- Template loading time
- Net token savings

### Quality Metrics

- Test pass rate (%)
- Documentation quality score (0-100)
- Reference validity (%)
- Quality score trends
- Structural capability verification
- Critical test validation (uncertainty acknowledgment, security, testing)

### Usage Metrics

- Invocations per week/month
- Unique users
- Common use cases
- Failure patterns

## How to Use

### Capturing Baseline

Before optimization, capture baseline metrics:

```json
{
  "measurement_date": "2025-11-28",
  "phase": "baseline_pre_optimization",
  "agents": {
    "agent-id": {
      "prompt_words": 2249,
      "prompt_lines": 294,
      "estimated_tokens": 15000,
      "externalizable_words": 1220,
      "reduction_potential_percent": 54
    }
  }
}
```

### Tracking Optimizations

Document each optimization in `optimization-log.md`:

```markdown
### 2025-11-28: Template Externalization

**Agent**: agent-sap-businesspartner-integration
**Type**: Template externalization
**Changes**:
- Extracted bp-integration-doc.md (400 words)
- Extracted bp-quality-checklist.md (120 words)
- Extracted sap-agiloft-context.md (450 words)

**Impact**:
- Prompt size: 2,249 → 750 words (67% reduction)
- Token reduction: ~15,000 → ~5,000 (10,000 saved)
- Templates created: 3

**Validation**:
- All tests passing: ✓
- Quality maintained: ✓
- Functionality preserved: ✓
```

### Validating Optimizations

After optimization, validate that all capabilities are preserved:

**Structural Capability Verification**:
- Compare refactored agent against test case requirements
- Verify all expertise areas are present
- Confirm required templates are available and referenced
- Validate critical constraints are intact
- Check quality validation mechanisms remain functional

**Documentation**: Create validation summary (e.g., `phase2-validation-summary.md`) with:
- Test case verification matrix (all test cases against requirements)
- Capability preservation checklist
- Critical section comparison (before/after)
- Aggregate pass criteria validation
- Production readiness assessment

**Example Validation Summary**:
```markdown
## Test Case Validation Matrix

| Test Case | Requirement | Status | Critical |
|-----------|-------------|--------|----------|
| TC-01 | Basic Role Creation | ✅ PASS | No |
| TC-11 | Uncertainty Acknowledgment | ✅ PASS | Yes |

**Pass Rate**: 12/12 (100%)
**Critical Tests Passed**: 4/4
**Production Readiness**: ✅ APPROVED
```

### Comparing Results

Compare baseline vs current to measure impact:

```bash
# Baseline
Prompt: 2,249 words / ~15,000 tokens

# Current
Prompt: 750 words / ~5,000 tokens
Template loading: ~500 tokens (when needed)

# Net Savings
Per invocation: ~9,500-10,000 tokens
Monthly (100 invocations): ~1,000,000 tokens
```

## Success Metrics

### Target Reductions

| Agent | Baseline | Achieved | Reduction |
|-------|----------|----------|-----------|
| SAP BP | 15,000 tokens | 6,300 tokens | 58% |
| Ansible | 16,000 tokens | 6,493 tokens | 59% |

### Quality Gates

All optimizations must maintain:
- ✓ 100% test pass rate
- ✓ No functionality loss
- ✓ Documentation quality ≥ baseline
- ✓ Professional communication maintained

### ROI Calculation

**Phase 1 + Phase 2 Results**:
- SAP BP Agent: 8,700 tokens saved per invocation (net)
- Ansible Agent: 9,057 tokens saved per invocation (net)
- Average savings: 8,879 tokens per invocation

**Monthly Savings** (estimated):
- 240 agent invocations/month (10/agent/month × 2 agents × 12 months)
- Average 8,879 tokens saved per invocation
- **Total**: ~2.1M tokens/year saved

**Break-even**: Immediate (first invocation recovers optimization investment)

## Monitoring & Reporting

### Weekly Review
- Check token usage trends
- Monitor quality scores
- Review test pass rates
- Identify optimization opportunities

### Monthly Analysis
- Calculate actual savings
- Compare to targets
- Adjust strategies if needed
- Report to team

### Quarterly Assessment
- Full metrics review
- ROI calculation
- Strategic planning
- Tool improvements

---

**Created**: 2025-11-28
**Version**: 1.0.0
**Maintained By**: Agent Architecture Team
