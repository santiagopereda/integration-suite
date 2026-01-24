# Sync Telemetry Back to Hub Workflow

When user asks to sync telemetry or runs `telemetry-sync`:

1. Read `tracked-projects.md` from hub for registered projects
2. For each tracked project:
   - Check if `.agent/telemetry/invocation-log.jsonl` exists
   - Read last sync marker from `.agent/telemetry/.last-sync`
   - Calculate new events since last sync
3. For each project with new events:
   - Copy new JSONL lines to `hub/.agent/telemetry/raw/{project}/{date}.jsonl`
   - Update project's sync marker
   - Log event count
4. Aggregate statistics:
   - Parse all raw JSONL files by agent_id
   - Calculate: total invocations, avg tokens, success rate
   - Write to `.agent/telemetry/aggregated/{agent-id}.json`
5. Generate hub summary:
   - Daily metrics in `hub-metrics-{YYYY-MM-DD}.json`
   - Cross-project patterns in `cross-project-analysis.md`
6. Report results:
   ```
   Telemetry Sync Complete:
   | Project | Events | Tokens | Last Activity |
   |---------|--------|--------|---------------|
   | cv-generator-agent | 47 new | 287K | 2026-01-24 |
   | mirobot | 12 new | 89K | 2026-01-23 |

   Total: 59 events collected
   Aggregated stats updated for: agent-git-manager, agent-cv-optimizer
   ```
