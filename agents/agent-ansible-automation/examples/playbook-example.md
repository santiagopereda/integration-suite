# Example: Complete Application Deployment Playbook

This example demonstrates a production-ready Ansible playbook for deploying a multi-tier application with best practices, error handling, and comprehensive variable management.

## Scenario

Deploy a Python Flask application with:
- Nginx reverse proxy
- Gunicorn application server
- PostgreSQL database
- SSL certificates
- Systemd service management
- Health checks and validation

## Directory Structure

```
flask-app-deployment/
├── ansible.cfg
├── inventory/
│   ├── production/
│   │   ├── hosts.yml
│   │   └── group_vars/
│   │       ├── all.yml
│   │       ├── webservers.yml
│   │       ├── appservers.yml
│   │       └── databases.yml
│   └── staging/
│       ├── hosts.yml
│       └── group_vars/
│           └── all.yml
├── playbooks/
│   ├── deploy.yml
│   ├── rollback.yml
│   └── health_check.yml
├── roles/
│   ├── common/
│   ├── nginx/
│   ├── flask_app/
│   └── postgresql/
└── vars/
    └── vault.yml (encrypted)
```

## Configuration Files

### ansible.cfg
```ini
[defaults]
inventory = inventory/production/hosts.yml
remote_user = deploy
host_key_checking = False
retry_files_enabled = False
callbacks_enabled = profile_tasks
stdout_callback = yaml
interpreter_python = auto_silent

# Performance optimization
gathering = smart
fact_caching = jsonfile
fact_caching_connection = /tmp/ansible_facts
fact_caching_timeout = 3600
forks = 10
pipelining = True

# Logging
log_path = ./ansible.log

[privilege_escalation]
become = True
become_method = sudo
become_user = root
become_ask_pass = False

[ssh_connection]
ssh_args = -o ControlMaster=auto -o ControlPersist=60s
control_path = /tmp/ansible-%%r@%%h:%%p
```

### inventory/production/hosts.yml
```yaml
---
all:
  children:
    webservers:
      hosts:
        web1.example.com:
          ansible_host: 192.168.1.10
        web2.example.com:
          ansible_host: 192.168.1.11

    appservers:
      hosts:
        app1.example.com:
          ansible_host: 192.168.1.20
          gunicorn_workers: 4
        app2.example.com:
          ansible_host: 192.168.1.21
          gunicorn_workers: 4
        app3.example.com:
          ansible_host: 192.168.1.22
          gunicorn_workers: 2

    databases:
      hosts:
        db1.example.com:
          ansible_host: 192.168.1.30
          postgresql_role: primary
        db2.example.com:
          ansible_host: 192.168.1.31
          postgresql_role: replica

  vars:
    ansible_user: deploy
    ansible_python_interpreter: /usr/bin/python3
```

### inventory/production/group_vars/all.yml
```yaml
---
# Global variables for all hosts

# Environment
environment_name: production
deployment_user: deploy
app_base_dir: /opt/apps

# Application details
app_name: flask_app
app_version: "1.2.0"
app_repo_url: https://github.com/example/flask-app.git
app_branch: main

# Python configuration
python_version: "3.10"
virtualenv_path: "{{ app_base_dir }}/{{ app_name }}/venv"

# Logging
log_base_dir: /var/log
app_log_dir: "{{ log_base_dir }}/{{ app_name }}"
log_level: INFO

# Feature flags
enable_ssl: true
enable_monitoring: true
enable_backup: true

# Security
ssl_cert_path: /etc/ssl/certs/{{ app_name }}.crt
ssl_key_path: /etc/ssl/private/{{ app_name }}.key
```

### inventory/production/group_vars/appservers.yml
```yaml
---
# Application server specific variables

# Gunicorn configuration
gunicorn_bind: "127.0.0.1:8000"
gunicorn_workers: 3
gunicorn_worker_class: sync
gunicorn_timeout: 30
gunicorn_max_requests: 1000

# Application configuration
app_config_file: "{{ app_base_dir }}/{{ app_name }}/config/production.py"
app_secret_key: "{{ vault_app_secret_key }}"

# Database connection
database_host: "{{ hostvars[groups['databases'][0]]['ansible_host'] }}"
database_port: 5432
database_name: "{{ app_name }}_prod"
database_user: "{{ app_name }}_user"
database_password: "{{ vault_database_password }}"
```

