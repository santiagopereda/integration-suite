# Example: Standard Commit Workflow

This example demonstrates the complete commit workflow with security scanning.

## Scenario

Developer has made changes to multiple files and wants to commit them safely.

## User Request

```
@agent-git-manager: I've been working on the new feature. Help me commit my changes.
```

## Agent Response

### Step 1: Repository Status

Let me check your repository status.

```
$ git status
On branch feature/user-authentication
Changes not staged for commit:
  modified:   src/auth/login.ts
  modified:   src/auth/logout.ts
  modified:   src/components/LoginForm.tsx
  modified:   tests/auth.test.ts

Untracked files:
  src/auth/session.ts
  src/utils/crypto.ts
```

**Summary**: 4 modified files, 2 new files

### Step 2: Change Analysis

```
$ git diff --stat
 src/auth/login.ts          | 45 +++++++++++++++++++++++++++++++++
 src/auth/logout.ts         | 23 +++++++++++++++++
 src/components/LoginForm.tsx | 67 +++++++++++++++++++++++++++++++++++++++
 tests/auth.test.ts         | 89 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 224 insertions(+)
```

**Total changes**: 6 files, +224 lines

### Step 3: Security Scan (Mandatory)

Running pre-commit security scan...

**File Pattern Check**:
- [PASS] No .env files detected
- [PASS] No credential files detected
- [PASS] No private key files detected

**Content Scan**:
- Scanning src/auth/login.ts... [PASS]
- Scanning src/auth/logout.ts... [PASS]
- Scanning src/components/LoginForm.tsx... [PASS]
- Scanning tests/auth.test.ts... [PASS]
- Scanning src/auth/session.ts... [PASS]
- Scanning src/utils/crypto.ts... [PASS]

```
Security Scan Results
---------------------
Files scanned: 6
Patterns checked: 15
Warnings: 0
Blocks: 0

Status: ALL CLEAR
```

### Step 4: Commit Message Suggestion

Based on the changes, I suggest:

```
feat(auth): implement user authentication system

- Add login and logout functionality
- Create LoginForm component with validation
- Implement session management
- Add comprehensive test coverage

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
```

### Step 5: Confirmation

**Ready to commit with the message above.**

Files to be committed:
- src/auth/login.ts (modified)
- src/auth/logout.ts (modified)
- src/components/LoginForm.tsx (modified)
- tests/auth.test.ts (modified)
- src/auth/session.ts (new)
- src/utils/crypto.ts (new)

Shall I proceed with this commit? [Y/n]

---

## User Confirms

```
User: Y
```

## Agent Executes

```
$ git add src/auth/login.ts src/auth/logout.ts src/components/LoginForm.tsx tests/auth.test.ts src/auth/session.ts src/utils/crypto.ts
$ git commit -m "feat(auth): implement user authentication system

- Add login and logout functionality
- Create LoginForm component with validation
- Implement session management
- Add comprehensive test coverage

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"

[feature/user-authentication abc1234] feat(auth): implement user authentication system
 6 files changed, 224 insertions(+)
 create mode 100644 src/auth/session.ts
 create mode 100644 src/utils/crypto.ts
```

**Commit successful!**

Current status:
- Branch: feature/user-authentication
- Commit: abc1234
- Ahead of origin by: 1 commit

Would you like to push these changes to the remote repository?

---

## Key Takeaways

1. **Security scan is mandatory** - Runs before every commit
2. **Transparency** - All changes shown before commit
3. **User control** - Explicit confirmation required
4. **Conventional commits** - Message follows standard format
5. **Co-authorship** - Claude included as co-author
