# /pr-secure - Secure Pull Request Creation

Create pull requests with security scanning, conventional commit verification, and automated descriptions from commit history.

## Purpose

Creates pull requests with mandatory pre-push security scanning and intelligent PR descriptions generated from the commit history since branch divergence.

## Quick Reference

| Aspect | Details |
|--------|---------|
| **Invocation** | `/pr-secure` or `/pr-secure --title "Custom Title"` |
| **Security Check** | Mandatory scan before push |
| **Output** | GitHub PR with auto-generated description |

---

## Workflow Steps

### Step 1: Assess Branch State

```bash
# Check current branch and remote tracking
git status
git branch -vv

# View commits since divergence from main/master
git log origin/main..HEAD --oneline
git diff origin/main...HEAD
```

### Step 2: Security Scan (MANDATORY)

Same as `/commit-secure` Step 2 - scan all staged and committed files:

Load patterns from `.agent/templates/git/security-patterns.md` and check:
- File patterns (`.env*`, `*.key`, `credentials*`)
- Content patterns (API keys, tokens, passwords, private keys)

**Block PR creation if security issues found.**

### Step 3: Generate PR Title and Description

**Title** (if not provided):
- Analyze all commits in the branch
- Create concise title (<70 chars) summarizing the overall change
- Use conventional commit format: `type(scope): description`

**Description**:
```markdown
## Summary
- [Bullet points from commit messages]
- [Organized by type: features, fixes, docs, etc.]

## Test plan
- [ ] [Checklist items based on changes]
- [ ] Manual testing performed
- [ ] All tests passing

🤖 Generated with [Claude Code](https://claude.com/claude-code)
```

### Step 4: Push Branch

```bash
# Push with upstream tracking if needed
git push -u origin $(git branch --show-current)
```

### Step 5: Create PR

```bash
# Use GitHub CLI with heredoc for proper formatting
gh pr create --title "PR title" --body "$(cat <<'EOF'
## Summary
...

## Test plan
...

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

### Step 6: Display PR URL

Return the PR URL to user for review.

---

## Safety Constraints

**NEVER do these**:
- Push without security scan
- Force push without explicit user request
- Push to main/master without confirmation
- Create PR if security scan blocks

**ALWAYS do these**:
- Run security scan before push
- Verify branch is up to date with remote
- Generate description from actual commits
- Return PR URL for user review

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-02-23 | Initial release (migrated from agent-git-manager) |

---

**Command Created**: 2026-02-23
**Purpose**: Secure PR creation with mandatory security scanning
**Status**: Active
