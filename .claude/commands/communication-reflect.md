---
name: communication-reflect
description: Extract patterns from content intent log and update brand voice memory
agent: agent-brand-voice
---

# Communication Reflection Workflow

Extract patterns from content performance data in the intent log and update memory patterns.

## When to Use

- **Monthly**: After publishing 5-10 pieces of content
- **Quarterly**: Before voice profile review
- **Campaign retrospective**: After completing a content campaign
- **Migration checkpoint**: After moving from v1.0 to v2.0 voice

## What It Does

1. Reads `.agent/system/content-intent-log.md`
2. Analyzes entries marked `status: measured`
3. Identifies patterns across:
   - Intent clarity → outcome correlation
   - Channel performance by audience
   - Voice compliance score → engagement correlation
   - Hook patterns that drive saves/shares
   - Timing triggers vs scheduled content
4. Updates `.agent/memory/agents/agent-brand-voice-memory.md` with new patterns
5. Flags voice drift signals
6. Recommends voice profile updates (if warranted)

## Usage

```bash
/communication-reflect

# Or with specific focus
/communication-reflect --channel=linkedin
/communication-reflect --audience=developers
/communication-reflect --campaign=data-quality-series
```

## Output

**Pattern Report**:
- New INT-XXX patterns (intent effectiveness)
- New CNT-XXX patterns (content performance)
- New AUD-XXX patterns (audience response)
- New EVL-XXX patterns (voice evolution signals)

**Recommendations**:
- High-performing content types to replicate
- Low-performing patterns to avoid
- Voice drift warnings (if detected)
- Voice profile updates (if significant shift detected)

## Example Pattern Extraction

From this content intent log data:
```yaml
- 5 LinkedIn posts published
- 3 with event-triggered intent (avg 4.1% engagement)
- 2 with scheduled intent (avg 1.8% engagement)
- All had voice compliance score ≥ 10/12
```

Pattern extracted:
```markdown
### INT-002: Event-Triggered Content Outperforms Scheduled

**Pattern**: Content triggered by real events (team member leaving,
customer question, bug discovery) performs 2.3x better than scheduled
content (4.1% vs 1.8% engagement).

**Sample Size**: 12 posts (8 triggered, 4 scheduled)

**Hypothesis**: Authenticity signal - audience senses when content is
reactive vs planned, values timeliness.

**Application**: When something happens that triggers insight, capture
and publish immediately. Don't wait for "content calendar day."

**Related**: Principle 1 (Journey Sharing) - real-time sharing feels
more authentic than scheduled posts.
```

## Integration with `/agent_reflect`

`/communication-reflect` focuses on **content performance patterns** within this project.

`/agent_reflect` synthesizes **cross-project patterns** including brand voice insights.

**Workflow**:
1. `/communication-reflect` monthly → updates local memory
2. `/agent_reflect` quarterly → generates testimony including brand voice patterns
3. Testimony feeds reflection pool → patterns propagate to other projects

---

**Agent**: agent-brand-voice (Analyst mode + Reviewer mode)
**Templates Used**:
- `content-intent-log.md` (data source)
- `agent-brand-voice-memory.md` (pattern output)
- `voice-evolution-workflow.md` (if drift detected)
