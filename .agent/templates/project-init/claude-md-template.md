# CLAUDE.md Template

Use this template when creating new CLAUDE.md files during project initialization.

## Template

```markdown
# CLAUDE.md - {project_name}

## Project Overview

**Type**: {project_type}
**Purpose**: {project_goals}
**Technologies**: {key_resources}

## Project Goals

{detailed_goals}

## Constraints

{known_constraints}

## Available Agents

{list_of_provisioned_agents_with_brief_descriptions}

## Available Commands

- `/update_doc` - Update project documentation
- `/agent_reflect` - Generate project journey testimony

## Knowledge Base

Project documentation lives in `.agent/`:

```
.agent/
├── README.md                 # Knowledge base overview
├── injection-history.md      # Audit trail of all changes
{type_specific_folders}
```

### Using the Knowledge Base

1. **Before starting work**: Check injection-history.md for recent changes
2. **During work**: Reference relevant documentation in .agent/
3. **After completing work**: Update injection-history.md

---

**Initialized**: {date}
**Project Type**: {project_type}
```

## Placeholders

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `{project_name}` | User-provided project name | "Auth Patterns Research" |
| `{project_type}` | Selected type | Integration, Development, Research, Optimization |
| `{project_goals}` | Brief purpose | "Investigate OAuth patterns" |
| `{key_resources}` | Technologies involved | "OAuth 2.0, JWT, OIDC" |
| `{detailed_goals}` | Expanded goals | Full paragraph from user |
| `{known_constraints}` | Limitations | "Must support SSO" |
| `{type_specific_folders}` | Structure from folder-structures.md | See folder-structures.md |
| `{date}` | Current date | YYYY-MM-DD format |
