# Example: Pick-and-Place Sequence Validation with Failure Analysis

This example demonstrates a comprehensive pick-and-place validation workflow with diagnostic logging and failure pattern analysis.

## Scenario

**User Request:**
```
@agent-robotarm-tester: Our automated pick-and-place sequence works most
of the time but fails randomly about 10% of the time. I need to run it 50
times and capture detailed diagnostic data to identify the failure pattern.

Sequence:
1. Home position
2. Move to pick location (x=85, y=60, z=25)
3. Close gripper
4. Lift object (z=120)
5. Move to place location (x=-45, y=75, z=120)
6. Lower object (z=30)
7. Open gripper
8. Return to safe height (z=120)
9. Return home

Commands: "robot-cli home", "robot-cli move x X y Y z Z",
"robot-cli grip close", "robot-cli grip open", "robot-cli status"
```

## Agent Output

### Comprehensive Test Workflow

```bash
#!/bin/bash
# Pick-and-Place Sequence Validation
# 50 iterations with comprehensive diagnostic logging
# Generated: 2025-12-06 15:00:00
# Robot: XR-5000 on robotarm-pi

# Configuration
ITERATIONS=50
HOSTNAME="robotarm-pi"
LOG_DIR="pick-place-test-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$LOG_DIR"

MAIN_LOG="$LOG_DIR/test-session.log"
SUMMARY_LOG="$LOG_DIR/summary.log"
FAILURES_LOG="$LOG_DIR/failures.log"
TIMINGS_CSV="$LOG_DIR/timings.csv"

# Counters
total_tests=0
successful_tests=0
failed_tests=0

# Failure tracking by step
declare -A failures_by_step

# Initialize CSV
echo "Iteration,StartTime,EndTime,DurationSeconds,Status,FailedStep,ErrorMessage" > "$TIMINGS_CSV"

echo "=== Pick-and-Place Validation Test ===" | tee -a "$MAIN_LOG"
echo "Start time: $(date -Iseconds)" | tee -a "$MAIN_LOG"
echo "Target iterations: $ITERATIONS" | tee -a "$MAIN_LOG"
echo "Log directory: $LOG_DIR" | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"

# Test function with detailed error handling
run_pick_place_test() {
  local iteration=$1
  local start_time=$(date +%s)
  local start_time_iso=$(date -Iseconds)
  local failed_step=""
  local error_message=""

  echo "=== Iteration $iteration/$ITERATIONS - $(date -Iseconds) ===" | tee -a "$MAIN_LOG"

  # Step 1: Home position
  echo "  Step 1/9: Moving to home position..." | tee -a "$MAIN_LOG"
  output=$(ssh pi@$HOSTNAME "robot-cli home 2>&1")
  exit_code=$?

  if [ $exit_code -ne 0 ]; then
    failed_step="1_home"
    error_message="Home command failed: $output"
    echo "  ❌ FAIL: $error_message" | tee -a "$MAIN_LOG" | tee -a "$FAILURES_LOG"
    return 1
  fi

  # Verify status
  status=$(ssh pi@$HOSTNAME "robot-cli status 2>&1")
  echo "  ✓ Home position reached. Status: $status" | tee -a "$MAIN_LOG"

  # Step 2: Move to pick location
  echo "  Step 2/9: Moving to pick location (85, 60, 25)..." | tee -a "$MAIN_LOG"
  output=$(ssh pi@$HOSTNAME "robot-cli move x 85 y 60 z 25 2>&1")
  exit_code=$?

  if [ $exit_code -ne 0 ]; then
    failed_step="2_move_to_pick"
    error_message="Move to pick failed: $output"
    echo "  ❌ FAIL: $error_message" | tee -a "$MAIN_LOG" | tee -a "$FAILURES_LOG"

    # Attempt recovery
    echo "  → Attempting recovery: returning to home..." | tee -a "$MAIN_LOG"
    ssh pi@$HOSTNAME "robot-cli home"
    return 1
  fi

  status=$(ssh pi@$HOSTNAME "robot-cli status 2>&1")
  echo "  ✓ Pick location reached. Status: $status" | tee -a "$MAIN_LOG"

  # Step 3: Close gripper
  echo "  Step 3/9: Closing gripper..." | tee -a "$MAIN_LOG"
  output=$(ssh pi@$HOSTNAME "robot-cli grip close 2>&1")
  exit_code=$?

  if [ $exit_code -ne 0 ]; then
    failed_step="3_grip_close"
    error_message="Gripper close failed: $output"
    echo "  ❌ FAIL: $error_message" | tee -a "$MAIN_LOG" | tee -a "$FAILURES_LOG"

    ssh pi@$HOSTNAME "robot-cli home"
    return 1
  fi

  echo "  ✓ Gripper closed" | tee -a "$MAIN_LOG"
  sleep 0.5  # Allow gripper to settle

  # Step 4: Lift object
  echo "  Step 4/9: Lifting object to z=120..." | tee -a "$MAIN_LOG"
  output=$(ssh pi@$HOSTNAME "robot-cli move z 120 2>&1")
  exit_code=$?

  if [ $exit_code -ne 0 ]; then
    failed_step="4_lift"
    error_message="Lift failed: $output"
    echo "  ❌ FAIL: $error_message" | tee -a "$MAIN_LOG" | tee -a "$FAILURES_LOG"

    ssh pi@$HOSTNAME "robot-cli grip open"
    ssh pi@$HOSTNAME "robot-cli home"
    return 1
  fi

  status=$(ssh pi@$HOSTNAME "robot-cli status 2>&1")
  echo "  ✓ Object lifted. Status: $status" | tee -a "$MAIN_LOG"

  # Step 5: Move to place location
  echo "  Step 5/9: Moving to place location (-45, 75, 120)..." | tee -a "$MAIN_LOG"
  output=$(ssh pi@$HOSTNAME "robot-cli move x -45 y 75 z 120 2>&1")
  exit_code=$?

  if [ $exit_code -ne 0 ]; then
    failed_step="5_move_to_place"
    error_message="Move to place failed: $output"
    echo "  ❌ FAIL: $error_message" | tee -a "$MAIN_LOG" | tee -a "$FAILURES_LOG"

    ssh pi@$HOSTNAME "robot-cli grip open"
    ssh pi@$HOSTNAME "robot-cli home"
    return 1
  fi

  status=$(ssh pi@$HOSTNAME "robot-cli status 2>&1")
  echo "  ✓ Place location reached. Status: $status" | tee -a "$MAIN_LOG"

  # Step 6: Lower object
  echo "  Step 6/9: Lowering object to z=30..." | tee -a "$MAIN_LOG"
  output=$(ssh pi@$HOSTNAME "robot-cli move z 30 2>&1")
  exit_code=$?

  if [ $exit_code -ne 0 ]; then
    failed_step="6_lower"
    error_message="Lower failed: $output"
    echo "  ❌ FAIL: $error_message" | tee -a "$MAIN_LOG" | tee -a "$FAILURES_LOG"

    ssh pi@$HOSTNAME "robot-cli move z 120"
    ssh pi@$HOSTNAME "robot-cli grip open"
    ssh pi@$HOSTNAME "robot-cli home"
    return 1
  fi

  status=$(ssh pi@$HOSTNAME "robot-cli status 2>&1")
  echo "  ✓ Object lowered. Status: $status" | tee -a "$MAIN_LOG"

  # Step 7: Open gripper
  echo "  Step 7/9: Opening gripper..." | tee -a "$MAIN_LOG"
  output=$(ssh pi@$HOSTNAME "robot-cli grip open 2>&1")
  exit_code=$?

  if [ $exit_code -ne 0 ]; then
    failed_step="7_grip_open"
    error_message="Gripper open failed: $output"
    echo "  ❌ FAIL: $error_message" | tee -a "$MAIN_LOG" | tee -a "$FAILURES_LOG"

    ssh pi@$HOSTNAME "robot-cli move z 120"
    ssh pi@$HOSTNAME "robot-cli home"
    return 1
  fi

  echo "  ✓ Gripper opened" | tee -a "$MAIN_LOG"
  sleep 0.5

  # Step 8: Return to safe height
  echo "  Step 8/9: Returning to safe height z=120..." | tee -a "$MAIN_LOG"
  output=$(ssh pi@$HOSTNAME "robot-cli move z 120 2>&1")
  exit_code=$?

  if [ $exit_code -ne 0 ]; then
    failed_step="8_safe_height"
    error_message="Return to safe height failed: $output"
    echo "  ❌ FAIL: $error_message" | tee -a "$MAIN_LOG" | tee -a "$FAILURES_LOG"

    ssh pi@$HOSTNAME "robot-cli home"
    return 1
  fi

  echo "  ✓ Safe height reached" | tee -a "$MAIN_LOG"

  # Step 9: Return home
  echo "  Step 9/9: Returning to home position..." | tee -a "$MAIN_LOG"
  output=$(ssh pi@$HOSTNAME "robot-cli home 2>&1")
  exit_code=$?

  if [ $exit_code -ne 0 ]; then
    failed_step="9_return_home"
    error_message="Return home failed: $output"
    echo "  ❌ FAIL: $error_message" | tee -a "$MAIN_LOG" | tee -a "$FAILURES_LOG"
    return 1
  fi

  status=$(ssh pi@$HOSTNAME "robot-cli status 2>&1")
  echo "  ✓ Home position reached. Status: $status" | tee -a "$MAIN_LOG"

  # Calculate duration
  local end_time=$(date +%s)
  local end_time_iso=$(date -Iseconds)
  local duration=$((end_time - start_time))

  echo "  ✅ SUCCESS: Iteration $iteration completed in ${duration}s" | tee -a "$MAIN_LOG"
  echo "$iteration,$start_time_iso,$end_time_iso,$duration,SUCCESS,N/A,N/A" >> "$TIMINGS_CSV"

  return 0
}

# Main test loop
for i in $(seq 1 $ITERATIONS); do
  total_tests=$((total_tests + 1))

  if run_pick_place_test $i; then
    successful_tests=$((successful_tests + 1))
  else
    failed_tests=$((failed_tests + 1))

    # Track failure by step
    if [ -n "$failed_step" ]; then
      failures_by_step[$failed_step]=$((${failures_by_step[$failed_step]:-0} + 1))
      echo "$i,$(date -Iseconds),N/A,N/A,FAIL,$failed_step,$error_message" >> "$TIMINGS_CSV"
    fi
  fi

  # Progress indicator every 10 iterations
  if [ $((i % 10)) -eq 0 ]; then
    success_rate=$(echo "scale=1; $successful_tests * 100 / $total_tests" | bc)
    echo "" | tee -a "$MAIN_LOG"
    echo "--- Progress: $i/$ITERATIONS complete ($success_rate% success rate) ---" | tee -a "$MAIN_LOG"
    echo "" | tee -a "$MAIN_LOG"
  fi

  # Small delay between tests
  sleep 1
done

# Generate summary report
echo "" | tee -a "$MAIN_LOG"
echo "========================================" | tee -a "$MAIN_LOG"
echo "      TEST SUMMARY REPORT" | tee -a "$MAIN_LOG"
echo "========================================" | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"
echo "Total iterations:    $total_tests" | tee -a "$MAIN_LOG"
echo "Successful:          $successful_tests" | tee -a "$MAIN_LOG"
echo "Failed:              $failed_tests" | tee -a "$MAIN_LOG"

if [ $total_tests -gt 0 ]; then
  success_rate=$(echo "scale=2; $successful_tests * 100 / $total_tests" | bc)
  failure_rate=$(echo "scale=2; $failed_tests * 100 / $total_tests" | bc)
  echo "Success rate:        $success_rate%" | tee -a "$MAIN_LOG"
  echo "Failure rate:        $failure_rate%" | tee -a "$MAIN_LOG"
fi

echo "" | tee -a "$MAIN_LOG"
echo "Failures by step:" | tee -a "$MAIN_LOG"

if [ $failed_tests -gt 0 ]; then
  for step in "${!failures_by_step[@]}"; do
    count=${failures_by_step[$step]}
    percentage=$(echo "scale=1; $count * 100 / $failed_tests" | bc)
    echo "  $step: $count failures ($percentage% of all failures)" | tee -a "$MAIN_LOG"
  done
else
  echo "  No failures detected!" | tee -a "$MAIN_LOG"
fi

echo "" | tee -a "$MAIN_LOG"
echo "End time: $(date -Iseconds)" | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"
echo "Logs saved to: $LOG_DIR" | tee -a "$MAIN_LOG"
echo "  - Main log: $MAIN_LOG" | tee -a "$MAIN_LOG"
echo "  - Failures: $FAILURES_LOG" | tee -a "$MAIN_LOG"
echo "  - Timings:  $TIMINGS_CSV" | tee -a "$MAIN_LOG"

# Save summary to dedicated file
cp "$MAIN_LOG" "$SUMMARY_LOG"

echo ""
echo "Test complete! Review logs in $LOG_DIR"
```

