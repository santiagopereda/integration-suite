# Optimization Plan: agent-cv-optimizer

**Date**: 2026-02-22
**Agent Size**: SMALL-MEDIUM (3,483 tokens)
**Strategy**: Template Externalization with HYBRID Documentation

## Optimization Hypothesis

**Goal**: Reduce agent-cv-optimizer token count by 30-40% through template externalization.

**Evidence**: Phase 2 analysis identified 2,395 tokens (69%) of externalizable content across 6 sections. This is a SMALL-MEDIUM agent similar to robotarm-tester, so HYBRID documentation (Template Usage table + minimal references) will add ~800 tokens overhead, yielding net 1,595 tokens saved (45.8% reduction). Conservative target: 30-40% to account for implementation variations.

**Confirm before proceeding? [Y/n]**: Proceeding as instructed.

---

## Summary

- **Optimization Score**: 70/100
- **Estimated Token Reduction**: 30-40% (1,045-1,393 tokens)
- **Priority**: High (well-structured, clear externalization candidates)
- **Documentation Approach**: HYBRID (800 token overhead)

## Templates to Create

All templates in `.agent/templates/career/`:

### 1. `operating-modes.md` (877 tokens → external)
**Current**: Lines 59-137 - Three Operating Modes section
**Content**:
- Mode 1: Career Coach (responsibilities, approach)
- Mode 2: HR Manager (responsibilities, approach)
- Mode 3: Interviewer (responsibilities, approach)
**Why**: Detailed workflow content, loaded when user needs mode explanation

### 2. `directory-structure.md` (295 tokens → external)
**Current**: Lines 138-163 - Directory Structure Workflow
**Content**:
- Directory tree structure
- File descriptions
- Directory creation workflow
- Portability notes
**Why**: Reference material, loaded when setting up applications

### 3. `recruiter-outreach.md` (196 tokens → external)
**Current**: Lines 165-180 - Recruiter Outreach Workflow
**Content**:
- 7-step workflow for recruiter-initiated contact
- Intent categories (Target/Practice/Exploratory)
**Why**: Specialized workflow, loaded when recruiter reaches out

### 4. `rendercv-integration.md` (186 tokens → external)
**Current**: Lines 182-204 - RenderCV Integration
**Content**:
- Format specifications
- Base CV detection
- CV tailoring process
- Key RenderCV sections
**Why**: Technical reference, loaded when working with RenderCV

### 5. `web-research-guidelines.md` (160 tokens → external)
**Current**: Lines 311-319 - Web Research Guidelines
**Content**:
- Research topics (company news, interview process, salaries, etc.)
- Citation requirements
**Why**: Reference checklist, loaded when doing research

### 6. `frontmatter-examples.md` (681 tokens → external)
**Current**: Lines 6-42 - Frontmatter examples
**Content**:
- 4 detailed usage examples with context and commentary
**Why**: Examples for agent invocation, not core operational content

**Total External**: 2,395 tokens

## Agent Refactor Plan

### Template Usage Section (HYBRID approach)

Replace frontmatter examples with:

```markdown
## When to Use This Agent

Load examples from `.agent/templates/career/frontmatter-examples.md` for detailed usage scenarios.

**Quick Reference**:
- CV tailoring → HR Manager mode
- Career guidance → Career Coach mode
- Interview prep → Interviewer mode
- Application tracking → Directory structure workflow
```

### Core Content Structure (remaining in agent)

```markdown
## Your Expertise
[KEEP - 137 tokens, defines agent identity]

## Template Library

| Template | Purpose | Load When |
|----------|---------|-----------|
| operating-modes.md | Detailed mode responsibilities | User needs mode explanation or first use |
| directory-structure.md | Application folder setup | Creating new application directory |
| recruiter-outreach.md | Handle recruiter-initiated contact | Recruiter reaches out before application |
| rendercv-integration.md | RenderCV YAML workflows | Working with CV variants |
| web-research-guidelines.md | Research checklist | Performing company research |
| frontmatter-examples.md | Usage scenarios | Understanding agent capabilities |

Load templates on demand using Read tool.

## Quick Mode Reference

**Career Coach**: Mine experience, detect blindspots, build narrative, map opportunities.
**HR Manager**: Parse JD, analyze gaps, tailor CV, optimize ATS, draft communications.
**Interviewer**: Research company, generate questions, coach STAR method, prep scenarios.

## File Templates
[KEEP - 82 tokens, references existing templates]

## Application Tracker Format
[KEEP - 84 tokens, essential reference]

## Agent Coordination
[KEEP - 147 tokens, integration points]

## Output Modes
[KEEP - 133 tokens, already optimal]

## Critical Constraints
[KEEP - 244 tokens, REQUIRED for quality gates]

## Communication Style
[KEEP - 79 tokens, essential guidance]

## Workflow Examples
[KEEP but simplified - reference template instead]
```

### Documentation Overhead Estimate

- Template Usage table: ~200 tokens
- Quick Mode Reference: ~100 tokens
- When to Use section: ~50 tokens
- Template metadata/transitions: ~100 tokens
- Existing template references: kept as-is (~350 tokens)

**Total Overhead**: ~800 tokens (HYBRID approach)

## Expected Outcome

**Before**:
- Lines: 321
- Tokens: 3,483

**After**:
- Lines: ~160-180 (50% reduction)
- Tokens: ~2,088-2,438 (40-30% reduction)
- External templates: 6 files, 2,395 tokens (loaded on demand)

**Net Reduction**: 1,045-1,393 tokens (30-40%)

## Quality Gate Pre-Check

| Gate | Status | Evidence |
|------|--------|----------|
| QG-1 | PASS | No test cases defined - structural validation only |
| QG-2 | PASS | Lines 271-273 "Never fabricate" will be preserved |
| QG-3 | PASS | Lines 267-291 Critical Constraints section preserved |
| QG-4 | PENDING | Templates will be created in Phase 4 |
| QG-5 | PASS | 7 critical constraints identified, all preserved |

**Result**: APPROVED for optimization (pending template creation)

## Implementation Steps

1. Create 6 templates in `.agent/templates/career/`
2. Refactor agent with HYBRID documentation
3. Validate all quality gates
4. Measure final metrics
5. Record optimization log

**Proceed to Phase 4: IMPLEMENT**
