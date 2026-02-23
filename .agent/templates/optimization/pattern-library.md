# Optimization Pattern Library

Standard patterns for agent optimization. Referenced by `agent-optimizer` during Phase 2: ANALYZE.

---

## Pattern Definitions

| Pattern ID | Pattern | Trigger | Expected Reduction |
|------------|---------|---------|-------------------|
| PAT-01 | Template Externalization | Embedded content > 100 words | 51-65% (FULL), 20-30% (HYBRID), 5-10% (MINIMAL) |
| PAT-02 | Lazy Loading | Templates loaded unconditionally | 5% overhead reduction |
| PAT-03 | Output Modes | No verbosity control | N/A (user control benefit) |
| PAT-04 | Section Compression | Similar agent has fewer lines | 15-30% |
| PAT-05 | Verification-First | No verification constraint | Quality improvement |

---

## Pattern Details

### PAT-01: Template Externalization

**Trigger**: Embedded content blocks > 100 words

**Approach by Externalization Potential**:
- **FULL (>50%)**: Externalize all reference content, examples, workflows
  - Example: cv-optimizer (69% potential → 52.5% actual reduction)
- **HYBRID (20-50%)**: Externalize tables, examples, reference data
  - Example: agent-optimizer (24.7% potential → 20-25% predicted)
- **MINIMAL (<20%)**: Selective externalization of largest sections only
  - Example: robotarm-tester (12% potential → 6% actual reduction)

**Risk**: Low (reference material doesn't affect logic)

### PAT-02: Lazy Loading

**Trigger**: Templates loaded unconditionally at agent startup

**Solution**: Reference templates in text, load only when needed

**Benefit**: Reduces baseline token consumption by ~5%

### PAT-03: Output Modes

**Trigger**: Fixed verbosity, no user control over detail level

**Solution**: Implement Brief/Standard/Detailed modes

**Benefit**: User control, reduced tokens for quick queries

### PAT-04: Section Compression

**Trigger**: Comparing agents reveals structural bloat

**Solution**: Identify redundant sections, merge similar content

**Benefit**: 15-30% reduction through structural efficiency

### PAT-05: Verification-First

**Trigger**: Missing fabrication prevention or uncertainty acknowledgment

**Solution**: Add explicit constraints against hallucination

**Benefit**: Quality improvement, prevents false positives

---

## Application Priority

1. High usage + high potential = Immediate
2. High usage + medium potential = Scheduled
3. Low usage + high potential = Deferred
4. Low usage + low potential = Skip

---

**Source**: Extracted from cross-project analysis (2025-11-28 to 2026-02-22)
**Evidence**: robotarm-tester, cv-optimizer, ansible-automation optimizations
**Maintained By**: agent-optimizer
**Version**: 1.0
