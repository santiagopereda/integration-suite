# Project Journey Testimony: GLInet Network

**Generated**: 2026-02-21 22:40:15
**Project Path**: /home/askeox/Documents/GLInet_Network
**Command Version**: 1.5.0
**Knowledge Base Version**: Comprehensive (40 documented entries)
**Total Documentation Entries**: 40 (2025-01-11 to 2026-02-02)

---

## Executive Summary

The GLInet Network project documents the configuration and hardening of a multi-router network spanning two GL.iNet devices: a BE3600 travel router and an MT6000 home router. The project demonstrates extensive real-world troubleshooting, with particular focus on Tailscale SSH access, WireGuard hub-spoke VPN architecture, IoT isolation via VLANs, and comprehensive security hardening.

The knowledge base reveals a pattern of **assumption-correction cycles**: initial approaches based on documentation often failed in practice, requiring hands-on testing and troubleshooting to discover the actual behavior of OpenWRT with Tailscale. Key learnings include the critical importance of firewall zone configuration, the limitations of UCI interface binding with TUN devices, and the need for source-IP-based firewall rules when VPN interfaces share zones with LAN.

The project excels at documenting both successes and failures, creating a valuable reference for future OpenWRT/Tailscale/WireGuard deployments. The 40 documented entries spanning 53 days demonstrate sustained, methodical iteration with strong documentation discipline.

---

## Timeline of Key Events

### Initial Setup (2025-01-11)
- **Date**: 2025-01-11
- **Duration**: Single day
- **Objectives**: Establish Claude Code integration, preserve existing documentation
- **Outcomes**: Created `.claude/` and `.agent/` structure, documented router specs and architecture
- **Key Decision**: Preserved existing markdown documentation rather than restructuring

### Knowledge Base Structure (2026-01-11)
- **Date**: 2026-01-11
- **Objectives**: Complete knowledge base with tasks/ and sops/ folders
- **Outcomes**: Added README files, SOP templates, organized system/ and sops/ documentation
- **Key Decision**: Separated technical specs (system/) from operational procedures (sops/)

### Security Hardening Phase (2026-01-11)
- **Date**: 2026-01-11
- **Duration**: Multiple iterations same day
- **Objectives**: Harden AdGuard Home and Tailscale ACL configurations
- **Outcomes**:
  - Applied encrypted DNS, DNSSEC, interface binding to AdGuard
  - Fixed ICMP rule in Tailscale ACL (`:*` port specifier required)
  - Documented security review findings
- **Key Decision**: Document not just what was done, but why each security measure matters

### SSH Binding Discovery & Troubleshooting (2026-01-11)
- **Date**: 2026-01-11
- **Duration**: Multiple troubleshooting cycles
- **Objectives**: Restrict SSH access to Tailscale only
- **Outcomes**:
  - **Failed Approach #1**: UCI `Interface='tailscale0'` binding doesn't work with TUN devices
  - **Failed Approach #2**: SSH via Tailscale returned "Connection refused" despite correct ACLs
  - **Root Cause Discovered**: `tailscale0` not in any firewall zone, hit default `input='REJECT'`
  - **Successful Fix**: Added `tailscale0` to `lan` zone + LAN SSH block via source IP rule
- **Key Decision**: Document the diagnostic path, not just the final solution

### WireGuard Hub-Spoke Implementation (2026-01-31 to 2026-02-02)
- **Date**: 2026-01-31 to 2026-02-02
- **Duration**: 3 days
- **Objectives**: Configure MT6000 as WireGuard hub, BE3600 as spoke
- **Outcomes**:
  - Complete hub-spoke VPN with bidirectional connectivity
  - IoT VLAN isolation on MT6000
  - WAN hardening (drop invalid packets, block bogons, geo-blocking)
  - Comprehensive wireless configuration documentation
- **Key Decision**: WireGuard over Tailscale for site-to-site VPN (performance, control)

---

## What Worked Well

### 1. Iterative Documentation During Troubleshooting
**Context**: SSH binding to Tailscale failed despite following official documentation
**Approach**: Document each failed attempt and diagnostic step in injection-history.md
**Outcome**: Created comprehensive troubleshooting guide others can follow
**Evidence**:
> "SSH via Tailscale returned 'Connection refused' even with correct ACLs. Cause: `tailscale0` interface was not in any firewall zone. OpenWRT default policy `input='REJECT'` blocked traffic from unzoned interfaces."
**Transferable Insight**: **Document failures in real-time, not after success.** The diagnostic path is often more valuable than the final solution, especially when official docs are incomplete.

