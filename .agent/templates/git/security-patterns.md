# Git Security Scanning Patterns

Pre-commit security patterns for detecting secrets, credentials, and sensitive files.

---

## File Pattern Detection

Block commits containing these file patterns:

### Environment Files
- `.env`, `.env.*`, `*.env`

### Credential Files
- `*credentials*`, `*secret*`, `*password*`

### Certificates & Keys
- `*.pem`, `*.key`, `*.p12`, `*.pfx`
- `id_rsa`, `id_ed25519`, `*.pub` (SSH keys)

### Configuration Files
- `config.json`, `secrets.json`, `auth.json`
- `.npmrc`, `.pypirc` (package manager credentials)

---

## Content Scanning Patterns

Grep staged files for these patterns:

### API Keys
- `api[_-]?key`
- `apikey`
- `api_secret`

### AWS Credentials
- `AKIA[0-9A-Z]{16}` (AWS access key ID)
- `aws_secret_access_key`

### GitHub Tokens
- `ghp_` (personal access token)
- `gho_` (OAuth token)
- `ghu_` (user-to-server token)
- `ghs_` (server-to-server token)
- `ghr_` (refresh token)

### Generic Secrets
- `password\s*=`
- `secret\s*=`
- `token\s*=`

### Private Keys
- `-----BEGIN.*PRIVATE KEY-----`

### Connection Strings
- `mysql://`
- `postgres://`
- `mongodb://`

---

## Security Report Format

Always display before commit:

```
Security Scan Results:
- Files scanned: [count]
- Patterns checked: 15
- Warnings: [count]
- Blocks: [count]
[Status: All clear / Issues found]
```

---

## Override Mechanism

If user explicitly confirms a flagged file is safe:
1. Log the override decision in your response
2. Recommend adding to `.gitignore` if appropriate
3. Proceed only with explicit user confirmation

---

**Last Updated:** 2026-02-22
**Source:** agent-git-manager optimization (Phase 4)
