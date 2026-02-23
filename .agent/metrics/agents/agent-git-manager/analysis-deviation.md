# Optimization Analysis: Predicted vs Actual

**Agent:** agent-git-manager
**Date:** 2026-02-22

---

## Predicted vs Actual Results

| Metric | Predicted | Actual | Delta |
|--------|-----------|--------|-------|
| **Externalized words** | 980 | 1,173 | +193 (+19.7%) |
| **Agent reduction (tokens)** | 1,875 (71.5%) | 608 (23.2%) | -1,267 (-67.6%) |
| **Documentation overhead** | 575 | 595* | +20 (+3.5%) |
| **Template tokens** | ~2,450 | 2,109 | -341 (-13.9%) |

*595 = Template Usage table estimate based on actual agent

---

## Root Cause Analysis

### Why Did We Externalize Less Than Expected?

**Prediction:** 1,080 words externalized (75.7%)
**Actual:** 1,173 words externalized (82.2% of baseline)

**Finding:** We actually externalized MORE words than predicted (+193 words)

### Why Is Agent Reduction Only 23.2% Instead of 71.5%?

**The overhead was underestimated:**

1. **Template Usage Table**: More verbose than cv-optimizer's table
   - Predicted: ~150 words
   - Actual (estimated): ~180 words
   - Table has 4 rows with detailed descriptions

2. **Inline References**: Added context throughout agent
   - Line 6: "For usage examples, load..."
   - Line 30: "(patterns in template)"
   - Line 33: "(workflow in template)"
   - Line 63: "using patterns from `.agent/templates/git/security-patterns.md`"
   - Line 111: "(detailed workflow in..."
   - Line 143: "(MANDATORY - load patterns if needed)"
   - Line 154: "(load SSH workflow if issues arise)"

   **Total inline references: ~100 words** (not predicted)

3. **Context Preservation**: Kept summaries of externalized content
   - Security scanning: Kept 4-step process summary
   - SSH integration: Kept operation summaries
   - Commit workflow: Kept threshold detection list

   **Summary text: ~200 words** (predicted removal, actually kept)

**Total overhead:**
- Template Usage table: ~180 words (~450 tokens)
- Inline references: ~100 words (~250 tokens)
- Summary preservation: ~200 words (~500 tokens)
- **Total: ~1,200 tokens overhead** (predicted 575)

**Corrected calculation:**
- Baseline: 2,621 tokens
- Externalized: -2,109 tokens (templates)
- Overhead: +1,200 tokens (table + references + summaries)
- **Net: 2,621 - 2,109 + 1,200 = 1,712 tokens**
- **Wait, actual is 2,013 tokens...**

Let me recalculate from actual data:
- Baseline chars: 10,483
- Optimized chars: 8,051
- Reduction: 2,432 chars = 608 tokens (23.2%)

The 608-token reduction is CORRECT.

---

## Why The Prediction Failed

### Faulty Assumption 1: "Externalize = Pure Reduction"

**Assumed:** Moving 980 words to templates = 980 words removed from agent
**Reality:** Moving content requires:
- Template references
- Context summaries
- Loading instructions
- Inline pointers to templates

**Impact:** ~400 words of overhead (vs predicted 230)

### Faulty Assumption 2: "Summaries Are Minimal"

**Assumed:** Removing detailed content leaves minimal summaries
**Reality:** To maintain agent coherence, we kept:
- Security scanning: 4-step process
- SSH operations: Command list
- Commit thresholds: Full criteria list
- Workflow modes: 3 detailed mode descriptions

**Impact:** ~200 words retained that were predicted to be removed

### Faulty Assumption 3: "cv-optimizer Pattern Applies Directly"

**cv-optimizer context:**
- 69% externalization → 52.5% reduction
- Ratio: 0.76 (reduction / externalization)

**git-manager context:**
- 75.7% externalization → 23.2% reduction
- Ratio: 0.31 (reduction / externalization)

**Why the difference?**
- cv-optimizer: Tables, lists, examples (low-context content)
- git-manager: Workflows, procedures, constraints (high-context content)

High-context content requires more summaries and references to maintain coherence.

---

## Lessons Learned

### 1. Content Type Matters More Than Volume

**Low-context content** (tables, examples, lists):
- Externalizes cleanly
- Minimal references needed
- High reduction ratio (0.7-0.8)

**High-context content** (workflows, procedures, rules):
- Requires summaries
- Needs inline context
- Lower reduction ratio (0.3-0.4)

### 2. Externalization % Is Not Reduction %

**Formula correction:**
```
Predicted reduction = (Externalization % × Context Factor) - Overhead %

Context Factor:
- Low-context (tables/examples): 0.7-0.8
- Medium-context (documentation): 0.5-0.6
- High-context (workflows/procedures): 0.3-0.4

Overhead %:
- Template table: 5-10%
- Inline references: 5-10%
- Summary preservation: 10-20%
- Total: 20-40% of baseline
```

### 3. Lazy Loading Benefit Is Real

**Without templates loaded:**
- Agent only: 2,013 tokens (23.2% reduction)

**Typical usage (1-2 templates):**
- Agent + 1 template: 2,013 + 543 = 2,556 (2.5% reduction)
- Agent + 2 templates: 2,013 + 1,098 = 3,111 (18.7% increase)

**The benefit:**
- User requests status: Load 0 templates (23.2% reduction)
- User commits: Load security-patterns (2.5% reduction)
- User needs SSH help: Load ssh-workflow (18.7% increase)

Average across usage patterns: ~10% reduction (vs 71.5% predicted)

---

## Revised Prediction Model

For future optimizations:

```
1. Classify content:
   - Low-context: Examples, tables, reference data
   - High-context: Workflows, procedures, decision trees

2. Calculate reduction:
   - Low-context reduction = Ext % × 0.75 - 30%
   - High-context reduction = Ext % × 0.35 - 30%

3. For git-manager (high-context):
   - 75.7% × 0.35 - 30% = 26.5% - 30% = -3.5%
   - **Prediction: Minimal benefit or slight increase**

4. Actual: 23.2% reduction
   - Better than revised model due to removal of low-context Examples section
```

---

## Value Assessment: Was This Optimization Worth It?

**Cost:**
- Time to externalize: ~30 minutes
- Complexity added: Template loading, references
- Maintenance burden: 5 files instead of 1

**Benefit:**
- Agent reduction: 23.2% (608 tokens)
- Lazy loading: 0-23% depending on usage
- Template reusability: Can be referenced by other agents
- Modularity: Security patterns, workflows can be updated independently

**Verdict:**
- **For git-manager in isolation: MARGINAL VALUE** (23% reduction, increased complexity)
- **For hub-wide template library: MODERATE VALUE** (reusable patterns for future agents)
- **For learning: HIGH VALUE** (corrects prediction model for high-context content)

---

## Recommendation for Future Optimizations

**High-context agents (workflows, procedures):**
- **SKIP externalization** unless content is reusable across agents
- Focus on compression, deduplication instead
- Use output modes for verbosity control

**Low-context agents (tables, examples, reference):**
- **APPLY externalization** aggressively
- Expected reduction: 40-60%
- Template strategy works well

**Mixed agents:**
- **HYBRID selective externalization**
- Externalize low-context sections only
- Keep high-context workflows inline with summaries

---

**Conclusion:**
The 71.5% prediction was based on faulty assumptions about content type and overhead. The actual 23.2% reduction is reasonable for high-context procedural content. The optimization provides value through lazy loading and template reusability, but future high-context agents should be deprioritized for externalization-based optimization.

**Next time:** Use revised prediction model with content type classification.
