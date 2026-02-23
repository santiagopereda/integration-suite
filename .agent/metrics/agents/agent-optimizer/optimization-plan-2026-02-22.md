# Optimization Plan: agent-optimizer

**Generated**: 2026-02-22
**Meta Moment**: The optimizer optimizes itself

---

## Summary

- **Optimization Score**: 60/100
- **Estimated Token Reduction**: 20-25%
- **Priority**: Medium (meta-validation exercise)
- **Category**: HYBRID (24.7% externalization potential)

## The Meta Paradox

The agent-optimizer teaches template externalization (PAT-01) but doesn't apply it to itself. The pattern library table that teaches externalization is embedded in the agent definition. This optimization creates recursive consistency: the optimizer will load its own externalized patterns.

---

## Recommendations

### 1. Template Externalization (PAT-01)

**Current**: 402 words embedded across 3 sections
**Target**: Extract to 3 template files
**Estimated Reduction**: 20-25%
**Risk**: Low (reference material, not logic)

#### Sections to Externalize:

**A. Pattern Library Table (151 words)**
- **Location**: Phase 2: ANALYZE section
- **Content**: PAT-01 through PAT-05 definitions
- **Target**: `.agent/templates/optimization/pattern-library.md`
- **Rationale**: Core reference data loaded on every analysis
- **Meta-insight**: The pattern that teaches externalization should itself be externalized

**B. Quality Gates Matrix (144 words)**
- **Location**: Phase 4: VALIDATE section
- **Content**: QG-1 through QG-5 definitions
- **Target**: `.agent/templates/optimization/quality-gates.md`
- **Rationale**: Validation reference, stable criteria

**C. Output Mode Examples (107 words)**
- **Location**: Output Modes section
- **Content**: Analysis/Optimization/Status mode formats
- **Target**: `.agent/templates/optimization/output-modes.md`
- **Rationale**: Format examples, rarely changed

#### Template Loading Strategy:

```markdown
## Phase 2: ANALYZE (Apply Patterns)

Load proven patterns from `.agent/reflection_pool/key-insights.md`:

**Pattern Library**: See `.agent/templates/optimization/pattern-library.md`

Apply pattern matching algorithm:
[existing algorithm logic remains inline]
```

### 2. Self-Consistency Validation (Meta-Check)

After optimization, verify:
- [ ] Agent loads its own pattern library template
- [ ] Quality gates reference external template
- [ ] Output modes reference external template
- [ ] No functional change (all tests pass)

---

## Quality Gate Pre-Check

| Gate | Status | Evidence |
|------|--------|----------|
| QG-1 | PENDING | No test cases exist yet (hub-only agent) |
| QG-2 | PASS | 6 fabrication constraints identified, will preserve all |
| QG-3 | PASS | "Never fabricate patterns" constraint present |
| QG-4 | PENDING | Will verify templates exist after creation |
| QG-5 | PASS | 6 critical constraints, count will be preserved |

**Pre-Check Result**: CONDITIONAL PASS (QG-1 N/A for hub-only agent, QG-4 pending template creation)

---

## Implementation Steps

### Step 1: Create Template Files (3 files)
1. Create `.agent/templates/optimization/pattern-library.md`
2. Create `.agent/templates/optimization/quality-gates.md`
3. Create `.agent/templates/optimization/output-modes.md`

### Step 2: Update Agent Definition
1. Replace embedded pattern table with reference to template
2. Replace embedded quality gates with reference to template
3. Replace embedded output modes with reference to template
4. Preserve all logic and algorithms inline

### Step 3: Validate
1. Run quality gates (Phase 4)
2. Verify all template references resolve
3. Confirm constraint count unchanged
4. Document token reduction

### Step 4: Track
1. Re-measure agent (Phase 1)
2. Calculate delta
3. Update optimization log
4. Update hub summary

---

## Expected Outcome

**Before**:
- Words: 1,628
- Tokens: ~3,183
- Externalization: 0%

**After**:
- Words: ~1,225 (removing 402 externalizable words)
- Tokens: ~2,400
- Externalization: 24.7%
- Reduction: ~24.6%

**Templates Created**: 3
**Loading Strategy**: On-demand reference
**Risk**: Minimal (reference data only)

---

## Meta-Validation

This optimization demonstrates:
1. **Self-application**: Pattern externalization applied to the agent that teaches it
2. **Recursive consistency**: Optimizer loads its own optimized structure
3. **Methodology validation**: HYBRID approach for 20-50% potential agents
4. **Pattern proof**: If PAT-01 works on the tool that teaches it, it validates the pattern

---

## Next Steps

1. ✅ Review this plan (APPROVED by user)
2. Execute implementation (Steps 1-4)
3. Run Phase 4: VALIDATE
4. Run Phase 5: TRACK
5. Document meta-insights
