# GLInet_Network Deployment

**Project**: GLInet_Network
**Path**: /home/askeox/Documents/GLInet_Network
**Type**: infrastructure
**Created**: 2026-01-31

## Deployed Agents

| Agent | Version | Deployed |
|-------|---------|----------|
| agent-git-manager | 1.0.0 | 2026-01-31 |

## Deployed Commands

| Command | Description |
|---------|-------------|
| update_doc | Documentation update workflow |

## Hooks Configured

| Event | Matcher | Purpose |
|-------|---------|---------|
| PostToolUse | Edit\|Write\|NotebookEdit | Trigger git commit suggestions |

## Usage

Invoke the agent with:
```
@agent-git-manager: [your request]
```

Examples:
- `@agent-git-manager: status` - Check repository status
- `@agent-git-manager: commit` - Commit workflow with security scan
- `@agent-git-manager: push` - Push with confirmation

## Deployment History

| Date | Action | Details |
|------|--------|---------|
| 2026-01-31 | Initial deploy | agent-git-manager via /agent-deploy |
