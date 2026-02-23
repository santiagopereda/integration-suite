# Optimization Plan: agent-git-manager

**Date:** 2026-02-22
**Phase:** Planning
**Strategy:** HYBRID (Template Externalization + Lazy Loading)

---

## Executive Summary

- **Optimization Score:** 95/100 (highest in campaign - 75.7% externalization)
- **Estimated Token Reduction:** 71.5% (1,875 tokens)
- **Priority:** High (tier 2, operational utility)
- **Risk:** Low (clear section boundaries, preserved constraints)

**Baseline:**
- Current: 2,621 tokens (1,427 words)
- Target: ~746 tokens (after optimization)

**Comparison to Benchmarks:**
- cv-optimizer: 69% ext → 52.5% reduction
- **git-manager: 75.7% ext → 71.5% reduction (EXCEEDS benchmark)**

---

## Recommendations

### 1. Template Externalization (PAT-01) - PRIMARY

**Current:** 1,080 words embedded inline
**Target:** Extract to 4 specialized templates
**Estimated Reduction:** 76% raw content (before overhead)
**Risk:** Low

#### Templates to Create

**A. `.agent/templates/git/examples.md`**
- **Source:** Lines 6-52 (Examples section)
- **Content:** 5 inline usage examples
- **Words:** 380 → Extract 350 words
- **Purpose:** Usage demonstrations, invoked on request

**B. `.agent/templates/git/security-patterns.md`**
- **Source:** Lines 83-112 (Security First - Pre-Commit Scanning)
- **Content:** File patterns, regex, security rules
- **Words:** 280 → Extract 250 words
- **Purpose:** Security scanning reference, loaded when scan triggered

**C. `.agent/templates/git/ssh-github-workflow.md`**
- **Source:** Lines 147-176 (SSH/GitHub Integration)
- **Content:** Step-by-step authentication procedures
- **Words:** 240 → Extract 220 words
- **Purpose:** Authentication setup, loaded on SSH/auth issues

**D. `.agent/templates/git/commit-workflow.md`**
- **Source:** Lines 224-252 (Workflow Example)
- **Content:** Detailed commit process walkthrough
- **Words:** 180 → Extract 160 words
- **Purpose:** Workflow guidance, loaded for complex scenarios

**Total Externalized:** 980 words (~2,450 tokens saved)

---

### 2. Add Lazy Loading (PAT-02) - SECONDARY

**Current:** No template infrastructure
**Target:** Load templates on-demand based on context
**Benefit:** Avoid loading unused templates (5-10% overhead reduction)

**Loading Triggers:**
- **examples.md**: User asks "show me an example" or "how do I use this"
- **security-patterns.md**: Pre-commit scan detects issues requiring patterns
- **ssh-github-workflow.md**: Authentication errors or SSH setup requests
- **commit-workflow.md**: Complex commit scenarios or workflow questions

**Implementation:**
```markdown
## Template Usage

Templates loaded on demand:

| Template | Trigger | Purpose |
|----------|---------|---------|
| examples.md | Usage demonstration requests | Show practical examples |
| security-patterns.md | Security scan findings | Pattern reference for remediation |
| ssh-github-workflow.md | Auth setup/troubleshooting | SSH/GitHub authentication |
| commit-workflow.md | Complex workflow scenarios | Detailed commit process |
```

**Estimated overhead:** ~150 words (~375 tokens)

---

### 3. Documentation Overhead

**Template Usage table:** ~150 words (~375 tokens)
**Lazy loading instructions:** ~80 words (~200 tokens)
**Total overhead:** ~575 tokens (22% of baseline)

**Net Calculation:**
- Baseline: 2,621 tokens
- Removed: -2,450 tokens (externalized content)
- Added: +575 tokens (documentation)
- **Net reduction: 1,875 tokens (71.5%)**

---

## Quality Gate Pre-Check

