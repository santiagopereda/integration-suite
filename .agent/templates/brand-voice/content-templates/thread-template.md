# Thread Template

Structure for Twitter/X threads and other platform thread formats (LinkedIn multi-part, Mastodon). Optimized for thread-native storytelling.

## Prerequisites

- Intent capture completed (`intent_capture` metadata available)
- Voice profile loaded from `.agent/system/brand-voice-profile.md`
- Twitter channel rules loaded from `channel-rules/twitter-rules.md`

## Thread Planning

### Thread Metadata

```yaml
thread:
  intent_ref: "[Link to intent capture]"
  topic: "[Thread topic in one phrase]"
  tweet_count: "[Target: 5-12]"
  hook_pattern: "[Pattern used for tweet 1]"
  structure: "[Listicle / Narrative / Breakdown / Tutorial / Contrarian]"
  media_plan: "[Which tweets get images/code screenshots]"
  cross_post_to: "[LinkedIn carousel / blog post / none]"
  voice_check: false
```

### Structure Selection

| Structure | Best For | Thread Length |
|-----------|----------|:------------:|
| Listicle | Tips, patterns, mistakes, tools | 6-10 tweets |
| Narrative | Story, lesson learned, journey | 5-8 tweets |
| Breakdown | Analyzing a concept, technology, event | 7-12 tweets |
| Tutorial | Step-by-step how-to | 5-8 tweets |
| Contrarian | Challenging conventional wisdom | 5-7 tweets |

## Thread Outline

### Tweet 1: Hook

The hook tweet must stand alone as a compelling post. It earns the thread read.

**Template**:
```
[Bold claim / surprising stat / promise of value]

[One-line expansion or context]

Thread ↓
```

**Rules**:
- Must make sense without the rest of the thread
- Don't number the hook tweet (no "1/")
- Don't say "A thread" — show, don't label
- Under 280 characters (leave room for quote retweets)

---

### Tweet 2: Context or First Point

Sets up the thread or delivers the first piece of value.

**Template (context)**:
```
First, some context:

[Background needed to understand the rest of the thread]
[Keep it to 2-3 sentences max]
```

**Template (first point)**:
```
1. [Point title]

[Explanation in 2-3 sentences]

[Optional: concrete example or data point]
```

---

### Tweets 3-N: Body Tweets

Each body tweet delivers one point, one step, or one beat of the narrative.

**Template (listicle)**:
```
[N]. [Point]

[2-3 sentence explanation]

[Example, data, or visual if applicable]
```

**Template (narrative)**:
```
[Story beat — what happened next]

[1-2 sentences of context or reaction]
```

**Template (tutorial)**:
```
Step [N]: [Action]

[How to do it — brief instruction]

[Code snippet or screenshot if applicable]
```

**Rules per body tweet**:
- One idea per tweet — if you need two tweets for one point, the point is too big
- Each tweet should be understandable if retweeted alone
- Use concrete specifics: numbers, names, real examples
- Vary tweet length — mix short punchy tweets with slightly longer ones
- Add images/screenshots to 2-3 tweets in the thread for engagement

---

### Tweet N-1: Synthesis

Ties the thread together before the closing CTA.

**Template**:
```
The common thread across all of these:

[One-sentence synthesis of the key insight]

[Optional: reframe the hook tweet's claim with new context from the thread]
```

---

### Tweet N: Closing CTA

**Template**:
```
TL;DR:

[3-5 bullet summary of key points]

If this was useful:
- Repost the first tweet to share it
- Follow @[handle] for more [topic]
- Bookmark this thread for reference
```

**Alternative CTA patterns**:
- "What would you add to this list?" (discussion)
- "Which of these resonated most?" (engagement)
- "I'm writing a deeper dive on [topic]. What should I cover?" (content ideas)

---

### Reply Tweet: Resources (Optional)

**Template**:
```
Resources mentioned in this thread:

- [Resource 1]: [link]
- [Resource 2]: [link]
- [Resource 3]: [link]

Full blog version: [link]
```

Post as a reply to the hook tweet so it stays connected but doesn't clutter the thread.

## Thread Review Checklist

Before publishing:

- [ ] Hook works as a standalone post
- [ ] Each tweet conveys one clear idea
- [ ] No tweet exceeds 280 characters (unless using X Premium and deliberately going long)
- [ ] Thread has 5-12 tweets (under 5 feels thin; over 12 loses readers)
- [ ] 2-3 tweets include media (images, screenshots, code)
- [ ] Synthesis tweet ties the thread back to the hook
- [ ] CTA is specific and actionable
- [ ] Resource links are in a reply, not in the thread body
- [ ] Tone matches Twitter channel rules
- [ ] No tweet starts with "So," or "Basically,"
- [ ] Read each tweet in isolation — does it still make sense?

## Cross-Posting Adaptation

| Platform | Adaptation |
|----------|-----------|
| LinkedIn | Merge into a single long post; add hashtags; adjust tone to professional |
| Instagram | Convert to carousel (1 slide per tweet); add visual design |
| Blog | Expand each tweet into a paragraph; add depth and examples |
| Newsletter | Use thread as outline; expand with additional context |
