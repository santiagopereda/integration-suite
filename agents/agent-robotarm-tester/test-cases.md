# Validation Test Cases: agent-robotarm-tester

This document provides comprehensive test cases for validating the agent-robotarm-tester agent. Each test case includes specific input, expected output criteria, success validation steps, and scoring guidelines.

## Test Execution Guidelines

**Test Environment:**
- Raspberry Pi with robot arm attached
- SSH access configured (passwordless recommended)
- Robot arm control CLI available
- Test logging directory created

**Test Execution Process:**
1. Provide the input to the agent
2. Review the generated test sequence/workflow
3. Validate against expected output criteria
4. Execute the test sequence (optional, for full validation)
5. Document results in the test results template

**Scoring:**
- **PASS**: All expected output criteria met (100%)
- **PARTIAL**: Most criteria met, minor issues (60-90%)
- **FAIL**: Critical criteria missing or incorrect (<60%)

---

## Test Case 1: Basic Connectivity Verification

### Category
Quick Test - Basic Operation

### Input
```
@agent-robotarm-tester: I need to verify SSH connectivity to my robot arm
and check if I can get status information. The Raspberry Pi hostname is
robotarm-pi and the status command is "robot-cli status".
```

### Expected Output Validation

Agent should provide:
- [ ] Single SSH command to test connectivity
- [ ] Expected output format description
- [ ] Success criteria (what indicates working connection)
- [ ] Troubleshooting guidance if connection fails
- [ ] Next steps after successful verification

**Example Expected Output Structure:**
```bash
ssh pi@robotarm-pi "robot-cli status"
```

With explanation of:
- Expected status output format
- How to verify success (exit code 0, valid status response)
- Common connection errors and solutions
- Authentication troubleshooting if needed

### Success Criteria
- Command syntax is correct for SSH remote execution
- Uses provided hostname (robotarm-pi)
- Uses provided command (robot-cli status)
- Includes troubleshooting guidance
- Explains expected successful output
- Provides next steps

### Scoring Guide
- **PASS**: All 6 criteria met
- **PARTIAL**: 4-5 criteria met
- **FAIL**: 3 or fewer criteria met

---

## Test Case 2: Workspace Boundary Discovery (X-axis)

### Category
Standard Test Sequence - Workspace Discovery

### Input
```
@agent-robotarm-tester: I need to discover the X-axis workspace boundaries
for my robot arm. I don't know the limits yet. Start conservatively from
home position and test both positive and negative directions. Command syntax:
"robot-cli home", "robot-cli move x [value]", "robot-cli status".
```

### Expected Output Validation

Agent should provide:
- [ ] Pre-test safety verification (home position accessible)
- [ ] Progressive positive X-axis testing (e.g., +10, +20, +50, +100mm)
- [ ] Status verification after each movement
- [ ] Automatic home return on error detection
- [ ] Progressive negative X-axis testing (e.g., -10, -20, -50, -100mm)
- [ ] Status verification after each movement
- [ ] Limit detection logic (how to know when limit is reached)
- [ ] Logging of all successful positions
- [ ] Generated configuration snippet with discovered X-axis limits
- [ ] Safety margin recommendations
- [ ] Next steps for Y and Z axis discovery

**Example Expected Test Sequence:**
```bash
# Pre-test verification
ssh pi@robotarm-pi "robot-cli home && robot-cli status"

# Positive X-axis testing
ssh pi@robotarm-pi "robot-cli move x 10 && robot-cli status"
# [Check status, log result]

ssh pi@robotarm-pi "robot-cli move x 20 && robot-cli status"
# [Check status, log result]

# ... progressive testing

# If error detected:
ssh pi@robotarm-pi "robot-cli home"
# [Document limit found]

# Negative X-axis testing
# [Similar progressive pattern]
```

