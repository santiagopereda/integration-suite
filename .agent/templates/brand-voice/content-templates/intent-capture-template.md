# Intent Capture Template

**CRITICAL**: This is the mandatory first step before generating any content. Every content request must pass through intent capture to ensure alignment with brand voice, audience needs, and business goals.

## Purpose

Captures the content creator's intent and context before any drafting begins. Prevents wasted effort from misaligned assumptions. The four questions below are non-negotiable.

## The 4 Mandatory Questions

### Question 1: Intent

> **What do you want to say, and why does it matter right now?**

Captures the core message and its urgency/relevance.

**Probe deeper if needed**:
- What triggered this content? (event, insight, request, calendar)
- What's the single most important idea to communicate?
- Why should the audience care about this today, not next month?

**Record**:
- Core message (1 sentence):
- Trigger/context:
- Timeliness factor:

---

### Question 2: Timing

> **When and where will this be published?**

Determines channel rules, format constraints, and scheduling context.

**Probe deeper if needed**:
- Which channel(s)? (LinkedIn, blog, email, Twitter, YouTube, Instagram, docs)
- Is this part of a campaign or series?
- Are there external timing dependencies? (product launch, event, news cycle)
- Cross-posting plan?

**Record**:
- Primary channel:
- Secondary channels:
- Target publish date:
- Campaign/series context:

---

### Question 3: Outcome

> **What should the audience think, feel, or do after consuming this?**

Defines the success state from the audience's perspective.

**Probe deeper if needed**:
- **Think**: What new understanding should they have?
- **Feel**: What emotion should this evoke? (inspired, reassured, curious, urgency)
- **Do**: What specific action should they take? (sign up, try it, share, reply, buy)
- Who is the primary audience for this specific piece?

**Record**:
- Think:
- Feel:
- Do (primary CTA):
- Target audience:

---

### Question 4: Metric

> **How will you measure whether this content succeeded?**

Grounds the content in measurable business impact.

**Probe deeper if needed**:
- What's the primary KPI? (engagement, traffic, conversions, awareness)
- What does "good" look like for this metric? (specific number or range)
- How long until you evaluate? (24h for social, 2 weeks for blog, 30 days for email)
- Is there a secondary metric worth tracking?

**Record**:
- Primary metric:
- Target value:
- Evaluation timeline:
- Secondary metric:

---

## Intent Capture Metadata

After completing the 4 questions, compile the structured metadata block. This block is passed to all downstream templates (content generation, review, scoring).

```yaml
intent_capture:
  # Question 1: Intent
  core_message: "[One sentence summary]"
  trigger: "[What prompted this content]"
  timeliness: "[Why now]"

  # Question 2: Timing
  primary_channel: "[Channel name]"
  secondary_channels: []
  publish_date: "[YYYY-MM-DD or 'ASAP' or 'TBD']"
  campaign: "[Campaign name or 'standalone']"

  # Question 3: Outcome
  audience_think: "[New understanding]"
  audience_feel: "[Target emotion]"
  audience_do: "[Primary CTA]"
  target_audience: "[Specific audience segment]"

  # Question 4: Metric
  primary_metric: "[KPI name]"
  target_value: "[Specific number or range]"
  eval_timeline: "[When to evaluate]"
  secondary_metric: "[Optional secondary KPI]"

  # Metadata
  captured_by: "[Name or role]"
  captured_date: "[YYYY-MM-DD]"
  voice_profile: "[Path to brand voice profile]"
  status: "captured"  # captured → drafting → review → published
```

## Using the Metadata

Once captured, the metadata drives all downstream decisions:

| Downstream Step | Uses |
|----------------|------|
| Channel selection | `primary_channel` → loads matching channel rules |
| Content template | `primary_channel` → selects appropriate content template |
| Tone settings | `audience_feel` + `primary_channel` → tone matrix lookup |
| Draft review | `audience_do` → verify CTA is present and clear |
| Performance review | `primary_metric` + `target_value` → post-publish evaluation |

## Workflow Integration

```
1. Creator requests content
       ↓
2. ★ INTENT CAPTURE (this template) ★
       ↓
3. Load channel rules for primary_channel
       ↓
4. Select content template for format
       ↓
5. Generate draft using voice profile + intent metadata
       ↓
6. Review against checklists
       ↓
7. Publish and track against metric
```

## Rules

- **Never skip intent capture** — even for "quick" or "simple" content requests
- **All 4 questions must be answered** — partial capture leads to misaligned content
- **Push back on vague answers** — "just get some engagement" is not a metric; ask for specifics
- **Re-capture if scope changes** — if the brief evolves significantly, update the metadata
- **Keep it fast** — intent capture should take 5-10 minutes, not an hour; it's a focusing tool, not a bureaucracy
