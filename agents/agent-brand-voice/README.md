# agent-brand-voice

**Version**: 1.0.0
**Status**: Production
**Agent Type**: Brand Voice Consistency
**Model**: Sonnet

## Overview

The `agent-brand-voice` is a brand voice strategist that helps teams define, maintain, and evolve a consistent voice across all communications. It operates through 5 specialized modes that cover the full voice lifecycle: discovery, content creation, review, analysis, and stakeholder alignment.

**Key differentiator**: Combines voice discovery interviewing, content generation, auditing, linguistic analysis, and multi-stakeholder reconciliation in a single agent backed by a structured template library.

**Voice profile location**: `.agent/system/brand-voice-profile.md` (created by Assessor/Reconciler, consumed by Generator/Reviewer/Analyst)

## When to Use This Agent

### Trigger Conditions

- You need to define or document a brand's voice from scratch
- You're creating content that must match an established voice
- You want to audit existing content for voice consistency
- You need to analyze a creator's writing style
- Multiple stakeholders disagree on voice direction
- An existing voice profile needs periodic review

### When NOT to Use

- Visual brand identity (logos, colors, typography)
- Brand strategy and competitive positioning
- Social media management or scheduling
- SEO optimization (unless it intersects with voice)
- Content for non-text channels (video production, audio editing)

## Five Operating Modes

### 1. Assessor Mode

**Purpose**: Discover and document a brand's voice through structured interview.

**Invoke when**:
- Creating a voice profile for the first time
- Documenting an existing but unwritten voice
- Rebranding and need to redefine voice

**What it does**:
1. Walks through an 11-section discovery questionnaire
2. Analyzes existing content samples (if available)
3. Builds a complete voice profile (principles, tone matrix, vocabulary, attributes)
4. Saves the profile to `.agent/system/brand-voice-profile.md`

**Example**:
```
@agent-brand-voice: Help us define our brand voice for a B2B SaaS
startup targeting DevOps teams
```

**Templates loaded**: `initial-assessment-workflow.md`, `discovery-questionnaire.md`, then all `voice-profile/*` templates for profile construction.

---

### 2. Generator Mode

**Purpose**: Create content that matches an established voice profile.

**Invoke when**:
- Writing blog posts, emails, docs, or social content
- Need content that follows documented voice rules
- Want AI-generated content that sounds like your brand

**What it does**:
1. Loads the active voice profile
2. Applies tone matrix settings for the target channel/audience/context
3. Drafts content following vocabulary rules and voice principles
4. Self-reviews against the profile before delivery

**Requires**: An existing voice profile at `.agent/system/brand-voice-profile.md`

**Example**:
```
@agent-brand-voice: Write a blog post announcing our new CI/CD
integration feature. Target audience: platform engineers.
```

**Templates loaded**: `content-generation-workflow.md` + voice profile.

---

### 3. Reviewer Mode

**Purpose**: Audit content against the documented voice profile.

**Invoke when**:
- Reviewing a draft before publication
- Checking content from external writers or agencies
- Running periodic voice consistency checks
- Validating AI-generated content

**What it does**:
1. Loads voice profile and the content to review
2. Scores across 5 dimensions (principles, tone, vocabulary, attributes, consistency)
3. Provides line-level feedback with specific corrections
4. Outputs a composite voice score (1-10) with classification

**Requires**: An existing voice profile at `.agent/system/brand-voice-profile.md`

**Example**:
```
@agent-brand-voice: Review this draft blog post for voice consistency:
[paste content or provide file path]
```

**Templates loaded**: `content-review-workflow.md` + voice profile.

**Score classification**:
| Score | Classification |
|:-----:|---------------|
| 8-10 | Strong - ready to publish |
| 5-7 | Acceptable - minor revisions |
| 1-4 | Needs Revision - significant rework |

---

### 4. Analyst Mode

**Purpose**: Study a creator's writing style from content samples.

**Invoke when**:
- Onboarding a new content creator
- Evaluating if a freelancer matches your voice
- Comparing a creator's natural style to your brand voice
- Building a style reference for an individual

**What it does**:
1. Analyzes 3-5 content samples
2. Extracts structural patterns (sentence length, paragraph structure)
3. Performs linguistic analysis (word frequency, rhetorical devices, tone markers)
4. Maps findings to voice attribute dimensions
5. Optionally compares to the brand voice profile

**Example**:
```
@agent-brand-voice: Analyze these 3 blog posts from our new writer
and tell me how their style compares to our brand voice:
[provide samples or file paths]
```

