# Test Cases: agent-brand-voice

**Agent**: agent-brand-voice
**Version**: 1.0.0
**Last Updated**: 2026-02-23

## Overview

Validation test cases for the `agent-brand-voice` agent covering all 5 operating modes, quality gates, mode transitions, agent coordination, template loading, and memory patterns.

## Test Execution Instructions

1. Invoke the agent with the specified test request
2. Review output against expected criteria
3. Mark PASS if all criteria are met, FAIL if any are not
4. Document issues for agent refinement

## Quality Assurance Checklist

All agent outputs should satisfy:
- [ ] No fabricated brand guidelines or voice attributes
- [ ] Voice profile referenced by specific section when reviewing content
- [ ] Templates loaded on demand (not eagerly at session start)
- [ ] Recommendations distinguish subjective opinion from rule-based findings
- [ ] Existing brand decisions preserved unless stakeholder-approved change
- [ ] Memory file checked at mode start
- [ ] Uncertainty explicitly acknowledged when profile is incomplete

---

## Quality Gates

| Gate | Requirement | Validated In |
|------|-------------|-------------|
| QG-BV-1 | Voice profile completeness: all 4 sections populated (principles, tone matrix, vocabulary, attributes) | TC-01, TC-02 |
| QG-BV-2 | No fabrication: never invents brand guidelines or voice attributes without evidence | TC-01, TC-11, TC-15 |
| QG-BV-3 | Tone matrix compliance: generated content matches matrix settings for context/channel | TC-04, TC-05, TC-06, TC-07, TC-08 |
| QG-BV-4 | Review scoring consistency: same content scores within ±1 point across repeated reviews | TC-09, TC-10, TC-11 |
| QG-BV-5 | Stakeholder sign-off tracked: reconciliation produces sign-off tracker with all participants | TC-14, TC-15 |
| QG-BV-6 | External reference ethics: no plagiarism, all principles abstracted, creator attribution complete | TC-12, TC-13 |

---

## Assessor Mode Tests

### Test Case 1: Initial Setup — No Existing Content

**Mode**: Assessor
**Scenario**: Brand new company with no existing content or voice guidelines.

#### Test Request
```
@agent-brand-voice: We're launching a B2B SaaS developer tools startup called CodeForge.
We have no existing content or brand guidelines. Help us define our brand voice from scratch.
```

#### Expected Output Criteria
- [ ] Loads `assessment/discovery-questionnaire.md` template
- [ ] Checks `.agent/memory/agents/agent-brand-voice-memory.md` for prior patterns
- [ ] Conducts interview across all 11 questionnaire sections
- [ ] Adapts: skips Section 10 (existing integrations), emphasizes Section 11 (new brand)
- [ ] Produces complete voice profile with all 4 sections:
  - [ ] 3-5 voice principles with Do/Don't examples
  - [ ] Tone matrix with baseline + context shifts
  - [ ] Vocabulary guide with preferred/avoided terms
  - [ ] 4-6 voice attributes with spectrum targets
- [ ] Saves output to `.agent/system/brand-voice-profile.md`
- [ ] Provides 2-3 sample paragraphs demonstrating the new voice
- [ ] Suggests next steps (content creation, team training, review schedule)

#### Quality Gates Validated
- **QG-BV-1**: All 4 voice profile sections populated
- **QG-BV-2**: No fabricated guidelines — all attributes derived from interview responses

#### Success Criteria
- Voice profile is complete and internally consistent
- Principles are specific to CodeForge, not generic marketing advice
- Sample content demonstrably matches the defined profile

---

### Test Case 2: Initial Setup — Existing Content Library Conflict

**Mode**: Assessor
**Scenario**: Company has existing content at `docs/05-content-library/` that may conflict with the new voice definition.

#### Test Request
```
@agent-brand-voice: We want to define our brand voice. We already have a content library
at docs/05-content-library/ with ~50 published articles. Some were written by different
authors with inconsistent styles. Help us assess and unify our voice.
```

