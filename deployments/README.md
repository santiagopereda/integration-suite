# Deployment Tracking System

Track where agents are deployed across projects.

## Purpose

This system enables:
- Visibility into agent usage across projects
- Version tracking per deployment
- Testimony collection coordination
- Impact analysis for agent updates

## Files

- `registry.json` - Machine-readable deployment registry
- `by-project/` - Human-readable per-project summaries

## Registry Schema

```json
{
  "registry_version": "1.0.0",
  "last_updated": "2026-01-25",
  "projects": [
    {
      "path": "/home/user/my-project",
      "name": "my-project",
      "deployed_at": "2026-01-25",
      "agents": [
        {
          "id": "agent-git-manager",
          "version": "1.0.0",
          "deployed_at": "2026-01-25"
        }
      ],
      "testimony_collected": false,
      "last_sync": "2026-01-25"
    }
  ],
  "deployment_history": [
    {
      "timestamp": "2026-01-25T10:30:00Z",
      "project": "/home/user/my-project",
      "agent": "agent-git-manager",
      "action": "deploy",
      "version": "1.0.0"
    }
  ],
  "statistics": {
    "total_projects": 1,
    "total_deployments": 1,
    "agents_deployed": {
      "agent-git-manager": 1
    },
    "most_deployed_agent": "agent-git-manager"
  }
}
```

## Per-Project Files

Each deployed project gets a summary file:

```markdown
# Project: my-project

**Path**: /home/user/my-project
**First Deployed**: 2026-01-25
**Last Sync**: 2026-01-25

## Deployed Agents

| Agent | Version | Deployed | Updated |
|-------|---------|----------|---------|
| agent-git-manager | 1.0.0 | 2026-01-25 | - |

## Testimony Status

- [ ] Testimony generated
- [ ] Synced to reflection pool

## Notes

[Any project-specific notes]
```

## Workflow

### On Deploy (/agent-deploy or agent-provisioner sync)

1. Update `registry.json` with new deployment
2. Create/update `by-project/{project-name}.md`
3. Add entry to deployment history
4. Update statistics

### On Testimony Collection (/agent_reflect)

1. Mark project as `testimony_collected: true`
2. Copy testimony to `reflection_pool/testimonies/`
3. Update last sync timestamp

### On Agent Update

1. Identify all projects using the agent
2. Flag for potential update
3. Track version differences

## Integration with agent-provisioner

The provisioner updates this registry automatically:

```bash
@agent-provisioner: sync /path/to/project
# → Updates deployments/registry.json
# → Creates/updates deployments/by-project/project-name.md
```

## Queries (Future: /agent-status)

The `/agent-status` command will query this registry:

```bash
/agent-status
# Shows all agents and their deployment counts

/agent-status agent-git-manager
# Shows all projects using agent-git-manager
```

---

**Version**: 1.0.0
**Last Updated**: 2026-01-25
