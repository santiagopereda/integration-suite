# Integration Assessment: [NAME]

**Date**: [DATE]
**Assessor**: [NAME]
**Type**: [New / Existing]
**Status**: [Draft / Final]

---

## Executive Summary

[2-3 sentences: What is this integration, key findings, overall assessment]

## Systems & Stakeholders

| Role | System / Person | Details |
|------|----------------|---------|
| Source | [System A] | [Version, connector type] |
| Target | [System B] | [Version, connector type] |
| Middleware | [Platform] | [Version, edition] |
| Business Owner | [Name] | [Department] |
| Technical Owner | [Name] | [Team] |

## Integration Profile

| Attribute | Value |
|-----------|-------|
| Pattern | [Point-to-point / Hub-spoke / API-led / Event-driven / ETL] |
| Trigger | [Schedule / Event / Manual / API call] |
| Sync Type | [Synchronous / Asynchronous / Batch] |
| Volume | [Records/hour, peak load] |
| Latency Requirement | [Real-time / Near-real-time / Batch window] |
| Criticality | [Tier 1 / Tier 2 / Tier 3] |
| Platform | [MuleSoft / Workato / Talend / Boomi / Custom / Cloud-native] |

---

## Dimension Assessments

### 1. Architecture & Design

**Findings:**
- [Pattern used and appropriateness]
- [Coupling analysis]
- [API maturity level]

**Evidence:**
- [Specific artifacts, configs, or documentation reviewed]

**Gaps:**
- [What's missing or concerning]

---

### 2. Data Quality & Governance

**Findings:**
- [Schema management approach]
- [Mapping complexity and documentation]
- [Validation coverage]

**Evidence:**
- [Schema files, mapping docs, validation rules]

**Gaps:**
- [Missing schemas, undocumented mappings, validation gaps]

---

### 3. Operational Excellence

**Findings:**
- [Monitoring coverage (logs/metrics/traces)]
- [Error handling approach]
- [SLA/SLO status]

**Evidence:**
- [Dashboards, alert rules, log samples]

**Gaps:**
- [Missing observability, alerting gaps]

---

### 4. Reliability & Resilience

**Findings:**
- [Retry logic and configuration]
- [Idempotency approach]
- [DR readiness]

**Evidence:**
- [Retry config, circuit breaker setup, DR documentation]

**Gaps:**
- [Missing resilience patterns, untested DR]

---

### 5. Security & Compliance

**Findings:**
- [Authentication/authorization mechanism]
- [Encryption status (transit/rest)]
- [Compliance posture]

**Evidence:**
- [Auth config, TLS version, audit logs, compliance reports]

**Gaps:**
- [Security vulnerabilities, compliance gaps]

---

### 6. Business Impact

**Findings:**
- [Criticality classification]
- [Cost of failure estimate]
- [Dependency map status]

**Evidence:**
- [BIA document, dependency diagrams, SLA agreements]

**Gaps:**
- [Missing BIA, unknown dependencies, unquantified impact]

---

### 7. Maintainability & Scalability

**Findings:**
- [Test coverage]
- [CI/CD maturity]
- [Documentation quality]
- [Scaling capability]

**Evidence:**
- [Test reports, pipeline config, docs, scaling config]

**Gaps:**
- [Missing tests, manual deployments, documentation gaps]

---

### 8. Tool & Platform Assessment

**Findings:**
- [Platform fit analysis]
- [Lock-in risk]
- [TCO assessment]

**Evidence:**
- [Feature utilization, cost data, alternatives analysis]

**Gaps:**
- [Capability gaps, missing TCO data, skill gaps]

---

## Unknowns & Gaps

| # | Area | Unknown | Impact | Follow-up Action |
|---|------|---------|--------|-----------------|
| 1 | [Dimension] | [What's unknown] | [High/Med/Low] | [Who to ask, what to check] |

## Inventory Reference

- **Code Analysis**: [Link to inventory.md if analyzer was run]
- **Data Journey**: [Link to journey map if applicable]

## Metadata

| Field | Value |
|-------|-------|
| Assessment Date | [DATE] |
| Assessment Version | 1.0 |
| Assessor | [NAME] |
| Method | [Interview / Code analysis / Both] |
| Documents Reviewed | [List] |
| People Interviewed | [List] |
| Next Review Date | [DATE] |