#### Expected Output Criteria
- [ ] Reads existing content samples from `docs/05-content-library/`
- [ ] Analyzes 5-10 representative samples for current voice patterns
- [ ] Identifies inconsistencies across authors/time periods
- [ ] Flags conflicts between observed voice and stakeholder preferences
- [ ] Presents conflict resolution options:
  - Option A: Update principles to match dominant existing pattern
  - Option B: Define new target voice and create migration plan for existing content
- [ ] Documents which existing content aligns with new profile and which needs revision
- [ ] Produces voice profile incorporating resolution decisions
- [ ] Saves to `.agent/system/brand-voice-profile.md`

#### Quality Gates Validated
- **QG-BV-1**: Profile complete even with conflicting inputs
- **QG-BV-2**: Conflicts documented, not silently resolved with fabricated guidelines

#### Success Criteria
- Existing content analyzed before defining new voice
- Conflicts surfaced explicitly with options for resolution
- Migration path provided for non-compliant content

---

### Test Case 3: Quarterly Review with Voice Drift Detection

**Mode**: Assessor (evolution sub-workflow)
**Scenario**: Voice profile exists and has been in use for 3 months. Content has drifted.

#### Test Request
```
@agent-brand-voice: Run a quarterly voice review. Our profile was defined 3 months ago.
Recent blog posts seem more formal than intended, and social media posts are inconsistent.
Review the current state against our profile.
```

#### Expected Output Criteria
- [ ] Loads existing voice profile from `.agent/system/brand-voice-profile.md`
- [ ] Loads `assessment/periodic-review-template.md`
- [ ] Loads `workflows/voice-evolution-workflow.md`
- [ ] Requests 10-20 recent content pieces for audit
- [ ] Runs Reviewer mode on each piece (or representative sample)
- [ ] Calculates average voice score and trend
- [ ] Identifies drift patterns with specific evidence:
  - Blog: formality crept from target 3/5 to observed ~4/5
  - Social: inconsistency across posts (score variance > 2 points)
- [ ] Proposes profile updates (if drift is intentional evolution) OR retraining recommendations (if unintentional)
- [ ] Sets next review date
- [ ] Updates voice profile version if changes made

#### Quality Gates Validated
- **QG-BV-4**: Review scores are evidence-based and reproducible

#### Success Criteria
- Drift detected with specific, citable evidence
- Clear distinction between intentional evolution and unintentional drift
- Actionable recommendations with priority ordering

---

## Generator Mode Tests

### Test Case 4: LinkedIn Post — Draft Mode with Intent Capture

**Mode**: Generator
**Scenario**: Generate a LinkedIn post about a product launch, starting with intent capture.

#### Test Request
```
@agent-brand-voice: Generate a LinkedIn post announcing our new API monitoring feature.
This is a draft for review.
```

#### Expected Output Criteria
- [ ] Loads voice profile from `.agent/system/brand-voice-profile.md`
- [ ] Loads `content-templates/intent-capture-template.md` FIRST
- [ ] Asks the 4 mandatory intent capture questions:
  1. What do you want to say, and why does it matter right now?
  2. When and where will this be published?
  3. What should the audience think, feel, or do?
  4. How will you measure success?
- [ ] After capturing intent, loads `channel-rules/linkedin-rules.md`
- [ ] Loads `content-templates/linkedin-post-template.md`
- [ ] Generates draft applying:
  - Voice principles from profile
  - Tone matrix settings for LinkedIn + product announcement context
  - Vocabulary guide (preferred/avoided terms)
  - LinkedIn-specific formatting rules
- [ ] Labels output as "DRAFT — for review" (not publish-ready)
- [ ] Includes intent capture metadata block in YAML format

#### Quality Gates Validated
- **QG-BV-3**: Tone matches matrix for LinkedIn + announcement context

#### Success Criteria
- Intent capture precedes any content generation
- Post follows LinkedIn format constraints (character limits, structure)
- Tone matches the profile's LinkedIn + announcement settings
- Draft clearly marked as requiring review

---

### Test Case 5: Blog Outline — Polished Mode

**Mode**: Generator
**Scenario**: Generate a polished blog outline ready for writer handoff.

