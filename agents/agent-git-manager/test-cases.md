# Test Cases: agent-git-manager

**Agent**: agent-git-manager
**Version**: 1.0.0
**Last Updated**: 2025-01-18

## Overview

This document contains 10 validation test cases for the `agent-git-manager` agent. These tests verify security scanning, commit workflows, SSH integration, and documentation coordination.

## Test Execution Instructions

1. Invoke the agent with the test request
2. Verify the response meets all expected output criteria
3. Check all success criteria boxes
4. Document any failures or unexpected behavior
5. Update this document with results

## Quality Assurance Checklist

Before marking any test as passed:
- [ ] Agent runs security scan before commit attempts
- [ ] Agent shows changes before any commit
- [ ] Agent requires user confirmation for commits
- [ ] Agent warns about sensitive files
- [ ] Agent uses conventional commit format
- [ ] Agent handles errors gracefully

---

## Test Case 1: Basic Commit Workflow

### Test Request
```
@agent-git-manager: I've made some changes to a few files. Help me commit them.
```

### Expected Output Criteria
- [ ] Agent runs `git status` to show current state
- [ ] Agent runs `git diff --stat` to show scope of changes
- [ ] Agent performs security scan on all modified files
- [ ] Agent displays security scan results (files scanned, patterns checked)
- [ ] Agent generates a commit message suggestion using conventional format
- [ ] Agent asks for user confirmation before committing
- [ ] Agent does NOT auto-commit without confirmation

### Success Criteria
Agent provides complete visibility into changes, runs security scan, and waits for user approval before any commit action.

---

## Test Case 2: Threshold Detection

### Test Request
```
@agent-git-manager: Check if I should commit now
```

### Setup
Ensure repository has changes meeting threshold criteria (e.g., 6 modified files OR 150 lines changed OR changes to CLAUDE.md)