### 2. Security-First Approach to Network Configuration
**Context**: Home network with IoT devices, travel router with public WiFi exposure
**Approach**: Security hardening before feature enablement (encrypted DNS before convenience features)
**Outcome**: Comprehensive security baseline documented in `.agent/sops/security/`
**Evidence**: AdGuard hardening SOP, Tailscale ACL documentation, WAN firewall hardening, IoT VLAN isolation
**Transferable Insight**: **Establish security baseline early.** It's easier to relax security than to retrofit it after convenience features are in place.

### 3. Structured Knowledge Base Separation
**Context**: Need to document both "how it works" (specs) and "how to do it" (procedures)
**Approach**: Split `.agent/system/` (technical reference) from `.agent/sops/` (operational procedures)
**Outcome**: Clear navigation for both learning (system/) and doing (sops/)
**Evidence**: `.agent/README.md` structure table clearly delineates purposes
**Transferable Insight**: **Separate "what/why" from "how".** Reference documentation and step-by-step procedures serve different audiences and should be organized accordingly.

### 4. Real-World Testing Validation
**Context**: Official OpenWRT/Tailscale docs suggested interface binding would work
**Approach**: Test every documented procedure against actual hardware before considering it "done"
**Outcome**: Discovered 3 critical gaps in official documentation (UCI binding, firewall zones, source IP rules)
**Evidence**: 40 injection-history entries with "Verified working" confirmations
**Transferable Insight**: **Never trust documentation alone for network/security configs.** Official docs are often incomplete or outdated for specific platform combinations.

---

## What Failed and Corrections Made

### 1. UCI Interface Binding for SSH
**Initial Assumption**: Setting Dropbear `Interface='tailscale0'` would restrict SSH to Tailscale
**What Happened**: Error: `Network interface 'tailscale0' has no suitable IP address(es)!`
**Correction Applied**: Documented that UCI expects network interfaces, not raw TUN devices; use firewall rules instead
**Lesson Learned**: **UCI network config and kernel network devices are not the same thing.** TUN/TAP interfaces bypass UCI's network abstraction.
**Source**: `.agent/injection-history.md` - "2026-01-11 - SSH Binding Documentation Update"

### 2. Firewall Zone Configuration
**Initial Assumption**: Tailscale ACLs alone would control SSH access
**What Happened**: SSH via Tailscale returned "Connection refused" despite ACLs allowing it
**Correction Applied**: Added `tailscale0` to `lan` firewall zone to prevent default `input='REJECT'`
**Lesson Learned**: **OpenWRT firewall zones and Tailscale ACLs are complementary, not redundant.** Zone policy determines if traffic reaches the router; ACLs determine who can send it.
**Source**: `.agent/injection-history.md` - "2026-01-11 - Firewall Zone Requirement for Tailscale SSH"

### 3. Tailscale ICMP Rule Syntax
**Initial Assumption**: `"dst": ["tag:router"]` would work for ICMP just like TCP/UDP
**What Happened**: Validation error: `port range "router": invalid first integer`
**Correction Applied**: Changed to `"dst": ["tag:router:*"]` (port specifier required even for ICMP)
**Lesson Learned**: **Tailscale ACL syntax is strict—all protocol types require port specifiers.** Use `*` wildcard for protocols where ports don't apply.
**Source**: `.agent/injection-history.md` - "2026-01-11 - ACL Comments and ICMP Fix"

### 4. LAN SSH Blocking with Shared Zones
**Initial Assumption**: Adding `tailscale0` to `lan` zone would automatically differentiate traffic
**What Happened**: Both LAN devices (192.168.x.x) and Tailscale devices (100.x.x.x) in same zone
**Correction Applied**: Source-IP-based firewall rule to block 192.168.8.0/24 from reaching SSH while allowing 100.x.x.x
**Lesson Learned**: **When VPN and LAN share a firewall zone, use source IP rules for selective blocking.** Zone-based rules are too coarse.
**Source**: `.agent/injection-history.md` - "2026-01-11 - LAN SSH Block Implementation"

---

## Initial Assumptions That Needed Clarification

| Assumption | Reality Discovered | When Discovered | Impact on Project |
|------------|-------------------|-----------------|-------------------|
| UCI interface binding works with all network devices | UCI expects configured network interfaces; TUN devices bypass UCI | 2026-01-11 | Major—required complete rethink of SSH restriction approach |
| Tailscale ACLs are sufficient for SSH security | OpenWRT firewall zones also control traffic; both needed | 2026-01-11 | High—SSH was completely blocked until firewall zone fixed |
| Official docs cover common use cases | Tailscale + OpenWRT edge cases undocumented | 2026-01-11 | High—required extensive hands-on testing to discover working config |
| Port specifiers only needed for TCP/UDP | All Tailscale ACL rules require port syntax, even ICMP | 2026-01-11 | Medium—prevented ACL save until fixed |
| `tailscale ping` success means network is configured | Ping uses control plane; doesn't validate kernel firewall config | 2026-01-11 | High—led to false confidence that config was working |

