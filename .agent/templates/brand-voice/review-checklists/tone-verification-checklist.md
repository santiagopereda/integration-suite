# Tone Verification Checklist

Verifies that content tone is appropriate for the specific audience, channel, and context. Catches tone mismatches that the voice compliance checklist might miss at a higher level.

## Prerequisites

- Voice profile loaded from `.agent/system/brand-voice-profile.md`
- Tone matrix available from voice profile
- Content draft ready for review
- Target channel and audience identified

## Step 1: Identify Target Tone

Look up the correct tone settings from the tone matrix:

```
Channel:  [e.g., LinkedIn]
Audience: [e.g., Technical decision makers]
Context:  [e.g., Product announcement]

Target tone:
  Formality: [X/5]
  Energy:    [X/5]
  Warmth:    [X/5]
  Authority: [X/5]
```

Note any channel-specific overrides from the channel rules file.

## Step 2: Read-Through Assessment

Read the content once, then score each dimension intuitively before analyzing:

| Dimension | Target | Perceived | Delta | Status |
|-----------|:------:|:---------:|:-----:|--------|
| Formality | [X/5] | [X/5] | [+/-N] | [OK / Adjust] |
| Energy | [X/5] | [X/5] | [+/-N] | [OK / Adjust] |
| Warmth | [X/5] | [X/5] | [+/-N] | [OK / Adjust] |
| Authority | [X/5] | [X/5] | [+/-N] | [OK / Adjust] |

**Acceptable delta**: +/- 1 point is within range. +/- 2 or more requires adjustment.

## Step 3: Dimension Deep Dive

For each dimension that needs adjustment, use these diagnostic checks:

### Formality Check

| Signal | Too Casual (needs +) | Too Formal (needs -) |
|--------|---------------------|----------------------|
| Contractions | Excessive use | Zero contractions reads stiff |
| Slang/idioms | Present when shouldn't be | Appropriate colloquialisms missing |
| Sentence structure | Fragments, run-ons | Every sentence is complex/compound |
| Address | "hey", "folks" | "Dear stakeholders" |
| Vocabulary | Informal choices | Unnecessarily elevated language |

**Adjustment techniques**:
- +Formality: Replace contractions, use complete sentences, elevate word choice
- -Formality: Add contractions, shorter sentences, conversational phrasing

### Energy Check

| Signal | Too Low (needs +) | Too High (needs -) |
|--------|-------------------|---------------------|
| Pacing | Long, dense paragraphs | All short sentences, breathless |
| Punctuation | No variation, all periods | Excessive exclamation marks |
| Word choice | Passive, muted verbs | Superlatives, hype words |
| Opening | Slow, buried lead | Overpromising hook |
| Overall feel | Monotone, academic | Salesy, performative |

**Adjustment techniques**:
- +Energy: Stronger verbs, shorter sentences, more direct address, varied punctuation
- -Energy: Longer sentences, measured pacing, remove superlatives, calm verbs

### Warmth Check

| Signal | Too Cold (needs +) | Too Warm (needs -) |
|--------|--------------------|--------------------|
| Pronouns | "one", "users" | Excessive "we", "together" |
| Empathy markers | None | Overuse of "I understand how you feel" |
| Reader address | Impersonal, third person | Overly familiar, presumptuous |
| Emotional language | Clinical, detached | Sentimental, flattering |
| Vulnerability | Zero personal disclosure | Oversharing |

**Adjustment techniques**:
- +Warmth: Use "you", acknowledge reader's experience, add relatable examples
- -Warmth: Reduce personal pronouns, focus on facts, remove emotional appeals

### Authority Check

| Signal | Too Low (needs +) | Too High (needs -) |
|--------|--------------------|---------------------|
| Hedging | "Maybe", "possibly", "I think" | Never acknowledges uncertainty |
| Evidence | Claims without support | Over-citation feels insecure |
| Framing | Suggestions, "you might consider" | Commands, "you must" |
| Expertise signals | No credentials or experience shown | Name-dropping, credential-heavy |
| Position-taking | Avoids opinions | Dismisses alternatives |

**Adjustment techniques**:
- +Authority: Remove hedging language, add evidence, take clear positions
- -Authority: Add "in my experience", acknowledge alternatives, soften directives

## Step 4: Boundary Check

Verify tone stays within the absolute boundaries from the tone matrix:

- [ ] No dimension falls below the documented minimum for any context
- [ ] No dimension exceeds the documented maximum for any context
- [ ] Absolute rules are respected (e.g., "never use sarcasm in support contexts")

## Step 5: Context Sensitivity

Check for tone-sensitive situations:

- [ ] **Bad news / incident**: Warmth is elevated; energy is measured; no humor
- [ ] **Celebration / launch**: Energy is elevated; warmth is high; authority can relax
- [ ] **Controversial topic**: Authority is elevated; formality is up; avoid flippancy
- [ ] **Support / help**: Warmth is maximum; patience evident; no assumptions about user error
- [ ] **Cross-cultural audience**: Formality slightly higher; avoid idioms and cultural references

## Review Log

```yaml
tone_review:
  content_title: "[Title or identifier]"
  channel: "[Channel]"
  audience: "[Audience segment]"
  context: "[Content context]"
  reviewer: "[Name or role]"
  review_date: "[YYYY-MM-DD]"
  dimensions:
    formality: { target: X, perceived: X, status: "ok/adjust" }
    energy: { target: X, perceived: X, status: "ok/adjust" }
    warmth: { target: X, perceived: X, status: "ok/adjust" }
    authority: { target: X, perceived: X, status: "ok/adjust" }
  boundary_violations: []
  adjustments_needed: "[Summary of changes]"
  status: "[pass / adjust / rewrite]"
```
