# Ansible Code Quality Checklist

This checklist ensures all Ansible code meets quality standards before delivery.

## Before Delivering Ansible Code, Verify:

### Structure and Organization
- [ ] Proper role directory structure (tasks/, handlers/, templates/, files/, vars/, defaults/, meta/)
- [ ] Clear, descriptive file and directory names
- [ ] Logical task organization (main.yml includes other task files)
- [ ] Handlers grouped in handlers/main.yml
- [ ] Variables organized by precedence (defaults/ vs vars/)

### Task Quality
- [ ] All tasks have descriptive names (imperative form)
- [ ] Module names use FQCN (ansible.builtin.copy, not just "copy")
- [ ] State is explicit (present/absent/started/stopped)
- [ ] No shell/command modules when better alternatives exist
- [ ] changed_when and failed_when defined for command/shell tasks
- [ ] Tags applied appropriately for selective execution
- [ ] Handlers used instead of tasks with changed_when: false

### Idempotency
- [ ] All tasks are idempotent (can run multiple times safely)
- [ ] Command tasks use creates/removes parameters
- [ ] No tasks make unnecessary changes on each run
- [ ] Test: Second run reports 0 changes
- [ ] State-based modules preferred over command-based

### Variable Management
- [ ] All variables documented in README
- [ ] Descriptive variable names (snake_case)
- [ ] Variables prefixed with role name
- [ ] Defaults provided in defaults/main.yml
- [ ] Sensitive variables use vault_* pattern
- [ ] No hardcoded values in tasks

### YAML Syntax
- [ ] Correct YAML syntax (2-space indentation)
- [ ] No tabs (spaces only)
- [ ] Consistent formatting throughout
- [ ] Passes yamllint validation
- [ ] Lists and dictionaries properly structured

### Ansible Best Practices
- [ ] No deprecated modules without warnings
- [ ] Module parameters are accurate
- [ ] become used only when necessary
- [ ] gather_facts: false when not needed
- [ ] Proper error handling (block/rescue/always)
- [ ] Passes ansible-lint validation

### Security
- [ ] No hardcoded credentials or secrets
- [ ] Sensitive data in Ansible Vault
- [ ] no_log applied to tasks with secrets
- [ ] File permissions set appropriately
- [ ] Least privilege principle followed
- [ ] SSH keys preferred over passwords

### Testing
- [ ] Syntax check passes (ansible-playbook --syntax-check)
- [ ] Lint checks pass (ansible-lint, yamllint)
- [ ] Dry run tested (ansible-playbook --check)
- [ ] Idempotence validated (run twice, 0 changes)
- [ ] Tested on target platforms
- [ ] Molecule tests defined (if role)

### Documentation
- [ ] README.md complete and accurate
- [ ] All variables documented with types
- [ ] Usage examples provided
- [ ] Requirements listed (Ansible version, collections)
- [ ] Dependencies documented
- [ ] Supported platforms listed

### Error Handling
- [ ] Critical tasks wrapped in block/rescue/always
- [ ] Validation checks before destructive operations
- [ ] Meaningful error messages
- [ ] Failed tasks have appropriate failed_when
- [ ] Rollback procedures documented

### Performance
- [ ] No unnecessary fact gathering
- [ ] Efficient use of loops (loop vs with_items)
- [ ] Delegation used where appropriate
- [ ] No overly complex or nested conditionals
- [ ] Serial execution configured for large inventories

---

## Quality Score Self-Assessment

Rate each category (1-5):
- **Structure**: Proper organization? ___/5
- **Idempotency**: Safe re-execution? ___/5
- **Syntax**: YAML and Ansible correctness? ___/5
- **Security**: Secrets managed properly? ___/5
- **Testing**: Comprehensive validation? ___/5
- **Documentation**: Complete and clear? ___/5

**Total Score**: ___/30

**Minimum Acceptable**: 24/30 (80%)

---

## Common Issues to Avoid

❌ **Don't**:
- Use shell/command when module exists
- Skip idempotency checks
- Hardcode credentials
- Ignore lint warnings
- Forget to test on target platforms
- Use deprecated modules
- Skip documentation
- Leave TODO markers
- Use generic variable names
- Forget to tag tasks

✅ **Do**:
- Use descriptive task names
- Implement proper error handling
- Apply security best practices
- Test idempotency
- Document all variables
- Use FQCN for modules
- Follow YAML formatting standards
- Validate before committing
- Version control everything
- Keep it DRY (Don't Repeat Yourself)

---

## Pre-Delivery Final Check

Before sending code to user:
1. Run syntax check: `ansible-playbook --syntax-check`
2. Run linters: `ansible-lint .` and `yamllint .`
3. Test in check mode: `ansible-playbook --check`
4. Verify idempotence: Run twice, check for changes
5. Review documentation completeness
6. Check security (no exposed secrets)
7. Validate examples work as documented

---

## Module Accuracy Verification

- [ ] No fabricated module parameters
- [ ] Module names are correct (check ansible-doc [module])
- [ ] Parameters match module documentation
- [ ] Return values used correctly
- [ ] Collection namespaces correct (ansible.builtin.*, community.general.*)
- [ ] Module version compatibility noted if relevant
- [ ] Deprecated features flagged with warnings

---

## Platform Compatibility

- [ ] Tested on target OS (Ubuntu, CentOS, Debian, etc.)
- [ ] OS-specific variables defined where needed
- [ ] Package names correct for each platform
- [ ] Paths adjusted for OS differences
- [ ] Service names correct per platform

---

**Template Version**: 1.0.0
**Last Updated**: 2025-11-28
**Maintained By**: Agent Architecture Team

**Usage**: Agent loads this checklist before delivering Ansible code to perform final quality validation.
