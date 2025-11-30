# agent-ansible-automation

**Version**: 1.0.0
**Status**: Production
**Agent Type**: Ansible Automation Development Specialist

## Overview

The `agent-ansible-automation` is an expert DevOps automation specialist designed to create production-ready Ansible playbooks, roles, and comprehensive automation documentation. This agent embodies deep expertise in Ansible best practices, security, testing, performance optimization, and cloud provider integration.

## Purpose

This agent helps teams:
- Create robust, idempotent Ansible playbooks and roles
- Design proper role structures following Ansible best practices
- Implement comprehensive testing strategies
- Secure automation with Ansible Vault and secrets management
- Optimize performance for large-scale deployments
- Integrate with cloud providers (AWS, Azure, GCP)
- Troubleshoot and debug Ansible automation issues

## When to Use This Agent

Invoke `agent-ansible-automation` when you need:

### Playbook & Role Development
- Creating new Ansible playbooks from scratch
- Designing Ansible role structures with proper organization
- Converting shell scripts or manual procedures to Ansible automation
- Refactoring existing playbooks for better maintainability

### Infrastructure Automation
- Automating server configuration and deployment
- Managing application installations and updates
- Orchestrating multi-tier infrastructure provisioning
- Implementing infrastructure-as-code patterns

### Testing & Quality Assurance
- Setting up ansible-lint for syntax validation
- Implementing molecule testing frameworks
- Creating integration test suites
- Establishing CI/CD pipelines for Ansible code

### Security & Compliance
- Implementing Ansible Vault for secrets management
- Integrating with external secret stores (HashiCorp Vault, AWS Secrets Manager)
- Ensuring secure credential handling
- Following security best practices and compliance requirements

### Performance Optimization
- Optimizing playbook execution speed
- Implementing fact caching strategies
- Configuring parallel execution
- Troubleshooting slow playbook runs

### Cloud Integration
- Writing AWS automation with amazon.aws collection
- Creating Azure infrastructure with azure.azcollection
- Managing GCP resources with google.cloud collection
- Implementing dynamic inventory for cloud environments

### Variable & Inventory Management
- Designing variable hierarchies and precedence
- Creating dynamic inventories
- Managing environment-specific configurations
- Implementing Jinja2 templating patterns

## Key Capabilities

### Code Generation
- Production-ready Ansible playbooks
- Complete role structures with all components
- Idempotent task implementations
- Error handling with block/rescue/always
- Jinja2 templates for configuration files

### Documentation
- Comprehensive README files for roles
- Variable documentation with types and examples
- Usage examples for different scenarios
- Troubleshooting guides
- Best practices documentation

### Testing Frameworks
- Ansible-lint configurations
- Molecule test scenarios
- YAML linting setups
- Integration test strategies
- CI/CD pipeline examples

### Best Practices
- YAML syntax and formatting guidelines
- Variable naming conventions
- Task organization patterns
- Handler usage recommendations
- Tag strategies for selective execution

## Agent Constraints

### What This Agent Does NOT Do
- Fabricate Ansible modules or parameters
- Assume undocumented module behavior
- Provide infrastructure-as-code for other tools (Terraform, CloudFormation) unless integration is specifically requested
- Make assumptions about target system state without validation
- Include production credentials or API keys in examples
- Guarantee specific performance metrics without qualification

### Transparency & Accuracy
The agent:
- Acknowledges uncertainties about module parameters or version-specific features
- Recommends verification against official Ansible documentation when uncertain
- Uses accurate Ansible terminology consistently
- Warns about deprecated modules and features
- Qualifies environment-specific recommendations appropriately

## How to Invoke

### Direct Invocation
```bash
@agent-ansible-automation: [Your specific request]
```

### Example Invocations

#### Example 1: Complete Role Creation
```bash
@agent-ansible-automation: Create a complete Ansible role for deploying
a Django application with Nginx reverse proxy, Gunicorn application server,
PostgreSQL database, SSL certificates via Let's Encrypt, and systemd service
management. Include proper variable management, handlers, templates, and
molecule testing.
```

#### Example 2: Security Best Practices
```bash
@agent-ansible-automation: Document best practices for managing secrets
in Ansible automation. Include Ansible Vault usage, integration with
HashiCorp Vault, no_log directive usage, and secure variable handling
across multiple environments.
```

#### Example 3: Testing Strategy
```bash
@agent-ansible-automation: Create a comprehensive testing framework for
an Ansible role that needs to support Ubuntu 20.04, CentOS 8, and Debian 11.
Include ansible-lint configuration, molecule setup with Docker driver, and
CI/CD integration examples for GitLab CI.
```

#### Example 4: Performance Optimization
```bash
@agent-ansible-automation: Our Ansible playbook takes 45 minutes to run
across 100 servers. Analyze common performance bottlenecks and provide
optimization strategies including fact caching, parallel execution, and
task delegation patterns.
```

#### Example 5: Cloud Integration
```bash
@agent-ansible-automation: Create an Ansible playbook for provisioning
AWS infrastructure including VPC, subnets, security groups, EC2 instances,
RDS database, and S3 buckets. Include dynamic inventory configuration and
proper tagging strategy.
```

#### Example 6: Troubleshooting
```bash
@agent-ansible-automation: We're getting "Unreachable host" errors
intermittently when running playbooks against cloud instances. Document
common causes and troubleshooting steps for Ansible connection issues.
```

## Output Format

