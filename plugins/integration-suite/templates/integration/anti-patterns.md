# Integration Anti-Patterns Library

Common anti-patterns to check for during design review.

## Architecture Anti-Patterns

### Point-to-Point Spaghetti
**Symptoms**: N systems with N*(N-1)/2 direct connections, each with custom logic
**Impact**: Unmaintainable, changes cascade, no central visibility
**Remediation**: Introduce hub (iPaaS/ESB) or API-led connectivity layer

### Distributed Monolith
**Symptoms**: Microservices that must deploy together, shared databases, synchronized releases
**Impact**: Worst of both worlds - distributed complexity without independence
**Remediation**: Identify boundaries, decouple with APIs/events, separate data stores

### Shared Database Integration
**Symptoms**: Multiple systems reading/writing same database tables directly
**Impact**: Tight schema coupling, change in one breaks others, no encapsulation
**Remediation**: API layer over database, event-driven sync, CQRS

### Synchronous Chaining
**Symptoms**: Service A calls B calls C calls D synchronously, latency = sum of all
**Impact**: Cascading failures, latency multiplication, fragile chain
**Remediation**: Async where possible, circuit breakers, event-driven decoupling

### Chatty Interface
**Symptoms**: Hundreds of small API calls to accomplish one business operation
**Impact**: Network overhead, latency, rate limit exhaustion
**Remediation**: Batch endpoints, GraphQL, coarse-grained APIs, composite services

## Data Anti-Patterns

### Schema-on-Read Without Contracts
**Symptoms**: No schema validation, consumers parse what they get, silent failures
**Impact**: Data quality degradation, debugging nightmare, silent data loss
**Remediation**: Schema registry, data contracts, validation at boundaries

### Golden Source Ambiguity
**Symptoms**: Multiple systems claim to be source of truth for same data
**Impact**: Data conflicts, inconsistency, reconciliation burden
**Remediation**: Define MDM strategy, single source of truth per entity

### Transformation Spaghetti
**Symptoms**: Complex nested transformations with business logic buried in mapping code
**Impact**: Untestable, hard to maintain, hard to debug
**Remediation**: Layered transformations, canonical model, testable transformation functions

## Reliability Anti-Patterns

### Retry Storm
**Symptoms**: All consumers retry simultaneously when service recovers, causing re-failure
**Impact**: Cascading overload, extended outage
**Remediation**: Exponential backoff with jitter, circuit breaker, rate limiting

### Fire-and-Forget Without DLQ
**Symptoms**: Async messages sent with no tracking, failures silently lost
**Impact**: Data loss, inconsistency, no way to detect or recover
**Remediation**: DLQ for failed messages, monitoring on DLQ depth, reprocessing strategy

### Non-Idempotent Operations
**Symptoms**: Retrying an operation creates duplicates or side effects
**Impact**: Duplicate records, double-charging, data corruption
**Remediation**: Idempotency keys, upsert patterns, deduplication logic

### Missing Circuit Breaker
**Symptoms**: Continuous calls to failing service, thread pool exhaustion
**Impact**: Cascading failure, resource exhaustion, entire system degradation
**Remediation**: Circuit breaker pattern (open/half-open/closed), fallback responses

## Security Anti-Patterns

### Credentials in Code
**Symptoms**: API keys, passwords, tokens in source code or config files
**Impact**: Security breach risk, credential exposure in repos/logs
**Remediation**: Vault/secrets manager, environment variables (minimum), never commit secrets

### Over-Permissioned Service Accounts
**Symptoms**: Integration service account has admin access to everything
**Impact**: Blast radius of compromise is entire system
**Remediation**: Least privilege, scoped API keys, role-based access

### Missing Audit Trail
**Symptoms**: No logging of who did what, when, to which data
**Impact**: Compliance failure, forensics impossible, breach undetectable
**Remediation**: Comprehensive audit logging with immutable storage

## Operational Anti-Patterns

### Alert Fatigue
**Symptoms**: Hundreds of alerts firing constantly, team ignores them
**Impact**: Real incidents missed, slow response time
**Remediation**: SLO-based alerting, actionable alerts only, severity tiers

### Log-and-Forget
**Symptoms**: Errors logged but never reviewed or acted upon
**Impact**: Issues accumulate, degradation unnoticed, sudden failure
**Remediation**: Error dashboards, trend monitoring, automated escalation

### Monitoring Gap
**Symptoms**: No visibility into integration health between source and target
**Impact**: Black box operations, issues discovered by end users
**Remediation**: 3-pillar observability (logs/metrics/traces), end-to-end correlation
