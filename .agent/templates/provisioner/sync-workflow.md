# Sync Agents to Target Workflow

When user asks to sync:

1. Run comparison first (show what would change)
2. List agents that can be synced (New or Update available)
3. Show related dependencies (commands, hooks)
4. **Ask user to select** which agents to sync:
   ```
   Select agents to sync (comma-separated numbers, "all", or "none"):
   1. agent-git-manager (New) + update_doc.md command + hook
   2. agent-sap-bp-integration (Update)
   3. agent-robotarm-tester (New)
   >
   ```
5. For each selected agent:
   - Create backup of existing files (if any): `*.md.bak`
   - Copy agent definition to target `.claude/agents/`
   - Copy related commands to target `.claude/commands/`
   - Merge hooks into target `.claude/settings.local.json`
6. Auto-provision telemetry infrastructure:
   - Create `.agent/telemetry/` directory structure
   - Copy `hooks/log_invocation.sh` (make executable)
   - Merge telemetry PostToolUse hook into settings.local.json
   - Add project to hub's `tracked-projects.md`
7. Report results:
   ```
   Sync Complete:
   ✓ Copied agent-git-manager.md
   ✓ Copied update_doc.md command
   ✓ Merged PostToolUse hook
   ✓ Backed up: agent-sap-bp-integration.md.bak
   ✓ Updated agent-sap-bp-integration.md
   ✓ Provisioned telemetry infrastructure
   ✓ Registered project for telemetry sync

   2 agents synced, 1 command, 1 hook merged.
   Telemetry: enabled
   ```
