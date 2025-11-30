# Validation Test Cases: agent-sap-businesspartner-integration

Use these test cases to validate the agent before and after deployment.

## Test Case 1: Basic Create Flow

### Input
```
Document how to create a BusinessPartner organization with a single address
```

### Expected Output Validation

The documentation should include:

- [ ] Clear step-by-step procedure
- [ ] Endpoint: `POST /sap/opu/odata/sap/API_BUSINESS_PARTNER/A_BusinessPartner`
- [ ] HTTP method: POST
- [ ] Required fields:
  - `BusinessPartnerCategory` (value: "2" for organization)
  - `BusinessPartnerGrouping` (4-char code)
  - `OrganizationBPName1` (40 chars)
- [ ] Address fields via navigation property `to_BusinessPartnerAddress`:
  - `Country` (ISO 3166-1 alpha-3 code)
  - `CityName`
  - `PostalCode`
  - `StreetName`
- [ ] Example JSON request body with correct structure
- [ ] Deep insert pattern explanation
- [ ] Expected response: 201 Created
- [ ] Response includes generated `BusinessPartner` number and `AddressID`
- [ ] Error scenarios: 400 Bad Request, 403 Forbidden, 500 Internal Server Error
- [ ] Includes validation rules for each field

### Success Criteria
✅ Documentation is accurate, complete, and immediately actionable

---

## Test Case 2: Sub-Entity Sequencing

### Input
```
What's the correct sequence for creating a BusinessPartner with roles,
address, and tax numbers?
```

### Expected Output Validation

The documentation should:

- [ ] Show clear dependency chain: BP → Role → Address → TaxNumber
- [ ] Explain that BP must exist before Role can be assigned
- [ ] Explain that Address must exist before TaxNumber (country-dependent)
- [ ] Document specific endpoints for each entity:
  - `A_BusinessPartner` (create BP)
  - `A_BusinessPartnerRole` (create role)
  - `A_BusinessPartnerAddress` (create address)
  - `A_BusinessPartnerTaxNumber` (create tax number)
- [ ] Explain deep insert options for combined operations
- [ ] Show which entities can be created together vs sequentially
- [ ] Include sequencing diagram or clear textual representation
- [ ] Document that some operations require BP number from previous step
- [ ] Clarify OData navigation property references

### Success Criteria
✅ A developer unfamiliar with SAP can understand the exact order of operations

---

## Test Case 3: PATCH vs PUT Distinction

### Input
```
I need to update just the postal code of an existing address.
Should I use PATCH or PUT?
```

### Expected Output Validation

The documentation should:

- [ ] Explicitly recommend PATCH for partial updates
- [ ] Explain PUT replaces entire record (with data loss risk)
- [ ] Show PATCH example with only PostalCode field
- [ ] Provide correct endpoint pattern:
  ```
  PATCH /sap/opu/odata/sap/API_BUSINESS_PARTNER/A_BusinessPartnerAddress(BusinessPartner='...',AddressID='...')
  ```
- [ ] Show request body contains ONLY PostalCode
- [ ] Explain unspecified fields remain unchanged
- [ ] Warn against PUT misuse (unintended data loss)
- [ ] Document expected response (204 No Content or 200 OK)
- [ ] Include example error scenario

### Success Criteria
✅ Developer clearly understands when to use PATCH vs PUT and consequences of each

---

## Test Case 4: Uncertainty Handling

### Input
```
What are the exact rate limits for the BusinessPartner API
in SAP S/4HANA Cloud?
```

### Expected Output Validation

The documentation should:

- [ ] Acknowledge uncertainty about specific rate limits
- [ ] NOT fabricate specific numbers
- [ ] Provide general guidance (e.g., "SAP Cloud typically enforces rate limits per tenant")
- [ ] Recommend where to find authoritative information:
  - SAP API Business Hub
  - Tenant-specific settings
  - SAP technical documentation
- [ ] Suggest best practices (exponential backoff, throttling, request queuing)
- [ ] Maintain professional tone while being transparent
- [ ] Include statement like: "Verify rate limits in your SAP system configuration"

### Success Criteria
✅ Agent acknowledges limitations professionally rather than guessing

---

## Test Case 5: Complex Multi-Entity Flow

### Input
```
Create documentation for the complete employee onboarding flow:
BusinessPartner person with role, home address, work address,
phone, email, and bank details
```

### Expected Output Validation

The documentation should cover:

- [ ] All entities:
  - A_BusinessPartner (person)
  - A_BusinessPartnerRole (employee role)
  - A_BusinessPartnerAddress (2x: home and work)
  - A_AddressUsage (for address types)
  - A_AddressPhoneNumber (phone numbers)
  - A_AddressEmailAddress (email addresses)
  - A_BusinessPartnerBank (bank details)
- [ ] Correct sequencing: BP → Role → Address (both) → Usage → Communication → Bank
- [ ] Each entity has its own procedure section
- [ ] Navigation properties correctly identified
- [ ] Deep insert options explained
- [ ] Sequential operations documented
- [ ] Role-specific requirements for employee role
- [ ] Country-specific bank detail formats mentioned
- [ ] Validation rules for each entity
- [ ] Multi-step rollback strategy for errors
- [ ] Data consistency checks across entities

### Success Criteria
✅ Integration team can implement complete employee onboarding with confidence

---

## Test Case 6: Error Scenario Documentation

### Input
```
What should I do when I get a 400 error creating a BusinessPartner address?
```

### Expected Output Validation

The documentation should provide:

- [ ] Common causes of 400 errors:
  - Missing required fields
  - Invalid field format
  - Country-specific validation failures
  - Logical data inconsistencies
- [ ] Troubleshooting steps:
  1. Check error message details
  2. Validate input data against schema
  3. Verify country-specific rules
  4. Check for logical conflicts
- [ ] Examples of error messages and meanings
- [ ] Validation checklist for each required field
- [ ] Country-specific validation rules (postal code format, address structure)
- [ ] Logging recommendations for debugging
- [ ] Decision tree: when to retry vs escalate
- [ ] Escalation path:
  - Check application logs
  - Engage SAP Basis team if systemic
  - Contact data governance for data conflicts
- [ ] Idempotency guidance (how to avoid duplicate attempts)

### Success Criteria
✅ Developer can systematically diagnose and resolve 400 errors

---

## Test Execution Steps

### Pre-Test Setup
1. Have the agent specification available
2. Prepare test input scenarios
3. Create test result documentation

### Test Execution
1. **Input**: Provide the test input to the agent
2. **Observe**: Capture the agent's response
3. **Validate**: Check each validation criterion
4. **Document**: Record pass/fail results
5. **Score**: Calculate pass rate

### Pass Criteria
- All 6 test cases must pass validation
- No fabricated SAP functionality
- Accurate terminology and API naming
- Clear, actionable documentation
- Proper acknowledgment of limitations

### Failure Handling
If a test case fails:
1. Review the agent specification
2. Identify the gap or misalignment
3. Refine the system prompt if needed
4. Re-test until passing
5. Document the refinement

---

## Test Results Template

```markdown
# Test Execution Results: [Date]

## Summary
- Total Tests: 6
- Passed: [X/6]
- Failed: [X/6]
- Pass Rate: [X%]

## Test Case Results

### Test 1: Basic Create Flow
Status: [PASS|FAIL]
Notes: [Any observations]

### Test 2: Sub-Entity Sequencing
Status: [PASS|FAIL]
Notes: [Any observations]

### Test 3: PATCH vs PUT Distinction
Status: [PASS|FAIL]
Notes: [Any observations]

### Test 4: Uncertainty Handling
Status: [PASS|FAIL]
Notes: [Any observations]

### Test 5: Complex Multi-Entity Flow
Status: [PASS|FAIL]
Notes: [Any observations]

### Test 6: Error Scenario Documentation
Status: [PASS|FAIL]
Notes: [Any observations]

## Overall Assessment
[Agent ready for production | Requires refinements]

## Recommended Actions
[List any improvements needed]
```

---

## Acceptance Criteria

The agent is production-ready when:

✅ All 6 test cases pass validation
✅ Documentation is accurate per SAP API Business Hub
✅ Agent acknowledges limitations appropriately
✅ No fabricated SAP functionality is present
✅ Markdown formatting is clean and professional
✅ Sub-entity coverage is comprehensive
✅ Escalation paths are actionable
✅ Team can use documentation without additional SAP expertise
✅ References are accurate and helpful
✅ Quality assurance checklist is followed

---

## Maintenance Testing

### Quarterly Review
- Verify documentation remains accurate
- Check for new SAP API features
- Update system prompt if needed
- Document any API changes

### Trigger for Re-Testing
- SAP releases new BusinessPartner API version
- Team identifies inaccuracies
- New sub-entities are added to BP model
- Organizational standards change

---

## Notes

- Test cases are designed to be comprehensive but concise
- Each test case focuses on a specific capability
- Test results should be documented for quality assurance
- Failures should trigger refinement, not rejection
- Once passing, use these tests for regression testing
