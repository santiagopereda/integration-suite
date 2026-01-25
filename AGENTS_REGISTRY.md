# Agents Registry

> **Note**: This file has been superseded by `agents-registry.json` for machine-readable data.
> See `CLAUDE.md` for quick reference tables.

## Quick Reference

For a complete list of agents and their capabilities, use:

```bash
# View full registry
cat agents-registry.json | jq '.agents[] | {id, version, status, category}'

# Or use the dashboard command
/agent-status
```

## Agent Locations

| Component | Location |
|-----------|----------|
| Agent definitions | `.claude/agents/{agent-id}.md` |
| Agent metadata | `agents-registry.json` |
| Agent documentation | `agents/{agent-id}/README.md` |
| Test cases | `agents/{agent-id}/test-cases.md` |
| Templates | `.agent/templates/{agent}/` |

## Available Agents (Summary)

| Agent | Domain | Status |
|-------|--------|--------|
| agent-sap-businesspartner-integration | SAP/ERP | Production |
| agent-ansible-automation | DevOps | Production |
| agent-robotarm-tester | Robotics | Production |
| agent-git-manager | Utility | Production |
| agent-cv-optimizer | Career | Production |
| agent-provisioner | Hub (Meta) | Production |
| agent-project-init | Hub (Meta) | Production |
| agent-optimizer | Hub (Meta) | Production |
| agent-architect | Hub (Meta) | Production |
| research-assistant | Support | Production |
| documentation-specialist | Support | Production |

## Using Agents

```bash
@{agent-id}: [Your request]
```

## Creating New Agents

1. Design with `@agent-architect`
2. Create `.claude/agents/{agent-id}.md`
3. Add to `agents-registry.json`
4. Create test cases in `agents/{agent-id}/test-cases.md`
5. Validate with `/agent-test {agent-id}`

See `AGENTS_REPOSITORY_GUIDE.md` for full workflow.

## Data Sources

- **agents-registry.json** - Canonical source for agent metadata
- **CLAUDE.md** - Hub configuration and quick reference
- **deployments/registry.json** - Deployment tracking

---

**Registry Version**: 2.0.0 (redirects to agents-registry.json)
**Last Updated**: 2026-01-25
**Status**: Deprecated - Use agents-registry.json
