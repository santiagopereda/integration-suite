# Agent Memory: Shared Patterns

**Last Updated**: 2026-02-21
**Patterns From**: 9 projects (Talend-Reviewer, Client-B-Debug, Client-A, Agentic, GLInet-BE3600, RaspberryPi, CV-Generator-Agent, Survival, TMC-API)
**Total Patterns**: 22

---

## Universal Patterns

### UNI-001: Structured Agent Pipelines Produce Consistent Artifacts
- **Pattern**: The full analyzer→assessor→scorer→reviewer→doc-specialist pipeline produced consistent, cross-referenced artifacts on the first run. Pipeline structure enforces quality that ad-hoc invocation misses.
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: Use structured agent pipelines for complex multi-artifact workflows. Define the handoff sequence and ensure each stage consumes the previous stage's output.
- **Tags**: integration, pipeline

### UNI-002: Templates Need Real-World Refinement
- **Pattern**: 11 gaps in the Talend parsing guide only surfaced during the first real customer analysis. Synthetic testing and design-time review cannot catch platform-specific edge cases.
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: Treat the first real engagement as template validation. Plan for iterative refinement during first use rather than expecting templates to be complete on day one.
- **Tags**: integration, verification

### UNI-003: MCP Server as Agent Capability Extension
- **Pattern**: Building a TMC MCP server gave agents access to live runtime data, transforming assessment from code-level inference to evidence-based scoring. The server became reusable across engagements.
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: When agents need external system data, build an MCP server rather than manual data collection. MCP servers make capabilities reusable and composable across projects.
- **Tags**: talend, agent-capability

### UNI-004: Export Configs Before Debugging
- **Pattern**: Baseline configuration exports on day 1 revealed a dual-JVM architecture (Runtime vs Remote Engine) that was not obvious from documentation. Side-by-side comparison prevented wasted effort targeting the wrong component.
- **Source**: Client-B-Debug (2026-02-12)
- **Action**: Export and baseline all environment configurations before starting debugging or assessment. Compare configurations across instances to reveal architectural insights.
- **Tags**: talend, process

### UNI-005: Document Experiments in Real Time
- **Pattern**: A 200-line experiment log capturing 6 fix options (A/C/D/E/F + Studio) prevented repeated testing of failed approaches. Writing results during testing captured details lost if documented later.
- **Source**: Client-B-Debug (2026-02-12)
- **Action**: Document each debugging attempt immediately with hypothesis, steps, and result. Failed approaches are as valuable as successes — they prevent rework and inform the next attempt.
- **Tags**: debugging, process

### UNI-006: Create Preemptive Documentation for Patterns Not Yet Broken
- **Pattern**: POST-Method-Fix.md was created before POST broke, providing a ready reference with decision tree for all failure modes. When the issue eventually surfaces, the team has immediate guidance.
- **Source**: Client-B-Debug (2026-02-12)
- **Action**: After resolving an issue for one HTTP method/pattern, proactively document the equivalent fix for related methods/patterns that may break in the future.
- **Tags**: documentation, process

### UNI-007: Verify Before Implementing — False Positive Rate Can Be High
- **Pattern**: 43% of validated issues were false positives that would have wasted ~4 days of implementation work. Platform security features (encryption, concurrency controls, API design) often already handle flagged concerns.
- **Source**: Client-A (2026-01-23)
- **Action**: Before implementing fixes for identified issues, verify each against actual platform behavior. Prioritize verification of highest-severity items first. Expect significant false positive rates.
- **Tags**: integration, verification

### UNI-008: Audit First, Then Estimate — Prevents Overestimation
- **Pattern**: CRIT-2 documentation clarification completed in 1 day vs. 5 days planned (80% time savings). A comprehensive audit revealed documentation was mostly correct, needing only context additions rather than rewrites.
- **Source**: Client-A (2026-01-23)
- **Action**: Conduct a thorough audit before effort estimation. Understand the actual scope of the gap before committing to a fix plan. Audits frequently reveal less work than assumed.
- **Tags**: integration, process

