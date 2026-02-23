# Red Flags Library

Common critical issues found during integration assessments. Use for pattern matching.

## Security Red Flags

| ID | Red Flag | Dimension | Severity | Impact |
|----|----------|-----------|----------|--------|
| SEC-01 | Plaintext credentials in code or config | Security | Critical | Credential exposure, breach risk |
| SEC-02 | No TLS or TLS < 1.2 | Security | Critical | Data interception risk |
| SEC-03 | No authentication on API endpoints | Security | Critical | Unauthorized access |
| SEC-04 | PII transmitted/stored without encryption | Security | Critical | Compliance violation, data breach |
| SEC-05 | No audit trail for data access | Security | High | Compliance failure, no forensics |
| SEC-06 | Shared credentials across environments | Security | High | Dev/test breach = production breach |
| SEC-07 | Over-permissioned service accounts | Security | High | Blast radius of compromise |

## Reliability Red Flags

| ID | Red Flag | Dimension | Severity | Impact |
|----|----------|-----------|----------|--------|
| REL-01 | No retry logic for external calls | Reliability | Critical | Transient failures cause data loss |
| REL-02 | Non-idempotent operations (duplicates on retry) | Reliability | Critical | Data corruption, double-processing |
| REL-03 | No circuit breaker for external dependencies | Reliability | High | Cascading failure risk |
| REL-04 | No DLQ for failed messages | Reliability | High | Silent data loss |
| REL-05 | No DR plan for Tier-1 integration | Reliability | Critical | Extended outage, business impact |
| REL-06 | DR plan untested > 1 year | Reliability | High | DR may not work when needed |
| REL-07 | Single point of failure (no redundancy) | Reliability | High | One component failure = full outage |

## Operational Red Flags

| ID | Red Flag | Dimension | Severity | Impact |
|----|----------|-----------|----------|--------|
| OPS-01 | No monitoring at all | Operations | Critical | Issues discovered by end users |
| OPS-02 | No alerting on errors | Operations | Critical | Failures go unnoticed |
| OPS-03 | No correlation IDs | Operations | High | Cannot trace request through system |
| OPS-04 | Failed messages disappear (no logging, no DLQ) | Operations | Critical | Undetectable data loss |
| OPS-05 | No SLAs defined | Operations | High | No accountability, no measurement |
| OPS-06 | Alert fatigue (100+ alerts/day) | Operations | High | Real incidents missed |

## Architecture Red Flags

| ID | Red Flag | Dimension | Severity | Impact |
|----|----------|-----------|----------|--------|
| ARC-01 | >20% point-to-point integrations | Architecture | High | Unmaintainable spaghetti |
| ARC-02 | All synchronous, no timeout handling | Architecture | High | Cascading failure risk |
| ARC-03 | Shared database integration | Architecture | High | Tight coupling, schema changes cascade |
| ARC-04 | Distributed monolith | Architecture | Medium | Complexity without benefit |
| ARC-05 | Chatty interface (100+ API calls per operation) | Architecture | Medium | Performance degradation |

## Data Red Flags

| ID | Red Flag | Dimension | Severity | Impact |
|----|----------|-----------|----------|--------|
| DAT-01 | Schema changes breaking production | Data Quality | Critical | Production outage |
| DAT-02 | No schema versioning | Data Quality | High | Breaking changes undetectable |
| DAT-03 | >50% fields require complex transformation | Data Quality | Medium | Maintenance burden, error-prone |
| DAT-04 | Multiple sources of truth | Data Quality | High | Data inconsistency, conflicts |
| DAT-05 | No data validation at integration boundary | Data Quality | High | Bad data propagates |

## Business Impact Red Flags

| ID | Red Flag | Dimension | Severity | Impact |
|----|----------|-----------|----------|--------|
| BIZ-01 | Tier-1 integration without documented RTO/RPO | Business Impact | Critical | No recovery plan for critical system |
| BIZ-02 | SPOF for revenue-generating process | Business Impact | Critical | Revenue loss on failure |
| BIZ-03 | No dependency mapping | Business Impact | High | Unknown blast radius of changes |
| BIZ-04 | Cost of failure unknown | Business Impact | Medium | Cannot prioritize investments |

## Remediation Quick Reference

| Red Flag Pattern | Quick Remediation | Effort |
|-----------------|-------------------|--------|
| Credentials in code | Move to vault/secrets manager | Days |
| No TLS | Enable TLS 1.2+ on all connections | Days |
| No retry | Add exponential backoff (3 retries) | Hours |
| No monitoring | Add structured logging + basic alerting | Days |
| No DLQ | Configure dead letter queue + monitoring | Days |
| No schema versioning | Version-control current schemas | Hours |
| No audit trail | Add audit logging for data access | Days |
