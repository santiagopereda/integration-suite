# Workato Recipe Parsing Guide

## File Structure

Workato exports recipes as JSON files. Key structure:

```
export/
├── recipes/
│   ├── recipe_name.json          # Recipe definition
│   └── recipe_name_2.json
├── connections/
│   └── connection_name.json      # Connection configs (auth details redacted)
├── lookup_tables/
│   └── table_name.csv            # Reference data
└── properties/
    └── account_properties.json   # Account-level settings
```

## Recipe JSON Structure

Key top-level fields to extract:

```json
{
  "name": "Recipe Name",
  "description": "What it does",
  "version": 1,
  "active": true,
  "trigger": { ... },        // What starts the recipe
  "actions": [ ... ],        // Ordered list of steps
  "code": { ... }            // Full recipe code tree
}
```

## What to Extract

### Trigger (Entry Point)
- Path: `recipe.trigger` or `recipe.code.trigger`
- Extract: trigger type (`webhook`, `scheduler`, `new_record`, `updated_record`)
- Extract: connection/adapter name (e.g., `salesforce`, `sap`)
- Extract: object/entity being monitored
- Extract: filter conditions

### Actions (Steps)
- Path: `recipe.code.actions[]` (recursive - actions can contain sub-actions)
- Each action has:
  - `provider`: connector name (salesforce, sap, http, etc.)
  - `name`: action type (create_record, update_record, search, etc.)
  - `input`: field mappings and formulas
  - `output`: available output fields for downstream steps

### Field Mappings
- Path: `action.input`
- Format: `{ "target_field": "source_expression" }`
- Expressions use datapills: `#{trigger.output.field_name}`
- Formulas: `.present?`, `.to_s`, `.to_i`, `.strip`, string interpolation
- Lookups: `lookup('Table Name', 'Key Column', value)['Result Column']`

### Callable Recipes (Inter-Recipe Dependencies)
- Action provider: `recipe_function` or `call_recipe`
- Contains: recipe ID reference, input/output field mapping
- Grep for: `"provider": "recipe_function"` or `"call_recipe"`

### Error Handling
- Look for: `"on_error"` blocks within action definitions
- Types: `retry` (with count), `skip`, `stop`, `call_recipe` (error handler)
- Path: `action.on_error`

### Conditional Logic
- Action type: `conditional_action` or `if`
- Contains: condition expression + true_actions[] + false_actions[]

### Loops
- Action type: `repeat_action` or `foreach`
- Contains: list source + loop_actions[]

## Key Grep Patterns

```
# Find all connectors/adapters used
Grep: "provider"

# Find callable recipe references
Grep: "recipe_function|call_recipe"

# Find error handling
Grep: "on_error|error_handler"

# Find lookup table references
Grep: "lookup"

# Find conditional logic
Grep: "conditional_action|condition"

# Find scheduling
Grep: "scheduler|cron"

# Find webhook triggers
Grep: "webhook"
```

## Common Workato Connectors

| Connector | Type | Notes |
|-----------|------|-------|
| `salesforce` | CRM | SOQL queries, objects |
| `sap` | ERP | RFC/BAPI/OData |
| `workday` | HCM | Web services, RaaS reports |
| `servicenow` | ITSM | Table API |
| `netsuite` | ERP | SuiteTalk, RESTlets |
| `http` | Generic | REST/SOAP calls |
| `database` | DB | SQL queries |
| `s3` / `sftp` | File | File-based integration |
| `slack` / `email` | Notification | Alerts and notifications |

## Building the Call Graph

1. Glob all `.json` files in recipes/
2. For each recipe, extract `name` and check for `call_recipe` actions
3. Build adjacency list: `{ recipe_name: [called_recipe_1, called_recipe_2] }`
4. Find entry points: recipes NOT in any called list
5. Find terminals: recipes that don't call other recipes
6. Trace path from entry to terminal for complete journey

## Known Pitfalls and Platform-Specific Findings

Lessons from production Workato integration projects. Check these during assessment and review.

### Security and Authentication

**CSRF Token Requires Two-Action Pattern**: SAP OData write operations require CSRF tokens tied to session cookies. Workato SDK doesn't preserve cookies between HTTP requests within a single execute block. Single-action pattern (fetch token + API call) consistently fails. Use a two-action pattern: Action 1 fetches token + cookies, Action 2 receives both as inputs.

**Platform Security Features Are Often Sufficient**: Workato provides AES-256 encryption and `concurrency=1` settings that already address many common security concerns. Verify platform capabilities before flagging issues — expect 30-50% false positive rate when assessing iPaaS security from documentation alone.

### API Integration

**API Documentation Overstates What Works**: In SAP OData integration via Workato, only 1 of 7 fields documented as "required during creation" actually blocked creation. Critical API behaviors must be tested against production, not assumed from documentation.

**Self-Terminating Pagination**: Workato recipes may use API pagination patterns that appear to lack termination conditions. Check whether the API itself returns empty results or a termination signal — the recipe may be correctly relying on API behavior rather than implementing its own stop condition.

### Assessment Considerations

**High False Positive Rate in Static Analysis**: 43% of issues identified in a Workato assessment Phase 0 validation (6/14) were false positives. Platform security features (AES-256, concurrency controls) and API design (self-terminating pagination) already handled flagged concerns. Always verify findings against actual platform capabilities before recommending fixes.

**Recipes Are Source of Truth, Not Resource Files**: VQL/resource files can drift from actual recipe implementations. When conflicting information exists, always verify against the actual recipe JSON exports.
