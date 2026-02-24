# Integration Maturity Scoring Rubric

8-Dimension framework aligned with Gartner Integration Maturity Model.
Score each dimension 1-5 based on evidence from the assessment.

## Maturity Levels

| Level | Name | Description |
|-------|------|-------------|
| 5 | Augmented | AI-assisted, self-healing, predictive analytics, continuous optimization |
| 4 | Balanced | Automated governance, proactive monitoring, resilience patterns, well-documented |
| 3 | Centralized | Standardized patterns, centralized management, documented, monitored |
| 2 | Enlightened | Some standards, basic monitoring, ad-hoc governance, aware of gaps |
| 1 | Ad hoc | Undocumented, reactive, point solutions, minimal oversight |

## Scoring Guidelines

- Score based on **evidence**, not potential or intentions
- If evidence is insufficient, mark as "Needs Assessment" (N/A)
- Use the **lowest applicable score** when criteria span multiple levels
- Document evidence for each score

---

## Dimension 1: Architecture & Design (Weight: HIGH)

| Score | Criteria | Evidence Required |
|-------|----------|-------------------|
| 1 | Point-to-point connections, no pattern, tight coupling, hardcoded endpoints | Direct connections between systems, no abstraction |
| 2 | Some patterns identified, basic API usage (Richardson Level 0-1), mixed coupling | Simple REST calls, some reusable components |
| 3 | Consistent pattern (hub-spoke or API-led), Richardson Level 2, loose coupling for most integrations | Documented architecture, API gateway, standard connectors |
| 4 | API-led connectivity (System/Process/Experience), event-driven where appropriate, Richardson Level 2-3, fully decoupled | HATEOAS or event bus, canonical models, service mesh |
| 5 | Adaptive architecture, self-describing APIs, automated pattern selection, AI-assisted routing | Dynamic routing, auto-scaling patterns, ML-based optimization |

**Red Flags**: >20% point-to-point, services can't deploy independently, all synchronous, no timeout handling
**Quick Wins**: API documentation, introduce gateway, decouple hardcoded endpoints

## Dimension 2: Data Quality & Governance (Weight: HIGH)

| Score | Criteria | Evidence Required |
|-------|----------|-------------------|
| 1 | No schema management, ad-hoc field mappings, no validation, multiple sources of truth | Undocumented schemas, data quality issues in production |
| 2 | Basic schema documentation, some validation rules, informal data ownership | Spreadsheet-based mapping docs, manual validation |
| 3 | Schema versioning (semver), canonical data model for key entities, data contracts between teams | Schema registry or version-controlled schemas, validation middleware |
| 4 | Automated schema evolution (forward/backward compatible), comprehensive data contracts, MDM alignment | Schema registry with compatibility modes, automated validation pipeline |
| 5 | AI-assisted data quality, predictive schema evolution, automated data lineage, self-healing data pipelines | ML-based anomaly detection, automated remediation |

**Red Flags**: Schema changes breaking production, >50% complex transformations, no rollback capability
**Quick Wins**: Document schemas, add basic validation, version control mapping specs

## Dimension 3: Operational Excellence (Weight: CRITICAL)

| Score | Criteria | Evidence Required |
|-------|----------|-------------------|
| 1 | No monitoring, no logging standards, errors discovered by end users, no alerting | Reactive incident response, no dashboards |
| 2 | Basic logging, some metrics, manual alerting, no correlation IDs | Application logs exist, basic health checks |
| 3 | Structured logging, 3-pillar observability (logs/metrics/traces), automated alerting, SLA tracking | Correlation IDs, dashboards, alert rules, SLO definitions |
| 4 | Full observability stack (OpenTelemetry), proactive alerting, error budgets, runbooks for all scenarios | Distributed tracing, SLI/SLO dashboards, automated escalation |
| 5 | AIOps, predictive anomaly detection, self-healing, automated root cause analysis | ML-based alerting, auto-remediation, chaos engineering |

**Red Flags**: No monitoring, no DLQ, failed messages disappear, metrics not accessible
**Quick Wins**: Add structured logging, basic alerting on error rates, correlation IDs

## Dimension 4: Reliability & Resilience (Weight: CRITICAL)

| Score | Criteria | Evidence Required |
|-------|----------|-------------------|
| 1 | No retry logic, no error handling, single point of failure, no DR plan | Integration fails on any transient error |
| 2 | Basic retry (fixed interval), some error handling, manual recovery, DR plan exists but untested | Retry config exists, error logs reviewed manually |
| 3 | Exponential backoff with jitter, circuit breakers on external calls, idempotent operations, DLQ for failed messages | Retry policies documented, circuit breaker config, DLQ monitoring |
| 4 | Comprehensive resilience patterns (bulkhead, timeout, fallback), tested DR plan, chaos engineering | DR tested quarterly, failure mode analysis, automated failover |
| 5 | Self-healing systems, predictive failure detection, zero-downtime deployments, multi-region active-active | Automated chaos testing, predictive scaling, <1min RTO |

**Red Flags**: No retry logic, non-idempotent operations with at-least-once delivery, no circuit breakers, DR untested >1 year
**Quick Wins**: Add retry with backoff, implement idempotency keys, document DR plan

