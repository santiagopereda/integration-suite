# Agent Optimizer Test Cases

Validation test cases for the agent-optimizer. All tests must pass before deployment.

## Test Matrix

| ID | Category | Test Case | Critical |
|----|----------|-----------|----------|
| TC-01 | Measurement | Accurate token estimation | Yes |
| TC-02 | Measurement | Telemetry data parsing | Yes |
| TC-03 | Analysis | Pattern detection (PAT-01) | Yes |
| TC-04 | Analysis | Pattern detection (PAT-03) | No |
| TC-05 | Analysis | Score calculation | Yes |
| TC-06 | Recommendation | Plan generation format | No |
| TC-07 | Validation | Quality gate QG-1 | Yes |
| TC-08 | Validation | Quality gate QG-2 | Yes |
| TC-09 | Validation | Quality gate QG-5 | Yes |
| TC-10 | Tracking | Metrics persistence | Yes |
| TC-11 | Tracking | Optimization log update | No |
| TC-12 | Integration | Status dashboard generation | No |

**Pass Requirement**: 12/12 (100%)
**Critical Tests**: 7/12 must pass

---

## TC-01: Accurate Token Estimation

**Category**: Measurement
**Critical**: Yes

**Input**:
```
Agent file with known word count: 946 words
```

**Expected**:
```json
{
  "words": 946,
  "estimated_tokens": 6300  // ~6.7 tokens per word
}
```

**Validation**:
- [ ] Token estimate within 10% of manual calculation
- [ ] Word count exact match
- [ ] Line count accurate

---

## TC-02: Telemetry Data Parsing

**Category**: Measurement
**Critical**: Yes

**Input**:
```json
// .agent/telemetry/aggregated/agent-git-manager.json
{
  "agent_id": "agent-git-manager",
  "total_invocations": 847,
  "avg_tokens": 5230,
  "success_rate": 0.992
}
```

**Expected**:
- Correctly reads all fields
- Handles missing telemetry gracefully
- Reports "telemetry not available" when file absent

**Validation**:
- [ ] Invocation count parsed correctly
- [ ] Success rate calculated
- [ ] Missing file handled with fallback

---

## TC-03: Pattern Detection - Template Externalization

**Category**: Analysis
**Critical**: Yes

**Input**:
```
Agent with 2,100 words embedded content
No template references in definition
```

**Expected**:
```
Pattern: PAT-01 (Template Externalization)
Reason: Embedded content > 100 words (threshold: 100, actual: 2,100)
Estimated Reduction: 50-60%
```

**Validation**:
- [ ] Pattern correctly identified
- [ ] Threshold comparison accurate
- [ ] Reduction estimate in expected range

---

## TC-04: Pattern Detection - Output Modes

**Category**: Analysis
**Critical**: No

**Input**:
```
Agent without "Output Modes" or "Verbosity" section
```

**Expected**:
```
Pattern: PAT-03 (Output Modes)
Reason: No verbosity control found
Benefit: User control over output length
```

**Validation**:
- [ ] Missing output modes detected
- [ ] Recommendation generated

---

## TC-05: Score Calculation

**Category**: Analysis
**Critical**: Yes

**Input**:
```
Agent with:
- 12,400 estimated tokens (high)
- 234 invocations (moderate usage)
- No template externalization
- No output modes
```

**Expected**:
```
Score: 85/100
Breakdown:
- Token potential: +60 (>10,000 tokens)
- Usage weight: ×1.17 (234/200)
- Missing output modes: +15
```

**Validation**:
- [ ] Score formula applied correctly
- [ ] Usage weighting accurate
- [ ] Score in 0-100 range

---

## TC-06: Plan Generation Format

**Category**: Recommendation
**Critical**: No

**Input**:
```
Agent: agent-cv-optimizer
Score: 85
Patterns: [PAT-01, PAT-03]
```

**Expected**:
- Markdown format with sections
- Summary with score, reduction, priority
- Recommendations with estimates
- Quality gate pre-check section
- Next steps section