### UNI-009: Document as You Code — Prevent Drift
- **Pattern**: SDK connector development benefited from immediate documentation updates. Resource files that weren't updated during implementation drifted from actual recipes, causing verification false failures.
- **Source**: Client-A (2026-01-23)
- **Action**: Make documentation updates part of the implementation checklist. Update README and guides immediately after each implementation change, not in batches.
- **Tags**: integration, process

### UNI-010: Establish Baseline Metrics Before Optimizing
- **Pattern**: JSON baseline + current metrics combined with Markdown optimization changelog provided both quantitative measurement and qualitative context. Without baselines, the 51% token reduction would have been unverifiable.
- **Source**: Agentic (2026-01-23)
- **Action**: Document token counts, word counts, and line counts before any optimization. Create both JSON (quantitative) and Markdown (qualitative) tracking files.
- **Tags**: hub, process

### UNI-011: Test Cases Before Implementation Ensure Capability Preservation
- **Pattern**: Having 6-12 test cases per agent before optimization ensured capability preservation could be verified systematically. 100% pass rate (18/18 Phase 1, 12/12 Phase 2) confirmed no regression.
- **Source**: Agentic (2026-01-23)
- **Action**: Define test cases before implementing or optimizing agents. Structural verification after changes validates capability preservation without full invocation testing.
- **Tags**: hub, verification

### UNI-012: Phase-Based Optimization Enables Focus
- **Pattern**: Separating Phase 1 (externalization, 51% reduction) from Phase 2 (alignment, closing 13% gap between agents) allowed targeted optimization with clear success criteria per phase.
- **Source**: Agentic (2026-01-23)
- **Action**: Break optimization into focused phases with clear success criteria. One phase per strategy (externalization, compression, alignment). Measure after each phase.
- **Tags**: hub, process

### UNI-013: Redundancy Across Providers Beats Redundancy Within
- **Pattern**: Bootstrap DNS was initially configured with multiple IPs from the same provider (Quad9). For a travel router operating in countries with DNS restrictions, if Quad9 is blocked, all IPs fail. Provider diversity (Quad9 + Cloudflare + Google) ensures availability.
- **Source**: GLInet-BE3600 (2026-01-23)
- **Action**: When designing redundancy for systems that operate across environments (travel, multi-cloud, multi-region), diversify across providers rather than replicating within a single provider.
- **Tags**: networking, process