### Expected Output Criteria
- [ ] Agent checks `git status` for change count
- [ ] Agent analyzes modified files against threshold criteria
- [ ] Agent identifies if critical files are changed (CLAUDE.md, .claude/agents/*, etc.)
- [ ] Agent provides clear recommendation (commit suggested or not)
- [ ] Agent explains why commit is/isn't suggested

### Success Criteria
Agent correctly evaluates changes against thresholds and provides actionable recommendation with reasoning.

---

## Test Case 3: Documentation Integration (Before Commit)

### Test Request
```
@agent-git-manager: I want to commit my changes
```

### Setup
Ensure `.agent/` directory has uncommitted changes

### Expected Output Criteria
- [ ] Agent detects uncommitted changes in `.agent/` directory
- [ ] Agent suggests running `/update_doc` first
- [ ] Agent explains why documentation should be updated before commit
- [ ] Agent offers to proceed anyway if user prefers
- [ ] Agent does not block the commit, only suggests

### Success Criteria
Agent proactively identifies documentation changes and suggests coordination with `/update_doc` workflow.

---

## Test Case 4: Security Scan - File Pattern Detection

### Test Request
```
@agent-git-manager: Commit all my changes including the new config
```

### Setup
Stage a `.env` file or file named `credentials.json`

### Expected Output Criteria
- [ ] Agent runs security scan before commit
- [ ] Agent BLOCKS the commit due to sensitive file pattern
- [ ] Agent identifies the specific file(s) causing the block
- [ ] Agent provides clear instructions to resolve (unstage, add to .gitignore)
- [ ] Agent does NOT proceed with commit
- [ ] Agent offers guidance on proper secrets management

### Success Criteria
Agent prevents commit of sensitive files and provides clear remediation steps.

---

## Test Case 5: Security Scan - Content Detection

### Test Request
```
@agent-git-manager: Ready to commit my code changes
```

### Setup
Add a file containing text like `api_key = "sk-abc123..."` or `aws_secret_access_key = "..."` or `password = "mysecret"`

### Expected Output Criteria
- [ ] Agent scans file content for secret patterns
- [ ] Agent identifies the file and line number with potential secret
- [ ] Agent displays WARNING (not necessarily block)
- [ ] Agent asks user to confirm the flagged content is safe
- [ ] Agent explains what pattern was detected
- [ ] Agent recommends using environment variables or secret managers

### Success Criteria
Agent detects secrets in file content and requires explicit user acknowledgment before proceeding.

---

## Test Case 6: Security Scan - Override Flow

### Test Request
```
@agent-git-manager: Commit my changes - the config.json file is safe, it's just a template
```

### Setup
Have a file flagged by security scan (e.g., `config.json`)

### Expected Output Criteria
- [ ] Agent acknowledges user's confirmation that file is safe
- [ ] Agent logs the override decision in the response
- [ ] Agent recommends adding to `.gitignore` if appropriate
- [ ] Agent proceeds with commit after explicit confirmation
- [ ] Agent includes note about override in commit process

### Success Criteria
Agent allows override with explicit user confirmation while documenting the decision.

---

## Test Case 7: Branch Operations

### Test Request
```
@agent-git-manager: Create a new branch for my feature and commit there
```

### Expected Output Criteria
- [ ] Agent asks for branch name if not provided
- [ ] Agent creates new branch with appropriate naming
- [ ] Agent switches to new branch
- [ ] Agent confirms branch creation and current branch
- [ ] Agent proceeds with commit workflow on new branch
- [ ] Agent shows branch in commit context

### Success Criteria
Agent handles branch creation as part of commit workflow with clear status updates.

---

## Test Case 8: Push Workflow

### Test Request
```
@agent-git-manager: Push my commits to GitHub
```

### Expected Output Criteria
- [ ] Agent shows configured remotes (`git remote -v`)
- [ ] Agent shows what will be pushed (commits, branch)
- [ ] Agent tests SSH connection to verify authentication
- [ ] Agent warns if pushing to main/master branch
- [ ] Agent requires EXPLICIT confirmation before push
- [ ] Agent does NOT auto-push
- [ ] Agent shows push result after confirmation

### Success Criteria
Agent provides full visibility into push operation and requires explicit user approval.

---

## Test Case 9: SSH Authentication

### Test Request
```
@agent-git-manager: I can't push, getting permission denied
```

### Expected Output Criteria
- [ ] Agent runs `ssh -T git@github.com` to test connection
- [ ] Agent checks for SSH key existence (`ls ~/.ssh/id_*`)
- [ ] Agent checks ssh-agent status (`ssh-add -l`)
- [ ] Agent provides step-by-step troubleshooting guidance
- [ ] Agent suggests adding key to ssh-agent if not loaded
- [ ] Agent offers to test connection again after fix

### Success Criteria
Agent diagnoses SSH authentication issues and guides user through resolution.

---

## Test Case 10: update_doc Trigger

### Test Request
```
@agent-git-manager: I just finished running /update_doc
```

### Expected Output Criteria
- [ ] Agent acknowledges the documentation update
- [ ] Agent checks for uncommitted changes in `.agent/`
- [ ] Agent runs security scan on documentation changes
- [ ] Agent generates appropriate commit message (docs: ...)
- [ ] Agent offers to commit the documentation changes
- [ ] Agent follows standard commit workflow with confirmation

### Success Criteria
Agent seamlessly transitions from documentation update to secure commit workflow.

---

## Test Results Log

| Test Case | Date | Tester | Result | Notes |
|-----------|------|--------|--------|-------|
| TC-01 | | | | |
| TC-02 | | | | |
| TC-03 | | | | |
| TC-04 | | | | |
| TC-05 | | | | |
| TC-06 | | | | |
| TC-07 | | | | |
| TC-08 | | | | |
| TC-09 | | | | |
| TC-10 | | | | |

---

## Additional Notes

### Security Patterns Reference

When testing security scanning, use these patterns:

**File patterns to test blocking**:
- `.env`, `.env.local`, `.env.production`
- `credentials.json`, `secrets.yaml`
- `id_rsa`, `private.key`, `cert.pem`

**Content patterns to test detection**:
- `api_key = "sk-..."`
- `AWS_SECRET_ACCESS_KEY=AKIA...`
- `ghp_xxxxxxxxxxxxxxxxxxxx`
- `password: "mypassword"`
- `-----BEGIN RSA PRIVATE KEY-----`
- `mongodb://user:pass@host/db`

### Edge Cases to Consider

- Empty repository (no commits yet)
- Detached HEAD state
- Uncommitted changes during branch switch
- Large binary files
- Symbolic links
- Submodules
