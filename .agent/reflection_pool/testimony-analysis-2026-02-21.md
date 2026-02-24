# Testimony Analysis — February 2026 Batch

Cross-project pattern synthesis from 3 new project testimonies. Picks up from [testimony-analysis-2026-01-23.md](testimony-analysis-2026-01-23.md) (7 projects, Jan 23 batch).

---

## Projects Analyzed (3)

| Project | Dates | Domain | Primary Output |
|---------|-------|--------|----------------|
| Client-B Debug | Feb 4–12, 2026 | Talend OSGi debugging | tJavaFlex + java.net.http.HttpClient pattern for PATCH method |
| Talend-Reviewer | Feb 14–20, 2026 | Integration assessment lifecycle | Full maturity assessment: static + runtime + walkthrough methodology |
| TMC API MCP Server | Feb 16–17, 2026 | MCP server development | 39 tools, 4 resources, 390 tests, 3 security hardening iterations |

---

## New Success Patterns

Patterns not identified in the Jan 23 batch.

### P14: Two-Phase Assessment Methodology

**Pattern**: Treat static analysis as a first draft, not a conclusion. Follow with runtime enrichment and a developer walkthrough before finalizing any score or recommendation.

**Evidence**:
- Talend-Reviewer: static score 2.41 → runtime-corrected to 2.17 (10% swing)
- Runtime enrichment changed 4 of 8 dimension scores
- Developer walkthrough corrected 4 architectural assumptions that static analysis had wrong

**Application**: Integration assessments, code reviews, any situation where you score or rate a system from code alone. Always distinguish static findings from confirmed runtime behavior.

---

### P15: Phase-Gated Development

**Pattern**: For complex multi-deliverable projects, define formal phases with explicit gates between them. Each phase has a clear objective; no phase begins until the previous gate is cleared.

**Evidence**:
- TMC API MCP Server: MVP (9 tools, 124 tests) → Full Coverage (36 tools, 4 resources, 214 tests) → Integration Testing (46 tests) → Security Hardening (17 findings, 97 tests). 39 tools total, 390 tests, 2 days.
- Security hardening was a separate phase, not concurrent — this prevented regression loops

**Application**: Any project delivering multiple layers (core, coverage, integration, security). Prevents scope creep and ensures each layer is solid before the next begins.

---

### P16: Security as Incremental Feature Work

**Pattern**: Treat each security hardening pass as a feature sprint: findings → fixes → tests → ADR entry → backward compatibility check. Never skip the test or ADR steps.

**Evidence**:
- TMC API MCP Server: 3 security iterations, 17 findings → 97 new tests
  - Iteration 1: SSRF protection, token leakage, path traversal, error sanitization
  - Iteration 2: Configurable log redaction (external JSON patterns file)
  - Iteration 3: Recursive credential scrubbing (preAuthorizedKey discovery)
- All iterations preserved backward compatibility

**Application**: Security work in any project. The 3-iteration structure (core protections → configurability → edge case recursion) is a reusable template.

---

### P17: Code-Level Override in Constrained Runtimes

**Pattern**: When a configuration-level fix fails due to runtime isolation (OSGi, container boundaries, classloader scoping), drop to code using JDK primitives that bypass the embedded framework entirely.

