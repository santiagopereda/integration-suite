# Agent Memory: agent-integration-assessor

**Last Updated**: 2026-02-20
**Patterns From**: 2 projects (Talend-Reviewer, UniQure)
**Total Patterns**: 4

---

## Assessment Methodology Patterns

### ASM-001: Three-Source Methodology for Accurate Scoring
- **Pattern**: Static workspace analysis alone overestimates operational maturity. 4 major architectural details were wrong from code alone. Runtime data changed 4 of 8 dimension scores. Developer walkthrough corrected all 4 architecture errors in 30 minutes.
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: Always use three-source methodology: static export analysis → runtime data enrichment → developer walkthrough. Score only after all three sources confirm findings.
- **Tags**: talend, assessment-methodology

### ASM-002: Verify Issues Before Implementing — High False Positive Rate
- **Pattern**: 43% of validated issues (6/14) in Phase 0 validation were false positives. Platform security features (Workato AES-256, concurrency=1) and API design (self-terminating pagination) already handled flagged concerns.
- **Source**: UniQure (2026-01-23)
- **Action**: Always verify identified issues against actual platform capabilities before recommending fixes. Research platform security features first. Expect 30-50% false positive rate in static analysis findings.
- **Tags**: workato, assessment-methodology

---

## Dimension-Specific Patterns

### DIM-001: Runtime Data Essential for Operational Dimensions
- **Pattern**: Dimensions D3 (Operational Excellence), D4 (Reliability), D7 (Maintainability), D8 (Scalability) cannot be accurately scored from static analysis alone. TMC runtime data changed all four dimension scores.
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: Flag D3, D4, D7, D8 as "requires runtime validation" when scoring from static data only. Note confidence level as low for these dimensions without runtime evidence.
- **Tags**: talend, dimension-specific

---

## Data Source Patterns

### SRC-001: TMC Observability is DI-Only
- **Pattern**: TMC component execution metrics return empty for ESB routes (Camel microservices). Only DI jobs have TMC-level observability. ESB runtime monitoring requires custom solutions.
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: When assessing TMC-monitored environments, note that ESB route metrics require alternative data sources (custom Prometheus, application logs). Do not assume TMC covers all artifact types.
- **Tags**: talend, data-sources
