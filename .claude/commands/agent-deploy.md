# /agent-deploy Command

One-command agent deployment with validation and tracking.

## Invocation

```bash
/agent-deploy <agent-id> <target-path>           # Deploy specific agent
/agent-deploy <agent-id>,<agent-id> <target>     # Deploy multiple agents
/agent-deploy --all-utility <target-path>        # Deploy all utility agents
/agent-deploy --validate <target-path>           # Validate existing deployment
```

## Workflow

### Phase 1: PREPARE

1. **Verify agent exists** in hub
   ```bash
   # Check definition exists
   ls .claude/agents/{agent-id}.md
   ```

2. **Verify target path** is accessible
   ```bash
   # Check path exists and is writable
   test -d {target-path} && test -w {target-path}
   ```

3. **Load agent dependencies** from `agents-registry.json`
   - Commands to sync
   - Hooks to merge
   - Templates to copy

### Phase 2: BACKUP

4. **Create backups** if target has existing files
   ```bash
   # Backup existing agent
   cp {target}/.claude/agents/{agent-id}.md \
      {target}/.claude/agents/{agent-id}.md.bak.{timestamp}

   # Backup settings if hooks will change
   cp {target}/.claude/settings.local.json \
      {target}/.claude/settings.local.json.bak.{timestamp}
   ```

### Phase 3: DEPLOY

5. **Create target directories** if needed
   ```bash
   mkdir -p {target}/.claude/agents
   mkdir -p {target}/.claude/commands
   ```

6. **Copy agent definition**
   ```bash
   cp .claude/agents/{agent-id}.md {target}/.claude/agents/
   ```

7. **Copy dependencies**
   - Commands: `.claude/commands/*.md`
   - Templates: `.agent/templates/{agent}/` (if applicable)

8. **Merge hooks** into `settings.local.json`
   - Read existing or create new
   - Add required hook matchers
   - Preserve existing hooks
   - Write merged file

### Phase 4: VALIDATE

9. **Run /agent-test** for deployed agent
   ```bash
   # In target directory, verify:
   # - Definition file exists and is valid YAML frontmatter
   # - All referenced files exist
   # - Constraints are present
   ```

10. **Verify hooks** are correctly merged
    ```bash
    # Check settings.local.json contains expected matchers
    jq '.hooks[] | select(.matcher | contains("{agent-id}"))' \
       {target}/.claude/settings.local.json
    ```

### Phase 5: REGISTER

11. **Update hub deployment registry**
    ```bash
    # deployments/registry.json
    # Add or update project entry
    # Add agent to project's agents array
    # Log to deployment_history
    # Update statistics
    ```

12. **Create/update per-project file**
    ```bash
    # deployments/by-project/{project-name}.md
    ```

13. **Update target CLAUDE.md** (optional, with confirmation)
    - Add agent to available agents section
    - Add invoke examples

## Output Format

### Progress Display

```
## Deploying: agent-git-manager → /home/user/my-project

**Agent**: agent-git-manager (v1.0.0)
**Target**: /home/user/my-project

### Steps:

[1/6] ✓ Verified agent exists in hub
[2/6] ✓ Verified target path accessible
[3/6] ✓ Created backup of existing agent
[4/6] ✓ Copied agent definition
[5/6] ✓ Merged hooks into settings.local.json
[6/6] ✓ Validation passed

### Deployment Summary

| Item | Status |
|------|--------|
| Agent definition | ✓ Deployed |
| Commands | ✓ 1 synced (update_doc.md) |
| Hooks | ✓ Merged |
| Validation | ✓ Passed |
| Registry | ✓ Updated |

**Next Steps**:
- Test agent: `@agent-git-manager: status`
- View deployment: `cat deployments/by-project/my-project.md`
```

### Error Display

```
## Deployment Failed: agent-git-manager → /home/user/my-project

**Error**: Target path not writable

**Details**:
- Path: /home/user/my-project
- Issue: Permission denied

**Recovery**:
1. Check directory permissions: `ls -la /home/user/my-project`
2. Fix permissions: `chmod u+w /home/user/my-project`
3. Retry: `/agent-deploy agent-git-manager /home/user/my-project`
```

## Agent Groups

Pre-defined groups for common deployments:

| Group | Agents | Use Case |
|-------|--------|----------|
| `--all-utility` | agent-git-manager | Every project |
| `--all-support` | research-assistant, documentation-specialist | Most projects |
| `--all-default` | utility + support | Standard deployment |
| `--all-devops` | agent-ansible-automation, agent-git-manager | DevOps projects |
| `--all-sap` | agent-sap-businesspartner-integration | SAP projects |

## Examples

### Deploy Single Agent

```bash
/agent-deploy agent-git-manager /home/user/my-project
```

### Deploy Multiple Agents

```bash
/agent-deploy agent-git-manager,agent-cv-optimizer /home/user/cv-project
```

### Deploy All Utility Agents

```bash
/agent-deploy --all-utility /home/user/new-project
```

### Validate Existing Deployment

```bash
/agent-deploy --validate /home/user/my-project
```

## Comparison with agent-provisioner

| Feature | /agent-deploy | @agent-provisioner |
|---------|---------------|-------------------|
| Interactive | No (one-command) | Yes (guided) |
| Validation | Automatic | Manual |
| Registry update | Automatic | Automatic |
| Multiple agents | Comma-separated | Interactive selection |
| Target CLAUDE.md | Optional update | No update |
| Best for | CI/CD, scripts | Manual deployment |

## Integration

### With agent-hub-orchestrator

The orchestrator can use /agent-deploy for automated workflows:

```
@agent-hub-orchestrator: Set up new project with git workflow

Orchestrator workflow:
1. /project_init → Create structure
2. /agent-deploy agent-git-manager → Deploy agent
3. /agent-test → Validate
4. Report results
```

### With CI/CD

```yaml
# .github/workflows/deploy-agents.yml
- name: Deploy agents
  run: |
    cd /path/to/agentic-hub
    claude /agent-deploy agent-git-manager ${{ github.workspace }}
```

## Rollback

If deployment fails or causes issues:

```bash
# Restore from backup
cp {target}/.claude/agents/{agent-id}.md.bak.{timestamp} \
   {target}/.claude/agents/{agent-id}.md

# Or remove entirely
rm {target}/.claude/agents/{agent-id}.md

# Update registry to reflect rollback
# (Manual edit of deployments/registry.json)
```

---

**Version**: 1.0.0
**Last Updated**: 2026-01-25