The agent provides:

### Ansible Code
- Properly formatted YAML (2-space indentation)
- Fully Qualified Collection Names (FQCN) for all modules
- Comprehensive task names and documentation
- Idempotent task implementations
- Error handling and validation

### Documentation
- Markdown-formatted guides and README files
- Clear section organization with headings
- Code blocks with syntax highlighting
- Tables for variable documentation
- Step-by-step procedures

### Examples
- Complete, working examples
- Multiple scenarios (basic to advanced)
- Environment-specific variations
- Testing and validation steps

## Quality Standards

All outputs from this agent include:
- [ ] Descriptive task names in imperative form
- [ ] Idempotency assurance (no shell/command unless necessary)
- [ ] Correct YAML syntax (2-space indentation)
- [ ] FQCN module names (ansible.builtin.*, community.general.*)
- [ ] Comprehensive variable documentation
- [ ] Security best practices (Ansible Vault, no_log)
- [ ] Error handling where appropriate
- [ ] Proper tag usage for selective execution
- [ ] Handler usage instead of always-run tasks
- [ ] No deprecated modules without warnings
- [ ] Testing strategy documentation
- [ ] Performance optimization notes

## Integration with Knowledge Base

This agent integrates with the project's knowledge base structure:

### Knowledge Base References
The agent checks and references:
- `.agent/system/` - Infrastructure documentation and deployment procedures
- `.agent/tasks/` - Related implementation plans and PRDs
- `.agent/sops/` - Standard Operating Procedures for automation

### Knowledge Contribution
After completing automation work, the agent notes:
- New automation patterns discovered
- Common Ansible mistakes and how to avoid them
- Best practices that should become standard procedures

## Dependencies

### Ansible Versions
- Knowledge base covers Ansible 2.9+
- Uses modern Ansible practices (collections, FQCN)
- Warns about version-specific features

### Collections Referenced
- `ansible.builtin` - Core Ansible modules
- `community.general` - Community-maintained general modules
- `amazon.aws` - AWS automation
- `azure.azcollection` - Azure automation
- `google.cloud` - GCP automation

### Testing Tools
- `ansible-lint` - Ansible-specific linting
- `yamllint` - YAML syntax validation
- `molecule` - Role testing framework
- `ansible-test` - Ansible collection testing

## Project Integration

### Repository Structure
```
agents/agent-ansible-automation/
├── README.md                        # This file
├── test-cases.md                    # Validation test cases
└── examples/
    ├── webserver-role-example.md    # Complete role example
    ├── playbook-example.md          # Sample playbook
    └── molecule-test-example.md     # Testing example
```

### Related Documentation
- `.claude/agents/agent-ansible-automation.md` - Agent definition and system prompt
- `AGENTS_REGISTRY.md` - Central agent registry
- `CLAUDE.md` - Project configuration
- `AGENTS_REPOSITORY_GUIDE.md` - Agent creation guide

## Version History

### v1.0.0 (2025-11-22)
- Initial release
- Complete Ansible automation capabilities
- Playbook and role creation
- Testing framework support
- Security best practices
- Cloud provider integration
- Performance optimization guidance
- Knowledge base integration

## Support & Feedback

### Getting Help
1. Review this README for usage guidance
2. Check examples in `examples/` directory
3. Consult `AGENTS_REGISTRY.md` for agent status
4. Contact Agent Architecture Team for issues

### Reporting Issues
When reporting issues, include:
- Agent ID: `agent-ansible-automation`
- Exact invocation request
- Expected output
- Actual output received
- Environment context (Ansible version, target OS, etc.)

## Validation & Testing

Before using agent outputs in production:
- [ ] Verify accuracy against Ansible documentation
- [ ] Test playbooks/roles in sandbox environment
- [ ] Run syntax checks (`ansible-playbook --syntax-check`)
- [ ] Execute linting (`ansible-lint`, `yamllint`)
- [ ] Validate idempotency (run twice, check for changes)
- [ ] Test error handling scenarios
- [ ] Review security implications
- [ ] Check performance in representative environment

## Best Practices for Users

### Do
- Review agent outputs before production deployment
- Test automation in sandbox environments first
- Verify module parameters against Ansible documentation
- Provide detailed context when invoking the agent
- Report inaccuracies to improve the agent
- Use agent outputs as starting points, customize as needed

### Don't
- Assume outputs are production-ready without testing
- Skip validation and testing steps
- Ignore security warnings or recommendations
- Use agent for out-of-scope tools (Terraform, CloudFormation)
- Expect the agent to replace Ansible expertise
- Deploy untested automation to production

## Examples Quick Reference

| Example | Location | Description |
|---------|----------|-------------|
| Web Server Role | `examples/webserver-role-example.md` | Complete role structure for Nginx deployment |
| Sample Playbook | `examples/playbook-example.md` | Full playbook with best practices |
| Molecule Testing | `examples/molecule-test-example.md` | Testing framework setup |

## Tags & Keywords

`ansible`, `automation`, `devops`, `infrastructure-as-code`, `configuration-management`,
`playbooks`, `roles`, `ansible-vault`, `testing`, `molecule`, `ansible-lint`,
`cloud-automation`, `aws`, `azure`, `gcp`, `idempotency`, `jinja2`, `inventory-management`

---

**Agent Status**: ✅ Production Ready
**Last Updated**: 2025-11-22
**Maintained By**: Agent Architecture Team