**Validation**:
- [ ] All required sections present
- [ ] Markdown renders correctly
- [ ] Estimates are reasonable

---

## TC-07: Quality Gate QG-1 (Test Pass Rate)

**Category**: Validation
**Critical**: Yes

**Input**:
```
Agent with 10 test cases
Proposed optimization removes capability tested by TC-05
```

**Expected**:
```
QG-1: FAIL
Reason: Test case TC-05 would fail after optimization
Blocked: Optimization cannot proceed
```

**Validation**:
- [ ] Test case analysis performed
- [ ] Capability loss detected
- [ ] Optimization blocked

---

## TC-08: Quality Gate QG-2 (Fabrication Prevention)

**Category**: Validation
**Critical**: Yes

**Input**:
```
Agent with "Never fabricate" constraint
Proposed optimization removes this section
```

**Expected**:
```
QG-2: FAIL
Reason: Fabrication prevention constraint would be removed
Line: Previously at line 31, now absent
Blocked: Critical safety constraint cannot be removed
```

**Validation**:
- [ ] Fabrication constraint detected in original
- [ ] Removal detected in proposed
- [ ] Optimization blocked with clear reason

---

## TC-09: Quality Gate QG-5 (Constraints Intact)

**Category**: Validation
**Critical**: Yes

**Input**:
```
Agent with 7 constraints
Proposed optimization has 6 constraints
```

**Expected**:
```
QG-5: FAIL
Reason: Constraint count reduced (7 → 6)
Missing: "Always verify before committing"
Blocked: Cannot remove constraints without approval
```

**Validation**:
- [ ] Constraint count compared
- [ ] Missing constraint identified
- [ ] Failure reported with specifics

---

## TC-10: Metrics Persistence

**Category**: Tracking
**Critical**: Yes

**Input**:
```
Measure agent-git-manager
```

**Expected**:
```
File created: .agent/metrics/agents/agent-git-manager/current.json
Contents match measurement
History updated: history/2026-01-24.json
```

**Validation**:
- [ ] JSON file created
- [ ] All fields populated
- [ ] History snapshot saved

---

## TC-11: Optimization Log Update

**Category**: Tracking
**Critical**: No

**Input**:
```
Apply optimization to agent-git-manager
Before: 946 words, 6,300 tokens
After: 512 words, 3,400 tokens
```

**Expected**:
```markdown
### 2026-01-24: Template Externalization

**Agent**: agent-git-manager
**Pattern**: PAT-01
**Before**: 946 words, ~6,300 tokens
**After**: 512 words, ~3,400 tokens
**Reduction**: 46%
**Validation**: All quality gates passed
```

**Validation**:
- [ ] Log entry added
- [ ] Before/after accurate
- [ ] Date stamped

---

## TC-12: Status Dashboard Generation

**Category**: Integration
**Critical**: No

**Input**:
```
Hub with 7 agents
3 optimized, 4 not optimized
```

**Expected**:
```markdown
# Hub Optimization Status

| Agent | Baseline | Current | Reduction | Last Optimized |
|-------|----------|---------|-----------|----------------|
| agent-sap-bp | 15,000 | 6,300 | 58% | 2025-11-28 |
| agent-ansible | 16,000 | 6,493 | 59% | 2025-11-28 |
| agent-git-manager | 6,300 | - | - | Never |
...

Summary:
- Optimized: 3/7 (43%)
- Total savings: ~18,000 tokens
```

**Validation**:
- [ ] All agents listed
- [ ] Metrics accurate
- [ ] Summary calculated

---

## Aggregate Validation

### Pre-Deployment Checklist

- [ ] All 12 test cases pass
- [ ] 7/7 critical tests pass
- [ ] No regressions from previous version
- [ ] Integration with telemetry verified
- [ ] Quality gates enforce correctly

### Performance Criteria

| Metric | Target |
|--------|--------|
| Measurement time | < 2s per agent |
| Analysis time | < 5s per agent |
| Dashboard generation | < 3s |

---

**Version**: 1.0.0
**Last Validated**: 2026-01-24
**Validated By**: Pending
