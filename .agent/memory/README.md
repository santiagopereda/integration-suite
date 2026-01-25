# Agent Memory System

Persistent memory infrastructure for cross-session agent context.

## Purpose

The memory system enables:
- Session continuity across invocations
- Cross-project learning accumulation
- Context-efficient warm loading
- Pattern recognition over time

## Architecture

### Three-Tier Memory

| Tier | Contents | Size | Access |
|------|----------|------|--------|
| **Hot** | Active session, current prompt | < 10K tokens | Always loaded |
| **Warm** | Agent memory files, recent telemetry | < 20K tokens | On-demand |
| **Cold** | All testimonies, historical data | Unlimited | RAG-retrieved |

### Directory Structure

```
memory/
├── README.md                     # This file
├── hooks/
│   └── memory_hook.sh            # Memory tracking hook
├── session-summaries/
│   └── current-session.md        # Active session log
├── agents/
│   └── {agent-id}-memory.md      # Per-agent memory
```

## Agent Memory Format

Each agent can have a persistent memory file:

```markdown
# Agent Memory: {agent-id}

## Session Summary
- Last used: [timestamp]
- Key actions: [list]
- Outcomes: [list]

## Learnings
- [Insight 1]
- [Insight 2]

## Context for Next Session
- [State 1]
- [State 2]
```

## Usage

### Automatic Memory Loading

When agents are invoked, their memory is loaded via hooks:

```json
{
  "hooks": {
    "PreAgentInvoke": [
      {"command": "cat .agent/memory/{agent-id}-memory.md 2>/dev/null || true"}
    ]
  }
}
```

### Manual Memory Update

After significant sessions, update agent memory:

```bash
@documentation-specialist: Summarize this session's key learnings
and update .agent/memory/{agent-id}-memory.md
```

## Session Summaries

After extended work sessions, capture summaries:

```markdown
# Session Summary: 2026-01-25

## Agents Used
- agent-optimizer (3 invocations)
- agent-git-manager (2 invocations)

## Key Actions
- Optimized agent-cv-optimizer (45% reduction)
- Committed documentation updates

## Insights Discovered
- Template loading order matters for performance
- Quality gates prevented false optimization

## Follow-up Tasks
- [ ] Test optimized agent in target project
- [ ] Update reflection pool with new patterns
```

## Integration with Telemetry

Memory system works alongside OTEL telemetry:
- Telemetry: Quantitative (invocations, tokens, timing)
- Memory: Qualitative (insights, patterns, context)

## Memory Hooks

Hooks track agent invocations and maintain memory files.

### Hook Script

`.agent/memory/hooks/memory_hook.sh` handles:
- Pre-invocation logging (session start)
- Post-invocation logging (outcome tracking)
- Per-agent memory updates

### Usage

```bash
# Post-invocation (automatic via hook)
.agent/memory/hooks/memory_hook.sh post agent-optimizer completed

# Pre-invocation (automatic via hook)
.agent/memory/hooks/memory_hook.sh pre agent-git-manager
```

### Session Tracking

Current session tracked in `session-summaries/current-session.md`:

```markdown
| Timestamp | Agent | Status | Notes |
|-----------|-------|--------|-------|
| 2026-01-25T10:30:00 | agent-optimizer | Started | - |
| 2026-01-25T10:35:00 | agent-optimizer | completed | - |
```

### Per-Agent Memory

Each agent has persistent memory in `agents/{agent-id}-memory.md`:

```markdown
# Agent Memory: agent-optimizer

## Invocation History
| Timestamp | Session | Outcome |
|-----------|---------|---------|
| 2026-01-25T10:30:00 | sess-123 | completed |

## Learnings
(Accumulated insights)

## Context for Next Session
(State to restore)
```

---

**Version**: 1.1.0
**Last Updated**: 2026-01-25
