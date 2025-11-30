# BusinessPartner Integration Guide: [Specific Operation/Flow]

<!-- Token Budget Guidelines:
- Brief Mode: Use only relevant sections (500-800 tokens)
- Standard Mode: All sections, concise (1,500-3,000 tokens)
- Detailed Mode: All sections, comprehensive (3,000-6,000 tokens)
-->

## Overview
<!-- Brief: 100-150 tokens | Standard: 150-250 tokens | Detailed: 300-400 tokens -->

[Purpose, scope, prerequisites, key entities involved]

**Purpose**: [What this integration accomplishes]
**Scope**: [What operations/entities are covered]
**Prerequisites**: [Required access, knowledge, tools]
**Key Entities**: [A_BusinessPartner, sub-entities involved]

---

## Data Model & Dependencies
<!-- Brief: skip | Standard: 200-300 tokens | Detailed: 400-600 tokens -->

[Entity relationships, mandatory sequencing, field-level dependencies]

**Entity Relationships**:
- Primary Entity: [e.g., A_BusinessPartner]
- Navigation Properties: [e.g., to_BusinessPartnerAddress]
- Sub-Entities Required: [List with dependencies]

**Mandatory Sequencing**:
1. [First operation] → [Why it must be first]
2. [Second operation] → [Dependencies on first]
3. [Subsequent operations] → [Dependency chain]

**Field-Level Dependencies**:
- [Field X] requires [Field Y] to be set first
- [Country-specific requirements]
- [Conditional fields based on Category/Grouping]

---

## Step-by-Step Procedures
<!-- Brief: 200-300 tokens | Standard: 500-800 tokens | Detailed: 1,000-1,500 tokens -->

### [Operation Name] (e.g., Create BusinessPartner Organization)

#### Step 1: [Operation Description]

**Endpoint**: `/sap/opu/odata/sap/API_BUSINESS_PARTNER/[Entity]`
**Method**: [POST|PATCH|PUT|GET|DELETE]

**Required Fields**:
| Field | Type | Description | Validation Rules |
|-------|------|-------------|------------------|
| [FieldName] | [Type] | [Purpose] | [Rules] |
| [FieldName] | [Type] | [Purpose] | [Rules] |

**Optional Fields**:
| Field | Type | Description | Usage Guidance |
|-------|------|-------------|----------------|
| [FieldName] | [Type] | [Purpose] | [When to use] |

**Example Request Body**:
```json
{
  "[FieldName]": "[value]",
  "[FieldName]": "[value]",
  "to_[NavigationProperty]": [
    {
      "[SubEntityField]": "[value]"
    }
  ]
}
```

**Expected Response**:
- **Success**: HTTP 201 Created (for POST) or 200 OK (for GET)
- **Response Structure**:
```json
{
  "d": {
    "BusinessPartner": "[generated-number]",
    "[OtherFields]": "[values]"
  }
}
```

**Error Scenarios**:
| HTTP Code | Error Type | Common Causes | Resolution |
|-----------|-----------|---------------|------------|
| 400 | Bad Request | Missing required field | Check request body against required fields |
| 403 | Forbidden | Insufficient authorization | Verify user has BusinessPartner.Create authorization |
| 409 | Conflict | Duplicate detected | Check for existing BP with same identifiers |
| 500 | Internal Server Error | System issue | Check SAP logs, contact Basis team |

---

## Integration Best Practices
<!-- Brief: skip | Standard: 200-300 tokens | Detailed: 400-600 tokens -->

### Idempotency
[Strategies for ensuring safe retries]
- Use GET before POST to check if entity exists
- Store generated BusinessPartner number for reference
- Implement duplicate detection logic
- Handle 409 Conflict responses gracefully

### Error Handling
[Patterns for graceful degradation]
- Retry on 500-series errors with exponential backoff
- Log all request/response pairs for debugging
- Implement circuit breaker for repeated failures
- Escalate persistent errors to appropriate team

### Retry Logic
[When and how to retry failed operations]
- **Retry**: 500, 502, 503, 504 (server errors)
- **Don't Retry**: 400, 401, 403, 404 (client errors - fix request)
- **Max Retries**: 3 attempts
- **Backoff**: Exponential (1s, 2s, 4s)

### Async Processing
[Considerations for long-running operations]
- Most OData operations are synchronous
- For bulk operations, consider batching (see $batch)
- Monitor timeout settings (default 60s)

### Rate Limiting
[Throttling and backoff strategies]
- SAP Cloud enforces rate limits per tenant
- Implement request queuing for burst scenarios
- Monitor for 429 Too Many Requests
- Recommended: Max 10 requests/second per integration

---

## Validation & Data Cleansing
<!-- Brief: skip | Standard: 150-250 tokens | Detailed: 300-500 tokens -->