### inventory/production/group_vars/webservers.yml
```yaml
---
# Web server specific variables

# Nginx configuration
nginx_server_name: www.example.com
nginx_listen_port: 80
nginx_listen_ssl_port: 443
nginx_client_max_body_size: 64M

# Upstream configuration
nginx_upstream_servers: "{{ groups['appservers'] | map('extract', hostvars, 'ansible_host') | list }}"
nginx_upstream_port: 8000

# SSL configuration
nginx_ssl_protocols: TLSv1.2 TLSv1.3
nginx_ssl_ciphers: HIGH:!aNULL:!MD5
```

## Main Deployment Playbook

### playbooks/deploy.yml
```yaml
---
- name: Deploy Flask Application - Pre-flight Checks
  hosts: all
  gather_facts: true
  tags:
    - always

  tasks:
    - name: Verify Ansible version
      ansible.builtin.assert:
        that:
          - ansible_version.full is version('2.9', '>=')
        fail_msg: "Ansible version must be 2.9 or higher"
        success_msg: "Ansible version {{ ansible_version.full }} is supported"

    - name: Check Python version on target
      ansible.builtin.assert:
        that:
          - ansible_python_version is version('3.6', '>=')
        fail_msg: "Python 3.6+ is required on target hosts"

    - name: Verify connectivity to all hosts
      ansible.builtin.ping:

    - name: Display deployment information
      ansible.builtin.debug:
        msg:
          - "Environment: {{ environment_name }}"
          - "Application: {{ app_name }} v{{ app_version }}"
          - "Branch: {{ app_branch }}"
          - "Deploying to {{ inventory_hostname }}"


- name: Deploy Database Tier
  hosts: databases
  become: true
  serial: 1
  tags:
    - database

  pre_tasks:
    - name: Check if database is already running
      ansible.builtin.service_facts:

    - name: Create backup if database exists
      block:
        - name: Create database backup directory
          ansible.builtin.file:
            path: /var/backups/postgresql
            state: directory
            owner: postgres
            group: postgres
            mode: '0700'

        - name: Backup existing database
          community.postgresql.postgresql_db:
            name: "{{ database_name }}"
            state: dump
            target: "/var/backups/postgresql/{{ database_name }}_{{ ansible_date_time.iso8601_basic_short }}.sql"
          become_user: postgres
          when:
            - "'postgresql.service' in ansible_facts.services"
            - ansible_facts.services['postgresql.service'].state == 'running'

      rescue:
        - name: Log backup failure
          ansible.builtin.debug:
            msg: "Database backup failed, but continuing deployment"

  roles:
    - role: postgresql

  post_tasks:
    - name: Wait for PostgreSQL to be ready
      ansible.builtin.wait_for:
        port: 5432
        host: "{{ ansible_host }}"
        timeout: 60
        delay: 5

    - name: Verify database connectivity
      community.postgresql.postgresql_ping:
        db: "{{ database_name }}"
        login_host: localhost
        login_user: "{{ database_user }}"
        login_password: "{{ database_password }}"
      become_user: postgres


- name: Deploy Application Tier
  hosts: appservers
  become: true
  serial: "30%"
  tags:
    - application

  pre_tasks:
    - name: Check disk space
      ansible.builtin.assert:
        that:
          - item.size_available > 1073741824  # 1GB in bytes
        fail_msg: "Insufficient disk space on {{ item.mount }}"
      loop: "{{ ansible_mounts }}"
      when: item.mount == '/'

  roles:
    - role: common
    - role: flask_app

  tasks:
    - name: Deploy application code
      block:
        - name: Clone application repository
          ansible.builtin.git:
            repo: "{{ app_repo_url }}"
            dest: "{{ app_base_dir }}/{{ app_name }}/src"
            version: "{{ app_branch }}"
            force: true
          register: git_clone
          notify: Restart application

        - name: Install Python dependencies
          ansible.builtin.pip:
            requirements: "{{ app_base_dir }}/{{ app_name }}/src/requirements.txt"
            virtualenv: "{{ virtualenv_path }}"
            virtualenv_python: "python{{ python_version }}"
          when: git_clone.changed
          notify: Restart application

        - name: Deploy application configuration
          ansible.builtin.template:
            src: app_config.py.j2
            dest: "{{ app_config_file }}"
            owner: "{{ deployment_user }}"
            group: "{{ deployment_user }}"
            mode: '0640'
          no_log: true
          notify: Restart application

        - name: Run database migrations
          ansible.builtin.command:
            cmd: "{{ virtualenv_path }}/bin/flask db upgrade"
            chdir: "{{ app_base_dir }}/{{ app_name }}/src"
          environment:
            FLASK_APP: app.py
            FLASK_ENV: production
          register: migration_result
          changed_when: "'Running upgrade' in migration_result.stdout"
          run_once: true

        - name: Deploy systemd service file
          ansible.builtin.template:
            src: gunicorn.service.j2
            dest: "/etc/systemd/system/{{ app_name }}.service"
            owner: root
            group: root
            mode: '0644'
          notify: Restart application

        - name: Enable and start application service
          ansible.builtin.systemd:
            name: "{{ app_name }}"
            enabled: true
            state: started
            daemon_reload: true

      rescue:
        - name: Application deployment failed
          ansible.builtin.fail:
            msg: "Application deployment failed on {{ inventory_hostname }}"

      always:
        - name: Log deployment status
          ansible.builtin.debug:
            msg: "Deployment {{ 'succeeded' if git_clone is succeeded else 'failed' }} on {{ inventory_hostname }}"

  post_tasks:
    - name: Wait for application to be ready
      ansible.builtin.wait_for:
        port: 8000
        host: 127.0.0.1
        timeout: 60
        delay: 5

    - name: Health check application endpoint
      ansible.builtin.uri:
        url: "http://127.0.0.1:8000/health"
        status_code: 200
        timeout: 10
      register: health_check
      retries: 5
      delay: 3
      until: health_check.status == 200

  handlers:
    - name: Restart application
      ansible.builtin.systemd:
        name: "{{ app_name }}"
        state: restarted


- name: Deploy Web Tier
  hosts: webservers
  become: true
  serial: 1
  tags:
    - webserver

  roles:
    - role: common
    - role: nginx

  tasks:
    - name: Deploy Nginx configuration
      ansible.builtin.template:
        src: nginx_vhost.conf.j2
        dest: "/etc/nginx/sites-available/{{ app_name }}"
        owner: root
        group: root
        mode: '0644'
        validate: 'nginx -t -c /dev/stdin < %s'
      notify: Reload nginx

    - name: Enable Nginx site
      ansible.builtin.file:
        src: "/etc/nginx/sites-available/{{ app_name }}"
        dest: "/etc/nginx/sites-enabled/{{ app_name }}"
        state: link
      notify: Reload nginx

    - name: Ensure Nginx is started
      ansible.builtin.service:
        name: nginx
        state: started
        enabled: true

  post_tasks:
    - name: Wait for Nginx to be ready
      ansible.builtin.wait_for:
        port: 80
        timeout: 30

    - name: Verify Nginx is serving the application
      ansible.builtin.uri:
        url: "http://{{ ansible_host }}/health"
        status_code: 200
        follow_redirects: all
      register: nginx_health
      retries: 3
      delay: 5
      until: nginx_health.status == 200

  handlers:
    - name: Reload nginx
      ansible.builtin.service:
        name: nginx
        state: reloaded


- name: Post-deployment Validation
  hosts: webservers[0]
  gather_facts: false
  tags:
    - validation

  tasks:
    - name: Final end-to-end health check
      ansible.builtin.uri:
        url: "https://{{ nginx_server_name }}/health"
        validate_certs: true
        status_code: 200
        return_content: true
      register: final_health_check
      when: enable_ssl

    - name: Display deployment summary
      ansible.builtin.debug:
        msg:
          - "============================================"
          - "Deployment completed successfully!"
          - "Application: {{ app_name }} v{{ app_version }}"
          - "Environment: {{ environment_name }}"
          - "URL: https://{{ nginx_server_name }}"
          - "Health Status: {{ final_health_check.json.status | default('OK') }}"
          - "============================================"

    - name: Send deployment notification
      ansible.builtin.uri:
        url: "https://slack.example.com/webhook"
        method: POST
        body_format: json
        body:
          text: "Deployment of {{ app_name }} v{{ app_version }} to {{ environment_name }} completed successfully"
      when: enable_monitoring
      ignore_errors: true
```

