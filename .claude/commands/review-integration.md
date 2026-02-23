# /review-integration - Design Review

Review an integration design against best practices and the 8-dimension framework.

## Quick Reference

| Aspect | Details |
|--------|---------|
| **Invocation** | `/review-integration [design description or reference]` |
| **Agent Used** | agent-integration-reviewer |
| **Output** | Review report with findings and approval status |

## Usage

```bash
/review-integration Review the Salesforce-SAP integration design
/review-integration --security Review customer data integration with PII
/review-integration --from-file path/to/design-document.md
```

## Workflow

```
agent-integration-reviewer
├── Loads review checklist
├── Validates 8-dimension coverage
├── Checks for anti-patterns
├── Security deep-dive (if --security)
├── Classifies findings (Critical/High/Medium/Low)
└── Produces: Review report with approval status
```

## Options

| Option | Description |
|--------|-------------|
| `--security` | Trigger detailed security deep-dive (OWASP API Top 10, encryption, auth) |
| `--from-file <path>` | Review an existing design document file |

## Output

- Dimension coverage table
- Findings by severity (Critical, High, Medium, Low)
- Security review highlights
- Strengths identified
- Approval status: Approved / Approved with Conditions / Revisions Required
- Next steps and recommendations

---

**Version**: 1.0.0