## Dimension 5: Security & Compliance (Weight: CRITICAL)

| Score | Criteria | Evidence Required |
|-------|----------|-------------------|
| 1 | Plaintext credentials, no encryption, no audit trail, hardcoded API keys | Credentials in code/config, HTTP endpoints |
| 2 | Basic auth, TLS for external calls, some audit logging, secrets in config files (not code) | HTTPS endpoints, basic access logs |
| 3 | OAuth 2.0 or modern auth, TLS 1.2+ everywhere, secrets in vault, comprehensive audit trail | OAuth config, vault integration, audit log retention |
| 4 | Zero-trust architecture, mTLS, automated compliance scanning, PII encryption at rest, GDPR/HIPAA controls | Certificate management, compliance reports, data classification |
| 5 | Continuous compliance monitoring, automated threat detection, security-as-code, zero-knowledge architecture | SIEM integration, automated remediation, pen test results |

**Red Flags**: Plaintext credentials anywhere, TLS <1.2, PII without encryption, no audit trail
**Quick Wins**: Move secrets to vault, enable TLS 1.2+, add audit logging

## Dimension 6: Business Impact (Weight: MEDIUM)

| Score | Criteria | Evidence Required |
|-------|----------|-------------------|
| 1 | No criticality classification, unknown cost of failure, no dependency mapping | No documentation, ad-hoc understanding |
| 2 | Informal criticality awareness, basic dependency knowledge, no BIA | Team knowledge of importance, informal escalation |
| 3 | Formal criticality tiers (Tier 1/2/3), documented dependencies, RTO/RPO defined | BIA document, dependency diagram, SLA agreements |
| 4 | Quantified cost of failure ($/hour), automated dependency mapping, change impact analysis | Financial impact model, automated discovery, impact scoring |
| 5 | Real-time business impact dashboards, predictive impact analysis, automated risk scoring | Live KPI correlation, ML-based risk assessment |

**Red Flags**: Tier-1 integration without DR, SPOF for revenue process, cost of failure unknown
**Quick Wins**: Classify criticality tier, document top dependencies, estimate downtime cost

## Dimension 7: Maintainability & Scalability (Weight: MEDIUM)

| Score | Criteria | Evidence Required |
|-------|----------|-------------------|
| 1 | No tests, manual deployment, no documentation, can't scale | Undocumented, deployed by hand, single instance |
| 2 | Some unit tests (<50%), semi-automated deployment, basic docs | Partial test coverage, deployment scripts |
| 3 | Test pyramid (unit >80%, integration, E2E), CI/CD pipeline, architecture docs, horizontal scaling | Pipeline config, test reports, scaling config |
| 4 | Full CI/CD with automated rollback, <10min pipeline, auto-scaling, comprehensive runbooks | Blue-green deploy, auto-scale policies, runbook library |
| 5 | GitOps, canary deployments, automated capacity planning, self-documenting systems | Progressive delivery, ML-based capacity, auto-generated docs |

**Red Flags**: No tests, manual deployment, no rollback, can't meet current demand
**Quick Wins**: Add integration tests, automate deployment, document architecture

## Dimension 8: Tool & Platform Assessment (Weight: LOW)

| Score | Criteria | Evidence Required |
|-------|----------|-------------------|
| 1 | Platform can't support required patterns, massive over-engineering, no skills in team | Mismatched capabilities, workarounds everywhere |
| 2 | Platform partially fits, some workarounds needed, basic team skills | Capability gaps documented, training in progress |
| 3 | Platform fits requirements, acceptable lock-in, team proficient, TCO understood | Fit analysis, training complete, TCO documented |
| 4 | Platform optimally used, alternatives evaluated, migration path exists, TCO optimized | Feature utilization report, alternatives doc, cost optimization |
| 5 | Multi-platform strategy, zero lock-in risk, deep expertise, continuous optimization | Portability layer, cross-platform skills, automated optimization |

**Red Flags**: Platform can't support critical patterns, vendor switching cost >$1M, no skills in team
**Quick Wins**: Document platform fit, identify alternatives, plan training

---

## Overall Maturity Calculation

**Weighted Average Formula:**

```
Overall = (
  Architecture * 2 +
  Data Quality * 2 +
  Operational Excellence * 3 +
  Reliability * 3 +
  Security * 3 +
  Business Impact * 1.5 +
  Maintainability * 1.5 +
  Platform * 1
) / 17
```

**Overall Level Mapping:**

| Average Score | Level | Label |
|---------------|-------|-------|
| 4.5 - 5.0 | 5 | Augmented |
| 3.5 - 4.4 | 4 | Balanced |
| 2.5 - 3.4 | 3 | Centralized |
| 1.5 - 2.4 | 2 | Enlightened |
| 1.0 - 1.4 | 1 | Ad hoc |

## Risk Classification

| Overall Score | Risk Level | Action |
|---------------|------------|--------|
| < 2.0 | Critical | Immediate remediation plan required |
| 2.0 - 2.9 | High | Prioritized improvement roadmap needed |
| 3.0 - 3.9 | Medium | Targeted improvements recommended |
| 4.0+ | Low | Maintain and optimize |
