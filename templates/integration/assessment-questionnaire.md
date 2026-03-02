# Integration Assessment Questionnaire

Guided interview structure for evaluating integrations. Adapt questions based on context (new vs existing).

## Section 1: Business Context

- What business process does this integration support?
- Which systems are involved (source, target, intermediary)?
- What is the business criticality? (Revenue-impacting, operational, supporting)
- Who are the stakeholders? (Business owner, technical owner, support team)
- What triggers this integration? (Schedule, event, manual, API call)
- What is the expected data volume? (Records/hour, peak load)
- What are the latency requirements? (Real-time, near-real-time, batch)

## Section 2: Architecture & Design

- What integration pattern is used? (Point-to-point, hub-spoke, API-led, event-driven, ETL)
- Is the integration synchronous or asynchronous?
- How are endpoints configured? (Hardcoded, config-driven, service discovery)
- What API style is used? (REST, SOAP, GraphQL, gRPC, file-based)
- What is the coupling level between systems? (Tight: shared DB, Loose: API/events)
- Is there an API gateway or middleware layer?
- How are API versions managed?

## Section 3: Data Quality & Governance

- Are schemas documented and version-controlled?
- Is there a canonical/standard data model?
- How are field mappings defined and maintained?
- What data validation rules exist? (Pre-send, post-receive)
- How are data conflicts or duplicates handled?
- Is there master data management (MDM) alignment?
- Who owns data quality for this integration?

## Section 4: Operational Excellence

- What monitoring exists? (Logs, metrics, traces, dashboards)
- Is runtime monitoring data available for this assessment? (Execution logs, error rates, latency metrics)
- Are correlation IDs used for tracing?
- How are errors detected and reported?
- What alerting rules are configured? (Who gets notified, when)
- Are SLAs/SLOs defined and tracked?
- What happens when a message fails processing?
- Is there a dead letter queue (DLQ)?

## Section 5: Reliability & Resilience

- What retry logic exists? (Fixed, exponential backoff, max attempts)
- Are operations idempotent? (Safe to retry without side effects)
- Are circuit breakers configured for external calls?
- What timeout values are set?
- What is the DR plan? (RTO/RPO, failover, backup strategy)
- When was DR last tested?
- How is data consistency maintained during failures?

## Section 6: Security & Compliance

- What authentication mechanism is used? (OAuth 2.0, API keys, basic auth, mTLS)
- Is data encrypted in transit? (TLS version)
- Is data encrypted at rest? (If stored)
- How are credentials/secrets managed? (Vault, env vars, config files)
- Is there an audit trail? (What's logged, retention period)
- What regulatory requirements apply? (GDPR, HIPAA, SOC 2, ISO 27001)
- How is PII/sensitive data handled?

## Section 7: Business Impact

- What is the criticality tier? (Tier 1: critical, Tier 2: important, Tier 3: standard)
- What is the cost of 1 hour of downtime? (Revenue loss, operational impact)
- What are the upstream/downstream dependencies?
- How does a change in this integration affect other systems?
- Is there a documented Business Impact Analysis (BIA)?

## Section 8: Maintainability & Scalability

- What is the current test coverage? (Unit, integration, E2E)
- Is there a CI/CD pipeline?
- How is the integration deployed? (Manual, automated, blue-green, canary)
- Is there a rollback plan?
- Is architecture documentation current?
- Can the integration scale horizontally?
- What is the current capacity vs. demand?

## Section 9: Tool & Platform

- What integration platform is used? (MuleSoft, Workato, Boomi, Talend, custom, cloud-native)
- Does the platform support all required patterns?
- What is the vendor lock-in risk?
- What is the total cost of ownership? (License, infra, labor)
- Are there alternative platforms being considered?
- What is the team's skill level with this platform?

## Section 10: Data Source Reliability

- Has API documentation been validated against actual production behavior?
- Are there known API quirks or undocumented behaviors? (Expect 8-12 per integration)
- Which findings are based on direct evidence (runtime logs, tested behaviors) vs inference (code review, documentation)?
- Has a developer/domain owner walkthrough been conducted?
- Are there platform-specific capabilities that may already address flagged concerns?

## Section 11: For Existing Integrations Only

- How long has this integration been running?
- What are the most common issues/incidents?
- When was the last significant change?
- What is the current incident frequency? (Per week/month)
- What improvements have been requested by stakeholders?
- Is there technical debt that needs addressing?

## Section 11: For New Integrations Only

- What are the hard requirements vs. nice-to-have?
- Are there existing integrations that can be reused or extended?
- What is the target go-live date?
- What resources are available? (Team size, skill set, budget)
- Are there constraints on platform/technology choice?
- What is the MVP scope vs. full scope?
