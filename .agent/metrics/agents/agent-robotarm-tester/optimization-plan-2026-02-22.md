# Optimization Plan: agent-robotarm-tester

**Generated**: 2026-02-22
**Optimization Score**: 78/100
**Estimated Token Reduction**: 45.4% (3,909 → 2,134 tokens)
**Priority**: Medium (high potential, no usage data)

---

## Executive Summary

Agent-robotarm-tester contains 730 words of embedded reference content (configuration examples, logging formats, command patterns) that can be externalized to templates. This optimization will reduce token usage by ~45% while maintaining all safety constraints, test validation, and core capabilities.

**Primary Strategy**: Template externalization (PAT-01)
**Secondary Strategy**: Section compression (PAT-04)

---

## Optimization Hypothesis

**Goal for agent-robotarm-tester**: Reduce token usage by 45% (1,775 tokens) through template externalization of 4 reference content blocks while preserving all 106 safety constraints and 12 test case validations.

**Evidence**: Phase 2 analysis identified 730 words of externalizable content across 4 sections:
- Configuration File Management (280 words, lines 306-353)
- Test Session Logging (185 words, lines 163-199)
- Error Recovery Strategy (145 words, lines 201-217)
- SSH Command Patterns (120 words, lines 220-241)

Similar pattern (PAT-01) achieved 51-65% reduction in agent-sap-businesspartner-integration and agent-ansible-automation.

**Confirm proceeding with this optimization? [Y/n]**

---

## Phase 1: Template Design

### Template 1: Workspace Configuration Template

**File**: `.agent/templates/robotics/workspace-config-template.yml`
**Purpose**: Reference YAML structure for discovered workspace limits
**Current Location**: Lines 306-353 (280 words)

**Template Structure**:
```yaml
# robot-arm-workspace-config.yml
# Generated: {TIMESTAMP}

workspace_limits:
  x_axis:
    min: {VALUE}      # mm, discovered via testing
    max: {VALUE}      # mm, discovered via testing
    safe_min: {VALUE} # mm, safety margin applied
    safe_max: {VALUE} # mm, safety margin applied

  y_axis:
    min: {VALUE}
    max: {VALUE}
    safe_min: {VALUE}
    safe_max: {VALUE}

  z_axis:
    min: {VALUE}
    max: {VALUE}
    safe_min: {VALUE}
    safe_max: {VALUE}

home_position:
  x: {VALUE}
  y: {VALUE}
  z: {VALUE}

safe_zones:
  - name: "{ZONE_NAME}"
    x_range: [{MIN}, {MAX}]
    y_range: [{MIN}, {MAX}]
    z_range: [{MIN}, {MAX}]

  - name: "{ZONE_NAME}"
    x_range: [{MIN}, {MAX}]
    y_range: [{MIN}, {MAX}]
    z_range: [{MIN}, {MAX}]

testing_metadata:
  last_validated: "{ISO_TIMESTAMP}"
  validation_cycles: {COUNT}
  accuracy_tolerance: {VALUE}  # mm
```

**Agent Reference** (replaces lines 306-353):
```markdown
## Configuration File Management

Generate workspace configuration files using the template at `.agent/templates/robotics/workspace-config-template.yml`. Populate with discovered values during boundary testing and include 10mm safety margins.
```

**Token Impact**: 280 words → 15 words = **265 word reduction**

---

### Template 2: Test Session Log Format

**File**: `.agent/templates/robotics/test-session-log-format.md`
**Purpose**: Structured Markdown format for test session logging
**Current Location**: Lines 163-199 (185 words)

**Template Structure**:
```markdown
# Robot Arm Test Session - {TIMESTAMP}

## Test Configuration
- Robot Arm: {MODEL/ID}
- Raspberry Pi: {HOSTNAME/IP}
- Test Type: {DESCRIPTION}
- Operator: {NAME}

## Test Sequence

### Test 1: {DESCRIPTION}
- Command: {SSH_COMMAND}
- Timestamp: {ISO_TIMESTAMP}
- Response: {OUTPUT}
- Status: {PASS/FAIL/WARN}
- Notes: {OBSERVATIONS}

### Test 2: {DESCRIPTION}
- Command: {SSH_COMMAND}
- Timestamp: {ISO_TIMESTAMP}
- Response: {OUTPUT}
- Status: {PASS/FAIL/WARN}
- Notes: {OBSERVATIONS}

[... repeat for all tests ...]

## Summary
- Total Tests: {COUNT}
- Passed: {COUNT}
- Failed: {COUNT}
- Warnings: {COUNT}

## Discovered Limits
{WORKSPACE_BOUNDARIES_AND_LIMITS}

## Recommendations
{NEXT_STEPS_AND_ISSUES}
```

