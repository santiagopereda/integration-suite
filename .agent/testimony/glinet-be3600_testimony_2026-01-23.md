# Project Journey Testimony: GL.iNet BE3600 Secure Travel Router

**Generated**: 2026-01-23 16:56:58
**Project Path**: /home/askeox/Documents/GLInet_Be3600
**Knowledge Base Version**: 2026-01-13 (Final)
**Total Documentation Entries**: 31 entries across 3 days (973 lines in injection-history.md)

---

## Executive Summary

This project transformed a default GL.iNet BE3600 WiFi 7 router into a fully hardened, secure travel router with layered VPN architecture. The agent-assisted journey spanned from initial setup (2025-01-11) through completion (2026-01-13), resulting in comprehensive documentation covering SSH hardening, Tailscale control plane, AdGuard DNS filtering, NordVPN privacy, wireless configuration, and firewall hardening.

The most significant learnings came from real-world testing that invalidated initial assumptions about OpenWRT interface binding. The discovery that UCI interface binding doesn't work with Tailscale's TUN devices led to a complete redesign of the SSH security model, ultimately resulting in a more robust defense-in-depth architecture using ACLs, firewall rules, and key authentication.

The project demonstrated the value of incremental testing and documentation-driven development. Each configuration change was verified before proceeding, and failures were documented alongside corrections. This approach transformed what could have been frustrating troubleshooting sessions into valuable learning opportunities that are now captured in reusable SOPs.

---

## Timeline of Key Events

### Phase 1: Initial Setup
- **Date**: 2025-01-11
- **Duration**: Single session
- **Objectives**: Establish Claude Code integration, create project structure
- **Outcomes**:
  - Project structure with `.claude/` and `.agent/` folders
  - CLAUDE.md comprehensive reference created
  - agent-openwrt-configurator agent defined
  - Existing documentation preserved (SSH, Tailscale, VPN guides)
- **Key Decision**: Use `.agent/` as single source of truth for project state

### Phase 2: Knowledge Base Structure
- **Date**: 2026-01-11
- **Duration**: Early session
- **Objectives**: Complete knowledge base structure
- **Outcomes**:
  - `.agent/README.md` main overview created
  - `tasks/` and `sops/` directories established
  - SOP template created for future procedures
- **Key Decision**: Separate technical reference (.agent/) from user guides

### Phase 3: Security Review & SSH Discovery
- **Date**: 2026-01-11
- **Duration**: Extended troubleshooting session
- **Objectives**: Configure SSH access via Tailscale only
- **Outcomes**:
  - **Critical discovery**: UCI interface binding doesn't work with Tailscale
  - Root cause identified: Dropbear expects UCI network interface, Tailscale creates raw TUN device
  - Firewall zone requirement discovered and documented
  - LAN SSH block implemented using source IP filtering
  - Defense-in-depth model documented with 4 security layers
- **Key Decision**: Rely on Tailscale ACLs + firewall rules instead of interface binding

### Phase 4: AdGuard Home Documentation
- **Date**: 2026-01-11
- **Duration**: Multi-session
- **Objectives**: Document and verify AdGuard configuration
- **Outcomes**:
  - 6-document guide structure created (mirroring Tailscale folder)
  - Authentication requirement corrected (not needed on GL.iNet)
  - Bootstrap DNS diversity implemented for travel use
  - GL.iNet `--glinet` flag limitation discovered (blocks Prometheus)
  - Query log persistence enabled
- **Key Decision**: Use Query Log instead of Prometheus for DNS monitoring

