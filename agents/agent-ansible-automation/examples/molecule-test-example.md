# Example: Molecule Testing Framework

This example demonstrates a comprehensive Molecule testing framework for testing Ansible roles across multiple operating systems with complete validation.

## Overview

Molecule provides:
- Multi-platform testing (Ubuntu, CentOS, Debian)
- Docker-based test environments
- Automated linting and validation
- Integration testing
- CI/CD pipeline integration

## Prerequisites

```bash
# Install molecule and dependencies
pip install molecule molecule-docker ansible-lint yamllint

# Verify installation
molecule --version
```

## Project Structure

```
roles/webapp/
├── README.md
├── defaults/
│   └── main.yml
├── tasks/
│   └── main.yml
├── handlers/
│   └── main.yml
├── templates/
│   └── app.conf.j2
├── molecule/
│   ├── default/
│   │   ├── molecule.yml
│   │   ├── converge.yml
│   │   ├── verify.yml
│   │   ├── prepare.yml
│   │   └── side_effect.yml
│   ├── ubuntu/
│   │   └── molecule.yml
│   └── multi-platform/
│       ├── molecule.yml
│       └── converge.yml
├── .ansible-lint
└── .yamllint
```

## Molecule Configuration Files

### molecule/default/molecule.yml
```yaml
---
# Molecule configuration for default scenario
# This tests the role on Ubuntu 20.04

dependency:
  name: galaxy
  options:
    requirements-file: requirements.yml
    force: false

driver:
  name: docker

platforms:
  - name: ubuntu2004-webapp
    image: geerlingguy/docker-ubuntu2004-ansible:latest
    command: ""
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
    privileged: true
    pre_build_image: true
    networks:
      - name: molecule-network
    published_ports:
      - "8080:80"
    env:
      DEBIAN_FRONTEND: noninteractive

provisioner:
  name: ansible
  config_options:
    defaults:
      callbacks_enabled: profile_tasks
      stdout_callback: yaml
      verbosity: 1
    ssh_connection:
      pipelining: true
  inventory:
    host_vars:
      ubuntu2004-webapp:
        webapp_port: 80
        webapp_environment: test
  playbooks:
    prepare: prepare.yml
    converge: converge.yml
    verify: verify.yml
    side_effect: side_effect.yml
  lint: |
    set -e
    yamllint .
    ansible-lint .

verifier:
  name: ansible

scenario:
  name: default
  test_sequence:
    - dependency
    - lint
    - cleanup
    - destroy
    - syntax
    - create
    - prepare
    - converge
    - idempotence
    - side_effect
    - verify
    - cleanup
    - destroy
```

### molecule/multi-platform/molecule.yml
```yaml
---
# Multi-platform testing scenario
# Tests role across Ubuntu, Debian, and CentOS

dependency:
  name: galaxy

driver:
  name: docker

platforms:
  - name: ubuntu2004
    image: geerlingguy/docker-ubuntu2004-ansible:latest
    command: ""
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
    privileged: true
    pre_build_image: true
    groups:
      - debian_family

  - name: ubuntu2204
    image: geerlingguy/docker-ubuntu2204-ansible:latest
    command: ""
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
    privileged: true
    pre_build_image: true
    groups:
      - debian_family

  - name: debian11
    image: geerlingguy/docker-debian11-ansible:latest
    command: ""
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
    privileged: true
    pre_build_image: true
    groups:
      - debian_family

  - name: centos8
    image: geerlingguy/docker-centos8-ansible:latest
    command: ""
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
    privileged: true
    pre_build_image: true
    groups:
      - redhat_family

provisioner:
  name: ansible
  config_options:
    defaults:
      callbacks_enabled: profile_tasks
      host_key_checking: false
  inventory:
    group_vars:
      debian_family:
        webapp_package_name: apache2
      redhat_family:
        webapp_package_name: httpd

verifier:
  name: ansible

scenario:
  name: multi-platform
  test_sequence:
    - dependency
    - lint
    - destroy
    - syntax
    - create
    - prepare
    - converge
    - idempotence
    - verify
    - destroy
```

