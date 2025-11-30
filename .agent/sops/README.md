# SOPs Folder - Standard Operating Procedures

This folder contains Standard Operating Procedures (SOPs) that ensure consistency, quality, and efficiency in how tasks are executed.

## 📋 Purpose

The SOPs folder provides:
- **Step-by-Step Procedures**: How to perform specific tasks
- **Process Templates**: Reusable templates for common work
- **Common Mistakes**: Lessons learned from past work
- **Checklists**: Validation and quality assurance steps
- **Best Practices**: Proven approaches to common problems

## 🎯 Why SOPs Matter

SOPs ensure:
- ✅ Consistency across all work
- ✅ New agents ramp up quickly
- ✅ Mistakes aren't repeated
- ✅ Quality standards are maintained
- ✅ Knowledge is preserved

## 📁 Structure

```
sops/
├── README.md                        ← This file
├── templates/                       ← Templates for creating SOPs
│   ├── sop-template.md             ← Blank SOP template
│   ├── implementation-checklist.md  ← Checklist template
│   └── common-mistakes-template.md  ← Tracking template
├── database/                        ← Database-related SOPs
│   ├── add-new-table.md
│   ├── add-migration.md
│   └── common-mistakes.md
├── integration/                     ← Integration-related SOPs
│   ├── integrate-external-api.md
│   ├── create-sync-flow.md
│   └── error-handling.md
├── documentation/                   ← Documentation SOPs
│   ├── write-api-docs.md
│   ├── create-prd.md
│   └── generate-implementation-plan.md
├── testing/                         ← Testing SOPs
│   ├── unit-testing.md
│   ├── integration-testing.md
│   └── manual-qa.md
├── deployment/                      ← Deployment SOPs
│   ├── deploy-to-staging.md
│   ├── deploy-to-production.md
│   └── rollback-procedure.md
└── common-mistakes.md               ← Master list of mistakes & prevention
```

## 📝 SOP Format

```markdown
# SOP: [Process Name]

## Overview
[Brief one-sentence description of what this SOP covers]

## When to Use This SOP
[Circumstances where this procedure applies]
- [Trigger 1]
- [Trigger 2]

## Prerequisites
[What must be in place before starting]
- [Requirement 1]
- [Requirement 2]

## Definitions
[Define any special terms used in this SOP]
- **Term 1**: [Definition]
- **Term 2**: [Definition]

## Step-by-Step Procedure

### Step 1: [Action]
[Detailed instructions]
- [Sub-action 1]
- [Sub-action 2]
- **Validation**: [How to verify this step worked]
- **Common Mistakes**: [What NOT to do here]

### Step 2: [Action]
[Detailed instructions]
- [Sub-action 1]
- [Sub-action 2]
- **Validation**: [How to verify this step worked]
- **Common Mistakes**: [What NOT to do here]

## Troubleshooting

### Issue: [Problem Description]
**Symptom**: [How to recognize this issue]
**Cause**: [Why this happens]
**Resolution**: [How to fix it]

### Issue: [Problem Description]
[Same format]

## Validation Checklist

- [ ] Check 1 - [What to verify]
- [ ] Check 2 - [What to verify]
- [ ] Check 3 - [What to verify]

## Common Mistakes to Avoid

- ❌ **Mistake 1**: [What not to do]
  - **Why it's wrong**: [Consequences]
  - **How to avoid**: [Prevention]

- ❌ **Mistake 2**: [What not to do]
  - **Why it's wrong**: [Consequences]
  - **How to avoid**: [Prevention]

## Related SOPs
- [Link to related SOP 1]
- [Link to related SOP 2]

## References
- [Link to system documentation]
- [Link to API docs if applicable]

## History
- **Created**: [Date] by [Person/Agent]
- **Last Updated**: [Date] by [Person/Agent]
- **Version**: 1.0
```

## 🎯 Creating SOPs

### After Completing Each Task

```
1. Task is completed
2. Create SOP for the process
3. Store in: sops/[category]/[process-name].md
4. Log: Any mistakes discovered in common-mistakes.md
5. Update: injection-history.md
```

### SOP Development Workflow

```
Step 1: Identify Process
└─ What repeatable task was completed?

Step 2: Document Steps
└─ Write detailed, sequential steps

Step 3: Add Examples
└─ Provide concrete examples

Step 4: Identify Mistakes
└─ What could go wrong?
└─ How to prevent it?

Step 5: Create Checklist
└─ How to validate success?

Step 6: Review & Test
└─ Have another agent follow SOP?
└─ Does it work as written?

Step 7: Publish
└─ Move to sops/[category]/
└─ Update injection-history.md
```

## 📋 Common Mistakes Log

The `common-mistakes.md` file tracks all discovered mistakes:

```markdown
## Common Mistakes Log

### [Task Category]: [Specific Mistake]

**Date Discovered**: [Date]
**Agent**: [Who discovered it]
**Severity**: [Critical/High/Medium/Low]

**Mistake**: [What was done wrong]
**Impact**: [What went wrong as a result]
**Root Cause**: [Why it happened]
**Prevention**: [How to avoid it]
**Related SOP**: [Link to SOP that addresses this]
**Status**: [Documented/Fixed/Preventable]

---

### Example: Database: Missing Index on Foreign Key

**Date Discovered**: 2025-11-15
**Agent**: integration-agent
**Severity**: High

**Mistake**: Added new table without indexing foreign key columns
**Impact**: Query performance degraded by 60%
**Root Cause**: Forgot SOP requirement to index FKs
**Prevention**: Always index foreign key columns before deploying
**Related SOP**: sops/database/add-new-table.md
**Status**: Fixed - Updated SOP to emphasize FK indexing
```

