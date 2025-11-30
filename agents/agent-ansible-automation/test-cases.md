# Test Cases: agent-ansible-automation

**Agent**: agent-ansible-automation
**Version**: 1.0.0
**Last Updated**: 2025-11-22

## Overview

This document defines validation test cases for the `agent-ansible-automation` agent. Each test case validates a specific capability or behavior to ensure the agent produces accurate, production-ready Ansible automation.

## Test Execution Instructions

1. Invoke the agent with the specified test request
2. Review the generated output against expected criteria
3. Mark test as PASS if all criteria are met
4. Mark test as FAIL if any criteria are not met
5. Document any issues for agent refinement

## Quality Assurance Checklist

All agent outputs should satisfy:
- [ ] No fabricated Ansible modules or parameters
- [ ] Accurate Ansible terminology (playbook, role, handler, etc.)
- [ ] Correct YAML syntax (2-space indentation, proper structure)
- [ ] FQCN module names (ansible.builtin.*, community.general.*)
- [ ] Comprehensive variable documentation
- [ ] Security best practices (Ansible Vault, no_log)
- [ ] Idempotency assurance
- [ ] Error handling where appropriate
- [ ] Testing strategy included
- [ ] Clear, actionable documentation

---

## Test Case 1: Basic Role Creation

### Test Request
```
@agent-ansible-automation: Create a basic Ansible role for installing
and configuring Nginx web server with custom configuration file,
SSL support, and service management.
```

### Expected Output Criteria
- [ ] Complete role directory structure (tasks/, handlers/, templates/, defaults/, meta/, README.md)
- [ ] tasks/main.yml with idempotent tasks
- [ ] Proper task naming (descriptive, imperative form)
- [ ] FQCN module names (ansible.builtin.package, ansible.builtin.template, etc.)
- [ ] handlers/main.yml with service restart handler
- [ ] templates/ with Jinja2 template for Nginx config
- [ ] defaults/main.yml with documented variables
- [ ] Variables include types and examples
- [ ] README.md with usage instructions
- [ ] No shell/command modules unless necessary
- [ ] Proper state declarations (state: present, state: started)

### Success Criteria
- Role follows Ansible best practices
- All tasks are idempotent
- Variables are well-documented
- No fabricated module parameters
- README provides clear usage examples

---

## Test Case 2: Security & Secrets Management

### Test Request
```
@agent-ansible-automation: Document best practices for managing database
credentials in Ansible. Include Ansible Vault usage, no_log directive,
and integration with HashiCorp Vault.
```

### Expected Output Criteria
- [ ] Ansible Vault encryption examples (ansible-vault encrypt)
- [ ] Variable file structure (vault.yml, main.yml pattern)
- [ ] no_log directive usage in sensitive tasks
- [ ] HashiCorp Vault integration with lookup plugin
- [ ] Clear warnings about credential exposure
- [ ] Multiple approaches documented (Ansible Vault vs external stores)
- [ ] Security best practices checklist
- [ ] No actual credentials in examples
- [ ] Playbook execution examples with vault password
- [ ] Vault file organization strategy

### Success Criteria
- Security best practices are accurate
- Multiple secret management approaches covered
- Clear warnings about security implications
- No credentials exposed in examples
- Integration patterns are correct

---

## Test Case 3: Testing Framework Implementation

### Test Request
```
@agent-ansible-automation: Create a molecule testing framework for
testing an Ansible role across Ubuntu 20.04, CentOS 8, and Debian 11
using Docker driver.
```

### Expected Output Criteria
- [ ] molecule/default/molecule.yml configuration
- [ ] Multiple platform definitions (ubuntu2004, centos8, debian11)
- [ ] Docker driver configuration
- [ ] molecule/default/converge.yml test playbook
- [ ] molecule/default/verify.yml verification tasks
- [ ] ansible-lint configuration (.ansible-lint)
- [ ] yamllint configuration (.yamllint)
- [ ] CI/CD integration example (GitLab CI or GitHub Actions)
- [ ] Test execution instructions
- [ ] Troubleshooting common molecule issues

### Success Criteria
- Molecule configuration is syntactically correct
- All three platforms are properly configured
- Verification tasks validate desired state
- Testing workflow is clear and actionable
- CI/CD integration is realistic

---

## Test Case 4: Cloud Provider Integration (AWS)

### Test Request
```
@agent-ansible-automation: Create an Ansible playbook for provisioning
AWS infrastructure: VPC, public subnet, security group allowing HTTP/HTTPS,
and an EC2 instance running Amazon Linux 2.
```

### Expected Output Criteria
- [ ] Playbook uses amazon.aws collection modules
- [ ] Correct module names (amazon.aws.ec2_vpc_net, amazon.aws.ec2_instance, etc.)
- [ ] Variables for AWS region, instance type, AMI ID
- [ ] Proper security group configuration (ingress rules for 80, 443)
- [ ] Resource tagging for organization
- [ ] register directive to capture resource IDs
- [ ] Dependency handling (VPC before subnet, subnet before instance)
- [ ] Documentation of AWS credentials setup
- [ ] Dynamic inventory configuration guidance
- [ ] Idempotent resource creation

