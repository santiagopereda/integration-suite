# Example: Security Scan Blocking Secrets

This example demonstrates how the security scan detects and blocks commits containing sensitive data.

## Scenario

Developer accidentally stages files containing secrets and API keys.

## User Request

```
@agent-git-manager: Commit all my changes
```

## Agent Response

### Step 1: Repository Status

```
$ git status
On branch feature/api-integration
Changes to be committed:
  modified:   src/api/client.ts
  new file:   src/config/settings.ts
  new file:   .env.local

Changes not staged:
  modified:   README.md
```

### Step 2: Security Scan

Running pre-commit security scan...

**File Pattern Check**:
```
[BLOCK] .env.local - Environment file detected
        This file type commonly contains secrets.
        Action: Remove from staging or add to .gitignore
```

**Content Scan**:
```
Scanning src/api/client.ts...
[WARNING] Line 15: Possible API key detected
          Pattern: api_key = "sk-proj-abc123..."

Scanning src/config/settings.ts...
[WARNING] Line 8: Possible AWS credential detected
          Pattern: AWS_SECRET_ACCESS_KEY = "wJalr..."
[WARNING] Line 12: Database connection string detected
          Pattern: mongodb://admin:password123@...
```

### Step 3: Security Report

```
SECURITY SCAN RESULTS
=====================

BLOCKED FILES (1):
  .env.local
    Reason: Environment files commonly contain secrets
    Action: git reset .env.local && echo ".env.local" >> .gitignore

WARNINGS (3):
  src/api/client.ts:15
    Pattern: API key (sk-proj-...)
    Risk: API key exposure could allow unauthorized access

  src/config/settings.ts:8
    Pattern: AWS secret access key
    Risk: AWS credential exposure could lead to account compromise

  src/config/settings.ts:12
    Pattern: Database connection string with password
    Risk: Database credentials exposure

Status: COMMIT BLOCKED
```

### Step 4: Remediation Guidance

**Cannot proceed with commit.** Please address the following:

**1. Remove .env.local from staging:**
```bash
git reset .env.local
echo ".env.local" >> .gitignore
```

**2. Review flagged content:**

For `src/api/client.ts:15`:
- Consider using environment variables: `process.env.API_KEY`
- Or use a secrets manager

For `src/config/settings.ts:8-12`:
- Move credentials to environment variables
- Use AWS credential provider chain
- Use connection string from environment

**3. Best practices:**
- Never commit secrets to version control
- Use `.env` files locally but add to `.gitignore`
- Use secret managers (AWS Secrets Manager, HashiCorp Vault, etc.)
- Consider using git-secrets or similar pre-commit hooks

After addressing these issues, run the commit again.

---

## User Response (After Fixing)

```
User: I've moved the secrets to environment variables and removed .env.local. Try again.
```

## Agent Re-runs

### Security Scan (Retry)

```
$ git status
On branch feature/api-integration
Changes to be committed:
  modified:   src/api/client.ts
  modified:   src/config/settings.ts
  modified:   .gitignore

$ git diff src/api/client.ts
-  api_key = "sk-proj-abc123..."
+  api_key = process.env.API_KEY

$ git diff src/config/settings.ts
-  AWS_SECRET_ACCESS_KEY = "wJalr..."
+  // Credentials loaded from environment
-  mongodb://admin:password123@...
+  process.env.MONGODB_URI
```

Running pre-commit security scan...

**File Pattern Check**:
- [PASS] No sensitive file patterns detected

**Content Scan**:
- Scanning src/api/client.ts... [PASS]
- Scanning src/config/settings.ts... [PASS]
- Scanning .gitignore... [PASS]

```
Security Scan Results
---------------------
Files scanned: 3
Patterns checked: 15
Warnings: 0
Blocks: 0

Status: ALL CLEAR
```

### Commit Message Suggestion

```
refactor(config): move secrets to environment variables

- Remove hardcoded API key from client.ts
- Remove AWS credentials from settings.ts
- Remove database connection string from settings.ts
- Add .env.local to .gitignore

Security: Credentials now loaded from environment variables

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
```

Shall I proceed with this commit? [Y/n]

---

## Override Example

If the user insists a flagged file is safe:

```
User: The config.json file is actually a template with placeholder values, not real secrets. Please proceed.
```

### Agent Override Flow

I understand you've confirmed that `config.json` contains only placeholder values.

**Override acknowledgment:**
- File: config.json
- User confirmation: Template with placeholders only
- Recommendation: Consider renaming to `config.template.json` or `config.example.json` to clarify intent

**Proceeding with commit** based on your explicit confirmation.

Note: If this file should never contain real values, consider:
1. Adding a comment at the top explaining it's a template
2. Renaming to `.template` or `.example` suffix
3. Creating a `.gitignore` entry for the actual config file

---

## Key Takeaways

1. **Security scan blocks dangerous patterns** - Prevents accidental secret exposure
2. **Clear remediation guidance** - Tells user exactly how to fix issues
3. **Override requires explicit confirmation** - User must acknowledge risk
4. **Best practices shared** - Educates on proper secrets management
5. **Re-scan after fixes** - Verifies issues are resolved