#### Test Request
```
@agent-brand-voice: Create a polished blog outline for a thought leadership article
about "Why Data Observability Matters for DevOps Teams". This should be ready for
our content writer to draft from.
```

#### Expected Output Criteria
- [ ] Loads voice profile
- [ ] Runs intent capture (or confirms intent if already provided)
- [ ] Loads `channel-rules/blog-rules.md`
- [ ] Loads `content-templates/blog-outline-template.md`
- [ ] Generates outline with:
  - Working title with voice-appropriate tone
  - Target word count based on blog rules
  - 4-7 section headings matching voice attributes
  - 2-3 bullet points per section with key arguments
  - Suggested hook/opening aligned with engagement patterns
  - CTA aligned with intent capture outcome
- [ ] Applies vocabulary guide (no avoided terms in headings/bullets)
- [ ] Labels as "Polished — ready for writer handoff"
- [ ] Includes voice notes: which tone settings applied, any deviations

#### Quality Gates Validated
- **QG-BV-3**: Blog tone matrix settings applied

#### Success Criteria
- Outline is actionable enough for a writer to draft from without further voice guidance
- Headings and bullets reflect voice principles
- Blog-specific rules followed (structure, length, SEO considerations)

---

### Test Case 6: Twitter Thread Generation

**Mode**: Generator
**Scenario**: Generate a Twitter/X thread from an existing blog post.

#### Test Request
```
@agent-brand-voice: Convert our blog post about data observability into a Twitter thread.
Keep it punchy and engaging. 5-7 tweets.
```

#### Expected Output Criteria
- [ ] Loads voice profile
- [ ] Loads `channel-rules/twitter-rules.md`
- [ ] Loads `content-templates/thread-template.md`
- [ ] Adapts tone from blog settings to Twitter settings per tone matrix
- [ ] Generates thread with:
  - Hook tweet that stands alone
  - 5-7 tweets with logical progression
  - Character count within Twitter limits per tweet
  - Thread-specific formatting (numbering, emoji policy per profile)
  - Final tweet with CTA
- [ ] Demonstrates tone shift from blog (likely more formal) to Twitter (likely more casual)
- [ ] Documents tone adaptation: "Shifted formality from X to Y per tone matrix"

#### Quality Gates Validated
- **QG-BV-3**: Twitter-specific tone matrix applied (not just blog tone copy-pasted)

#### Success Criteria
- Each tweet stands alone while forming a coherent thread
- Tone clearly different from blog version per tone matrix
- Character limits respected
- Channel rules followed

---

### Test Case 7: Email Campaign Generation

**Mode**: Generator
**Scenario**: Generate an email campaign for a product update.

#### Test Request
```
@agent-brand-voice: Create an email announcing our Q1 product updates to existing customers.
Include subject line options and preview text.
```

#### Expected Output Criteria
- [ ] Loads voice profile
- [ ] Runs intent capture
- [ ] Loads `channel-rules/mailings-rules.md`
- [ ] Loads `content-templates/email-template.md`
- [ ] Generates email with:
  - 3 subject line options with rationale
  - Preview text aligned with subject lines
  - Email body following mailing rules (structure, length, CTAs)
  - Tone matching email + product update context from matrix
  - Personalization tokens where appropriate
- [ ] Follows vocabulary guide strictly (email is high-visibility)
- [ ] Includes intent metadata

#### Quality Gates Validated
- **QG-BV-3**: Email tone matrix settings applied

#### Success Criteria
- Subject lines are on-brand and varied in approach
- Email body matches voice profile with email-specific adaptations
- Mailing rules followed (unsubscribe, formatting, CTA placement)

---

### Test Case 8: Customer Documentation Section

**Mode**: Generator
**Scenario**: Generate a documentation section for a technical feature.

#### Test Request
```
@agent-brand-voice: Write the "Getting Started" section for our API documentation.
Audience is developers integrating our monitoring SDK for the first time.
```

