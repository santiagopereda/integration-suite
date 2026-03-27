# Talend Workspace Parsing Guide (Core)

Shared structures for both Talend Data Integration (DI) and Talend ESB workspaces.

**Companion guides:**
- [talend-jobs.md](talend-jobs.md) - Process job parsing (t\* components, DI call graph)
- [talend-routes.md](talend-routes.md) - ESB route & joblet parsing (c\* Camel components, ESB call graph)

## Workspace Type Detection

| Indicator              | Workspace Type | Guides to Use                                |
| ---------------------- | -------------- | -------------------------------------------- |
| `process/` only        | Talend DI      | This + `talend-jobs.md`                      |
| `process/` + `routes/` | Talend ESB     | This + `talend-jobs.md` + `talend-routes.md` |

Additional ESB indicators: `joblets/`, `routelets/`, `services/`, `route_resources/`

## File Structure

```
workspace/
├── talend.project                    # Project metadata (name, version, type)
├── .project                          # Eclipse project descriptor
├── recycle_bin.index                  # Deleted item references
│
├── process/                          # Process jobs (.item + .properties per job)
│   └── FolderName/
│       └── JobName_0.1/
│           ├── JobName_0.1.item          # Job definition (XML)
│           └── JobName_0.1.properties    # Job metadata
│
├── context/                          # Shared context variable groups
│   └── ContextGroup_0.1/
│       ├── ContextGroup_0.1.item         # Context definitions (XML)
│       └── ContextGroup_0.1.properties   # Context metadata
│
├── metadata/                         # Shared metadata definitions
│   ├── connections/                   # Database connection configs
│   ├── json/                          # JSON schema definitions
│   ├── fileXml/                       # XML schema definitions
│   ├── fileDelimited/                 # CSV/flat file schemas
│   ├── fileExcel/                     # Excel file schemas
│   ├── genericSchema/                 # Reusable generic schemas
│   ├── salesforce/                    # Salesforce module schemas
│   ├── SalesforceSchema/              # Salesforce schema definitions
│   ├── WSDLSchema/                    # WSDL/SOAP schema definitions
│   ├── JDBC/                          # JDBC connection definitions
│   ├── bigqueryconnections/           # Google BigQuery connections
│   ├── sapconnections/                # SAP connection definitions
│   ├── tacokit/                       # Tacokit component configs
│   └── validationRules/               # Data validation rules
│
├── code/                             # Custom code
│   ├── routines/                      # Java routines (DI)
│   ├── routinesjar/                   # Routine JAR dependencies
│   ├── beans/                         # Java beans (ESB)
│   └── beansjar/                      # Bean JAR dependencies
│
├── routes/                           # [ESB] Camel route definitions
│   └── FolderName/
│       └── RouteName_0.1/
│           ├── RouteName_0.1.item
│           └── RouteName_0.1.properties
│
├── joblets/                          # [ESB] Reusable job fragments
│   └── JobletName_0.1/
│       ├── JobletName_0.1.item
│       └── JobletName_0.1.properties
│
├── routelets/                        # [ESB] Reusable route fragments
│   └── RouterletName_0.1/
│       ├── RouterletName_0.1.item
│       └── RouterletName_0.1.properties
│
├── services/                         # [ESB] SOAP/REST service definitions
├── route_resources/                  # [ESB] Route resource files
│
├── sqlPatterns/                       # SQL pattern templates
├── components/                        # Custom component definitions
├── documentations/                    # Embedded documentation
├── images/                            # Embedded images
└── .settings/                         # IDE settings
```

## Artifact Types & XML Root Elements

| Artifact | Location | XML Root Element | Detail |
|----------|----------|-----------------|--------|
| Process job | `process/*.item` | `talendfile:ProcessType` | See `talend-jobs.md` |
| ESB route | `routes/*.item` | `talendfile:ProcessType` (with c\* components) | See `talend-routes.md` |
| Joblet | `joblets/*.item` | `model:JobletProcess` inside `xmi:XMI` | See `talend-routes.md` |
| Routelet | `routelets/*.item` | `talendfile:ProcessType` (route fragment) | See `talend-routes.md` |
| Context group | `context/*.item` | `talendfile:ContextType` (multiple per file) | Detailed below |
| Properties | `*/*.properties` | `TalendProperties:Property` | Detailed below |
| Project | `talend.project` | `TalendProperties:Project` | Detailed below |

## Context Variables

Context items define environment-specific configuration. Each `.item` file contains multiple named contexts.

### XML Structure

```xml
<xmi:XMI xmlns:talendfile="platform:/resource/org.talend.model/model/TalendFile.xsd">
  <talendfile:ContextType name="Default" xmi:id="...">
    <contextParameter name="db_host" type="id_String" value="" repositoryContextId="built-in" />
    <contextParameter name="db_password" type="id_Password" value="enc:system.encryption.key.v1:..." />
  </talendfile:ContextType>
  <talendfile:ContextType name="PROD" xmi:id="...">
    <contextParameter name="db_host" type="id_String" value="<host>" />
  </talendfile:ContextType>
  <talendfile:ContextType name="TEST" xmi:id="...">
    ...
  </talendfile:ContextType>
</xmi:XMI>
```

