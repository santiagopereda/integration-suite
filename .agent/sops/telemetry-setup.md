# SOP: Telemetry Setup for Downstream Projects

## Overview

This SOP documents how to set up agent telemetry collection in projects provisioned from the Agentic hub.

---

## When to Use This SOP

- Setting up a new project that will use agents from the hub
- Enabling telemetry in an existing project
- Troubleshooting telemetry that isn't capturing data
- Understanding the telemetry infrastructure

---

## Prerequisites

- Project has been provisioned with agents via `agent-provisioner`
- `.claude/` directory exists in the project
- Bash shell available (for hook script)
- Write access to project's `.agent/` directory

---

## Definitions

- **Telemetry**: Usage data collected when agents are invoked
- **Invocation Log**: JSONL file storing raw telemetry events
- **Session**: Group of tool uses within a 5-minute window
- **Hub Sync**: Process of sending telemetry back to Agentic hub

---

## Step-by-Step Procedure

### Step 1: Verify Telemetry Infrastructure

The telemetry infrastructure should be auto-provisioned when agents are synced.

**Sub-steps:**
1. Check for telemetry directory: `ls -la .agent/telemetry/`
2. Verify hook script exists: `ls -la .agent/telemetry/hooks/log_invocation.sh`
3. Confirm script is executable: `file .agent/telemetry/hooks/log_invocation.sh`

**Validation**:
- [ ] `.agent/telemetry/` directory exists
- [ ] `hooks/log_invocation.sh` exists and is executable

**Common Mistakes**:
- ❌ Missing `.agent/` directory: Project not initialized - run `/project_init`
- ❌ Script not executable: Run `chmod +x .agent/telemetry/hooks/log_invocation.sh`

---

### Step 2: Configure Hooks in settings.local.json

Add telemetry hooks to capture agent tool usage.

**Sub-steps:**
1. Open or create `.claude/settings.local.json`
2. Add the PostToolUse hook configuration
3. Save the file

**Configuration:**
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write|NotebookEdit",
        "hooks": [{
          "type": "command",
          "command": ".agent/telemetry/hooks/log_invocation.sh"
        }]
      }
    ]
  }
}
```

**Validation**:
- [ ] `settings.local.json` exists in `.claude/`
- [ ] Hook configuration is valid JSON
- [ ] Matcher covers Edit, Write, and NotebookEdit

**Common Mistakes**:
- ❌ Invalid JSON: Use a JSON validator before saving
- ❌ Wrong matcher: Ensure pipe-separated list `Edit|Write|NotebookEdit`
- ❌ Absolute path in command: Use relative path from project root

**Files Involved**:
- `.claude/settings.local.json` - Hook configuration

---

### Step 3: Test Telemetry Capture

Verify that telemetry is being captured correctly.

**Sub-steps:**
1. Invoke an agent that modifies files (e.g., `@agent-git-manager: status`)
2. Check for telemetry log: `cat .agent/telemetry/invocation-log.jsonl`
3. Verify JSON format is valid

**Validation**:
- [ ] `invocation-log.jsonl` contains entries
- [ ] Each line is valid JSON
- [ ] Timestamps are recent

**Common Mistakes**:
- ❌ Empty log file: Hooks may not be triggering - check settings.local.json
- ❌ Permission denied: Check script executable permissions

---

### Step 4: Register for Hub Sync

Ensure project is in the hub's tracked projects list.

**Sub-steps:**
1. From the Agentic hub, run: `@agent-provisioner: register /path/to/project`
2. Verify entry in `tracked-projects.md`
3. Test sync with: `@agent-provisioner: telemetry-sync /path/to/project`

**Validation**:
- [ ] Project appears in hub's `tracked-projects.md`
- [ ] Sync completes without errors
- [ ] Hub's `.agent/telemetry/raw/{project}/` contains data

---

## Troubleshooting

### Issue: Hook Not Triggering

**Symptom**: No entries in `invocation-log.jsonl` after agent use

**Cause**: Hook configuration missing or invalid

**Resolution**:
1. Verify `.claude/settings.local.json` exists
2. Validate JSON syntax
3. Restart Claude Code session
4. Test with manual file edit

---

### Issue: Permission Denied on Script

**Symptom**: Error message about permission when hook runs

**Cause**: Script not executable

**Resolution**:
1. Run `chmod +x .agent/telemetry/hooks/log_invocation.sh`
2. Verify with `ls -la .agent/telemetry/hooks/`

---

### Issue: Malformed JSON in Log

**Symptom**: Log file contains invalid JSON lines

**Cause**: Script interrupted or encoding issues

**Resolution**:
1. Backup current log: `cp invocation-log.jsonl invocation-log.jsonl.bak`
2. Remove malformed lines: `jq -c '.' invocation-log.jsonl > clean.jsonl && mv clean.jsonl invocation-log.jsonl`
3. Test with new entries

---

## Validation Checklist

- [ ] Telemetry directory structure exists (`.agent/telemetry/`)
- [ ] Hook script is executable
- [ ] `settings.local.json` has correct hook configuration
- [ ] Test invocation creates log entry
- [ ] Log entries are valid JSON
- [ ] Project registered in hub's tracked-projects.md
- [ ] Sync to hub works without errors

---

## Common Mistakes to Avoid

### ❌ Mistake 1: Using Absolute Paths

**What NOT to do**: Using `/home/user/project/.agent/...` in hook command

**Why it's wrong**: Breaks portability when project moves or is cloned

**How to avoid it**:
- Always use relative paths from project root
- Use `.agent/telemetry/hooks/log_invocation.sh` not full path

---

### ❌ Mistake 2: Forgetting to Re-provision After Hub Updates

**What NOT to do**: Assuming old projects automatically get new telemetry features

**Why it's wrong**: Telemetry infrastructure must be explicitly synced

**How to avoid it**:
- Run `@agent-provisioner: sync /path/to/project` after hub updates
- Check hook script version matches hub version

---

## Tips & Best Practices

- 💡 Test telemetry after any agent-provisioner sync
- 💡 Check log file size periodically - rotate if >10MB
- 💡 Use `jq` for querying JSONL files: `jq -s '.' invocation-log.jsonl`
- 💡 Run telemetry-sync weekly to keep hub updated

---

## Estimated Time

- **First-time setup**: 10-15 minutes
- **Subsequent verification**: 2-3 minutes
- **Troubleshooting**: 15-30 minutes

---

## Related SOPs

- [Agent Provisioning](./agent-provisioning.md) - How to sync agents
- [Project Initialization](./project-init.md) - Setting up new projects

---

## References

### Documentation
- [Telemetry README](../telemetry/README.md) - System overview
- [Agent Provisioner](../../.claude/agents/agent-provisioner.md) - Sync capabilities

---

## Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-24 | agent-optimizer | Initial creation |

---

## Approval & Sign-Off

- **Written By**: Claude Code (agent-optimizer implementation)
- **Reviewed By**: Pending
- **Approved By**: Pending
- **Date Approved**: Pending
- **Next Review Date**: 2026-04-24

---

## Feedback & Updates

If you discover:
- ❌ **Errors in this SOP**: Report to Agent Architecture Team
- 🔧 **Improvements needed**: Update and log in injection-history.md
- 🎓 **New lessons learned**: Add to common-mistakes section