## Test Playbooks

### molecule/default/prepare.yml
```yaml
---
# Preparation tasks run before converge
# Use this to set up test prerequisites

- name: Prepare test environment
  hosts: all
  gather_facts: true
  become: true

  tasks:
    - name: Update apt cache (Debian family)
      ansible.builtin.apt:
        update_cache: true
        cache_valid_time: 3600
      when: ansible_os_family == 'Debian'
      changed_when: false

    - name: Update yum cache (RedHat family)
      ansible.builtin.yum:
        update_cache: true
      when: ansible_os_family == 'RedHat'
      changed_when: false

    - name: Install test dependencies
      ansible.builtin.package:
        name:
          - curl
          - net-tools
        state: present

    - name: Create test user
      ansible.builtin.user:
        name: testuser
        state: present
        create_home: true

    - name: Ensure test directories exist
      ansible.builtin.file:
        path: "{{ item }}"
        state: directory
        mode: '0755'
      loop:
        - /opt/test
        - /var/log/test
```

### molecule/default/converge.yml
```yaml
---
# Main test playbook - applies the role

- name: Converge
  hosts: all
  become: true

  pre_tasks:
    - name: Display test environment info
      ansible.builtin.debug:
        msg:
          - "Testing on: {{ ansible_distribution }} {{ ansible_distribution_version }}"
          - "Platform: {{ inventory_hostname }}"
          - "Environment: {{ webapp_environment }}"

  roles:
    - role: webapp
      webapp_server_name: test.example.com
      webapp_enable_ssl: false
      webapp_custom_config: true

  post_tasks:
    - name: Wait for webapp to be ready
      ansible.builtin.wait_for:
        port: "{{ webapp_port }}"
        timeout: 60
        delay: 5

    - name: Verify webapp is responding
      ansible.builtin.uri:
        url: "http://localhost:{{ webapp_port }}"
        status_code: 200
      register: webapp_check
      retries: 3
      delay: 5
      until: webapp_check.status == 200
```

### molecule/default/verify.yml
```yaml
---
# Verification tasks - validate the role worked correctly

- name: Verify webapp role
  hosts: all
  gather_facts: true
  become: true

  tasks:
    - name: Gather package facts
      ansible.builtin.package_facts:
        manager: auto

    - name: Verify required packages are installed
      ansible.builtin.assert:
        that:
          - "'apache2' in ansible_facts.packages or 'httpd' in ansible_facts.packages"
        fail_msg: "Web server package is not installed"
        success_msg: "Web server package is installed"

    - name: Gather service facts
      ansible.builtin.service_facts:

    - name: Verify web server service is running
      ansible.builtin.assert:
        that:
          - >
            (ansible_facts.services['apache2.service'] is defined and
             ansible_facts.services['apache2.service'].state == 'running') or
            (ansible_facts.services['httpd.service'] is defined and
             ansible_facts.services['httpd.service'].state == 'running')
        fail_msg: "Web server service is not running"
        success_msg: "Web server service is running"

    - name: Check configuration files exist
      ansible.builtin.stat:
        path: "{{ item }}"
      register: config_files
      loop:
        - /etc/webapp/webapp.conf
        - /var/log/webapp
      failed_when: not config_files.results | map(attribute='stat.exists') | list | min

    - name: Verify configuration file permissions
      ansible.builtin.stat:
        path: /etc/webapp/webapp.conf
      register: config_stat

    - name: Assert correct permissions on config
      ansible.builtin.assert:
        that:
          - config_stat.stat.mode == '0644'
          - config_stat.stat.pw_name == 'root'
        fail_msg: "Configuration file has incorrect permissions"

    - name: Test HTTP endpoint
      ansible.builtin.uri:
        url: "http://localhost:{{ webapp_port }}"
        return_content: true
        status_code: 200
      register: http_response

    - name: Verify HTTP response content
      ansible.builtin.assert:
        that:
          - "'Welcome' in http_response.content"
        fail_msg: "HTTP response does not contain expected content"

    - name: Check log files are being created
      ansible.builtin.stat:
        path: /var/log/webapp/access.log
      register: access_log

    - name: Verify log file exists and has content
      ansible.builtin.assert:
        that:
          - access_log.stat.exists
          - access_log.stat.size > 0
        fail_msg: "Log file doesn't exist or is empty"

    - name: Test idempotency marker
      ansible.builtin.stat:
        path: /var/lib/webapp/.installed
      register: idempotency_marker

    - name: Verify idempotency marker exists
      ansible.builtin.assert:
        that:
          - idempotency_marker.stat.exists
        fail_msg: "Idempotency marker not created"

    - name: Verify webapp user exists
      ansible.builtin.user:
        name: webapp
        state: present
      check_mode: true
      register: user_check
      failed_when: user_check.changed

    - name: Check webapp is in correct groups
      ansible.builtin.command: groups webapp
      register: user_groups
      changed_when: false

    - name: Verify user group membership
      ansible.builtin.assert:
        that:
          - "'www-data' in user_groups.stdout or 'apache' in user_groups.stdout"
        fail_msg: "User is not in correct groups"

    - name: Final validation summary
      ansible.builtin.debug:
        msg:
          - "========================================="
          - "All verification checks passed!"
          - "Platform: {{ ansible_distribution }}"
          - "Web server: {{ 'Apache' if 'apache2' in ansible_facts.packages else 'httpd' }}"
          - "Service status: Running"
          - "HTTP response: OK"
          - "========================================="
```

