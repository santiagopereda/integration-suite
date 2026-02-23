# Blog Channel Rules

Rules for adapting brand voice to long-form blog content and thought leadership.

## Platform Characteristics

- Owned media with full editorial control
- Long-form format: 800-2,500 words typical
- High SEO value; evergreen content compounds over time
- Supports rich formatting: headings, code blocks, images, diagrams, tables
- Readers arrive via search, social shares, or newsletter links
- Dwell time and scroll depth matter for engagement

## Audience Expectations

- **Primary**: Practitioners seeking depth, decision-makers evaluating expertise
- **Mindset**: Problem-solving, learning, validating approaches
- **Tolerance**: High tolerance for depth; low tolerance for fluff or clickbait
- **Engagement**: Expect actionable takeaways, not vague generalities

## Tone Guidelines

| Dimension | Setting | Notes |
|-----------|:-------:|-------|
| Formality | 3/5 | Conversational expertise — not academic, not casual |
| Energy | 3/5 | Steady, confident pacing |
| Warmth | 3/5 | Approachable; use "you" to address the reader |
| Authority | 4-5/5 | Back claims with evidence, examples, data |

**Tone shifts by content type**:
- Tutorial / how-to: Warmth +1, direct instructional voice
- Opinion / analysis: Authority +1, take clear positions
- Case study: Energy +1, narrative-driven
- Comparison / guide: Formality +1, balanced and fair

## Format Constraints

### Article Structure
1. **Title**: Clear benefit or curiosity gap; avoid clickbait
2. **Introduction** (2-3 paragraphs): State the problem, why it matters, what the reader will learn
3. **Body**: Logical sections with descriptive H2/H3 headings
4. **Conclusion**: Summary of key points + clear next step or CTA
5. **Metadata**: Author, date, category, estimated read time

### Formatting Rules
- Use H2 for major sections, H3 for subsections; never skip heading levels
- Paragraphs: 2-4 sentences max; break up dense reasoning
- Use code blocks with language identifiers for all technical snippets
- Tables for comparisons; bullet lists for enumerations
- Bold for key terms on first mention; avoid over-bolding
- Include a TL;DR or key takeaways section for long posts (>1,500 words)
- Alt text on all images; descriptive captions

### Length Guidelines
| Content Type | Word Count | Read Time |
|-------------|-----------|-----------|
| Quick tip | 400-800 | 2-3 min |
| Standard post | 1,000-1,800 | 5-8 min |
| Deep dive | 2,000-3,500 | 10-15 min |
| Guide / pillar | 3,000-5,000 | 15-25 min |

## Best Practices

- **Open with the problem, not the solution** — readers need to feel the pain before the fix
- **One idea per post** — go deep, not wide; save related ideas for a series
- **Show, don't tell** — code samples, screenshots, diagrams, real examples over theory
- **Cite sources** — link to docs, papers, original tools; builds trust
- **Write scannable content** — a reader skimming headings and bold text should get the gist
- **End with action** — what should the reader do next? Try it, read more, discuss?
- **Update old posts** — add an "Updated [date]" note; keep evergreen content current
- **Avoid hedging language** — "I think maybe this could possibly help" weakens authority; take positions

## Examples

### Good Opening
```markdown
## Why Your Data Pipeline Breaks Every Monday

Every Monday morning, the same Slack message: "Pipeline failed overnight."

You check the logs. A schema changed upstream. Again.

This isn't a monitoring problem. It's a contracts problem. Here's how
to fix it with schema registries and validation gates — without slowing
down the teams producing the data.
```

### Bad Opening
```markdown
## Introduction to Data Pipelines

In today's fast-paced digital landscape, data is the new oil. Companies
everywhere are leveraging big data to drive innovation. In this blog post,
we will explore some interesting aspects of data pipelines and how they
can potentially help your organization.
```

### Good Technical Section
```markdown
## Setting Up Schema Validation

Add a validation step before your transformation layer:

\```python
from schema_registry import SchemaValidator

validator = SchemaValidator(registry_url="https://schema.internal")

def validate_incoming(record: dict, schema_id: str) -> bool:
    result = validator.validate(record, schema_id)
    if not result.valid:
        dead_letter_queue.send(record, errors=result.errors)
        return False
    return True
\```

This catches malformed records before they corrupt downstream tables.
The dead letter queue preserves them for investigation without blocking
the pipeline.
```
