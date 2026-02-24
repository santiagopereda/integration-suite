# Integration Inventory: [NAME]

**Platform**: [Workato / Talend / MuleSoft / Boomi / SAP CPI]
**Analysis Date**: [DATE]
**Analyzer**: [NAME]
**Source Path**: [Path to workspace export]

---

## Overview

| Attribute | Value |
|-----------|-------|
| Platform | [Detected platform] |
| Total Jobs/Recipes | [N] |
| Source System(s) | [System names] |
| Target System(s) | [System names] |
| Pattern | [Sync/Async, Batch/Real-time, Push/Pull] |
| Trigger | [Webhook / Schedule / Event / Manual] |
| Entry Point(s) | [Root job/recipe names] |

---

## Connections

| # | System | Role | Connector Type | Protocol | Auth Method | Endpoint |
|---|--------|------|---------------|----------|-------------|----------|
| 1 | | [Source/Target/Both] | | [HTTPS/SFTP/DB/etc.] | [OAuth/API Key/Basic] | [URL/host] |

## Schemas

### Source: [Object/Entity Name]

| Field | Type | Required | Sample Value | Notes |
|-------|------|----------|-------------|-------|
| | | [Y/N] | | |

### Target: [Object/Entity Name]

| Field | Type | Required | Sample Value | Notes |
|-------|------|----------|-------------|-------|
| | | [Y/N] | | |

## Field Mappings

| # | Source Field | Transformation | Target Field | Notes |
|---|-------------|---------------|-------------|-------|
| 1 | | [Direct/Lookup/Formula/Conditional/Default] | | |

## Transformations

| # | Type | Description | Complexity | Location |
|---|------|-------------|-----------|----------|
| 1 | [Lookup/Formula/Conditional/Format/Aggregate] | [What it does] | [Low/Med/High] | [Job/recipe/step name] |

## Error Handling

| Scenario | Handler Type | Action | Location |
|----------|------------|--------|----------|
| | [Try-Catch/Retry/DLQ/Alert/Skip] | [What happens] | [Job/recipe/step] |

## Scheduling & Triggers

| Job/Recipe | Trigger | Schedule | Dependencies |
|-----------|---------|----------|-------------|
| | [Cron/Webhook/Event/Manual/Called] | [Expression or N/A] | [Upstream jobs/recipes] |

## Dependencies & Shared Resources

### Shared Components
| Resource | Type | Used By | Notes |
|----------|------|---------|-------|
| | [Lookup table/Shared schema/Sub-job/Function/Connection] | [Job/recipe names] | |

### Environment Variables / Context Variables
| Variable | Type | Default | Used By | Purpose |
|----------|------|---------|---------|---------|
| | | | | |

---

## Data Journey Map

### Execution Graph

```
Entry Point: [Root Job/Recipe]
├── Step 1: [Name] ([Source System])
│   ├── Extracts: [What data, schema]
│   └── Passes: [Variables/data] → [Next step]
├── Step 2: [Name]
│   ├── Receives: [From previous step]
│   ├── Transforms: [What transformations]
│   └── Passes: [Variables/data] → [Next step]
└── Step N: [Name] ([Target System])
    ├── Receives: [From previous step]
    └── Loads: [Target entity/table]
```

### Data Flow Through Chain

```
[Source.Entity]
  → [Extract] field1, field2, field3
    → [Transform] target_field1=..., target_field2=...
      → [Load] [Target.Entity]
        → [Result] success/error counts
```

### Variable/Context Passing

| Variable | Set By | Used By | Type | Purpose |
|----------|--------|---------|------|---------|
| | | | | |

---

## Observations & Red Flags

### Findings

| # | Category | Finding | Severity | Details |
|---|----------|---------|----------|---------|
| 1 | [Architecture/Data/Error/Security/Performance] | [What was found] | [Critical/High/Med/Low] | [Specifics] |

### Common Issues to Check
- [ ] Hardcoded values (endpoints, credentials, magic numbers)
- [ ] Missing error handling (no try-catch, no retry)
- [ ] No logging or minimal logging
- [ ] Complex transformations without documentation
- [ ] Unused components or dead code
- [ ] Circular dependencies between jobs/recipes
- [ ] No idempotency handling
- [ ] Missing timeout configuration
- [ ] Credentials in plaintext

## File Manifest

| File | Type | Size | Description |
|------|------|------|-------------|
| | [Job/Recipe/Schema/Config/Script] | [KB] | [What it contains] |