---

## Expected Output Example

```
=== Pick-and-Place Validation Test ===
Start time: 2025-12-06T15:00:00-05:00
Target iterations: 50
Log directory: pick-place-test-20251206-150000

=== Iteration 1/50 - 2025-12-06T15:00:01-05:00 ===
  Step 1/9: Moving to home position...
  ✓ Home position reached. Status: X=0, Y=0, Z=100
  Step 2/9: Moving to pick location (85, 60, 25)...
  ✓ Pick location reached. Status: X=85, Y=60, Z=25
  Step 3/9: Closing gripper...
  ✓ Gripper closed
  Step 4/9: Lifting object to z=120...
  ✓ Object lifted. Status: X=85, Y=60, Z=120
  Step 5/9: Moving to place location (-45, 75, 120)...
  ✓ Place location reached. Status: X=-45, Y=75, Z=120
  Step 6/9: Lowering object to z=30...
  ✓ Object lowered. Status: X=-45, Y=75, Z=30
  Step 7/9: Opening gripper...
  ✓ Gripper opened
  Step 8/9: Returning to safe height z=120...
  ✓ Safe height reached
  Step 9/9: Returning to home position...
  ✓ Home position reached. Status: X=0, Y=0, Z=100
  ✅ SUCCESS: Iteration 1 completed in 12s

[... iterations 2-9 ...]

=== Iteration 10/50 - 2025-12-06T15:02:15-05:00 ===
  Step 1/9: Moving to home position...
  ✓ Home position reached. Status: X=0, Y=0, Z=100
  Step 2/9: Moving to pick location (85, 60, 25)...
  ✓ Pick location reached. Status: X=85, Y=60, Z=25
  Step 3/9: Closing gripper...
  ❌ FAIL: Gripper close failed: Error: Gripper timeout
  → Attempting recovery: returning to home...

--- Progress: 10/50 complete (90.0% success rate) ---

[... more iterations ...]

=== Iteration 23/50 - 2025-12-06T15:05:48-05:00 ===
  Step 1/9: Moving to home position...
  ✓ Home position reached. Status: X=0, Y=0, Z=100
  Step 2/9: Moving to pick location (85, 60, 25)...
  ✓ Pick location reached. Status: X=85, Y=60, Z=25
  Step 3/9: Closing gripper...
  ✓ Gripper closed
  Step 4/9: Lifting object to z=120...
  ❌ FAIL: Lift failed: Error: Position unreachable
  → Attempting recovery: returning to home...

[... remaining iterations ...]

========================================
      TEST SUMMARY REPORT
========================================

Total iterations:    50
Successful:          45
Failed:              5
Success rate:        90.00%
Failure rate:        10.00%

Failures by step:
  3_grip_close: 3 failures (60.0% of all failures)
  4_lift: 2 failures (40.0% of all failures)

End time: 2025-12-06T15:10:32-05:00

Logs saved to: pick-place-test-20251206-150000
  - Main log: pick-place-test-20251206-150000/test-session.log
  - Failures: pick-place-test-20251206-150000/failures.log
  - Timings:  pick-place-test-20251206-150000/timings.csv

Test complete! Review logs in pick-place-test-20251206-150000
```

