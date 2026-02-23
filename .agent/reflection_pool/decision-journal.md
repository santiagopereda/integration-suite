# Decision Journal

Live record of significant decision forks — moments when multiple viable approaches existed, one was chosen, and the reasoning is captured while the alternatives are still visible.

**How to use**: Search by label or project to retrieve the reasoning behind a past decision. Read before revisiting an architectural choice — the reversal condition tells you what would justify changing it.

**Written by**: Claude proactively during sessions (CLAUDE.md rule) + retrospectively via `agent_reflect` Step 11e
**Update cadence**: Real-time during work — not retrospective. Entries written at the decision point, not after.

**Last Updated**: 2026-02-21 | **Entries**: 3

---

## Entry Format

```markdown
## [Decision label — verb + noun, specific enough to find later]
**Context**: [1-2 sentences — what was being built and what created the fork]
**Options**: A) [option] / B) [option] / C) [option if applicable]
**Chosen**: [A/B/C] — [primary reason in one sentence]
**Reasoning**: [Why this over the alternatives — 2-3 sentences]
**Reversal condition**: [What evidence or constraint change would justify switching]
**Date**: YYYY-MM-DD | **Project**: [name] | **Source**: Live / Reconstructed
```

**Source field**:
- `Live` — written at the decision point during the session
- `Reconstructed` — extracted from testimony after the fact (reasoning may have more nuance than captured)

---

## What Qualifies

Log when:
- Alternatives were explicitly compared and one was rejected for a stated reason
- An architectural choice was made that could reasonably have gone another direction
- A scope decision was made (include vs. exclude, now vs. later, hub vs. per-project)
- A tool, pattern, or approach was chosen over a real alternative

Do not log:
- Single obvious implementations with no real alternatives
- Trivial naming or formatting choices
- Decisions that follow an established pattern without deviation

---

## Entries

## Differentiate reflection pool update cadences vs. apply uniform per-testimony updates
**Context**: Building 5 new reflection pool indexes. Question: should all indexes be updated per-testimony by agent_reflect, or should some be on longer cadences?
**Options**: A) Uniform per-testimony updates for all indexes / B) Differentiated cadences based on evidence requirements
**Chosen**: B — different content types require different evidence thresholds
**Reasoning**: Quotable insights qualify from a single project (one well-evidenced observation is enough). Domain-independent reasoning heuristics require cross-project validation — a pattern observed once is an observation, not a heuristic. Applying per-testimony cadence to heuristics would produce premature generalization. The evidence threshold is the right gating criterion, not a uniform rule.
**Reversal condition**: If thinking-patterns becomes consistently stale (falling behind by 5+ projects with no update), reconsider whether per-testimony updates with stricter qualification criteria would be better than manual synthesis.
**Date**: 2026-02-21 | **Project**: Agentic Hub | **Source**: Reconstructed

---

## thinking-patterns.md: auto-update via agent_reflect vs. manual synthesis
**Context**: Designing the update mechanism for thinking-patterns.md — the file of domain-independent reasoning heuristics.
**Options**: A) Auto-update via agent_reflect Step 11, with strict qualification criteria / B) Manual synthesis only, every 3-4 projects
**Chosen**: B — manual synthesis only
**Reasoning**: Auto-update creates mechanical pressure to add entries, even when cross-project evidence is insufficient. Manual synthesis forces deliberate evaluation of whether a candidate pattern has been validated across multiple domains. The file's value is its rigor; mechanizing the updates risks degrading it with single-project observations.
**Reversal condition**: If the file stagnates (no updates after 6+ projects) because manual synthesis never happens, add a periodic reminder trigger rather than switching to auto-update.
**Date**: 2026-02-21 | **Project**: Agentic Hub | **Source**: Reconstructed

---

## Decision journal location: hub reflection pool vs. per-project .agent/
**Context**: Designing where decision-journal.md should live — with each project (per-project .agent/) or centrally in the hub reflection pool.
**Options**: A) Per-project: each project maintains its own decision journal / B) Hub-centralized: single decision-journal.md in hub reflection pool
**Chosen**: B — hub centralized
**Reasoning**: The value of the decision journal is in the aggregate — patterns in reasoning only become visible across 20-30 entries from multiple projects. Per-project entries get buried in completed project directories and never synthesized. Centralization makes the aggregate always visible. The cost is slightly higher friction for projects not opened in the hub context, but the CLAUDE.md rule and agent_reflect Step 11e mitigate this.
**Reversal condition**: If entries are consistently failing to be written because the hub context isn't open during project work (friction too high), consider per-project journals with a sync step in agent_reflect.
**Date**: 2026-02-21 | **Project**: Agentic Hub | **Source**: Reconstructed

---

## Adding New Entries

When a session produces a qualifying decision, append it before this footer:

```markdown
## [Label]
**Context**: ...
**Options**: A) ... / B) ...
**Chosen**: [A] — ...
**Reasoning**: ...
**Reversal condition**: ...
**Date**: YYYY-MM-DD | **Project**: [name] | **Source**: Live
```

After adding, update the `Entries` count in the header.

---

**Sources**: Written live during sessions + extracted via `agent_reflect` Step 11e
**Not a retrospective document** — entries written at the fork, not after
