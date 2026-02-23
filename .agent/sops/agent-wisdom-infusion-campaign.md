# Agent Wisdom Infusion Campaign

**Purpose**: Systematically incorporate lessons from project testimonies and reflection pool into agent definitions to improve decision quality, reduce false starts, and embody proven patterns.

**Optimization Goal**: Agent effectiveness (not token consumption)

**Measurement**: Quality of agent outputs, fewer iterations to completion, reduction in preventable errors

**Status**: DESIGN (not yet executed)

**Created**: 2026-02-22

---

## Core Premise

**Current state**: 11+ project testimonies have accumulated 62+ concrete lessons + 8 reasoning heuristics in the reflection pool. These represent hard-won wisdom about what works and what doesn't.

**Opportunity**: Most agents were designed BEFORE these lessons were learned. They don't embody the accumulated wisdom.

**Goal**: Systematically map lessons → agents and inject wisdom where applicable to improve agent effectiveness.

**Key difference from Token Optimization Campaign**:
- Token campaign: Reduce consumption (efficiency)
- Wisdom campaign: Improve decisions (effectiveness)

---

## What We're Optimizing For

### Primary: Decision Quality
- **Fewer false starts**: Agents apply T3 (verify before implementing)
- **Better framing**: Agents apply T4 (test the frame)
- **Human consultation**: Agents apply T5 (ask for WHY, not just WHAT)

### Secondary: Process Quality
- **Phase gates**: Agents apply T8 (enforce completion before advancing)
- **Pattern recognition**: Agents apply T1 (detect repeated error classes)
- **Bias awareness**: Agents apply T2 (know documentation overstates reality)

### Tertiary: Domain Expertise
- **Integration best practices**: From UniQure, Talend-Reviewer testimonies
- **Security patterns**: From TMC, GL.iNet testimonies
- **Assessment methodology**: From Talend-Reviewer, CV Generator

---

## Phase 1: Map Lessons to Agents (Audit)

### Step 1: Classify Lessons by Applicability

**Universal lessons** (apply to ALL agents):
- T1: Stop when same error repeats
- T3: Compress before you execute (verify before implementing)
- T5: Humans hold the WHY (ask user for context/intent)
- T8: Gates enforce done (complete one step before next)

**Agent-type-specific lessons**:

**Integration agents** (analyzer, assessor, scorer, designer, reviewer):
- T2: Indirect evidence bias (API docs overstate, static analysis misses runtime)
- "Always test against production APIs" (UniQure)
- "Runtime enrichment changes scores" (Talend-Reviewer)
- "12 API quirks survived unit tests" (TMC)
- "43% false positive rate validates verification-first" (UniQure)

**Meta-agents** (optimizer, architect, provisioner, hub-orchestrator, project-init):
- T6: Front-load the model (methodology before execution)
- T7: How work is classified determines quality (treat as feature, not debt)
- "Phase gates prevent scope drift" (TMC)
- "Agent definitions = identity + constraints + workflow; content = templates" (Agentic)

**Domain agents** (SAP, Ansible, CV, robotarm, git):
- T4: The frame determines solutions (reframe blocked problems)
- Domain-specific patterns from relevant testimonies

**Support agents** (research-assistant, documentation-specialist):
- "Documentation during troubleshooting captures WHY" (GL.iNet)
- "ADRs are institutional memory" (TMC)
- "False positives are documentation opportunities" (UniQure)

### Step 2: Agent-Lesson Mapping Matrix

Create matrix: `{agent-id}` × `{lesson-id}` → `{applicable: yes/no/maybe}`

**Example row (agent-integration-assessor)**:
- T1 (stop when error repeats): ✅ YES (prevent assessment loops)
- T2 (indirect evidence bias): ✅ YES (static analysis overstates)
- T3 (verify before implementing): ✅ YES (confirm issues before scoring)
- T5 (humans hold WHY): ✅ YES (ask why architecture chosen)
- "43% false positive rate": ✅ YES (critical for assessors)
- "Runtime enrichment changes scores": ✅ YES (flag static scores)

