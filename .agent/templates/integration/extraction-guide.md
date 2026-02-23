# Integration Code Extraction Guide

What to extract from any integration platform export. Platform-specific parsing instructions are in `platform-parsers/`.

## Universal Extraction Checklist

Regardless of platform, extract these categories:

### 1. Connections
- Source/target system names and types
- Connector/adapter types used
- Protocol (HTTPS, SFTP, JDBC, OData, etc.)
- Authentication method (OAuth, API Key, Basic Auth, Certificate)
- Endpoints/URLs (note if hardcoded vs. configured)

### 2. Schemas
- Input/output field definitions (name, type, required flag)
- Nested/hierarchical structures
- Array/collection fields
- Reference data fields (lookups, enums)

### 3. Field Mappings
- Source-to-target field mapping (1:1, 1:many, many:1)
- Transformation type per mapping (direct, lookup, formula, conditional, default)
- Mapping direction (one-way, bi-directional)

### 4. Transformations
- Data type conversions
- String operations (concat, substring, trim, case change)
- Lookup operations (reference tables, cross-reference)
- Conditional logic (if/else, switch)
- Aggregations (sum, count, group by)
- Date/time formatting
- Custom functions/scripts

### 5. Flow Logic
- Execution sequence (step order)
- Branching/conditional routing
- Loops/iterations
- Parallel processing
- Sub-job/sub-recipe calls

### 6. Error Handling
- Try-catch blocks
- Retry configuration (count, interval, backoff)
- Error routing (DLQ, error handler, skip)
- Alert/notification on failure
- Compensation/rollback logic

### 7. Triggers & Scheduling
- Trigger type (cron, webhook, event, manual, API)
- Schedule expressions
- Polling intervals
- Event sources

### 8. Dependencies
- Inter-job/inter-recipe calls (the call graph)
- Shared resources (connections, schemas, lookup tables)
- Environment/context variables passed between jobs
- External dependencies (APIs, databases, file systems)

### 9. Metadata
- Job/recipe name, description, version
- Author, last modified date
- Tags/categories
- Status (active, inactive, draft)

## Platform Detection

Auto-detect platform from file structure:

| Platform | Key Indicators |
|----------|---------------|
| **Workato** | `.json` recipe files with `"adapter"` and `"action"` keys |
| **Talend** | `.item` files, `talend.properties`, `/process/` directory |
| **MuleSoft** | `mule-artifact.json`, `.xml` with `<mule>` root, `.dwl` files |
| **Boomi** | `*.xml` with `<bns:Component>`, `/process/` with Boomi schemas |
| **SAP CPI** | `META-INF/MANIFEST.MF` with `SAP`, `*.iflw` files |

## Analysis Strategy

1. **Glob first**: Find all relevant files by extension and naming pattern
2. **Read manifest/config**: Start with main config file for overview
3. **Parse entry points**: Identify root jobs/recipes (not called by others)
4. **Trace call graph**: Follow inter-job references (tRunJob, Call recipe, flow-ref)
5. **Extract per component**: Parse each job/recipe for schemas, mappings, transforms
6. **Build journey**: Assemble the complete data flow from entry to exit
7. **Flag issues**: Note anti-patterns, hardcoded values, missing error handling