### UNI-014: Keep Recovery Paths Open During Changes
- **Pattern**: Before making SSH/firewall changes that could lock out remote access, LuCI via LAN (http://192.168.8.1:8080) was kept as emergency recovery. The `uci changes` / `uci commit` / `uci revert` workflow prevented lockout disasters.
- **Source**: GLInet-BE3600 (2026-01-23)
- **Action**: Before making changes that could block access, verify a backup access method exists and is working. Document recovery procedures before you need them. Never close the last access path until the new one is verified.
- **Tags**: networking, process

### UNI-015: Convert Resolutions to Formal SOPs Immediately
- **Pattern**: After resolving each deployment failure (SSH key, Python version, pyenv detection), an SOP was created immediately while context was fresh. 5 SOPs totaling 3,619 lines with 15-16 item validation checklists became the primary operational reference.
- **Source**: RaspberryPi (2026-01-23)
- **Action**: After resolving any non-trivial issue, immediately document the resolution as a formal SOP with validation checklist and common mistakes section. Include the debugging path that led to the solution.
- **Tags**: ansible, process

### UNI-016: Pin All Dependencies for Hardware-Interface Code
- **Pattern**: Python 3.13 broke dataclass compatibility with mirobot-py (requires 3.9-3.11). bleak 1.1.0 removed `discover()` function, breaking BLE communication. Both were "latest version" defaults that caused silent failures.
- **Source**: RaspberryPi (2026-01-23)
- **Action**: For hardware-interface and robotics code, pin exact versions of runtime (Python 3.9.18), libraries (bleak==0.22.3), and transitive dependencies (async-timeout==4.0.3). Test before any version upgrade.
- **Tags**: ansible, process

### UNI-017: Real Usage Reveals Gaps That Theoretical Design Misses
- **Pattern**: A "Practice" job application (BrainRocket, 58% match) was intentionally low-stakes but revealed the missing recruiter outreach workflow. The second application (Vivid Utilities) benefited from same-day enhancements. Theoretical design had missed the inbound recruiting scenario entirely.
- **Source**: CV-Generator-Agent (2026-01-23)
- **Action**: Test workflows with real but low-stakes cases early. Use the Build → Use → Discover Gaps → Enhance cycle. Don't wait for high-stakes situations to validate workflow completeness.
- **Tags**: workflow, process

### UNI-018: Treat Budget as Optimization Parameter, Not Hard Constraint
- **Pattern**: Initial survival planning treated budget as a hard constraint, limiting options. Reframing budget as an optimization parameter led to a 3-tier approach (Minimum/Recommended/Premium) across all 5 categories, enabling flexible decision-making while maintaining safety baselines.
- **Source**: Survival (2026-01-23)
- **Action**: When scope involves procurement or resource allocation, provide tiered recommendations (minimum viable, recommended, premium) rather than single-tier proposals. Each tier should meet minimum safety/quality standards.
- **Tags**: planning, process

### UNI-019: Validate Feasibility Before Procurement or Implementation
- **Pattern**: A survival project procured comprehensive equipment (67 documents, EUR 5,995 budget) for a 1,400km cycling evacuation without validating route feasibility. Route planning was left incomplete, meaning "no point buying gear for an impossible journey."
- **Source**: Survival (2026-01-23)
- **Action**: Before detailed procurement or implementation work, validate the overall feasibility of the plan. For integrations: validate architecture before building components. For projects: validate requirements before detailed design.
- **Tags**: planning, process

### UNI-020: Lazy Loading Reduces Agent Invocation Cost Without Reducing Capability
- **Pattern**: Template externalization (56% avg token reduction across 3 agents) achieved by separating agent identity/workflow from static reference content. Reference content loaded via Read tool only when the specific task requires it. Zero functionality loss observed.
- **Source**: Agentic Hub (2026-02-21)
- **Action**: Separate agent definitions into: (1) identity + workflow (always load) and (2) reference content/templates (load conditionally via Read tool). Apply to any agent where static reference content exceeds 30% of total definition size.
- **Tags**: agent-optimization, token-efficiency

### UNI-021: Wire Documentation Updates Into the Tool That Produces Source Material
- **Pattern**: Reflection pool files fell behind when updates were manual (key-insights still said "6 projects" after 3 new testimonies). Wiring updates into agent_reflect Step 11 made them automatic and consistent.
- **Source**: Agentic Hub (2026-02-21)
- **Action**: When documentation depends on another artifact (testimony → reflection pool, assessment → memory files), wire the update into the tool that produces the source. Never rely on manual update schedules for dependent documentation.
- **Tags**: process, documentation

### UNI-022: Name the Retrieval Question Before Building the Knowledge Store
- **Pattern**: Reflection pool expansion from 4 to 8 files succeeded because each new file was designed to answer a distinct question: "what worked in situation X?" (value-unlock) vs. "what mental model to enter this domain with?" (eureka-moments) vs. "what reasoning rules to apply before starting?" (thinking-patterns). Without distinct questions, one file would have served all needs poorly.
- **Source**: Agentic Hub (2026-02-21)
- **Action**: Before creating a new knowledge store or index, explicitly state the retrieval question it answers. If two stores answer the same question, merge them. If one store answers multiple questions, split it.
- **Tags**: knowledge-architecture, process