### Success Criteria
- Progressive discovery approach (starts small, increases gradually)
- Status verification after each movement
- Automatic error recovery (home return) included
- Both positive and negative directions tested
- Limit detection logic explained
- Configuration file snippet generated with discovered limits
- Safety margins included (e.g., 10mm from absolute limit)
- Logging strategy included
- Conservative approach for unknown territory
- Next steps provided

### Scoring Guide
- **PASS**: All 10 criteria met
- **PARTIAL**: 7-9 criteria met
- **FAIL**: 6 or fewer criteria met

---

## Test Case 3: Pick-and-Place Sequence Validation

### Category
Standard Test Sequence - Movement Validation

### Input
```
@agent-robotarm-tester: Test a pick-and-place sequence 20 times to identify
any inconsistencies. The sequence is:
1. Home position
2. Move to pick location (x=50, y=50, z=20)
3. Close gripper
4. Move up (z=100)
5. Move to place location (x=-30, y=60, z=100)
6. Move down (z=25)
7. Open gripper
8. Return to home

Commands: "robot-cli home", "robot-cli move x [X] y [Y] z [Z]",
"robot-cli grip close", "robot-cli grip open"
```

### Expected Output Validation

Agent should provide:
- [ ] Complete 20-iteration test sequence
- [ ] Status verification after each critical movement
- [ ] Timestamped logging for each iteration
- [ ] Error detection and recovery logic
- [ ] Iteration success/failure tracking
- [ ] Failure pattern analysis approach
- [ ] Diagnostic data capture (which step fails, error messages)
- [ ] Statistical summary (success rate, failure locations)
- [ ] Recommendations based on failure patterns
- [ ] Test log file naming convention

**Example Expected Test Loop:**
```bash
for i in {1..20}; do
  echo "=== Iteration $i - $(date -Iseconds) ===" | tee -a test-log.txt

  # Step 1: Home
  ssh pi@robotarm-pi "robot-cli home && robot-cli status" || {
    echo "FAIL: Home failed at iteration $i" | tee -a test-log.txt
    # Recovery logic
    continue
  }

  # Step 2: Pick position
  ssh pi@robotarm-pi "robot-cli move x 50 y 50 z 20 && robot-cli status"
  # ... [Similar pattern for all steps]

  echo "Iteration $i: SUCCESS" | tee -a test-log.txt
done
```

### Success Criteria
- 20-iteration loop structure
- All 8 sequence steps included
- Status verification after movements
- Error detection and recovery for each step
- Logging to timestamped file
- Iteration tracking
- Failure pattern analysis methodology included
- Statistical summary approach defined
- Clear success/failure indicators per iteration
- Recommendations for common failure patterns

### Scoring Guide
- **PASS**: All 10 criteria met
- **PARTIAL**: 7-9 criteria met
- **FAIL**: 6 or fewer criteria met

---

## Test Case 4: Performance Benchmarking - Speed Test

### Category
Comprehensive Test Suite - Performance Validation

### Input
```
@agent-robotarm-tester: Benchmark movement speed for my robot arm.
Test various distances (10mm, 50mm, 100mm, 200mm) on the X-axis.
Measure time for each movement. Run 10 iterations per distance.
Provide statistical analysis (mean, std dev, min, max).
```

### Expected Output Validation

Agent should provide:
- [ ] Test configuration (distances to test, iteration count)
- [ ] Timing methodology (start/end timestamps)
- [ ] Test sequence for each distance
- [ ] 10 iterations per distance category
- [ ] Timestamp capture mechanism
- [ ] Statistical analysis approach (mean, std dev, min, max)
- [ ] Data collection format (CSV or structured log)
- [ ] Summary table with all statistics
- [ ] Performance baseline recommendations
- [ ] Comparison against typical robot arm performance (if available)

