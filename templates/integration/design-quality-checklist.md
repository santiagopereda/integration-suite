# Design Quality Checklist

Validate before delivering a design document or improvement roadmap.

## Completeness

- [ ] All 8 dimensions addressed in design
- [ ] Requirements from assessment covered
- [ ] NFRs defined (latency, throughput, availability, security)
- [ ] Error scenarios documented (transient, permanent, timeout, auth failure)
- [ ] Testing strategy included (unit, integration, E2E, performance)
- [ ] Migration/deployment plan present
- [ ] Success criteria defined with measurable targets
- [ ] Risks identified with mitigation strategies

## Architecture

- [ ] Pattern selection justified with rationale
- [ ] Alternatives considered and documented
- [ ] Coupling level appropriate (loose preferred)
- [ ] Sync/async choice matches requirements
- [ ] No anti-patterns present (spaghetti, shared DB, chatty interface)

## Data Design

- [ ] Schemas defined (source, target, canonical)
- [ ] Mapping specifications complete (field-level)
- [ ] Transformation logic documented
- [ ] Schema versioning strategy defined
- [ ] Validation rules specified (pre-send, post-receive)

## Error Handling

- [ ] Retry strategy defined (backoff, max attempts, timeout)
- [ ] Circuit breaker configured for external dependencies
- [ ] Dead letter queue specified (when to DLQ, monitoring, reprocessing)
- [ ] Compensation/rollback logic for multi-step operations
- [ ] Alert rules defined (who, when, how)

## Security

- [ ] Authentication mechanism specified (OAuth 2.0 preferred)
- [ ] Encryption in transit (TLS 1.2+)
- [ ] Secrets management defined (vault, never hardcoded)
- [ ] Audit trail specified
- [ ] PII handling documented (if applicable)
- [ ] No credentials in code, config, or documentation

## Monitoring

- [ ] Correlation IDs planned
- [ ] Metrics defined (rate, errors, duration at minimum)
- [ ] Logging strategy specified (levels, format, what to log)
- [ ] Dashboards identified
- [ ] SLOs defined

## Pragmatism

- [ ] Design matches team's skill level
- [ ] Platform constraints considered
- [ ] Budget/timeline constraints reflected
- [ ] Phased approach if full solution is complex
- [ ] Trade-offs documented explicitly
