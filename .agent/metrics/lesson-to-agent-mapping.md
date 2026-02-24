# Lesson-to-Agent Mapping Matrix

**Purpose**: Map which lessons from reflection pool apply to which agents

**Source**: key-insights.md (62+ lessons) + thinking-patterns.md (8 heuristics T1-T8)

**Last Updated**: 2026-02-22

---

## Universal Patterns (Apply to ALL Agents)

| Pattern | Lesson | Impact | Injection Method |
|---------|--------|--------|------------------|
| **T1** | Stop when same error repeats | Detect boundaries vs bugs | Error Handling section |
| **T3** | Verify before implementing | 43% false positive prevention | Critical Constraints |
| **T5** | Ask for WHY, not just WHAT | Prevent wrong assumptions | Workflow steps |
| **T8** | Gates enforce done | No regression loops | Workflow gates |

**Action**: Add these 4 patterns to ALL 17 agents

---

## Integration Suite (5 Agents)

### Agents
- agent-integration-analyzer
- agent-integration-assessor
- agent-integration-scorer
- agent-integration-designer
- agent-integration-reviewer

### Applicable Lessons (Priority Order)

| Priority | Pattern/Lesson | Evidence | Expected Impact |
|----------|----------------|----------|-----------------|
| **HIGH** | T2: Indirect evidence bias | API docs overstate (Client-A: 1 of 7 fields worked) | 30-40% false positive reduction |
| **HIGH** | T3: Verify before implementing | 43% false positive rate (Client-A) | Prevent wasted implementation |
| **HIGH** | "Runtime changes scores" | Talend: 10% swing, 4/8 dimensions changed | Flag static-only assessments |
| **HIGH** | "12 API quirks not in docs" | TMC testimony | Set realistic expectations |
| **MEDIUM** | T5: Humans hold WHY | 4 assumptions corrected in 30 min (Talend) | Better recommendations |
| **MEDIUM** | "Always test against production" | Only 1 of 7 SAP fields worked (Client-A) | Catch doc inaccuracies |
| **LOW** | "Recipes = source of truth" | VQL files drifted (Client-A) | Verify against implementations |

### Injection Points

**For all 5 agents**, add to:
1. **Critical Constraints**: T2 (bias awareness), T3 (verify first), "43% false positive rate"
2. **Assessment Workflow**: Flag static-only as "Preliminary", request runtime data
3. **Best Practices Section**: "API Documentation Bias" subsection with specific examples
4. **Output Format**: Add ⚠️ "PRELIMINARY — Static Analysis Only" banner if no runtime data

---

## Meta-Agents (5 Agents)

### Agents
- agent-optimizer
- agent-architect
- agent-provisioner
- agent-hub-orchestrator
- agent-project-init

### Applicable Lessons

| Priority | Pattern/Lesson | Evidence | Expected Impact |
|----------|----------------|----------|-----------------|
| **HIGH** | T6: Front-load the model | CV: 2 days positioning → 2hr→30min per app | Methodology reuse |
| **HIGH** | T7: Work classification = quality | TMC: Security as features → 97 new tests | Proper testing rigor |
| **HIGH** | T8: Gates enforce done | TMC: 39 tools, 4 phases, no regression | No scope drift |
| **HIGH** | "Phase gates prevent scope drift" | TMC testimony | Enforce completion |
| **MEDIUM** | "Agent definitions = identity + workflow; content = templates" | Agentic optimization campaign | Design pattern |
| **MEDIUM** | "Security findings are feature work" | TMC: 17 findings → ADRs, tests, docs | Treat seriously |
| **LOW** | "Invest in compounding mechanism" | agent_reflect grew v1.0→v1.6 in 29 days | Tool evolution |

### Injection Points

**For all 5 meta-agents**, add to:
1. **Workflow Methodology**: T6 (establish framework before first instance), T8 (phase gates)
2. **Quality Standards**: T7 (classify work as features, not debt)
3. **Critical Constraints**: "Security findings = feature work, not debt" (if applicable)
4. **Process Section**: Phase gate checklist with "must be true before advancing" criteria