---

## Evolution of Thinking

### Technical Evolution
- **Started With**: Following official OpenWRT and Tailscale documentation verbatim
- **Pivoted To**: Test-driven configuration—document only what actually works on hardware
- **Ended With**: Comprehensive SOPs combining official docs with platform-specific corrections
- **Key Insight**: Official documentation for niche platform combinations (OpenWRT + Tailscale + GL.iNet firmware) is incomplete; hands-on validation is mandatory.

### Process Evolution
- **Started With**: Configure first, document after success
- **Pivoted To**: Document each failure and diagnostic step as it happens
- **Ended With**: Real-time troubleshooting documentation becomes the most valuable reference
- **Key Insight**: The path to the solution is more instructive than the solution itself, especially for debugging network/firewall issues.

### Architecture Evolution
- **Started With**: Single router (BE3600) with Tailscale for remote access
- **Pivoted To**: Hub-spoke architecture with MT6000 as WireGuard hub, BE3600 as spoke
- **Ended With**: Layered security model: WireGuard for site-to-site, Tailscale for user access, VLANs for device isolation
- **Key Insight**: Different network needs require different VPN solutions—Tailscale for ease of use, WireGuard for performance and control.

---

## Lessons Learned

### Technical Lessons

1. **TUN Device Firewall Requirements**: Raw TUN devices (created by VPNs) must be explicitly added to firewall zones or they hit OpenWRT's default reject policy. UCI interface binding doesn't apply to kernel-level devices.

