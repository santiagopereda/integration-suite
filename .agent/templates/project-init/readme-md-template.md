# README.md Template

Use this template when creating new project README.md files.

## Template

```markdown
# {project_name}

{project_goals}

## Quick Start

[To be filled based on project type]

## Project Structure

```
{project_name}/
├── .agent/                   # Agent knowledge base
├── .claude/                  # Agent and command definitions
│   ├── agents/
│   └── commands/
├── CLAUDE.md                 # Project configuration
└── README.md                 # This file
```

## Documentation

- **Knowledge Base**: See `.agent/README.md`
- **Agent Configuration**: See `CLAUDE.md`

---

**Created**: {date}
```

## Placeholders

| Placeholder | Description |
|-------------|-------------|
| `{project_name}` | User-provided project name |
| `{project_goals}` | Brief purpose description |
| `{date}` | Current date (YYYY-MM-DD) |
