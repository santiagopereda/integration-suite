# CLAUDE.md - Agent Repository Hub Configuration

This file configures Claude Code agents and tools for the Agentic project - a centralized hub for designing, creating, and maintaining reusable specialized agents.

## Project Overview

**Purpose**: Serve as a base repository where specialized Claude Code agents are designed, created, documented, and tested before deployment to other projects.

**Vision**: Enable teams to leverage consistent, high-quality specialized agents across multiple projects with clear governance, versioning, and quality standards.

## Available Agents

### agent-sap-businesspartner-integration (v1.0.0) - Production

**ID**: `agent-sap-businesspartner-integration`

**Purpose**: Expert SAP S/4HANA Cloud consultant specializing in BusinessPartner master data integration through OData APIs.

**Use When**:
- Documenting BusinessPartner OData API integration procedures
- Creating step-by-step guides for BP create/update/patch operations
- Defining data sequencing and dependencies across sub-entities
- Requiring integration best practices and error handling guidance
- Clarifying PATCH vs PUT operation semantics
- Establishing validation rules and escalation procedures

**Location**: `.claude/agents/agent-sap-businesspartner-integration.md`

**Key Files**:
- `.claude/agents/agent-sap-businesspartner-integration.md` - Agent definition (Claude Code format)
- `agents/agent-sap-businesspartner-integration/README.md` - Detailed usage guide
- `agents/agent-sap-businesspartner-integration/test-cases.md` - Validation test cases

**Capabilities**:
- BusinessPartner entity creation and updates
- Sub-entity management (Roles, Addresses, Tax, Bank, Communications)
- API sequencing and dependency documentation
- PATCH vs PUT operation guidance
- Validation and data cleansing rules
- Error handling and troubleshooting
- Escalation procedures
- Misuse prevention guidance

**Critical Constraints**:
- Never fabricates SAP functionality
- Acknowledges uncertainties and recommends verification
- Uses accurate SAP terminology and API patterns
- Does not include proprietary SAP content
- Provides accurate entity names and endpoint patterns

**Invoke With**:
```bash
@agent-sap-businesspartner-integration: [Your documentation request]
```

**Examples**:
```bash
# Complete integration guide
@agent-sap-businesspartner-integration: Create comprehensive documentation
for BusinessPartner creation with addresses and tax numbers

# Specific operation
@agent-sap-businesspartner-integration: Document how to use PATCH
to update a BusinessPartner address field

# Best practices
@agent-sap-businesspartner-integration: Document best practices
for bulk BusinessPartner imports with error handling
```

**Documentation**:
- User Guide: `agents/agent-sap-businesspartner-integration/README.md`
- Test Cases: `agents/agent-sap-businesspartner-integration/test-cases.md`

---

### agent-ansible-automation (v1.0.0) - Production

**ID**: `agent-ansible-automation`

**Purpose**: Expert DevOps automation specialist focusing on Ansible automation development including playbook creation, role design, inventory management, testing, and security best practices.

**Use When**:
- Creating production-ready Ansible playbooks, roles, or tasks
- Designing Ansible role structure and best practices
- Requiring inventory management guidance (static or dynamic)
- Implementing testing strategies (ansible-lint, molecule, yamllint)
- Needing security best practices (Ansible Vault, secrets management)
- Optimizing Ansible performance and execution
- Integrating with cloud providers (AWS, Azure, GCP)
- Troubleshooting and debugging Ansible automation

**Location**: `.claude/agents/agent-ansible-automation.md`

**Key Files**:
- `.claude/agents/agent-ansible-automation.md` - Agent definition (Claude Code format)
- `agents/agent-ansible-automation/README.md` - Detailed usage guide
- `agents/agent-ansible-automation/test-cases.md` - 12 validation test cases
- `agents/agent-ansible-automation/examples/` - Complete examples

**Capabilities**:
- Production-ready Ansible playbooks and roles
- Role directory structure with all components
- Idempotent task implementations
- Comprehensive error handling (block/rescue/always)
- Variable management and Jinja2 templating
- Testing framework setup (molecule, ansible-lint, yamllint)
- Security implementation (Ansible Vault, no_log)
- Performance optimization strategies
- Cloud provider integration (AWS, Azure, GCP)
- Multi-platform role development
- CI/CD pipeline integration
- Troubleshooting and debugging guidance

**Critical Constraints**:
- Never fabricates Ansible modules or parameters
- Acknowledges uncertainties and recommends verification
- Uses accurate Ansible terminology (playbook, role, handler)
- References correct module names with FQCN (ansible.builtin.*)
- Provides correct YAML syntax (2-space indentation)
- Warns about deprecated modules and features
- Does not assume undocumented module behavior