## 📚 Template SOPs (To Create)

### Database SOPs

**`add-new-table.md`**
- How to create a new database table
- When to use migrations
- Indexing requirements
- Common mistakes (FK indexing, null constraints, etc.)

**`add-migration.md`**
- How to create a database migration
- Testing migrations
- Rollback procedures
- Validation steps

**`common-mistakes.md`**
- Master list of database-related mistakes

### Integration SOPs

**`integrate-external-api.md`**
- How to integrate a new external API
- Authentication setup
- Error handling
- Rate limiting
- Testing the integration

**`create-sync-flow.md`**
- How to create a data sync flow
- Identifying data mapping
- Handling conflicts
- Monitoring sync health

**`error-handling.md`**
- Standard error handling patterns
- Retry logic
- Logging requirements
- Alerting setup

### Documentation SOPs

**`write-api-docs.md`**
- API documentation format
- Required sections
- Example requirements
- Validation checklist

**`create-prd.md`**
- How to write a PRD
- Required sections
- User story format
- Acceptance criteria format

**`generate-implementation-plan.md`**
- How to create an implementation plan
- Level of detail required
- Dependency identification
- Risk assessment

### Testing SOPs

**`unit-testing.md`**
- Testing standards
- Coverage requirements
- Mock setup
- Assertions best practices

**`integration-testing.md`**
- Integration test setup
- Fixture management
- Error scenario testing
- Performance testing

### Deployment SOPs

**`deploy-to-staging.md`**
- Staging deployment process
- Validation steps
- Rollback procedure
- Communication requirements

**`deploy-to-production.md`**
- Production deployment process
- Pre-deployment checks
- Monitoring setup
- Incident response

## 🎓 How Agents Use SOPs

### Before Starting Work

```
Agent checks:
1. "What task am I doing?" → Find relevant SOP
2. Read the SOP → Understand process
3. Check common mistakes → Avoid known issues
4. Follow step-by-step → Execute precisely
```

### While Working

```
Agent references:
1. Current step in SOP
2. Validation checks → Confirm success
3. Common mistakes list → Stay aware of pitfalls
4. Troubleshooting section → If something goes wrong
```

### After Completing Work

```
Agent:
1. Reviews what was completed
2. Identifies any new learnings
3. Discovers any new mistakes made
4. Creates/updates relevant SOP
5. Logs discoveries in common-mistakes.md
6. Updates injection-history.md
```

## ✅ Quality Standards

### For SOPs

✅ **Include**:
- Clear, step-by-step instructions
- Specific details (file names, commands, etc.)
- Practical examples
- Validation/checklist
- Common mistakes to avoid
- Troubleshooting guide
- Links to related docs

❌ **Avoid**:
- Vague instructions
- Missing details
- No validation steps
- No mistake warnings
- Untested procedures
- Isolated (no links)

### Testing SOPs

Before publishing, validate that:
- [ ] Another agent can follow it successfully
- [ ] All steps produce expected results
- [ ] Validation checks work
- [ ] Troubleshooting examples are accurate
- [ ] Common mistakes are realistic

## 📊 Current SOPs

| Category | SOP Name | Status | Version |
|----------|----------|--------|---------|
| (None yet) | — | — | — |

## 🚀 Getting Started with SOPs

### Week 1
- [ ] Create templates in `sops/templates/`
- [ ] Create first SOP based on a completed task
- [ ] Document common mistakes discovered

### Week 2-4
- [ ] Add 5-10 SOPs for common tasks
- [ ] Expand common-mistakes.md with lessons learned
- [ ] Cross-reference SOPs with system documentation

### Month 2+
- [ ] Comprehensive SOP library for all task types
- [ ] Mature common-mistakes log
- [ ] Regular SOP reviews and updates

## 🔄 Maintenance

### When Mistakes Happen

1. Document mistake in common-mistakes.md
2. Update relevant SOP to prevent it
3. Note in SOP version history
4. Update injection-history.md

### Monthly Reviews

- Review recent SOPs for accuracy
- Update examples if outdated
- Check for obsolete procedures

### Quarterly Audits

- Review all SOPs for completeness
- Identify missing SOPs
- Update procedures based on team feedback

## 📞 Quick Links

- **Knowledge Base Home**: `../ (README.md)`
- **Project Tasks**: `../tasks/`
- **System Documentation**: `../system/`
- **Injection History**: `../injection-history.md`
- **Common Mistakes**: `./common-mistakes.md`

## 🎯 SOP Categories

Recommended categories to create SOPs for:

- **Database**: Table creation, migrations, schema updates
- **Integration**: API integration, data sync, system connections
- **Documentation**: Writing PRDs, API docs, implementation plans
- **Testing**: Unit tests, integration tests, QA procedures
- **Deployment**: Staging deployment, production deployment, rollbacks
- **Maintenance**: Monitoring, troubleshooting, updates
- **Code Review**: Review standards, merge procedures, testing requirements

---

**Folder Purpose**: Standard Operating Procedures for consistent, quality work
**Current Status**: Structure ready, awaiting first SOP
**Version**: 1.0.0
**Last Updated**: 2025-11-21

Ready to start documenting processes!
