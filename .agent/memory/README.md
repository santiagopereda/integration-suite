# Agent Memory System

Compound knowledge infrastructure for cross-project agent learning.

## Purpose

The memory system enables:
- **Cross-project learning**: Patterns extracted from project testimonies accumulate in agent memory
- **Session-start intelligence**: Agents read their memory at first invocation, starting informed
- **Compound knowledge**: Each project makes the next project better — not just accumulation, but refinement
- **Pattern recognition**: Recurring insights across projects get deduplicated and strengthened

## Architecture

### Three-Tier Memory

| Tier | Contents | Size | Access |
|------|----------|------|--------|
| **Hot** | Active session, current prompt | < 10K tokens | Always loaded |
| **Warm** | Agent memory files (compound patterns) | < 20K tokens | Read at session start |
| **Cold** | All testimonies, historical data | Unlimited | On-demand via `/agent_reflect` |

### Directory Structure

```
memory/
├── README.md                              # This file
├── hooks/
│   └── memory_hook.sh                     # Session tracking hook
├── session-summaries/
│   └── current-session.md                 # Active session log
├── agents/
│   ├── _shared-patterns.md                # Universal cross-agent patterns
│   ├── agent-integration-analyzer-memory.md
│   ├── agent-integration-assessor-memory.md
│   ├── agent-integration-scorer-memory.md
│   ├── agent-integration-reviewer-memory.md
│   ├── agent-integration-designer-memory.md
│   └── documentation-specialist-memory.md
```

### Data Flow

```
Project work → /agent_reflect → Testimony (cold)
                                    ↓
                              Pattern Extraction (Step 9)
                                    ↓
                              Agent Memory Files (warm)
                                    ↓
                              Next session: agent reads memory at start
```

---

## Compound Knowledge Pattern Format

Each pattern in a memory file represents a distilled, actionable insight extracted from a project testimony. Patterns are the unit of compound knowledge — testimony is the evidence, patterns are the operational wisdom.

### Pattern Template

```markdown
### [ID]: [Title]
- **Pattern**: [What was observed — 1-2 sentences]
- **Source**: [Project name] ([YYYY-MM-DD])
- **Action**: [What the agent should do about it — imperative]
- **Tags**: [platform], [category]
```

### Pattern ID Convention

3-letter category prefix + 3-digit sequence number.

| Agent | Prefix | Category |
|-------|--------|----------|
| analyzer | `EXT-` | Extraction |
| analyzer | `PRS-` | Parsing |
| analyzer | `INV-` | Inventory |
| assessor | `ASM-` | Assessment methodology |
| assessor | `DIM-` | Dimension-specific |
| assessor | `SRC-` | Data sources |
| scorer | `SCA-` | Scoring accuracy |
| scorer | `WGT-` | Weighting |
| scorer | `BNC-` | Benchmarking |
| reviewer | `SEC-` | Security |
| reviewer | `DRV-` | Design review |
| reviewer | `APT-` | Anti-patterns |
| designer | `ARC-` | Architecture |
| designer | `PAT-` | Patterns |
| designer | `IMP-` | Improvement roadmap |
| documentation | `DOC-` | Documentation |
| documentation | `TMY-` | Testimony |
| documentation | `DLV-` | Deliverables |
| _shared | `UNI-` | Universal |

### Memory File Structure

```markdown
# Agent Memory: [agent-id]

**Last Updated**: [YYYY-MM-DD]
**Patterns From**: [N] projects ([comma-separated project names])
**Total Patterns**: [count]

---

## [Category Name]

### [ID]: [Title]
- **Pattern**: [observation]
- **Source**: [project] ([date])
- **Action**: [what to do]
- **Tags**: [platform], [category]

---
```

### Deduplication Rules

1. **Same insight, new project**: Add project as additional source
   ```
   - **Source**: Talend-Reviewer (2026-02-20), UniQure (2026-01-23)
   ```
2. **Refined insight**: Update Pattern and Action text, keep all sources
3. **Genuinely new**: Append with next sequence number in category

---

## Pattern Extraction

Patterns are extracted automatically by `/agent_reflect` (v1.3.0+) after generating a testimony.

### Extraction Source Sections

| Testimony Section | What Gets Extracted |
|---|---|
| What Failed and Corrections Made | Initial Assumption + Lesson Learned → failure pattern |
| What Worked Well | Transferable Insight → success pattern |
| Lessons Learned | Technical/Process/Collaboration → domain patterns |
| Initial Assumptions Clarified | Assumption + Reality → correction pattern |
| Recommendations | Do/Avoid/Consider → best practice patterns |
| Metrics and Outcomes | Significant deltas → validation patterns |

### Extraction Routing

Patterns route to agent memory files by content keyword matching:

| Keywords | Target Agent |
|---|---|
| parsing, export, workspace, XML, artifact count, recycle bin | analyzer |
| assessment, dimension, methodology, walkthrough, data source | assessor |
| score, weighted, maturity, red flag, quick win, benchmark | scorer |
| security, OWASP, review finding, credential, encryption | reviewer |
| architecture, pattern, design, improvement, roadmap | designer |
| documentation, customer summary, deliverable, template | documentation-specialist |
| pipeline, agent, process, collaboration, verification | _shared |

Patterns can route to multiple agents when they span domains.

---

## Session Tracking

### Hook Script

`.agent/memory/hooks/memory_hook.sh` handles:
- Pre-invocation logging (session start)
- Post-invocation logging (outcome tracking)

### Session Summaries

Current session tracked in `session-summaries/current-session.md`:

```markdown
| Timestamp | Agent | Status | Notes |
|-----------|-------|--------|-------|
| 2026-01-25T10:30:00 | agent-optimizer | Started | - |
| 2026-01-25T10:35:00 | agent-optimizer | completed | - |
```

---

## Integration with Telemetry

Memory system works alongside OTEL telemetry:
- **Telemetry**: Quantitative (invocations, tokens, timing)
- **Memory**: Qualitative (patterns, insights, operational knowledge)

---

**Version**: 1.2.0
**Last Updated**: 2026-02-20