### molecule/default/side_effect.yml
```yaml
---
# Side effect tests - simulate failures or edge cases

- name: Test failure scenarios
  hosts: all
  become: true
  gather_facts: false

  tasks:
    - name: Simulate service restart
      ansible.builtin.systemd:
        name: "{{ 'apache2' if ansible_os_family == 'Debian' else 'httpd' }}"
        state: restarted

    - name: Wait for service to recover
      ansible.builtin.wait_for:
        port: 80
        timeout: 30

    - name: Verify service recovered correctly
      ansible.builtin.uri:
        url: http://localhost:80
        status_code: 200
```

## Linting Configuration

### .ansible-lint
```yaml
---
# Ansible-lint configuration

# Exclude specific paths
exclude_paths:
  - .cache/
  - .github/
  - molecule/
  - venv/

# Skip specific rules
skip_list:
  - yaml[line-length]  # Allow longer lines in specific cases
  - meta-no-info       # Only if you have a reason

# Warn on these rules instead of failing
warn_list:
  - experimental
  - role-name

# Enable offline mode (don't check galaxy)
offline: false

# Use specific Ansible version for linting
# ansible_version: "2.12"

# Enable all rules by default
use_default_rules: true

# Custom rules directory
# rulesdir:
#   - ./custom-rules/
```

### .yamllint
```yaml
---
# YAML lint configuration

extends: default

rules:
  line-length:
    max: 200
    level: warning

  indentation:
    spaces: 2
    indent-sequences: true

  trailing-spaces: enable

  truthy:
    allowed-values: ['true', 'false', 'yes', 'no']
    check-keys: false

  comments:
    min-spaces-from-content: 1

  comments-indentation: enable

  braces:
    max-spaces-inside: 1

  brackets:
    max-spaces-inside: 1

  empty-lines:
    max: 2

ignore: |
  .cache/
  .github/
  venv/
  molecule/*/
```

## CI/CD Integration

### .github/workflows/molecule.yml
```yaml
---
name: Molecule Test

on:
  push:
    branches:
      - main
      - develop
  pull_request:
    branches:
      - main

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.10'

      - name: Install dependencies
        run: |
          pip install ansible ansible-lint yamllint

      - name: Run ansible-lint
        run: ansible-lint .

      - name: Run yamllint
        run: yamllint .

  test:
    runs-on: ubuntu-latest
    needs: lint
    strategy:
      matrix:
        scenario:
          - default
          - multi-platform
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.10'

      - name: Install dependencies
        run: |
          pip install molecule molecule-docker ansible-lint yamllint docker

      - name: Run Molecule test
        run: molecule test -s ${{ matrix.scenario }}
        env:
          PY_COLORS: '1'
          ANSIBLE_FORCE_COLOR: '1'

      - name: Upload test results
        if: always()
        uses: actions/upload-artifact@v3
        with:
          name: molecule-test-results-${{ matrix.scenario }}
          path: |
            molecule/*/molecule.log
            molecule/*/pytest.log
```

