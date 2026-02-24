# Key Discoveries: Breakthrough Moments in Agentic

The insights that transformed a simple agent repository into a token-optimized, cross-project learning system.

---

## Discovery 1: Template Externalization

> **"Agent definitions should contain identity, constraints, and workflow; reference content belongs in external templates."**

### The Moment

During Phase 1 optimization, we analyzed what our agents were actually loading:
- 2,000-2,400 words of content per agent
- Documentation templates (rarely used)
- Code pattern examples (sometimes used)
- Quality checklists (used at end only)

**The realization**: Most content was loaded every time but used only sometimes.

### The Pattern

```
Before: Agent definition = Identity + Content (loaded always)
After:  Agent definition = Identity + References (content loaded when needed)
```

### The Results

| Metric | Before | After | Savings |
|--------|--------|-------|---------|
| SAP Agent | 15,000 tokens | 6,300 tokens | 8,700 (58%) |
| Ansible Agent | 16,000 tokens | 6,493 tokens | 9,507 (59%) |
| **Per Cycle** | 31,000 tokens | 12,793 tokens | **18,207 (59%)** |

### Why It Works

1. **Separation of concerns**: Core agent behavior vs. reference material
2. **On-demand loading**: Read tool fetches templates only when task requires
3. **Compound savings**: Every invocation benefits, costs compound over time

### How to Apply

1. Identify embedded content > 100 words
2. Extract to `.agent/templates/{domain}/`
3. Replace with reference: "Load `.agent/templates/x.md` when needed"
4. Agent uses Read tool on-demand

---

## Discovery 2: Lazy Loading Economics

> **"Loading cost (~450 tokens) is 5% of baseline cost."**

### The Numbers

When an agent loads a template via the Read tool:
- **Cost to load**: ~450-500 tokens
- **Content loaded**: ~8,000-9,000 tokens worth of content
- **Net benefit**: ~8,500 tokens saved per invocation that *doesn't* need the template

### The Economics

| Scenario | Without Externalization | With Externalization |
|----------|------------------------|---------------------|
| Task needs template | 15,000 tokens | 6,500 + 450 = 6,950 tokens |
| Task doesn't need template | 15,000 tokens | 6,500 tokens |
| **Savings** | 0 | **8,050-8,500 tokens** |

### Key Insight

> "On-demand resource loading dramatically reduces average costs while maintaining capability access."

Templates are loaded maybe 30-40% of the time. The other 60-70% of invocations get full savings.

---

## Discovery 3: injection-history.md is Non-Negotiable

> **"100% usage rate across all analyzed projects."**

### The Pattern

Every project with a `.agent/` knowledge base maintained `injection-history.md` — a chronological log of everything added to the knowledge base.

### Why 100% Adoption

1. **Audit trail**: Know exactly when any document was added
2. **Project archaeology**: Understand evolution months later
3. **No prescriptive burden**: You log what you *did*, not what you *might* do
4. **Natural workflow fit**: Add entry after completing work

### Contrast with Other Patterns

| Pattern | Usage Rate | Why |
|---------|------------|-----|
| injection-history.md | 100% | Descriptive, low overhead |
| tasks/ folder | 17% | Prescriptive, requires upfront planning |
| sops/ folder | 33% | Requires process maturity |
| templates/ folder | 33% | Requires optimization phase |

### The Insight

> "Descriptive documentation wins; prescriptive templates fail."

People document what they did. They resist documenting what they might do.

---

## Discovery 4: Verification Before Implementation

> **"43% false positive rate validates verification-first approach."**

### The Story

During the Client-A project, we identified 7 potential issues with SAP API integration. Before implementing fixes:
- We verified each issue against the actual production API
- Result: Only 4 of 7 were real issues
- **43% were false positives** (3 out of 7)

### Time Saved

Without verification: ~4 days of unnecessary work on false positives

### The Pattern

```
1. Identify potential issue
2. VERIFY against production/reality before implementing
3. Only then implement fix
```

### Related Insight

> "Always test against actual production APIs; don't trust documentation alone."

The SAP documentation said 7 fields would block creation. Reality: only 1 field actually blocked.

---

## Discovery 5: Architecture Consistency Matters

> **"13% optimization disparity between agents"**

### The Problem

