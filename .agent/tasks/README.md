# Tasks Folder - PRDs & Implementation Plans

This folder stores all Product Requirements Documents (PRDs) and Implementation Plans for features and work items.

## 📋 Purpose

The Tasks folder provides:
- **PRDs**: What needs to be built and why
- **Implementation Plans**: How to build it step-by-step
- **User Stories**: What users need
- **Acceptance Criteria**: Definition of done
- **Design Decisions**: Rationale for choices

## 📁 Structure

Each feature/task gets its own subfolder:

```
tasks/
├── feature-one/
│   ├── prd.md                 ← Product Requirements Document
│   └── implementation-plan.md ← Step-by-step implementation guide
├── feature-two/
│   ├── prd.md
│   └── implementation-plan.md
└── [other-features]/
```

## 📝 Creating a New Task

### Step 1: Create PRD

```markdown
# [Feature Name] - PRD

## Overview
[What is being built and why]

## Objectives
- [Objective 1]
- [Objective 2]

## User Stories
- As a [user type], I want [feature] so that [benefit]

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2

## Scope
- **In Scope**: [What's included]
- **Out of Scope**: [What's excluded]

## Success Metrics
- [How to measure success]

## Dependencies
- [What this depends on]

## References
- [Links to related documentation]
```

### Step 2: Create Implementation Plan

Before starting implementation:
1. Turn on plan mode
2. Create comprehensive implementation plan
3. Store in `implementation-plan.md`

```markdown
# Implementation Plan: [Feature Name]

## Overview
[Brief summary of what's being built]

## Approach
[High-level strategy]

## Detailed Steps
1. [Step 1 with specific details]
   - Files: [Files to create/modify]
   - APIs: [APIs to call]
   - Data: [Data structures involved]

2. [Step 2 with specific details]

## Dependencies
- [What must be done first]

## Testing Strategy
[How to validate work]

## Risks & Mitigation
- [Risk 1]: [How to mitigate]

## Timeline
[Expected duration]

## Sign-Off
[When complete, mark as done]
```

### Step 3: Log in Injection History

Update `.agent/injection-history.md`:

```markdown
### [Date] - PRD: [Feature Name]
- **Added By**: [Your name]
- **Location**: `.agent/tasks/[feature-name]/prd.md`
- **Purpose**: [Why this feature is needed]
- **Links**: Related to [other docs]
- **Status**: Complete

### [Date] - Implementation Plan: [Feature Name]
- **Added By**: [Agent/Your name]
- **Location**: `.agent/tasks/[feature-name]/implementation-plan.md`
- **Purpose**: [Step-by-step implementation guide]
- **Links**: Implements PRD at tasks/[feature-name]/prd.md
- **Status**: Complete
```

## 🔗 Linking to Other Documentation

### In PRD, link to:
- Related features in `tasks/`
- System documentation in `system/`
- Related SOPs in `sops/`

### In Implementation Plan, link to:
- APIs in `system/apis/`
- Schemas in `system/schemas/`
- Relevant SOPs in `sops/`
- The PRD being implemented

## 🎯 Agent Workflow

### When Starting Implementation

```
1. Read PRD
   └─ Understand requirements

2. Review Implementation Plan
   └─ Understand step-by-step approach

3. Reference System Documentation
   └─ APIs, schemas, integrations

4. Check Relevant SOPs
   └─ Follow standard procedures

5. Execute Plan
   └─ Update injection-history when done
```

### After Completing Task

```
1. Create SOP for the process
   └─ Store in sops/[category]/[process].md

2. Log any mistakes discovered
   └─ Add to sops/common-mistakes.md

3. Update task status
   └─ Mark as "Completed" in injection-history.md

4. Link to new system docs
   └─ If new APIs, schemas, or integrations were created
```

## 📋 Task Template Files

### Basic PRD Template

See `tasks/prd-template.md` (to be created with first task)

### Implementation Plan Template

See `tasks/implementation-plan-template.md` (to be created with first task)

## 📊 Current Tasks

| Task | Status | PRD | Plan |
|------|--------|-----|------|
| (None yet) | — | — | — |

## 🚀 How Agents Use This Folder

### Scenario 1: New Feature Development
```
Agent:
1. Reads: tasks/[feature]/prd.md
2. Reads: tasks/[feature]/implementation-plan.md
3. References: system/ and sops/ folders
4. Implements: According to plan
5. Logs: Completion and any SOPs created
```

### Scenario 2: Understanding Project
```
Agent:
1. Lists: All folders in tasks/
2. Reads: PRDs to understand features
3. Skims: Implementation plans for context
4. Understands: Complete project scope
```

### Scenario 3: Finding Similar Work
```
Agent:
1. Searches: Task names for similar features
2. Reads: PRD and implementation plan
3. References: SOPs that were created for similar work
4. Applies: Lessons learned to current task
```

## ✅ Quality Standards

### For PRDs

✅ **Include**:
- Clear overview and objectives
- Specific user stories
- Measurable acceptance criteria
- Identified dependencies
- Success metrics

❌ **Avoid**:
- Vague requirements
- Implementation details (that's the plan's job)
- Untested assumptions
- Missing acceptance criteria

### For Implementation Plans

✅ **Include**:
- Step-by-step procedures
- Specific file/API references
- Data structure details
- Testing approach
- Risk identification

❌ **Avoid**:
- Vague steps
- Missing dependencies
- No testing strategy
- Unidentified risks
- Incomplete coverage

## 🔄 Maintenance

### Updating Tasks

If requirements change:
1. Update PRD
2. Update Implementation Plan accordingly
3. Note change in injection-history.md

### Completing Tasks

When a task is done:
1. Mark as "Completed" in injection-history.md
2. Create SOP if not already created
3. Link to new system documentation created
4. Archive if not needed for reference

## 📞 Quick Links

- **Knowledge Base Home**: `../ (README.md)`
- **Injection History**: `../injection-history.md`
- **System Documentation**: `../system/`
- **SOPs**: `../sops/`

---

**Folder Purpose**: Store all PRDs and implementation plans
**Current Status**: Empty - Ready for first feature
**Version**: 1.0.0
**Last Updated**: 2025-11-21

Start by creating your first PRD and implementation plan!
