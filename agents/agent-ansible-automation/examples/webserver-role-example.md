# Example: Complete Nginx Web Server Role

This example demonstrates a production-ready Ansible role for deploying and configuring Nginx web server with SSL support, custom configuration, and proper testing.

## Role Structure

```
roles/nginx_webserver/
├── README.md
├── defaults/
│   └── main.yml
├── files/
│   └── index.html
├── handlers/
│   └── main.yml
├── meta/
│   └── main.yml
├── tasks/
│   └── main.yml
├── templates/
│   ├── nginx.conf.j2
│   └── vhost.conf.j2
├── vars/
│   └── main.yml
└── molecule/
    └── default/
        ├── converge.yml
        ├── molecule.yml
        └── verify.yml
```

## File Contents

### defaults/main.yml
```yaml
---
# Nginx Web Server Role - Default Variables

# Package configuration
nginx_package_name: nginx
nginx_service_name: nginx

# Paths
nginx_config_dir: /etc/nginx
nginx_vhost_dir: "{{ nginx_config_dir }}/sites-available"
nginx_vhost_enabled_dir: "{{ nginx_config_dir }}/sites-enabled"
nginx_log_dir: /var/log/nginx
nginx_web_root: /var/www/html

# Service configuration
nginx_service_enabled: true
nginx_service_state: started

# Server configuration
nginx_server_name: localhost
nginx_listen_port: 80
nginx_listen_ssl_port: 443

# SSL configuration
nginx_enable_ssl: false
nginx_ssl_cert_path: ""
nginx_ssl_key_path: ""

# Worker configuration
nginx_worker_processes: auto
nginx_worker_connections: 1024

# Logging
nginx_access_log: "{{ nginx_log_dir }}/access.log"
nginx_error_log: "{{ nginx_log_dir }}/error.log"

# Performance tuning
nginx_keepalive_timeout: 65
nginx_client_max_body_size: 64M

# Default site configuration
nginx_default_site_enabled: true
nginx_custom_index_page: false
```

### tasks/main.yml
```yaml
---
# Nginx Web Server Role - Main Tasks

- name: Include OS-specific variables
  ansible.builtin.include_vars: "{{ ansible_os_family }}.yml"
  when: ansible_os_family in ['Debian', 'RedHat']
  tags:
    - nginx
    - configuration

- name: Install Nginx package
  ansible.builtin.package:
    name: "{{ nginx_package_name }}"
    state: present
  tags:
    - nginx
    - installation

- name: Ensure Nginx configuration directory exists
  ansible.builtin.file:
    path: "{{ nginx_config_dir }}"
    state: directory
    owner: root
    group: root
    mode: '0755'
  tags:
    - nginx
    - configuration

- name: Ensure vhost directories exist
  ansible.builtin.file:
    path: "{{ item }}"
    state: directory
    owner: root
    group: root
    mode: '0755'
  loop:
    - "{{ nginx_vhost_dir }}"
    - "{{ nginx_vhost_enabled_dir }}"
  tags:
    - nginx
    - configuration

- name: Deploy main Nginx configuration
  ansible.builtin.template:
    src: nginx.conf.j2
    dest: "{{ nginx_config_dir }}/nginx.conf"
    owner: root
    group: root
    mode: '0644'
    validate: 'nginx -t -c %s'
  notify: Reload Nginx
  tags:
    - nginx
    - configuration

- name: Deploy default vhost configuration
  ansible.builtin.template:
    src: vhost.conf.j2
    dest: "{{ nginx_vhost_dir }}/default"
    owner: root
    group: root
    mode: '0644'
  notify: Reload Nginx
  when: nginx_default_site_enabled
  tags:
    - nginx
    - configuration
    - vhost

- name: Enable default vhost
  ansible.builtin.file:
    src: "{{ nginx_vhost_dir }}/default"
    dest: "{{ nginx_vhost_enabled_dir }}/default"
    state: link
  notify: Reload Nginx
  when: nginx_default_site_enabled
  tags:
    - nginx
    - configuration
    - vhost

- name: Ensure web root directory exists
  ansible.builtin.file:
    path: "{{ nginx_web_root }}"
    state: directory
    owner: www-data
    group: www-data
    mode: '0755'
  tags:
    - nginx
    - webroot

- name: Deploy custom index page
  ansible.builtin.copy:
    src: index.html
    dest: "{{ nginx_web_root }}/index.html"
    owner: www-data
    group: www-data
    mode: '0644'
  when: nginx_custom_index_page
  tags:
    - nginx
    - webroot

- name: Validate SSL configuration
  block:
    - name: Check SSL certificate exists
      ansible.builtin.stat:
        path: "{{ nginx_ssl_cert_path }}"
      register: ssl_cert_check
      failed_when: not ssl_cert_check.stat.exists

    - name: Check SSL key exists
      ansible.builtin.stat:
        path: "{{ nginx_ssl_key_path }}"
      register: ssl_key_check
      failed_when: not ssl_key_check.stat.exists

  when: nginx_enable_ssl
  tags:
    - nginx
    - ssl
    - validation

- name: Ensure Nginx service is configured
  ansible.builtin.service:
    name: "{{ nginx_service_name }}"
    enabled: "{{ nginx_service_enabled }}"
    state: "{{ nginx_service_state }}"
  tags:
    - nginx
    - service

- name: Verify Nginx is responding
  ansible.builtin.uri:
    url: "http://localhost:{{ nginx_listen_port }}"
    status_code: 200
    timeout: 5
  register: nginx_health_check
  retries: 3
  delay: 2
  until: nginx_health_check.status == 200
  changed_when: false
  tags:
    - nginx
    - validation
```

