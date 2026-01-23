# Cross-Project Testimony Analysis

**Analysis Date**: 2026-01-23
**Last Updated**: 2026-01-23 (added raspberrypi project)
**Projects Analyzed**: 7
**Total Lines Analyzed**: ~13,400+ lines across testimonies

---

## Projects Summary

| Project | Domain | Duration | Key Achievement |
|---------|--------|----------|-----------------|
| Agentic | Agent hub | Nov 2025 - Jan 2026 | 51-59% token reduction, 7 production agents |
| CV Generator Agent | Career optimization | 5 days | 3-stage workflow, recruiter flow discovery |
| GL.iNet BE3600 | Router hardening | 3 days | 4-layer defense-in-depth, 7 configs complete |
| Mirobot | Agent optimization | Nov 2025 | Template externalization, lazy loading |
| Survival | Emergency prep | 3 days | 3-stage food model, EUR 5,995 procurement roadmap |
| UniQure | Enterprise integration | 2 months | 43% false positive detection, 9 validated SOPs |
| **raspberrypi** | **Ansible automation** | **12 days** | **5 SOPs (3,619 lines), 65% prompt reduction, 5 GitHub repos** |

---

## SUCCESS PATTERNS (Do More Of)

### 1. Knowledge Base Structure (.agent/)
**Evidence**: All 6 projects used identical structure
```
.agent/
├── tasks/         # PRDs & implementation plans
├── system/        # Project structure, schemas, APIs
├── sops/          # Standard operating procedures
└── injection-history.md  # Audit trail
```
**Why It Works**: Single source of truth, clear separation of concerns, audit trail

### 2. Template Externalization & Lazy Loading
**Evidence**: Agentic/Mirobot achieved 51-59% token reduction; **raspberrypi achieved 65%**
- Agentic: Baseline 31,000 tokens → Current 15,200 tokens
- raspberrypi: Agent prompt 576 lines → 202 lines (**65% reduction**, best in class)
- ROI: Templates used 30+ times break even quickly
**Pattern**: Core instructions always loaded; reference content on-demand
**Reinforcement Strength**: HIGH (3 projects, consistent 51-65% range)

### 3. Verification Before Implementation
**Evidence**: UniQure Phase 0 found 43% false positive rate (6/14 issues)
- Prevented ~4 days unnecessary work
- CRIT-5 Race Condition: FALSE (Workato concurrency=1)
- CRIT-4 Password Storage: FALSE (Workato AES-256 auto-encrypts)
**Pattern**: Always verify issues before implementing fixes

### 4. Documentation-First / As-You-Code
**Evidence**:
- CV Generator: Front-loaded career narrative paid off immediately
- GL.iNet: "Documentation during troubleshooting captures the 'why'"
- UniQure: "Document as you code" prevented drift
**Pattern**: Update docs immediately after implementation

### 5. Phased/Staged Approaches
**Evidence**:
- Survival: 3-stage food model (frozen → basement → cycling)
- Agentic: Phase 1 (externalization) → Phase 2 (alignment)
- UniQure: Validation phases with prioritization
**Pattern**: Break complex work into distinct phases with clear objectives

### 6. Budget/Option Tiers (3-tier system)
**Evidence**: Survival applied across all categories
- Minimum | Recommended | Premium
- Every item has weight AND price estimates
**Pattern**: Flexibility over rigid constraints; "budget as optimization parameter"

### 7. Production Testing Reveals Documentation Gaps
**Evidence**:
- UniQure: Only 1 of 7 SAP blocking fields works during creation (contrary to docs)
- GL.iNet: UCI interface binding doesn't work with Tailscale TUN devices
**Pattern**: Always test against actual production APIs; don't trust documentation alone

### 8. Defense-in-Depth for Critical Systems
**Evidence**: GL.iNet SSH security has 4 independent layers
1. Tailscale ACLs
2. Firewall rules (source IP)
3. SSH key authentication
4. WAN firewall
**Pattern**: Multiple mechanisms survive single-point failure

### 9. SOP Creation Immediately After Task Completion
**Evidence**:
- UniQure created 9 production-validated SOPs
- **raspberrypi created 5 comprehensive SOPs (3,619 lines total)**:
  - ansible-playbook-vagrant-testing.md (858 lines, 16 validation items)
  - ansible-user-variable-configuration.md (797 lines, 15 validation items)
  - mirobot-python-environment-setup.md (580 lines)
  - mirobot-deployment.md (578 lines)
  - role-modularization.md (806 lines)
