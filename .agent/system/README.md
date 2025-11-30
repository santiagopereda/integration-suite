# System Folder - Project Structure & Knowledge Base

This folder contains comprehensive project structure, schemas, APIs, integrations, and domain-specific documentation that grows over time.

## 📋 Purpose

The System folder provides:
- **Project Structure**: How the project is organized
- **Data Schemas**: Entity models and data structures
- **APIs**: API documentation and endpoints
- **Integrations**: System integration specifications
- **Domain Knowledge**: Comprehensive docs for specific domains

## 🌱 Growth Philosophy

Unlike Tasks (which closes when done), System documentation:
- **Grows continuously** as the project evolves
- **Provides holistic context** spanning multiple PRDs
- **Links across domains** showing relationships
- **Serves as reference** for all agents
- **Updates when schema/API changes occur**

## 📁 Structure

```
system/
├── README.md                    ← This file
├── project-structure.md         ← How the project is organized
├── schemas/                     ← Data models
│   ├── businesspartner.md
│   ├── agiloft-entity.md
│   └── sync-tracking.md
├── apis/                        ← API documentation
│   ├── sap-businesspartner-api.md
│   ├── agiloft-api.md
│   └── internal-api.md
├── integrations/                ← System integrations
│   ├── sap-agiloft-integration.md
│   └── sync-mechanism.md
└── [domain]/                    ← Domain-specific docs
    ├── sap-agiloft/
    │   ├── architecture.md
    │   ├── data-mapping.md
    │   └── error-handling.md
    └── [other-domains]/
```

## 📝 What Goes in System Folder

### project-structure.md

```markdown
# Project Structure

## Overview
[High-level organization of project]

## Directory Structure
```
project/
├── src/
├── tests/
├── docs/
├── config/
└── [other-dirs]/
```

## Key Components
- [Component 1 description]
- [Component 2 description]

## Architectural Patterns
- [Pattern 1]
- [Pattern 2]

## Technology Stack
- [Technology 1]
- [Technology 2]
```

### Schemas (data-structure.md)

```markdown
# [Entity Name] Schema

## Overview
[What this entity represents]

## Fields
| Field | Type | Description | Required |
|-------|------|-------------|----------|
| field1 | string | Description | Yes |

## Relationships
- [Relationship to other entities]

## Validation Rules
- [Rules for this entity]

## Examples
[JSON example showing the structure]
```

### APIs (api-name.md)

```markdown
# [API Name] Documentation

## Overview
[What this API does]

## Authentication
[How to authenticate]

## Endpoints

### GET /endpoint
[Description]
- **Parameters**: [params]
- **Response**: [structure]

### POST /endpoint
[Description]
- **Request Body**: [structure]
- **Response**: [structure]

## Error Handling
[Common errors and codes]

## Rate Limiting
[Limits and throttling]

## Examples
[Code examples]
```

### Integrations (integration-name.md)

```markdown
# [System A] ↔ [System B] Integration

## Overview
[How systems interact]

## Architecture
[Diagrams or description]

## Data Flow
- [Flow 1]
- [Flow 2]

## Sync Mechanism
[How data is synchronized]

## Error Handling
[What happens when things fail]

## Testing
[How to test the integration]
```

### Domain Documentation (domain/file.md)

```markdown
# [Domain Name]: [Topic]

## Overview
[Comprehensive overview]

## Key Concepts
- [Concept 1]: [Explanation]
- [Concept 2]: [Explanation]

## Related Systems
[Links to related system docs]

## Integration Points
[Where this domain integrates with others]

## Known Issues & Limitations
[Gotchas for agents to avoid]
```

## 🎯 Agent Workflow

### When Starting Any Task

```
1. Read: system/project-structure.md
   └─ Understand overall organization

2. Find: Relevant schemas in system/schemas/
   └─ Understand data structures

3. Reference: Relevant APIs in system/apis/
   └─ Understand endpoints needed

4. Check: Integration docs
   └─ Understand system interactions

5. Review: Domain-specific docs if applicable
   └─ Deep-dive into specialized knowledge
```