#### Expected Output Criteria
- [ ] Loads voice profile
- [ ] Loads `channel-rules/customer-docs-rules.md`
- [ ] Applies docs-specific tone from matrix (likely higher formality, higher authority)
- [ ] Generates documentation with:
  - Clear, step-by-step structure
  - Code examples (if applicable to context)
  - Vocabulary matching jargon policy for technical audience
  - Tone appropriate for documentation (instructional, precise)
  - Consistent with voice principles (still sounds like the brand, not generic docs)
- [ ] Demonstrates brand personality even in technical content

#### Quality Gates Validated
- **QG-BV-3**: Documentation tone matrix applied (distinct from marketing tone)

#### Success Criteria
- Documentation is technically clear AND on-brand
- Jargon policy applied correctly (defined or assumed based on policy)
- Tone is distinct from marketing content but recognizably the same brand
- Channel-specific docs rules followed

---

## Reviewer Mode Tests

### Test Case 9: Audit Compliant Content (Score >= 90%)

**Mode**: Reviewer
**Scenario**: Content that closely follows the voice profile. Should score high.

#### Test Request
```
@agent-brand-voice: Review this blog post draft for voice compliance.
[Provide content that deliberately follows all voice profile rules:
correct tone, preferred vocabulary, proper sentence patterns, on-target attributes]
```

#### Expected Output Criteria
- [ ] Loads voice profile
- [ ] Loads `workflows/content-review-workflow.md`
- [ ] Loads `review-checklists/voice-compliance-checklist.md`
- [ ] Scores each dimension:
  - Principle adherence: 9-10
  - Tone accuracy: 9-10
  - Vocabulary compliance: 9-10
  - Attribute alignment: 9-10
  - Consistency: 9-10
- [ ] Composite score >= 9/10 (90%+)
- [ ] Classification: "Strong — Publish-ready"
- [ ] Lists 2-3 specific strengths with evidence
- [ ] Minor suggestions only (no P0 or P1 violations)

#### Quality Gates Validated
- **QG-BV-4**: Compliant content consistently scores high

#### Success Criteria
- High-quality content is recognized and scored accordingly
- Strengths are specific and reference profile elements
- No false positives (flagging compliant content as non-compliant)

---

### Test Case 10: Audit Non-Compliant Content (Flag Violations)

**Mode**: Reviewer
**Scenario**: Content that violates multiple voice profile rules.

#### Test Request
```
@agent-brand-voice: Review this draft for voice compliance.
[Provide content with deliberate violations: wrong tone, avoided vocabulary used,
passive voice when active required, off-target attributes, mismatched channel style]
```

#### Expected Output Criteria
- [ ] Loads voice profile and review checklists
- [ ] Identifies violations across multiple dimensions
- [ ] Composite score < 5/10
- [ ] Classification: "Needs Revision" or "Major Revision"
- [ ] Each violation includes:
  - Specific line/section where it occurs
  - Which profile element it violates (by name)
  - Suggested rewrite
  - Priority (P0: blocks publication, P1: should fix, P2: nice to fix)
- [ ] Lists violations in priority order
- [ ] Does NOT suggest nuking the entire piece — provides actionable fix path

#### Quality Gates Validated
- **QG-BV-4**: Non-compliant content consistently scores low

#### Success Criteria
- All deliberate violations are caught
- Feedback is actionable (specific rewrites, not just "fix the tone")
- Profile elements cited by name for each finding
- Priority classification is reasonable

---

### Test Case 11: Audit Mixed Content (P0, P1, P2 Violations)

**Mode**: Reviewer
**Scenario**: Content with a mix of compliant sections and violations at different severity levels.

#### Test Request
```
@agent-brand-voice: Review this marketing email draft for voice compliance.
[Provide content with:
- 1 P0 violation (e.g., claims a capability that doesn't exist — fabrication)
- 2 P1 violations (e.g., wrong tone for channel, avoided vocabulary used)
- 3 P2 violations (e.g., slightly long sentences, minor attribute drift)]
```

#### Expected Output Criteria
- [ ] Identifies all 6 violations correctly
- [ ] Classifies severity accurately:
  - P0 (1): Blocks publication — must fix before sending
  - P1 (2): Should fix — significantly off-brand
  - P2 (3): Nice to fix — minor drift from targets