- **Combined**: 14 SOPs across 2 projects
**Pattern**: Document procedures while fresh; capture common mistakes
**Reinforcement Strength**: VERY HIGH (14 SOPs with validation checklists)

### 10. FAQ Sections Prevent Support Burden
**Evidence**: UniQure created 13 FAQ questions for unidirectional architecture
**Pattern**: Document rationale (WHY), not just facts (WHAT)

### 11. Parallel Documentation Systems (NEW from raspberrypi)
**Evidence**: raspberrypi established clear separation
- `docs/` - User-facing documentation (narrative, explanatory, comprehensive)
- `.agent/` - Agent knowledge base (procedural, actionable, structured)
- Bidirectional cross-references between systems
**Pattern**: Different audiences need different documentation formats
**Quote**: "Created 'Documentation Structure' section explaining relationship between docs/ and .agent/"

### 12. Architecture Modularization to External Repositories (NEW from raspberrypi)
**Evidence**: raspberrypi extracted 5 Ansible roles to independent GitHub repositories
- ansible-role-common (389 insertions)
- ansible-role-security (229 insertions)
- ansible-role-shell (874 insertions)
- ansible-role-python-dev (562 insertions)
- ansible-role-mirobot (2,239 insertions)
- Main project uses `requirements.yml` for dependency management
**Pattern**: Plan for modularization early; external dependencies enable reuse and independent versioning
**Benefits**: Reusability, independent version control, semantic versioning capability

### 13. Version Pinning for Hardware/Robotics Projects (NEW from raspberrypi)
**Evidence**: raspberrypi discovered critical version dependencies
- Python 3.9.18 required (3.13+ breaks dataclass compatibility)
- bleak==0.22.3 required (1.1.0+ removed `discover()` function)
- async-timeout==4.0.3 required (5.0+ incompatible with bleak 0.22.3)
**Pattern**: Pin exact versions for hardware-interface code; breaking changes are common
**Lesson**: Test upgrades explicitly; don't assume latest is compatible

---

## FAILURE PATTERNS (Avoid These)

### 1. "What to Bring" Without "How to Use"
**Evidence**: Survival project
- 67 documents, EUR 5,995 procurement roadmap complete
- BUT: No SOPs, no packing checklists, no daily routines
- Evacuation readiness: Only 50% despite 80% category completion
**Lesson**: Equipment without operational procedures = limited readiness

### 2. Route/Journey Planning Deferred
**Evidence**: Survival route planning 0% complete
- All gear for 1,400km journey, no route validation
- No daily distance targets, resupply points, border crossing research
**Lesson**: Validate journey feasibility BEFORE equipment procurement

### 3. Resource Files Drift from Implementations
**Evidence**: UniQure VQL files missing fields present in actual recipes
- VeevaLanguages.vql, VeevaLocales.vql missing `global_id__sys`
**Lesson**: Recipes/implementations are source of truth; resource files are reference

### 4. Premature CV/Variant Creation
**Evidence**: CV Generator NATO variant deleted
- "Insufficient differentiation from base CV"
- Wasted maintenance effort
**Lesson**: Tailor on-demand for specific JDs; avoid premature variants

### 5. Missing Phase Completion Documentation
**Evidence**: Mirobot references PHASE*_COMPLETE.md but files not found
**Lesson**: Validate cross-referenced documentation exists

### 6. Empty Template Sections
**Evidence**: Multiple projects
- tasks/ folder has README but no PRDs
- sops/ folder has templates but no actual SOPs
- common-mistakes.md template but not populated
**Lesson**: Populate templates or remove; empty structure misleads

### 7. Single-Point Assumptions (Invalidated by Testing)
**Evidence**:
- GL.iNet: UCI interface binding assumed to work
- UniQure: SAP field availability assumed accurate
- CV Generator: Assumed all applications start with user
**Lesson**: Test assumptions early; design for discovered reality

### 8. Day 2 Momentum Loss
**Evidence**: Survival
- Day 1: 6 injection entries, 50+ files
- Day 2: Zero entries
- Day 3: Completion tasks
**Lesson**: Multi-day sprints need momentum maintenance