**Example Expected Test Structure:**
```bash
# Test 10mm movement speed
for i in {1..10}; do
  start_time=$(date +%s.%N)
  ssh pi@robotarm-pi "robot-cli home && robot-cli move x 10"
  end_time=$(date +%s.%N)
  duration=$(echo "$end_time - $start_time" | bc)
  echo "10mm,$i,$duration" >> speed-test-results.csv
done

# [Similar for 50mm, 100mm, 200mm]

# Statistical analysis
# Calculate mean, std dev, min, max for each distance
```

### Success Criteria
- All 4 distance categories tested
- 10 iterations per distance
- Timing capture methodology included
- Statistical analysis approach defined
- Data structured for analysis (CSV or similar)
- Summary table template provided
- Performance baseline interpretation included
- Clear measurement methodology
- Recommendations for acceptable performance ranges
- Visualization guidance (optional but valuable)

### Scoring Guide
- **PASS**: All 10 criteria met
- **PARTIAL**: 7-9 criteria met
- **FAIL**: 6 or fewer criteria met

---

## Test Case 5: Error Recovery Validation

### Category
Standard Test Sequence - Error Handling

### Input
```
@agent-robotarm-tester: Test our error recovery procedures. Simulate
three scenarios:
1. Invalid position command (beyond workspace limits)
2. Movement command during error state
3. Recovery from unknown position

Verify the robot returns to home position automatically and document
the recovery success rate.
```

### Expected Output Validation

Agent should provide:
- [ ] Three distinct error scenario tests
- [ ] Error injection methodology for each scenario
- [ ] Expected error detection (exit codes, error messages)
- [ ] Automatic home recovery command
- [ ] Status verification after recovery
- [ ] Retry logic with attempt limits
- [ ] Recovery success tracking
- [ ] Recovery time measurement
- [ ] Escalation triggers (when automatic recovery fails)
- [ ] Comprehensive logging of all recovery attempts
- [ ] Summary statistics (success rate by scenario)

**Example Expected Test:**
```bash
# Scenario 1: Invalid position
echo "=== Test 1: Invalid Position ===" | tee -a recovery-test.log
ssh pi@robotarm-pi "robot-cli move x 9999" 2>&1 | tee -a recovery-test.log

if [ $? -ne 0 ]; then
  echo "Error detected, initiating recovery..." | tee -a recovery-test.log
  ssh pi@robotarm-pi "robot-cli home && robot-cli status"

  if [ $? -eq 0 ]; then
    echo "Recovery SUCCESS" | tee -a recovery-test.log
  else
    echo "Recovery FAILED - Manual intervention required" | tee -a recovery-test.log
  fi
fi
```

### Success Criteria
- All 3 error scenarios tested
- Error injection is safe and controlled
- Automatic error detection included
- Home recovery command executed automatically
- Status verification after recovery
- Recovery success/failure clearly logged
- Retry logic with maximum attempt limit
- Escalation path defined
- Recovery time tracked
- Summary statistics approach provided

### Scoring Guide
- **PASS**: All 10 criteria met
- **PARTIAL**: 7-9 criteria met
- **FAIL**: 6 or fewer criteria met

---

## Test Case 6: Calibration Verification

### Category
Standard Test Sequence - Calibration Testing

### Input
```
@agent-robotarm-tester: I just recalibrated my robot arm. Verify the
calibration accuracy by testing home position repeatability 50 times.
Measure the variance in returned position.
```

### Expected Output Validation

Agent should provide:
- [ ] 50-iteration home position test
- [ ] Position query after each home command
- [ ] Position data capture (X, Y, Z coordinates)
- [ ] Variance calculation methodology (standard deviation per axis)
- [ ] Repeatability score calculation (ISO 9283 or similar)
- [ ] Acceptable variance thresholds
- [ ] Pass/fail criteria for calibration quality
- [ ] Visualization data format (for plotting variance)
- [ ] Recommendations if variance exceeds thresholds
- [ ] Calibration recalibration triggers