- [ ] Composite score in 5-7 range ("Acceptable" or "Revision needed")
- [ ] Distinguishes between subjective and rule-based findings
- [ ] Acknowledges compliant sections as strengths
- [ ] Provides fix priority order: P0 first, then P1, then P2
- [ ] Does not fabricate violations that don't exist in the content

#### Quality Gates Validated
- **QG-BV-2**: No fabricated violations
- **QG-BV-4**: Consistent scoring for mixed-quality content

#### Success Criteria
- P0/P1/P2 classification is correct for each violation
- No false positives (inventing violations in compliant sections)
- No false negatives (missing actual violations)
- Actionable fix path with clear priority

---

## Analyst Mode Tests

### Test Case 12: Analyze External Creator

**Mode**: Analyst
**Scenario**: Analyze an external content creator's style to extract reusable techniques.

#### Test Request
```
@agent-brand-voice: Analyze this creator's writing style from these 5 LinkedIn posts.
Extract techniques we could adapt for our own content.
[Provide 5 content samples from a real or simulated creator]
```

#### Expected Output Criteria
- [ ] Loads `workflows/creator-analysis-workflow.md`
- [ ] Loads `style-references/reference-analysis-template.md`
- [ ] Loads `style-references/extraction-checklist.md`
- [ ] Analyzes all 5 samples for:
  - Structural patterns (sentence length, paragraph length, heading usage)
  - Linguistic analysis (word frequency, voice, person, rhetorical devices)
  - Tone mapping (formality, energy, warmth, authority scores)
  - Engagement techniques (direct address, rhetorical questions, etc.)
  - Storytelling approaches
- [ ] Extracts 3-8 abstracted principles (technique, not imitation)
- [ ] Each principle passes ethical validation:
  - Describes a technique, not a signature element
  - Another brand could use it without sounding like a copy
  - No distinctive phrases or coined terms included
- [ ] Attributes the creator by name with source URLs
- [ ] Provides compatibility notes vs. existing voice profile

#### Quality Gates Validated
- **QG-BV-6**: All principles abstracted, creator attributed, no plagiarism

#### Success Criteria
- Principles are genuinely reusable by any brand
- No copying of unique voice elements, only technique extraction
- Attribution is complete and traceable
- Compatibility with existing profile assessed

---

### Test Case 13: Update Inspiration Library

**Mode**: Analyst
**Scenario**: Add extracted principles from TC-12 to the inspiration library.

#### Test Request
```
@agent-brand-voice: Save the principles extracted from the previous analysis
to our inspiration library. Ensure ethical guidelines are followed.
```

#### Expected Output Criteria
- [ ] Loads `style-references/inspiration-library-template.md`
- [ ] Formats extracted principles into library entry format
- [ ] Each entry includes:
  - Principle name and category
  - Description of the technique
  - Source creator with attribution
  - Ethical validation status (passed/needs review)
  - Application guidance (when to use, when not to)
- [ ] Runs ethical validation checklist on every principle before saving
- [ ] Rejects or flags any principle that:
  - Contains signature phrases
  - Includes coined terminology
  - Could only apply to one creator's style
- [ ] Saves to inspiration library with proper attribution

#### Quality Gates Validated
- **QG-BV-6**: Ethical boundaries enforced, no content reproduction

#### Success Criteria
- Library entry is properly formatted and attributed
- Ethical validation is explicit (not assumed)
- Rejected principles documented with reason
- Library is usable by Generator and Reviewer modes

---

## Reconciler Mode Tests

### Test Case 14: Resolve Conflict — Update Principles (Option A)

**Mode**: Reconciler
**Scenario**: Two stakeholders disagree on voice formality. Resolution: update principles.

#### Test Request
```
@agent-brand-voice: Our CMO wants the brand voice to be more casual and approachable,
but our CTO insists on maintaining technical authority. Help us reconcile these
preferences into a unified voice.
```

