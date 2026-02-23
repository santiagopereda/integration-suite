# Social Post Template

Generic structure for social media posts across platforms. For platform-specific rules, load the corresponding channel rules file.

## Prerequisites

- Intent capture completed (`intent_capture` metadata available)
- Voice profile loaded from `.agent/system/brand-voice-profile.md`
- Channel rules loaded for target platform

## Post Structure

### 1. Hook (First Line)

The hook must stop the scroll. It appears before the "see more" fold on most platforms.

**Hook patterns** (choose one):

| Pattern | Example | Best For |
|---------|---------|----------|
| Bold claim | "Most CI/CD pipelines are security theater." | Opinion posts |
| Surprising stat | "73% of data breaches start with a misconfigured API." | Data-driven posts |
| Question | "What's the most expensive bug you've shipped?" | Engagement posts |
| Contrarian take | "You don't need microservices." | Thought leadership |
| Result/outcome | "We cut deploy time from 45 min to 3 min." | Achievement posts |
| How-to promise | "3 checks that prevent 80% of pipeline failures:" | Educational posts |

**Rules**:
- Under 125 characters (Instagram fold) or 200 characters (LinkedIn fold)
- No filler words ("So", "Well", "Basically")
- Don't start with "I" unless sharing a personal story

### 2. Body

Expands on the hook with supporting detail, examples, or a brief narrative.

**Structure options**:

**List format** (for tips, frameworks, patterns):
```
Here's what works:

1. [Point] — [brief explanation]
2. [Point] — [brief explanation]
3. [Point] — [brief explanation]
```

**Narrative format** (for stories, lessons):
```
[Setup — what happened]

[Turning point — what changed]

[Lesson — what I learned]
```

**Before/after format** (for transformations):
```
Before: [pain state]
After: [improved state]

The shift: [what changed and why]
```

**Rules**:
- One short paragraph per point (1-2 sentences)
- Line breaks between paragraphs for readability
- Concrete specifics over vague claims ("3 hours" not "a lot of time")

### 3. CTA (Call to Action)

Every post needs a clear next step for the reader.

**CTA options by goal**:

| Goal | CTA Example |
|------|-------------|
| Discussion | "What's your experience with this? Drop a comment." |
| Save/bookmark | "Save this for your next project." |
| Share | "Share with someone who needs to hear this." |
| Traffic | "Full breakdown in the blog post — link in comments." |
| Follow | "Follow for more [topic] posts." |
| Action | "Try this on your next deployment and let me know." |

**Rules**:
- One primary CTA per post
- Phrase as an invitation, not a command
- Place after the body, with a line break before it

## Metadata Block

Include in your working draft (remove before publishing):

```yaml
social_post:
  intent_ref: "[Link to intent capture]"
  platform: "[Primary platform]"
  hook_pattern: "[Pattern used]"
  cta_type: "[Goal type]"
  hashtags: []
  media: "[none / image / carousel / video]"
  cross_post: "[Platforms to adapt for]"
  voice_check: false  # Set true after voice compliance review
```

## Platform Adaptation Notes

When cross-posting, adjust — don't copy-paste:

| Adaptation | LinkedIn | Twitter | Instagram |
|-----------|----------|---------|-----------|
| Length | Full post OK | Condense to 280 chars or thread | Caption + visual |
| Hashtags | 3-5 at end | 0-2 inline | 5-15 in caption or comment |
| Links | In first comment | In reply or inline | "Link in bio" |
| Media | Optional | Increases engagement 2x | Required |
| Tone | Professional | Punchy, casual | Visual-first, friendly |