2. **Layered Firewall Rules**: When VPN and LAN share a zone, combine zone policies (what's allowed in general) with source-IP rules (specific exceptions). Don't try to solve everything at the zone level.

3. **Diagnostic Isolation**: When Tailscale ping works but SSH fails, the issue is OpenWRT firewall config, not Tailscale. Ping uses control plane; SSH goes through kernel firewall.

4. **ACL Syntax Strictness**: Tailscale ACL validation is unforgiving. Always specify ports, even for ICMP (`*` wildcard). Use `//` comments liberally for human readability.

### Process Lessons

1. **Document Failures Immediately**: Waiting until success to document means forgetting the diagnostic path. Future troubleshooters need the failure modes, not just the final config.

2. **Test Before Committing**: Every security/firewall change should be tested with a recovery path (LuCI web interface, serial console) before committing. One typo can lock you out.

3. **Cross-Reference Everything**: Link `.agent/` knowledge base entries to actual config files in the project. Makes it easy to validate docs are still accurate when configs change.

### Human-Agent Collaboration Lessons

1. **Agent as Documentation Enforcer**: agent-git-manager's requirement to document before committing creates accountability for real-time documentation discipline.

2. **Knowledge Base as Memory**: Returning to the project after weeks away, the `.agent/injection-history.md` chronological log makes it easy to remember "where we left off."

3. **SOPs as Checklists**: Standard procedures in `.agent/sops/` eliminate decision fatigue for routine tasks (WireGuard peer addition, firewall rule creation).

---

## Metrics and Outcomes

### Quantitative Results

| Metric | Baseline | Final | Change | Significance |
|--------|----------|-------|--------|--------------|
| Documentation Entries | 1 (init) | 40 | +3900% | Demonstrates sustained documentation discipline |
| Routers Configured | 0 | 2 | +2 | Complete hub-spoke VPN with redundancy |
| Security Hardening SOPs | 0 | 3 | +3 | AdGuard, Tailscale ACL, WAN hardening |
| Troubleshooting Documented | 0 | 7+ | N/A | SSH binding, firewall zones, ICMP, WireGuard peer issues |
| Knowledge Base Files | 4 | 50+ | +1150% | Comprehensive reference across system/, sops/, tasks/ |

### Qualitative Outcomes

- **Security Posture**: Layered defense (Tailscale ACLs + OpenWRT firewall + source IP rules) with documented recovery procedures
- **Maintainability**: Future configuration changes can reference existing SOPs and system documentation
- **Knowledge Transfer**: New team members can understand both "what" (system/) and "how" (sops/) without tribal knowledge
- **Troubleshooting Speed**: Documented diagnostic paths reduce future troubleshooting time from hours to minutes

---

## Agent Usage Telemetry

**Telemetry not enabled** for this project.

To enable telemetry tracking:
1. Provision telemetry infrastructure from Agentic hub via `@agent-provisioner: sync`
2. Enable `CLAUDE_CODE_ENABLE_TELEMETRY=1` in environment
3. Configure OTEL endpoint if using centralized collection

---

## Recommendations for Future Projects

### Do This

1. **Document Failures as They Happen**: Don't wait for success. The diagnostic path is more valuable than the final config for future troubleshooters.

2. **Test Against Real Hardware Early**: Official docs for platform combinations (OpenWRT + Tailscale) are often incomplete. Discover gaps early through hands-on testing.

3. **Separate Reference from Procedure**: Keep "how it works" (system/) distinct from "how to do it" (sops/). Different audiences need different content.

4. **Use Source IP Rules When VPNs Share Zones**: If Tailscale and LAN both live in the `lan` zone, use `src_ip` rules to differentiate them. Zone-level policies are too coarse.

5. **Document Recovery Procedures**: Every security change should include "how to undo this if it locks me out." LuCI web interface, serial console access, etc.

### Avoid This

1. **Trusting UCI Interface Binding for TUN Devices**: It doesn't work. Use firewall zones and source IP rules instead.

2. **Assuming Tailscale Ping Means Full Connectivity**: Ping uses control plane; SSH/HTTP go through kernel firewall. Test all services, not just ping.

3. **Committing Firewall Changes Without Testing**: One typo can lock you out. Test with recovery path open (web interface in another tab).

4. **Skipping Documentation "Just This Once"**: Undocumented changes are forgotten in 2 weeks. The discipline of documenting every change creates a complete project history.

### Consider This

1. **WireGuard for Site-to-Site, Tailscale for User Access**: Different VPN protocols for different use cases. WireGuard gives you control and performance; Tailscale gives you ease of use.

2. **VLAN Isolation for IoT**: Don't trust IoT devices on your main network. Isolate them early before the device count grows.

3. **Geo-Blocking as Defense in Depth**: Even if you have strong authentication, blocking traffic from countries you'll never visit reduces attack surface.

---

## Knowledge Base Audit

### Files Analyzed

| File | Lines | Key Insights Extracted |
|------|-------|----------------------|
| `.agent/injection-history.md` | 1400 | 40 documented events, extensive troubleshooting paths |
| `.agent/README.md` | 87 | Clear navigation structure for system/ vs sops/ |
| `.agent/sops/` | Multiple | 3 security hardening SOPs, WireGuard procedures |
| `.agent/system/` | Multiple | Router specs, architecture, Tailscale ACL, firewall docs |

### Documentation Gaps Identified

- **No PHASE*_COMPLETE.md**: Milestones are documented in injection-history but no dedicated completion narratives
- **No Metrics Tracking**: No quantitative tracking of configuration time, troubleshooting duration, or agent invocations
- **No Tasks/PRDs**: No formal task documentation—all work tracked via injection-history only

### Suggested Improvements

1. **Create Milestone Markers**: When completing major phases (BE3600 complete, MT6000 complete, hub-spoke VPN working), create `PHASE*_COMPLETE.md` documents with metrics and learnings

2. **Track Troubleshooting Time**: Document how long each issue took to diagnose/fix. Helps quantify value of having SOPs for next time.

3. **Add Tasks Directory**: Create PRDs for planned features (dual-WAN failover, guest network, etc.) to separate "what we're planning" from "what we've done"

---

## Appendix: Source Excerpts

### Critical Discovery: Firewall Zone Requirement

From injection-history.md (2026-01-11):

> **Root Cause Discovered**: SSH via Tailscale returned "Connection refused" even with correct ACLs. Cause: `tailscale0` interface was not in any firewall zone. OpenWRT default policy `input='REJECT'` blocked traffic from unzoned interfaces. `tailscale ping` worked because it uses Tailscale control plane, not kernel firewall.
>
> **Fix**:
> ```bash
> uci add_list firewall.@zone[0].device='tailscale0'
> uci commit firewall
> fw4 reload
> ```
>
> **Key Finding**: Adding `tailscale0` to the `lan` zone is **required** for SSH to work via Tailscale. This is safer than creating a separate tailscale zone (which can cause lockouts). Tailscale ACLs still control who can reach the router; firewall zone controls whether traffic is accepted.

### Diagnostic Methodology

From injection-history.md:

> **Diagnostic Path**:
> 1. LAN SSH works, Tailscale ping works, but Tailscale SSH fails = firewall zone issue
> 2. Check `uci show firewall | grep input` to see zone policies
> 3. Interfaces not in any zone hit the default `input='REJECT'`

### Security Status Table

From injection-history.md (2026-01-11):

| Access Path | Status |
|-------------|--------|
| SSH via Tailscale | ✅ Works |
| SSH via LAN | ✅ Blocked |
| SSH via WAN | ✅ Blocked (default) |
| LuCI via LAN | ✅ Works (recovery path) |

---

**Testimony Generated By**: Opus 4.6 (direct generation)
**Command Version**: 1.5.0
**Generation Date**: 2026-02-21 22:40:15