### When Creating New Schemas

```
1. Document in: system/schemas/[entity-name].md
2. Link from: Related APIs and integrations
3. Update: injection-history.md
4. Cross-reference: From PRD that introduced it
```

### When Adding New APIs

```
1. Document in: system/apis/[api-name].md
2. Include: All endpoints, parameters, responses
3. Link to: Schemas it uses
4. Link to: Integrations that depend on it
5. Update: injection-history.md
```

### When Adding Integrations

```
1. Document in: system/integrations/[integration-name].md
2. Explain: How systems interact
3. Link to: Both systems' APIs
4. Document: Error handling and retries
5. Update: injection-history.md
```

## 🔗 Cross-References

System documentation links to:
- **PRDs** in `tasks/` (which created or modified these systems)
- **SOPs** in `sops/` (which describe how to work with these)
- **Other System Docs** (showing relationships)

Example: `sap-businesspartner-api.md` links to:
- `tasks/businesspartner-integration/prd.md` (PRD that required this API)
- `schemas/businesspartner.md` (data structure it uses)
- `integrations/sap-agiloft-integration.md` (integration that depends on it)
- `sops/integration/integrate-external-api.md` (SOP for integrating APIs)

## 📊 Current System Documentation

### Project Structure
- [ ] `project-structure.md` - To be created

### Schemas
- [ ] `schemas/` folder - To be created with first schema

### APIs
- [ ] `apis/` folder - To be created with first API

### Integrations
- [ ] `integrations/` folder - To be created with first integration

### Domains
- [ ] `sap-agiloft/` folder - To be created when SAP-Agiloft work begins
- [ ] Other domains - Will grow as needed

## ✅ Quality Standards

### For All Documentation

✅ **Include**:
- Clear overview
- Complete details
- Practical examples
- Links to related docs
- Validation/error info

❌ **Avoid**:
- Vague descriptions
- Incomplete information
- No examples
- Isolated (no links)
- Outdated information

### Updating Documentation

- Update when schemas/APIs change
- Update links if documents are reorganized
- Add notes about version changes
- Keep examples current

## 🔄 Maintenance Schedule

### When PRD Creates New System Elements

```
PRD for Feature X:
├─ Creates Schema
│  └─ Document in system/schemas/
├─ Uses/Creates API
│  └─ Document in system/apis/
├─ Integrates Systems
│  └─ Document in system/integrations/
└─ Deep domain work
   └─ Document in system/[domain]/
```

### Regular Review

- Monthly: Review for accuracy
- Quarterly: Update examples
- When APIs change: Update immediately
- When schemas change: Update immediately

## 📞 Quick Links

- **Knowledge Base Home**: `../ (README.md)`
- **Project Tasks**: `../tasks/`
- **Standard Procedures**: `../sops/`
- **Injection History**: `../injection-history.md`

## 🎓 Best Practices

### Discovering Existing Documentation

```
Agent Task: "I need to understand [system/concept]"

1. Check: system/project-structure.md
2. Search: system/ folder for relevant docs
3. Check: Related PRDs in tasks/
4. Read: Links provided in relevant docs
5. If missing: Document what you learn
```

### Keeping Documentation Current

```
After working on a system:

1. Update: Relevant system docs
2. Add: New insights discovered
3. Link: Related documents
4. Update: injection-history.md
```

### Using Documentation for Implementation

```
Before starting code:

1. Read: Relevant schema docs
2. Review: API documentation
3. Check: Integration patterns
4. Understand: Data flow
5. Start: With full context
```

## 📈 Growth Expected

**Starting**: Empty (3 subfolders ready)
**Month 1**: Project structure, initial schemas, API docs
**Month 2**: Integration documentation, domain-specific docs
**Month 3+**: Comprehensive system knowledge base

The system folder will become the central reference for all agents and team members.

---

**Folder Purpose**: Comprehensive project knowledge base growing with the project
**Current Status**: Structure ready, awaiting first documentation
**Version**: 1.0.0
**Last Updated**: 2025-11-21

Ready to grow with your project!
