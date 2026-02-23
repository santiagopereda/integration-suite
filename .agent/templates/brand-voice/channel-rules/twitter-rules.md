# Twitter / X Channel Rules

Rules for adapting brand voice to Twitter/X's fast-paced, concise format.

## Platform Characteristics

- Microblogging: 280-character limit per post (X Premium: 25,000)
- Real-time, fast-moving feed; content has short lifespan
- Threads allow extended storytelling (series of connected posts)
- Engagement: likes, reposts, quotes, replies, bookmarks
- Algorithm favors replies, quotes, and engagement velocity
- Audience can be global and unpredictable; posts are public by default

## Audience Expectations

- **Primary**: Industry peers, tech community, prospective followers
- **Mindset**: Scrolling quickly; looking for sharp insights, useful takes, interesting threads
- **Tolerance**: Zero tolerance for fluff; high respect for concise expertise
- **Engagement**: Expect quick, valuable takes — not press releases

## Tone Guidelines

| Dimension | Setting | Notes |
|-----------|:-------:|-------|
| Formality | 2/5 | Casual, direct, sharp |
| Energy | 4/5 | Punchy, opinionated, dynamic |
| Warmth | 3/5 | Human and approachable but not soft |
| Authority | 3-4/5 | Confident opinions backed by experience |

**Tone shifts by post type**:
- Hot take / opinion: Energy +1, Authority +1
- Thread / educational: Warmth +1, measured pacing
- Reply / engagement: Formality -1, conversational
- Announcement: Energy +1, brief and impactful

## Format Constraints

### Single Post Rules
- Target 200-260 characters to leave room for engagement
- One clear idea per tweet
- Front-load the insight — no buildup needed
- Line breaks for emphasis (single tweet can have 2-3 lines)
- Hashtags: 0-2 max; only if genuinely relevant (avoid #MondayMotivation style)
- Links: one max; use link-in-reply if the post itself is the value

### Thread Structure
1. **Tweet 1 (hook)**: Bold claim, question, or promise — must stand alone
2. **Tweets 2-N (body)**: One point per tweet; self-contained but connected
3. **Final tweet**: Summary + CTA (follow, bookmark, share the thread)
4. **Label it**: Start with "Thread:" or use a numbering system (1/7, 2/7...)

### Thread Rules
- 5-12 tweets is the sweet spot; over 15 loses readers
- Each tweet should make sense if read in isolation (some will be retweeted alone)
- Use the first reply to add context, links, or resources
- Avoid "1/" on the hook tweet — it signals a thread but the hook should earn the click

### Media Usage
- Images increase engagement 2-3x; use screenshots, diagrams, code snippets
- Code screenshots: dark theme, large font, minimal lines visible
- Memes/humor: only if it fits brand voice and won't age poorly
- Videos: under 60 seconds; autoplay means the first frame matters

## Best Practices

- **Be opinionated** — bland takes get scrolled past; take a clear position
- **Quote tweet with value** — add insight when sharing others' content, not just "This!"
- **Reply thoughtfully** — substantive replies build following faster than original posts
- **Post consistently** — 1-3 tweets/day; threads 1-2x per week
- **Timing matters** — mornings (8-10am) and lunch (12-1pm) in your audience's timezone
- **Pin your best thread** — your pinned post is your landing page
- **Don't delete bad takes** — correct and own them; it builds trust
- **Use bookmarks** — curate ideas for threads; share reading lists
- **Avoid corporate speak** — "We're excited to announce" reads like a press release; just say what happened

## Examples

### Good Single Post
```
Most data pipelines fail on Mondays.

Not because of bad code.
Because someone changed a schema on Friday and nobody downstream knew.

Schema contracts > monitoring dashboards.
```

### Bad Single Post
```
We are thrilled to announce our new partnership with XYZ Corp!
Together we will revolutionize the data infrastructure space.
Read our press release: [link] #Innovation #Partnership #BigData
```

### Good Thread Hook
```
I've reviewed 50+ data architectures this year.

The ones that actually work share 5 patterns.

The ones that fail share 3 anti-patterns.

Here's what I found:
```

### Good Thread Body (tweets 2-4 of a thread)
```
[2/8]
Pattern 1: Schema-as-code

The best teams version their schemas like application code.
PRs, reviews, CI checks.

If a column changes, the pipeline knows before it runs — not after it fails.
```
```
[3/8]
Pattern 2: Idempotent everything

Every job can run twice without duplicating data.

This sounds basic until you're debugging a pipeline that ran 3 times
during an incident recovery and tripled your invoice table.
```
```
[4/8]
Pattern 3: Dead letter queues at every boundary

Bad records don't crash the pipeline.
They get captured, logged, and reviewed.

Production keeps running. Data quality gets measured, not assumed.
```

### Bad Thread Tweet
```
[2/10]
So basically what I mean is that you should probably think about
maybe implementing some kind of schema management solution if
you haven't already, because it can really help with a lot of
the issues that teams commonly face... (1/2)
```