**Invoke With**:
```bash
@agent-ansible-automation: [Your automation request]
```

**Examples**:
```bash
# Complete role creation
@agent-ansible-automation: Create a complete Ansible role for deploying
a Django application with Nginx, Gunicorn, PostgreSQL, and SSL certificates

# Security guidance
@agent-ansible-automation: Document best practices for managing secrets
in Ansible using Ansible Vault and integration with HashiCorp Vault

# Testing framework
@agent-ansible-automation: Create a molecule testing framework for
testing an Ansible role across Ubuntu 20.04, CentOS 8, and Debian 11

# Performance optimization
@agent-ansible-automation: Provide optimization strategies for playbooks
running against 200 servers including fact caching and parallel execution

# Cloud integration
@agent-ansible-automation: Create an Ansible playbook for provisioning
AWS infrastructure including VPC, subnets, security groups, and EC2 instances
```

**Documentation**:
- User Guide: `agents/agent-ansible-automation/README.md`
- Test Cases: `agents/agent-ansible-automation/test-cases.md`
- Examples: `agents/agent-ansible-automation/examples/`
  - `webserver-role-example.md` - Complete Nginx role
  - `playbook-example.md` - Multi-tier deployment playbook
  - `molecule-test-example.md` - Testing framework

---

## Agent Repository Tools

### agent-architect (Meta-Agent)

Use this specialized agent to help design new agents:

**Purpose**: Guide comprehensive agent design and specification

**Use When**:
- Planning a new specialized agent
- Need help defining agent scope and boundaries
- Designing system prompts for agents
- Establishing test cases and quality standards

**Invoke With**:
```bash
@agent-architect: [Your agent design request]
```

**Capabilities**:
- Requirements gathering and clarification
- Agent specification design
- System prompt engineering
- Test case development
- Quality standard definition
- Integration guidance

---

## Knowledge Base & Agent Context

The project includes a comprehensive knowledge management system at `.agent/` that serves as the centralized context for all agents.

### Knowledge Base Structure

```
.agent/
├── README.md                    ← Overview & navigation
├── injection-history.md         ← Log of all documentation added
├── tasks/                       ← PRDs & Implementation Plans
├── system/                      ← Project Structure, Schemas, APIs
└── sops/                        ← Standard Operating Procedures
```

### What Agents Use

**Tasks Folder** (`tasks/`):
- Product Requirements Documents (PRDs)
- Implementation plans (created before coding)
- User stories and acceptance criteria
- Referenced when starting new features

**System Folder** (`system/`):
- Project structure and organization
- Data schemas and entity models
- API documentation and endpoints
- Integration specifications
- Grows continuously as project evolves

**SOPs Folder** (`sops/`):
- Standard Operating Procedures for common tasks
- Step-by-step instructions for consistency
- Common mistakes log (what to avoid)
- Templates for repeated work
- Created after completing tasks

### How Agents Use Knowledge Base

```
Agent Workflow:
1. Read: tasks/[feature]/prd.md          (understand requirements)
2. Review: tasks/[feature]/implementation-plan.md  (understand approach)
3. Check: system/[domain]/ documentation (understand systems & APIs)
4. Reference: sops/[category]/[process].md  (follow standard procedures)
5. Execute: Following knowledge as context
6. Create: SOP for the process after completion
```

### Adding to Knowledge Base

After completing a task:
```
1. Document new schemas in: system/schemas/
2. Document new APIs in: system/apis/
3. Document new integrations in: system/integrations/
4. Create SOP in: sops/[category]/
5. Log discoveries in: sops/common-mistakes.md
6. Update: injection-history.md
```

### Quick Links

- **Knowledge Base Home**: `.agent/README.md`
- **Tasks Guide**: `.agent/tasks/README.md`
- **System Guide**: `.agent/system/README.md`
- **SOPs Guide**: `.agent/sops/README.md`
- **What's Been Added**: `.agent/injection-history.md`

---

## Repository Structure

```
/Agentic
├── agents/
│   └── agent-sap-businesspartner-integration/
│       ├── agent.yml
│       ├── system-prompt.md
│       ├── README.md
│       ├── test-cases.md
│       └── examples/
├── docs/
│   └── sap-integration/
│       └── businesspartner/
│           ├── bp-create-flow.md
│           ├── bp-update-patterns.md
│           └── [generated docs]
├── AGENTS_REGISTRY.md          # Central registry of all agents
├── AGENTS_REPOSITORY_GUIDE.md  # How to create new agents
└── CLAUDE.md                   # This file
```