### Phase 5: Wireless Configuration
- **Date**: 2026-01-11
- **Duration**: Single session
- **Objectives**: Document multi-network WiFi architecture
- **Outcomes**:
  - 4-document guide structure created
  - Multi-network architecture documented (5GHz family, 2.4GHz IoT, Guest)
  - 2.4GHz fixes applied (hidden SSID doesn't work with IoT)
  - Channel selection optimized for travel (non-DFS)
- **Key Decision**: Separate SSIDs for different security requirements

### Phase 6: VPN Architecture Revision
- **Date**: 2026-01-12
- **Duration**: Single session
- **Objectives**: Align documentation with working configuration
- **Outcomes**:
  - Three-layer model simplified to two-layer (Tailscale + NordVPN)
  - WireGuard server removed (impractical behind hotel NAT)
  - NordVPN configuration documented with privacy-focused server selection
  - Canada removed from server list (5 Eyes)
- **Key Decision**: Keep router clean, run complex services elsewhere

### Phase 7: Firewall Hardening
- **Date**: 2026-01-13
- **Duration**: Extended session
- **Objectives**: Complete firewall documentation and verification
- **Outcomes**:
  - 5-document Firewall/ folder created
  - Live `fw4 print` output verified against documentation
  - Discovered undocumented features (SYN flood protection, DNS leak prevention)
  - All security checks passed verification
- **Key Decision**: Document actual vs expected configuration for audit trail

### Phase 8: Project Completion
- **Date**: 2026-01-13
- **Duration**: Final session
- **Objectives**: Mark project complete, document scope decisions
- **Outcomes**:
  - All 7 configuration steps marked complete
  - VLAN and QoS deferred to future home network project
  - Scope rationale documented (not suitable for travel router)
- **Key Decision**: Complete project, defer advanced features to dedicated hardware

---

## What Worked Well

### 1. Defense-in-Depth Security Model
**Context**: SSH access needed to be restricted to Tailscale only, but initial approach (interface binding) failed.
**Approach**: Layered multiple independent security mechanisms.
**Outcome**: Four-layer SSH protection that survives any single-point failure.
**Evidence**: From `.agent/system/architecture.md`:
> "SSH Security Layers:
> 1. Tailscale ACLs (primary) - Only `tag:laptop` and `autogroup:admin` can reach port 22
> 2. Firewall rule - `Block_SSH_from_LAN` blocks 192.168.8.0/24
> 3. SSH keys - Ed25519 only, no passwords
> 4. WAN firewall - Blocks all WAN access (default)"
**Transferable Insight**: When a single security mechanism fails, having redundant layers prevents complete compromise.

### 2. Documentation-Driven Discovery
**Context**: Configuration decisions needed to be made about complex interacting systems.
**Approach**: Document assumptions, test, update documentation with findings.
**Outcome**: Every failure became a learning opportunity with permanent record.
**Evidence**: From `injection-history.md`:
> "**Root Cause Discovered**:
> - SSH via Tailscale returned 'Connection refused' even with correct ACLs
> - Cause: `tailscale0` interface was not in any firewall zone
> - OpenWRT default policy `input='REJECT'` blocked traffic from unzoned interfaces"
**Transferable Insight**: Documenting the debugging path creates reusable knowledge that prevents others from repeating the same mistakes.

### 3. Numbered Guide Structure
**Context**: Multiple complex configuration topics needed clear organization.
**Approach**: Mirror successful Tailscale folder structure for all topics.
**Outcome**: Consistent, navigable documentation across 6 topic areas.
**Evidence**: All topic folders follow the pattern:
```
Topic/
├── 00-Index.md          # Overview, architecture, success criteria
├── 01-First-Step.md     # Sequential guides
├── ...
└── 0X-Troubleshooting.md # Recovery procedures
```
**Transferable Insight**: Consistent documentation patterns reduce cognitive load and enable faster navigation.

### 4. Source IP-Based Firewall Rule
**Context**: Needed to block LAN SSH while allowing Tailscale SSH, but both use the `lan` zone.
**Approach**: Block by source IP (192.168.8.0/24) instead of by zone.
**Outcome**: Tailscale traffic (100.x.x.x) allowed through while LAN blocked.
**Evidence**: From `.agent/sops/security/ssh-tailscale-only.md`:
```bash
uci set firewall.@rule[-1].src='lan'
uci set firewall.@rule[-1].src_ip='192.168.8.0/24'  # Key: IP-based, not zone-based
```
**Transferable Insight**: When interfaces share a zone, use IP-based rules for granular control.

### 5. Bootstrap DNS Diversity for Travel
**Context**: Travel router may encounter networks where specific DNS providers are blocked.
**Approach**: Include multiple major DNS providers in bootstrap DNS.
**Outcome**: DNS resolution works even if one provider is blocked in a country.
**Evidence**: From `injection-history.md`:
> "For travel router use, provider diversity is more valuable than same-provider redundancy.
> If Quad9 is blocked in a country, two Quad9 IPs won't help."
**Transferable Insight**: For portable devices, redundancy across providers beats redundancy within a provider.

---

## What Failed and Corrections Made

### 1. UCI Interface Binding with Tailscale
**Initial Assumption**: Setting `Dropbear.Interface='tailscale0'` would restrict SSH to Tailscale.
**What Happened**: Error: "Network interface 'tailscale0' has no suitable IP address(es)!"
**Correction Applied**: Abandoned interface binding, implemented ACLs + firewall rules.
**Lesson Learned**: Tailscale creates raw TUN devices, not UCI network interfaces. Security must be enforced at other layers.
**Source**: `injection-history.md` entry "## 2026-01-11 - SSH Binding Documentation Update"

### 2. AdGuard Authentication Requirement
**Initial Assumption**: AdGuard Home required authentication (users: []) to be secure.
**What Happened**: GL.iNet routers don't have the Settings -> General -> Administrator section. Adding auth via config.yaml breaks GL.iNet UI integration.
**Correction Applied**: Documented why authentication is optional: router creates isolated LAN, external networks can't reach admin interface, Tailscale ACLs control remote access.
**Lesson Learned**: Security requirements depend on network topology. A travel router's isolation provides implicit protection.
**Source**: `injection-history.md` entry "## 2026-01-11 - AdGuard Authentication Correction"

### 3. Firewall Zone Requirement
**Initial Assumption**: Tailscale SSH would work once ACLs were configured.
**What Happened**: "Connection refused" despite correct ACLs. `tailscale ping` worked but `ssh` failed.
**Correction Applied**: Added `tailscale0` to the `lan` firewall zone.
**Lesson Learned**: Tailscale control plane uses different paths than kernel networking. Ping uses control plane, SSH uses kernel firewall.
**Source**: `injection-history.md` entry "## 2026-01-11 - Firewall Zone Requirement for Tailscale SSH"

### 4. Hidden SSID for IoT
**Initial Assumption**: Hidden SSID would provide additional security for IoT network.
**What Happened**: IoT devices failed to connect to hidden SSIDs.
**Correction Applied**: Set SSID visibility to "Shown" on 2.4GHz IoT network.
**Lesson Learned**: Hidden SSIDs are security theater and break compatibility. Devices broadcast probes revealing the SSID anyway.
**Source**: `injection-history.md` entry "## 2026-01-11 - Wireless Configuration Update"

### 5. WireGuard Server on Travel Router
**Initial Assumption**: Three-layer VPN model (Tailscale + WireGuard server + NordVPN).
**What Happened**: WireGuard server impractical - behind hotel NAT/CGNAT, incoming connections blocked.
**Correction Applied**: Simplified to two-layer model (Tailscale + NordVPN client only).
**Lesson Learned**: Travel routers can't accept incoming connections. All "server" functions should run on home infrastructure.
**Source**: `injection-history.md` entry "## 2026-01-12 - VPN Architecture Revision"

### 6. Prometheus Metrics on GL.iNet
**Initial Assumption**: AdGuard Home Prometheus endpoint could be enabled for monitoring.
**What Happened**: GL.iNet patches AdGuard with `--glinet` flag requiring Admin-Token cookie for all API access.
**Correction Applied**: Documented limitation, recommended Query Log as better solution for domain monitoring.
**Lesson Learned**: Vendor modifications may limit standard functionality. Query logs often provide more useful data than aggregate metrics for security monitoring.
**Source**: `injection-history.md` entry "## 2026-01-11 - Prometheus Metrics Investigation"

---

## Initial Assumptions That Needed Clarification

| Assumption | Reality Discovered | When Discovered | Impact on Project |
|------------|-------------------|-----------------|-------------------|
| UCI interface binding works universally | Tailscale creates raw TUN, not UCI interface | 2026-01-11 | Complete security model redesign |
| AdGuard needs explicit authentication | Network topology provides implicit protection | 2026-01-11 | Removed incorrect "CRITICAL" warnings |
| Tailscale ACLs alone secure SSH | Firewall zone membership required for traffic flow | 2026-01-11 | Added mandatory firewall zone step |
| WireGuard server viable on travel router | Hotel NAT blocks incoming connections | 2026-01-12 | Simplified to two-layer architecture |
| Prometheus ideal for DNS monitoring | Query logs provide better per-domain visibility | 2026-01-11 | Shifted monitoring strategy |
| Same-provider DNS redundancy sufficient | Country-level blocking requires provider diversity | 2026-01-11 | Changed bootstrap DNS approach |
| Hidden SSIDs add security | Security theater that breaks IoT devices | 2026-01-11 | Changed to visible SSIDs |

---

## Evolution of Thinking

### Technical Evolution
- **Started With**: Three-layer VPN (Tailscale + WireGuard server + NordVPN) with interface binding for security
- **Pivoted To**: Two-layer VPN (Tailscale + NordVPN client) with ACL-based security
- **Ended With**: Defense-in-depth model with four security layers working independently
- **Key Insight**: Travel routers are clients, not servers. Security through multiple mechanisms beats single-point enforcement.

### Process Evolution
- **Started With**: Configure first, document later approach
- **Pivoted To**: Test incrementally, document findings immediately
- **Ended With**: Every change documented with verification steps before and after
- **Key Insight**: Documentation during troubleshooting captures the "why" that post-hoc documentation misses.

### Architecture Evolution
- **Started With**: Assumed GL.iNet would behave like standard OpenWRT
- **Pivoted To**: Discovered GL.iNet customizations (--glinet flag, UI integration requirements)
- **Ended With**: Documentation distinguishes GL.iNet-specific behaviors from standard OpenWRT
- **Key Insight**: Vendor forks of open source projects have hidden modifications. Test assumptions, document differences.

---

## Lessons Learned

### Technical Lessons
1. **Tailscale TUN Interface**: Tailscale creates `tailscale0` as a raw TUN device, not a UCI network interface. Services cannot bind directly to it. Access control must use Tailscale ACLs and OpenWRT firewall rules.

2. **Firewall Zone Membership**: Traffic from an interface not in any zone hits the default policy (usually REJECT). Adding `tailscale0` to the `lan` zone is required for any traffic to flow through kernel firewall.

3. **Source IP vs Zone Rules**: When multiple interfaces share a firewall zone, use source IP rules (`src_ip='192.168.8.0/24'`) for granular control instead of zone-based rules.

4. **Travel Router Constraints**: Behind hotel NAT/CGNAT, incoming connections are blocked. Design for client-only operation - run servers on home infrastructure.

5. **Vendor Modifications**: GL.iNet's `--glinet` flag on AdGuard requires Admin-Token cookie for all API access, blocking standard integrations like Prometheus.

### Process Lessons
1. **Test Before Commit**: Always verify changes work via Tailscale before committing firewall rules that might lock you out. The `uci changes` / `uci commit` / `uci revert` workflow prevents disasters.

2. **Keep Recovery Path Open**: LuCI via LAN (http://192.168.8.1:8080) serves as emergency recovery. Never close this path until SSH via Tailscale is verified working.

3. **Document the Debug Path**: Recording the troubleshooting steps that led to a solution creates reusable knowledge. The "Connection refused" to "firewall zone required" discovery path is now a documented pattern.

### Human-Agent Collaboration Lessons
1. **Verification Before Trust**: Initial recommendations about interface binding were based on general OpenWRT knowledge. Real-world testing revealed Tailscale-specific behaviors. Agent assistance accelerated the discovery but human verification caught the gap.

2. **Question "Best Practices"**: The AdGuard authentication recommendation came from general security principles but didn't account for the travel router's isolated network topology. Challenging assumptions led to correct documentation.

3. **Incremental Scope**: Starting with a complete vision (three-layer VPN, Prometheus monitoring) but being willing to simplify based on findings (two-layer, Query Log) resulted in a working system faster than pursuing impractical features.

---

## Metrics and Outcomes

### Quantitative Results
| Metric | Baseline | Final | Change | Significance |
|--------|----------|-------|--------|--------------|
| Security layers on SSH | 1 (keys only) | 4 | +300% | Defense-in-depth |
| Documentation files | ~5 scattered | 25+ structured | +400% | Comprehensive coverage |
| Configuration journey steps | 0 | 7 complete | - | Full hardening |
| Knowledge base entries | 0 | 31 | - | Complete audit trail |
| Deferred features | 0 | 2 | - | Appropriate scope |

### Qualitative Outcomes
- **Security posture**: SSH accessible only via Tailscale with key authentication, protected by 4 independent mechanisms
- **Maintainability**: Numbered guide structure with consistent format enables future updates
- **Recoverability**: Emergency paths documented (LuCI, hard reset, failsafe mode)
- **Audit capability**: Complete injection-history.md traces every decision
- **Reusability**: SOPs created for SSH hardening and firewall auditing applicable to future routers

---

## Recommendations for Future Projects

### Do This
1. **Create injection-history.md immediately**: Start logging changes from day one. The chronological record is invaluable for understanding how and why the system evolved.

2. **Test incrementally with recovery paths open**: Before making changes that could lock you out, verify you have a working backup access method. Document recovery procedures before you need them.

3. **Question interface binding assumptions**: Different systems (Tailscale, WireGuard, Docker) create interfaces that may not integrate with standard configuration systems. Test before documenting.

4. **Design for travel constraints**: If the device will be behind NAT, don't plan for server functionality. Build client-only architectures with remote control via mesh VPN.

5. **Document vendor modifications**: When using vendor forks (GL.iNet OpenWRT), explicitly note where behavior differs from upstream. These gaps cause the hardest-to-debug issues.

### Avoid This
1. **Don't assume authentication is always required**: Evaluate the network topology. An isolated network may provide implicit protection that makes explicit authentication redundant.

2. **Don't pursue metrics over logs for security monitoring**: Prometheus aggregate metrics don't show which domains were queried. Query logs provide the forensic detail needed for security analysis.

3. **Don't use hidden SSIDs**: Security theater that breaks IoT device compatibility. Use strong encryption (WPA2/WPA3) instead.

4. **Don't implement features "just in case"**: The WireGuard server and Prometheus integration were planned but never needed. Implementing them would have added complexity without benefit.

### Consider This
1. **GL.iNet vs raw OpenWRT**: GL.iNet's UI integration is convenient but limits some advanced features. Consider whether the trade-off fits your use case before committing.

2. **DNS provider diversity for travel**: If the device will operate in countries with DNS restrictions, include multiple major providers in bootstrap DNS configuration.

3. **Separate documentation levels**: Technical reference (`.agent/`) for agent context vs user guides (`Topic/`) for human operators reduces confusion and duplication.

---

## Knowledge Base Audit

### Files Analyzed
| File | Lines | Key Insights Extracted |
|------|-------|----------------------|
| `.agent/injection-history.md` | 973 | Complete project timeline, all corrections, decision rationale |
| `.agent/README.md` | 63 | Knowledge base structure and navigation |
| `.agent/system/architecture.md` | 185 | VPN layer design, service access control matrix |
| `.agent/system/README.md` | 42 | System documentation categories |
| `.agent/sops/README.md` | 65 | SOP structure and categories |
| `.agent/sops/security/ssh-tailscale-only.md` | 189 | SSH security procedure with verification |
| `.agent/sops/security/firewall-hardening.md` | 378 | 7-phase audit procedure with rollback |
| `README.md` | 183 | Configuration journey status, quick reference |

### Documentation Gaps Identified
- **No PHASE*_COMPLETE.md files**: Milestone narratives would enrich retrospective analysis
- **No metrics/*.json files**: Quantitative baseline/current data not captured
- **No common-mistakes.md**: Failures documented in injection-history but not consolidated
- **No task PRDs**: `.agent/tasks/` contains only README.md

### Suggested Improvements
1. **Create PHASE_COMPLETE.md** for major milestones with narrative summaries
2. **Consolidate failures** into `.agent/sops/common-mistakes.md` for quick reference
3. **Add metrics tracking** for security posture over time (number of exposed ports, authentication mechanisms, etc.)
4. **Template verification checklist** at end of each SOP to ensure completeness

---

## Appendix: Source Excerpts

### Key Entries from injection-history.md

**2025-01-11 - Initial Setup**
> "**Purpose**: Establish Claude Code integration for travel router configuration project"

**2026-01-11 - SSH Binding Discovery**
> "UCI `Interface='tailscale0'` binding **does NOT work** with Tailscale
> - Error: `Network interface 'tailscale0' has no suitable IP address(es)!`
> - Cause: Dropbear expects UCI network interface, Tailscale creates raw TUN device"

**2026-01-11 - Firewall Zone Root Cause**
> "SSH via Tailscale returned 'Connection refused' even with correct ACLs
> - Cause: `tailscale0` interface was not in any firewall zone
> - OpenWRT default policy `input='REJECT'` blocked traffic from unzoned interfaces"

**2026-01-11 - AdGuard Authentication Correction**
> "GL.iNet routers don't have Settings -> General -> Administrator section
> Adding auth via config.yaml breaks GL.iNet UI integration"

**2026-01-11 - Bootstrap DNS Diversity**
> "For travel router use, provider diversity is more valuable than same-provider redundancy
> If Quad9 is blocked in a country, two Quad9 IPs won't help"

**2026-01-13 - Project Complete**
> "Steps 8-9 (VLAN Configuration, QoS) are deferred to a future **Home Network** project using dedicated hardware (Flint 2 + Zimaboard 2). IoT isolation and advanced traffic shaping don't belong on a portable travel router."

### Security Verification Results

From firewall verification session (2026-01-13):
- tailscale0 in lan zone: VERIFIED
- SSH blocked from LAN (192.168.8.0/24): VERIFIED
- WAN input hardened (DROP policy): VERIFIED
- Guest zone isolated: VERIFIED
- DNS leak prevention active: VERIFIED
- SYN flood protection active: VERIFIED

### Final Configuration Status

| Step | Topic | Status |
|------|-------|--------|
| 1 | Initial Router Setup | Done |
| 2 | SSH Hardening | Done |
| 3 | Tailscale Control Plane | Done |
| 4 | Wireless Configuration | Done |
| 5 | DNS & AdGuard | Done |
| 6 | NordVPN (WireGuard Client) | Done |
| 7 | Firewall Hardening | Done |

---

**Testimony Generated By**: Claude Opus 4.5 (claude-opus-4-5-20251101)
**Command**: /agent_reflect
**Generation Date**: 2026-01-23 16:56:58
