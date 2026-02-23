# Agent Memory: documentation-specialist

**Last Updated**: 2026-02-21
**Patterns From**: 8 projects (Talend-Reviewer, UniQure, Agentic, GLInet-BE3600, Mirobot, RaspberryPi, CV-Generator-Agent, TMC-API)
**Total Patterns**: 12

---

## Documentation Patterns

### DOC-001: Customer Summary Should Reference Not Duplicate
- **Pattern**: Customer summaries that duplicate detailed assessment findings create drift as artifacts are updated during remediation. Summaries that reference artifacts by name maintain a single source of truth.
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: Structure customer summaries to reference assessment artifacts by name and section. Never copy-paste findings into summaries — link to the source artifacts.
- **Tags**: integration, documentation

### DOC-002: FAQ Sections Proactively Address Common Confusion
- **Pattern**: 13 FAQ questions created for Veeva-Entra unidirectional architecture reduced support burden. Questions focused on "why" (rationale) rather than "what" (facts), addressing confusion before it occurred.
- **Source**: UniQure (2026-01-23)
- **Action**: Add FAQ sections to major workflow and architecture documentation. Focus on "why" questions that address common confusion about design decisions.
- **Tags**: integration, documentation

### DOC-003: Naming Convention Explanations Reduce Confusion
- **Pattern**: "Veeva-Entra" naming implied Veeva is source, but Entra is actually source. A dedicated naming convention document explaining organizational vs. technical naming resolved repeated confusion.
- **Source**: UniQure (2026-01-23)
- **Action**: Document naming conventions with rationale at project start. When names don't align with technical data flow, create a dedicated explanation document.
- **Tags**: integration, documentation

### DOC-004: Recipes Are Source of Truth, Not Resource Files
- **Pattern**: Veeva-Entra VQL resource files were outdated (missing fields) compared to actual Workato recipes. Resource files serve as reference, but actual implementations are authoritative.
- **Source**: UniQure (2026-01-23)
- **Action**: When verifying integrations, always verify against actual platform recipes/implementations, not resource files. Treat resource files as reference documentation only.
- **Tags**: workato, documentation

### DOC-005: Injection History from Day One Provides Invaluable Context
- **Pattern**: Creating injection-history.md from project start provided a complete chronological audit trail of 36 documents across 15+ major entries, making retrospectives and debugging traceable.
- **Source**: Agentic (2026-01-23)
- **Action**: Create injection-history.md on day one of any project. Log every documentation addition with purpose, links, and status. This becomes the primary source for testimony generation.
- **Tags**: hub, documentation

### DOC-006: Consistent Numbered Guide Structure Reduces Cognitive Load
- **Pattern**: A numbered guide structure (00-Index.md, 01-First-Step.md, ..., 0X-Troubleshooting.md) replicated across 6 topic folders created consistent, navigable documentation. The pattern was discovered in the first folder (Tailscale) and mirrored to all subsequent topics.
- **Source**: GLInet-BE3600 (2026-01-23)
- **Action**: When documenting multi-topic systems, establish a numbered guide template from the first topic and replicate across all topics. Include an Index (00) and Troubleshooting (last) in every folder.
- **Tags**: networking, documentation

### DOC-007: Validate Cross-Referenced Files Exist
- **Pattern**: Injection-history.md referenced PHASE*_COMPLETE.md and metrics/ directory files that didn't exist in the filesystem. Cross-references were documented but never validated, creating broken links and false confidence in documentation completeness.
- **Source**: Mirobot (2026-01-23)
- **Action**: Before marking documentation as complete, validate that all cross-referenced files actually exist. Add filesystem validation to documentation review checklists. Referenced files should be created before or simultaneously with the reference.
- **Tags**: hub, documentation

### DOC-008: Parallel Documentation Systems for Human vs AI Audiences
- **Pattern**: Confusion about where to store documentation was resolved by establishing clear separation: `docs/` for human-readable guides and `.agent/` for agent-consumable procedures. Bidirectional cross-references link the two systems without duplication.
- **Source**: RaspberryPi (2026-01-23)
- **Action**: Maintain separate documentation systems for human operators (docs/) and AI agents (.agent/). Use cross-references between systems rather than duplicating content. Each system should be optimized for its audience's consumption patterns.
- **Tags**: ansible, documentation

---

## Testimony Patterns

### DOC-009: Front-Load Strategic Framing Before Tactical Execution
- **Pattern**: Career narrative, self-assessment questionnaires, and 7 STAR stories were created before any job applications. When applications started 5 days later, response drafting was immediate because positioning was already articulated. Per-application effort dropped significantly.
- **Source**: CV-Generator-Agent (2026-01-23)
- **Action**: Before executing tactical work (applications, implementations, deployments), invest in strategic documentation first — positioning narratives, architecture decisions, design rationale. This front-loading reduces per-instance effort and improves consistency.
- **Tags**: workflow, documentation

---

## Deliverable Patterns

### DLV-001: Produce Improvement Roadmap Even for Quick Assessments
- **Pattern**: Even a quick assessment benefits from a prioritized action list. The Vaxxinova roadmap (31 items across 6 sprints with P0-P4 categories) became the primary engagement driver beyond the initial scoring.
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: Always produce an improvement roadmap with priority levels and sprint/phase assignments, even for short engagements. The roadmap often becomes more valuable than the score.
- **Tags**: integration, deliverables

### DOC-010: Testimony Is the Compounding Mechanism — Invest in the Tool
- **Pattern**: agent_reflect evolved from a one-shot documentation tool (v1.0) to a complete compounding cycle (v1.6) in 29 days. Each version added one downstream action (dual-write → pattern extraction → memory updates → reflection pool enforcement). The compounding value came from the tool investment, not from individual testimony quality.
- **Source**: Agentic Hub (2026-02-21)
- **Action**: Treat the testimony/reflection command as a primary investment target. Each extension to the tool compounds across all future testimonies. Prioritize adding downstream actions (pattern routing, memory writes, index updates) over improving testimony formatting.
- **Tags**: process, compounding

### DOC-011: Differentiate Update Cadences by Evidence Requirements
- **Pattern**: Reflection pool files have different evidence thresholds: quotable insights qualify from one project (per-testimony); reasoning heuristics require cross-project validation (every 3-4 projects). Applying the same per-testimony cadence to heuristics produces premature generalization.
- **Source**: Agentic Hub (2026-02-21)
- **Action**: When defining an update cadence for a documentation file, ask: "what is the minimum evidence required before this content qualifies?" Per-testimony: one project is sufficient. Cross-project synthesis: wait for 3-4 projects and synthesize deliberately. Mark files explicitly with their cadence.
- **Tags**: documentation, process
