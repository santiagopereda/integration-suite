# /analyze-integration - Parse Code Exports

Analyze integration platform workspace exports to extract schemas, mappings, transformations, and data lineage.

## Quick Reference

| Aspect | Details |
|--------|---------|
| **Invocation** | `/analyze-integration <path-to-export>` |
| **Agent Used** | agent-integration-analyzer |
| **Output** | Integration inventory with data journey map |

## Usage

```bash
/analyze-integration /path/to/workato/export
/analyze-integration /path/to/talend/workspace --platform talend
/analyze-integration /path/to/export --full
```

## Workflow

```
Step 1: Platform Detection
├── Glob scan for file patterns
└── Auto-detect: Workato (JSON), Talend (XML), MuleSoft, Boomi

Step 2: Parse & Extract
├── Read configuration and job/recipe files
├── Extract: connections, schemas, mappings, transformations
├── Trace: inter-job/recipe calls (tRunJob, Call recipe)
└── Build: dependency graph

Step 3: Map Data Journey
├── Identify entry points (root jobs/recipes)
├── Trace data flow through entire chain
├── Document context/variable passing between steps
└── Flag observations and red flags

Step 4: Generate Inventory
└── Produces: Structured inventory document
```

## Options

| Option | Description |
|--------|-------------|
| `--platform <name>` | Force platform detection (workato, talend, mulesoft, boomi) |
| `--full` | After analysis, automatically run assessor + scorer on the inventory |
| `--output <dir>` | Save inventory to specified directory |

## Supported Platforms

| Platform | Status | File Types Parsed |
|----------|--------|-------------------|
| Workato | Supported | JSON recipes, connections, lookup tables |
| Talend | Supported | XML .item files, .properties, context vars |
| MuleSoft | Planned | XML configs, .dwl DataWeave files |
| Boomi | Planned | XML process definitions, maps |
| SAP CPI | Planned | iFlow XML, Groovy scripts |

## Output

Integration inventory document containing:
- Connections (source/target, connectors, auth)
- Schemas (input/output fields with types)
- Field mappings (source -> transformation -> target)
- Transformations (lookups, formulas, conditionals)
- Error handling (retry config, error routing)
- Data journey map (complete execution graph with variable passing)
- Observations and red flags found in code

---

**Version**: 1.0.0