### Pre-Submission Validation
[Rules to check before API calls]
- Verify all required fields present and non-empty
- Validate field lengths (e.g., OrganizationBPName1 max 40 chars)
- Check field formats (dates, phone numbers, postal codes)
- Ensure logical consistency (Category + Grouping combinations)

### Data Format Requirements
[Date formats, address structures, tax ID patterns]
- **Dates**: YYYY-MM-DD format
- **Country Codes**: ISO 3166-1 alpha-3 (e.g., "USA", "DEU")
- **Phone Numbers**: Internationalize with country/area codes
- **Postal Codes**: Country-specific formats

### Country-Specific Rules
[Locale-dependent validation]
- Address structures vary by country
- Tax ID formats are country-dependent
- Postal code validation rules differ
- Verify requirements in SAP system configuration

### Duplicate Detection
[Strategies to avoid creating duplicates]
- Search by name before creating
- Check unique identifiers (Tax IDs, external IDs)
- Implement matching logic for similarity
- Use SAP duplicate check rules if configured

---

## Error Handling & Troubleshooting
<!-- Brief: skip (unless specifically requested) | Standard: 200-300 tokens | Detailed: 400-600 tokens -->

### Common Error Codes
[HTTP status codes and OData error messages]
- **400 Bad Request**: Invalid request structure or missing required fields
- **401 Unauthorized**: Authentication failed or token expired
- **403 Forbidden**: Insufficient authorization for operation
- **404 Not Found**: Entity does not exist (on GET/PATCH/DELETE)
- **409 Conflict**: Duplicate or constraint violation
- **500 Internal Server Error**: SAP system issue

### Data Consistency Checks
[Post-operation validation]
- Verify generated BusinessPartner number received
- Confirm all sub-entities created successfully
- Check data matches request (GET after POST/PATCH)
- Validate navigation property relationships

### Rollback Strategies
[How to handle partial failures]
- OData does not support transactions across multiple entities
- If sub-entity creation fails, consider deleting parent BP
- Log all created entities for cleanup if needed
- Implement compensation logic for partial failures

### Logging & Audit
[What to log for troubleshooting]
- Full request URL and body (mask sensitive data)
- Full response including headers and status
- Timestamp, user context, correlation ID
- Business context (which process triggered this)
- Errors and retry attempts

---

## Escalation Guidelines
<!-- Brief: skip | Standard: 100-150 tokens | Detailed: 200-300 tokens -->

### Data Inconsistencies
[When to involve data governance team]
- Conflicting master data from multiple sources
- Business rule violations not caught by validation
- Data quality issues requiring manual review

### API Failures
[When to escalate to SAP support vs retry]
- **Retry**: Transient 500-series errors (< 3 occurrences)
- **SAP Basis**: Persistent errors, authorization issues, system down
- **SAP Support**: Suspected SAP bugs, unexpected API behavior
- **Data Governance**: Business logic conflicts, data ownership questions

### Authorization Issues
[When to involve SAP Basis/security team]
- 403 Forbidden errors despite correct credentials
- Authorization object configuration questions
- Role assignment or profile changes needed

### Business Logic Conflicts
[When to engage business stakeholders]
- Category/Grouping combination questions
- Business partner type determination
- Ownership and data stewardship questions
- Process exceptions requiring approval

---

## Misuse Prevention
<!-- Brief: skip | Standard: 100-150 tokens | Detailed: 200-300 tokens -->

### Rate Limits
[Specific limits and adherence strategies]
- Respect SAP Cloud rate limits (tenant-specific)
- Implement queuing for burst scenarios
- Monitor for 429 responses
- Use batch operations when appropriate

### PATCH vs PUT
[When to use each, consequences of misuse]
- **PATCH**: Partial update (recommended) - only changed fields
- **PUT**: Full replacement - unspecified fields may be cleared
- **Risk of PUT**: Data loss if not all fields provided
- **Best Practice**: Always use PATCH for updates

### Derived Fields
[Fields to never update directly]
- Fields calculated by SAP (e.g., SearchTerm, NameInternational)
- System-managed fields (CreatedBy, CreatedOn)
- Fields populated by automatic determination
- **Rule**: Only update fields you explicitly set

### Governance Compliance
[Checkpoints and approvals required]
- Data ownership verification before updates
- Change approval for critical master data
- Compliance with data retention policies
- Audit trail maintenance

---

## References
<!-- All modes: 50-100 tokens -->

- [SAP API Business Hub - BusinessPartner API](https://api.sap.com/api/API_BUSINESS_PARTNER/)
- [SAP Help Portal - BusinessPartner Documentation](https://help.sap.com/businesspartner)
- Related Integration Documentation: [Links to related docs]
- Project-Specific Context: [Links to project documentation]

---

**Template Version**: 1.0.0
**Last Updated**: 2025-11-28
**Maintained By**: Agent Architecture Team

**Usage**: This template is loaded by agent-sap-businesspartner-integration when creating documentation. Agents populate sections based on specific user requests and output mode (Brief/Standard/Detailed).
