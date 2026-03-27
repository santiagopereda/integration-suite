# Talend Process Job Parsing Guide

Parsing guide for Talend process jobs — the standard data integration units using t\* components.

**Prerequisite:** Read [talend.md](talend.md) first for workspace structure, context variables, and properties file parsing.

**Applies to:** All `.item` files in `process/` directory.

## Job XML Structure

Process jobs use `talendfile:ProcessType` as the root element:

```xml
<talendfile:ProcessType
  xmlns:talendfile="platform:/resource/org.talend.model/model/TalendFile.xsd"
  defaultContext="Default"
  jobType="Standard">

  <context name="Default">
    <contextParameter name="var1" type="id_String" value="..." />
  </context>

  <node componentName="tRESTClient" offsetLabelX="0" offsetLabelY="0" posX="256" posY="160">
    <elementParameter field="TEXT" name="URL" value="&quot;https://api.example.com&quot;" />
    <metadata connector="FLOW" name="tRESTClient_1">
      <column comment="" key="false" name="body" nullable="true" type="id_Object" />
    </metadata>
  </node>

  <connection connectorName="FLOW" label="row1" source="tRESTClient_1" target="tMap_1" />

  <subjob>
    <elementParameter name="UNIQUE_NAME" value="tRESTClient_1" />
  </subjob>
</talendfile:ProcessType>
```

### Key Elements

| Element | Description |
|---------|-------------|
| `<node>` | A component instance with `componentName` attribute |
| `<elementParameter>` | Component configuration (inside `<node>`) |
| `<metadata>` / `<column>` | Schema definition (inside `<node>`) |
| `<connection>` | Data flow link between components |
| `<subjob>` | Sub-job grouping for execution control |
| `<context>` | Job-embedded context variables (may override shared contexts) |

## Process Job Component Types

### Data I/O

| Component | Category | What It Does |
|-----------|----------|-------------|
| `tDBInput` / `tDBOutput` | Database | Read/write database |
| `tDBConnection` / `tDBClose` | Database | Manage database connections |
| `tBigQueryOutput` | Cloud DB | Write to Google BigQuery |
| `tFileInputDelimited` / `tFileOutputDelimited` | File | CSV/flat file I/O |
| `tFileList` | File | Iterate over files in directory |
| `tFileDelete` | File | Delete files |
| `tGSDelete` | Cloud | Delete Google Cloud Storage objects |
| `tSalesforceInput` / `tSalesforceOutput` | CRM | Salesforce I/O |
| `tSalesforceConnection` | CRM | Establish Salesforce session |
| `tSAPInput` / `tSAPOutput` | ERP | SAP RFC/BAPI |

### API & Messaging

| Component | Category | What It Does |
|-----------|----------|-------------|
| `tRESTClient` | API | REST API client calls |
| `tREST` | API | REST service endpoint (server-side) |
| `tSOAP` | API | SOAP web service calls |
| `tHTTPRequest` | API | Generic HTTP requests |
| `tMomOutput` / `tMomInput` | Messaging | Send/receive ActiveMQ/JMS messages |
| `tRouteInput` | ESB | Receive data from ESB route (via cTalendJob) |
| `tRouteOutput` | ESB | Send data back to ESB route |

### Transformation

| Component | Category | What It Does |
|-----------|----------|-------------|
| `tMap` | Transform | Visual data mapping and transformation |
| `tExtractJSONFields` | Transform | Parse JSON string into fields |
| `tWriteJSONField` | Transform | Construct JSON payload from fields |
| `tExtractXMLField` | Transform | Parse XML string into fields |

### Control Flow

| Component | Category | What It Does |
|-----------|----------|-------------|
| `tRunJob` | Orchestration | Call another Talend process job |
| `tFixedFlowInput` | Control | Generate fixed input rows (trigger) |
| `tFlowToIterate` | Control | Convert flow to loop |
| `tIterateToFlow` | Control | Convert iterate to flow |
| `tUnite` | Control | Merge multiple input flows |
| `tSetGlobalVar` | Variables | Set global variables |
| `tContextLoad` | Context | Load context variables at runtime |
| `tPreJob` / `tPostJob` | Lifecycle | Before/after main job logic |

### Code & Logging

| Component | Category | What It Does |
|-----------|----------|-------------|
| `tJava` / `tJavaRow` | Code | Custom Java logic (inline) |
| `tJavaFlex` | Code | Java code with begin/main/end blocks |
| `tLogRow` | Logging | Log output rows |
| `tLogCatcher` | Logging | Catch and route component errors |
| `tStatCatcher` | Logging | Catch component execution statistics |
| `tDie` | Error | Stop job execution with error code |
| `tWarn` | Error | Log warning but continue |

## Schemas

### XPaths

| XPath | Returns |
|-------|---------|
| `//node/metadata/column` | Inline schema columns per component |
| `//column/@name` | Field name |
| `//column/@type` | Field type (`id_String`, `id_Integer`, `id_Date`, `id_Object`, etc.) |
| `//column/@nullable` | Whether field accepts null |
| `//column/@length` | Field length constraint |
| `//column/@key` | Primary key indicator |

### External Schemas

Also check shared schema definitions in the workspace:
- `metadata/json/` — JSON schema definitions
- `metadata/fileXml/` — XML schema definitions
- `metadata/salesforce/` — Salesforce object schemas
- `metadata/genericSchema/` — Reusable generic schemas

## Data Flow Connections

Connections define how data moves between components. Organized by Talend's 4 connection categories:

### Row Connections (data transfer)

