# Agent Memory: agent-integration-analyzer

**Last Updated**: 2026-02-20
**Patterns From**: 1 project (Talend-Reviewer)
**Total Patterns**: 2

---

## Extraction Patterns

*No patterns extracted yet.*

---

## Parsing Patterns

### PRS-001: Recycle Bin Contamination in Talend Exports
- **Pattern**: Talend workspace exports include recycle bin contents without distinction. 7 of 46 artifacts were deleted items, causing 3 false red flags in the initial assessment.
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: Filter `process/recycle_bin/`, `process/_Trash/`, and `Copy_of_*` paths before counting active artifacts in any Talend workspace export.
- **Tags**: talend, parsing

### PRS-002: Split Parsing Guides by Artifact Type
- **Pattern**: A monolithic 199-line parsing guide missed ESB structures entirely (11 gaps). Splitting into core/jobs/routes files (894 lines total) enabled independent loading and complete platform coverage.
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: Create separate parsing guide sections for each platform artifact type (DI jobs vs ESB routes vs shared components). Enable independent loading per section.
- **Tags**: talend, parsing

---

## Inventory Patterns

*No patterns extracted yet.*
