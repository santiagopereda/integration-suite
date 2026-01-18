# agent-provisioner

**Version**: 1.0.0
**Status**: Production
**ID**: `agent-provisioner`

## Purpose

Expert agent provisioning specialist for syncing agents, commands, and hooks from the Agentic hub to other local projects. Enables safe deployment and updates with version awareness, interactive selection, and proper backup procedures.

## When to Use

Invoke this agent when you need to:

- **List available agents**: See all agents in this hub with versions and descriptions
- **Compare versions**: Check what's different between hub and a target project
- **Provision new projects**: Set up agents in projects that don't have them
- **Update existing agents**: Sync newer versions to projects with older agents
- **Sync configurations**: Deploy related commands and hooks alongside agents

## How to Invoke

```bash
# List all available agents
@agent-provisioner: list

# Compare with a target project
@agent-provisioner: compare /path/to/project

# Sync agents to a target project
@agent-provisioner: sync /path/to/project
```

## Commands

### List

Shows all available agents from the hub.

```bash
@agent-provisioner: list
```

**Output**:
```
Available Agents from Hub:
| Agent | Modified | Description |
|-------|----------|-------------|
| agent-git-manager | 2026-01-18 | Git repository management with security scanning |
| agent-sap-bp-integration | 2026-01-18 | SAP BusinessPartner OData API documentation |
| agent-ansible-automation | 2026-01-18 | DevOps automation with Ansible |
| agent-robotarm-tester | 2026-01-18 | Robot arm validation and testing |
| agent-provisioner | 2026-01-18 | Agent sync and provisioning |
```

### Compare

Shows version differences between hub and target project without making changes.

```bash
@agent-provisioner: compare /home/user/my-project
```

**Output**:
```
Comparison: Hub vs /home/user/my-project
| Agent | Hub Date | Target Date | Status |
|-------|----------|-------------|--------|
| agent-git-manager | 2026-01-18 | (none) | New |
| agent-sap-bp | 2026-01-18 | 2025-11-20 | Update available |
| agent-ansible | 2026-01-18 | 2026-01-18 | Up to date |
```

### Sync

Full provisioning workflow with interactive selection.

```bash
@agent-provisioner: sync /home/user/my-project
```

**Workflow**:
1. Compares hub with target
2. Shows what can be synced
3. Lists related dependencies (commands, hooks)
4. Asks user to select agents
5. Creates backups of existing files
6. Copies selected agents and dependencies
7. Merges hooks into target configuration
8. Reports results

## What Gets Synced

### Per Agent

**Minimal deployment** - Only the agent definition:
- `.claude/agents/[agent-id].md`

### Related Dependencies

Some agents have related commands and hooks:

| Agent | Commands | Hooks |
|-------|----------|-------|
| agent-git-manager | update_doc.md | PostToolUse: Edit\|Write\|NotebookEdit |
| agent-sap-bp-integration | - | - |
| agent-ansible-automation | - | - |
| agent-robotarm-tester | - | - |

When you select an agent with dependencies, those are included automatically.

## Safety Features

### Backups

Before overwriting any existing file, a backup is created:
- `agent-file.md` → `agent-file.md.bak`

### Interactive Selection

You always choose which agents to sync. The agent never dumps all agents without asking.

```
Select agents to sync (comma-separated numbers, "all", or "none"):
1. agent-git-manager (New) + command + hook
2. agent-sap-bp-integration (Update)
3. agent-robotarm-tester (New)
> 1,2
```

### Hook Merging

Hooks are merged into the target's `settings.local.json`, not replaced:
- Existing permissions (allow, deny, ask) are preserved
- New hooks are added alongside existing hooks
- Conflicting hooks prompt for user decision

## Example Workflows

### Setting Up a New Project

```bash
# Create project
mkdir /home/user/new-project
cd /home/user/new-project
git init

# Provision agents
@agent-provisioner: sync /home/user/new-project
# Select the agents you need
# Agent creates .claude/ structure and copies files
```

### Updating an Existing Project

```bash
@agent-provisioner: compare /home/user/existing-project
# See which agents have updates

@agent-provisioner: sync /home/user/existing-project
# Select only the agents you want to update
```

### Check-Only (No Changes)

```bash
@agent-provisioner: compare /home/user/project
# Read-only operation - just shows differences
```

## Error Handling

### Target Path Not Found

```
Error: Target path does not exist: /path/to/project
Please verify the path and try again.
```

### No .claude Directory

```
Target has no .claude/ directory. Would you like me to create it?
This will set up:
- /path/to/project/.claude/agents/
- /path/to/project/.claude/commands/
- /path/to/project/.claude/settings.local.json
```

### Permission Issues

```
Error: Cannot write to target: /path/to/project/.claude/
Please check permissions and try again.
```

## Limitations

- **Local paths only**: Does not support remote repositories or URLs
- **One-way sync**: Hub → Target only, not bidirectional
- **File-based versioning**: Uses modification dates, not semantic versions
- **Manual hook review**: Complex hook conflicts require user decision

## Files

| File | Purpose |
|------|---------|
| `.claude/agents/agent-provisioner.md` | Agent definition |
| `agents/agent-provisioner/README.md` | This documentation |
| `agents/agent-provisioner/test-cases.md` | Validation test cases |

## Related Documentation

- [AGENTS_REGISTRY.md](../../AGENTS_REGISTRY.md) - Complete agent registry
- [CLAUDE.md](../../CLAUDE.md) - Project configuration
- [agent-git-manager](../agent-git-manager/README.md) - Git workflow agent
