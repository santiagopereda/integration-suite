# Blog Outline Template

Structure for planning blog posts before drafting. Ensures alignment with intent, voice, and audience needs.

## Prerequisites

- Intent capture completed (`intent_capture` metadata available)
- Voice profile loaded from `.agent/system/brand-voice-profile.md`
- Blog channel rules loaded from `channel-rules/blog-rules.md`

## Title Options

Generate 3-5 title options. The best titles are clear, specific, and promise value.

| # | Title | Type | SEO Keyword |
|---|-------|------|-------------|
| 1 | [Title] | [How-to / Opinion / Guide / Case Study] | [Primary keyword] |
| 2 | [Title] | | |
| 3 | [Title] | | |
| 4 | [Title] | | |
| 5 | [Title] | | |

**Title evaluation criteria**:
- Does it promise a specific benefit or answer a question?
- Is the primary keyword front-loaded?
- Under 60 characters for full display in search results?
- Would you click on this in a search result?

**Selected title**: [Choose one]

## Article Metadata

```yaml
blog_outline:
  intent_ref: "[Link to intent capture]"
  title: "[Selected title]"
  content_type: "[tutorial / opinion / case-study / comparison / guide / explainer]"
  target_word_count: "[Range, e.g., 1200-1600]"
  estimated_read_time: "[X min]"
  target_audience: "[From intent capture]"
  seo_primary_keyword: "[Keyword]"
  seo_secondary_keywords: []
  internal_links: []  # Related existing content to link to
  external_links: []  # Sources, tools, references to cite
```

## Outline Structure

### Introduction (10-15% of word count)

**Hook** (first 1-2 sentences):
- [ ] Opens with the problem, not the solution
- [ ] Creates recognition ("I've seen this before")
- Pattern: [stat / anecdote / question / bold claim]

**Context** (2-3 sentences):
- [ ] Why this matters now
- [ ] Who this is for

**Promise** (1 sentence):
- [ ] What the reader will learn or be able to do

---

### Section 1: [Heading]

**Purpose**: [What this section accomplishes]

**Key points**:
1. [Point]
2. [Point]
3. [Point]

**Evidence/examples**:
- [ ] Code sample
- [ ] Screenshot / diagram
- [ ] Data / stat
- [ ] Anecdote

**Transition to next section**: [How this connects]

---

### Section 2: [Heading]

**Purpose**: [What this section accomplishes]

**Key points**:
1. [Point]
2. [Point]
3. [Point]

**Evidence/examples**:
- [ ] Code sample
- [ ] Screenshot / diagram
- [ ] Data / stat
- [ ] Anecdote

**Transition**: [How this connects]

---

### Section 3: [Heading]

**Purpose**: [What this section accomplishes]

**Key points**:
1. [Point]
2. [Point]
3. [Point]

**Evidence/examples**:
- [ ] ...

---

### [Add more sections as needed]

---

### Conclusion (10% of word count)

**Summary**: Key takeaways (3-5 bullet points)

**Next step**: What should the reader do right now?

**CTA**: [From intent capture — aligned with `audience_do`]

---

## Optional Sections

Include if relevant to the content type:

- [ ] **TL;DR / Key Takeaways** — for posts over 1,500 words
- [ ] **Prerequisites** — for tutorials
- [ ] **FAQ** — for guides and explainers
- [ ] **Further reading** — for deep dives
- [ ] **Changelog** — for posts that will be updated

## Outline Review Checklist

Before moving to draft:

- [ ] Title promises clear value
- [ ] Introduction hooks within 2 sentences
- [ ] Each section has a distinct purpose (no overlap)
- [ ] Evidence/examples planned for every major claim
- [ ] Logical flow from section to section
- [ ] Conclusion drives to a specific action
- [ ] Intent capture goals are addressed (think, feel, do)
- [ ] Voice profile tone settings identified for this content type
- [ ] Word count estimate fits the target range
