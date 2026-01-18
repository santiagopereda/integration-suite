# agent-provisioner Test Cases

This document contains validation test cases for the agent-provisioner agent. Each test case verifies specific capabilities and constraints.

## Test Case 1: List Available Agents

**Objective**: Verify the agent can list all available agents from the hub.

**Input**:
```
@agent-provisioner: list
```

**Expected Behavior**:
1. Agent reads all `.claude/agents/*.md` files from hub
2. Extracts agent names, descriptions, modification dates
3. Displays formatted table with all agents
4. Does NOT include agent-provisioner itself in recommendations for sync

**Expected Output Contains**:
- Table with columns: Agent, Modified, Description
- At least 4 agents listed (git-manager, sap-bp, ansible, robotarm)
- Modification dates in readable format

**Validation Criteria**:
- [ ] All hub agents are listed
- [ ] Modification dates are accurate
- [ ] Descriptions are extracted correctly
- [ ] Output is clearly formatted

---

## Test Case 2: Compare with Empty Target

**Objective**: Verify comparison with a project that has no agents.

**Setup**:
```bash
mkdir /tmp/test-empty-project
```

**Input**:
```
@agent-provisioner: compare /tmp/test-empty-project
```

**Expected Behavior**:
1. Agent verifies target path exists
2. Detects no `.claude/agents/` directory
3. All hub agents show status "New"

**Expected Output Contains**:
- All agents with status "New"
- No "Update available" or "Up to date" statuses
- Note about missing .claude directory

**Validation Criteria**:
- [ ] Target path is validated
- [ ] All agents show as "New"
- [ ] No errors thrown for missing directory

---

## Test Case 3: Compare with Existing Agents

**Objective**: Verify comparison detects version differences correctly.

**Setup**:
```bash
mkdir -p /tmp/test-existing-project/.claude/agents
# Copy an agent and make it older
cp /path/to/hub/.claude/agents/agent-git-manager.md /tmp/test-existing-project/.claude/agents/
touch -d "2025-01-01" /tmp/test-existing-project/.claude/agents/agent-git-manager.md
```

**Input**:
```
@agent-provisioner: compare /tmp/test-existing-project
```

**Expected Behavior**:
1. Agent compares modification dates
2. Older target file shows "Update available"
3. Missing files show "New"

**Expected Output Contains**:
- agent-git-manager with status "Update available"
- Other agents with status "New"
- Both hub and target dates shown

**Validation Criteria**:
- [ ] Version comparison is accurate
- [ ] "Update available" correctly detected
- [ ] Dates are compared correctly

---

## Test Case 4: Compare with Up-to-Date Agents

**Objective**: Verify "Up to date" status when target is current.

**Setup**:
```bash
mkdir -p /tmp/test-current-project/.claude/agents
cp /path/to/hub/.claude/agents/agent-git-manager.md /tmp/test-current-project/.claude/agents/
# File has same or newer date
```

**Input**:
```
@agent-provisioner: compare /tmp/test-current-project
```

**Expected Behavior**:
1. Agent compares modification dates
2. Same or newer target file shows "Up to date"

**Expected Output Contains**:
- agent-git-manager with status "Up to date"
- Agent is excluded from sync candidates

**Validation Criteria**:
- [ ] "Up to date" correctly detected
- [ ] Agent not offered for sync

---

## Test Case 5: Sync with Interactive Selection

**Objective**: Verify sync workflow asks for user selection.

**Setup**:
```bash
mkdir -p /tmp/test-sync-project
```

**Input**:
```
@agent-provisioner: sync /tmp/test-sync-project
```

**Expected Behavior**:
1. Shows comparison results first
2. Lists agents available to sync with numbers
3. Shows related dependencies (commands, hooks)
4. Prompts user for selection
5. Does NOT proceed without user input

**Expected Output Contains**:
- Comparison table
- Numbered list of syncable agents
- Note about dependencies for agent-git-manager
- Selection prompt

**Validation Criteria**:
- [ ] Comparison shown before selection
- [ ] Selection prompt appears
- [ ] Dependencies are mentioned
- [ ] Agent waits for user input

---

## Test Case 6: Sync Creates Backups

**Objective**: Verify backups are created before overwriting.

**Setup**:
```bash
mkdir -p /tmp/test-backup-project/.claude/agents
echo "old content" > /tmp/test-backup-project/.claude/agents/agent-git-manager.md
```

**Input**:
```
@agent-provisioner: sync /tmp/test-backup-project
# User selects agent-git-manager
```

**Expected Behavior**:
1. Detects existing file
2. Creates backup: `agent-git-manager.md.bak`
3. Then overwrites with new content

**Expected Output Contains**:
- "Backed up: agent-git-manager.md.bak"
- "Updated agent-git-manager.md"

**Validation Criteria**:
- [ ] Backup file created
- [ ] Backup contains old content
- [ ] New file has updated content

---

## Test Case 7: Sync with Dependencies

**Objective**: Verify agent-git-manager syncs with command and hook.

**Setup**:
```bash
mkdir -p /tmp/test-deps-project
```