---

## Failure Pattern Analysis

Based on the test results, the agent provides analysis:

### Generated Analysis Report

```markdown
# Pick-and-Place Failure Analysis
Generated: 2025-12-06 15:11:00

## Test Overview
- **Total Iterations**: 50
- **Success Rate**: 90.0%
- **Failure Rate**: 10.0%
- **Total Failures**: 5

## Failure Distribution

| Step | Failures | % of Total Failures |
|------|----------|---------------------|
| 3_grip_close | 3 | 60% |
| 4_lift | 2 | 40% |

## Detailed Findings

### Primary Issue: Gripper Timeout (60% of failures)

**Symptoms:**
- Gripper close command times out intermittently
- Occurs at Step 3 (after reaching pick position)
- Error message: "Gripper timeout"

**Possible Root Causes:**
1. **Gripper mechanical issue**: Intermittent jam or obstruction
2. **Gripper controller communication**: Timeout in gripper control signal
3. **Object position variation**: Object not consistently in graspable position
4. **Gripper calibration**: Gripper sensors may need recalibration

**Recommendations:**
1. Inspect gripper mechanism for obstructions or wear
2. Add gripper status check before close command
3. Increase gripper timeout setting if configurable
4. Add object detection verification before gripper close
5. Test gripper in isolation to rule out mechanical failure

### Secondary Issue: Lift Position Unreachable (40% of failures)

**Symptoms:**
- Lift command fails after gripper closes
- Error message: "Position unreachable"
- Occurs at Step 4 (lifting to z=120)

**Possible Root Causes:**
1. **Object weight**: Object may be too heavy, exceeding lift capacity
2. **Gripper grip failure**: Object not securely gripped, detected during lift
3. **Collision detection**: Robot detects potential collision during lift
4. **Workspace limit**: Z=120 may be near workspace boundary at (x=85, y=60)

**Recommendations:**
1. Verify object weight is within robot specifications
2. Add grip verification after gripper close (force sensor check)
3. Test Z=120 position at (x=85, y=60) without object
4. Review workspace limits at pick location coordinates
5. Consider reducing lift height to z=100 as test

## Timing Analysis

**Average Duration (Successful Tests):**
- Mean: 12.3 seconds
- Std Dev: 0.8 seconds
- Min: 11.2 seconds
- Max: 14.1 seconds

**Duration Consistency:**
- Low variation indicates consistent movement performance
- No performance degradation over 50 cycles
- Failures occur quickly (within 3-5 seconds of start)

## Recommended Next Steps

### Immediate Actions
1. **Gripper Inspection**
   - Physically inspect gripper mechanism
   - Test gripper open/close 100 times in isolation
   - Check gripper controller logs for errors

2. **Workspace Validation**
   - Verify Z=120 is achievable at (x=85, y=60)
   - Test lift movement without object
   - Review workspace-config.yml for limits

3. **Object Setup**
   - Verify object position consistency at pick location
   - Confirm object weight is within specifications
   - Test with different object positions

### Testing Recommendations
1. **Isolated Gripper Test**: Run 100 open/close cycles at pick position
2. **Lift Test**: Test lift movement from pick position without gripper close
3. **Weight Test**: Test with lighter object to isolate weight factor
4. **Position Test**: Test pick sequence at slightly different Z height

### Configuration Updates
Consider these workspace-config.yml updates:

```yaml
# Add to workspace-config.yml
known_issues:
  - issue: "Gripper timeout at pick location"
    frequency: "3/50 tests (6%)"
    coordinates: {x: 85, y: 60, z: 25}
    recommended_action: "Inspect gripper mechanism"

  - issue: "Lift position unreachable"
    frequency: "2/50 tests (4%)"
    coordinates: {x: 85, y: 60, z: 120}
    recommended_action: "Verify workspace limits at pick location"