**Templates loaded**: `creator-analysis-workflow.md`, optionally voice profile for comparison.

---

### 5. Reconciler Mode

**Purpose**: Align multiple stakeholders on a unified voice.

**Invoke when**:
- Founders/leaders disagree on voice direction
- Merging teams with different content cultures
- Rebranding with multiple decision-makers
- Post-acquisition voice unification

**What it does**:
1. Collects individual voice preferences from each stakeholder (independently)
2. Runs convergence analysis to find agreement and conflicts
3. Applies resolution hierarchy (audience data > strategy > feasibility > role weight)
4. Builds a unified voice profile from reconciled preferences
5. Tracks stakeholder sign-off

**Example**:
```
@agent-brand-voice: We have 3 co-founders who each have different
ideas about our brand voice. Help us align.
```

**Templates loaded**: `reconciliation-workflow.md`, then all `voice-profile/*` templates for unified profile construction.

## Output Modes

All operating modes support three output depths:

| Mode | Trigger Words | What You Get |
|------|--------------|--------------|
| Brief | "quick", "brief", "summary" | Top-level findings, 2-3 key points |
| Standard | (default) | Full structured analysis |
| Detailed | "detailed", "comprehensive", "in-depth" | Full analysis + examples + alternatives + cross-channel notes |

## Quick Start Guide

### First Time: Define Your Voice

1. **Invoke Assessor mode**:
   ```
   @agent-brand-voice: Help us define our brand voice
   ```
2. The agent walks you through an 11-section discovery interview
3. Answer questions about your brand, audience, tone, and language preferences
4. The agent builds and saves your voice profile

### Creating Content

1. Ensure a voice profile exists (run Assessor first if not)
2. **Invoke Generator mode**:
   ```
   @agent-brand-voice: Write a [content type] about [topic] for [channel/audience]
   ```
3. Review the generated content and provide feedback

### Reviewing Content

1. **Invoke Reviewer mode**:
   ```
   @agent-brand-voice: Review this [content type] for brand voice consistency
   ```
2. Receive dimensional scores and line-level feedback
3. Apply suggested corrections

### Typical Workflow

```
Define voice (Assessor) --> Create content (Generator) --> Review content (Reviewer)
         |                                                        |
         v                                                        v
  Reconcile if needed (Reconciler)              Evolve over time (Voice Evolution)
```

## Integration with Existing Infrastructure

### Voice Profile Storage

The agent reads and writes to `.agent/system/brand-voice-profile.md`. This integrates with the hub's knowledge base structure:

| Path | Purpose |
|------|---------|
| `.agent/system/brand-voice-profile.md` | Active voice profile (created by agent) |
| `.agent/templates/brand-voice/` | Template library (12 files, ~24 KB) |
| `.agent/memory/agents/agent-brand-voice-memory.md` | Persistent agent memory |

### Agent Coordination

| Agent | When to Combine |
|-------|----------------|
| `research-assistant` | Industry voice benchmarking, competitor voice analysis |
| `documentation-specialist` | Polish voice guide documents for distribution to teams |
| `agent-cv-optimizer` | Align personal brand voice with job applications |

### Template Library

The agent loads templates on demand from `.agent/templates/brand-voice/`. See `.agent/templates/brand-voice/README.md` for the complete template index, loading guide, and token cost estimates.

## Directory Structure

```
agents/agent-brand-voice/
├── README.md                    # This file

.claude/agents/
└── agent-brand-voice.md         # Agent definition (loaded by Claude Code)

.agent/templates/brand-voice/
├── README.md                    # Template index and loading guide
├── assessment/                  # Discovery and review templates
├── voice-profile/               # Profile structure templates
└── workflows/                   # Step-by-step process templates

.agent/system/
└── brand-voice-profile.md       # Active voice profile (created by agent)
```

## Quality Standards

The agent adheres to:
- **Accuracy**: Never fabricates brand guidelines; works from documented profiles or stakeholder input
- **Respect**: Preserves intentional voice choices even when unconventional
- **Transparency**: Shows reasoning behind recommendations, cites profile elements
- **Honesty**: Flags incomplete profiles, distinguishes opinion from rule-based findings

## Portability

This agent is fully portable:
- No hardcoded paths beyond standard `.agent/` conventions
- Works in any project directory
- Creates relative directory structures
- Voice profile stored in standard knowledge base location

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-02-23 | Initial release with 5 modes, 12 templates, voice profile system |

## Support & Feedback

Report issues to the Agent Architecture Team with:
- Agent ID: `agent-brand-voice`
- Operating mode used
- Your request
- Expected vs. actual behavior
