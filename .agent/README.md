# Knowledge Base - Agent Context & Documentation

This directory contains all relevant information that agents need to understand project context, execute tasks consistently, and maintain quality standards.

## 📚 Overview

The knowledge base is organized into three primary sections:

1. **Tasks** - Product Requirements and Implementation Plans
2. **System** - Project Structure, Schemas, and APIs
3. **SOPs** - Standard Operating Procedures for common processes

Each section serves a specific purpose in supporting agent decision-making and execution.

---

## 📂 Directory Structure

```
.claude/knowledge/
├── README.md                    ← This file (navigation & overview)
├── injection-history.md         ← What's been added and when
│
├── tasks/                       ← PRDs & Implementation Plans
│   ├── README.md               ← Task folder guide
│   └── [prd-name]/
│       ├── prd.md              ← Product Requirements Document
│       └── implementation-plan.md  ← Implementation plan generated before coding
│
├── system/                      ← Project Structure & Knowledge Base
│   ├── README.md               ← System folder guide
│   ├── project-structure.md    ← Overall project organization
│   ├── schemas/                ← Data models and structures
│   ├── apis/                   ← API documentation
│   ├── integrations/           ← Integration documentation
│   └── [domain]/               ← Domain-specific documentation
│
└── sops/                        ← Standard Operating Procedures
    ├── README.md               ← SOP folder guide
    ├── templates/              ← SOP templates
    ├── [category]/             ← Organized by task category
    │   ├── sop-template.md
    │   └── [specific-sop].md
    └── common-mistakes.md      ← Log of agent mistakes & fixes
```

---

## 🎯 Purpose of Each Section

### Tasks Folder (`/tasks`)

**Purpose**: Store all PRDs and implementation plans for features/work items

**When to Use**:
- Starting a new feature or major task
- Need context on what's being built and why
- Creating consistency across similar tasks

**Content**:
- Product Requirements Documents (PRDs)
- Implementation plans (created before coding)
- User stories and acceptance criteria
- Design decisions and rationale

**Example Structure**:
```
tasks/
├── businesspartner-integration/
│   ├── prd.md                 ← What needs to be built
│   └── implementation-plan.md ← How to build it
├── sap-agiloft-sync/
│   ├── prd.md
│   └── implementation-plan.md
└── reporting-dashboard/
    ├── prd.md
    └── implementation-plan.md
```

**Agent Workflow**:
1. **Before Implementation**: Turn on plan mode and create implementation plan
2. **Store**: Save plan to `tasks/[feature-name]/implementation-plan.md`
3. **Reference**: Future implementations reference these plans
4. **Update**: Update when requirements change

---

### System Folder (`/system`)

**Purpose**: Centralized knowledge base for project structure, APIs, schemas, integrations

**When to Use**:
- Understanding project architecture
- Working with specific systems or APIs
- Need comprehensive project context
- Integrating with external systems

**Content**:
- Project structure and organization
- Data schemas and models
- API documentation and endpoints
- Integration specifications
- Domain-specific documentation

**Grows Over Time**:
- Starts with basic structure
- Expands as features are added
- Links span across multiple PRDs
- Provides holistic project understanding

**Example Subfolders**:
```
system/
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
└── sap-agiloft/                ← Domain-specific docs
    ├── architecture.md
    ├── data-mapping.md
    └── error-handling.md
```

**Usage Pattern**:
- New agents review `project-structure.md` for overview
- Deep-dive into specific `system/[domain]/` for details
- Reference APIs when implementing integrations
- Cross-reference with PRDs in `tasks/`

---

### SOPs Folder (`/sops`)

**Purpose**: Standardized procedures ensuring consistency in agent work

**When to Use**:
- Performing routine tasks
- Implementing similar features
- Need to avoid common mistakes
- Training new agents on processes

**Content**:
- Step-by-step procedures for common tasks
- Templates for standard work
- Common mistakes and how to avoid them
- Checklists and validation steps
- Best practices and lessons learned

**Generated After Tasks**:
After completing a task:
1. Ask the implementing agent to generate an SOP
2. Document the process for future use
3. Log any common mistakes discovered
4. Include validation and quality checks