---

## How to Use This Repository

### 1. Finding an Agent

**Check AGENTS_REGISTRY.md** for:
- Complete list of available agents
- Quick reference table
- Agent descriptions and capabilities
- Status and version information

### 2. Using an Agent

**Step 1**: Read the agent's README
- Understand trigger conditions
- Review usage examples
- Check output format

**Step 2**: Invoke the agent
```bash
@agent-sap-businesspartner-integration: [Your specific request]
```

**Step 3**: Review generated output
- Verify accuracy in sandbox
- Check for fabricated functionality
- Validate against documentation
- Test procedures before production use

### 3. Creating a New Agent

**Use the AGENTS_REPOSITORY_GUIDE.md** which provides:
- 7-phase creation workflow
- Agent anatomy and file structure
- System prompt templates
- Test case examples
- Quality standards and checklists

**Quick Start**:
1. Read AGENTS_REPOSITORY_GUIDE.md
2. Use `@agent-architect` to help design
3. Follow the 7-phase workflow
4. Validate with test cases
5. Add to AGENTS_REGISTRY.md
6. Update CLAUDE.md

### 4. Reporting Issues

**Found a problem?**
1. Document the issue with specific examples
2. Check if it's documented behavior or unexpected
3. Report to Agent Architecture Team
4. Include: agent ID, request, actual output, expected output

---

## Workflows

### Workflow 1: Document BusinessPartner Integration

**Goal**: Create comprehensive guide for BusinessPartner OData integration

**Steps**:
1. Review `agents/agent-sap-businesspartner-integration/README.md`
2. Invoke with specific scope (create, update, sub-entities, etc.)
3. Review generated Markdown documentation
4. Verify accuracy in SAP sandbox
5. Add to docs/sap-integration/businesspartner/
6. Share with team

**Example**:
```bash
@agent-sap-businesspartner-integration: Create documentation for the
complete BusinessPartner onboarding flow: person entity with employee role,
home address, work address, phone, email, and bank details. Include
step-by-step procedures, validation rules, error handling, and escalation.
```

### Workflow 2: Create New Agent

**Goal**: Design and implement a new specialized agent

**Steps**:
1. Read AGENTS_REPOSITORY_GUIDE.md (complete workflow)
2. Use `@agent-architect` for requirements analysis
3. Follow 7-phase creation process
4. Implement configuration files
5. Develop and run test cases
6. Document in AGENTS_REGISTRY.md
7. Update CLAUDE.md
8. Notify team

**Time Estimate**: 4-6 hours for comprehensive agent

### Workflow 3: Update Existing Agent

**Goal**: Refine agent based on feedback or changes

**Steps**:
1. Identify what needs updating
2. Update system prompt (system-prompt.md)
3. Add test cases if needed (test-cases.md)
4. Run validation tests
5. Update README if behavior changed
6. Update version in agent.yml
7. Document change in AGENTS_REGISTRY.md

---

## Quality Gates

### Before Using Agent Output

- [ ] Verified accuracy (spot-checked against authoritative source)
- [ ] Tested procedures in sandbox
- [ ] No fabricated functionality detected
- [ ] Uncertainties are clearly called out
- [ ] SAP API endpoints and entity names are correct
- [ ] Examples are realistic and complete

### Before Deploying Agent to Production

- [ ] All test cases pass (100%)
- [ ] System prompt is comprehensive and clear
- [ ] Documentation is complete and accurate
- [ ] README provides clear trigger conditions
- [ ] Examples demonstrate key capabilities
- [ ] Quality standards checklist is satisfied
- [ ] Team has reviewed and approved
- [ ] AGENTS_REGISTRY.md is updated

---

## Best Practices

### For Users

✅ **Do**:
- Read agent README before using
- Verify outputs in sandbox before production
- Report inaccuracies to improve agents
- Use agents proactively for relevant tasks
- Provide feedback on usefulness

❌ **Don't**:
- Assume outputs are production-ready without review
- Ignore agent limitations
- Use agents for out-of-scope purposes
- Bypass validation and testing
- Expect agents to replace domain experts

### For Maintainers

✅ **Do**:
- Keep system prompts current and accurate
- Test agents quarterly
- Document limitations transparently
- Incorporate team feedback
- Version control carefully
- Acknowledge uncertainty rather than guess

