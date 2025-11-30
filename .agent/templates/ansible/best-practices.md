# Ansible Best Practices Reference

Load this template when implementing Ansible automation to ensure adherence to production standards.

---

## Task Implementation

- **Descriptive task names**: Use imperative form (e.g., "Install nginx package", "Configure firewall rules")
- **FQCN module names**: Always use fully qualified collection names (ansible.builtin.copy, community.general.docker_container)
- **Explicit state**: Always declare state (present/absent/started/stopped/enabled/disabled)
- **Idempotency checks**: Use creates/removes parameters, changed_when, failed_when for command/shell tasks
- **Tags for selective execution**: Tag tasks by function (install, configure, deploy) for targeted runs
- **Handlers for service restarts**: Use notify to trigger handlers, avoid direct service restarts in tasks

---

## Variable Management

- **Prefix role variables**: Use role name as prefix (nginx_port, not just port)
- **defaults/main.yml**: For overridable defaults that users can customize
- **vars/main.yml**: For internal role variables that shouldn't be modified
- **Vault pattern**: Use vault_variable_name for encrypted secrets (vault_db_password)
- **Document all variables**: Include type, description, and example values in README

---

## Security

- **Use Ansible Vault**: Encrypt all sensitive data (passwords, API keys, certificates)
- **Apply no_log**: Add no_log: true to tasks handling secrets to prevent logging
- **Set restrictive file permissions**: Use mode: '0600' for secrets, '0640' for configs, '0750' for directories
- **Use service accounts**: Run services with minimal privileges, dedicated service accounts
- **SSH keys over passwords**: Prefer SSH key authentication, disable password auth where possible

---

## Testing

- **Syntax validation**: Run ansible-playbook --syntax-check before execution
- **Linting**: Use ansible-lint and yamllint to catch common issues
- **Idempotency testing**: Run playbook twice, verify 0 changes on second run
- **Molecule testing**: Use molecule for comprehensive role testing across platforms
- **Platform-specific testing**: Test on target platforms (Ubuntu, CentOS, Debian, RHEL)

---

## Template Version

- **Version**: 1.0.0
- **Created**: 2025-11-28
- **Purpose**: Ansible best practices reference for production automation
- **Status**: Active

**Usage**: Load this template when implementing Ansible automation to apply production standards consistently.