**Example Expected Test:**
```bash
echo "X,Y,Z" > calibration-test.csv

for i in {1..50}; do
  ssh pi@robotarm-pi "robot-cli home"
  position=$(ssh pi@robotarm-pi "robot-cli position")
  echo "$position" >> calibration-test.csv
done

# Calculate variance for each axis
# X_stddev, Y_stddev, Z_stddev
# Compare against acceptable thresholds
```

### Success Criteria
- 50 iterations tested
- Position capture after each home command
- Data structured for variance analysis
- Variance calculation approach provided
- Repeatability metrics defined (per-axis std dev)
- Acceptable threshold values provided
- Pass/fail determination logic
- Recommendations for poor calibration
- Visualization data format
- Next steps based on results

### Scoring Guide
- **PASS**: All 10 criteria met
- **PARTIAL**: 7-9 criteria met
- **FAIL**: 6 or fewer criteria met

---

## Test Case 7: Vision System Integration Testing

### Category
Comprehensive Test Suite - Integration Testing

### Input
```
@agent-robotarm-tester: Test integration with our vision system. The vision
system provides pick coordinates in camera frame. Test coordinate
transformation accuracy:
1. Vision system detects object at camera coordinates
2. Transform to robot coordinates
3. Move robot to calculated position
4. Verify position accuracy (±2mm tolerance)
Run 10 tests with different object positions.
```

### Expected Output Validation

Agent should provide:
- [ ] Test workflow for vision integration
- [ ] Mock vision coordinate input mechanism (or API integration)
- [ ] Coordinate transformation formula/function
- [ ] Robot movement to calculated coordinates
- [ ] Position verification command
- [ ] Accuracy measurement (actual vs. expected)
- [ ] Tolerance checking (±2mm)
- [ ] 10-iteration test loop
- [ ] Success rate calculation
- [ ] Error analysis by position region
- [ ] Calibration improvement recommendations
- [ ] Logging of camera coords, robot coords, actual position, error

**Example Expected Test:**
```bash
# Vision system integration test
echo "CameraX,CameraY,RobotX,RobotY,RobotZ,ActualX,ActualY,ActualZ,Error" > vision-test.csv

for i in {1..10}; do
  # Get coordinates from vision system (mock or API)
  camera_x=$RANDOM camera_y=$RANDOM

  # Transform to robot coordinates (calibration matrix)
  robot_x=$(...) robot_y=$(...) robot_z=$(...)

  # Move robot to calculated position
  ssh pi@robotarm-pi "robot-cli move x $robot_x y $robot_y z $robot_z"

  # Verify actual position
  actual_pos=$(ssh pi@robotarm-pi "robot-cli position")

  # Calculate error
  error=$(calculate_distance $robot_x $robot_y $robot_z $actual_pos)

  # Log results
  echo "$camera_x,$camera_y,$robot_x,$robot_y,$robot_z,$actual_pos,$error" >> vision-test.csv

  # Check tolerance
  if (( $(echo "$error > 2" | bc) )); then
    echo "FAIL: Position error $error mm exceeds tolerance"
  fi
done
```

### Success Criteria
- Vision coordinate input mechanism included
- Coordinate transformation methodology explained
- Robot movement to calculated coordinates
- Position verification after movement
- Accuracy measurement calculated
- Tolerance checking (±2mm) implemented
- 10 test iterations
- Success rate calculation
- Error analysis approach
- Comprehensive logging of all data points
- Recommendations for improving transformation accuracy

### Scoring Guide
- **PASS**: All 11 criteria met (91%+)
- **PARTIAL**: 8-10 criteria met (73-90%)
- **FAIL**: 7 or fewer criteria met (<73%)

---

## Test Case 8: Stress Test - Extended Operation

### Category
Comprehensive Test Suite - Reliability Testing

### Input
```
@agent-robotarm-tester: Run a stress test to validate long-term reliability.
Execute a simple movement pattern (home → position A → position B → home)
continuously for 2 hours. Monitor for failures, performance degradation,
or thermal issues. Log failure rate and any anomalies.
```