### handlers/main.yml
```yaml
---
# Nginx Web Server Role - Handlers

- name: Reload Nginx
  ansible.builtin.service:
    name: "{{ nginx_service_name }}"
    state: reloaded
  when: nginx_service_state == 'started'

- name: Restart Nginx
  ansible.builtin.service:
    name: "{{ nginx_service_name }}"
    state: restarted
```

### templates/nginx.conf.j2
```jinja2
# {{ ansible_managed }}
# Nginx Main Configuration

user www-data;
worker_processes {{ nginx_worker_processes }};
pid /run/nginx.pid;

events {
    worker_connections {{ nginx_worker_connections }};
    # use epoll;
    # multi_accept on;
}

http {
    ##
    # Basic Settings
    ##

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout {{ nginx_keepalive_timeout }};
    types_hash_max_size 2048;
    client_max_body_size {{ nginx_client_max_body_size }};

    # server_tokens off;
    # server_names_hash_bucket_size 64;
    # server_name_in_redirect off;

    include {{ nginx_config_dir }}/mime.types;
    default_type application/octet-stream;

    ##
    # Logging Settings
    ##

    access_log {{ nginx_access_log }};
    error_log {{ nginx_error_log }};

    ##
    # Gzip Settings
    ##

    gzip on;
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_types text/plain text/css text/xml text/javascript application/json application/javascript application/xml+rss application/rss+xml font/truetype font/opentype application/vnd.ms-fontobject image/svg+xml;
    gzip_disable "msie6";

    ##
    # Virtual Host Configs
    ##

    include {{ nginx_vhost_enabled_dir }}/*;
}
```

### templates/vhost.conf.j2
```jinja2
# {{ ansible_managed }}
# Nginx Virtual Host Configuration

server {
    listen {{ nginx_listen_port }} default_server;
    listen [::]:{{ nginx_listen_port }} default_server;

{% if nginx_enable_ssl %}
    listen {{ nginx_listen_ssl_port }} ssl default_server;
    listen [::]:{{ nginx_listen_ssl_port }} ssl default_server;

    ssl_certificate {{ nginx_ssl_cert_path }};
    ssl_certificate_key {{ nginx_ssl_key_path }};
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;
{% endif %}

    server_name {{ nginx_server_name }};

    root {{ nginx_web_root }};
    index index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }

    # Deny access to hidden files
    location ~ /\. {
        deny all;
        access_log off;
        log_not_found off;
    }

    # Logging
    access_log {{ nginx_access_log }};
    error_log {{ nginx_error_log }};
}
```