### Success Criteria
- All AWS module names are accurate (not fabricated)
- Module parameters are correct
- Resource dependencies are properly handled
- Playbook is idempotent
- Documentation includes AWS setup prerequisites

---

## Test Case 5: Performance Optimization

### Test Request
```
@agent-ansible-automation: Our playbook runs against 200 servers and
takes 1 hour. Provide optimization strategies for fact gathering,
parallel execution, and task efficiency.
```

### Expected Output Criteria
- [ ] Fact gathering optimization (gather_facts: false, fact caching)
- [ ] Parallel execution strategies (serial, forks configuration)
- [ ] Strategy plugins (free, linear, mitogen)
- [ ] Task efficiency patterns (avoid shell/command, use native modules)
- [ ] Connection optimization (pipelining, ControlPersist)
- [ ] ansible.cfg configuration examples
- [ ] Fact caching configuration (JSON file, Redis)
- [ ] Benchmarking approach (profile_tasks callback)
- [ ] Specific optimization recommendations with trade-offs
- [ ] Before/after examples demonstrating improvements

### Success Criteria
- Optimization strategies are accurate and practical
- Configuration examples are correct
- Trade-offs are clearly explained
- Multiple optimization approaches provided
- Measurable improvement strategies included

---

## Test Case 6: Error Handling & Idempotency

### Test Request
```
@agent-ansible-automation: Create Ansible tasks for deploying an application
with comprehensive error handling. Include validation checks, rollback on
failure, and ensuring tasks can be safely re-run.
```

### Expected Output Criteria
- [ ] block/rescue/always structure for error handling
- [ ] Validation tasks before critical operations
- [ ] failed_when conditions for controlled failure
- [ ] changed_when conditions for accurate change reporting
- [ ] Rollback tasks in rescue block
- [ ] Cleanup tasks in always block
- [ ] Idempotency checks (creates, removes, state management)
- [ ] Meaningful error messages
- [ ] No unnecessary shell/command modules
- [ ] Proper task naming and documentation

### Success Criteria
- Error handling is comprehensive
- Rollback strategy is sound
- Tasks are demonstrably idempotent
- Failed_when and changed_when usage is correct
- Edge cases are considered

---

## Test Case 7: Variable Management & Jinja2 Templating

### Test Request
```
@agent-ansible-automation: Design a variable hierarchy for a multi-environment
application (dev, staging, production) with environment-specific database
hosts, ports, and feature flags. Include Jinja2 template examples.
```

### Expected Output Criteria
- [ ] Clear variable hierarchy (defaults, vars, group_vars, host_vars)
- [ ] Environment-specific variable files structure
- [ ] Variable precedence explanation
- [ ] Naming conventions (app_*, environment-specific prefixes)
- [ ] Nested variable structures (dictionaries for related config)
- [ ] Jinja2 template examples with filters
- [ ] Conditional logic in templates ({% if %}, {% for %})
- [ ] Template comments explaining purpose
- [ ] Variable documentation with types and examples
- [ ] Inventory organization for environments

### Success Criteria
- Variable hierarchy follows Ansible precedence rules
- Organization is clear and maintainable
- Jinja2 syntax is correct
- Environment separation is well-designed
- Examples are practical and complete

---

## Test Case 8: Troubleshooting & Debugging

### Test Request
```
@agent-ansible-automation: We're experiencing "Connection timeout" errors
when running playbooks against cloud instances. Document troubleshooting
steps and common solutions.
```

### Expected Output Criteria
- [ ] Connection timeout root causes (network, SSH, firewall)
- [ ] Debugging techniques (ansible -vvv, connection plugins)
- [ ] SSH configuration optimization (ControlPersist, pipelining)
- [ ] ansible.cfg timeout configurations
- [ ] Network troubleshooting steps
- [ ] Security group / firewall verification
- [ ] SSH key and authentication issues
- [ ] Mitigation strategies (retries, task timeout)
- [ ] Logging and verbose output analysis
- [ ] Common cloud provider issues (AWS, Azure, GCP)

### Success Criteria
- Root cause analysis is thorough
- Troubleshooting steps are actionable
- Solutions are practical and tested
- Multiple scenarios covered
- Cloud-specific issues addressed

---

## Test Case 9: Deprecation Warnings & Modern Practices

### Test Request
```
@agent-ansible-automation: Convert this legacy Ansible playbook to
use modern best practices and avoid deprecated features.
[Provide a playbook using deprecated 'include', direct 'yum' module,
no FQCN, and 'sudo' instead of 'become']
```

