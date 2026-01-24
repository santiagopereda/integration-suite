# Registry Entry Templates

## CLAUDE.md Entry Format

```markdown
### {agent-name} (v1.0.0) - Production

**ID**: `{agent-name}`

**Purpose**: {extracted from description}

**Use When**:
- {extracted from examples/triggers}

**Location**: `.claude/agents/{agent-name}.md`

**Invoke With**:
\`\`\`bash
@{agent-name}: [Your request]
\`\`\`
```

## AGENTS_REGISTRY.md Quick Reference Row

```markdown
| `{agent-name}` | {Short Name} | {Domain} | Production | {Brief trigger description} |
```

## AGENTS_REGISTRY.md Detailed Section

```markdown
### N. {agent-name}

**Status**: Production Ready (v1.0.0)

**Category**: {Domain}

**Description**:
{Full description from agent file}

**Location**: `.claude/agents/{agent-name}.md`

**Key Expertise**:
- {Extracted from expertise section}

**Trigger Conditions**:
- {Extracted from examples}

**Example Usage**:
\`\`\`bash
@{agent-name}: {example request}
\`\`\`
```
