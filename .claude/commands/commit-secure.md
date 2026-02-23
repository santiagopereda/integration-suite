# /commit-secure - Secure Git Commit Workflow

Execute a security-first git commit workflow with pre-commit scanning, change analysis, and conventional commit messages.

## Purpose

This command provides intelligent git commit orchestration with mandatory security scanning to prevent committing secrets, credentials, or sensitive data.

## Quick Reference

| Aspect | Details |
|--------|---------|
| **Invocation** | `/commit-secure` or `/commit-secure "custom message"` |
| **Security Templates** | `.agent/templates/git/security-patterns.md` |
| **Workflow Template** | `.agent/templates/git/commit-workflow.md` |
| **Output** | Conventional commit with security validation |

---

## Workflow Steps

### Step 1: Assess Repository State

```bash
# Check repository status
git status

# View staged and unstaged changes
git diff
git diff --staged

# Review recent commits for style
git log --oneline -5
```

### Step 2: Security Scan (MANDATORY)

Load security patterns from `.agent/templates/git/security-patterns.md` and scan:

**File Pattern Check:**
- Scan for sensitive files: `.env*`, `*.key`, `*.pem`, `credentials*`, `secrets*`, `*.pfx`
- Check for backup files: `*.bak`, `*.backup`, `*~`
- Identify large binaries that shouldn't be tracked

**Content Pattern Check:**
Use Grep to scan staged files for:
- API keys: `(api|API)[_-]?key.*[A-Za-z0-9]{20,}`
- Tokens: `(token|TOKEN).*[A-Za-z0-9]{20,}`
- Passwords: `(password|PASSWORD|pwd).*[:=]\s*[^\s]+`
- Private keys: `-----BEGIN (RSA |PRIVATE |OPENSSH )?PRIVATE KEY-----`
- Connection strings: `(mongodb|postgres|mysql)://.*@`
- AWS credentials: `(AKIA|AWS)[A-Z0-9]{16,}`

**Security Report Format:**
```markdown
## Security Scan Results

**Files Scanned**: [count]
**Patterns Checked**: [count]

### Warnings
- [filename]: [pattern matched] (Line [N])

### Blocked
- [filename]: [critical secret detected]

**Status**: PASS | WARN | BLOCK
```

### Step 3: User Confirmation

If security scan finds issues:
- **BLOCK status**: Do NOT proceed, user must resolve
- **WARN status**: Present warnings, require explicit confirmation
- **PASS status**: Proceed to Step 4

### Step 4: Generate Commit Message

If user provided custom message, use it. Otherwise, analyze changes and generate conventional commit:

**Format**: `type(scope): description`

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Formatting, missing semi colons, etc
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `perf`: Performance improvement
- `test`: Adding missing tests
- `chore`: Changes to build process or auxiliary tools

**Rules**:
- Analyze actual changes, don't fabricate
- Keep description concise (<70 chars for summary line)
- Do NOT include `Co-Authored-By` lines (this is for human commits)
- Use lowercase for type and description

### Step 5: Stage Files

Prefer specific files over blanket `git add .`:

```bash
# Stage specific changed files
git add file1.js file2.py config.yaml

# Avoid (unless user explicitly requests):
# git add .
# git add -A
```

### Step 6: Create Commit

```bash
# Use heredoc for proper formatting
git commit -m "$(cat <<'EOF'
type(scope): description

Optional longer description if needed.
EOF
)"
```

### Step 7: Confirm Success

```bash
git status
git log -1 --stat
```

---

## Safety Constraints

**NEVER do these** (unless user explicitly requests):
- Update git config
- Run destructive commands (`reset --hard`, `clean -f`, `checkout .`)
- Skip hooks (`--no-verify`, `--no-gpg-sign`)
- Force push to main/master
- Amend commits (always create NEW commits)
- Use `git add -A` or `git add .` (prefer specific files)
- Commit without security scan

**ALWAYS do these**:
- Run security scan before commit
- Show changes before committing
- Require confirmation if warnings exist
- Create new commits (not amend)
- Add specific files by name

---

## Examples

### Example 1: Basic Commit

```
User: /commit-secure