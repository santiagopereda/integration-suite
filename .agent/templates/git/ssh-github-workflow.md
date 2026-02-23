# SSH/GitHub Integration Workflow

Step-by-step procedures for SSH authentication and GitHub operations.

---

## SSH Authentication Handling

### Step 1: Check Connection
```bash
ssh -T git@github.com
```

Expected success output:
```
Hi [username]! You've successfully authenticated, but GitHub does not provide shell access.
```

### Step 2: Diagnose Issues

If authentication fails, guide user through:

1. **Check if SSH key exists:**
   ```bash
   ls ~/.ssh/id_*
   ```

2. **Verify ssh-agent is running:**
   ```bash
   ssh-add -l
   ```

3. **Add key if needed:**
   ```bash
   ssh-add ~/.ssh/id_ed25519
   ```

4. **Test connection again:**
   ```bash
   ssh -T git@github.com
   ```

---

## SSH Error Handling

### Permission denied
- Guide through SSH key setup
- Verify key is added to GitHub account (Settings → SSH and GPG keys)
- Check SSH config (`~/.ssh/config`)

### Host key verification failed
- Explain the issue (GitHub's host key changed or not recognized)
- Offer to add host to `known_hosts`:
  ```bash
  ssh-keyscan github.com >> ~/.ssh/known_hosts
  ```

### Connection timeout
- Check network connectivity
- Suggest HTTPS fallback if persistent:
  ```bash
  git remote set-url origin https://github.com/user/repo.git
  ```

---

## Remote Operations

### View Configured Remotes
```bash
git remote -v
```

Always show remotes before push operations.

### Fetch (Safe, Read-Only)
```bash
git fetch
```

Check remote state without modifying local repository.

### Push (Requires Confirmation)
```bash
git push
```

**Before pushing:**
1. Show exactly what will be pushed
2. Display target branch
3. Warn if pushing to main/master
4. Require explicit confirmation

### Pull with Rebase
```bash
git pull --rebase
```

**Warnings:**
- Potential conflicts may occur
- Require confirmation before executing
- Explain rebase implications if user unfamiliar

---

## GitHub CLI (gh) Integration

### Create Pull Request
```bash
gh pr create --title "..." --body "..."
```

### View PR Status
```bash
gh pr status
```

### Check CI Status
```bash
gh pr checks
```

---

**Last Updated:** 2026-02-22
**Source:** agent-git-manager optimization (Phase 4)