### meta/main.yml
```yaml
---
galaxy_info:
  role_name: nginx_webserver
  author: Your Team
  description: Production-ready Nginx web server deployment
  company: Your Company
  license: MIT
  min_ansible_version: "2.9"

  platforms:
    - name: Ubuntu
      versions:
        - focal
        - jammy
    - name: Debian
      versions:
        - buster
        - bullseye
    - name: EL
      versions:
        - "8"
        - "9"

  galaxy_tags:
    - nginx
    - webserver
    - web
    - http
    - ssl

dependencies: []
```

### molecule/default/molecule.yml
```yaml
---
dependency:
  name: galaxy
driver:
  name: docker
platforms:
  - name: ubuntu-nginx
    image: geerlingguy/docker-ubuntu2004-ansible
    command: ""
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
    privileged: true
    pre_build_image: true

  - name: debian-nginx
    image: geerlingguy/docker-debian11-ansible
    command: ""
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
    privileged: true
    pre_build_image: true

provisioner:
  name: ansible
  config_options:
    defaults:
      callbacks_enabled: profile_tasks
  inventory:
    host_vars:
      ubuntu-nginx:
        nginx_server_name: ubuntu.example.com
      debian-nginx:
        nginx_server_name: debian.example.com

verifier:
  name: ansible
```

### molecule/default/converge.yml
```yaml
---
- name: Converge
  hosts: all
  become: true

  roles:
    - role: nginx_webserver
      nginx_custom_index_page: true
```

### molecule/default/verify.yml
```yaml
---
- name: Verify
  hosts: all
  gather_facts: false

  tasks:
    - name: Check Nginx is installed
      ansible.builtin.package_facts:
        manager: auto

    - name: Verify Nginx package is installed
      ansible.builtin.assert:
        that:
          - "'nginx' in ansible_facts.packages"

    - name: Check Nginx service status
      ansible.builtin.service_facts:

    - name: Verify Nginx is running
      ansible.builtin.assert:
        that:
          - "ansible_facts.services['nginx.service'].state == 'running'"

    - name: Check Nginx responds on port 80
      ansible.builtin.uri:
        url: http://localhost:80
        status_code: 200
      register: http_response

    - name: Verify HTTP response
      ansible.builtin.assert:
        that:
          - http_response.status == 200
```

## Usage Examples

### Basic Usage
```yaml
- hosts: webservers
  become: true
  roles:
    - nginx_webserver
```

### With Custom Configuration
```yaml
- hosts: webservers
  become: true
  roles:
    - role: nginx_webserver
      nginx_server_name: www.example.com
      nginx_worker_processes: 4
      nginx_client_max_body_size: 128M
      nginx_custom_index_page: true
```

### With SSL Enabled
```yaml
- hosts: webservers
  become: true
  roles:
    - role: nginx_webserver
      nginx_server_name: secure.example.com
      nginx_enable_ssl: true
      nginx_ssl_cert_path: /etc/ssl/certs/example.com.crt
      nginx_ssl_key_path: /etc/ssl/private/example.com.key
```

## Testing

### Run Molecule Tests
```bash
cd roles/nginx_webserver
molecule test
```

### Run Specific Test Sequence
```bash
molecule create
molecule converge
molecule verify
molecule destroy
```

### Linting
```bash
ansible-lint roles/nginx_webserver
yamllint roles/nginx_webserver
```

## Key Features Demonstrated

1. **Proper Role Structure**: Complete directory layout following Ansible best practices
2. **Idempotency**: All tasks can be safely re-run
3. **FQCN Modules**: Fully Qualified Collection Names (ansible.builtin.*)
4. **Template Validation**: nginx.conf validated before deployment
5. **Error Handling**: SSL validation in block
6. **Handlers**: Proper service reload/restart
7. **Variables**: Comprehensive defaults with documentation
8. **Testing**: Complete molecule framework
9. **Multi-OS Support**: Works across Ubuntu, Debian, CentOS
10. **Health Checks**: Verification tasks ensure service is responding

## Notes

- This role demonstrates production-ready patterns
- SSL certificate paths must be provided when SSL is enabled
- Customize variables in inventory or playbook as needed
- Test in development before deploying to production