**Example Structure**:
```
sops/
├── templates/
│   ├── sop-template.md          ← Blank SOP template
│   └── implementation-checklist.md
│
├── database/
│   ├── add-new-table.md         ← "How to add database table"
│   ├── add-migration.md         ← "How to create migration"
│   └── common-mistakes.md       ← Mistakes in DB work
│
├── integration/
│   ├── integrate-external-api.md
│   ├── create-sync-flow.md
│   └── error-handling.md
│
├── documentation/
│   ├── write-api-docs.md
│   ├── create-prd.md
│   └── generate-implementation-plan.md
│
└── common-mistakes.md           ← Master log of all agent mistakes
```

**Common Mistake Tracking**:
```markdown
## Common Mistakes Log

### [Task Category]: [Specific Mistake]
**Agent**: [Who made it]
**Date**: [When]
**Mistake**: [What went wrong]
**Impact**: [How it affected work]
**Prevention**: [How to avoid it]
**SOP Updated**: [Yes/No]

Example:
### Database: Not creating index on foreign keys
**Agent**: integration-agent
**Date**: 2025-11-15
**Mistake**: Added new table without indexing FK columns
**Impact**: Query performance degraded by 60%
**Prevention**: Always add indexes to FK columns in SOP
**SOP Updated**: Yes (add-new-table.md updated)
```

---

## 📝 Injection History

The `injection-history.md` file logs all documentation added to the knowledge base:

```markdown
## Knowledge Base Injection History

### [Date] - [Type]: [Description]
- **Added By**: [Agent/User]
- **Location**: `.claude/knowledge/[path]`
- **Purpose**: [Why this was added]
- **Links**: [Cross-references to related docs]
- **Status**: [Draft/Complete/Validated]

Example:
### 2025-11-21 - PRD: BusinessPartner Integration Feature
- **Added By**: User
- **Location**: `.claude/knowledge/tasks/businesspartner-integration/prd.md`
- **Purpose**: Define requirements for SAP-Agiloft BusinessPartner sync
- **Links**: Relates to System > Integrations > SAP-Agiloft
- **Status**: Complete
```

---

## 🔄 Workflow Integration

### Creating a New Feature

```
1. Write PRD
   └─ Store in: tasks/[feature-name]/prd.md

2. Turn on Plan Mode
   └─ Create implementation plan
   └─ Store in: tasks/[feature-name]/implementation-plan.md

3. Implementation
   └─ Reference PRD and plan
   └─ Add to system/ if it creates new schemas/APIs

4. After Completion
   └─ Generate SOP for the process
   └─ Store in: sops/[category]/[process].md
   └─ Log any mistakes discovered
   └─ Update common-mistakes.md

5. Update Injection History
   └─ Log all new docs added
```

### Using Knowledge for Tasks

```
Agent Starting New Task:
1. Read: .claude/knowledge/README.md (this file)
2. Review: .claude/knowledge/tasks/[related-feature]/prd.md
3. Reference: .claude/knowledge/system/[domain]/
4. Check: .claude/knowledge/sops/[category]/common-mistakes.md
5. Execute: Using knowledge as context
6. Validate: Against applicable SOPs
```

---

## 📋 How Agents Use This Knowledge

### When Starting a Task

```
Agent checks:
✓ tasks/ for PRD and implementation plan
✓ system/ for project context and schemas
✓ sops/ for standard procedures
✓ common-mistakes.md to avoid known issues
```

### During Implementation

```
Agent references:
✓ System schemas for data structure
✓ API docs for integration details
✓ SOPs for standard processes
✓ Implementation plan for sequence
```

### After Completion

```
Agent creates:
✓ SOP for the process completed
✓ Updates common-mistakes.md if issues found
✓ Links PRD to system docs if new systems added
✓ Updates injection-history.md
```

---

## 🔗 Integration with Agent System

This knowledge base is referenced by:

**In `.claude/agents/`**:
- Agents load relevant knowledge when invoked
- System prompt references applicable SOPs
- Context includes related PRDs and plans

**In `CLAUDE.md`**:
- Lists knowledge base as context for agents
- References SOPs for consistency
- Links to task PRDs for feature work