### XPaths

| XPath | Returns |
|-------|---------|
| `//talendfile:ContextType[@name]` | All named contexts (Default, PROD, TEST, etc.) |
| `//contextParameter[@name]` | All context variables |
| `//contextParameter[@type='id_Password']` | Password/secret variables |

### Key Attributes

| Attribute | Description |
|-----------|-------------|
| `name` | Variable name (e.g., `connection_activemq_broker`) |
| `type` | Data type: `id_String`, `id_Password`, `id_Integer`, `id_Boolean`, `id_Date` |
| `value` | Value for this context environment |
| `repositoryContextId` | `built-in` or reference to shared context group |
| `prompt` | Prompt text shown when value required at runtime |
| `promptNeeded` | Whether runtime prompt is enabled |

### Password Encryption Detection

Values prefixed with `enc:system.encryption.key.v1:` are Talend-encrypted passwords. Flag these for security assessment - evaluate the *mechanism* (context variable vs vault), not the credential value.

### Environment Detection

Multiple `ContextType` elements with different `name` attributes indicate environment management. Common patterns: Default, DEV, TEST, PROD, TEST_LINUX, PROD_MAC.

## Properties File Parsing

Every artifact (job, route, joblet, context) has a companion `.properties` file containing metadata.

### XML Structure

```xml
<xmi:XMI xmlns:TalendProperties="http://www.talend.org/properties">
  <TalendProperties:Property
    id="_uniqueId"
    label="JobName"
    purpose="Description of the job"
    version="0.1"
    statusCode=""
    displayName="JobName">
    <additionalProperties key="created_date" value="2025-10-22T14:35:26.116+0200"/>
    <additionalProperties key="modified_date" value="2026-02-11T18:36:18.660+0100"/>
    <additionalProperties key="created_product_version" value="8.0.1.20231017_1026-patch"/>
  </TalendProperties:Property>
  <TalendProperties:ItemState path="FolderPath"/>
</xmi:XMI>
```

### XPaths

| XPath | Returns |
|-------|---------|
| `//TalendProperties:Property/@label` | Artifact display name |
| `//TalendProperties:Property/@version` | Version string |
| `//TalendProperties:Property/@purpose` | Description/purpose text |
| `//TalendProperties:Property/@statusCode` | Active/inactive status |
| `//additionalProperties[@key='created_date']/@value` | Creation timestamp |
| `//additionalProperties[@key='modified_date']/@value` | Last modified timestamp |
| `//TalendProperties:ItemState/@path` | Folder path in project tree |

### Use for Inventory

- `label` + `version` = canonical artifact name
- `purpose` = job description (often populated by developers)
- `statusCode` = empty string means active; check for inactive codes
- `path` = logical grouping (e.g., `Account/Out`, `Item/In`)

## talend.project File

The root project descriptor contains workspace-level metadata.

### XML Structure

```xml
<xmi:XMI xmlns:TalendProperties="http://www.talend.org/properties">
  <TalendProperties:Project
    label="project_name"
    technicalLabel="PROJECT_NAME"
    productVersion="Talend Cloud API Services Platform-8.0.1.20231017_1026-patch"
    language="java"
    type="DQ"
    description="Project description"/>
</xmi:XMI>
```

### XPaths

| XPath | Returns |
|-------|---------|
| `//TalendProperties:Project/@technicalLabel` | Project technical name |
| `//TalendProperties:Project/@productVersion` | Talend product + version |
| `//TalendProperties:Project/@type` | Product type (DI, DQ, etc.) |
| `//TalendProperties:Project/@language` | Language (java/perl) |

### ESB Detection

If `productVersion` contains "API Services Platform" or "ESB", or if `routes/` directory exists, this is an ESB workspace.

## Key Grep Patterns - Shared

Patterns applicable to all workspace types:

```
# All component types (any .item file)
componentName=

# Context variables
contextParameter.*name=

# Schema columns
<column.*name=

# Encrypted passwords
enc:system.encryption.key.v1

# Context environments
ContextType.*name=

# Properties metadata
TalendProperties:Property

# Joblet detection (ESB)
model:JobletProcess
```

For job-specific patterns, see `talend-jobs.md` Section 11.
For route-specific patterns, see `talend-routes.md` Section 8.

## Filtering Inactive Items

Before building call graphs, exclude inactive artifacts from analysis. This applies to `process/`, `routes/`, and `joblets/` directories.

### Recycle Bin Detection

- Items in `process/recycle_bin/` or `process/_Trash/` directories are deleted - **skip entirely**
- Check `.properties` files for `statusCode` indicating deleted/inactive state
- Check `recycle_bin.index` at workspace root for deleted item references

### Copy/Backup Detection

