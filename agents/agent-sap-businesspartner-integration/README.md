# agent-sap-businesspartner-integration

**Expert SAP S/4HANA Cloud consultant specializing in BusinessPartner OData API integration documentation**

## Overview

This agent creates comprehensive, accurate Markdown documentation for managing BusinessPartner master data through SAP S/4HANA Cloud OData APIs. It specializes in:

- Creating step-by-step integration procedures
- Documenting data dependencies and sequencing
- Explaining PATCH vs PUT operation semantics
- Defining validation rules and error handling
- Creating escalation guidelines
- Preventing API misuse and governance violations

## When to Use This Agent

### ✅ Trigger Conditions

Invoke this agent when:

1. **Integration Documentation Needed** - You need comprehensive documentation for BusinessPartner OData API integration patterns
2. **Procedure Definition** - You ask for step-by-step procedures for BP create/update/patch operations
3. **Data Sequencing** - You need guidance on data sequencing and dependencies across BP sub-entities
4. **Best Practices** - You require integration best practices for SAP S/4HANA Cloud BusinessPartner APIs
5. **Error Handling** - You ask about validation rules, error handling, or escalation procedures
6. **Operation Clarity** - You need clarity on differences between PATCH vs PUT operations for BusinessPartner updates

### ❌ When NOT to Use This Agent

- Requesting SAP functional configuration (use SAP documentation)
- Needing code implementations (use a code generation agent)
- Asking about non-BusinessPartner SAP modules
- Requesting general SAP consulting (outside integration scope)
- Needing real-time API responses (use SAP systems directly)

## Usage Examples

### Example 1: Complete Integration Guide

**User Request:**
```
I'm starting a new BusinessPartner data integration project.
I need comprehensive documentation covering creation, updates,
and all sub-entity management (roles, addresses, tax numbers, bank details).
```

**What the Agent Will Produce:**
- Complete overview and prerequisites
- Entity relationship diagrams (textual)
- Step-by-step procedures for:
  - Creating BusinessPartner with address (deep insert)
  - Creating BusinessPartner and entities separately (sequential)
  - Updating BusinessPartner fields (PATCH)
  - Adding/updating addresses, roles, tax numbers, bank details
  - Managing communication data (phone, email)
- Integration best practices (idempotency, error handling, retry logic)
- Validation rules for each entity
- Common error scenarios and resolutions
- Escalation guidelines
- Misuse prevention guidance

### Example 2: Specific Operation Documentation

**User Request:**
```
I need to update just the postal code of an existing BusinessPartner address
without affecting other fields. Should I use PATCH or PUT? Document the procedure.
```

**What the Agent Will Produce:**
- Clear PATCH vs PUT comparison
- PATCH recommendation with explanation
- Exact endpoint with key predicate
- Request body structure (only PostalCode field)
- Expected response (204 No Content)
- Error scenarios
- Alternative approaches if PATCH doesn't work

### Example 3: Sub-Entity Sequencing

**User Request:**
```
What's the correct sequence for creating a BusinessPartner with roles,
address, and tax numbers? Can I do this in one request or do I need multiple calls?
```

**What the Agent Will Produce:**
- Dependency chain visualization
- Deep insert option (combined in one request)
- Sequential approach (if needed)
- Entity prerequisites
- Navigation property references
- Example JSON for both approaches

### Example 4: Error Handling & Troubleshooting

**User Request:**
```
We're getting 400 errors when creating BusinessPartner addresses.
What are the common causes and how do we troubleshoot?
```

**What the Agent Will Produce:**
- Common causes of 400 errors
- Troubleshooting steps
- Validation requirements by country/region
- Required vs optional fields
- Field format requirements
- Logging recommendations
- Escalation triggers

### Example 5: Integration Best Practices

**User Request:**
```
We're building a bulk BusinessPartner import process.
What are the best practices for error handling, retries, and ensuring idempotency?
```

**What the Agent Will Produce:**
- Idempotency strategy (using business keys)
- Error handling patterns (per-record error capture)
- Retry logic recommendations (exponential backoff)
- Rate limiting guidance
- Batch vs streaming considerations
- Rollback strategies
- Monitoring and alerting

## Agent Capabilities

