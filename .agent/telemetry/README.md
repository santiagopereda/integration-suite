# Agent Telemetry System

This directory implements telemetry collection for Claude Code agents following Anthropic best practices.

## Architecture Overview

The telemetry system uses a **hybrid approach**:

1. **Claude Code Native OTel** - Captures rich metrics (tokens, costs, lines, sessions)
2. **Lightweight Hook** - Tracks agent ID attribution only

```
┌─────────────────────────────────────────────────────────────────┐
│ Claude Code (with CLAUDE_CODE_ENABLE_TELEMETRY=1)               │
│   Built-in OpenTelemetry instrumentation                        │
│   Exports: sessions, tokens, lines, costs, tools               │
└─────────────────────────────────────────────────────────────────┘
           │                              │
           │ OTLP                         │ PostToolUse hook
           ▼                              ▼
┌─────────────────────────┐    ┌─────────────────────────┐
│ OTel Collector          │    │ log_invocation.sh       │
│ otel/docker-compose.yml │    │ (lightweight)           │
│                         │    │                         │
│ Rich metrics:           │    │ Agent attribution:      │
│ - Tokens (actual)       │    │ - Session ID            │
│ - Costs (actual)        │    │ - Agent ID              │
│ - Lines modified        │    │ - Tool sequence         │
│ - Session counts        │    │                         │
└─────────────────────────┘    └─────────────────────────┘
           │                              │
           ▼                              ▼
    otel/data/telemetry.jsonl    session-activity.log
```

## Directory Structure

```
telemetry/
├── README.md                      ← This file
├── hooks/
│   └── log_invocation.sh          ← Lightweight agent attribution hook
├── otel/                          ← OpenTelemetry infrastructure
│   ├── docker-compose.yml         ← OTel collector deployment
│   ├── otel-config.yaml           ← Collector configuration
│   ├── query-telemetry.sh         ← Query utility
│   ├── README.md                  ← OTel setup guide
│   └── data/                      ← Telemetry data exports
│       └── telemetry.jsonl        ← Rich metrics from Claude Code
├── session-activity.log           ← Agent attribution log
├── .session                       ← Current session state
└── .current-agent                 ← Agent marker file
```

## Quick Start

### 1. Start OTel Collector

```bash
cd .agent/telemetry/otel
docker compose up -d
```

### 2. Enable Claude Code Telemetry

Add to `~/.bashrc` or `~/.zshrc`:

```bash
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export OTEL_EXPORTER_OTLP_ENDPOINT="http://localhost:4317"
export OTEL_SERVICE_NAME="claude-code-agentic"
```

Or source the project's `.envrc`.

### 3. The Hook is Already Active

The `log_invocation.sh` hook is configured in `.claude/settings.local.json`:

```json
{
  "hooks": {
    "PostToolUse": [{
      "matcher": "Edit|Write|NotebookEdit",
      "hooks": [{
        "type": "command",
        "command": ".agent/telemetry/hooks/log_invocation.sh"
      }]
    }]
  }
}
```

## Metrics Available

### From OTel (Rich Metrics)

| Metric | Description |
|--------|-------------|
| `claude_code.session.count` | Session count |
| `claude_code.token.usage` | Actual token consumption |
| `claude_code.lines_of_code.count` | Lines modified |
| `claude_code.cost.usage` | Cost in USD |
| `claude_code.tool.count` | Tool invocations |

### From Hook (Agent Attribution)

| Field | Description |
|-------|-------------|
| `timestamp` | When tool was used |
| `session_id` | Session identifier |
| `agent_id` | Which agent (if registered) |
| `tool_seq` | Tool sequence in session |

## Agent Registration

For agent ID tracking, agents should register themselves on first tool use:

```bash
echo "agent-git-manager|1.0.0" > .agent/telemetry/.current-agent
```

The hook reads this marker and includes the agent ID in logs.

## Querying Metrics

### OTel Metrics

```bash
# Today's metrics
.agent/telemetry/otel/query-telemetry.sh --today

# Last 7 days
.agent/telemetry/otel/query-telemetry.sh --week

# Summary
.agent/telemetry/otel/query-telemetry.sh --all
```

### Agent Attribution

```bash
# Count by agent
cut -d'|' -f3 session-activity.log | sort | uniq -c | sort -rn

# Sessions today
grep "$(date +%Y-%m-%d)" session-activity.log | cut -d'|' -f2 | sort -u | wc -l
```

## Data Retention

| Data | Retention | Managed By |
|------|-----------|------------|
| OTel telemetry.jsonl | 90 days | OTel collector rotation |
| session-activity.log | ~5000 lines | Hook rotation (1% probability) |
| .session | Current session | Cleared on timeout |
| .current-agent | Current session | Cleared on session end |

## Privacy & Security

### What IS Logged (OTel)

- Token counts (actual)
- Costs (actual)
- Lines modified (actual)
- Session counts
- Tool invocation counts

### What IS Logged (Hook)

- Session IDs
- Agent IDs (if registered)
- Tool sequence numbers
- Timestamps

### What is NOT Logged

- File contents or paths
- User prompts or responses
- Credentials or secrets
- PII or sensitive data

## Integration with Other Systems

### agent-optimizer

Uses telemetry to make data-driven optimization decisions:

- **High token usage** → Apply template externalization
- **High invocation count** → Prioritize optimization
- **Agent attribution** → Track per-agent ROI

### agent-provisioner

When syncing agents to projects:

- Provisions `otel/` directory (optional)
- Configures telemetry hook
- Enables agent registration pattern

### /agent_reflect

The testimony command includes quantitative metrics from telemetry.

## Troubleshooting

### No OTel data

1. Is collector running? `docker compose ps`
2. Is telemetry enabled? `echo $CLAUDE_CODE_ENABLE_TELEMETRY`
3. Check collector logs: `docker compose logs otel-collector`

### Agent ID always "unknown"

Agents must register themselves:
```bash
echo "your-agent-id|version" > .agent/telemetry/.current-agent
```

### Hook not firing

Check `.claude/settings.local.json` has the PostToolUse hook configured.

---

**Version**: 2.0.0 (OTel-based)
**Created**: 2026-01-24
**Updated**: 2026-01-24
**Approach**: Anthropic-aligned OpenTelemetry
