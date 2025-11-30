# Ansible Playbook/Role: [Name]

<!-- Token Budget Guidelines:
- Brief Mode: Core sections only (500-800 tokens)
- Standard Mode: All sections, concise (1,500-3,000 tokens)
- Detailed Mode: All sections, comprehensive examples (3,000-6,000 tokens)
-->

## Overview
<!-- Brief: 100-150 tokens | Standard: 150-250 tokens | Detailed: 300-400 tokens -->

**Purpose**: [What this playbook/role accomplishes]
**Scope**: [Systems affected, operations performed]
**Target Systems**: [OS/platform requirements]
**Prerequisites**: [Required access, tools, dependencies]

---

## Requirements
<!-- Brief: skip | Standard: 100-150 tokens | Detailed: 200-300 tokens -->

- **Ansible version**: X.Y+ (minimum version required)
- **Python version on target**: X.Y+ (target system requirement)
- **Required collections**:
  - `collection.namespace` (version X.Y+)
  - `collection.other` (version X.Y+)
- **Target OS**: [List supported operating systems]
- **Privileges**: [sudo/root requirements, specific user permissions]
- **Network**: [Connectivity requirements, firewall rules]

---

## Role Variables
<!-- Brief: skip | Standard: 200-300 tokens | Detailed: 400-600 tokens -->

### Required Variables
```yaml
variable_name:
  description: "Purpose and usage"
  type: string|list|dict|boolean
  default: none (must be provided)
  example: "example_value"
  validation: "Constraints or validation rules"

another_required_var:
  description: "Purpose and usage"
  type: string
  default: none
  example: "example_value"
```

### Optional Variables
```yaml
optional_variable:
  description: "Purpose and usage"
  type: string|list|dict|boolean
  default: "default_value"
  example: "alternative_value"
  notes: "When/why to override default"
```

---

## Dependencies
<!-- Brief: skip | Standard: 50-100 tokens | Detailed: 100-150 tokens -->

**Role Dependencies**:
- `namespace.role_name` - [Why this dependency exists]
- `other.role` - [Purpose of this role]

**External Dependencies**:
- [System packages required on target]
- [Services that must be running]

---

## Usage Examples
<!-- Brief: Basic example only (100-150 tokens) | Standard: 2-3 examples (300-400 tokens) | Detailed: 4-5 examples (600-800 tokens) -->

### Example 1: Basic Usage
```yaml
---
- hosts: webservers
  become: yes
  roles:
    - role: namespace.role_name
      variable_name: "value"
      another_var: "value"
```

### Example 2: Advanced Configuration
```yaml
---
- hosts: application_servers
  become: yes
  vars:
    app_config:
      setting1: value1
      setting2: value2
  roles:
    - role: namespace.role_name
      variable_name: "{{ app_config.setting1 }}"
      complex_var:
        - item1
        - item2
```

### Example 3: Multiple Environments
```yaml
---
- hosts: "{{ target_environment }}"
  become: yes
  vars_files:
    - "vars/{{ target_environment }}.yml"
  roles:
    - role: namespace.role_name
      variable_name: "{{ environment_specific_value }}"
```

---

## Handlers
<!-- Brief: skip | Standard: 100-150 tokens | Detailed: 150-200 tokens -->

**Available Handlers**:
- `restart [service_name]`: Triggered when configuration changes require service restart
- `reload [service_name]`: Triggered when configuration can be hot-reloaded
- `validate [config]`: Runs validation before applying changes

**Handler Behavior**:
- Handlers run at the end of the play
- Multiple notifications to same handler run it once
- Use `flush_handlers` for immediate execution

---

## Tags
<!-- Brief: skip | Standard: 100-150 tokens | Detailed: 150-200 tokens -->

**Available Tags for Selective Execution**:
- `install`: Installation tasks only
- `config` / `configuration`: Configuration tasks
- `service`: Service management tasks
- `validation`: Pre/post validation checks
- `[specific-feature]`: Feature-specific tasks

**Usage**:
```bash
# Run only configuration tasks
ansible-playbook playbook.yml --tags config

# Skip installation
ansible-playbook playbook.yml --skip-tags install
```

---

## Testing
<!-- Brief: skip | Standard: 150-200 tokens | Detailed: 300-400 tokens -->

### Syntax Check
```bash
ansible-playbook playbook.yml --syntax-check
```

### Dry Run (Check Mode)
```bash
ansible-playbook playbook.yml --check --diff
```

### Linting
```bash
# YAML linting
yamllint playbook.yml

# Ansible best practices
ansible-lint playbook.yml
```

