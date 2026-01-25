# .agent/README.md Template

Use this template when creating the knowledge base README.

## Template

```markdown
# Knowledge Base - {project_name}

This directory contains project documentation and context for agent-assisted development.

## Structure

```
.agent/
├── README.md                 # This file
├── injection-history.md      # Audit trail of all changes
{type_specific_structure}
```

## Quick Reference

| Need | Location |
|------|----------|
| What changed recently | `injection-history.md` |
{type_specific_references}

## Adding Documentation

After completing work:
1. Document what was done
2. Add entry to `injection-history.md`

---

**Initialized**: {date}
**Project Type**: {project_type}
```

## Type-Specific References

### Integration Projects
```markdown
| Standard procedures | `sops/` |
| System schemas & APIs | `system/` |
| Integration flows | `workflows/` |
```

### Development Projects
```markdown
| Architecture decisions | `decisions/` |
| Data models | `schemas/` |
| Test strategies | `testing/` |
```

### Research Projects
```markdown
| Discoveries | `findings/` |
| Assumptions | `hypotheses/` |
| Unknown areas | `gaps/` |
```

### Optimization Projects
```markdown
| External content | `templates/` |
| Measurements | `metrics/` |
| Trials | `experiments/` |
```