❌ **Don't**:
- Fabricate functionality
- Include proprietary content verbatim
- Skip test cases
- Leave uncertainties undocumented
- Forget to update AGENTS_REGISTRY.md
- Ignore maintenance triggers

---

## Integration with Projects

### Using This Agent Hub in Other Projects

**In a project's CLAUDE.md**, reference available agents:

```yaml
# Pull agents from centralized hub
agents:
  - id: agent-sap-businesspartner-integration
    source: /IntoData/Internal/Agentic/agents/
    version: "1.0.0"
    use_for: "SAP BusinessPartner OData integration documentation"
```

**Then invoke normally**:
```bash
@agent-sap-businesspartner-integration: [Your request]
```

### Versioning

Agents follow semantic versioning:
- `1.0.0` - Major version, breaking changes possible
- `1.1.0` - Minor version, new features backward compatible
- `1.0.1` - Patch version, bug fixes only

Check AGENTS_REGISTRY.md for current versions before using.

---

## Maintenance Schedule

### Quarterly Review (Each Quarter)

- [ ] Verify agent outputs remain accurate
- [ ] Check for new API versions or standards
- [ ] Review team feedback
- [ ] Update system prompts if needed
- [ ] Run validation tests
- [ ] Update version if changes made
- [ ] Document any improvements

### Annual Audit (Annually)

- [ ] Comprehensive accuracy review
- [ ] Check usage patterns across projects
- [ ] Gather feedback from all users
- [ ] Assess ROI and deprecation candidates
- [ ] Plan improvements for next year
- [ ] Update AGENTS_REPOSITORY_GUIDE.md

### On-Demand (As Needed)

- **SAP API Update**: Test and update agent if APIs change
- **Team Feedback**: Address reported issues quickly
- **New Feature Request**: Evaluate feasibility
- **Deprecation**: Plan sunset for obsolete agents

---

## Support

### Getting Help

**For agent questions**:
1. Check agent README first
2. Review examples in agent directory
3. Check AGENTS_REGISTRY.md
4. Ask Agent Architecture Team

**For repository questions**:
1. Read AGENTS_REPOSITORY_GUIDE.md
2. Check AGENTS_REGISTRY.md
3. Review this CLAUDE.md
4. Ask Agent Architecture Team

### Reporting Issues

Report issues with:
1. Agent ID
2. Exact request you made
3. What you expected
4. What actually happened
5. Evidence (screenshots, logs, etc.)

---

## Document References

| Document | Purpose | Audience |
|----------|---------|----------|
| AGENTS_REGISTRY.md | Central hub of all agents | Everyone |
| AGENTS_REPOSITORY_GUIDE.md | How to create new agents | Agent creators |
| CLAUDE.md (this file) | Agent configuration | Everyone |
| agents/*/README.md | Agent-specific usage | Agent users |
| agents/*/system-prompt.md | Agent personality/behavior | Maintainers |
| agents/*/test-cases.md | Validation framework | QA/Maintainers |

---

## Contact & Contributions

**Agent Architecture Team**: Maintains this repository hub

**Contributing**:
- Suggest new agents with detailed requirements
- Report issues with specific examples
- Provide feedback on agent accuracy/usefulness
- Contribute test cases and examples
- Help document improvements

**Questions?**
- Review AGENTS_REPOSITORY_GUIDE.md
- Check AGENTS_REGISTRY.md
- Ask Agent Architecture Team

---

## Project Status

**Repository Status**: Active
**Version**: 1.1.0
**Last Updated**: 2025-11-22

**Current Agents**:
- 2 production-ready agents
  - agent-sap-businesspartner-integration (v1.0.0)
  - agent-ansible-automation (v1.0.0)
- 0 beta agents
- 0 deprecated agents

**Roadmap**: See AGENTS_REGISTRY.md for planned future agents

---

## Next Steps

### To Get Started

1. **Read AGENTS_REGISTRY.md** - See what agents are available
2. **Explore existing agents** - Examples of production agents:
   - agent-sap-businesspartner-integration - SAP OData API integration
   - agent-ansible-automation - DevOps automation development
3. **Try an agent** - Invoke it with a specific request
4. **Provide feedback** - Help improve the agents

### To Create a New Agent

1. **Read AGENTS_REPOSITORY_GUIDE.md** - Full 7-phase process
2. **Use @agent-architect** - Get help designing
3. **Follow the workflow** - Build, test, validate
4. **Register and deploy** - Make available to team

---

**This repository hub is designed to scale. As you create and refine agents, update these documents to reflect your growing library of specialized tools.**