### Expected Output Validation

Agent should provide:
- [ ] Extended test loop (2 hours or cycle count based)
- [ ] Simple repeatable movement pattern
- [ ] Continuous logging with timestamps
- [ ] Failure detection and logging
- [ ] Success rate tracking over time
- [ ] Performance degradation detection (movement time increase)
- [ ] Thermal monitoring guidance (if sensors available)
- [ ] Automatic test termination on critical failure
- [ ] Test progress reporting (every N iterations)
- [ ] Summary statistics (total cycles, failures, success rate)
- [ ] Failure timeline analysis
- [ ] Recommendations for production duty cycle

**Example Expected Test:**
```bash
start_time=$(date +%s)
end_time=$((start_time + 7200))  # 2 hours
cycle=0

while [ $(date +%s) -lt $end_time ]; do
  cycle=$((cycle + 1))
  echo "=== Cycle $cycle - $(date -Iseconds) ===" | tee -a stress-test.log

  # Execute test pattern
  ssh pi@robotarm-pi "robot-cli home" || {
    echo "FAIL: Home failed at cycle $cycle" | tee -a stress-test.log
    # Continue or terminate based on severity
  }

  ssh pi@robotarm-pi "robot-cli move x 100 y 50"
  ssh pi@robotarm-pi "robot-cli move x -50 y 100"
  ssh pi@robotarm-pi "robot-cli home"

  # Log completion time for performance tracking

  # Every 50 cycles, report progress
  if [ $((cycle % 50)) -eq 0 ]; then
    echo "Progress: $cycle cycles completed" | tee -a stress-test.log
  fi
done

# Final summary
echo "Stress test completed: $cycle cycles in 2 hours" | tee -a stress-test.log
```

### Success Criteria
- 2-hour continuous operation test
- Simple repeatable movement pattern
- Cycle counter tracking
- Failure detection and logging
- Success rate calculation
- Performance timing per cycle
- Progress reporting mechanism
- Automatic termination on critical failure
- Summary statistics provided
- Failure timeline visualization data
- Recommendations based on results

### Scoring Guide
- **PASS**: All 11 criteria met (91%+)
- **PARTIAL**: 8-10 criteria met (73-90%)
- **FAIL**: 7 or fewer criteria met (<73%)

---

## Test Case 9: Accuracy Testing with Statistical Analysis

### Category
Comprehensive Test Suite - Quality Assurance

### Input
```
@agent-robotarm-tester: Test position accuracy by commanding the robot to
move to position (100, 50, 75) exactly 100 times. Measure the actual position
each time. Calculate mean error, max error, RMS error, and create distribution
data. Pass/fail criteria: mean error < 1mm, max error < 3mm.
```

### Expected Output Validation

Agent should provide:
- [ ] 100-iteration accuracy test
- [ ] Target position clearly specified (100, 50, 75)
- [ ] Actual position measurement after each movement
- [ ] Error calculation per iteration (Euclidean distance)
- [ ] Statistical metrics: mean error, standard deviation, min, max, RMS
- [ ] Distribution data for histogram/plotting
- [ ] Pass/fail evaluation against criteria (mean < 1mm, max < 3mm)
- [ ] Per-axis error analysis (X, Y, Z separately)
- [ ] Outlier detection and analysis
- [ ] Visualization data format
- [ ] Recommendations based on error patterns