#### Expected Output Criteria
- [ ] Loads `assessment/reconciliation-workflow.md`
- [ ] Collects individual preferences from each stakeholder:
  - CMO: 3 desired words, 3 undesired words, content examples, attribute rankings
  - CTO: same structure
- [ ] Creates convergence matrix showing agreement/conflict points
- [ ] Identifies the core conflict: formality spectrum (casual vs. authoritative)
- [ ] Applies resolution hierarchy:
  1. Audience data: What does the developer audience prefer?
  2. Brand strategy: Which serves positioning better?
  3. Practical feasibility: What can the team maintain?
  4. Stakeholder priority: CMO for marketing voice, CTO for technical voice
- [ ] Proposes resolution as Option A: Update voice principles to accommodate both
  - E.g., "Approachable authority" — casual in marketing, authoritative in technical docs
  - Channel-specific tone settings that satisfy both
- [ ] Documents resolution rationale
- [ ] Produces sign-off tracker with both stakeholders listed
- [ ] Updates voice profile with reconciled attributes

#### Quality Gates Validated
- **QG-BV-5**: Sign-off tracker produced with all stakeholders

#### Success Criteria
- Both stakeholder positions are respected, not dismissed
- Resolution is principled (uses hierarchy), not arbitrary
- Sign-off tracker is actionable
- Updated profile resolves the conflict without contradiction

---

### Test Case 15: Resolve Conflict — Update Content (Option B with Migration Plan)

**Mode**: Reconciler
**Scenario**: New voice definition conflicts with existing published content. Resolution: keep new voice, migrate old content.

#### Test Request
```
@agent-brand-voice: We've redefined our voice to be more direct and concise, but our
existing content library (50+ articles) uses a verbose, academic style. We don't want
to change the new voice definition. Help us plan the content migration.
```

#### Expected Output Criteria
- [ ] Loads reconciliation workflow
- [ ] Confirms: new voice profile is the target, existing content is the change scope
- [ ] Does NOT suggest changing the new voice definition (respects stakeholder decision)
- [ ] Produces migration plan:
  - Categorizes existing content by priority (high-traffic first, evergreen vs. dated)
  - Estimates effort per content piece (minor edits vs. full rewrite)
  - Suggests phased approach (not all-at-once)
  - Identifies content that can be retired instead of migrated
- [ ] Provides before/after examples showing migration for 2-3 sample pieces
- [ ] Creates timeline with milestones
- [ ] Produces sign-off tracker for migration plan approval
- [ ] Notes: new content follows new voice immediately; old content migrates per plan

#### Quality Gates Validated
- **QG-BV-2**: Does not fabricate voice changes to avoid migration work
- **QG-BV-5**: Sign-off tracker for migration plan

#### Success Criteria
- Respects the stakeholder decision to keep the new voice
- Migration plan is realistic (phased, prioritized)
- Before/after examples are genuinely different in voice
- Clear separation: new content = new voice immediately, old content = phased migration

---

## Cross-Cutting Tests

### Test Case 16: Mode Transition — Assessor to Generator

**Mode**: Assessor -> Generator
**Scenario**: Define voice profile, then immediately generate content using it.

#### Test Request
```
@agent-brand-voice: Define our voice (we're a fintech startup targeting CFOs),
then generate a LinkedIn post announcing our Series A funding using that voice.
```

#### Expected Output Criteria
- [ ] Completes Assessor mode: interview, profile creation, save to system file
- [ ] Transitions to Generator mode without losing profile context
- [ ] In Generator mode:
  - Loads the profile just created (not a stale/different one)
  - Applies intent capture for the LinkedIn post
  - Generates content that demonstrably matches the just-defined voice
- [ ] Voice profile from assessment is consistent with generated content
- [ ] Transition is seamless — no re-discovery needed

#### Success Criteria
- Profile created in Assessor mode is correctly used in Generator mode
- No voice mismatch between definition and generation
- Transition does not require user to re-specify voice attributes

---

### Test Case 17: Integration with documentation-specialist

**Mode**: Assessor (output handoff)
**Scenario**: Voice profile defined, needs to be polished for team distribution.