---

## Domain Agents (4 Agents)

### agent-git-manager

**Applicable lessons**:
- ✅ T3: Verify changes before commit
- ✅ T8: Security scan gate before commit (already has this!)
- ✅ "Security findings are feature work" (TMC)
- ⏸️ T4: Frame determines solutions (for debugging commit failures)

**Injection**: Add T4 to error handling (if commit fails 3 times, reframe problem)

---

### agent-sap-businesspartner-integration

**Applicable lessons**:
- ✅ T2: API docs overstate
- ✅ "Only 1 of 7 SAP blocking fields works during creation" (Client-A - **direct testimony!**)
- ✅ "Always test against production APIs" (Client-A)
- ⏸️ T5: Ask WHY certain fields are required

**Injection**: Add SAP-specific quirks section from Client-A testimony

---

### agent-cv-optimizer

**Applicable lessons**:
- ✅ T6: Front-load positioning methodology
- ✅ "Front-load positioning: 2 days → 2hr→30min" (CV Generator testimony - **direct!**)
- ⏸️ T3: Verify job requirements before tailoring
- ⏸️ T5: Ask WHY user targeting specific company/role

**Injection**: Add "Positioning First" subsection in Career Coach mode

---

### agent-robotarm-tester

**Applicable lessons**:
- ✅ T1: Stop when same test fails repeatedly (boundary detection)
- ⏸️ T4: Reframe testing approach if blocked
- ⏸️ "Export architecture before debugging" (GL.iNet pattern)

**Injection**: Add T1 to error recovery workflow

---

## Support Agents (2 Agents)

### agent-documentation-specialist

**Applicable lessons**:
- ✅ "Documentation during troubleshooting captures WHY" (GL.iNet)
- ✅ "ADRs are institutional memory" (TMC)
- ✅ "False positives = documentation opportunities" (Client-A)
- ⏸️ T5: Ask WHY before documenting (understand intent)

**Injection**: Add "Documentation Best Practices" section with testimony lessons

---

### agent-research-assistant

**Applicable lessons**:
- ✅ T2: Know bias direction of sources
- ✅ "API docs overstate what works" (Client-A)
- ⏸️ T3: Verify claims from research
- ⏸️ T5: Distinguish WHAT (artifacts) from WHY (humans)

**Injection**: Add "Source Reliability" guidance with T2 bias awareness

---

## Ansible & Provisioner (Already Optimized for Tokens)

### agent-ansible-automation

**Applicable lessons**:
- ✅ T7: Testing rigor for security work
- ⏸️ T8: Phase gates (lint → syntax → idempotency → integration)

**Injection**: Add phase gate checklist to testing section

---

### agent-provisioner

**Applicable lessons**:
- ✅ T8: Verification gate before deployment
- ⏸️ T3: Verify agent compatibility before syncing

**Injection**: Add verification step before sync execution

---

## Summary Statistics

| Agent Category | Agent Count | Applicable Universal | Applicable Specific | Total Lessons |
|----------------|-------------|---------------------|-------------------|---------------|
| **Integration Suite** | 5 | 4 (T1,T3,T5,T8) | 7 | 11 per agent |
| **Meta-Agents** | 5 | 4 | 7 | 11 per agent |
| **Domain Agents** | 4 | 4 | 2-4 | 6-8 per agent |
| **Support Agents** | 2 | 4 | 3-4 | 7-8 per agent |
| **Already Optimized** | 2 | 4 | 1-2 | 5-6 per agent |
| **TOTAL** | **17** | **4 universal** | **2-7 specific** | **~140 total injections** |

---

## Prioritization Matrix

### Tier 1: Integration Suite (Highest Impact)

**Why first**: Directly affected by testimony lessons about false positives, API quirks, static vs runtime

**Expected improvement**:
- 30-40% reduction in false positive work
- 10% assessment accuracy improvement
- Proper flagging of preliminary assessments