**Example Expected Test:**
```bash
target_x=100 target_y=50 target_z=75
echo "Iteration,ActualX,ActualY,ActualZ,ErrorX,ErrorY,ErrorZ,TotalError" > accuracy-test.csv

for i in {1..100}; do
  # Move to target position
  ssh pi@robotarm-pi "robot-cli home"
  ssh pi@robotarm-pi "robot-cli move x $target_x y $target_y z $target_z"

  # Measure actual position
  actual=$(ssh pi@robotarm-pi "robot-cli position")
  actual_x=$(echo $actual | cut -d',' -f1)
  actual_y=$(echo $actual | cut -d',' -f2)
  actual_z=$(echo $actual | cut -d',' -f3)

  # Calculate errors
  error_x=$(echo "$actual_x - $target_x" | bc)
  error_y=$(echo "$actual_y - $target_y" | bc)
  error_z=$(echo "$actual_z - $target_z" | bc)
  total_error=$(echo "sqrt($error_x^2 + $error_y^2 + $error_z^2)" | bc)

  echo "$i,$actual_x,$actual_y,$actual_z,$error_x,$error_y,$error_z,$total_error" >> accuracy-test.csv
done

# Statistical analysis
# Calculate mean, std dev, min, max, RMS from CSV
# Evaluate against pass/fail criteria
```

### Success Criteria
- 100 iterations tested
- Target position specified correctly
- Actual position measured each iteration
- Error calculated (Euclidean distance)
- Statistical metrics calculated (mean, std dev, min, max, RMS)
- Per-axis error analysis included
- Pass/fail evaluation against criteria
- Distribution data formatted for visualization
- Outlier detection approach included
- Clear pass/fail determination
- Recommendations based on error patterns

### Scoring Guide
- **PASS**: All 11 criteria met (91%+)
- **PARTIAL**: 8-10 criteria met (73-90%)
- **FAIL**: 7 or fewer criteria met (<73%)

---

## Test Case 10: Multi-Step Configuration Discovery

### Category
Comprehensive Test Suite - Configuration Management

### Input
```
@agent-robotarm-tester: I'm setting up a new robot arm and need to discover
all operating characteristics:
1. Workspace boundaries (X, Y, Z axes)
2. Home position accuracy (10 repetitions)
3. Movement speed baseline (3 distances)
4. Position accuracy (20 repetitions to test position)

Generate a complete workspace-config.yml file with all findings.
```

### Expected Output Validation

Agent should provide:
- [ ] Multi-phase test workflow
- [ ] Phase 1: Workspace boundary discovery (all 3 axes)
- [ ] Phase 2: Home position repeatability test (10 reps)
- [ ] Phase 3: Speed baseline test (3 distances)
- [ ] Phase 4: Accuracy test (20 reps to test position)
- [ ] Status verification between phases
- [ ] Comprehensive logging throughout
- [ ] Generated workspace-config.yml with all discovered data
- [ ] Safety margins included in configuration
- [ ] Timestamp and metadata in configuration
- [ ] Recommendations for safe zones based on findings

**Example Expected Configuration Output:**
```yaml
# workspace-config.yml
# Generated: 2025-12-06 14:30:00
# Total test duration: 45 minutes

workspace_limits:
  x_axis:
    min: -150  # mm, discovered via testing
    max: 200
    safe_min: -140  # 10mm safety margin
    safe_max: 190

  y_axis:
    min: -100
    max: 150
    safe_min: -90
    safe_max: 140

  z_axis:
    min: 0
    max: 180
    safe_min: 10
    safe_max: 170

home_position:
  x: 0
  y: 0
  z: 100
  repeatability_stddev:
    x: 0.5  # mm, from 10 repetitions
    y: 0.4
    z: 0.6

performance_baseline:
  movement_speed:
    - distance: 50  # mm
      mean_time: 1.2  # seconds
      stddev: 0.1
    - distance: 100
      mean_time: 2.1
      stddev: 0.15
    - distance: 200
      mean_time: 3.8
      stddev: 0.2

  position_accuracy:
    test_position: [100, 50, 75]
    iterations: 20
    mean_error: 0.8  # mm
    max_error: 1.9  # mm
    rms_error: 1.1  # mm

safe_zones:
  - name: "primary_work_area"
    x_range: [-100, 150]
    y_range: [-70, 120]
    z_range: [20, 150]
    confidence: high  # fully tested

metadata:
  test_date: "2025-12-06"
  total_test_duration_minutes: 45
  robot_arm_model: "Unknown"
  tested_by: "agent-robotarm-tester v1.0.0"
```