### 9. Connection User vs Application User Confusion (NEW from raspberrypi)
**Evidence**: raspberrypi SSH key deployment failed
- `ansible_user` is the SSH connection user
- `new_user.name` is the application user
- Role used wrong variable, deploying keys to wrong user
**Lesson**: Distinguish connection context from application context in configuration
**Source**: `.agent/sops/configuration/ansible-user-variable-configuration.md`

### 10. Assuming Latest Version is Best (NEW from raspberrypi)
**Evidence**: Multiple compatibility breaks
- Python 3.13: Broke dataclass compatibility with mirobot-py
- bleak 1.1.0: Removed `discover()` function, breaking existing code
- System Python used instead of pinned pyenv Python
**Lesson**: Test version upgrades explicitly; hardware/robotics code is version-sensitive

### 11. Shell Command Assumptions in Non-Interactive Contexts (NEW from raspberrypi)
**Evidence**: `which pyenv` failed in Ansible
- Non-interactive shells don't load shell profiles (.bashrc, .zshrc)
- `which` command requires PATH to be set by profile
- Detection silently failed
**Correction**: Use `ansible.builtin.stat` to check for binary directly
**Lesson**: Never rely on shell commands that require interactive shell initialization

---

## BLINDSPOTS (Systematic Gaps)

### 1. Cross-Category Integration Validation
**Evidence**: Survival
- Power budget: No calculation of daily consumption vs. solar input
- Cooking: No validation stove capability matches recipe requirements
- Weight: No pannier loading plan
**Opportunity**: Integration testing checklist across categories

### 2. Seasonality/Timing Guidance
**Evidence**: Survival
- "Full summer energy independence achievable"
- BUT: No departure season recommendation
- No "worst month to travel" analysis
**Opportunity**: Add timing/seasonality sections

### 3. Physical/Real-World Validation
**Evidence**: Survival
- No weekend shakedown ride
- No actual pannier packing test
- No calorie burn vs. food supply calculation
**Opportunity**: Pre-deployment testing checklist

### 4. Training/Preparation Plans
**Evidence**: Survival 1,400km journey with no fitness plan
**Opportunity**: Preparation milestone tracking

### 5. Feedback/Success Metrics
**Evidence**: No project has user satisfaction tracking
**Opportunity**: Post-project feedback mechanism

### 6. Search/Tags/Metadata
**Evidence**: No project has document tagging system
**Opportunity**: Metadata for large knowledge bases

### 7. Version History Within Documents
**Evidence**: Documents updated in place, only injection-history tracks changes
**Opportunity**: Document-level change tracking

### 8. Reverse Workflow Support
**Evidence**: CV Generator had to add recruiter-initiated workflow
- Initial design only supported user → job posting flow
**Opportunity**: Design for bidirectional flows from start

---

## METRICS THAT PROVED VALUABLE

| Metric | Project | Value | Impact |
|--------|---------|-------|--------|
| Token reduction | Agentic | 51-59% | ~2.1M annual tokens saved |
| **Prompt reduction** | **raspberrypi** | **65% (576→202 lines)** | **Best optimization result** |
| False positive rate | UniQure | 43% | ~4 days saved per cycle |
| Lines eliminated | Agentic | 725 (80%) | Maintenance burden reduced |
| Test pass rate | Agentic | 100% | Quality maintained |
| Calorie/EUR | Survival | Calculated per product | Optimized food budget |
| Weight/category | Survival | ~70kg total | Validated cycling capacity |
| Workflow steps | UniQure | 401 total | Comprehensive documentation |
| **SOP line count** | **raspberrypi** | **3,619 lines (5 SOPs)** | **Most comprehensive procedures** |
| **Validation items** | **raspberrypi** | **76 checklist items** | **Quality assurance coverage** |
| **GitHub repos created** | **raspberrypi** | **5 role repositories** | **Architecture modularization** |
| **Ansible tasks** | **raspberrypi** | **69 successful** | **Full deployment validated** |

---

## RECOMMENDATIONS FOR AGENT-ARCHITECT

### 1. Add Integration Testing to Agent Design
When designing agents, include guidance for:
- Cross-agent validation
- System-level integration checklists
- Dependency verification

### 2. Include Operational Procedures in Agent Scope
Agents should produce both:
- "What" deliverables (documents, code)
- "How" procedures (SOPs, checklists)

### 3. Design for Verification-First Workflows
43% false positive rate suggests agents should:
- Verify issues before implementing fixes
- Include "is this actually a problem?" step