**In Main `README.md`**:
- Describes knowledge base structure
- Explains how to contribute
- Links to key documents

---

## 📖 Documentation Standards

### PRD Format

```markdown
# [Feature Name] - PRD

## Overview
[What is being built and why]

## Objectives
- [Objective 1]
- [Objective 2]

## User Stories
- [As a user, I want... so that...]
- [As a developer, I want... so that...]

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Scope & Constraints
- [In scope]
- [Out of scope]

## Success Metrics
- [How success is measured]
```

### SOP Format

```markdown
# SOP: [Process Name]

## Overview
[Brief description]

## When to Use
[Circumstances for using this SOP]

## Prerequisites
- [Requirement 1]
- [Requirement 2]

## Step-by-Step Procedure
1. [Step 1]
   - [Details]
   - [Validation]
2. [Step 2]

## Common Mistakes
- [Mistake 1]: [How to avoid]
- [Mistake 2]: [How to avoid]

## Validation Checklist
- [ ] Check 1
- [ ] Check 2

## Related SOPs
- [Link to related SOP]
```

### Implementation Plan Format

```markdown
# Implementation Plan: [Feature Name]

## Overview
[Brief summary]

## Approach
[High-level strategy]

## Detailed Steps
1. [Step 1]: [Details, files, APIs]
2. [Step 2]: [Details, files, APIs]

## Dependencies
- [Dependency 1]
- [Dependency 2]

## Testing Strategy
[How to validate]

## Risks & Mitigation
- [Risk 1]: [Mitigation]

## Timeline
[Expected duration]
```

---

## ✨ Best Practices

### For Adding Knowledge

✅ **Do**:
- Add documentation immediately after completing work
- Link new docs to existing related documentation
- Use consistent formatting and structure
- Update injection history with each addition
- Include practical examples
- Document common mistakes discovered

❌ **Don't**:
- Add incomplete or vague documentation
- Duplicate information already documented
- Create docs without linking to related content
- Forget to update common-mistakes.md
- Leave injection history outdated

### For Using Knowledge

✅ **Do**:
- Read relevant docs before starting work
- Reference SOPs for consistency
- Follow established procedures
- Update docs if you discover new information
- Link PRDs to system documentation

❌ **Don't**:
- Ignore existing SOPs
- Skip reading relevant PRDs
- Create custom processes without documenting
- Forget to log mistakes learned
- Leave incomplete or outdated documentation

---

## 🚀 Getting Started

### For New Users/Agents

1. **Read this README** (you are here)
2. **Review** `.claude/knowledge/system/project-structure.md` for overview
3. **Check** `.claude/knowledge/tasks/` for active features
4. **Explore** `.claude/knowledge/sops/` for standard procedures
5. **Reference** `injection-history.md` to see what's available

### For Adding Knowledge

1. **Create** folder under appropriate section (tasks/, system/, or sops/)
2. **Write** documentation using provided templates
3. **Link** to related documents
4. **Update** `injection-history.md`
5. **Validate** using standards above

---

## 📞 Navigation & Quick Links

| Need | Location |
|------|----------|
| **Feature requirements** | `tasks/[feature-name]/prd.md` |
| **Implementation steps** | `tasks/[feature-name]/implementation-plan.md` |
| **Project structure** | `system/project-structure.md` |
| **API documentation** | `system/apis/` |
| **Data schemas** | `system/schemas/` |
| **How to do X task** | `sops/[category]/[task].md` |
| **Common mistakes** | `sops/common-mistakes.md` |
| **What's been added** | `injection-history.md` |

---

## 📊 Knowledge Base Statistics

| Section | Purpose | Growth |
|---------|---------|--------|
| **Tasks** | PRDs & Plans | Grows with new features |
| **System** | Project Knowledge | Grows as project evolves |
| **SOPs** | Process Standards | Grows after each task |
| **History** | Audit Trail | Updated with each addition |

---

**Current Status**: Knowledge base structure initialized
**Last Updated**: 2025-11-21
**Maintained By**: Knowledge Management System
**Version**: 1.0.0

This knowledge base is designed to grow and evolve with your project. Add to it regularly, keep it current, and reference it consistently for optimal agent effectiveness.