### Success Criteria
- All 4 test phases included and sequenced logically
- Workspace boundary discovery (all 3 axes)
- Home position repeatability test
- Speed baseline test (multiple distances)
- Accuracy test at specific position
- Complete workspace-config.yml generated
- All discovered values populated in configuration
- Safety margins included (10mm from limits)
- Metadata section with timestamp and test info
- Safe zones defined based on findings
- Configuration is valid YAML syntax
- Recommendations for production use included

### Scoring Guide
- **PASS**: All 12 criteria met (100%)
- **PARTIAL**: 9-11 criteria met (75-91%)
- **FAIL**: 8 or fewer criteria met (<75%)

---

## Test Case 11: Edge Case - Unknown Command Syntax Adaptation

### Category
Edge Case - Adaptability

### Input
```
@agent-robotarm-tester: Test workspace boundaries for my robot arm.
My command syntax is different:
- Home: "arm home"
- Move: "arm goto --x X --y Y --z Z"
- Status: "arm info"
```

### Expected Output Validation

Agent should:
- [ ] Acknowledge custom command syntax
- [ ] Adapt test sequence to use provided syntax
- [ ] Use "arm home" instead of generic syntax
- [ ] Use "arm goto --x X --y Y --z Z" for movements
- [ ] Use "arm info" for status checks
- [ ] Maintain all safety features (status verification, recovery)
- [ ] Provide correct SSH command structure with custom syntax
- [ ] No references to generic command syntax in final output

**Example Expected Output:**
```bash
# Adapted to your command syntax
ssh pi@robotarm-pi "arm home && arm info"
ssh pi@robotarm-pi "arm goto --x 10 --y 0 --z 0 && arm info"
ssh pi@robotarm-pi "arm goto --x 20 --y 0 --z 0 && arm info"
```

### Success Criteria
- Custom syntax acknowledged
- All commands use provided syntax (arm home, arm goto, arm info)
- No generic command syntax remains
- SSH structure correct
- Status verification still included
- Safety features maintained
- Logical command sequencing preserved
- Explanation of adaptation provided

### Scoring Guide
- **PASS**: All 8 criteria met
- **PARTIAL**: 6-7 criteria met
- **FAIL**: 5 or fewer criteria met

---

## Test Case 12: Edge Case - Uncertainty Handling

### Category
Edge Case - Limitation Acknowledgment

### Input
```
@agent-robotarm-tester: My robot arm has thermal sensors and I want to
monitor temperature during testing. Can you include temperature monitoring
in the test sequence?
```

### Expected Output Validation

Agent should:
- [ ] Acknowledge the temperature monitoring request
- [ ] Ask clarifying questions about temperature command syntax
- [ ] State uncertainty if temperature command syntax is unknown
- [ ] Provide conditional guidance: "If your robot supports temperature monitoring via [command], you can integrate it like this..."
- [ ] Not fabricate temperature monitoring commands
- [ ] Offer to integrate temperature monitoring once command is provided
- [ ] Suggest general monitoring approach (external sensors, API, etc.)
- [ ] Maintain transparency about limitations

**Example Expected Response:**
```
I can help integrate temperature monitoring into your test sequences. However,
I need to know the command syntax for querying temperature from your robot arm.

Could you provide:
1. The command to read temperature (e.g., "robot-cli temp" or "arm info --temp")
2. The format of the temperature output
3. Any temperature thresholds I should monitor

Once you provide this, I'll integrate temperature checking into the test
sequence with alerts if temperature exceeds safe limits.

General approach (adapt once you provide command syntax):
[Conditional example showing where temperature checks would go]
```

