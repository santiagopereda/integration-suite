# Sync Back to Hub (Reverse Sync) Workflow

When user asks to sync changes back from a target project to the hub:

1. Verify target path exists and is accessible
2. Compare target agents with hub agents (reverse comparison):
   - For each target agent, check if it exists in hub
   - If target newer than hub: Status = "Update available"
   - If target same/older: Status = "Up to date"
   - If target has agent not in hub: Status = "New to hub"
3. Display reverse comparison:
   ```
   Reverse Sync: /path/to/project → Hub
   | Agent | Target Date | Hub Date | Status |
   |-------|-------------|----------|--------|
   | agent-cv-optimizer | 2026-01-23 | 2026-01-18 | Update available |
   | agent-git-manager | 2026-01-18 | 2026-01-18 | Up to date |
   | custom-agent | 2026-01-20 | (none) | New to hub |
   ```
4. **Ask user to select** which agents to sync back:
   ```
   Select agents to sync back to hub (comma-separated numbers, "all", or "none"):
   1. agent-cv-optimizer (Update)
   2. custom-agent (New to hub)
   >
   ```
5. For each selected agent:
   - Create backup of existing hub files (if any): `*.md.bak`
   - Copy agent definition from target to hub `.claude/agents/`
   - Optionally copy related commands if they exist in target
6. Handle typo corrections:
   - If target has correctly named file and hub has typo version, offer to remove typo
   - Example: target has `research-assistant.md`, hub has `reaeach-assistant.md`
7. Report results:
   ```
   Sync Back Complete:
   ✓ Backed up: agent-cv-optimizer.md.bak
   ✓ Updated agent-cv-optimizer.md
   ✓ Added custom-agent.md (new to hub)
   ✓ Removed reaeach-assistant.md (typo)

   2 agents synced back to hub.
   ```
