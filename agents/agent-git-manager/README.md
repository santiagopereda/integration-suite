# agent-git-manager

**Version**: 1.0.0
**Status**: Production
**Agent Type**: Git Repository Management with Security Scanning

## Overview

The `agent-git-manager` is an intelligent git repository manager that provides secure commit workflows with mandatory pre-commit security scanning, SSH/GitHub integration, and documentation workflow coordination.

**Key differentiator**: Every commit goes through a security scan to prevent accidental exposure of secrets, credentials, and sensitive data.

## When to Use This Agent

### Trigger Conditions

- You want to commit changes with security assurance
- You need to push changes to a remote repository
- You want to check repository status with security awareness
- You've completed documentation updates with `/update_doc`
- The hook system detected significant file changes
- You need help with SSH authentication to GitHub

### When NOT to Use

- For complex merge operations (manual review recommended)
- For interactive rebasing (use git directly)
- For repository-wide history rewrites (dangerous operations)

## Key Capabilities

### 1. Pre-Commit Security Scanning (Mandatory)

Every commit is scanned for:

**File Patterns Blocked**:
- `.env`, `.env.*`, `*.env` - Environment files
- `*credentials*`, `*secret*`, `*password*` - Credential files
- `*.pem`, `*.key`, `*.p12`, `*.pfx` - Certificates and keys
- `id_rsa`, `id_ed25519`, `*.pub` - SSH keys
- `config.json`, `secrets.json`, `auth.json` - Config with secrets

**Content Patterns Detected**:
- API keys: `api_key`, `apikey`, `api_secret`
- AWS credentials: `AKIA...`, `aws_secret_access_key`
- GitHub tokens: `ghp_`, `gho_`, `ghu_`, `ghs_`, `ghr_`
- Generic secrets: `password=`, `secret=`, `token=`
- Private keys: `-----BEGIN.*PRIVATE KEY-----`
- Connection strings: `mysql://`, `postgres://`, `mongodb://`

### 2. SSH/GitHub Integration

- Tests SSH connection to GitHub
- Guides through authentication issues
- Handles SSH agent and key management
- Supports GitHub CLI (gh) for PR operations

### 3. Documentation Workflow Integration

- Detects changes in `.agent/` directory
- Suggests running `/update_doc` before commits
- Automatically offers to commit after `/update_doc` completes

### 4. Commit Threshold Detection

Suggests commits when:
- 5+ files changed
- 100+ lines changed
- Critical files modified (`CLAUDE.md`, `.claude/agents/*`, etc.)
- After `/update_doc` completes

## How to Invoke

### Direct Invocation

```bash
@agent-git-manager: [Your request]
```

### Common Commands

```bash
# Check repository status
@agent-git-manager: status

# Commit workflow
@agent-git-manager: help me commit my changes

# Push to remote
@agent-git-manager: push my changes to GitHub

# After documentation updates
@agent-git-manager: I just ran /update_doc, commit the changes
```

### Hook-Triggered

When configured, the agent is automatically invoked after file edits to check if a commit is warranted.

## Safety Constraints

The agent will **NEVER**:
- Force push to any branch
- Amend commits without explicit request
- Push to main/master without explicit confirmation
- Commit files with detected secrets without explicit override
- Execute destructive operations (reset --hard, rebase)
- Auto-commit without user confirmation

The agent will **ALWAYS**:
- Run security scan before every commit
- Show changes before committing
- Require confirmation for push operations
- Warn about sensitive file patterns

## Example Workflows

### Standard Commit Workflow

```
User: Help me commit my changes

Agent:
1. [Runs git status]
2. [Runs security scan]
3. Security Scan Results:
   - Files scanned: 5
   - Patterns checked: 15
   - Warnings: 0
   - Blocks: 0
   All clear to proceed.

4. Suggested commit message:
   feat(feature): add new functionality

   - Implement X
   - Update Y
   - Fix Z

5. Shall I proceed with this commit? [Y/n]
```

### Security Block Example

```
User: Commit all my changes

Agent:
1. [Runs git status]
2. [Runs security scan]
3. SECURITY ALERT:
   - BLOCKED: .env file detected
   - WARNING: Possible API key in src/config.ts (line 15)

   Cannot proceed with commit. Please:
   1. Remove .env from staging: git reset .env
   2. Add .env to .gitignore
   3. Review src/config.ts line 15

   Run commit again after addressing these issues.
```

### SSH Authentication Workflow

```
User: Push my changes

Agent:
1. [Tests SSH connection]
   SSH authentication failed.

   Let me help you troubleshoot:

   Checking for SSH keys...
   Found: ~/.ssh/id_ed25519

   SSH agent status:
   No keys loaded.

   Try: ssh-add ~/.ssh/id_ed25519

   Then run push again.
```

## Configuration

### Commit Thresholds (Customizable in CLAUDE.md)

```yaml
agent-git-manager:
  thresholds:
    files_changed: 5      # Number of files to trigger suggestion
    lines_changed: 100    # Total lines to trigger suggestion

  critical_files:         # Always suggest commit when changed
    - "CLAUDE.md"
    - ".claude/agents/*"
    - ".agent/**/*"
    - "AGENTS_REGISTRY.md"
```

### Hook Configuration

Add to `.claude/settings.local.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write|NotebookEdit",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'GIT_CHECK_TRIGGER'"
          }
        ]
      }
    ]
  }
}
```

## Integration with update_doc

The agent works bidirectionally with `/update_doc`:

1. **Before commit**: If `.agent/` has uncommitted changes, agent suggests running `/update_doc` first
2. **After /update_doc**: The command triggers the agent to offer a commit workflow

## Portability

To use this agent in another project:

1. Copy `.claude/agents/agent-git-manager.md` to the project
2. Optionally copy hook configuration to `.claude/settings.local.json`
3. Agent works immediately with sensible defaults

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2025-01-18 | Initial release with security scanning, SSH integration, update_doc workflow |

## Support & Feedback

Report issues to the Agent Architecture Team with:
- Agent ID: `agent-git-manager`
- Your request
- Expected behavior
- Actual behavior
- Any error messages

## Best Practices

### Do

- Run security scan before every commit
- Review flagged files before overriding
- Use conventional commit messages
- Confirm before pushing to shared branches
- Keep `.gitignore` updated with sensitive patterns

### Don't

- Override security warnings without careful review
- Push directly to main/master without team coordination
- Commit large binary files without consideration
- Ignore SSH authentication errors