## Supporting Playbooks

### playbooks/health_check.yml
```yaml
---
- name: Application Health Check
  hosts: appservers
  gather_facts: false

  tasks:
    - name: Check application service status
      ansible.builtin.service_facts:

    - name: Verify service is running
      ansible.builtin.assert:
        that:
          - "ansible_facts.services['{{ app_name }}.service'].state == 'running'"
        fail_msg: "Application service is not running on {{ inventory_hostname }}"

    - name: Check application endpoint
      ansible.builtin.uri:
        url: "http://127.0.0.1:8000/health"
        status_code: 200
      register: app_health

    - name: Display health status
      ansible.builtin.debug:
        msg: "Application health: {{ app_health.json }}"
```

### playbooks/rollback.yml
```yaml
---
- name: Rollback Application Deployment
  hosts: appservers
  become: true
  serial: "30%"

  vars_prompt:
    - name: rollback_version
      prompt: "Enter the version to rollback to"
      private: false

    - name: confirm_rollback
      prompt: "Are you sure you want to rollback to {{ rollback_version }}? (yes/no)"
      private: false

  pre_tasks:
    - name: Confirm rollback
      ansible.builtin.fail:
        msg: "Rollback cancelled"
      when: confirm_rollback != 'yes'

  tasks:
    - name: Rollback to previous version
      ansible.builtin.git:
        repo: "{{ app_repo_url }}"
        dest: "{{ app_base_dir }}/{{ app_name }}/src"
        version: "{{ rollback_version }}"
        force: true
      notify: Restart application

    - name: Restart application
      ansible.builtin.systemd:
        name: "{{ app_name }}"
        state: restarted

  handlers:
    - name: Restart application
      ansible.builtin.systemd:
        name: "{{ app_name }}"
        state: restarted
```