- Items with `Copy_of_` prefix are typically user-created backups or test copies
- Flag as **inactive/backup** - list in inventory but exclude from main analysis
- Only include in main analysis if another active item's `tRunJob` or `cTalendJob` references them

### Grep Patterns

```
# Find recycle bin items
Glob: process/recycle_bin/**/*.item
Glob: process/_Trash/**/*.item

# Find copy/backup items (any directory)
Glob: **/Copy_of_*.item

# Verify if a Copy_of_ item is actually called
Grep: Copy_of_[ItemName] in all .item files (check tRunJob/cTalendJob references)
```

### Reporting

When inactive items are found, report them separately in the inventory:
- Count of recycled items (excluded from analysis)
- List of `Copy_of_` items with status (referenced by tRunJob/cTalendJob = active, not referenced = inactive)
- Total active vs inactive ratio per directory (process/, routes/, joblets/)

## Parsing Strategy Quick Reference

1. **Read `talend.project`** -> extract project name, product version, detect ESB vs DI
2. **Check for `routes/` directory** -> if present, this is ESB; read `talend-routes.md`
3. **Always read `talend-jobs.md`** for `process/` directory
4. **Parse `context/`** using this guide -> extract all context groups, environments, variables
5. **Parse `metadata/`** -> extract connection definitions, shared schemas
6. **Scan `.properties` files** -> build inventory with names, versions, descriptions, timestamps
7. **Filter inactive items** -> exclude recycle bin, flag Copy_of_ items
8. **Build call graph(s)** per `talend-jobs.md` (tRunJob) and `talend-routes.md` (cTalendJob)
9. **Merge graphs** if ESB workspace -> see `talend-routes.md` Section 7

## Known Pitfalls and Platform-Specific Findings

Lessons from production Talend integration projects. Check these during assessment and review.

### Runtime Architecture

**Dual-JVM Karaf Architecture**: Enterprise Talend ESB runs two separate JVM instances - Runtime (executes routes/jobs) and Remote Engine (handles deployment from TMC). Configuration changes must target the correct JVM. Export and compare both `wrapper.conf` files when diagnosing issues.

**OSGi Bundle Isolation Prevents Configuration Fixes**: Talend jobs embed their own dependencies (CXF, etc.) in OSGi bundles. JVM arguments, system properties, and Karaf-level bundle changes do NOT reach embedded libraries. When configuration-level approaches fail, go directly to code-level solutions using JDK built-ins.

**TMC Observability is DI-Only**: TMC component execution metrics return empty for ESB routes (Camel microservices). Only DI jobs have TMC-level observability. ESB runtime monitoring requires custom solutions (Prometheus, application logs).

### Component Behavior

**tDie Is Logging-Only, Not Exception Propagation**: `tDie` does not propagate its message string to the exception. `TDieException` constructor receives null. For proper error messages in DLC/ErrorQueue, use `tJava` throwing `new RuntimeException("descriptive message")` instead.

**tRESTClient PATCH Method Silently Converts to POST**: On Karaf Runtime, tRESTClient converts PATCH to POST due to CXF/HttpURLConnection limitation. Each OSGi bundle embeds its own CXF copy - you cannot override it via configuration. Solution: `tJavaFlex` using `java.net.http.HttpClient` (Java 17 built-in), which bypasses CXF entirely.

**tRouteOutput Is a No-Op Standalone**: `tRouteOutput` only generates actual Camel `setHeader()` code when called from a route. Standalone testing gives false confidence. Always test via route invocation.

**DLC URI Must Use Registered Connection Factory**: `activemq:queue:ErrorQueue` creates an anonymous JMS connection without credentials. Talend strips underscores from component IDs in Camel registry (`cMQConnectionFactory_1` -> `cMQConnectionFactory1`). Always use the registered name: `cMQConnectionFactory1:queue:ErrorQueue`.

### Code Constraints

**Avoid Java Generics in tJavaFlex**: Talend's code generator misinterprets angle brackets `<>` as annotation syntax. `HttpResponse<String>` causes compilation errors. Use raw types with explicit casts: `HttpResponse resp` then `(String) resp.body()`.

**Component Fields Have Undocumented Expression Contexts**: Different fields in the same component use different expression languages with no visual distinction. tRouteOutput Body supports `{in.header.X}` syntax; Header Name is raw Java requiring quoted strings. Compilation errors are the only way to discover the difference.

### Assessment Considerations

**Static-Only Scores Are Preliminary**: Runtime enrichment changed 4 of 8 dimension scores in a Talend assessment. Expected score swing: ~10%. Operational dimensions (D3 Monitoring, D4 Incident Response, D7 Scheduling, D8 Alerting) are almost always inference without runtime data - flag as low confidence.

**Developer Walkthrough Corrects Assumptions**: 4 architectural assumptions were corrected in a single 30-minute walkthrough. Code and configuration show WHAT was built; only domain owners know WHY. Conduct walkthrough before finalizing any assessment.
