# Talend Job Parsing Guide

## File Structure

Talend exports jobs as XML + Java files. Key structure:

```
export/
├── process/
│   └── Job_Name_0.1/
│       ├── Job_Name_0.1.item          # Job definition (XML)
│       └── Job_Name_0.1.properties    # Job metadata
├── metadata/
│   ├── connections/                    # Database/API connection configs
│   └── schemas/                       # Reusable schema definitions
├── context/
│   └── Default.properties             # Context variables (env config)
├── code/
│   └── routines/                      # Custom Java routines
└── lib/
    └── *.jar                          # External libraries
```

## Job Item XML Structure

The `.item` file contains the complete job definition:

```xml
<talendfile:ProcessType>
  <node componentName="tRESTClient" ...>     <!-- Components -->
    <elementParameter name="URL" value="..." />
    <metadata>                                 <!-- Schema definitions -->
      <column name="field1" type="id_String" />
    </metadata>
  </node>
  <connection connectorName="FLOW" source="tInput" target="tMap" />  <!-- Data flow -->
  <subjob>                                    <!-- Sub-job groupings -->
    ...
  </subjob>
</talendfile:ProcessType>
```

## What to Extract

### Components (Nodes)
- Path: `//node[@componentName]`
- Key attribute: `componentName` (e.g., tRESTClient, tMap, tDBInput, tRunJob)
- Extract: component type, configuration parameters, position in flow

### Common Component Types

| Component | Category | What It Does |
|-----------|----------|-------------|
| `tDBInput` / `tDBOutput` | Database | Read/write database |
| `tRESTClient` | API | REST API calls |
| `tSOAP` | API | SOAP web services |
| `tFileInputDelimited` / `tFileOutputDelimited` | File | CSV/flat file I/O |
| `tMap` | Transform | Visual data mapping and transformation |
| `tJavaRow` / `tJava` | Code | Custom Java logic |
| `tRunJob` | Orchestration | Call another Talend job |
| `tLogRow` / `tLogCatcher` | Logging | Log output / catch errors |
| `tDie` / `tWarn` | Error | Stop job / log warning |
| `tPreJob` / `tPostJob` | Lifecycle | Before/after main job |
| `tFlowToIterate` | Control | Convert flow to loop |
| `tSetGlobalVar` | Variables | Set global variables |
| `tContextLoad` | Context | Load context variables |
| `tSalesforceInput` / `tSalesforceOutput` | CRM | Salesforce I/O |
| `tSAPInput` / `tSAPOutput` | ERP | SAP RFC/BAPI |

### Schemas
- Path: `//node/metadata/column`
- Extract: field name, type (id_String, id_Integer, id_Date, etc.), nullable, length
- Also check: `metadata/schemas/` for reusable schema definitions

### Data Flow (Connections)
- Path: `//connection`
- Attributes: `source`, `target`, `connectorName` (FLOW, REJECT, ITERATE, etc.)
- FLOW = normal data path
- REJECT = error/reject path
- ITERATE = loop iteration
- Build flow graph: source -> target for each connection

### tMap Transformations
- The `tMap` component contains the core transformation logic
- Path: `//node[@componentName='tMap']/nodeData/mapperTableEntries`
- Extract: input tables, output tables, expression (transformation formula)
- Expressions use Java syntax: `input_row.field`, `StringHandling.CHANGE(...)`, etc.

### tRunJob (Inter-Job Dependencies)
- Path: `//node[@componentName='tRunJob']`
- Key parameter: `PROCESS:PROCESS_TYPE_PROCESS` = child job reference
- Context passing: `CONTEXTPARAMS` = variables passed to child job
- This is the PRIMARY mechanism for tracing data journeys

### Error Handling
- `tLogCatcher`: Catches component errors, logs them
- `tDie`: Stops job execution with error code
- `tWarn`: Logs warning but continues
- REJECT connections: Route rejected records to error handling
- `tPreJob` / `tPostJob`: Setup and cleanup logic

### Context Variables
- Path: `//context/contextParameter`
- Or: `context/Default.properties`
- Variables like: DB_HOST, API_URL, API_KEY, BATCH_SIZE, etc.
- These are the "configuration" of the job

## Key Grep Patterns