#### Test Request
```
@agent-brand-voice: Our voice profile is complete. Hand it off to the documentation
specialist to polish it into a team-distributable brand voice guide.
```

#### Expected Output Criteria
- [ ] Agent references `documentation-specialist` in coordination section
- [ ] Prepares handoff: voice profile + context notes
- [ ] Either invokes `documentation-specialist` directly or provides clear instructions for user to do so
- [ ] Handoff includes:
  - Complete voice profile content
  - Target audience for the guide (content team, new hires)
  - Formatting preferences (PDF-ready, wiki-ready, etc.)
  - Key sections to emphasize

#### Success Criteria
- Agent acknowledges documentation-specialist as the right agent for polishing
- Handoff is structured enough for documentation-specialist to work autonomously
- Voice profile integrity maintained through handoff

---

### Test Case 18: Template Loading Validation

**Mode**: All modes
**Scenario**: Verify all referenced templates load successfully.

#### Test Request
```
Invoke agent-brand-voice in each mode and verify template loading.
```

#### Expected Output Criteria

**Core templates (from agent definition):**
- [ ] `assessment/discovery-questionnaire.md` — loads in Assessor mode
- [ ] `assessment/reconciliation-workflow.md` — loads in Reconciler mode
- [ ] `assessment/periodic-review-template.md` — loads in evolution review
- [ ] `voice-profile/principles-template.md` — loads when building profile
- [ ] `voice-profile/tone-matrix-template.md` — loads when building profile
- [ ] `voice-profile/vocabulary-guide-template.md` — loads when building profile
- [ ] `voice-profile/voice-attributes-template.md` — loads when building profile
- [ ] `workflows/initial-assessment-workflow.md` — loads in Assessor mode
- [ ] `workflows/content-generation-workflow.md` — loads in Generator mode
- [ ] `workflows/content-review-workflow.md` — loads in Reviewer mode
- [ ] `workflows/creator-analysis-workflow.md` — loads in Analyst mode
- [ ] `workflows/voice-evolution-workflow.md` — loads in evolution review

