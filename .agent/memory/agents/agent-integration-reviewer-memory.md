# Agent Memory: agent-integration-reviewer

**Last Updated**: 2026-02-20
**Patterns From**: 5 projects (Talend-Reviewer, Vaxxinova-Debug, UniQure, GLInet-BE3600, RaspberryPi)
**Total Patterns**: 13

---

## Security Patterns

### SEC-001: Log Redaction Must Be Customer-Configurable
- **Pattern**: TMC execution logs contained unredacted Azure AD tenant IDs and API endpoints. A 3-layer redaction architecture (field-level, regex engine, customer-injected patterns) was needed because environments differ.
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: Build customer-configurable log redaction before collecting runtime logs. Use layered architecture: built-in field removal, configurable regex engine, customer-specific pattern injection.
- **Tags**: talend, security

### SEC-002: CSRF Token Requires Two-Action Pattern for Session Cookie Preservation
- **Pattern**: SAP OData write operations require CSRF tokens tied to session cookies. Workato SDK doesn't preserve cookies between HTTP requests within a single execute block. Single-action pattern consistently failed; two-action pattern succeeded.
- **Source**: UniQure (2026-01-23)
- **Action**: For CSRF-protected APIs on iPaaS platforms (Workato), always use a two-action pattern: Action 1 fetches token + cookies, Action 2 receives both as inputs. Never attempt single-action CSRF token fetch + API call.
- **Tags**: sap, security

### SEC-003: Defense-in-Depth — Multiple Independent Security Layers
- **Pattern**: When UCI interface binding failed for restricting SSH to Tailscale, a 4-layer independent security model was built: Tailscale ACLs, firewall source-IP rule, SSH key-only auth, WAN firewall. Any single-point failure doesn't compromise access control.
- **Source**: GLInet-BE3600 (2026-01-23)
- **Action**: When a primary security mechanism fails or is unavailable, layer multiple independent mechanisms. Each layer should function independently so that failure of one doesn't compromise the system.
- **Tags**: networking, security

### SEC-004: Source IP Rules When Interfaces Share a Firewall Zone
- **Pattern**: Tailscale (100.x.x.x) and LAN (192.168.8.x) traffic both flow through the `lan` firewall zone. Zone-based rules couldn't distinguish them. Source IP filtering (`src_ip='192.168.8.0/24'`) blocked LAN SSH while allowing Tailscale SSH.
- **Source**: GLInet-BE3600 (2026-01-23)
- **Action**: When multiple interfaces share a firewall zone and need different access rules, use source IP-based filtering instead of zone-based rules for granular control.
- **Tags**: networking, security

---

## Design Review Patterns

### DRV-001: DLC URI Must Use Registered Connection Factory
- **Pattern**: `activemq:queue:ErrorQueue` creates an anonymous JMS connection without credentials. Talend strips underscores from component IDs in Camel registry (`cMQConnectionFactory_1` → `cMQConnectionFactory1`).
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: In Talend DLC configuration, always use the registered connection factory name (e.g., `cMQConnectionFactory1:queue:ErrorQueue`), never the generic `activemq:` scheme. Verify naming by stripping underscores from component IDs.
- **Tags**: talend, design-review

### DRV-002: Test Talend Components from Route Context Not Standalone
- **Pattern**: tRouteOutput is a no-op when a job runs standalone — it only generates actual Camel `setHeader()` code when called from a route. Standalone testing gives false confidence.
- **Source**: Vaxxinova-Debug (2026-02-12)
- **Action**: When testing Talend components that interact with Camel routes (tRouteOutput, tRouteInput), always test via route invocation, never standalone. Standalone produces false positives.
- **Tags**: talend, design-review

### DRV-003: Distinguish Connection User from Application User in Ansible
- **Pattern**: `ansible_user` was used for SSH key deployment in a mirobot role, but `ansible_user` is the SSH connection user, not the application user. SSH keys were deployed to the wrong user. The fix was changing to `new_user.name` for application-context variables.
- **Source**: RaspberryPi (2026-01-23)
- **Action**: When reviewing Ansible roles, verify that user-related variables distinguish connection context (`ansible_user`, `ansible_become_user`) from application context (custom variables like `new_user.name`). Conflation causes privilege and deployment errors.
- **Tags**: ansible, design-review

---

## Anti-Patterns

### APT-001: tDie Is Logging-Only Not Exception Propagation
- **Pattern**: `tDie` in Talend routes does not propagate its message string to the exception. `TDieException` constructor receives null. For proper error messages in DLC/ErrorQueue, `RuntimeException` is required.
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: Never use `tDie` when error messages need to reach a Dead Letter Channel. Replace with `tJava` throwing `new RuntimeException("descriptive message")` for proper message propagation.
- **Tags**: talend, anti-patterns

### APT-002: OSGi Bundle Isolation Prevents Configuration-Based Fixes
- **Pattern**: Talend jobs embed their own dependencies (CXF, etc.) in OSGi bundles. JVM arguments, system properties, and Karaf-level bundle changes do NOT reach embedded libraries. Only code-level changes work.
- **Source**: Vaxxinova-Debug (2026-02-12)
- **Action**: In Karaf/OSGi environments, never attempt configuration-based fixes for embedded library behavior. Go directly to code-level solutions using JDK built-ins (e.g., tJavaFlex with java.net.http).
- **Tags**: talend, anti-patterns

### APT-003: Avoid Java Generics in tJavaFlex
- **Pattern**: Talend's code generator misinterprets angle brackets `<>` as annotation syntax. Using `HttpResponse<String>` causes compilation errors in tJavaFlex components.
- **Source**: Vaxxinova-Debug (2026-02-12)
- **Action**: Always use raw types with explicit casts in tJavaFlex code (e.g., `HttpResponse resp` then `(String) resp.body()`). Never use parameterized types.
- **Tags**: talend, anti-patterns

### APT-004: Talend Component Fields Have Undocumented Expression Contexts
- **Pattern**: Different fields in the same Talend component use different expression languages with no visual distinction. tRouteOutput Body supports `{in.header.X}` syntax; Header Name is raw Java requiring quoted strings.
- **Source**: Vaxxinova-Debug (2026-02-12)
- **Action**: When debugging Talend component compilation errors, check expression context per field. Test Body, Header, and other fields separately. Compilation errors are the only way to discover the difference.
- **Tags**: talend, anti-patterns

### APT-005: Hidden SSIDs Are Security Theater
- **Pattern**: Hidden SSIDs were configured for an IoT network for "additional security." IoT devices failed to connect, and devices broadcast probe requests that reveal the SSID anyway, negating any security benefit.
- **Source**: GLInet-BE3600 (2026-01-23)
- **Action**: Never use hidden SSIDs for security. They break device compatibility (especially IoT) and provide no real protection. Use strong encryption (WPA2/WPA3) and network segmentation instead.
- **Tags**: networking, anti-patterns

### APT-006: Avoid Interactive Shell Commands in Automation
- **Pattern**: `which pyenv` was used to detect pyenv in Ansible tasks. Non-interactive shells (used by Ansible) don't load `.bashrc`/`.profile`, so PATH-dependent commands fail silently. Replaced with `ansible.builtin.stat` checking the binary path directly.
- **Source**: RaspberryPi (2026-01-23)
- **Action**: In Ansible and other automation tools, never use shell commands that depend on interactive shell initialization (which, type, command -v with PATH). Use filesystem checks (stat, test -f) or absolute paths instead.
- **Tags**: ansible, anti-patterns