**Input**:
```
@agent-provisioner: sync /tmp/test-deps-project
# User selects agent-git-manager
```

**Expected Behavior**:
1. Copies agent-git-manager.md
2. Creates .claude/commands/ if needed
3. Copies update_doc.md command
4. Creates or merges settings.local.json with hook

**Expected Output Contains**:
- "Copied agent-git-manager.md"
- "Copied update_doc.md command"
- "Merged PostToolUse hook"

**Validation Criteria**:
- [ ] Agent file copied
- [ ] Command file copied
- [ ] Hook added to settings.local.json
- [ ] Existing settings preserved

---

## Test Case 8: Sync with "none" Selection

**Objective**: Verify sync aborts gracefully when user selects nothing.

**Input**:
```
@agent-provisioner: sync /tmp/test-project
# User enters "none"
```

**Expected Behavior**:
1. Shows comparison
2. Prompts for selection
3. User enters "none"
4. Agent aborts sync gracefully

**Expected Output Contains**:
- "No agents selected. Sync cancelled."
- No files modified

**Validation Criteria**:
- [ ] Sync is cancelled
- [ ] No files created or modified
- [ ] Graceful message displayed

---

## Test Case 9: Invalid Target Path

**Objective**: Verify error handling for non-existent paths.

**Input**:
```
@agent-provisioner: sync /path/that/does/not/exist
```

**Expected Behavior**:
1. Agent checks if path exists
2. Returns clear error message
3. Does not attempt any file operations

**Expected Output Contains**:
- "Error: Target path does not exist"
- Path shown in error message

**Validation Criteria**:
- [ ] Error is caught
- [ ] Clear message shown
- [ ] No partial operations attempted

---

## Test Case 10: Create .claude Directory Structure

**Objective**: Verify agent can create initial .claude structure.

**Setup**:
```bash
mkdir /tmp/test-new-project
# No .claude directory exists
```

**Input**:
```
@agent-provisioner: sync /tmp/test-new-project
# Agent asks about creating .claude
# User confirms
# User selects agents
```

**Expected Behavior**:
1. Detects missing .claude directory
2. Asks user if they want to create it
3. Creates directory structure
4. Proceeds with sync

**Expected Output Contains**:
- Question about creating .claude directory
- Confirmation of directories created
- Sync proceeds normally

**Validation Criteria**:
- [ ] Missing directory detected
- [ ] User prompted before creation
- [ ] Structure created correctly
- [ ] Sync completes successfully

---

## Test Case 11: Hook Merging Preserves Permissions

**Objective**: Verify hook merging doesn't overwrite existing permissions.

**Setup**:
```bash
mkdir -p /tmp/test-merge-project/.claude
cat > /tmp/test-merge-project/.claude/settings.local.json << 'EOF'
{
  "permissions": {
    "allow": ["Bash(npm:*)"],
    "deny": [],
    "ask": ["Bash(rm:*)"]
  },
  "hooks": {}
}
EOF
```

**Input**:
```
@agent-provisioner: sync /tmp/test-merge-project
# Select agent-git-manager (has hooks)
```

**Expected Behavior**:
1. Reads existing settings.local.json
2. Preserves permissions array
3. Adds PostToolUse hook
4. Writes merged configuration

**Expected Output Contains**:
- Confirmation of hook merge
- Note that permissions preserved

**Validation Criteria**:
- [ ] Original permissions still present
- [ ] New hook added
- [ ] JSON structure valid
- [ ] No data loss

---

## Test Case 12: Agent Without Dependencies

**Objective**: Verify clean sync of agent with no dependencies.

**Setup**:
```bash
mkdir -p /tmp/test-simple-project
```

**Input**:
```
@agent-provisioner: sync /tmp/test-simple-project
# Select agent-ansible-automation (no dependencies)
```

**Expected Behavior**:
1. Only copies agent definition
2. No command or hook operations
3. Clean completion

**Expected Output Contains**:
- "Copied agent-ansible-automation.md"
- No mention of commands or hooks

**Validation Criteria**:
- [ ] Only agent file created
- [ ] No command directory created (if not needed)
- [ ] No settings.local.json changes (if not needed)

---

## Test Execution Checklist

| Test | Description | Status |
|------|-------------|--------|
| TC1 | List available agents | [ ] |
| TC2 | Compare with empty target | [ ] |
| TC3 | Compare with existing agents | [ ] |
| TC4 | Compare with up-to-date agents | [ ] |
| TC5 | Sync with interactive selection | [ ] |
| TC6 | Sync creates backups | [ ] |
| TC7 | Sync with dependencies | [ ] |
| TC8 | Sync with "none" selection | [ ] |
| TC9 | Invalid target path | [ ] |
| TC10 | Create .claude directory structure | [ ] |
| TC11 | Hook merging preserves permissions | [ ] |
| TC12 | Agent without dependencies | [ ] |

## Notes

- Test cases should be executed in order for setup dependencies
- Clean up test directories after testing: `rm -rf /tmp/test-*-project`
- Some tests require user interaction (selection prompts)
