# Agent Memory: agent-integration-designer

**Last Updated**: 2026-02-20
**Patterns From**: 6 projects (Talend-Reviewer, Vaxxinova-Debug, UniQure, Agentic, GLInet-BE3600, Mirobot)
**Total Patterns**: 11

---

## Architecture Patterns

### ARC-001: Agent Pipeline Enforces Assessment Thoroughness
- **Pattern**: The analyzer→assessor→scorer→reviewer→doc-specialist pipeline produced 5 cross-referenced artifacts in a single day. Each agent checks dimensions the previous might miss, creating layered validation.
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: Design integration assessments as sequential agent pipelines. Each stage should consume and validate the previous stage's output. Do not skip agents.
- **Tags**: integration, architecture

### ARC-002: Dual-JVM Karaf Architecture — Runtime vs Remote Engine
- **Pattern**: Enterprise Talend ESB runs two separate JVM instances: Runtime (executes routes/jobs) and Remote Engine (handles deployment from TMC). Configuration changes must target the correct JVM.
- **Source**: Vaxxinova-Debug (2026-02-12)
- **Action**: When diagnosing Talend ESB issues, identify which JVM to target. Export and compare both wrapper.conf files. Runtime executes business logic; Remote Engine manages deployment.
- **Tags**: talend, architecture

### ARC-003: Knowledge Base Three-Pillar Structure Mirrors Agent Workflow
- **Pattern**: A .agent/ knowledge base with tasks/ (PRDs, plans), system/ (schemas, APIs, integrations), and sops/ (procedures) supported 3 parallel integrations with consistent standards. The structure mirrors agent workflow stages: context → execution → validation → learning.
- **Source**: UniQure (2026-01-23), Mirobot (2026-01-23)
- **Action**: Structure project knowledge bases with the three-pillar model: tasks (what to do), system (how things work), sops (how to do things). This separation of concerns enables multi-integration scaling and maps naturally to agent workflow stages.
- **Tags**: integration, architecture

### ARC-004: Template Externalization Pattern — 51-59% Token Reduction
- **Pattern**: Static reference content (templates, checklists, patterns) extracted to `.agent/templates/` and loaded on-demand via Read tool achieved 51-59% token reduction across agents while maintaining 100% test coverage.
- **Source**: Agentic (2026-01-23)
- **Action**: When designing agents, externalize static content exceeding ~100 words into loadable templates. Agent definitions should contain identity, constraints, and workflow only. Reference content belongs in external files.
- **Tags**: hub, architecture

### ARC-005: Travel/Edge Devices Are Clients Not Servers
- **Pattern**: A three-layer VPN architecture (Tailscale + WireGuard server + NordVPN) was planned for a travel router. WireGuard server was impractical — hotel NAT/CGNAT blocks all incoming connections. Simplified to two-layer client-only model.
- **Source**: GLInet-BE3600 (2026-01-23)
- **Action**: When designing for edge/travel/mobile devices, assume client-only operation. All "server" functions should run on infrastructure with stable public IPs. Design architectures that work behind NAT.
- **Tags**: networking, architecture

---

## Design Patterns

### PAT-001: java.net.http.HttpClient as Universal HTTP Fallback in Talend
- **Pattern**: When tRESTClient fails for HTTP method issues (PATCH 405 due to CXF/HttpURLConnection), tJavaFlex with Java 17's built-in HttpClient works in both Studio and Karaf without external JARs or OSGi configuration.
- **Source**: Vaxxinova-Debug (2026-02-12)
- **Action**: When tRESTClient has method-related failures, replace with tJavaFlex using java.net.http.HttpClient. This bypasses CXF and HttpURLConnection limitations entirely.
- **Tags**: talend, design-patterns

### PAT-002: Generic API Action Design Enables Endpoint Reuse
- **Pattern**: The OData v4 GET action was designed generically (user provides service path) rather than Bank-API-specific. This made it immediately reusable for any v4 endpoint without code changes.
- **Source**: UniQure (2026-01-23)
- **Action**: When building API connector actions, design with dynamic path/entity inputs rather than hardcoding specific endpoints. Generic designs enable reuse without modification.
- **Tags**: sap, design-patterns

### PAT-003: Output Modes Improve User Experience
- **Pattern**: Three output modes (Brief 300-500 / Standard 1,000-2,000 / Detailed 2,000-4,000 words) give users explicit control over response verbosity and prevent over-generation.
- **Source**: Agentic (2026-01-23)
- **Action**: Include output mode controls (Brief/Standard/Detailed) in agents where response length varies significantly. Make Standard the default.
- **Tags**: hub, design-patterns

### PAT-004: Document Vendor Fork Behavioral Differences
- **Pattern**: GL.iNet patches AdGuard Home with `--glinet` flag requiring Admin-Token cookie for all API access, blocking standard Prometheus integration. These vendor modifications had no documentation and caused unexpected failures.
- **Source**: GLInet-BE3600 (2026-01-23)
- **Action**: When using vendor forks of open-source projects, explicitly document where vendor behavior differs from upstream. Test standard integrations early — vendor patches may silently break them.
- **Tags**: networking, design-patterns

### PAT-005: Conditional Loading Requires Explicit Trigger Rules
- **Pattern**: Template externalization without explicit loading rules causes confusion. Defining precise triggers — "User requests documentation → Load doc template; Before delivery → Load quality checklist; 'SAP-Agiloft' mentioned → Load context.md" — made conditional loading predictable and debuggable.
- **Source**: Mirobot (2026-01-23)
- **Action**: When implementing lazy/conditional loading patterns, document explicit trigger rules for each loadable resource. Use keyword-based, task-based, or phase-based triggers with clear when-to-load conditions.
- **Tags**: hub, design-patterns

---

## Improvement Roadmap Patterns

### IMP-001: Living Artifacts Beat Static Reports
- **Pattern**: Assessment artifacts updated as remediations are applied create a living single source of truth. Score improved 2.17→2.38 in 4 days with tracked sprint assignments (31 items across 6 sprints).
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: Design assessment outputs as living documents with sprint tracking. Update scores and status as fixes land. Include improvement roadmaps with P0-P4 priorities.
- **Tags**: integration, improvement-roadmap