### Molecule Testing (for roles)
```bash
# Test role across multiple platforms
cd roles/role_name
molecule test

# Test specific scenario
molecule test --scenario-name centos8
```

### Integration Testing
[Project-specific integration test procedures]

---

## Idempotency
<!-- Brief: skip | Standard: 100-150 tokens | Detailed: 200-300 tokens -->

**How this playbook/role ensures idempotency**:
- Uses declarative modules (file, package, service) instead of shell/command
- Implements `changed_when` and `failed_when` for command tasks
- Checks state before making changes
- Uses `creates`/`removes` parameters where applicable

**Safe Re-execution**:
- Can be run multiple times without side effects
- Makes changes only when system state differs from desired state
- Idempotent validation: [Specific checks performed]

---

## Error Handling
<!-- Brief: skip | Standard: 150-200 tokens | Detailed: 300-400 tokens -->

**Error Handling Strategies**:
- **Block/Rescue/Always**: Critical operations wrapped in error handling
- **Validation Checks**: Pre-flight checks before destructive operations
- **Rollback Procedures**: [How failures are handled/reverted]
- **Logging**: [Where errors are logged]

**Common Failure Scenarios**:
1. [Scenario]: [How it's handled]
2. [Scenario]: [Recovery procedure]

**Failure Notifications**:
- [How failures are communicated - email, Slack, etc.]

---

## Security Considerations
<!-- Brief: skip | Standard: 150-200 tokens | Detailed: 300-400 tokens -->

**Secrets Management**:
- Sensitive variables stored in Ansible Vault
- `no_log: true` applied to tasks handling secrets
- Credentials never hardcoded in playbooks

**File Permissions**:
- Configuration files set with appropriate permissions
- Sensitive files (keys, certs) have restricted access

**Least Privilege**:
- Tasks run with minimum required privileges
- `become` used only when necessary

**Sensitive Data Handling**:
```yaml
- name: Task handling sensitive data
  module_name:
    sensitive_param: "{{ vaulted_variable }}"
  no_log: true
```

---

## Performance Considerations
<!-- Brief: skip | Standard: 100-150 tokens | Detailed: 200-300 tokens -->

**Optimization Strategies Applied**:
- **Fact Gathering**: `gather_facts: false` when not needed
- **Parallelism**: `serial` or `forks` configured appropriately
- **Task Delegation**: Resource-intensive tasks delegated where appropriate
- **Caching**: [Fact caching configuration if applicable]

**Performance Notes**:
- [Execution time expectations]
- [Resource usage (CPU, memory, network)]
- [Recommendations for large-scale deployments]

**Scaling Guidance**:
```yaml
- hosts: large_inventory
  serial: "30%"  # Process 30% of hosts at a time
  strategy: free  # Don't wait for all hosts per task
```

---

## Troubleshooting
<!-- Brief: Common issues only (100-150 tokens) | Standard: 200-300 tokens | Detailed: 400-500 tokens -->

### Common Issues and Solutions

**Issue 1: [Common Problem]**
- **Symptoms**: [What you see]
- **Cause**: [Why it happens]
- **Solution**: [How to fix]

**Issue 2: [Common Problem]**
- **Symptoms**: [What you see]
- **Cause**: [Why it happens]
- **Solution**: [How to fix]

### Debug Mode
```bash
# Verbose output
ansible-playbook playbook.yml -v  # or -vv, -vvv, -vvvv

# Step-by-step execution
ansible-playbook playbook.yml --step

# Start from specific task
ansible-playbook playbook.yml --start-at-task="task name"
```

### Logging
- **Ansible logs**: [Location and how to enable]
- **Task output**: [Where task results are stored]
- **Error logs**: [Where to find error details]

---

## References
<!-- All modes: 50-100 tokens -->

- **Ansible Module Documentation**: [Links to relevant modules]
- **Related Playbooks/Roles**: [Cross-references]
- **Upstream Documentation**: [Official docs]
- **Project Documentation**: [Project-specific docs]

---

## Maintenance Notes
<!-- Brief: skip | Standard: 50-100 tokens | Detailed: 100-150 tokens -->

**Version History**: [Link to CHANGELOG or version notes]
**Known Issues**: [Link to issue tracker or list known issues]
**Planned Improvements**: [Roadmap items]

**Contact**: [Maintainer or team contact information]

---

**Template Version**: 1.0.0
**Last Updated**: 2025-11-28
**Maintained By**: Agent Architecture Team

**Usage**: This template is loaded by agent-ansible-automation when creating Ansible playbook or role documentation. Agents populate sections based on specific user requests and output mode (Brief/Standard/Detailed).