**Evidence**:
- Client-B: tRESTClient silently converts PATCH → POST on Karaf Runtime. Root cause: CXF/HttpURLConnection limitation; each OSGi bundle embeds its own CXF copy — you cannot override it via configuration.
- Solution: tJavaFlex using `java.net.http.HttpClient` (Java 17 JDK built-in). Bypasses bundle CXF entirely. HTTP method sent correctly.
- Failed alternatives: JVM arguments (OSGi bundle isolation), HTTP tunneling (server doesn't honor X-HTTP-Method-Override), CXF transport bundle swap (jobs embed own CXF)

**Application**: Debugging in Talend Karaf Runtime, OSGi-based middleware, any environment where frameworks are bundle-isolated. When 3 configuration-level approaches fail: go to code level with JDK primitives.

---

### P18: ADRs as Institutional Memory

**Pattern**: Document Architecture Decision Records for any significant technical choice, including the alternatives considered and why they were rejected. The "why not" is as important as the "what."

**Evidence**:
- TMC API MCP Server: 5 ADRs in 2 days, covering FastMCP vs. manual registration, security patterns, API quirk handling, test strategy, and credential masking depth
- ADRs prevented revisiting already-decided questions during the project
- ADRs provided future contributors with context they need without reading the full commit history

**Application**: Any project with multiple technical decision points. Create an ADR at the moment of decision, not retrospectively. Include: decision, alternatives considered, rationale, consequences.

---

## New Failure Patterns

Failure patterns not identified in the Jan 23 batch.

### F12: Static Analysis Overconfidence

**Pattern**: Treating static analysis findings as confirmed facts rather than hypotheses that require runtime validation.

**Evidence**:
- Talend-Reviewer: Static score 2.41 presented as the assessment score. Runtime enrichment corrected it to 2.17 (10% swing). 4 of 8 dimension scores changed.
- 4 architectural assumptions were wrong — only a developer walkthrough revealed them
- Recycle bin (.trash) paths contaminated artifact counts, inflating numbers

**Mitigation**: Always flag static scores as "Preliminary — Static Analysis Only." Present confidence levels (HIGH/MEDIUM/LOW) for each finding. Do not finalize any score until runtime data and a domain owner walkthrough have been completed.

---

### F13: API Documentation Trust Failure

**Pattern**: Assuming API documentation accurately describes runtime behavior, leading to test suites that pass but fail in production.

**Evidence**:
- TMC API MCP Server: 12 API quirks discovered, all surviving unit tests. Examples:
  - Connection parameters returned inline (no sub-endpoint as documented)
  - No GET-by-ID for workspaces/environments
  - Schedule API silently ignores filter parameters
  - Execution log status endpoint always returns 404 (fallback required)
  - Lowercase execution status required (contradicting documentation)

**Mitigation**: Budget time for manual testing against production APIs as a mandatory phase. Expect 8–12 behavioral quirks per API integration as a baseline. Document each quirk with reproduction steps immediately.

---

### F14: Expression Context Mismatch in Visual ETL Tools

**Pattern**: Assuming all fields in a visual ETL component share the same expression context, leading to silent failures or wrong output.

**Evidence**:
- Client-B Debug: In Talend tRouteOutput, Header Name field uses raw Java (no expression evaluation), while Body uses Talend expressions. Treating Header Name as an expression context caused silent mismatch.
- Discovery required testing from route context, not standalone component testing

**Mitigation**: When debugging visual ETL components, test each field's expression context independently. Do not assume consistency across fields in the same component. Test from route context, not standalone.

---

## Connections to Jan 23 Patterns

| Jan 23 Pattern | New Evidence | Status |
|----------------|-------------|--------|
| P1: Knowledge Base Structure (injection-history.md 100% usage) | Both Client-B and Talend-Reviewer maintained injection-history throughout | Confirmed |
| P3: Verification Before Implementation (43% false positive rate) | Static scoring 10%+ swing strengthens this — verification rate now extends to assessments | Strengthened |
| P5: Always Test Against Production APIs | 12 TMC API quirks quantifies the magnitude: budget for 8-12 quirks per integration | Quantified |
| P8: Document During Troubleshooting | Client-B: real-time experiment documentation prevented repeated failures — "what didn't work and why" | Reinforced |
| P9: Defense-in-Depth Security | TMC security: 3-iteration structure with tests and ADRs extends the defense-in-depth principle to security hardening workflow | Extended |

---

## Updated Metrics

| Metric | Jan 23 Value | Feb 2026 Update |
|--------|-------------|-----------------|
| False positive rate (static analysis) | 43% (Client-A, business logic) | +10%+ score correction expected for any static-only integration assessment |
| Test coverage achievable | Not measured | 98% achievable with test-first approach (390 tests, 2 days, 39 tools) |
| Security iteration yield | Not measured | ~8-10 findings per dedicated audit iteration; ~32 new tests per iteration |
| API quirks per integration | 1 (SAP BP field behavior) | 8-12 behavioral quirks per API as realistic baseline |
| Developer walkthrough value | Not quantified | 4 wrong assumptions corrected in 30 minutes = prevents days of inference |

---

## Recommendations for Agent Design

Derived from new patterns — concrete design decisions not yet implemented.

**1. API Quirk Documentation Template**
Any agent building API integrations (MCP servers, integration connectors) should use a structured quirk log:
```
| Quirk | Documented Behavior | Actual Behavior | Workaround |
```
Log entries in real-time during development; never defer to post-hoc.

**2. Phase Gate Generalization**
The phase-gated pattern (P15) is generalizable beyond MCP servers. Any agent producing layered deliverables (e.g., agent-ansible-automation: playbook → tests → security hardening) should define phases explicitly and check previous phase completion before advancing.

**3. Static Score Mandatory Flagging** *(partially implemented in assessor/scorer agents)*
The "Preliminary — Static Analysis Only" flag is now in agent-integration-assessor.md and agent-integration-scorer.md. Next: add to `key-insights.md` as the standard wording (done in Feb 2026 batch), and ensure agent-integration-designer treats MEDIUM/LOW confidence findings as unconfirmed when generating roadmap recommendations.

**4. Security Iteration Structure**
The 3-iteration security pattern (core protections → configurability → edge case recursion) should be documented as a reusable template in `.agent/sops/` or `agent-integration-reviewer` memory for use when reviewing security hardening work.

---

**Analyzed**: 2026-02-21
**Total testimonies in pool**: 10 (7 from Jan 23 + 3 from Feb 2026)
**New patterns identified**: 5 success, 3 failure
**Patterns strengthened from Jan 23**: 5