testing_notes:
  - "Pick-and-place success rate: 90% (2025-12-06)"
  - "Primary failure mode: Gripper timeout (60% of failures)"
  - "Secondary failure mode: Lift unreachable (40% of failures)"
```

## Success Criteria for Resolution

Re-test with same parameters. Success criteria:
- Success rate ≥ 98% (49/50 or better)
- No gripper timeout errors
- No position unreachable errors
- Consistent timing (std dev < 1.0 second)

If criteria met, proceed to production validation.
```

---

## Generated Test Artifacts

**Files created in test directory:**

```
pick-place-test-20251206-150000/
├── test-session.log          # Complete test execution log
├── summary.log               # Summary report copy
├── failures.log              # All failure messages
├── timings.csv              # Structured timing data
└── analysis-report.md       # Failure pattern analysis (above)
```

**timings.csv format:**
```csv
Iteration,StartTime,EndTime,DurationSeconds,Status,FailedStep,ErrorMessage
1,2025-12-06T15:00:01-05:00,2025-12-06T15:00:13-05:00,12,SUCCESS,N/A,N/A
2,2025-12-06T15:00:14-05:00,2025-12-06T15:00:26-05:00,12,SUCCESS,N/A,N/A
...
10,2025-12-06T15:02:15-05:00,N/A,N/A,FAIL,3_grip_close,Gripper timeout
...
```

---

## Usage Instructions

1. **Save the test script** as `pick-place-validation.sh`

2. **Make it executable:**
   ```bash
   chmod +x pick-place-validation.sh
   ```

3. **Execute the test:**
   ```bash
   ./pick-place-validation.sh
   ```

4. **Monitor progress** in real-time:
   ```bash
   tail -f pick-place-test-*/test-session.log
   ```

5. **Review results** after completion:
   ```bash
   cat pick-place-test-*/summary.log
   ```

6. **Analyze failures:**
   ```bash
   cat pick-place-test-*/failures.log
   cat pick-place-test-*/analysis-report.md
   ```

7. **Import timing data** for statistical analysis:
   ```bash
   # Use Excel, Python pandas, or R to analyze timings.csv
   ```

---

## Next Steps

After identifying failure patterns:

1. **Address root causes** (gripper inspection, workspace validation)
2. **Re-run test** with same parameters
3. **Compare results** to validate improvements
4. **Update workspace-config.yml** with findings
5. **Document resolution** in project knowledge base

---

**Example Generated By:** agent-robotarm-tester v1.0.0
**Date:** 2025-12-06
**Scenario:** Pick-and-place validation with failure pattern analysis