### Sub-Entities Covered
- BusinessPartnerRole
- BusinessPartnerAddress
- AddressUsage
- AddressPhoneNumber
- AddressEmailAddress
- BPContactToFuncAndDept
- BusinessPartnerTaxNumber
- BusinessPartnerBank
- BuPaIdentification
- BuPaIndustry

### Operations Documented
- **Create (POST)** - Create new BusinessPartner and sub-entities
- **Read (GET)** - Query BusinessPartner and related data
- **Partial Update (PATCH)** - Update specific fields
- **Full Replace (PUT)** - Replace entire record (rare)
- **Delete** - Remove BusinessPartner and sub-entities

### Output Quality
- **Accurate**: Never fabricates SAP functionality; uses correct terminology and API names
- **Transparent**: Explicitly states uncertainties and recommends verification in sandboxes
- **Comprehensive**: Covers all aspects of integration (create, update, validation, error handling, escalation)
- **Scannable**: Uses hierarchical Markdown with headings, lists, and code blocks
- **Actionable**: Provides step-by-step procedures integration teams can immediately follow

## Integration Constraints

### What This Agent Won't Do
- ❌ Provide code implementations (focuses on procedural documentation)
- ❌ Include proprietary SAP content verbatim
- ❌ Document deprecated non-cloud approaches
- ❌ Make assumptions about customer-specific field extensions
- ❌ Provide security credentials or authentication tokens
- ❌ Guarantee specific performance metrics without qualification
- ❌ Fabricate SAP functionality

### What This Agent Handles Carefully
- ✓ Uncertain about recent API changes? → Recommends verification in SAP API Business Hub sandbox
- ✓ Customer-specific configurations? → Documents standard behavior, notes customization dependency
- ✓ Non-standard scenarios? → Recommends consulting SAP documentation or support
- ✓ Proprietary details? → Suggests engagement with SAP Basis team

## Documentation Structure

All documentation follows this proven structure:

```
# Title

## Overview
- Purpose and scope
- Prerequisites
- Key entities involved

## Data Model & Dependencies
- Entity relationships
- Mandatory sequencing
- Field-level dependencies

## Step-by-Step Procedures
[For each operation: endpoint, method, fields, validation, examples, errors]

## Integration Best Practices
- Idempotency
- Error handling
- Retry logic
- Async processing
- Rate limiting

## Validation & Data Cleansing
- Pre-submission validation
- Format requirements
- Country-specific rules
- Duplicate detection

## Error Handling & Troubleshooting
- Common error codes
- Data consistency checks
- Rollback strategies
- Logging guidance

## Escalation Guidelines
- Data inconsistencies
- API failures
- Authorization issues
- Business logic conflicts

## Misuse Prevention
- Rate limits
- PATCH vs PUT usage
- Derived fields to avoid
- Governance compliance
```

## Getting Started

### Direct Invocation
```bash
@agent-sap-businesspartner-integration: Create comprehensive documentation
for the BusinessPartner creation flow with addresses and tax numbers
```

### In CLAUDE.md
```yaml
agents:
  - name: agent-sap-businesspartner-integration
    trigger: "When documenting BusinessPartner OData API integrations"
    scope: "Creating procedures, best practices, error handling guides"
```

### With Other Agents
- **Code Review Agents**: Verify implementations align with this agent's documented patterns
- **API Testing Agents**: Use this agent's documentation to generate test cases
- **Architecture Agents**: Incorporate integration patterns into system designs

## Validation

Before using generated documentation, verify:
- [ ] All required sub-entities are covered
- [ ] Sequencing is explicit and logical
- [ ] API endpoints match SAP naming conventions
- [ ] PATCH vs PUT differences are explained
- [ ] Error handling covers technical and business errors
- [ ] Escalation paths are actionable
- [ ] No fabricated functionality is present
- [ ] Uncertainties are clearly called out

## Support & Maintenance

**When to Refresh Documentation:**
- SAP releases new BusinessPartner API version
- Organization discovers inaccuracies in generated docs
- New sub-entities are added to SAP BusinessPartner model
- Team changes integration standards

**Contact:** Agent Architecture Team
**Version:** 1.0.0
**Last Updated:** 2025-11-20
**Status:** Production Ready
