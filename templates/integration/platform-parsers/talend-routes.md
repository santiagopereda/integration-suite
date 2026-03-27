# Talend ESB Route & Joblet Parsing Guide

Parsing guide for Talend ESB routes (Camel-based, c\* components), joblets, and routelets.

**Prerequisite:** Read [talend.md](talend.md) first for workspace structure, context variables, and properties file parsing.

**Applies to:**
- `.item` files in `routes/` — ESB route definitions
- `.item` files in `joblets/` — Reusable job fragments
- `.item` files in `routelets/` — Reusable route fragments

**Only present in ESB workspaces** — detected by the existence of a `routes/` directory or `productVersion` containing "API Services Platform".

## Route XML Structure

ESB routes share the same root element as process jobs (`talendfile:ProcessType`) but use c\* Camel components instead of t\* components:

```xml
<talendfile:ProcessType
  xmlns:talendfile="platform:/resource/org.talend.model/model/TalendFile.xsd"
  defaultContext="Default"
  jobType="Standard">

  <context name="Default">
    <contextParameter name="connection_activemq_broker" type="id_String" value="" />
  </context>
  <context name="TEST">
    <contextParameter name="connection_activemq_broker" type="id_String" value="localhost" />
  </context>

  <node componentName="cREST" posX="64" posY="160">
    <elementParameter name="REST_ENDPOINT" value="&quot;/api/webhook&quot;" />
  </node>

  <node componentName="cTalendJob" posX="320" posY="160">
    <elementParameter name="SELECTED_JOB_NAME:PROCESS_TYPE_PROCESS"
      value="process:sjAccount_OnRamp_BusinessCentral" />
  </node>

  <connection connectorName="ROUTE" source="cREST_1" target="cTalendJob_1" />
</talendfile:ProcessType>
```

### Key Differences from Process Jobs

| Aspect | Process Job | ESB Route |
|--------|------------|-----------|
| Component prefix | `t*` (tMap, tRunJob) | `c*` (cREST, cTalendJob) |
| Connection type | FLOW, REJECT, ITERATE | ROUTE, ROUTE_WHEN, SPLIT |
| Calls other jobs via | `tRunJob` | `cTalendJob` |
| Entry point | tRunJob from parent or standalone | cREST endpoint, cJMS consumer |
| Error routing | REJECT, tLogCatcher | FAULT, route-level error handler |

## ESB Route Component Types

### Endpoints

| Component | Category | What It Does |
|-----------|----------|-------------|
| `cREST` | Endpoint | RESTful HTTP endpoint (webhook receiver) |
| `cJMS` | Messaging | JMS queue/topic producer or consumer |
| `cMQConnectionFactory` | Messaging | ActiveMQ/Artemis connection factory |
| `cMessagingEndpoint` | Generic | Wrapper for Camel components not in Talend palette |

### Orchestration

| Component | Category | What It Does |
|-----------|----------|-------------|
| `cTalendJob` | Orchestration | Call a process job from within a route |
| `cDirect` | Routing | Internal route endpoint (in-memory, no network) |

### Message Routing

| Component | Category | What It Does |
|-----------|----------|-------------|
| `cMessageRouter` | Routing | Content-based message routing (if/else on message) |
| `cSplitter` | Routing | Split message into parts for parallel processing |
| `cWireTap` | Routing | Copy message to secondary route (tap pattern) |

### Message Transformation

| Component | Category | What It Does |
|-----------|----------|-------------|
| `cProcessor` | Transform | Custom Java processing on message |
| `cSetBody` | Transform | Set/replace message body content |
| `cSetHeader` | Transform | Set message header value |
| `cConvertBodyTo` | Transform | Convert message body to different type |

### Configuration & Logging

| Component | Category | What It Does |
|-----------|----------|-------------|
| `cConfig` | Config | Route-level configuration properties |
| `cLog` | Logging | Log message to console/file |

## Route Connection Types

Routes use a different set of connection types than process jobs:

| connectorName | Description |
|---------------|-------------|
| `ROUTE` | Standard flow between Camel components |
| `ROUTE_WHEN` | Conditional branch from `cMessageRouter` (expression-based) |
| `ROUTE_OTHER` | Default/fallback branch from `cMessageRouter` (else case) |
| `ROUTE_ENDBLOCK` | End of a routing block (closes a branch) |
| `SPLIT` | Output from `cSplitter` (one per split part) |
| `RESPONSE` | Response path from `cREST` endpoint back to caller |
| `FAULT` | Error/fault path for exception handling |

### XPath

```
//connection[@connectorName]
```

Build route graph: `source` → `target` for each connection. Use `connectorName` to identify conditional branches (ROUTE_WHEN) vs default flow (ROUTE).

## Route-to-Job Bindings — cTalendJob

The `cTalendJob` component is the bridge between ESB routes and process jobs. It invokes a process job from within a route.

### XPath

| XPath | Returns |
|-------|---------|
| `//node[@componentName='cTalendJob']` | All cTalendJob components |
| `elementParameter[@name='SELECTED_JOB_NAME:PROCESS_TYPE_PROCESS']` | Referenced process job |
| `elementParameter[@name='CONTEXTPARAMS']` | Context variables passed to the job |
| `elementParameter[@name='USE_ROUTE_CONTEXT']` | Whether job inherits route context |

### XML Example

```xml
<node componentName="cTalendJob" posX="320" posY="160">
  <elementParameter name="SELECTED_JOB_NAME:PROCESS_TYPE_PROCESS"
    value="process:sjAccount_OnRamp_BusinessCentral" />
  <elementParameter name="USE_ROUTE_CONTEXT" value="true" />
  <elementParameter name="CONTEXTPARAMS">
    <elementValue elementRef="PARAM_NAME_COLUMN" value="entity_type" />
    <elementValue elementRef="PARAM_VALUE_COLUMN" value="&quot;Account&quot;" />
  </elementParameter>
</node>
```

### Extraction Steps

1. Find all `cTalendJob` nodes in route `.item` files
2. Extract `SELECTED_JOB_NAME:PROCESS_TYPE_PROCESS` → child job name (strip `process:` prefix)
3. Extract `CONTEXTPARAMS` → context variables passed to the job
4. Check `USE_ROUTE_CONTEXT` → if `true`, job inherits all route context variables

### ESB Bridge in Process Jobs

Process jobs called by routes typically use:
- `tRouteInput` — receives the message body from the route
- `tRouteOutput` — sends the result back to the route

These components act as the entry/exit points for route-invoked jobs. Look for them in jobs referenced by `cTalendJob`.

## Joblet Structure

Joblets are reusable job fragments. They use a different XML root element than process jobs.

### XML Root

```xml
<xmi:XMI xmlns:model="http://www.talend.com/joblet.ecore"
          xmlns:TalendProperties="http://www.talend.org/properties">
  <model:JobletProcess defaultContext="Default" jobType="Standard">
    <context name="PROD">
      <contextParameter name="connection_activemq_broker" type="id_String" value="localhost" />
      <contextParameter name="connection_activemq_password" type="id_Password"
        value="enc:system.encryption.key.v1:..." />
    </context>

    <!-- Components (same t* components as process jobs) -->
    <node componentName="tRESTClient" .../>
    <node componentName="tJavaRow" .../>

    <!-- Connections (same types as process jobs) -->
    <connection connectorName="FLOW" source="..." target="..." />
  </model:JobletProcess>
</xmi:XMI>
```

### Key Differences from Process Jobs