**Extended templates (from tasks #2 and #3):**
- [ ] `channel-rules/linkedin-rules.md` — loads for LinkedIn content
- [ ] `channel-rules/blog-rules.md` — loads for blog content
- [ ] `channel-rules/twitter-rules.md` — loads for Twitter content
- [ ] `channel-rules/mailings-rules.md` — loads for email content
- [ ] `channel-rules/customer-docs-rules.md` — loads for documentation
- [ ] `channel-rules/youtube-rules.md` — loads for YouTube content
- [ ] `channel-rules/instagram-rules.md` — loads for Instagram content
- [ ] `content-templates/intent-capture-template.md` — loads before any generation
- [ ] `content-templates/linkedin-post-template.md` — loads for LinkedIn
- [ ] `content-templates/blog-outline-template.md` — loads for blog
- [ ] `content-templates/thread-template.md` — loads for Twitter threads
- [ ] `content-templates/email-template.md` — loads for email
- [ ] `content-templates/social-post-template.md` — loads for general social
- [ ] `review-checklists/voice-compliance-checklist.md` — loads in Reviewer mode
- [ ] `review-checklists/tone-verification-checklist.md` — loads in Reviewer mode
- [ ] `review-checklists/vocabulary-scan-checklist.md` — loads in Reviewer mode
- [ ] `style-references/reference-analysis-template.md` — loads in Analyst mode
- [ ] `style-references/inspiration-library-template.md` — loads in Analyst mode
- [ ] `style-references/extraction-checklist.md` — loads in Analyst mode

**System files:**
- [ ] `.agent/system/brand-voice-profile.md` — loads in Generator/Reviewer/Analyst
- [ ] `.agent/memory/agents/agent-brand-voice-memory.md` — loads at mode start

#### Success Criteria
- All 33 templates exist and are readable
- No broken references in agent definition or workflow templates
- Templates load in the correct mode context

---

### Test Case 19: Memory Pattern Capture

**Mode**: All modes
**Scenario**: Verify patterns are captured to memory after significant interactions.

#### Test Request
```
After completing an Assessor session (TC-01), verify that any learned patterns
are written to the memory file.
```

#### Expected Output Criteria
- [ ] Memory file at `.agent/memory/agents/agent-brand-voice-memory.md` is read at session start
- [ ] After Assessor session: new patterns captured under appropriate category:
  - BRV (Brand Voice): e.g., "B2B SaaS dev tools brands tend toward informal authority"
  - INT (Interview): e.g., "Developers skip brand personality questions — reframe as 'how should docs feel'"
- [ ] Pattern format matches existing convention:
  - Pattern ID with category prefix (e.g., BRV-001)
  - Pattern description
  - Source project
  - Action recommendation
  - Tags
- [ ] Memory file updated timestamp incremented
- [ ] Total patterns count updated

#### Success Criteria
- Patterns are genuinely useful (not trivial observations)
- Category assignment is correct (BRV/CNT/INT/AUD/EVL)
- Format matches the memory file convention
- No duplicate patterns

---

## Aggregate Pass Criteria

For the agent to be considered production-ready:
- [ ] At least 17/19 test cases pass completely
- [ ] Critical test cases (TC-01, TC-04, TC-09, TC-10, TC-12, TC-14) must all pass
- [ ] All 6 quality gates (QG-BV-1 through QG-BV-6) validated by at least one passing test
- [ ] No fabrication violations in any test
- [ ] All 33 templates load successfully (TC-18)
- [ ] Memory patterns captured correctly (TC-19)
- [ ] Mode transitions work without context loss (TC-16)
- [ ] Agent coordination produces actionable handoffs (TC-17)

## Test Execution Log

| Test Case | Date | Status | Notes |
|-----------|------|--------|-------|
| TC-01 | YYYY-MM-DD | PENDING | Assessor: initial setup, no content |
| TC-02 | YYYY-MM-DD | PENDING | Assessor: conflict with existing library |
| TC-03 | YYYY-MM-DD | PENDING | Assessor: quarterly review, drift detection |
| TC-04 | YYYY-MM-DD | PENDING | Generator: LinkedIn post, intent capture |
| TC-05 | YYYY-MM-DD | PENDING | Generator: blog outline, polished mode |
| TC-06 | YYYY-MM-DD | PENDING | Generator: Twitter thread |
| TC-07 | YYYY-MM-DD | PENDING | Generator: email campaign |
| TC-08 | YYYY-MM-DD | PENDING | Generator: customer documentation |
| TC-09 | YYYY-MM-DD | PENDING | Reviewer: compliant content (>= 90%) |
| TC-10 | YYYY-MM-DD | PENDING | Reviewer: non-compliant content |
| TC-11 | YYYY-MM-DD | PENDING | Reviewer: mixed P0/P1/P2 violations |
| TC-12 | YYYY-MM-DD | PENDING | Analyst: external creator analysis |
| TC-13 | YYYY-MM-DD | PENDING | Analyst: update inspiration library |
| TC-14 | YYYY-MM-DD | PENDING | Reconciler: update principles (Option A) |
| TC-15 | YYYY-MM-DD | PENDING | Reconciler: update content (Option B) |
| TC-16 | YYYY-MM-DD | PENDING | Cross-cutting: Assessor -> Generator transition |
| TC-17 | YYYY-MM-DD | PENDING | Cross-cutting: documentation-specialist integration |
| TC-18 | YYYY-MM-DD | PENDING | Cross-cutting: all 33 templates load |
| TC-19 | YYYY-MM-DD | PENDING | Cross-cutting: memory pattern capture |

## Maintenance

### Quarterly Review
- [ ] Verify test cases remain relevant to agent definition
- [ ] Update for new templates or modes
- [ ] Add test cases for new capabilities
- [ ] Review pass/fail criteria against real-world usage

### When to Update Test Cases
- New operating mode added
- Template structure changes
- Quality gates modified
- User feedback indicates coverage gaps
- New channel rules or content templates added

---

**Document Owner**: Agent Architecture Team
**Review Frequency**: Quarterly
**Last Review**: 2026-02-23
