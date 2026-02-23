# Voice Compliance Checklist

12-point audit to verify content aligns with the documented brand voice profile. Run this checklist on every piece of content before publication.

## Prerequisites

- Voice profile loaded from `.agent/system/brand-voice-profile.md`
- Content draft ready for review
- Intent capture metadata available

## The 12-Point Voice Audit

### Principles & Identity

**1. Voice Principles Alignment**
- [ ] Content follows all documented voice principles
- [ ] No principle is violated or contradicted
- **Check**: Read each voice principle and ask: "Does this content embody it?"
- **Flag if**: Content takes a tone that contradicts any stated principle

**2. Voice Attribute Targets**
- [ ] Each voice attribute is within its target range on the spectrum
- [ ] No attribute has drifted toward a pole's "warning signs"
- **Check**: For each attribute (e.g., Formality 7/10), does the content feel like a 7?
- **Flag if**: Content reads as significantly more/less formal, energetic, warm, or authoritative than target

**3. Brand Personality Consistency**
- [ ] Content sounds like it comes from the same "person" as previous content
- [ ] Personality traits are evident without being forced
- **Check**: If you covered the byline, would you recognize the brand?
- **Flag if**: Content could belong to any brand — it's generic

---

### Tone & Context

**4. Tone Matrix Compliance**
- [ ] Tone settings match the matrix for this channel + audience + context
- [ ] Deliberate deviations are documented with rationale
- **Check**: Look up the exact tone matrix row for this content's context
- **Flag if**: Tone is significantly different from matrix without explanation

**5. Audience Appropriateness**
- [ ] Language complexity matches audience's expertise level
- [ ] References and examples are relevant to the target audience
- **Check**: Would the intended reader find this accessible and relevant?
- **Flag if**: Too technical for a general audience, or too basic for experts

**6. Channel Fit**
- [ ] Content follows the channel-specific rules (format, length, structure)
- [ ] Tone adjustments for this channel are applied
- **Check**: Does this feel native to the platform, not cross-posted lazily?
- **Flag if**: A LinkedIn post that reads like a press release, or a tweet that reads like a blog paragraph

---

### Language & Vocabulary

**7. Preferred Vocabulary**
- [ ] Uses preferred terms from vocabulary guide
- [ ] Avoided words and phrases are not present
- [ ] Brand-specific terms are used correctly (capitalization, no abbreviations)
- **Check**: Scan against the preferred/avoided word lists
- **Flag if**: Uses "leverage" instead of "use", or similar substitutable terms

**8. Sentence Patterns**
- [ ] Follows preferred sentence patterns (e.g., active voice, benefit-first)
- [ ] Sentence length is within target range
- [ ] Paragraph length is within target range
- **Check**: Calculate average sentence length; check voice (active vs. passive)
- **Flag if**: Consistently passive voice, or paragraphs exceeding 5 sentences

**9. Inclusive Language**
- [ ] No exclusionary terms or gendered language where neutral is possible
- [ ] Technical jargon follows the jargon policy (define on first use, etc.)
- [ ] Accessibility considerations met (alt text, clear structure)
- **Check**: Scan against inclusive language guide
- **Flag if**: Uses "guys", "whitelist/blacklist", or assumes specific cultural context

---

### Intent & Effectiveness

**10. Intent Alignment**
- [ ] Content delivers on the intent capture's core message
- [ ] Target audience's "think, feel, do" outcomes are addressed
- [ ] Primary CTA is present and clear
- **Check**: Compare draft against intent capture metadata
- **Flag if**: Content drifts from the original intent without documented reason

**11. Value Delivery**
- [ ] Content provides genuine value (teaches, informs, solves, inspires)
- [ ] Not self-promotional without offering substance
- [ ] Reader gains something concrete from consuming this content
- **Check**: What does the reader walk away with?
- **Flag if**: Content is primarily about the brand rather than for the reader

**12. Authenticity**
- [ ] Claims are backed by evidence, experience, or data
- [ ] No exaggeration, hype, or unsubstantiated superlatives
- [ ] Tone feels genuine, not performative
- **Check**: Can every claim be defended if questioned?
- **Flag if**: Uses "revolutionary", "game-changing", or "industry-leading" without proof

---

## Scoring

| Points | Rating | Action |
|:------:|--------|--------|
| 12/12 | Publish-ready | Proceed to publication |
| 10-11 | Minor adjustments | Fix flagged items; no re-review needed |
| 7-9 | Revision needed | Address issues and run checklist again |
| < 7 | Major revision | Likely needs re-drafting from intent capture |

## Review Log

```yaml
voice_review:
  content_title: "[Title or identifier]"
  reviewer: "[Name or role]"
  review_date: "[YYYY-MM-DD]"
  score: "[X/12]"
  flagged_items: []  # List item numbers that failed
  notes: "[Key observations]"
  status: "[pass / minor_revision / revision / major_revision]"
```
