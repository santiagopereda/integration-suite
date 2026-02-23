# Customer Documentation Channel Rules

Rules for adapting brand voice to technical documentation, user guides, and knowledge bases.

## Platform Characteristics

- Reference material accessed when users need help or are learning
- Must be searchable, scannable, and task-oriented
- Includes: user guides, API docs, tutorials, FAQs, release notes, knowledge base
- Accessed via docs site, in-app help, or search engines
- Versioned alongside product releases
- Users arrive with a specific question or task to accomplish

## Audience Expectations

- **Primary**: Users trying to accomplish a specific task or solve a problem
- **Mindset**: Goal-oriented, often frustrated; want answers fast
- **Tolerance**: Zero tolerance for marketing speak or vague language; high for precision
- **Engagement**: Expect accuracy, completeness, working examples, and clear structure

## Tone Guidelines

| Dimension | Setting | Notes |
|-----------|:-------:|-------|
| Formality | 3-4/5 | Professional and precise; not academic or stiff |
| Energy | 2/5 | Calm, steady, reassuring |
| Warmth | 3/5 | Helpful and respectful; not robotic |
| Authority | 5/5 | Definitive — users trust docs to be correct |

**Tone shifts by content type**:
- Tutorial / getting started: Warmth +1, encouraging tone
- API reference: Formality +1, maximally precise
- Troubleshooting: Warmth +1, empathetic ("If you see this error...")
- Release notes: Energy +1, highlight what's new and why it matters

## Format Constraints

### Document Structure
1. **Title**: Clear, task-oriented (e.g., "Configure SSL Certificates" not "SSL Guide")
2. **Overview**: 1-2 sentences — what this page covers and who it's for
3. **Prerequisites**: What the reader needs before starting
4. **Steps / Content**: Numbered steps for procedures; sections for concepts
5. **Examples**: Working code/config examples for every non-trivial step
6. **Related topics**: Links to next steps and related documentation

### Formatting Rules
- **Headings**: Task-oriented verb phrases ("Install the CLI", "Configure Authentication")
- **Steps**: Numbered for procedures; each step = one action
- **Code blocks**: Language-tagged; copy-pasteable; tested and verified
- **Callouts**: Use admonitions consistently:
  - **Note**: Supplementary information
  - **Tip**: Helpful shortcut or best practice
  - **Warning**: Could cause problems if ignored
  - **Caution**: Could cause data loss or security issues
- **Tables**: For parameter references, configuration options, comparison
- **Links**: Descriptive link text (never "click here")
- **Screenshots**: Annotated with callouts; updated with each UI change

### Writing Rules
- **Active voice**: "Configure the server" not "The server should be configured"
- **Present tense**: "The command returns..." not "The command will return..."
- **Second person**: "You can configure..." not "Users can configure..."
- **Imperative mood for steps**: "Run the command" not "You should run the command"
- **Consistent terminology**: One term per concept; define in a glossary
- **No assumptions**: State the OS, version, and context explicitly

## Best Practices

- **Task-first organization** — structure around what users do, not how the product is built
- **Working examples for everything** — every endpoint, every config option, every workflow
- **Progressive disclosure** — basic usage first, advanced options later
- **Test every example** — code samples must be verified against the current version
- **Version your docs** — users on older versions need docs that match their reality
- **Provide copy-paste commands** — include the full command, not just the flag
- **Error message coverage** — document every user-facing error with cause and resolution
- **Minimize time-to-success** — the shortest path from "I need to do X" to "X is done"

## Examples

### Good Procedure
```markdown
## Install the CLI

### Prerequisites
- Python 3.9 or later
- pip package manager

### Steps

1. Install the package:

   ```bash
   pip install mytools-cli
   ```

2. Verify the installation:

   ```bash
   mytools --version
   ```

   Expected output: `mytools v2.4.1`

3. Authenticate with your API key:

   ```bash
   mytools auth login --key YOUR_API_KEY
   ```

> **Tip**: Store your API key in an environment variable to avoid
> passing it with every command. See [Authentication Guide](./auth.md).
```

### Bad Procedure
```markdown
## Getting Started

To get started, you'll want to install our amazing tool. It's super easy!
Just use pip or whatever package manager you prefer. Once installed,
you should be able to run it. If you have any issues, reach out to support.
```

### Good API Reference Entry
```markdown
## Create User

`POST /api/v1/users`

Creates a new user account.

### Request Body

| Field | Type | Required | Description |
|-------|------|:--------:|-------------|
| `email` | string | Yes | Valid email address |
| `name` | string | Yes | Display name (2-100 chars) |
| `role` | string | No | One of: `admin`, `member`, `viewer`. Default: `member` |

### Example

```json
{
  "email": "alice@example.com",
  "name": "Alice Chen",
  "role": "admin"
}
```

### Response

`201 Created`

```json
{
  "id": "usr_abc123",
  "email": "alice@example.com",
  "name": "Alice Chen",
  "role": "admin",
  "created_at": "2026-02-23T10:00:00Z"
}
```

### Errors

| Status | Code | Description |
|--------|------|-------------|
| 400 | `invalid_email` | Email format is invalid |
| 409 | `email_exists` | Account with this email already exists |
```
