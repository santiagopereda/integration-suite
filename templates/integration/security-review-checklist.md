# Security Review Checklist

Deep security validation for integration designs. Based on OWASP API Security Top 10.

## Authentication & Authorization

- [ ] Authentication mechanism specified (OAuth 2.0 preferred over API keys/basic auth)
- [ ] Authorization scoped appropriately (least privilege)
- [ ] Token expiry and refresh configured
- [ ] Service-to-service auth defined (mTLS or service accounts)
- [ ] No shared credentials between environments
- [ ] API key rotation policy defined (if using API keys)
- [ ] Rate limiting configured per client/consumer

## Encryption

- [ ] TLS 1.2+ for all data in transit (TLS 1.3 preferred)
- [ ] No HTTP endpoints (all HTTPS)
- [ ] Certificate management planned (rotation, renewal)
- [ ] Data encrypted at rest if stored (AES-256)
- [ ] PII/sensitive data identified and classified
- [ ] Encryption keys managed properly (KMS, not in code)

## Secrets Management

- [ ] No credentials in source code
- [ ] No credentials in configuration files
- [ ] No credentials in documentation or examples
- [ ] Secrets stored in vault (HashiCorp, AWS Secrets Manager, Azure Key Vault)
- [ ] Secret rotation policy defined
- [ ] Environment-specific secrets isolated

## Input Validation

- [ ] Schema validation on incoming data
- [ ] Input size limits defined
- [ ] Injection prevention (SQL, NoSQL, command, XML)
- [ ] Content-type validation
- [ ] Malformed payload handling (reject, not crash)

## Audit & Logging

- [ ] Authentication events logged (success and failure)
- [ ] Data access logged (who accessed what, when)
- [ ] Data modification logged (before/after or hash)
- [ ] Error events logged with context (no sensitive data in logs)
- [ ] Logs stored immutably (tamper-proof)
- [ ] Log retention policy defined
- [ ] No PII in logs (or masked/tokenized)
- [ ] No credentials in logs

## OWASP API Security Top 10 Mapping

| # | Risk | Status | Notes |
|---|------|--------|-------|
| API1 | Broken Object Level Authorization | [ ] | Validate object-level access |
| API2 | Broken Authentication | [ ] | Strong auth mechanism |
| API3 | Broken Object Property Level Authorization | [ ] | Limit exposed fields |
| API4 | Unrestricted Resource Consumption | [ ] | Rate limiting, pagination |
| API5 | Broken Function Level Authorization | [ ] | Role-based access control |
| API6 | Unrestricted Access to Sensitive Business Flows | [ ] | Abuse detection |
| API7 | Server-Side Request Forgery (SSRF) | [ ] | Validate URLs, allowlists |
| API8 | Security Misconfiguration | [ ] | Secure defaults, no debug in prod |
| API9 | Improper Inventory Management | [ ] | API inventory, deprecation |
| API10 | Unsafe Consumption of APIs | [ ] | Validate third-party responses |

## Compliance

- [ ] GDPR requirements identified (if EU data)
  - [ ] Data minimization
  - [ ] Consent management
  - [ ] Right to deletion
  - [ ] Data portability
  - [ ] Breach notification process
- [ ] HIPAA requirements identified (if healthcare data)
  - [ ] PHI encryption
  - [ ] Access controls
  - [ ] Audit trails
- [ ] SOC 2 controls mapped (if applicable)
- [ ] Industry-specific requirements identified

## Network Security

- [ ] Network segmentation appropriate
- [ ] Firewall rules defined
- [ ] IP allowlisting (where applicable)
- [ ] DDoS protection (for public endpoints)
- [ ] WAF/API gateway configured