## Key Features Demonstrated

1. **Multi-tier Orchestration**: Database → Application → Web tier deployment
2. **Serial Execution**: Controlled rollout with `serial` directive
3. **Pre-flight Checks**: Version verification, connectivity tests
4. **Error Handling**: block/rescue/always for graceful failure handling
5. **Health Checks**: Comprehensive validation at each tier
6. **Idempotency**: Safe to re-run multiple times
7. **Variable Management**: Hierarchical organization across inventory
8. **Security**: Vault for secrets, no_log for sensitive data
9. **Performance**: Fact caching, pipelining in ansible.cfg
10. **Validation**: nginx -t for config validation, database backups
11. **Tags**: Selective execution of specific tiers
12. **Notifications**: Slack webhook integration example
13. **Rolling Updates**: Percentage-based serial deployment

## Usage

### Deploy to Production
```bash
ansible-playbook playbooks/deploy.yml
```

### Deploy Specific Tier
```bash
ansible-playbook playbooks/deploy.yml --tags application
```

### Health Check
```bash
ansible-playbook playbooks/health_check.yml
```

### Rollback
```bash
ansible-playbook playbooks/rollback.yml
```

### Dry Run
```bash
ansible-playbook playbooks/deploy.yml --check --diff
```

## Testing

### Syntax Check
```bash
ansible-playbook playbooks/deploy.yml --syntax-check
```

### Linting
```bash
ansible-lint playbooks/
yamllint playbooks/
```

### Inventory Verification
```bash
ansible-inventory -i inventory/production/hosts.yml --list
```

## Notes

- Always test in staging environment first
- Review `--check` output before production deployment
- Keep vault password secure (use ansible-vault)
- Monitor deployment logs for issues
- Have rollback plan ready before deployment