| connectorName | Description |
|---------------|-------------|
| `FLOW` | Standard data flow between components |
| `MAIN` | Main data flow (alternate naming) |
| `REJECT` | Rejected/error records (e.g., from tMap filter) |
| `LOOKUP` | Lookup input to tMap |
| `OUTPUT_1` | Named output flow (from joblets) |
| `RESPONSE` | Response data from service calls |
| `FAULT` | Fault/error response from service calls |

### Iterate Connections (loops)

| connectorName | Description |
|---------------|-------------|
| `ITERATE` | Loop iteration (e.g., from tFlowToIterate, tFileList) |

### Trigger Connections (execution control)

| connectorName | Description |
|---------------|-------------|
| `SUBJOB_OK` | Execute after sub-job completes successfully |
| `SUBJOB_ERROR` | Execute after sub-job fails |
| `COMPONENT_OK` | Execute after component completes successfully |
| `COMPONENT_ERROR` | Execute after component fails |
| `RUN_IF` | Conditional execution (expression-based) |
| `TRIGGER_OUTPUT_1` | Trigger output from joblet |

### Link Connections (ELT)

| connectorName | Description |
|---------------|-------------|
| `LINK` | ELT push-down to database engine (rare — used when transformations execute in DB) |

### XPath

```
//connection[@connectorName]
```

Attributes: `source`, `target`, `connectorName`, `label`

Build flow graph: `source` → `target` for each connection. Use `connectorName` to classify the edge type.

## tMap Transformations

The `tMap` component contains the core transformation logic:

| XPath | Returns |
|-------|---------|
| `//node[@componentName='tMap']/nodeData/mapperTableEntries` | Mapping entries |
| Input tables | Source data from upstream components |
| Output tables | Target data to downstream components |
| `expression` attribute | Transformation formula per field |

Expressions use Java syntax — see Transformation Expression Syntax below.

## tRunJob Inter-Job Dependencies

`tRunJob` is the primary mechanism for orchestrating multi-job flows:

| XPath | Returns |
|-------|---------|
| `//node[@componentName='tRunJob']` | All tRunJob components |
| `elementParameter[@name='PROCESS:PROCESS_TYPE_PROCESS']` | Referenced child job name |
| `elementParameter[@name='CONTEXTPARAMS']` | Context variables passed to child job |

This is the PRIMARY mechanism for tracing data journeys across process jobs.

## Error Handling

| Mechanism | Description |
|-----------|-------------|
| `tLogCatcher` | Catches component errors, routes them for logging |
| `tStatCatcher` | Catches execution statistics per component |
| `tDie` | Stops job execution with error code and message |
| `tWarn` | Logs warning but continues execution |
| `REJECT` connection | Routes rejected records to error handling components |
| `COMPONENT_ERROR` trigger | Execute error handler after component failure |
| `SUBJOB_OK` / `SUBJOB_ERROR` trigger | Execution flow based on sub-job success/failure |
| `tPreJob` / `tPostJob` | Setup and cleanup logic (resource init/release) |

## Transformation Expression Syntax

Talend uses Java-based expressions in tMap and other components:

| Pattern | Meaning |
|---------|---------|
| `input_row.fieldName` | Access input field |
| `StringHandling.CHANGE(str, old, new)` | String replace |
| `TalendDate.parseDate("yyyy-MM-dd", dateStr)` | Date parsing |
| `Numeric.sequence("seq", 1, 1)` | Auto-increment |
| `row1.field != null ? row1.field : "default"` | Null handling |
| `context.VARIABLE_NAME` | Access context variable |
| `globalMap.get("key")` | Access global variable |
| `routines.CustomRoutine.method(args)` | Custom Java routine |
| `(String)globalMap.get("tRouteInput_1_BODY")` | Access ESB route message body |

## Building the DI Call Graph

1. Glob all `.item` files in `process/`
2. Filter out inactive items (see `talend.md` — Filtering Inactive Items)
3. For each job, extract job name from filename and find all `tRunJob` nodes
4. From each `tRunJob`, extract the referenced child job name (`PROCESS:PROCESS_TYPE_PROCESS`)
5. Extract context parameters being passed (`CONTEXTPARAMS`)
6. Build adjacency list: `{ parent_job: [(child_job, context_vars), ...] }`
7. Find entry points: jobs NOT called by any other job's tRunJob
8. Find terminals: jobs with no tRunJob components
9. Trace path from entry to terminal for complete data journey

In ESB workspaces, merge this graph with the ESB call graph — see `talend-routes.md` Section 7.

## Job-Specific Grep Patterns

```
# tRunJob references (inter-job calls)
componentName.*tRunJob

# Database components
tDBInput|tDBOutput|tDB.*Connection

# API/HTTP components
tREST|tSOAP|tHTTP|tRESTClient

# Transformation components
componentName.*tMap

# Error handling components
tLogCatcher|tDie|tWarn|tStatCatcher

# Reject connections
connectorName="REJECT"

# Salesforce components
tSalesforce

# SAP components
tSAP

# BigQuery components
tBigQuery

# JSON processing
tExtractJSONFields|tWriteJSONField

# ESB bridge components (in process jobs called by routes)
tRouteInput|tRouteOutput

# File operations
tFileList|tFileDelete

# Messaging
tMomOutput|tMomInput

# Trigger connections
SUBJOB_OK|SUBJOB_ERROR|COMPONENT_OK|COMPONENT_ERROR|RUN_IF
```

## Known Job-Specific Patterns

### ProBI vs OData Encoding Differences

When Talend jobs interact with both ProBI and OData endpoints for the same SAP system, watch for encoding differences in field values. ProBI responses may use different character encoding or escaping than OData responses for the same logical field. Compare field values from both sources during data journey mapping and flag any encoding mismatches for the inventory.