### 4. Build in Timing/Seasonality Guidance
Agents should consider:
- When to perform actions
- Timing dependencies
- Seasonal factors

### 5. Suggest Reverse Workflow Support
Agents should consider:
- User-initiated flows (default)
- External-initiated flows (recruiter, webhook, etc.)

### 6. Recommend FAQ Sections
For complex architectural decisions, agents should:
- Suggest FAQ sections
- Document "why" not just "what"
- Address common confusion proactively

### 7. Emphasize Production Testing
Agent output should include:
- Test assumptions against production
- Document field/API availability
- Note documentation inaccuracies discovered

### 8. Design Parallel Documentation Systems (NEW from raspberrypi)
For projects serving both humans and AI:
- `docs/` for narrative, explanatory content for humans
- `.agent/` for procedural, actionable content for agents
- Establish bidirectional cross-references
- Document when to use each system

### 9. Plan for Modularization Early (NEW from raspberrypi)
For infrastructure/automation projects:
- Design components as independent modules from start
- Use dependency management (requirements.yml, package.json)
- Prepare for semantic versioning
- Add modules to .gitignore when externalized

### 10. Pin Versions for Hardware/Embedded Projects (NEW from raspberrypi)
When interfacing with hardware:
- Pin exact Python version (not just major.minor)
- Pin all library versions with known compatibility
- Document breaking change thresholds
- Test version upgrades explicitly

### 11. Avoid Shell-Dependent Commands in Automation (NEW from raspberrypi)
In non-interactive contexts (Ansible, CI/CD):
- Use direct binary checks instead of `which`
- Prefer `stat` or path existence tests
- Don't rely on shell profile initialization
- Test in clean environments

---

## CROSS-PROJECT SYNTHESIS

### Universal Success Factors
1. `.agent/` knowledge base structure (7/7 projects)
2. `injection-history.md` audit trail (7/7 projects)
3. Phased approach with clear objectives (6/7 projects)
4. Documentation-as-you-code (7/7 projects)
5. Production testing before design finalization (4/7 projects)
6. **SOP creation with validation checklists** (2/7 projects, but highest impact)
7. **Parallel documentation systems** (1/7 projects, emergent pattern)

### Universal Failure Factors
1. Equipment without procedures (Survival)
2. Resource file drift (UniQure)
3. Untested assumptions (GL.iNet, UniQure, CV Generator, **raspberrypi**)
4. Missing integration validation (Survival)
5. Empty template sections (Multiple projects)
6. **Version compatibility assumptions** (raspberrypi - Python/bleak)
7. **Context confusion** (raspberrypi - connection vs application user)

### Unique Strengths by Project
- **Agentic**: Token optimization methodology
- **CV Generator**: Rapid iteration, same-day workflow fixes
- **GL.iNet**: Defense-in-depth security patterns
- **Survival**: 3-tier budget optimization
- **UniQure**: False positive detection methodology
- **raspberrypi**: SOP depth (3,619 lines), parallel documentation, architecture modularization

---

## IMPACT OF RASPBERRYPI ADDITION

### Patterns Reinforced (Higher Confidence)
| Pattern | Before | After | Change |
|---------|--------|-------|--------|
| Template Externalization | 2 projects (51-59%) | 3 projects (51-65%) | +1 project, wider range |
| SOP Creation | 9 SOPs (UniQure) | 14 SOPs (2 projects) | +5 SOPs, +3,619 lines |
| Documentation-as-you-code | Mentioned | Parallel systems pattern | Elevated to new pattern |

### New Patterns Discovered
1. **Parallel Documentation Systems** - First evidence of formal `docs/` vs `.agent/` separation
2. **Architecture Modularization** - GitHub-based role extraction pattern
3. **Version Pinning for Hardware** - Specialized pattern for robotics/embedded

### New Anti-Patterns Discovered
1. **User variable confusion** (ansible_user vs new_user.name)
2. **Latest version assumptions** (breaking changes in bleak, Python)
3. **Shell command assumptions** (non-interactive shell profile loading)

### Key Insight
> raspberrypi demonstrates the most comprehensive SOP development process across all projects, with validation checklists (76 items) and common mistakes sections in every procedure.

---

**Analysis Generated By**: Claude Opus 4.5
**Source**: 7 project testimonies from .agent/testimony/
**Last Enrichment**: raspberrypi (2026-01-23)