### .gitlab-ci.yml
```yaml
---
# GitLab CI configuration for Molecule

image: python:3.10

stages:
  - lint
  - test

variables:
  PIP_CACHE_DIR: "$CI_PROJECT_DIR/.cache/pip"
  DOCKER_DRIVER: overlay2

cache:
  paths:
    - .cache/pip

before_script:
  - pip install molecule molecule-docker ansible-lint yamllint docker

lint:yaml:
  stage: lint
  script:
    - yamllint .

lint:ansible:
  stage: lint
  script:
    - ansible-lint .

test:default:
  stage: test
  services:
    - docker:dind
  script:
    - molecule test -s default
  artifacts:
    when: always
    paths:
      - molecule/default/molecule.log
    expire_in: 1 week

test:multi-platform:
  stage: test
  services:
    - docker:dind
  script:
    - molecule test -s multi-platform
  artifacts:
    when: always
    paths:
      - molecule/multi-platform/molecule.log
    expire_in: 1 week
  only:
    - main
    - develop
```

## Usage

### Run Default Test Scenario
```bash
cd roles/webapp
molecule test
```

### Run Specific Scenario
```bash
molecule test -s multi-platform
```

### Development Workflow
```bash
# Create test instances
molecule create

# Apply role
molecule converge

# Run verification tests
molecule verify

# Login to test instance for debugging
molecule login

# Destroy test instances
molecule destroy
```

### Test Idempotency
```bash
molecule idempotence
```

### Run Only Linting
```bash
molecule lint
```

### Debug Mode
```bash
molecule --debug test
```

## Key Features Demonstrated

1. **Multi-Platform Testing**: Ubuntu, Debian, CentOS coverage
2. **Complete Test Lifecycle**: prepare → converge → verify → cleanup
3. **Idempotency Testing**: Ensures tasks can be safely re-run
4. **Comprehensive Verification**: Package, service, file, HTTP checks
5. **Linting Integration**: ansible-lint and yamllint
6. **CI/CD Examples**: GitHub Actions and GitLab CI
7. **Side Effect Testing**: Failure scenario simulation
8. **Docker Driver**: Fast, isolated test environments
9. **Custom Scenarios**: Default and multi-platform scenarios
10. **Group Variables**: OS-family specific configuration

## Troubleshooting

### Common Issues

**Issue**: Docker permission denied
```bash
# Solution: Add user to docker group
sudo usermod -aG docker $USER
newgrp docker
```

**Issue**: Platform image not found
```bash
# Solution: Pull image manually
docker pull geerlingguy/docker-ubuntu2004-ansible
```

**Issue**: Converge fails on systemd
```bash
# Solution: Ensure privileged mode and cgroup volume are configured
# in molecule.yml
```

**Issue**: Verification timeout
```bash
# Solution: Increase wait_for timeout in verify.yml
# or check service logs with molecule login
```

## Best Practices

1. **Test on target platforms**: Match production OS distributions
2. **Verify idempotency**: Always include idempotence test
3. **Check permissions**: Validate file/directory permissions
4. **Test services**: Verify services are running and responding
5. **Validate content**: Check configuration file content, not just existence
6. **Clean up**: Always destroy test instances when done
7. **Use CI/CD**: Automate testing on every commit
8. **Version pins**: Pin Ansible and Python versions for consistency
9. **Test failures**: Include side_effect.yml to test failure scenarios
10. **Document scenarios**: Clearly document what each scenario tests

---

This comprehensive Molecule framework ensures your Ansible roles are production-ready, tested across multiple platforms, and validated for idempotency.
