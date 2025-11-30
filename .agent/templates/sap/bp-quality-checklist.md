# BusinessPartner Integration Documentation - Quality Checklist

This checklist ensures all BusinessPartner integration documentation meets quality standards before delivery.

## Before Delivering Documentation, Verify:

### Content Completeness
- [ ] All sub-entities in scope are documented
- [ ] Sequencing dependencies are explicit and correct
- [ ] Each operation includes endpoint, method, fields, examples
- [ ] Error scenarios documented with resolutions
- [ ] Validation rules are clear and actionable

### Technical Accuracy
- [ ] API endpoints follow SAP naming conventions
- [ ] Entity names use correct SAP terminology (A_BusinessPartner, not "BusinessPartner")
- [ ] HTTP methods are appropriate (POST/PATCH/PUT/GET/DELETE)
- [ ] Field names match SAP API Business Hub exactly
- [ ] Navigation properties are correctly identified
- [ ] OData syntax is accurate

### PATCH vs PUT Clarity
- [ ] PATCH vs PUT differences explained where relevant
- [ ] Risks of PUT misuse documented (data loss warning)
- [ ] Recommendation is clear (prefer PATCH)
- [ ] Examples show correct usage

### Error Handling
- [ ] Technical errors documented (400, 401, 403, 404, 500)
- [ ] Business errors addressed (validation, duplicates, conflicts)
- [ ] Retry strategies provided
- [ ] Escalation paths are actionable and specific
- [ ] Logging guidance included

### Escalation Paths
- [ ] Data inconsistencies → Data governance team
- [ ] API failures → SAP Basis/Support (with criteria)
- [ ] Authorization issues → SAP Basis/security team
- [ ] Business logic conflicts → Business stakeholders
- [ ] Each escalation path includes when/why/how

### No Fabricated Functionality
- [ ] All documented features exist in SAP API
- [ ] No assumed capabilities without verification note
- [ ] Uncertain details flagged with "Verify in SAP API Business Hub"
- [ ] No proprietary SAP content included verbatim

### Uncertainties Acknowledged
- [ ] Customer-specific configurations noted as environment-dependent
- [ ] Recent API changes include verification recommendation
- [ ] Non-standard scenarios marked as requiring SAP consultation
- [ ] Ambiguities explicitly called out with next steps

### Markdown Formatting
- [ ] Clean, scannable structure with proper headings
- [ ] Code blocks use appropriate syntax highlighting
- [ ] Tables formatted correctly
- [ ] Lists are consistent (bullets or numbered)
- [ ] Examples are properly indented and clear

### Examples Quality
- [ ] Examples are concrete and realistic
- [ ] JSON syntax is valid
- [ ] Field values are plausible
- [ ] Deep insert examples show proper structure
- [ ] Error examples include actual error messages

### SAP-Agiloft Specific (if applicable)
- [ ] Documentation references relevant sections of evaluation document
- [ ] Work aligns with High/Medium/Low priority roadmap
- [ ] New content addresses identified gaps from evaluation
- [ ] Quality score implications noted (if 5+ point improvement)
- [ ] Cross-references to existing API and mapping docs included

---

## Quality Score Self-Assessment

Rate each category (1-5):
- **Completeness**: All required information present? ___/5
- **Accuracy**: Technically correct and verified? ___/5
- **Clarity**: Easy to understand and follow? ___/5
- **Actionability**: Can user implement immediately? ___/5
- **Professional**: Meets standards for external documentation? ___/5

**Total Score**: ___/25

**Minimum Acceptable**: 20/25 (80%)

---

## Common Issues to Avoid

❌ **Don't**:
- Fabricate SAP capabilities
- Use generic error messages without specifics
- Skip sequencing dependencies
- Omit validation rules
- Provide code implementations (focus on procedures)
- Include proprietary SAP content
- Document deprecated approaches
- Assume customer-specific configurations

✅ **Do**:
- Use accurate SAP terminology
- Provide specific endpoints and methods
- Include realistic examples
- Document both success and error scenarios
- Acknowledge limitations transparently
- Reference SAP API Business Hub for verification
- Clarify environment-dependent configurations
- Maintain professional, consultative tone

---

## Pre-Delivery Final Check

Before sending documentation to user:
1. Read through as if you're unfamiliar with SAP
2. Verify all links and references are valid
3. Check spelling and grammar
4. Confirm examples use consistent data (BP number, addresses)
5. Ensure tone is consultative, not prescriptive
6. Validate that uncertainties are flagged appropriately

---

**Template Version**: 1.0.0
**Last Updated**: 2025-11-28
**Maintained By**: Agent Architecture Team

**Usage**: Agent loads this checklist before delivering BusinessPartner integration documentation to perform final quality validation.
