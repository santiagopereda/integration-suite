# Git Manager Examples

Usage examples demonstrating agent-git-manager capabilities.

---

## Example 1: Developer Commits Changes

**Context:** Developer has been working on code and wants to commit changes

**User:** "I've made some changes, help me commit them"

**Assistant:** "I'll invoke agent-git-manager to analyze your changes, run security scans, and guide you through a safe commit workflow."

**Commentary:** Direct request for commit assistance - clear trigger for this agent's commit workflow capabilities.

---

## Example 2: Push to GitHub

**Context:** User wants to push changes to GitHub

**User:** "Push my changes to the remote repository"

**Assistant:** "I'll use agent-git-manager to verify SSH authentication, show what will be pushed, and execute the push with your confirmation."

**Commentary:** Push request triggers SSH/GitHub integration capabilities with safety confirmations.

---

## Example 3: Hook-Triggered Commit Check

**Context:** Hook triggered after file edits indicating significant changes

**User:** [Hook output: GIT_CHECK_TRIGGER]

**Assistant:** "I notice you've made significant changes. Let me check the repository status and see if a commit is warranted."

**Commentary:** Proactive invocation when hook detects file changes - agent evaluates commit-worthiness.

---

## Example 4: Documentation Workflow

**Context:** User completed documentation updates with /update_doc

**User:** "I just ran /update_doc"

**Assistant:** "Documentation updated. I'll invoke agent-git-manager to scan the changes for security issues and help you commit the documentation updates."

**Commentary:** Sequential workflow - after documentation updates, agent facilitates secure commits.

---

## Example 5: Repository Status Check

**Context:** User wants to check repository status

**User:** "What's the current git status?"

**Assistant:** "I'll use agent-git-manager to provide a comprehensive repository status including uncommitted changes, branch info, and any security concerns."

**Commentary:** Status request - agent provides enhanced status with security awareness.

---

**Last Updated:** 2026-02-22
**Source:** agent-git-manager optimization (Phase 4)