```
# Find all component types used
Grep: componentName=

# Find tRunJob references (inter-job calls)
Grep: componentName.*tRunJob

# Find database connections
Grep: tDBInput|tDBOutput|tDB.*Connection

# Find API calls
Grep: tREST|tSOAP|tHTTP

# Find tMap (transformations)
Grep: componentName.*tMap

# Find error handling
Grep: tLogCatcher|tDie|tWarn|REJECT

# Find context variables
Grep: contextParameter|CONTEXT

# Find schemas
Grep: <column.*name=

# Find Salesforce components
Grep: tSalesforce

# Find SAP components
Grep: tSAP
```

## Building the Call Graph

1. Glob all `.item` files in `process/`
2. For each job, extract job name and find all `tRunJob` nodes
3. From each `tRunJob`, extract the referenced child job name
4. Extract context parameters being passed (`CONTEXTPARAMS`)
5. Build adjacency list: `{ parent_job: [(child_job, context_vars), ...] }`
6. Find entry points: jobs NOT called by any other job's tRunJob
7. Find terminals: jobs with no tRunJob components
8. Trace path from entry to terminal for complete data journey

## Transformation Expression Syntax

Talend uses Java-based expressions in tMap:

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

## Known Pitfalls and Platform-Specific Findings

Lessons from production Talend integration projects. Check these during assessment and review.

### Runtime Architecture

**Dual-JVM Karaf Architecture**: Enterprise Talend ESB runs two separate JVM instances — Runtime (executes routes/jobs) and Remote Engine (handles deployment from TMC). Configuration changes must target the correct JVM. Export and compare both `wrapper.conf` files when diagnosing issues.

**OSGi Bundle Isolation Prevents Configuration Fixes**: Talend jobs embed their own dependencies (CXF, etc.) in OSGi bundles. JVM arguments, system properties, and Karaf-level bundle changes do NOT reach embedded libraries. When configuration-level approaches fail, go directly to code-level solutions using JDK built-ins.

**TMC Observability is DI-Only**: TMC component execution metrics return empty for ESB routes (Camel microservices). Only DI jobs have TMC-level observability. ESB runtime monitoring requires custom solutions (Prometheus, application logs).

### Component Behavior

**tDie Is Logging-Only, Not Exception Propagation**: `tDie` does not propagate its message string to the exception. `TDieException` constructor receives null. For proper error messages in DLC/ErrorQueue, use `tJava` throwing `new RuntimeException("descriptive message")` instead.

**tRESTClient PATCH Method Silently Converts to POST**: On Karaf Runtime, tRESTClient converts PATCH to POST due to CXF/HttpURLConnection limitation. Each OSGi bundle embeds its own CXF copy — you cannot override it via configuration. Solution: `tJavaFlex` using `java.net.http.HttpClient` (Java 17 built-in), which bypasses CXF entirely.

**tRouteOutput Is a No-Op Standalone**: `tRouteOutput` only generates actual Camel `setHeader()` code when called from a route. Standalone testing gives false confidence. Always test via route invocation.

**DLC URI Must Use Registered Connection Factory**: `activemq:queue:ErrorQueue` creates an anonymous JMS connection without credentials. Talend strips underscores from component IDs in Camel registry (`cMQConnectionFactory_1` → `cMQConnectionFactory1`). Always use the registered name: `cMQConnectionFactory1:queue:ErrorQueue`.

### Code Constraints

**Avoid Java Generics in tJavaFlex**: Talend's code generator misinterprets angle brackets `<>` as annotation syntax. `HttpResponse<String>` causes compilation errors. Use raw types with explicit casts: `HttpResponse resp` then `(String) resp.body()`.

**Component Fields Have Undocumented Expression Contexts**: Different fields in the same component use different expression languages with no visual distinction. tRouteOutput Body supports `{in.header.X}` syntax; Header Name is raw Java requiring quoted strings. Compilation errors are the only way to discover the difference.

### Assessment Considerations

**Static-Only Scores Are Preliminary**: Runtime enrichment changed 4 of 8 dimension scores in a Talend assessment. Expected score swing: ~10%. Operational dimensions (D3 Monitoring, D4 Incident Response, D7 Scheduling, D8 Alerting) are almost always inference without runtime data — flag as low confidence.

**Developer Walkthrough Corrects Assumptions**: 4 architectural assumptions were corrected in a single 30-minute walkthrough. Code and configuration show WHAT was built; only domain owners know WHY. Conduct walkthrough before finalizing any assessment.
