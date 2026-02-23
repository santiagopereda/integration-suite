# Content Intent Log

Tracks all content generated through agent-brand-voice with intent metadata. Feeds the memory system to identify which intents, channels, and audiences produce the best outcomes.

## Purpose

- Create a queryable record of every content piece generated through the brand voice agent
- Enable pattern extraction: which intents drive engagement, which channels perform, which audiences respond
- Support voice evolution by showing what content was produced under which voice profile version
- Feed `.agent/memory/agents/agent-brand-voice-memory.md` with INT-xxx, CNT-xxx, and AUD-xxx patterns

## Entry Format

Each entry represents one content piece from intent capture through publication and measurement.

```yaml
# Entry ID: CONTENT-{YYYY}{MM}{DD}-{NNN}
- id: "CONTENT-20260223-001"
  status: "captured | drafted | reviewed | published | measured"

  # From intent capture
  intent:
    core_message: "[One sentence]"
    trigger: "[What prompted this]"
    timeliness: "[Why now]"

  # Channel & timing
  channel:
    primary: "[Channel name]"
    secondary: []
    publish_date: "[YYYY-MM-DD]"
    campaign: "[Campaign name or standalone]"

  # Target outcome
  outcome:
    audience_think: "[Understanding]"
    audience_feel: "[Emotion]"
    audience_do: "[CTA]"
    target_audience: "[Segment]"

  # Success criteria
  metric:
    primary: "[KPI name]"
    target_value: "[Number or range]"
    eval_timeline: "[When to check]"
    secondary: "[Optional KPI]"

  # Generation metadata
  generation:
    voice_profile_version: "[Version from profile metadata]"
    mode: "[Generator]"
    templates_used: ["[template1.md]", "[template2.md]"]
    voice_compliance_score: "[X/12]"
    tone_verification: "pass | adjust | rewrite"
    vocabulary_scan: "clean | minor_fixes | revision_needed"
    generation_time_minutes: "[N]"

  # Post-publish results (filled after eval_timeline)
  results:
    primary_metric_actual: "[Actual value]"
    secondary_metric_actual: "[Actual value]"
    met_target: true | false
    audience_feedback: "[Summary of comments/reactions]"
    lessons: "[What worked, what didn't]"
```

## Log Entries

*No entries yet. First entry will be created when agent-brand-voice Generator mode produces content with intent capture.*

---

## Example Entry

```yaml
- id: "CONTENT-20260223-001"
  status: "measured"

  intent:
    core_message: "Schema contracts prevent 73% of pipeline failures"
    trigger: "Internal data showing Monday morning failure spike"
    timeliness: "Data quality week in engineering org"

  channel:
    primary: "linkedin"
    secondary: ["twitter"]
    publish_date: "2026-02-24"
    campaign: "data-quality-series"

  outcome:
    audience_think: "Schema contracts are a practical, implementable solution"
    audience_feel: "Motivated to try this approach"
    audience_do: "Save the post and try schema validation on their next pipeline"
    target_audience: "Data engineers and platform engineers"

  metric:
    primary: "engagement_rate"
    target_value: ">3%"
    eval_timeline: "48h"
    secondary: "saves"

  generation:
    voice_profile_version: "1.0.0"
    mode: "Generator"
    templates_used: ["linkedin-post-template.md", "intent-capture-template.md"]
    voice_compliance_score: "11/12"
    tone_verification: "pass"
    vocabulary_scan: "clean"
    generation_time_minutes: 4

  results:
    primary_metric_actual: "4.2%"
    secondary_metric_actual: "47 saves"
    met_target: true
    audience_feedback: "Strong resonance with 'schema contracts > monitoring' framing"
    lessons: "Contrarian hook + specific metric in first line drove high saves"
```

## Aggregation Queries

Use these to extract patterns from the log:

### By channel performance
```
Filter entries by channel.primary → group by met_target → calculate success rate per channel
```

### By intent clarity
```
Filter entries where intent.core_message length < 15 words → compare met_target rate vs longer messages
```

### By voice compliance correlation
```
Group by voice_compliance_score → calculate average primary_metric_actual → find threshold score
```

### By generation efficiency
```
Average generation_time_minutes by channel → identify which channels take longest
```

## Maintenance

- **Add entries**: When Generator mode completes content with intent capture
- **Update status**: As content moves through captured → drafted → reviewed → published → measured
- **Extract patterns**: Monthly, extract patterns to memory file using INT-xxx, CNT-xxx, AUD-xxx categories
- **Archive**: Move entries older than 6 months to `content-intent-log-archive.md` to keep the active log scannable