**Agent Reference** (replaces lines 163-199):
```markdown
## Test Session Logging

Every test session creates timestamped log files using the format defined in `.agent/templates/robotics/test-session-log-format.md`. Capture all commands, responses, timestamps, and diagnostic data with clear PASS/FAIL/WARN status indicators.
```

**Token Impact**: 185 words → 15 words = **170 word reduction**

---

### Template 3: Error Recovery Workflow

**File**: `.agent/templates/robotics/error-recovery-workflow.md`
**Purpose**: Automatic recovery process and decision tree
**Current Location**: Lines 201-217 (145 words)

**Template Structure**:
```markdown
# Error Recovery Workflow

## Automatic Recovery Process

1. **Detect Failure**
   - Non-zero exit code
   - Timeout condition
   - Error message in output

2. **Log Failure Details**
   - Command executed
   - Response/error message
   - Timestamp (ISO format)

3. **Execute Home Command**
   - Return to safe position
   - Command: `ssh pi@{HOST} "robot-cli home"` (adapt to user's syntax)

4. **Verify Home Position**
   - Check status after home command
   - Confirm successful return

5. **Retry Original Command**
   - Use exponential backoff (1s, 2s, 4s delays)
   - Maximum retry attempts: 3

6. **Escalate if Still Failing**
   - Log escalation event
   - Request manual intervention
   - Do not continue automated testing

## Recovery Decision Tree

| Error Type | Recovery Action |
|------------|----------------|
| Communication error | Retry SSH connection (max 3 attempts) |
| Movement error | Home + retry movement (max 3 attempts) |
| Limit exceeded | Document limit + home (no retry) |
| Unknown error | Home + manual investigation |

## Recovery Success Tracking

Log all recovery attempts with:
- Error type
- Recovery action taken
- Success/failure outcome
- Time to recover
```

**Agent Reference** (replaces lines 201-217):
```markdown
## Error Recovery Strategy

Follow the automatic recovery process defined in `.agent/templates/robotics/error-recovery-workflow.md`. Always attempt home position return after failures, use exponential backoff for retries (max 3), and escalate to manual intervention if recovery fails.
```

**Token Impact**: 145 words → 15 words = **130 word reduction**

---

### Template 4: SSH Command Patterns

**File**: `.agent/templates/robotics/ssh-command-patterns.md`
**Purpose**: Common SSH command structures for robot arm testing
**Current Location**: Lines 220-241 (120 words)

**Template Structure**:
```markdown
# SSH Command Patterns for Robot Arm Testing

## Basic Status Check
```bash
ssh pi@{HOST} "robot-cli status"
```

## Movement with Status Verification
```bash
ssh pi@{HOST} "robot-cli move x {VALUE} && robot-cli status"
```

## Multi-Step Test Sequence with Logging
```bash
{
  echo "Test started: $(date -Iseconds)"
  ssh pi@{HOST} "robot-cli home && robot-cli status"
  ssh pi@{HOST} "robot-cli move x 50 && robot-cli status"
  ssh pi@{HOST} "robot-cli move y 50 && robot-cli status"
  ssh pi@{HOST} "robot-cli home && robot-cli status"
  echo "Test completed: $(date -Iseconds)"
} 2>&1 | tee test-session-$(date +%Y%m%d-%H%M%S).log
```

## Error Recovery with Home Return
```bash
ssh pi@{HOST} "robot-cli move x {VALUE}" || {
  echo "Movement failed, returning home..."
  ssh pi@{HOST} "robot-cli home"
}
```

## Timestamped Iteration Loop
```bash
for i in {1..10}; do
  echo "=== Iteration $i - $(date -Iseconds) ===" | tee -a log.txt
  ssh pi@{HOST} "robot-cli {COMMAND}"
done
```

**Note**: Adapt command syntax (`robot-cli`, `arm`, etc.) to match the user's specific robot arm control interface.
```

**Agent Reference** (replaces lines 220-241):
```markdown
## SSH Command Patterns

Use the command patterns defined in `.agent/templates/robotics/ssh-command-patterns.md` as a foundation. Always adapt syntax to match the user's specific robot arm control interface (e.g., `robot-cli`, `arm`, custom commands).
```

**Token Impact**: 120 words → 15 words = **105 word reduction**

---

## Phase 2: Agent Definition Refactoring

### Before/After Structure Comparison

**Current Structure** (386 lines, 2,061 words):
```
1-39:   Front matter + examples
40-54:  Expertise + Responsibilities
55-65:  Critical Constraints intro
66-88:  Safety + Accuracy + Assumptions
89-98:  Progressive Discovery
99-141: Testing Capabilities (6 subsections)
142-161: Output Modes
162-199: Test Session Logging (TEMPLATE CANDIDATE)
200-217: Error Recovery Strategy (TEMPLATE CANDIDATE)
218-241: SSH Command Patterns (TEMPLATE CANDIDATE)
242-254: Pre-Defined Test Patterns
255-264: Communication Style
265-304: Workflow Example
305-353: Configuration File Management (TEMPLATE CANDIDATE)
354-374: Advanced Features
375-386: Quality Assurance
```