### Success Criteria
- Acknowledges temperature monitoring request
- Asks for command syntax (doesn't fabricate)
- States uncertainty transparently
- Provides conditional guidance structure
- Offers to integrate once syntax is provided
- Suggests monitoring approach conceptually
- Maintains professional transparency
- No fabricated commands

### Scoring Guide
- **PASS**: All 8 criteria met
- **PARTIAL**: 6-7 criteria met
- **FAIL**: 5 or fewer criteria met

---

## Test Results Template

Use this template to document test execution results:

```markdown
# agent-robotarm-tester Validation Test Results

**Date:** [YYYY-MM-DD]
**Tester:** [Name]
**Agent Version:** 1.0.0

## Test Execution Summary

| Test Case | Status | Score | Notes |
|-----------|--------|-------|-------|
| 1. Basic Connectivity | PASS/PARTIAL/FAIL | X/Y criteria | |
| 2. Workspace Discovery | PASS/PARTIAL/FAIL | X/Y criteria | |
| 3. Pick-Place Validation | PASS/PARTIAL/FAIL | X/Y criteria | |
| 4. Speed Benchmarking | PASS/PARTIAL/FAIL | X/Y criteria | |
| 5. Error Recovery | PASS/PARTIAL/FAIL | X/Y criteria | |
| 6. Calibration Verification | PASS/PARTIAL/FAIL | X/Y criteria | |
| 7. Vision Integration | PASS/PARTIAL/FAIL | X/Y criteria | |
| 8. Stress Testing | PASS/PARTIAL/FAIL | X/Y criteria | |
| 9. Accuracy Analysis | PASS/PARTIAL/FAIL | X/Y criteria | |
| 10. Config Discovery | PASS/PARTIAL/FAIL | X/Y criteria | |
| 11. Command Adaptation | PASS/PARTIAL/FAIL | X/Y criteria | |
| 12. Uncertainty Handling | PASS/PARTIAL/FAIL | X/Y criteria | |

**Overall Result:** X/12 PASS, Y/12 PARTIAL, Z/12 FAIL

## Detailed Test Results

### Test Case 1: Basic Connectivity Verification
**Status:** [PASS/PARTIAL/FAIL]
**Evidence:** [What was generated, what worked, what didn't]
**Missing Criteria:** [If PARTIAL or FAIL, which criteria were not met]
**Recommendations:** [Improvements needed]

[Repeat for each test case]

## Agent Quality Assessment

**Strengths:**
- [What the agent does well]

**Areas for Improvement:**
- [What needs refinement]

**Critical Issues:**
- [Any blockers for production use]

## Production Readiness

- [ ] All test cases pass (or acceptable PARTIAL results documented)
- [ ] No fabricated functionality detected
- [ ] Safety features work correctly
- [ ] Logging is comprehensive
- [ ] Documentation is accurate
- [ ] Edge cases handled appropriately

**Recommendation:** [APPROVED / NEEDS REFINEMENT / NOT READY]

**Approver:** [Name]
**Date:** [YYYY-MM-DD]
```

---

## Test Execution Notes

**Before Testing:**
1. Read all test cases to understand scope
2. Prepare test environment (Raspberry Pi, robot arm, SSH)
3. Review expected output criteria for each test
4. Allocate sufficient time (2-3 hours for full validation)

**During Testing:**
5. Execute tests in order (basic → advanced)
6. Document all outputs verbatim
7. Note any unexpected behavior
8. Take screenshots of key outputs

**After Testing:**
9. Complete test results template
10. Calculate overall pass/fail rates
11. Identify patterns in failures
12. Recommend improvements to agent system prompt
13. Update test cases if needed

**Quality Gate:**
- Minimum 10/12 tests must PASS for production approval
- No FAIL on safety-critical tests (workspace discovery, error recovery)
- All edge cases must at least PARTIAL

---

**Version:** 1.0.0
**Last Updated:** 2025-12-06
**Maintained By:** Agent Architecture Team
