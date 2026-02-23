# Tier 2 Decision Analysis - 2026-02-22

## Context

After completing **agent-git-manager** (23.2% reduction, 608 tokens saved), we discovered that **content type** is more important than externalization volume:

- **Low-context content** (tables, examples): 52-60% reduction
- **High-context content** (workflows, procedures): 20-30% reduction

**Remaining Tier 2 agents:**
1. agent-hub-orchestrator: 2,614 tokens (1,396 words)
2. agent-project-init: 2,655 tokens (1,362 words)

Both are similar size to git-manager and likely have similar content type (orchestration patterns, workflows, procedures).

---

## Cost-Benefit Analysis

### Expected Outcomes (Conservative)

Assuming both agents have similar high-context content to git-manager:

| Agent | Baseline | Expected Reduction | Tokens Saved | Effort (hours) |
|-------|----------|-------------------|--------------|----------------|
| hub-orchestrator | 2,614 | 20-25% | ~520-655 | 2.5 |
| project-init | 2,655 | 20-25% | ~530-665 | 2.5 |
| **Total** | **5,269** | **22.5%** | **~1,185** | **5.0** |

### ROI Calculation

**Investment**: 5 hours (measurement, analysis, implementation, validation, tracking)

**Return**: ~1,185 tokens saved

**Break-even**:
- At 10 hub loads/month: 11,850 tokens/month
- Pays back in first month

**But consider:**
- Tier 1 already saved 2,485 tokens (3 agents)
- git-manager saved 608 tokens (1 agent)
- Total campaign so far: 3,093 tokens (4 agents in Tier 1+2)
- **Diminishing returns**: Each additional agent saves less

---

## Strategic Options

### Option A: Complete Tier 2 (Recommended by Plan)

**Approach**: Optimize both remaining agents using HYBRID strategy

**Pros:**
- Completes Tier 2 commitment (3/3 agents)
- Adds ~1,185 tokens savings
- Creates orchestration + project-init template libraries
- Maintains momentum

**Cons:**
- 5 hours effort for marginal gains
- High-context content = lower reductions
- Tier 3 (integration suite) may have better ROI

**Total Tier 2 savings**: 608 + 1,185 = ~1,793 tokens (22.5% avg)

---

### Option B: Skip to Tier 3 (Integration Suite)

**Approach**: Skip hub-orchestrator and project-init, jump to integration agents

**Rationale:**
- Integration agents (analyzer, scorer, reviewer, assessor, designer) are recently created
- Likely designed with cleaner structure
- May have higher low-context content (assessment matrices, scoring rubrics)
- 5 agents in tier = potential for batch efficiencies

**Pros:**
- Focus on potentially higher-ROI agents
- Tier 3 has 5 agents (more templates created)
- Newer agents may be cleaner candidates

**Cons:**
- Abandons Tier 2 commitment (only 1/3 complete)
- May fragment campaign structure
- Integration agents baseline unknown

**Risk**: Integration agents might also be high-context (assessment workflows)

---

### Option C: Selective Optimization (Hybrid Approach)

**Approach**: Measure hub-orchestrator and project-init, optimize only if >40% externalization of LOW-context content

**Decision Tree:**
1. Quick measurement (30 min each)
2. Classify content type (low vs high context)
3. If >40% low-context externalization: OPTIMIZE
4. If mostly high-context: SKIP with documented reasoning
5. Move to Tier 3 afterward

**Pros:**
- Data-driven decision
- Prevents wasted effort on high-context agents
- Documents "not worth optimizing" pattern
- Maintains campaign rigor

**Cons:**
- Adds measurement overhead
- May still skip both agents (1/3 Tier 2 complete)

---

### Option D: PAUSE Campaign and Consolidate

**Approach**: Stop at 6 optimized agents, consolidate learnings, update methodology

**Rationale:**
- 6/17 agents optimized (35%)
- 21,300 tokens saved hub-wide (41% avg reduction)
- Methodology proven and refined
- Content type classification validated
- Template library established (22 files)

**Focus on applying learnings:**
1. Update PAT-01 with content type guidance
2. Create "Should I Optimize?" decision tree
3. Document content type classification method
4. Design future agents with templates from start

**Pros:**
- Consolidates significant learnings
- Prevents optimization fatigue
- Shifts focus to designing better agents upfront
- 21K tokens saved is substantial

**Cons:**
- Leaves 11 agents unoptimized
- Campaign incomplete (original goal: 14 agents)
- May lose momentum

---

## Content Type Quick Assessment

### agent-hub-orchestrator (Preview from first 100 lines)

**Low-context content identified:**
- Agent capability table (lines 64-76): ~120 words
- Command table (lines 80-87): ~50 words
- Possibly orchestration pattern examples

**High-context content identified:**
- Orchestration patterns section (lines 89-100+): Workflows
- Example coordination scenarios (lines 8-42): Procedural
- Error handling strategies: Procedural

**Initial classification**: **Mixed (40% low, 60% high)**

**Estimated externalization**: 40-50% (moderate)
**Expected reduction**: 25-30% (~655-785 tokens)

---

### agent-project-init (No preview yet)

**Expected content (based on purpose):**
- Project type classification workflows (high-context)
- Directory structure templates (low-context)
- Agent provisioning workflows (high-context)
- Documentation templates (low-context)

**Initial classification**: **Mixed (40% low, 60% high)** (estimated)

