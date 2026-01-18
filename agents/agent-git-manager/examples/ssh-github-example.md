# Example: SSH Authentication and Push Workflow

This example demonstrates SSH authentication handling and secure push operations.

## Scenario 1: Successful Push Workflow

### User Request

```
@agent-git-manager: Push my commits to GitHub
```

### Agent Response

#### Step 1: Check Remote Configuration

```
$ git remote -v
origin  git@github.com:username/repository.git (fetch)
origin  git@github.com:username/repository.git (push)
```

Remote configured: `origin` -> `git@github.com:username/repository.git`

#### Step 2: Verify SSH Authentication

```
$ ssh -T git@github.com
Hi username! You've successfully authenticated, but GitHub does not provide shell access.
```

SSH authentication: **Verified**

#### Step 3: Check What Will Be Pushed

```
$ git log origin/main..HEAD --oneline
abc1234 feat(auth): implement user authentication system
def5678 fix(api): correct error handling in client
```

**Commits to push**: 2 commits

```
$ git diff --stat origin/main..HEAD
 src/auth/login.ts          | 45 +++++++++++++
 src/auth/logout.ts         | 23 +++++++
 src/api/client.ts          | 12 ++--
 4 files changed, 72 insertions(+), 4 deletions(-)
```

**Files affected**: 4 files, +72/-4 lines

#### Step 4: Confirmation Required

**Ready to push to origin/main:**
- 2 commits
- 4 files changed
- Branch: feature/user-authentication -> origin/feature/user-authentication

**Please confirm:** Push these commits to origin? [Y/n]

---

### User Confirms

```
User: Y
```

### Agent Executes

```
$ git push origin feature/user-authentication
Enumerating objects: 12, done.
Counting objects: 100% (12/12), done.
Delta compression using up to 8 threads
Compressing objects: 100% (8/8), done.
Writing objects: 100% (10/10), 2.34 KiB | 2.34 MiB/s, done.
Total 10 (delta 4), reused 0 (delta 0)
remote: Resolving deltas: 100% (4/4), completed with 2 local objects.
To github.com:username/repository.git
   789abc0..abc1234  feature/user-authentication -> feature/user-authentication
```

**Push successful!**

Would you like to create a pull request for this branch?

---

## Scenario 2: Push to Main Branch (Warning)

### User Request

```
@agent-git-manager: Push my changes to main
```

### Agent Response

```
WARNING: You are about to push directly to the main branch.

Current branch: main
Target: origin/main
Commits to push: 3

Direct pushes to main/master can:
- Bypass code review processes
- Affect all team members immediately
- Make reverting changes more difficult

Recommendations:
1. Create a feature branch: git checkout -b feature/your-change
2. Push to the feature branch
3. Create a pull request for review

Do you want to proceed with pushing directly to main?
This requires explicit confirmation: Type "PUSH TO MAIN" to proceed.
```

---

## Scenario 3: SSH Authentication Failure

### User Request

```
@agent-git-manager: Push my changes
```

### Agent Response

#### Step 1: Check Remote

```
$ git remote -v
origin  git@github.com:username/repository.git (fetch)
origin  git@github.com:username/repository.git (push)
```

#### Step 2: Verify SSH Authentication

```
$ ssh -T git@github.com
git@github.com: Permission denied (publickey).
```

**SSH authentication failed.** Let me help you troubleshoot.

#### Step 3: Diagnostic Checks

**Checking for SSH keys...**
```
$ ls -la ~/.ssh/
total 16
drwx------  2 user user 4096 Jan 15 10:00 .
drwxr-xr-x 30 user user 4096 Jan 18 09:00 ..
-rw-------  1 user user  411 Jan 10 14:00 id_ed25519
-rw-r--r--  1 user user   98 Jan 10 14:00 id_ed25519.pub
```

SSH key found: `~/.ssh/id_ed25519`

**Checking ssh-agent...**
```
$ ssh-add -l
The agent has no identities.
```

**Issue identified**: SSH key exists but is not loaded into ssh-agent.

#### Step 4: Resolution Steps

To fix this, run the following commands:

```bash
# Start ssh-agent if not running
eval "$(ssh-agent -s)"

# Add your SSH key
ssh-add ~/.ssh/id_ed25519
```

After adding your key, I'll test the connection again.

---

### User Follows Instructions

```
User: Done, I added the key
```

### Agent Verifies

```
$ ssh-add -l
256 SHA256:abc123... user@hostname (ED25519)
```

Key loaded successfully.

```
$ ssh -T git@github.com
Hi username! You've successfully authenticated, but GitHub does not provide shell access.
```

**SSH authentication: Verified**

Now proceeding with push...

---

## Scenario 4: SSH Key Not on GitHub

### Diagnostic Output

```
$ ssh -T git@github.com
git@github.com: Permission denied (publickey).

$ ssh-add -l
256 SHA256:abc123... user@hostname (ED25519)
```

Key is loaded but still getting permission denied.

**Possible cause**: SSH key is not registered with GitHub.

#### Resolution Steps

1. **Copy your public key:**
```bash
cat ~/.ssh/id_ed25519.pub
```

2. **Add to GitHub:**
   - Go to: https://github.com/settings/keys
   - Click "New SSH key"
   - Paste your public key
   - Give it a descriptive title

3. **Test connection:**
```bash
ssh -T git@github.com
```

After adding your key to GitHub, let me know and I'll verify the connection.

---

## Scenario 5: Create Pull Request

### User Request

```
@agent-git-manager: Create a pull request for my branch
```

### Agent Response

#### Step 1: Verify Branch Status

```
$ git status
On branch feature/user-authentication
Your branch is up to date with 'origin/feature/user-authentication'.

nothing to commit, working tree clean
```

Branch is pushed and ready for PR.

#### Step 2: Create Pull Request

```
$ gh pr create --title "feat(auth): implement user authentication" --body "## Summary
- Add login and logout functionality
- Create LoginForm component with validation
- Implement session management
- Add comprehensive test coverage

## Test Plan
- [ ] Manual testing of login flow
- [ ] Manual testing of logout flow
- [ ] Verify session persistence
- [ ] Run automated test suite

Generated with Claude Code"
```

**Pull Request Created!**

- URL: https://github.com/username/repository/pull/42
- Title: feat(auth): implement user authentication
- Base: main <- feature/user-authentication

Would you like me to show the PR status or check CI results?

---

## Key Takeaways

1. **SSH verification before push** - Always tests authentication first
2. **Clear push preview** - Shows exactly what will be pushed
3. **Main branch protection** - Extra confirmation for main/master
4. **Diagnostic troubleshooting** - Guides through SSH issues step-by-step
5. **GitHub CLI integration** - Can create PRs directly