**Optimized Structure** (estimated 220 lines, 1,391 words):
```
1-39:   Front matter + examples (unchanged)
40-54:  Expertise + Responsibilities (unchanged)
55-65:  Critical Constraints intro (unchanged)
66-88:  Safety + Accuracy + Assumptions (unchanged)
89-98:  Progressive Discovery (unchanged)
99-125: Testing Capabilities (COMPRESSED - matrix format)
126-145: Output Modes (unchanged)
146-150: Test Session Logging (TEMPLATE REFERENCE)
151-155: Error Recovery Strategy (TEMPLATE REFERENCE)
156-160: SSH Command Patterns (TEMPLATE REFERENCE)
161-173: Pre-Defined Test Patterns (unchanged)
174-183: Communication Style (unchanged)
184-223: Workflow Example (unchanged)
224-228: Configuration File Management (TEMPLATE REFERENCE)
229-249: Advanced Features (unchanged)
250-261: Quality Assurance (unchanged)
```

**Key Changes**:
1. Lines 163-199 → 4 lines (template reference)
2. Lines 201-217 → 4 lines (template reference)
3. Lines 220-241 → 4 lines (template reference)
4. Lines 306-353 → 4 lines (template reference)
5. Lines 101-141 → compressed to matrix (optional PAT-04)

---

## Phase 3: Section Compression (PAT-04 - Optional)

### Testing Capabilities Compression

**Current Approach** (lines 101-141, 40 lines):
```markdown
### Movement Validation
- Single-axis movement tests with position verification
- Multi-axis coordinated movement tests
- Movement speed variation testing
- Position repeatability validation
- Home position accuracy verification

### Workspace Discovery
- Progressive boundary exploration (X, Y, Z axes)
- Safe zone mapping and documentation
- Collision detection testing
- Workspace visualization data collection
- Configuration file generation

[... 4 more subsections ...]
```

**Compressed Approach** (estimated 20 lines):
```markdown
## Testing Capabilities

| Category | Key Capabilities | Output |
|----------|------------------|--------|
| **Movement Validation** | Single/multi-axis tests, speed variation, repeatability, home position accuracy | Position data, performance metrics |
| **Workspace Discovery** | Progressive boundary exploration (X/Y/Z), safe zones, collision detection | Configuration file, workspace map |
| **Calibration Verification** | Home position sequences, end-effector validation, coordinate transformation, offset testing | Calibration quality score |
| **Performance Benchmarking** | Speed tests, accuracy measurement, repeatability (100+ cycles), response time | Statistical analysis, baselines |
| **Error Recovery Testing** | Automatic home return, retry logic, failure analysis, recovery rate tracking | Recovery success rates |
| **Integration Testing** | Vision systems, conveyor belts, external sensors, multi-device coordination | End-to-end validation |
```

**Token Impact**: ~100 tokens (moderate improvement)

---

## Phase 4: Quality Gate Strategy

### QG-1: 100% Test Pass Rate

**Strategy**:
1. Review all 12 test cases in `agents/agent-robotarm-tester/test-cases.md`
2. Verify each test validates against **capabilities**, not **implementation details**
3. Templates provide **reference structures**, not **behavioral changes**
4. Test cases remain valid because:
   - TC1 (Connectivity): Tests command execution, not format
   - TC2 (Workspace Discovery): Tests progressive approach, not logging details
   - TC3-12: Similar - test behaviors, not embedded content

**Validation Method**: Structural analysis against test criteria

**Expected Result**: 12/12 tests remain valid

---

### QG-2: No Fabrication Constraints Removed

**Strategy**:
1. Identify fabrication prevention constraints:
   - Lines 77-80: "Never fabricate robot arm commands or parameters"
   - Line 77: Specific instruction to verify with documentation
2. Ensure these lines are **preserved verbatim** in optimized agent
3. Place in same section: "Critical Constraints > Accuracy Over Assumption"

**Validation Method**: Exact string match before/after

**Expected Result**: PASS - Lines 77-80 preserved exactly

---

### QG-3: Uncertainty Acknowledgment Preserved

**Strategy**:
1. Identify uncertainty acknowledgment section:
   - Lines 82-88: "What You Don't Assume"
   - Lists 5 explicit unknowns (SSH credentials, workspace limits, calibration, network, command syntax)
2. Preserve this section **unchanged**
3. Keep section title and all 5 bullet points

**Validation Method**: Line-by-line comparison