| Aspect | Process Job | Joblet |
|--------|------------|--------|
| Root element | `talendfile:ProcessType` | `model:JobletProcess` inside `xmi:XMI` |
| Namespace | `talendfile` | `model` (http://www.talend.com/joblet.ecore) |
| Placeholders | None | INPUT, OUTPUT, TRIGGER_INPUT, TRIGGER_OUTPUT |
| Standalone execution | Yes | No — must be embedded in a process job |

### Placeholder Components

Joblets define INPUT/OUTPUT/TRIGGER_INPUT/TRIGGER_OUTPUT placeholder components that map to the embedding job's data flow:

| Placeholder | Purpose |
|-------------|---------|
| `INPUT` | Receives data from the parent job's upstream component |
| `OUTPUT` | Sends data back to the parent job's downstream component |
| `TRIGGER_INPUT` | Receives trigger signals (SUBJOB_OK, etc.) |
| `TRIGGER_OUTPUT` / `TRIGGER_OUTPUT_1` | Sends trigger signals to parent job |

### How Joblets Appear When Referenced

When a process job uses a joblet, the joblet name appears as a `componentName` in the parent job's XML. The joblet's internal components are embedded transparently.

### Connection Types in Joblets

Joblets use the same connection types as process jobs: FLOW, ITERATE, COMPONENT_OK, COMPONENT_ERROR, SUBJOB_OK.

### Extraction

```
Glob: joblets/**/*.item
```

Parse each as `model:JobletProcess`. Extract components, connections, and context variables using the same patterns as process jobs (see `talend-jobs.md`).

## Routelet Structure

Routelets are reusable route fragments — the route equivalent of joblets.

### Key Characteristics

- Located in `routelets/` directory
- Same XML root as routes: `talendfile:ProcessType` with c\* Camel components
- Designed for reuse — embedded in other routes
- Cannot be connected to other components externally (self-contained fragment)
- May be empty in some workspaces

### Extraction

```
Glob: routelets/**/*.item
```

Parse as route fragment using the same c\* component patterns described in this guide.

## Building the ESB Call Graph

The ESB call graph connects routes → jobs → routes, extending the DI call graph from `talend-jobs.md`.

### Algorithm

1. **Parse routes:** Glob `routes/**/*.item`, find all `cTalendJob` nodes
2. **Build route-to-job edges:** Extract `SELECTED_JOB_NAME` → create `route → job` adjacency
3. **Build route-to-route edges:** Find `cDirect` connections → create `route → route` adjacency
4. **Identify route entry points:** Routes with `cREST` or `cJMS` consumer endpoints
5. **Merge with DI call graph:** Combine with `tRunJob` adjacency from `talend-jobs.md`
6. **Trace complete chains:**
   ```
   Route[cREST] → Route[cTalendJob] → Job[tRouteInput...tRouteOutput] → Route
                                        ↓ (via tRunJob)
                                        Job → Job → Job
   ```
7. **Identify full entry-to-exit paths:** From route entry (cREST/cJMS) through all job chains to terminal jobs

### Merged Graph Format

```
{
  route_to_job: { "RouteName": [("JobName", context_vars), ...] },
  route_to_route: { "RouteName": ["OtherRouteName", ...] },
  job_to_job: { "JobName": [("ChildJobName", context_vars), ...] },
  entry_points: ["RouteName_with_cREST", "RouteName_with_cJMS"],
  terminals: ["JobName_with_no_children"]
}
```

## Route-Specific Grep Patterns

```
# All Camel components (c* prefix)
componentName="c[A-Z]

# Route-to-job bindings
cTalendJob|SELECTED_JOB_NAME

# Route endpoints (entry points)
componentName.*cREST|componentName.*cJMS

# Route connections
connectorName="ROUTE"|connectorName="ROUTE_WHEN"

# Message routing components
cMessageRouter|cSplitter|cWireTap

# Generic Camel component wrappers
cMessagingEndpoint

# Internal route endpoints
componentName.*cDirect

# Joblet definitions
model:JobletProcess

# Joblet references in process jobs
componentName="j[A-Z]
```

## Known Route-Specific Patterns

### wireTap for Intentional-Failure Isolation

`cWireTap` can be used to isolate intentional-failure paths from the main route. When a route needs to test or probe an endpoint that may fail (e.g., checking if a resource exists before creating), wireTap sends a copy of the message to the probe path without affecting the main flow. If the probe path fails, the main route continues uninterrupted. Look for this pattern when mapping error handling - the wireTap failure is by design, not a gap.

### Two-Condition Sync Gates

ESB routes may implement synchronization gates using two `cMessageRouter` conditions in sequence - one checking for completion of process A and another for process B. Both must be satisfied before the route continues. This pattern appears as two consecutive ROUTE_WHEN connections with AND semantics. When building the call graph, note these as synchronization points rather than simple conditional branches.