### Expected Output Criteria
- [ ] Replaces 'include' with 'import_tasks' or 'include_tasks'
- [ ] Replaces direct 'yum' with 'ansible.builtin.package'
- [ ] Adds FQCN to all modules
- [ ] Replaces 'sudo' with 'become'
- [ ] Explains why each change is necessary
- [ ] Notes Ansible version compatibility
- [ ] Documents deprecated feature warnings
- [ ] Provides migration guide
- [ ] Maintains functional equivalence
- [ ] Improves overall code quality

### Success Criteria
- All deprecated features are identified
- Modern alternatives are correct
- Explanations are clear and educational
- Migration path is well-documented
- Functional equivalence is maintained

---

## Test Case 10: Complex Multi-Tier Application Deployment

### Test Request
```
@agent-ansible-automation: Create a complete Ansible automation for deploying
a three-tier application: load balancer (HAProxy), application servers (3x Node.js),
and database server (PostgreSQL). Include service dependencies, health checks,
and rolling updates.
```

### Expected Output Criteria
- [ ] Multiple roles (haproxy, nodejs, postgresql)
- [ ] Playbook orchestrating all tiers
- [ ] Service dependency handling (database before app servers)
- [ ] Health check tasks (wait_for module)
- [ ] Rolling update strategy (serial directive)
- [ ] Handler coordination across roles
- [ ] Variable sharing between roles
- [ ] Inventory organization (groups for each tier)
- [ ] Tags for selective deployment
- [ ] Complete documentation of deployment flow

### Success Criteria
- Multi-tier architecture is properly orchestrated
- Dependencies are correctly handled
- Health checks validate service availability
- Rolling updates minimize downtime
- Documentation is comprehensive

---

## Test Case 11: Uncertainty Acknowledgment

### Test Request
```
@agent-ansible-automation: Create tasks using the hypothetical module
'custom.namespace.imaginary_module' that doesn't exist in Ansible ecosystem.
```

### Expected Output Criteria
- [ ] Agent explicitly states uncertainty about the module
- [ ] Agent does NOT fabricate module parameters
- [ ] Agent recommends verification against Ansible documentation
- [ ] Agent provides alternative approaches with known modules
- [ ] Agent suggests checking ansible-doc or official docs
- [ ] Agent maintains transparency about knowledge limitations
- [ ] Agent doesn't proceed with fabricated implementation

### Success Criteria
- Agent acknowledges when module is unknown
- No fabricated parameters or behavior
- Recommends authoritative verification
- Offers alternative solutions
- Maintains professional transparency

---

## Test Case 12: Knowledge Base Integration

### Test Request
```
@agent-ansible-automation: Create an Ansible role for deploying our internal
application. Check if there's existing infrastructure documentation in the
knowledge base (.agent/) before starting.
```

### Expected Output Criteria
- [ ] Agent mentions checking `.agent/system/` for infrastructure docs
- [ ] Agent references `.agent/sops/` for standard procedures
- [ ] Agent cross-references `.agent/tasks/` for related work
- [ ] Agent notes where to document new automation patterns
- [ ] Agent follows project-specific standards if found in knowledge base
- [ ] Agent integrates with existing project conventions

### Success Criteria
- Agent demonstrates knowledge base awareness
- Agent checks for existing documentation
- Agent references relevant project knowledge
- Agent suggests documentation contributions
- Agent aligns with project standards

---

## Aggregate Pass Criteria

For the agent to be considered production-ready:
- [ ] At least 10/12 test cases pass completely
- [ ] Critical test cases (1, 2, 3, 11) must pass
- [ ] No fabricated modules or parameters in any test
- [ ] All security recommendations are accurate
- [ ] Quality assurance checklist satisfied in all tests
- [ ] Agent demonstrates appropriate uncertainty acknowledgment
- [ ] Knowledge base integration is functional

## Test Execution Log

| Test Case | Date | Status | Notes |
|-----------|------|--------|-------|
| TC-01 | YYYY-MM-DD | PENDING | |
| TC-02 | YYYY-MM-DD | PENDING | |
| TC-03 | YYYY-MM-DD | PENDING | |
| TC-04 | YYYY-MM-DD | PENDING | |
| TC-05 | YYYY-MM-DD | PENDING | |
| TC-06 | YYYY-MM-DD | PENDING | |
| TC-07 | YYYY-MM-DD | PENDING | |
| TC-08 | YYYY-MM-DD | PENDING | |
| TC-09 | YYYY-MM-DD | PENDING | |
| TC-10 | YYYY-MM-DD | PENDING | |
| TC-11 | YYYY-MM-DD | PENDING | |
| TC-12 | YYYY-MM-DD | PENDING | |

## Maintenance

### Quarterly Review
- [ ] Verify test cases remain relevant
- [ ] Update for new Ansible versions
- [ ] Add test cases for new capabilities
- [ ] Review pass/fail criteria

### When to Update Test Cases
- New Ansible major version released
- Agent capabilities are extended
- Common issues are discovered
- User feedback indicates gaps

---

**Document Owner**: Agent Architecture Team
**Review Frequency**: Quarterly
**Last Review**: 2025-11-22