**Agents**: analyzer, assessor, scorer, designer, reviewer (5)

---

### Tier 2: Meta-Agents (Process Quality)

**Why second**: Benefit from process patterns (T6, T7, T8) that improve all downstream work

**Expected improvement**:
- Stricter phase gate enforcement
- Better methodology reuse
- Feature-quality treatment across all work

**Agents**: optimizer, architect, provisioner, hub-orchestrator, project-init (5)

---

### Tier 3: Domain Agents (Specialized Wisdom)

**Why third**: Each has specific testimony lessons but lower universality

**Expected improvement**:
- Domain-specific error avoidance
- Better user consultation (T5)
- Testimony-proven patterns applied

**Agents**: git-manager, SAP, CV, robotarm (4)

---

### Tier 4: Support Agents (Documentation Quality)

**Why fourth**: Smaller set, focused impact on documentation quality

**Expected improvement**:
- Real-time documentation (not post-hoc)
- ADR creation for decisions
- Documentation gap identification

**Agents**: documentation-specialist, research-assistant (2)

---

### Tier 5: Already Optimized (Light Touch)

**Why last**: Already optimized for tokens, add wisdom conservatively

**Expected improvement**:
- Phase gate rigor (T8)
- Testing standards (T7)

**Agents**: Ansible, (provisioner in Tier 2) (1)

---

## Campaign Execution Estimate

| Tier | Agents | Lessons per Agent | Effort per Agent | Total Effort |
|------|--------|------------------|-----------------|--------------|
| Tier 1 | 5 | 11 | 2 hours | 10 hours |
| Tier 2 | 5 | 11 | 2 hours | 10 hours |
| Tier 3 | 4 | 6-8 | 1.5 hours | 6 hours |
| Tier 4 | 2 | 7-8 | 1.5 hours | 3 hours |
| Tier 5 | 1 | 5-6 | 1 hour | 1 hour |
| **TOTAL** | **17** | **~140 injections** | **-** | **30 hours** |

**Plus**: 2 hours for campaign report = **32 hours total**

---

## Quick Start Guide

### Step 1: Choose Pilot Agent

**Recommendation**: agent-integration-assessor

**Why**:
- High impact (11 applicable lessons)
- Clear metrics (false positive rate, static vs runtime)
- Direct testimony evidence (Client-A, Talend-Reviewer)
- Measurable before-after scenarios

### Step 2: Map Lessons

For pilot agent, identify:
- [ ] 4 universal patterns (T1, T3, T5, T8)
- [ ] 7 integration-specific lessons
- [ ] Injection points (constraints, workflow, best practices)

### Step 3: Inject

Add to agent definition:
- [ ] Critical Constraints section (T2, T3, "43% false positive")
- [ ] Workflow enhancement (verification steps)
- [ ] Best Practices section (API bias, runtime requirement)
- [ ] Output format (flag static-only)

### Step 4: Validate

Create test scenario:
- [ ] Static analysis with 3 known false positives
- [ ] Run pre-wisdom agent → counts issues caught?
- [ ] Run post-wisdom agent → flags for verification? Requests runtime?
- [ ] Measure: false positive rate reduction

### Step 5: Document & Scale

If pilot successful:
- [ ] Document results in `.agent/metrics/agents/agent-integration-assessor/wisdom-infusion-results.md`
- [ ] Scale to remaining 4 integration agents
- [ ] Proceed to Tier 2

---

## Cross-Reference

**Full campaign design**: `.agent/sops/agent-wisdom-infusion-campaign.md`

**Lesson sources**:
- `.agent/reflection_pool/key-insights.md` (62+ concrete lessons)
- `.agent/reflection_pool/thinking-patterns.md` (8 reasoning heuristics)
- `.agent/testimony/*.md` (15 project testimonies with context)

**Validation templates**: Create in `.agent/metrics/wisdom-validation-scenarios/`

---

**Status**: Mapping complete, ready for execution

**Next**: Decide pilot agent or full campaign approach