After Phase 1:
- SAP BP agent: 58% token reduction
- Ansible agent: 45% token reduction
- Gap: 13%

This inconsistency would complicate:
- Mental models (why are they different?)
- Maintenance (different optimization strategies)
- Future agents (which pattern to follow?)

### The Solution

Phase 2 dedicated 2 hours to closing the gap:
- Applied 7 strategic optimizations
- Created additional template (best-practices.md)
- Result: Both agents at 58-59% (1% gap)

### Key Insight

> "Consistency is worth pursuing even when Phase 1 had already achieved significant savings."

---

## Discovery 6: Structural Validation Suffices for Refactoring

> **"Structural verification is effective for refactoring validation; runtime testing reserved for quarterly review."**

### The Challenge

After refactoring an agent, how do you know you didn't break it?

### The Solution

Instead of full invocation testing (expensive, time-consuming):
1. List all test case requirements
2. Verify the refactored agent can still meet each requirement
3. Check: Are the capabilities still referenced? Are constraints preserved?

### Results

Ansible agent Phase 2: **12/12 test cases passed** via structural verification

### When to Use Each

| Validation Type | When to Use |
|-----------------|-------------|
| Structural verification | Refactoring (compression, externalization) |
| Runtime testing | New features, quarterly review |

---

## Discovery 7: Cross-Project Learning Multiplies Value

> **"13 success patterns, 11 failure patterns, 8 blindspots — from 7 projects."**

### The Mechanism

1. Each project generates a testimony via `/agent_reflect`
2. Testimonies are analyzed in the reflection pool
3. Patterns are extracted and synthesized
4. New projects benefit from collective wisdom

### Patterns Identified

**Success Patterns (13 total)**:
1. Template externalization (51-65% reduction)
2. Verification-first approach (43% false positive prevention)
3. injection-history.md adoption (100% usage)
4. Phased optimization (focused objectives)
5. Documentation-as-you-code
6. Defense-in-depth security
7. Budget as optimization parameter
8. SOP creation post-task
9. Test cases before implementation
10. Output mode controls
11. Metrics infrastructure
12. Structural validation
13. Quality gates

**Failure Patterns (11 total)**:
1. Equipment without procedures
2. Trusting documentation blindly
3. Empty template directories
4. Single-point assumptions
5. Monolithic agent definitions
6. Undocumented optimizations
7. Inconsistent architectures
8. Skipping validation
9. Embedding large templates
10. Day 2 momentum loss
11. Resource file drift

### The Multiplier Effect

Insight from one project prevents errors in all future projects.

---

## Quotable Insights

From [key-insights.md](/.agent/reflection_pool/key-insights.md):

### On Workflows
> **"Workflow gaps become visible only through actual use."** — CV Generator Agent

> **"Documentation during troubleshooting captures the 'why' that post-hoc documentation misses."** — GL.iNet BE3600

### On Architecture
> **"Defense-in-depth survives single-point failure."** — GL.iNet BE3600

> **"Travel routers are clients, not servers."** — GL.iNet BE3600

### On Validation
> **"Recipes/implementations are source of truth; resource files are reference."** — Client-A

### On Completeness
> **"Equipment without operational procedures = limited readiness."** — Survival

> **"Validate journey feasibility BEFORE equipment procurement."** — Survival

---

## Applying These Discoveries

### When Starting a New Project

1. **Create injection-history.md first** — 100% adoption rate proves its value
2. **Plan for template externalization** — Don't embed content > 100 words
3. **Establish baseline metrics** — You can't improve what you don't measure

### When Optimizing Existing Agents

1. **Identify static content** — Templates, examples, checklists
2. **Extract to .agent/templates/** — Organized by domain
3. **Verify structurally** — Check test cases can still pass
4. **Pursue consistency** — Align similar agents to similar optimization levels

### When Validating Work

1. **Verify before implementing** — 43% of issues may be false positives
2. **Test against reality** — Don't trust documentation alone
3. **Use structural validation for refactoring** — Save runtime tests for new features

---

**Last Updated**: 2026-01-25
**Sources**: key-insights.md, testimony-analysis-2026-01-23.md, PHASE1_COMPLETE.md, PHASE2_COMPLETE.md, agentic_testimony_2026-01-23.md
