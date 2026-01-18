# Example: Documentation Workflow Integration

This example demonstrates the bidirectional integration between `agent-git-manager` and the `/update_doc` command.

## Scenario 1: Commit Request with Documentation Changes

### User Request

```
@agent-git-manager: I want to commit my recent work
```

### Agent Response

#### Step 1: Repository Status

```
$ git status
On branch feature/new-api
Changes not staged for commit:
  modified:   src/api/endpoints.ts
  modified:   src/api/handlers.ts
  modified:   .agent/system/apis/new-api.md
  modified:   .agent/sops/api-development.md

Untracked files:
  .agent/system/schemas/request-schema.md
```

#### Step 2: Documentation Detection

I notice you have uncommitted changes in the `.agent/` knowledge base:

**Modified documentation:**
- `.agent/system/apis/new-api.md`
- `.agent/sops/api-development.md`

**New documentation:**
- `.agent/system/schemas/request-schema.md`

**Recommendation**: Consider running `/update_doc` first to ensure your documentation is complete and properly organized before committing.

The `/update_doc` command will:
- Verify documentation structure
- Check for consolidation opportunities
- Update cross-references
- Log changes in injection-history.md

**Options:**
1. Run `/update_doc` first, then return to commit
2. Proceed with commit now (documentation as-is)

What would you like to do?

---

### User Choice

```
User: Let's run update_doc first
```

### Agent Response

Understood. Please run:

```
/update_doc
```

When you're done updating documentation, come back and I'll help you commit all changes including the documentation updates.

---

## Scenario 2: After Running /update_doc

### User Request

```
@agent-git-manager: I just finished running /update_doc
```

### Agent Response

Documentation updated. Let me help you commit these changes.

#### Step 1: Check Documentation Changes

```
$ git status .agent/
On branch feature/new-api
Changes not staged for commit:
  modified:   .agent/system/apis/new-api.md
  modified:   .agent/sops/api-development.md
  modified:   .agent/injection-history.md

Untracked files:
  .agent/system/schemas/request-schema.md
```

Documentation changes detected:
- 3 modified files
- 1 new file
- injection-history.md updated (audit trail)

#### Step 2: Security Scan

Running pre-commit security scan on documentation files...

**File Pattern Check**:
- [PASS] No sensitive file patterns

**Content Scan**:
- Scanning .agent/system/apis/new-api.md... [PASS]
- Scanning .agent/sops/api-development.md... [PASS]
- Scanning .agent/injection-history.md... [PASS]
- Scanning .agent/system/schemas/request-schema.md... [PASS]

```
Security Scan Results
---------------------
Files scanned: 4
Patterns checked: 15
Warnings: 0
Blocks: 0

Status: ALL CLEAR
```

#### Step 3: Commit Options

Would you like to:

**Option A**: Commit documentation changes separately
```
docs: update API documentation and schemas

- Update new-api.md with endpoint details
- Add request-schema.md for validation rules
- Update api-development SOP with learnings
- Update injection-history.md
```

**Option B**: Commit documentation together with code changes
```
feat(api): implement new API with documentation

- Add new API endpoints (endpoints.ts, handlers.ts)
- Document API in .agent/system/apis/
- Add request schema documentation
- Update API development SOP
```

Which approach do you prefer?

---

### User Choice

```
User: Option B - commit everything together
```

### Agent Response

#### Step 4: Full Commit Preparation

```
$ git status
On branch feature/new-api
Changes to be committed:
  modified:   src/api/endpoints.ts
  modified:   src/api/handlers.ts
  modified:   .agent/system/apis/new-api.md
  modified:   .agent/sops/api-development.md
  modified:   .agent/injection-history.md
  new file:   .agent/system/schemas/request-schema.md
```

**Suggested commit message:**

```
feat(api): implement new API with documentation

Code changes:
- Add new API endpoints in endpoints.ts
- Implement request handlers in handlers.ts

Documentation:
- Document API endpoints in .agent/system/apis/new-api.md
- Add request schema in .agent/system/schemas/
- Update API development SOP with lessons learned
- Update injection-history.md with documentation changes

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
```

**Files to commit**: 6 files
**Total changes**: +312 lines

Shall I proceed with this commit? [Y/n]

---

## Scenario 3: Automatic Trigger from /update_doc

When `/update_doc` completes, it can automatically invoke the git manager.

### /update_doc Completion Message

```
Documentation update complete.

Changes made:
- Created .agent/system/apis/new-api.md
- Updated .agent/injection-history.md
- Added cross-references to existing docs

Invoking @agent-git-manager for commit workflow...
```

### Agent Auto-Response

I see `/update_doc` has completed with the following changes:

```
$ git diff --stat .agent/
 .agent/system/apis/new-api.md     | 85 ++++++++++++++++++++++++++++++++
 .agent/injection-history.md       | 12 +++++
 2 files changed, 97 insertions(+)
```

#### Security Scan

Running pre-commit security scan...

```
Security Scan Results
---------------------
Files scanned: 2
Patterns checked: 15
Warnings: 0
Blocks: 0

Status: ALL CLEAR
```

#### Commit Suggestion

```
docs: add new API documentation

- Create comprehensive API documentation in .agent/system/apis/
- Update injection-history.md with new documentation entry

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
```

Would you like to commit these documentation changes? [Y/n]

---

## Scenario 4: Documentation Without Code Changes

### User Request

```
@agent-git-manager: I only updated documentation, no code changes
```

### Agent Response

#### Step 1: Verify Documentation-Only Changes

```
$ git status
On branch main
Changes not staged for commit:
  modified:   .agent/sops/deployment-process.md
  modified:   .agent/system/integrations/third-party.md
  modified:   .agent/injection-history.md
```

Confirmed: Documentation-only changes (no code files modified).

#### Step 2: Security Scan

Running pre-commit security scan...

```
Security Scan Results
---------------------
Files scanned: 3
Patterns checked: 15
Warnings: 0
Blocks: 0

Status: ALL CLEAR
```

#### Step 3: Documentation Commit

**Suggested commit message:**

```
docs: update deployment process and integration docs

- Refine deployment SOP with recent learnings
- Update third-party integration documentation
- Record changes in injection-history.md

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
```

This is a documentation-only commit. No code changes included.

Shall I proceed? [Y/n]

---

## Key Takeaways

1. **Documentation awareness** - Agent detects `.agent/` changes automatically
2. **Workflow coordination** - Suggests `/update_doc` before commit when appropriate
3. **Bidirectional integration** - Works both before and after documentation updates
4. **Flexible commit options** - Can commit docs separately or with code
5. **Security applies to docs too** - All files scanned, including documentation
6. **Clean commit history** - Proper conventional commit messages for doc changes