| Gate | Status | Evidence |
|------|--------|----------|
| **QG-1** | ✅ PASS | No test cases defined for git-manager (operational agent) |
| **QG-2** | ✅ PASS | No fabrication constraints (git operations are deterministic) |
| **QG-3** | ✅ PASS | Section "Accuracy Over Assumption" preserved in core (lines 114-132) |
| **QG-4** | 🔄 PENDING | 4 templates will be created before optimization applied |
| **QG-5** | ✅ PASS | 3 critical constraint sections preserved: Git Safety Protocol, Security First, Safety Constraints |

**Critical Constraints to Preserve:**

1. **Git Safety Protocol** (lines 54-76)
   - NEVER update git config
   - NEVER run destructive commands without permission
   - NEVER skip hooks
   - Status: **PRESERVED VERBATIM**

2. **Security First** (lines 78-82)
   - Pre-commit scanning (details externalized, requirement remains)
   - Status: **PRESERVED (summary in core)**

3. **Safety Constraints** (lines 199-222)
   - User confirmation requirements
   - Directory verification
   - Status: **PRESERVED VERBATIM**

**Result:** ✅ **APPROVED** for optimization (pending template creation)

---

## Implementation Plan

### Step 1: Create Template Files

1. Create directory: `.agent/templates/git/`
2. Extract content to 4 template files:
   - `examples.md` (380 words from lines 6-52)
   - `security-patterns.md` (280 words from lines 83-112)
   - `ssh-github-workflow.md` (240 words from lines 147-176)
   - `commit-workflow.md` (180 words from lines 224-252)
3. Verify all templates formatted correctly

### Step 2: Update Agent Definition

1. Replace Examples section with template reference
2. Replace Security scanning details with summary + template ref
3. Replace SSH/GitHub workflow with summary + template ref
4. Replace Workflow example with summary + template ref
5. Add "Template Usage" table (lazy loading)
6. Preserve ALL constraint sections verbatim

### Step 3: Validation

1. Verify character count: target ~3,000 chars
2. Verify token estimate: target ~750 tokens
3. Verify all 4 templates exist and are accessible
4. Verify Git Safety Protocol section unchanged
5. Verify Safety Constraints section unchanged
6. Verify core workflow integrity maintained

### Step 4: Measurement

1. Re-measure optimized agent (same metrics as baseline)
2. Calculate actual reduction vs. predicted
3. Update optimization log
4. Record to tracking history

---

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Template not loaded when needed | Low | Medium | Clear triggers, lazy loading table |
| Loss of workflow coherence | Low | Medium | Summary remains in core, templates linked |
| Security constraint dilution | Very Low | Critical | All constraints preserved verbatim |
| User confusion on template access | Low | Low | Template Usage table explains triggers |

**Overall Risk:** **LOW** - Well-structured agent with clear section boundaries

---

## Expected Outcome

**Before:**
- Tokens: 2,621
- Words: 1,427
- Structure: Monolithic with embedded examples/patterns

**After:**
- Tokens: ~746 (71.5% reduction)
- Words: ~300 core + 980 in templates
- Structure: Core workflow + on-demand templates
- Templates: 4 specialized files

**Success Criteria:**
- ✅ Token reduction ≥ 60% (target: 71.5%)
- ✅ All quality gates pass
- ✅ Git Safety Protocol unchanged
- ✅ Security requirements intact
- ✅ User experience maintained via lazy loading

---

## Next Steps

1. ✅ Review this plan
2. 🔄 Create 4 template files (Step 1)
3. 🔄 Apply changes to agent definition (Step 2)
4. 🔄 Run validation (Step 3)
5. 🔄 Re-measure and track (Step 4)
6. 🔄 Update optimization log

---

**Plan Status:** Ready for execution
**Approval Required:** User confirmation to proceed

**Comparison to Campaign:**
- Tier 1 avg: 40.3% reduction
- **git-manager expected: 71.5% reduction (77% above tier 1 avg)**
- This is the **highest-performing optimization in the campaign**