**Example row (agent-git-manager)**:
- T1 (stop when error repeats): ✅ YES (detect commit failures)
- T2 (indirect evidence bias): ⏸️ MAYBE (git operations deterministic)
- T3 (verify before implementing): ✅ YES (verify changes before commit)
- T8 (gates enforce done): ✅ YES (security scan before commit)
- "Security findings are feature work": ✅ YES (treat security seriously)

---

## Phase 2: Gap Analysis (What's Missing)

### Step 1: Audit Current Agent Constraints

For each agent, identify existing wisdom:
- What lessons are already embedded?
- What lessons are missing?
- What lessons conflict with current approach?

**Example: agent-git-manager current constraints**:
- ✅ Has: T8-like pattern (security scan gate before commit)
- ✅ Has: Verification pattern (git status before commit)
- ❌ Missing: T1 (no repeated error detection)
- ❌ Missing: T5 (doesn't ask WHY user wants to commit certain files)

### Step 2: Prioritize Gaps

**High priority** (will measurably improve outcomes):
- Missing T3 (verify before implementing) → prevents false positive work
- Missing T5 (ask WHY) → prevents wrong assumptions
- Missing domain-specific lessons → prevents known failure modes

**Medium priority** (will improve edge cases):
- Missing T1 (repeated error detection) → helps with debugging loops
- Missing T2 (bias awareness) → improves decision skepticism

**Low priority** (nice to have):
- Missing T6, T7 (process quality) → less impactful for single-agent tasks

---

## Phase 3: Injection Strategy (How to Add Wisdom)

### Method 1: Add to Critical Constraints Section

**When**: Universal lessons that must ALWAYS be applied

**Format**:
```markdown
## Critical Constraints

### Verification Before Implementation (T3)

- **Never implement a fix** before verifying the issue exists as described
- **43% false positive rate** (UniQure testimony): Always confirm issue against actual system before investing effort
- If issue is from static analysis, documentation, or inference → **verify in runtime first**
```

**Example agents**: All integration agents, all meta-agents

---

### Method 2: Add to Workflow Steps

**When**: Lessons that apply at specific workflow points

**Format**:
```markdown
### Step 2: Analyze Issue

Before implementing any fix:
1. **Verify issue exists** (T3: Compress before execute)
   - Test against actual production API (not documentation)
   - Expect 40-50% of issues to be false positives or documentation gaps
2. **Ask user for context** (T5: Humans hold WHY)
   - Why was this designed this way?
   - What constraint was this responding to?
```

**Example agents**: Integration agents (analyzer, assessor), troubleshooting agents

---

### Method 3: Add to Error Handling Section

**When**: Lessons about recognizing failure patterns

**Format**:
```markdown
## Error Handling

### Repeated Error Class Detection (T1)

If you encounter structurally identical failures 2-3 times:
- **STOP** - you've hit a boundary, not a fixable bug
- Examples: Isolation layer (OSGi), architectural constraint (NAT), wrong frame
- Action: Identify the boundary, decide whether to work within it or go below it
- **Do not** try more variations of the same approach
```

**Example agents**: All agents (universal pattern)

---

### Method 4: Add Domain-Specific Best Practices

**When**: Concrete lessons from testimonies relevant to agent domain

**Format**:
```markdown
## Integration Best Practices (From Project Testimonies)

**API Documentation Bias** (T2):
- API docs overstate what works: Only 1 of 7 SAP blocking fields worked (UniQure)
- Expect 8-12 API quirks not mentioned in documentation (TMC)
- **Always verify** critical API behaviors against production

**Runtime vs Static Analysis**:
- Static scores change 10% when runtime data added (Talend-Reviewer)
- 4 of 8 dimension scores changed after runtime enrichment
- Flag static-only assessments as **"Preliminary — Static Analysis Only"**
```

**Example agents**: Integration suite (all 5 agents)

---

### Method 5: Add Reasoning Heuristics Reference

**When**: Agent should be aware of thinking patterns

**Format**:
```markdown
## Reasoning Heuristics

This agent applies domain-independent reasoning patterns from `.agent/reflection_pool/thinking-patterns.md`:

- **T1**: Stop when same error repeats (detect boundaries, not bugs)
- **T3**: Verify before implementing (43% false positive rate)
- **T5**: Ask for WHY, not just WHAT (humans hold intent)

**When uncertain about approach**: Reference full thinking patterns for guidance.
```

**Example agents**: Meta-agents (architect, optimizer), complex workflow agents

---

### Method 6: Update Output Modes with Wisdom Levels

**When**: Agent has output modes, add "wisdom-aware" variants

**Format**:
```markdown
## Output Modes

### Standard Mode (Default)
- Apply T3 (verify before implementing)
- Flag assumptions explicitly

### Thorough Mode
- Apply all applicable thinking patterns (T1, T2, T3, T5, T8)
- Ask WHY questions before proceeding
- Flag bias in all indirect sources (docs, static analysis)
- Enforce phase gates strictly

### Quick Mode
- Minimal verification (use with caution)
- Assumptions not flagged (user accepts risk)
```

**Example agents**: All agents with output modes

---

## Phase 4: Validation (How to Measure Impact)

### Before-After Comparison

**Metrics to track**:
1. **False positive rate**: % of agent-proposed actions that were incorrect
2. **Iteration count**: Average turns to complete task
3. **User corrections**: How often user corrects agent assumptions
4. **Quality gates failed**: How often agent-produced work fails validation
5. **User satisfaction**: Subjective quality ratings

**Method**: Create test scenarios, run pre-wisdom vs post-wisdom agent, compare metrics.

---

### Test Scenario Design

**For Integration Agents**:

**Scenario 1: False Positive Detection**
- Give agent a static analysis report with known false positives
- **Pre-wisdom**: Agent proposes fixes for all issues
- **Post-wisdom** (with T3): Agent asks to verify issues first, flags documentation gaps
- **Measurement**: % of false positives caught before implementation

**Scenario 2: Runtime vs Static**
- Give agent partial data (static only)
- **Pre-wisdom**: Agent finalizes assessment from static data
- **Post-wisdom** (with T2): Agent flags assessment as preliminary, requests runtime data
- **Measurement**: Accuracy improvement after runtime data

---

**For Meta-Agents**:

**Scenario 1: Phase Gate Enforcement**
- Ask agent to optimize another agent
- **Pre-wisdom**: Agent might skip validation if time-pressured
- **Post-wisdom** (with T8): Agent enforces quality gates before proceeding
- **Measurement**: Quality gate pass rate

**Scenario 2: WHY Questions**
- Ask agent to refactor code
- **Pre-wisdom**: Agent infers intent from code structure
- **Post-wisdom** (with T5): Agent asks WHY code was designed that way
- **Measurement**: % of wrong assumptions prevented

---

### Validation Checklist

For each infused agent:
- [ ] Identified 3-5 applicable lessons
- [ ] Injected lessons using appropriate method (constraints/workflow/error handling)
- [ ] Created before-after test scenarios
- [ ] Ran scenarios and measured impact
- [ ] Documented results in `.agent/metrics/agents/{agent-id}/wisdom-infusion-results.md`
- [ ] Achieved measurable improvement (lower false positive rate, fewer iterations, or higher quality)

---

## Phase 5: Campaign Execution Plan

### Tier 1: Integration Suite (High Impact)

**Agents**: 5 (analyzer, assessor, scorer, designer, reviewer)

**Why first**: Most impacted by T2 (indirect evidence bias), T3 (verify first), testimony lessons about API quirks and static analysis limitations.

**Expected impact**:
- 30-40% reduction in false positive work
- 10% improvement in assessment accuracy
- Flagging of preliminary assessments

**Lessons to inject**:
- T2 (API docs overstate)
- T3 (verify before implementing)
- "43% false positive rate" (UniQure)
- "Runtime changes 10% of scores" (Talend-Reviewer)
- "12 API quirks not in docs" (TMC)

**Effort**: ~2 hours per agent (mapping, injection, validation) = 10 hours total

---

### Tier 2: Meta-Agents (Process Quality)

**Agents**: 5 (optimizer, architect, provisioner, hub-orchestrator, project-init)

**Why second**: Benefit from T6 (front-load model), T7 (work classification), T8 (phase gates).

**Expected impact**:
- Stricter phase gate enforcement
- Better methodology documentation
- "Feature-quality" treatment of all work

**Lessons to inject**:
- T6 (front-load methodology)
- T7 (classify work properly)
- T8 (gates enforce done)
- "Phase gates prevent scope drift" (TMC)
- "Security findings are feature work" (TMC)

**Effort**: ~2 hours per agent = 10 hours total

---

### Tier 3: Domain Agents (Specialized Wisdom)

**Agents**: 4 (SAP, Ansible, CV, robotarm, git)

**Why third**: Each has domain-specific lessons from testimonies.

**Expected impact**:
- Domain-specific error avoidance
- Better user consultation (T5)
- Frame-testing (T4) for blocked problems

**Lessons to inject** (examples):
- git-manager: "Security findings = feature work" (TMC)
- CV agent: "Front-load positioning" (CV Generator testimony)
- SAP agent: "Only 1 of 7 blocking fields works" (UniQure)

**Effort**: ~2 hours per agent = 8 hours total

---

### Tier 4: Support Agents (Documentation Quality)

**Agents**: 2 (research-assistant, documentation-specialist)

**Why last**: Benefit from documentation-specific lessons.

**Expected impact**:
- Better documentation during work (not after)
- ADR creation for decisions
- False positives → documentation improvements

**Lessons to inject**:
- "Documentation during troubleshooting captures WHY" (GL.iNet)
- "ADRs are institutional memory" (TMC)
- "False positives = documentation opportunities" (UniQure)

**Effort**: ~2 hours per agent = 4 hours total

---

### Campaign Timeline

**Total effort**: ~32 hours (4 weeks × 8 hours/week)

**Week 1**: Tier 1 (Integration Suite - 5 agents)
**Week 2**: Tier 2 (Meta-Agents - 5 agents)
**Week 3**: Tier 3 (Domain Agents - 4 agents)
**Week 4**: Tier 4 (Support - 2 agents) + Campaign report

---

## Comparison: Token vs Wisdom Campaigns

| Dimension | Token Campaign | Wisdom Campaign |
|-----------|----------------|-----------------|
| **Goal** | Reduce consumption | Improve decisions |
| **Measurement** | Tokens saved, % reduction | False positive rate, iterations, quality |
| **Method** | Template externalization | Lesson injection |
| **Agents modified** | 6/17 (35%) | 16/17 (94%) planned |
| **Effort** | 15 hours (Tier 1+2) | 32 hours (all 4 tiers) |
| **Impact type** | Efficiency (cost/speed) | Effectiveness (quality) |
| **Validation** | Quality gates (5) | Test scenarios (before-after) |
| **Compounding** | Design guidelines for future | Reflection pool grows with projects |
| **Trade-offs** | Tokens vs usability | Verbosity vs decisiveness |

**Both are valuable**: Token campaign optimizes consumption, Wisdom campaign optimizes outcomes.

---

## Example: agent-integration-assessor Wisdom Infusion

### Current State (Pre-Wisdom)

agent-integration-assessor conducts structured discovery and evaluation. Current definition focuses on workflow mechanics (ask questions, gather data, produce assessment).

**Missing wisdom**:
- No awareness of 43% false positive rate
- No guidance to verify issues before finalizing
- No flagging of static-only assessments as preliminary
- No prompt to ask WHY architecture was chosen (T5)

---

### Proposed Infusion

**Add to Critical Constraints**:
```markdown
## Critical Constraints

### Verification-First Approach (T3)

**43% false positive rate** (UniQure testimony): In integration assessments, nearly half of identified issues are false positives, documentation gaps, or inference errors.

- **Before flagging an issue**: Verify it exists in actual runtime behavior, not just static analysis
- **When assessing from code alone**: Flag assessment as **"Preliminary — Static Analysis Only"**
- **Expect 10% score swing** when runtime data is added (Talend-Reviewer)

### Human Intent Consultation (T5)

Architecture choices encode constraints and decisions that code alone doesn't reveal:

- **Before criticizing a design**: Ask WHY it was built that way
- What constraint was this responding to?
- What was deliberately left simple?
- What was meant to be temporary?

**Don't infer intent from code structure alone** - one 30-minute conversation prevents days of wrong recommendations.
```

**Add to Workflow (Discovery Phase)**:
```markdown
### Step 2: Gather Context (Enhanced)

**Standard questions** (existing):
- Data flows, volumes, latency requirements...

**Wisdom-enhanced questions** (NEW):
1. **WHY was this integration designed this way?** (T5: Humans hold WHY)
   - What constraints influenced the approach?
   - What alternatives were considered and rejected?

2. **What runtime behaviors should I verify?** (T3: Verify before implementing)
   - Don't trust static analysis alone
   - Identify critical paths to test against production

3. **Is this production data or static analysis?** (T2: Indirect evidence bias)
   - Flag assessment scope explicitly
   - Request runtime data if only static available
```

**Add to Output Section**:
```markdown
### Assessment Output Format (Enhanced)

**If assessment is static-only**:
```
# Integration Assessment: {Name}

⚠️ **PRELIMINARY — Static Analysis Only**

This assessment is based on code review and documentation without runtime verification.
Expect ~10% score adjustment when runtime data is added (4 of 8 dimensions may change).

**To finalize**: Verify against production runtime behavior.
```

**Validation**: Create test scenario with known false positives, measure if agent catches them before finalizing.

---

## Success Criteria

**Campaign succeeds if**:

1. ✅ **Measurable quality improvement**:
   - False positive rate reduced by 20%+
   - Iteration count reduced by 15%+
   - User corrections reduced by 25%+

2. ✅ **Wisdom coverage**:
   - 80%+ of applicable lessons injected across all agents
   - All universal patterns (T1, T3, T5, T8) in all agents

3. ✅ **Validation completed**:
   - Before-after scenarios run for all agents
   - Results documented
   - Regressions identified and fixed

4. ✅ **No quality degradation**:
   - Agents don't become overly cautious (paralysis)
   - Response times acceptable
   - User experience maintained or improved

---

## Risks & Mitigations

### Risk 1: Verbosity Overload

**Risk**: Adding all lessons makes agents too verbose/cautious

**Mitigation**:
- Use Output Modes (Standard applies key lessons, Thorough applies all)
- Inject concisely (bullet points, not paragraphs)
- Focus on HIGH impact lessons only

### Risk 2: Lesson Conflicts

**Risk**: Some lessons conflict with agent's core purpose

**Example**: T5 (ask WHY) conflicts with autonomous agents that shouldn't interrupt

**Mitigation**:
- Map lessons carefully (not all apply to all agents)
- Adapt lessons to agent context
- Prioritize agent identity over universal patterns

### Risk 3: Measurement Difficulty

**Risk**: Hard to measure "decision quality" objectively

**Mitigation**:
- Use concrete metrics (false positive rate, iteration count)
- Create reproducible test scenarios
- Track user feedback systematically

### Risk 4: Lesson Obsolescence

**Risk**: Lessons from old testimonies may not apply to new contexts

**Mitigation**:
- Review reflection pool for relevance (annual)
- Update lessons as new testimonies challenge them
- Flag lessons with "Last validated: {date}"

---

## Future Enhancements

**After initial campaign**:

1. **Automated lesson mapping**: Script to suggest which lessons apply to which agents
2. **Wisdom scoring**: Measure how "wisdom-dense" each agent is
3. **Testimony-triggered updates**: When new testimony adds critical lesson, auto-suggest affected agents
4. **Cross-agent wisdom sharing**: When one agent learns something, propagate to similar agents
5. **Wisdom regression testing**: Ensure agent updates don't remove critical lessons

---

## Getting Started

**Immediate next step**:
1. Choose pilot agent (recommend: agent-integration-assessor - high impact, clear metrics)
2. Map applicable lessons (T2, T3, T5 + testimony lessons)
3. Inject using methods above
4. Create before-after test scenario (static analysis with known false positives)
5. Validate improvement
6. Document results
7. Scale to remaining agents if successful

**Or**: Run decision workshop:
- Which tier to start with?
- Which metrics matter most?
- What validation approach to use?

---

**Status**: DESIGN COMPLETE, awaiting execution decision

**Decision needed**: Proceed with pilot (agent-integration-assessor) or full campaign (all 16 agents)?
