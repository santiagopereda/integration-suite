# Integration Design: [NAME]

**Version**: [X.X]
**Date**: [DATE]
**Designer**: [NAME]
**Type**: [New Design / Improvement Roadmap]
**Assessment Reference**: [Link to assessment]
**Scorecard Reference**: [Link to scorecard]

---

## Overview

**Purpose**: [What this integration does and why]
**Scope**: [What's included and excluded]
**Stakeholders**: [Business owner, technical owner, users]

## Architecture Pattern

**Selected Pattern**: [API-led / Event-driven / Hub-spoke / ETL / Hybrid]
**Rationale**: [Why this pattern fits the requirements]
**Alternatives Considered**: [Other patterns and why not chosen]

### Architecture Diagram

```
[Source System] --> [Integration Layer] --> [Target System]
         |              |                      |
         v              v                      v
    [Trigger]    [Transform/Route]        [Deliver]
```

## Data Design

### Canonical Data Model

```json
{
  "entity": "[EntityName]",
  "version": "[X.X]",
  "fields": [
    {"name": "", "type": "", "required": true, "description": ""}
  ]
}
```

### Mapping Specifications

| Source Field | Source Type | Transformation | Target Field | Target Type | Notes |
|-------------|-----------|---------------|-------------|-----------|-------|
| | | [Direct / Lookup / Formula / Conditional] | | | |

### Schema Versioning Strategy

- Approach: [Semantic versioning / Date-based]
- Compatibility: [Forward / Backward / Full]
- Evolution: [Add fields, deprecate, never remove]

### Validation Rules

| Rule | When | Action on Failure |
|------|------|-------------------|
| Required fields | Pre-send | Reject with error |
| Format validation | Pre-send | Transform or reject |
| Reference data | Pre-send | Lookup or default |
| Business rules | Post-receive | Alert and queue |

## Flow Design

### Normal Flow (Happy Path)

1. **Trigger**: [Event/Schedule/API call]
2. **Extract**: [Read from source, apply filters]
3. **Transform**: [Apply mappings, validations, enrichments]
4. **Load**: [Write to target, confirm delivery]
5. **Confirm**: [Acknowledgment, status update]

### Error Flow

1. **Transient Error**: [Retry with exponential backoff]
2. **Validation Error**: [Log, skip record, continue batch]
3. **System Unavailable**: [Circuit breaker opens, queue messages]
4. **Permanent Error**: [Route to DLQ, alert support]

## Error Handling Strategy

### Retry Logic

| Scenario | Strategy | Max Attempts | Backoff | Timeout |
|----------|----------|-------------|---------|---------|
| API timeout | Exponential backoff | 3 | 1s, 2s, 4s | 30s |
| Rate limited | Fixed delay | 5 | 60s | 300s |
| Auth failure | No retry | 1 | N/A | N/A |
| Server error (5xx) | Exponential | 3 | 2s, 4s, 8s | 60s |

### Dead Letter Queue

- **When to DLQ**: After max retries exhausted, poison messages, permanent failures
- **Monitoring**: Alert on DLQ depth > [threshold]
- **Reprocessing**: Manual review then replay or discard
- **Retention**: [7/14/30 days]

### Circuit Breaker

- **Open after**: [N] consecutive failures or [X]% error rate in [Y] seconds
- **Half-open**: Try 1 request after [Z] seconds cooldown
- **Close after**: [N] consecutive successes

## Monitoring & Observability

### Logging Strategy

| Level | What to Log | Example |
|-------|------------|---------|
| INFO | Business events | "Processed 150 records, 148 success, 2 failed" |
| WARN | Recoverable issues | "Retry attempt 2/3 for record X" |
| ERROR | Failures requiring attention | "Circuit breaker opened for [target]" |
| DEBUG | Technical details | Request/response payloads (sanitized) |

- **Correlation ID**: Generated at entry, passed through all steps
- **Structured format**: JSON with standard fields (timestamp, correlationId, step, status)

### Metrics (RED Method)

| Metric | Description | Alert Threshold |
|--------|-------------|-----------------|
| Rate | Messages processed/minute | < [X] for [Y] minutes |
| Errors | Error rate percentage | > [X]% for [Y] minutes |
| Duration | Processing time P50/P95/P99 | P95 > [X] seconds |
| Queue Depth | Messages waiting | > [X] for [Y] minutes |
| DLQ Depth | Failed messages | > 0 |

### Dashboards

1. **Operations**: Throughput, error rate, latency, queue depth
2. **Business**: Records processed, success rate, SLA compliance
3. **Health**: System availability, circuit breaker status, resource usage

## Security Design

### Authentication & Authorization

| Connection | Auth Method | Details |
|-----------|------------|---------|
| Source API | [OAuth 2.0 / API Key / mTLS] | [Scope/key rotation policy] |
| Target API | [OAuth 2.0 / API Key / mTLS] | [Scope/key rotation policy] |
| Internal | [mTLS / Service account] | [Certificate rotation] |

### Encryption

- **In Transit**: TLS 1.2+ (TLS 1.3 preferred)
- **At Rest**: [AES-256 if data is stored, N/A if pass-through]
- **Secrets**: [Vault / Parameter Store / Key Vault] - never in code or config

### Audit Trail

| Event | Logged Fields | Retention |
|-------|--------------|-----------|
| Authentication | Timestamp, principal, result | 90 days |
| Data access | Timestamp, user, resource, action | 1 year |
| Data modification | Timestamp, before/after (hash), user | 1 year |
| Errors | Timestamp, error, context | 90 days |

## Reliability & Resilience

### Idempotency Strategy

- **Approach**: [Idempotency key / Natural key / Upsert]
- **Key**: [Field or generated UUID]
- **Deduplication Window**: [X hours/days]

### Disaster Recovery

| Metric | Target | Current |
|--------|--------|---------|
| RTO (Recovery Time) | [X hours] | [Current or N/A] |
| RPO (Recovery Point) | [X hours] | [Current or N/A] |
| Failover | [Manual / Automatic] | |
| Backup | [Strategy] | |

## Testing Strategy

| Type | Coverage Target | Tools | When |
|------|----------------|-------|------|
| Unit | >80% transformation logic | [Framework] | Every commit |
| Integration | Key flows, error paths | [Framework] | Every PR |
| E2E | Full business scenarios | [Framework] | Pre-release |
| Performance | Load + stress | [Tool] | Pre-release + quarterly |

## Deployment & CI/CD

- **Strategy**: [Blue-green / Canary / Rolling]
- **Pipeline**: Build -> Test -> Stage -> Approve -> Deploy
- **Rollback**: [Automated / Manual] - revert to previous version within [X] minutes
- **Environment Promotion**: Dev -> Test -> Staging -> Production

## Platform Considerations

| Aspect | Details |
|--------|---------|
| Platform | [MuleSoft / Workato / Talend / Boomi / Custom] |
| Rationale | [Why this platform fits] |
| Lock-in Risk | [Low / Medium / High] |
| Portability | [What's portable, what's platform-specific] |
| TCO Estimate | [License + infra + labor per year] |

## Implementation Phases

### Phase 1: MVP ([X weeks])
- Core data flow (happy path)
- Basic error handling (retry + logging)
- Essential monitoring

### Phase 2: Hardening ([X weeks])
- Advanced error handling (DLQ, circuit breaker)
- Full observability (3 pillars)
- Security hardening
- Integration tests

### Phase 3: Optimization ([X weeks])
- Performance tuning
- Auto-scaling
- Advanced monitoring (dashboards, alerting)
- E2E tests + chaos engineering

## Success Criteria

| Metric | Target |
|--------|--------|
| Throughput | [X records/minute] |
| Latency (P95) | [X seconds] |
| Availability | [99.X%] |
| Error Rate | [<X%] |
| Maturity Target | [Level X across all dimensions] |

## Risks & Mitigation

| Risk | Probability | Impact | Mitigation |
|------|------------|--------|------------|
| [Risk description] | [H/M/L] | [H/M/L] | [Strategy] |

## Open Questions

| # | Question | Owner | Due | Status |
|---|----------|-------|-----|--------|
| 1 | [Question] | [Who] | [When] | [Open/Resolved] |
