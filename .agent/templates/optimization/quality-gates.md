# Optimization Quality Gates

Validation criteria for agent optimizations. Referenced by `agent-optimizer` during Phase 4: VALIDATE.

---

## Gate Definitions

| Gate | Criterion | Verification Method |
|------|-----------|---------------------|
| QG-1 | 100% test pass rate | Structural analysis against test cases in `agents/{agent-id}/test-cases.md` |
| QG-2 | No fabrication constraints removed | Grep for "Never fabricate", "Never invent", "Do not hallucinate" - count must match baseline |
| QG-3 | Uncertainty acknowledgment preserved | Check "Acknowledge Limitations" or "Acknowledge uncertainty" section exists |
| QG-4 | Templates valid | Verify all referenced template files exist at specified paths |
| QG-5 | Critical constraints intact | Compare constraint count before/after (grep "MUST\|NEVER\|CRITICAL") |
| QG-6 | Quality score >= 4.0/5 | From user feedback (if available via telemetry) |

---

## Gate Details

### QG-1: Test Pass Rate

**Requirement**: 100% of existing test cases must pass after optimization

**Verification**:
1. Load test cases from `agents/{agent-id}/test-cases.md`
2. Structurally analyze optimized agent against each test
3. Confirm all capabilities preserved

**Exemption**: Hub-only agents without test cases (N/A status acceptable)

### QG-2: Fabrication Prevention

**Requirement**: All fabrication prevention constraints preserved

**Keywords to Check**:
- "Never fabricate"
- "Never invent"
- "Do not hallucinate"
- "Always acknowledge when uncertain"

**Verification**: Count before/after must match exactly

### QG-3: Uncertainty Acknowledgment

**Requirement**: Section acknowledging limitations must exist

**Common Patterns**:
- "Acknowledge Limitations"
- "Acknowledge uncertainty"
- "When in doubt, ask"

**Verification**: Section present (can be reworded, but must exist)

### QG-4: Template Validity

**Requirement**: All externalized templates must exist and be readable

**Verification**:
1. Extract all `.md` file references from agent definition
2. Verify each file exists at specified path
3. Confirm files are readable (not empty, valid markdown)

### QG-5: Critical Constraints

**Requirement**: Constraint count preserved (or increased, never decreased)

**Verification**:
```bash
# Before
grep -i "MUST\|NEVER\|CRITICAL" agent.md | wc -l

# After
grep -i "MUST\|NEVER\|CRITICAL" agent.md | wc -l

# Compare: after >= before
```

### QG-6: Quality Score

**Requirement**: Average user rating >= 4.0/5 (if feedback exists)

**Source**: `.agent/telemetry/aggregated/{agent-id}.json`

**Exemption**: Agents without deployment history (N/A status acceptable)

---

## Validation Matrix Template

Use this format for validation results:

```markdown
| Gate | Status | Evidence |
|------|--------|----------|
| QG-1 | PASS/FAIL/N/A | [Specific evidence] |
| QG-2 | PASS/FAIL | [Constraint count or preserved lines] |
| QG-3 | PASS/FAIL | [Section reference or line numbers] |
| QG-4 | PASS/FAIL | [Template file count or missing files] |
| QG-5 | PASS/FAIL | [Constraint count comparison] |
| QG-6 | PASS/FAIL/N/A | [Quality score if available] |

**Result**: APPROVED / CONDITIONAL / REJECTED
```

---

## Decision Rules

- **APPROVED**: All gates PASS (N/A acceptable for QG-1, QG-6)
- **CONDITIONAL**: Minor issues, requires review
- **REJECTED**: Any critical gate (QG-2, QG-3, QG-5) fails

---

**Source**: Established during agent optimization framework development
**Maintained By**: agent-optimizer
**Version**: 1.0
