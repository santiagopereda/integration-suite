# LinkedIn Post Template

Specific structure for LinkedIn posts. Combines the social post template with LinkedIn channel rules for platform-optimized content.

## Prerequisites

- Intent capture completed (`intent_capture` metadata available)
- Voice profile loaded from `.agent/system/brand-voice-profile.md`
- LinkedIn channel rules loaded from `channel-rules/linkedin-rules.md`

## Post Format

### Line 1-2: Hook (Above the Fold)

The first ~210 characters appear before "see more". This is your entire pitch to earn the click.

**LinkedIn-specific hook patterns**:

| Pattern | Template | When to Use |
|---------|----------|-------------|
| Personal result | "[Metric] in [timeframe]. Here's how:" | Sharing an achievement with lessons |
| Contrarian | "Unpopular opinion: [take]." | Thought leadership, sparking discussion |
| Observation | "I've [reviewed/built/seen] [N] [things]. Pattern:" | Experience-based insight |
| Direct question | "[Question that your audience wrestles with]?" | Engagement / polling opinion |
| Story opener | "Last [day], [thing happened]." | Narrative posts |
| Framework reveal | "[N] [things] that [result]:" | Educational / list posts |

**Rules**:
- No filler openings ("So I've been thinking..." / "It's funny because...")
- Front-load the value or tension
- Line break after hook for visual separation

---

### Body: Choose a Structure

**Structure A: Lesson Post**
```
[Hook]

Here's what I learned:

1. [Lesson] — [1-sentence explanation]

2. [Lesson] — [1-sentence explanation]

3. [Lesson] — [1-sentence explanation]

The biggest takeaway: [synthesis]

[CTA]
```

**Structure B: Story Post**
```
[Hook — what happened]

[Context — 2-3 short paragraphs telling the story]

[Turning point — what changed]

[Lesson — what I/we took away]

[CTA]
```

**Structure C: Framework/Tips Post**
```
[Hook — promise of framework/tips]

Here's the framework:

Step 1: [Action]
→ [Why it matters]

Step 2: [Action]
→ [Why it matters]

Step 3: [Action]
→ [Why it matters]

[Summary sentence]

[CTA]
```

**Structure D: Hot Take Post**
```
[Bold claim]

[Why most people get it wrong — 2-3 sentences]

[What actually works — 2-3 sentences]

[Nuance — when the common approach IS valid]

[CTA]
```

---

### CTA Line

**LinkedIn-specific CTAs**:
- "What's your experience with [topic]? I'd love to hear in the comments."
- "Agree or disagree? Drop your take below."
- "Save this for your next [project/review/sprint]."
- "Follow for more [topic] posts."
- "Full write-up in the comments ↓" (link in first comment)

---

### Hashtags (Final Line)

```
#[Hashtag1] #[Hashtag2] #[Hashtag3]
```

- 3-5 hashtags
- Mix: 1-2 broad (#DataEngineering), 1-2 niche (#SchemaValidation), 1 branded if applicable
- Place on their own line at the end
- No hashtags inside the body text

---

## LinkedIn Post Metadata

```yaml
linkedin_post:
  intent_ref: "[Link to intent capture]"
  structure: "[Lesson / Story / Framework / HotTake]"
  hook_pattern: "[Pattern used]"
  cta_type: "[Comment / Save / Follow / Link]"
  hashtags: ["#Tag1", "#Tag2", "#Tag3"]
  media: "[none / image / carousel / document / video]"
  link_placement: "[first_comment / none]"
  estimated_length: "[word count]"
  cross_post_to: "[Twitter thread / Instagram carousel / none]"
  voice_check: false
```

## Post Review Checklist (Quick)

Before publishing:

- [ ] Hook earns the "see more" click
- [ ] Body uses short paragraphs with line breaks
- [ ] One clear CTA present
- [ ] No link in main post (use first comment)
- [ ] 3-5 relevant hashtags at the end
- [ ] Tone matches LinkedIn channel rules
- [ ] "I" voice preferred over "we" for personal brand
- [ ] Proofread for typos (especially in the hook)
- [ ] Media attached if planned (carousel, image, document)
