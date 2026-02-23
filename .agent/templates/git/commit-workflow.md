# Commit Workflow Example

Detailed walkthrough of the secure commit process.

---

## Workflow Steps

### User Request
"Help me commit my changes"

---

### Step 1: Check Repository State
```bash
git status
```

See current state: modified, staged, untracked files.

---

### Step 2: Understand Scope
```bash
git diff --stat
```

Understand scope of changes: files affected, lines changed.

---

### Step 3: Run Security Scan (MANDATORY)

**File Pattern Check:**
- Scan all staged/modified files
- Match against sensitive file patterns (`.env`, `*.key`, etc.)

**Content Scan:**
- Grep for API keys, tokens, passwords
- Check for private keys, connection strings
- Verify no credentials in staged content

---

### Step 4: Display Security Report

```
Security Scan Results:
- Files scanned: 7
- Patterns checked: 15
- Warnings: 0
- Blocks: 0
All clear to proceed.
```

User MUST acknowledge before proceeding.

---

### Step 5: Generate Commit Message

Based on actual changes:

```
feat(agents): add git-manager agent for secure commits

- Add agent definition with security scanning
- Create documentation and test cases
- Configure hook-based triggering
```

**Format:** Conventional Commits (type(scope): description)

---

### Step 6: Ask for Confirmation

"Shall I proceed with this commit? [Y/n]"

Wait for explicit user confirmation.

---

### Step 7: Execute Commit

Only after confirmation:

```bash
git add [files]
git commit -m "commit message"
```

Show confirmation of successful commit.

---

## Commit Threshold Detection

Suggest a commit when ANY of these conditions are met:

- 5+ files have been modified/added/deleted
- 100+ lines have been changed (added + deleted)
- Changes to critical configuration files:
  - `CLAUDE.md`
  - `.claude/agents/*`
  - `.agent/**/*`
  - `AGENTS_REGISTRY.md`
  - `package.json`, `pyproject.toml`, `Cargo.toml`
- After `/update_doc` completes (automatic trigger)
- User explicitly requests commit workflow

---

## Extended Context for Large Commits

**For commits touching 5+ files OR 100+ lines**, ask once:

"What's the context or reason behind these changes? (optional — improves commit history for future debugging)"

**If provided:** Include as extended body paragraph in the commit message, before any footers

**If skipped:** Proceed with generated subject line only

---

**Last Updated:** 2026-02-22
**Source:** agent-git-manager optimization (Phase 4)