**Estimated externalization**: 40-50% (moderate)
**Expected reduction**: 25-30% (~665-795 tokens)

---

## Campaign Progress Review

### Completed Optimizations (6 agents)

| Tier | Agent | Baseline | Reduction | Content Type |
|------|-------|----------|-----------|--------------|
| Pre-campaign | agent-sap-bp | 15,000 | 58% | Low-context |
| Pre-campaign | agent-ansible | 16,000 | 59% | Low-context |
| **Tier 1** | robotarm-tester | 3,909 | 6% | Low ext% (12%) |
| **Tier 1** | cv-optimizer | 3,483 | 52.5% | Low-context (69% ext) |
| **Tier 1** | optimizer | 3,183 | 13.2% | Medium ext (24.7%) |
| **Tier 2** | git-manager | 2,621 | 23.2% | High-context (75.7% ext) |

**Patterns identified:**
1. **Low-context + high externalization** = 52-60% reduction (SAP, Ansible, cv-optimizer)
2. **High-context + high externalization** = 20-30% reduction (git-manager)
3. **Low externalization (<20%)** = 5-15% reduction (robotarm-tester, optimizer)

---

## Recommendation Matrix

| Criteria | Option A (Complete Tier 2) | Option B (Skip to Tier 3) | Option C (Selective) | Option D (Pause) |
|----------|---------------------------|---------------------------|---------------------|-----------------|
| **Completeness** | ✅ High | ❌ Low | ⚠️ Medium | ⚠️ Medium |
| **ROI** | ⚠️ Medium (~1,185 tokens) | ❓ Unknown | ✅ High (data-driven) | ✅ High (consolidate) |
| **Effort** | ⚠️ 5 hours | ✅ Deferred | ✅ 1-6 hours | ✅ 0 hours |
| **Learning Value** | ⚠️ Low (confirms patterns) | ❓ Unknown | ✅ Medium (validates decision tree) | ✅ High (methodology refinement) |
| **Campaign Momentum** | ✅ Maintains | ⚠️ Disrupts | ✅ Maintains | ❌ Stops |
| **Risk** | ✅ Low | ⚠️ Medium | ✅ Low | ⚠️ Medium |

---

## Final Recommendation

**Recommended**: ✅ **Option C - Selective Optimization**

**Rationale:**
1. **Data-driven**: Measure first, decide based on actual content type
2. **ROI-focused**: Only optimize if >40% low-context externalization
3. **Learning opportunity**: Validates "not worth optimizing" pattern
4. **Campaign integrity**: Maintains rigor without wasting effort
5. **Flexible**: Can pivot to Option D if both agents are low-ROI

**Execution Plan:**

### Step 1: Quick Measurement (60 min total)
- Measure hub-orchestrator: baseline + content type classification
- Measure project-init: baseline + content type classification
- Calculate low-context vs high-context externalization %

### Step 2: Decision Gate (15 min)
For each agent:
- **If >40% low-context externalization**: OPTIMIZE (expect 30-40% reduction)
- **If <40% low-context externalization**: SKIP (document reasoning)

### Step 3: Execute Optimizations (2.5 hours each if optimized)
- Apply HYBRID strategy for optimized agents
- Create templates in `.agent/templates/orchestration/` and `.agent/templates/project-init/`
- Run 5 quality gates

### Step 4: Consolidate Tier 2 Results (30 min)
- Update tier-2-results.md
- Document "not worth optimizing" pattern if applicable
- Assess Tier 3 viability

**Expected Outcomes:**
- Best case: 2 agents optimized, ~1,450 tokens saved (30-35% each)
- Likely case: 1 agent optimized, ~720 tokens saved (30% on 1 agent)
- Worst case: 0 agents optimized, learning documented

**Value regardless of outcome**: Validates decision tree for future agent optimization decisions.

---

## Decision Tree for Future Agents

Based on Tier 1+2 learnings, create decision tree:

```
START: Should I optimize this agent?
│
├─ Measure baseline tokens
│  ├─ <2,000 tokens → SKIP (overhead too high)
│  └─ ≥2,000 tokens → Continue
│
├─ Calculate externalization %
│  ├─ <15% → SKIP (not enough content)
│  └─ ≥15% → Continue
│
├─ Classify content type
│  ├─ >60% high-context → Expected reduction: 20-30%
│  │  └─ Is 20-30% worth effort? → User decides
│  └─ >60% low-context → Expected reduction: 40-60%
│     └─ OPTIMIZE with HYBRID strategy
│
└─ Mixed content (40-60% each)
   └─ Expected reduction: 25-35%
      └─ OPTIMIZE if >40% low-context
```

**Apply this to hub-orchestrator and project-init in Step 2.**

---

## Next Actions

**Immediate** (if Option C selected):
1. Quick measure hub-orchestrator (30 min)
2. Quick measure project-init (30 min)
3. Apply decision tree to both
4. Optimize 0-2 agents based on results
5. Document Tier 2 completion

**After Tier 2:**
1. Assess Tier 3 agents (integration suite - 5 agents)
2. Apply decision tree to each
3. Consider batch optimization if multiple are low-context
4. OR: Consolidate and pause campaign

---

**Status**: PENDING DECISION

**Recommended Path**: Option C - Selective Optimization

**Decision Needed**: Confirm approach before proceeding with hub-orchestrator measurement