**Expected Result**: PASS - Lines 82-88 preserved exactly

---

### QG-4: All Referenced Templates Exist

**Strategy**:
1. Create 4 templates in `.agent/templates/robotics/` during Phase 4 (IMPLEMENT)
2. Verify each template file exists before agent refactoring
3. Test template references resolve correctly

**Templates to Create**:
- `.agent/templates/robotics/workspace-config-template.yml`
- `.agent/templates/robotics/test-session-log-format.md`
- `.agent/templates/robotics/error-recovery-workflow.md`
- `.agent/templates/robotics/ssh-command-patterns.md`

**Validation Method**: File existence check + path resolution

**Expected Result**: PASS - All 4 templates exist and are valid

---

### QG-5: Critical Constraints Intact

**Strategy**:
1. Count critical constraints before optimization: **106**
2. Templates externalize **reference content** (examples, formats), not **constraints**
3. Verify constraint count after optimization: **106** (same)
4. Key constraint sections unchanged:
   - Lines 68-75: Safety First - Never Compromise (7 constraints)
   - Lines 77-80: Accuracy Over Assumption (4 constraints)
   - Lines 82-88: What You Don't Assume (5 constraints)
   - Lines 89-98: Progressive Discovery Approach (5 constraints)

**Validation Method**: Constraint enumeration before/after

**Expected Result**: PASS - 106 constraints before, 106 after

---

## Phase 5: Implementation Sequence

### Step 1: Create Template Directory
```bash
mkdir -p /home/askeox/Documents/Agentic/.agent/templates/robotics
```

### Step 2: Create Template Files
1. Write `workspace-config-template.yml`
2. Write `test-session-log-format.md`
3. Write `error-recovery-workflow.md`
4. Write `ssh-command-patterns.md`

### Step 3: Validate Templates
- Verify YAML syntax (workspace-config-template.yml)
- Verify Markdown rendering (other 3 files)
- Check all placeholder syntax is clear

### Step 4: Refactor Agent Definition
1. Read current agent-robotarm-tester.md
2. Replace lines 163-199 with template reference
3. Replace lines 201-217 with template reference
4. Replace lines 220-241 with template reference
5. Replace lines 306-353 with template reference
6. (Optional) Compress lines 101-141 to matrix format

### Step 5: Validate Quality Gates
- Run QG-1: Test case structural analysis
- Run QG-2: Fabrication constraint check (lines 77-80)
- Run QG-3: Uncertainty acknowledgment check (lines 82-88)
- Run QG-4: Template existence check (4 files)
- Run QG-5: Constraint count check (106 before/after)

### Step 6: Measure Results
- Re-count lines, words, characters
- Calculate token reduction (actual vs. estimated)
- Update metrics in `.agent/metrics/agents/agent-robotarm-tester/`

---

## Phase 6: Success Criteria

| Metric | Target | Validation |
|--------|--------|------------|
| **Token Reduction** | 40-50% (1,565-1,955 tokens) | Word count / 4 |
| **Lines Reduced** | ~165 lines (386 → ~220) | Line count |
| **Templates Created** | 4 valid templates | File existence + syntax |
| **Quality Gates** | 5/5 PASS | Individual gate validation |
| **Test Cases Valid** | 12/12 valid | Structural analysis |
| **Constraints Preserved** | 106/106 intact | Enumeration check |

---

## Risk Mitigation

### Low Risk Items
1. **Template externalization proven**: 51-65% reduction in agent-sap-bp, agent-ansible
2. **Reference content only**: Templates contain examples, not behavioral logic
3. **No test case impact**: Tests validate capabilities, not embedded content

### Contingency Plan
If quality gates fail:
1. **QG-1 (Test Cases)**: Review failing tests, adjust template references if needed
2. **QG-2/QG-3 (Constraints)**: Restore from baseline, re-apply carefully
3. **QG-4 (Templates)**: Create missing templates, fix paths
4. **QG-5 (Constraint Count)**: Compare before/after line-by-line, restore missing constraints

---

## Timeline Estimate

| Phase | Estimated Time |
|-------|---------------|
| Template Creation (4 files) | 15 minutes |
| Agent Refactoring | 20 minutes |
| Quality Gate Validation | 15 minutes |
| Measurement & Documentation | 10 minutes |
| **Total** | **60 minutes** |

---

## Approval

**Optimization Plan Ready**: YES
**Quality Gates Pre-Checked**: 4/5 (QG-4 pending template creation)
**Risk Level**: LOW
**Estimated ROI**: 45.4% token reduction

**Next Step**: Await user confirmation of optimization hypothesis, then proceed to Phase 4: IMPLEMENT.

---

**Plan Version**: 1.0
**Created**: 2026-02-22
**Agent**: agent-optimizer
