# Example: Performance Benchmarking Suite

This example demonstrates a comprehensive performance benchmarking workflow including speed tests, accuracy validation, and statistical analysis.

## Scenario

**User Request:**
```
@agent-robotarm-tester: I need to benchmark my robot arm's performance
before production deployment. Test:
1. Movement speed at various distances (25mm, 50mm, 100mm, 200mm)
2. Position accuracy (move to test position 100 times, measure error)
3. Repeatability (home position, 50 cycles)

Generate statistical analysis and pass/fail evaluation.

Specifications:
- Mean speed: ≥ 50 mm/s
- Position accuracy: mean error < 1mm, max error < 3mm
- Repeatability: std dev < 0.5mm per axis

Commands: "robot-cli home", "robot-cli move x X y Y z Z", "robot-cli position"
```

## Agent Output

### Complete Benchmarking Suite

```bash
#!/bin/bash
# Robot Arm Performance Benchmarking Suite
# Generated: 2025-12-06 16:00:00
# Robot: XR-5000 on robotarm-pi

HOSTNAME="robotarm-pi"
BENCHMARK_DIR="performance-benchmark-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BENCHMARK_DIR"

MAIN_LOG="$BENCHMARK_DIR/benchmark-session.log"
SPEED_CSV="$BENCHMARK_DIR/speed-test-results.csv"
ACCURACY_CSV="$BENCHMARK_DIR/accuracy-test-results.csv"
REPEATABILITY_CSV="$BENCHMARK_DIR/repeatability-test-results.csv"
REPORT="$BENCHMARK_DIR/performance-report.md"

echo "=== Robot Arm Performance Benchmarking ===" | tee -a "$MAIN_LOG"
echo "Start time: $(date -Iseconds)" | tee -a "$MAIN_LOG"
echo "Benchmark directory: $BENCHMARK_DIR" | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"

# ============================================================================
# TEST 1: MOVEMENT SPEED BENCHMARKING
# ============================================================================

echo "========================================" | tee -a "$MAIN_LOG"
echo "TEST 1: MOVEMENT SPEED BENCHMARKING" | tee -a "$MAIN_LOG"
echo "========================================" | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"

# Initialize CSV
echo "Distance_mm,Iteration,StartTime,EndTime,DurationSeconds,Speed_mm_per_s" > "$SPEED_CSV"

# Test distances
distances=(25 50 100 200)
iterations_per_distance=10

for distance in "${distances[@]}"; do
  echo "Testing movement speed for ${distance}mm distance (${iterations_per_distance} iterations)..." | tee -a "$MAIN_LOG"

  for i in $(seq 1 $iterations_per_distance); do
    # Return to home
    ssh pi@$HOSTNAME "robot-cli home" > /dev/null 2>&1

    # Measure movement time
    start_time=$(date +%s.%N)
    start_time_iso=$(date -Iseconds)

    ssh pi@$HOSTNAME "robot-cli move x $distance" > /dev/null 2>&1

    end_time=$(date +%s.%N)
    end_time_iso=$(date -Iseconds)

    # Calculate duration and speed
    duration=$(echo "$end_time - $start_time" | bc -l)
    speed=$(echo "scale=2; $distance / $duration" | bc -l)

    echo "$distance,$i,$start_time_iso,$end_time_iso,$duration,$speed" >> "$SPEED_CSV"

    echo "  Iteration $i: ${duration}s (${speed} mm/s)" | tee -a "$MAIN_LOG"
  done

  echo "" | tee -a "$MAIN_LOG"
done

echo "Speed testing complete." | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"

# ============================================================================
# TEST 2: POSITION ACCURACY TESTING
# ============================================================================

echo "========================================" | tee -a "$MAIN_LOG"
echo "TEST 2: POSITION ACCURACY TESTING" | tee -a "$MAIN_LOG"
echo "========================================" | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"

# Test position
target_x=100
target_y=50
target_z=75
accuracy_iterations=100

echo "Target position: ($target_x, $target_y, $target_z)" | tee -a "$MAIN_LOG"
echo "Iterations: $accuracy_iterations" | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"

# Initialize CSV
echo "Iteration,TargetX,TargetY,TargetZ,ActualX,ActualY,ActualZ,ErrorX,ErrorY,ErrorZ,TotalError" > "$ACCURACY_CSV"

for i in $(seq 1 $accuracy_iterations); do
  # Return to home
  ssh pi@$HOSTNAME "robot-cli home" > /dev/null 2>&1

  # Move to target position
  ssh pi@$HOSTNAME "robot-cli move x $target_x y $target_y z $target_z" > /dev/null 2>&1

  # Query actual position
  position_output=$(ssh pi@$HOSTNAME "robot-cli position")

  # Parse position (assuming format: "X=100.2, Y=50.1, Z=74.9")
  actual_x=$(echo "$position_output" | grep -oP 'X=\K[0-9.-]+')
  actual_y=$(echo "$position_output" | grep -oP 'Y=\K[0-9.-]+')
  actual_z=$(echo "$position_output" | grep -oP 'Z=\K[0-9.-]+')

  # Calculate errors
  error_x=$(echo "$actual_x - $target_x" | bc -l)
  error_y=$(echo "$actual_y - $target_y" | bc -l)
  error_z=$(echo "$actual_z - $target_z" | bc -l)

  # Calculate total Euclidean error
  total_error=$(echo "sqrt(($error_x)^2 + ($error_y)^2 + ($error_z)^2)" | bc -l)

  echo "$i,$target_x,$target_y,$target_z,$actual_x,$actual_y,$actual_z,$error_x,$error_y,$error_z,$total_error" >> "$ACCURACY_CSV"

  # Progress indicator every 20 iterations
  if [ $((i % 20)) -eq 0 ]; then
    echo "  Progress: $i/$accuracy_iterations iterations complete" | tee -a "$MAIN_LOG"
  fi
done

echo "" | tee -a "$MAIN_LOG"
echo "Accuracy testing complete." | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"

# ============================================================================
# TEST 3: REPEATABILITY TESTING (HOME POSITION)
# ============================================================================

echo "========================================" | tee -a "$MAIN_LOG"
echo "TEST 3: REPEATABILITY TESTING" | tee -a "$MAIN_LOG"
echo "========================================" | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"

repeatability_iterations=50

echo "Testing home position repeatability (${repeatability_iterations} cycles)..." | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"

# Initialize CSV
echo "Iteration,X,Y,Z" > "$REPEATABILITY_CSV"

for i in $(seq 1 $repeatability_iterations); do
  # Move away from home first
  ssh pi@$HOSTNAME "robot-cli move x 50 y 50 z 50" > /dev/null 2>&1

  # Return to home
  ssh pi@$HOSTNAME "robot-cli home" > /dev/null 2>&1

  # Query position
  position_output=$(ssh pi@$HOSTNAME "robot-cli position")

  # Parse position
  home_x=$(echo "$position_output" | grep -oP 'X=\K[0-9.-]+')
  home_y=$(echo "$position_output" | grep -oP 'Y=\K[0-9.-]+')
  home_z=$(echo "$position_output" | grep -oP 'Z=\K[0-9.-]+')

  echo "$i,$home_x,$home_y,$home_z" >> "$REPEATABILITY_CSV"

  # Progress indicator
  if [ $((i % 10)) -eq 0 ]; then
    echo "  Progress: $i/$repeatability_iterations cycles complete" | tee -a "$MAIN_LOG"
  fi
done

echo "" | tee -a "$MAIN_LOG"
echo "Repeatability testing complete." | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"

# ============================================================================
# STATISTICAL ANALYSIS
# ============================================================================

echo "========================================" | tee -a "$MAIN_LOG"
echo "GENERATING STATISTICAL ANALYSIS" | tee -a "$MAIN_LOG"
echo "========================================" | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"

# Create Python analysis script
cat > "$BENCHMARK_DIR/analyze.py" << 'PYTHON_SCRIPT'
import pandas as pd
import numpy as np
import sys

# Read data
speed_df = pd.read_csv('speed-test-results.csv')
accuracy_df = pd.read_csv('accuracy-test-results.csv')
repeatability_df = pd.read_csv('repeatability-test-results.csv')

# ============================================================================
# SPEED ANALYSIS
# ============================================================================

print("=" * 60)
print("SPEED TEST ANALYSIS")
print("=" * 60)
print()

speed_stats = speed_df.groupby('Distance_mm')['Speed_mm_per_s'].agg([
    ('Mean', 'mean'),
    ('StdDev', 'std'),
    ('Min', 'min'),
    ('Max', 'max')
])

print("Speed Statistics by Distance:")
print(speed_stats.to_string())
print()

# Check specification: ≥ 50 mm/s
overall_mean_speed = speed_df['Speed_mm_per_s'].mean()
print(f"Overall Mean Speed: {overall_mean_speed:.2f} mm/s")
print(f"Specification: ≥ 50 mm/s")
if overall_mean_speed >= 50:
    print("✓ PASS: Speed meets specification")
    speed_pass = True
else:
    print("✗ FAIL: Speed below specification")
    speed_pass = False
print()

# ============================================================================
# ACCURACY ANALYSIS
# ============================================================================

print("=" * 60)
print("ACCURACY TEST ANALYSIS")
print("=" * 60)
print()

# Overall accuracy statistics
mean_error = accuracy_df['TotalError'].mean()
max_error = accuracy_df['TotalError'].max()
min_error = accuracy_df['TotalError'].min()
std_error = accuracy_df['TotalError'].std()

# RMS error
rms_error = np.sqrt(np.mean(accuracy_df['TotalError']**2))

print(f"Total Error Statistics:")
print(f"  Mean Error:   {mean_error:.3f} mm")
print(f"  Max Error:    {max_error:.3f} mm")
print(f"  Min Error:    {min_error:.3f} mm")
print(f"  Std Dev:      {std_error:.3f} mm")
print(f"  RMS Error:    {rms_error:.3f} mm")
print()

# Per-axis error
print("Per-Axis Error Statistics:")
for axis in ['ErrorX', 'ErrorY', 'ErrorZ']:
    axis_name = axis.replace('Error', '')
    mean_axis_error = accuracy_df[axis].abs().mean()
    max_axis_error = accuracy_df[axis].abs().max()
    std_axis_error = accuracy_df[axis].std()
    print(f"  {axis_name}-axis: Mean={mean_axis_error:.3f}mm, Max={max_axis_error:.3f}mm, StdDev={std_axis_error:.3f}mm")
print()

# Check specification: mean error < 1mm, max error < 3mm
print("Specification Check:")
print(f"  Mean Error < 1mm: {mean_error:.3f} mm", end=" ")
if mean_error < 1.0:
    print("✓ PASS")
    accuracy_mean_pass = True
else:
    print("✗ FAIL")
    accuracy_mean_pass = False

print(f"  Max Error < 3mm:  {max_error:.3f} mm", end=" ")
if max_error < 3.0:
    print("✓ PASS")
    accuracy_max_pass = True
else:
    print("✗ FAIL")
    accuracy_max_pass = False

accuracy_pass = accuracy_mean_pass and accuracy_max_pass
print()

# ============================================================================
# REPEATABILITY ANALYSIS
# ============================================================================

print("=" * 60)
print("REPEATABILITY TEST ANALYSIS")
print("=" * 60)
print()

# Calculate statistics per axis
print("Home Position Repeatability:")
for axis in ['X', 'Y', 'Z']:
    mean_pos = repeatability_df[axis].mean()
    std_pos = repeatability_df[axis].std()
    min_pos = repeatability_df[axis].min()
    max_pos = repeatability_df[axis].max()
    range_pos = max_pos - min_pos

    print(f"  {axis}-axis: Mean={mean_pos:.3f}mm, StdDev={std_pos:.3f}mm, Range={range_pos:.3f}mm")

    # Check specification: std dev < 0.5mm
    print(f"    Specification (StdDev < 0.5mm): {std_pos:.3f} mm", end=" ")
    if std_pos < 0.5:
        print("✓ PASS")
    else:
        print("✗ FAIL")

# Overall repeatability pass/fail
repeatability_pass = all([
    repeatability_df['X'].std() < 0.5,
    repeatability_df['Y'].std() < 0.5,
    repeatability_df['Z'].std() < 0.5
])

print()

# ============================================================================
# OVERALL SUMMARY
# ============================================================================

print("=" * 60)
print("OVERALL PERFORMANCE SUMMARY")
print("=" * 60)
print()

print("Test Results:")
print(f"  Speed Test:        {'PASS ✓' if speed_pass else 'FAIL ✗'}")
print(f"  Accuracy Test:     {'PASS ✓' if accuracy_pass else 'FAIL ✗'}")
print(f"  Repeatability Test: {'PASS ✓' if repeatability_pass else 'FAIL ✗'}")
print()

if speed_pass and accuracy_pass and repeatability_pass:
    print("OVERALL RESULT: ✓ PASS - Robot arm meets all performance specifications")
    sys.exit(0)
else:
    print("OVERALL RESULT: ✗ FAIL - Robot arm does not meet all performance specifications")
    sys.exit(1)
PYTHON_SCRIPT

# Run Python analysis
cd "$BENCHMARK_DIR"
python3 analyze.py 2>&1 | tee -a "../$MAIN_LOG"
analysis_exit_code=$?
cd ..

# ============================================================================
# GENERATE MARKDOWN REPORT
# ============================================================================

echo "" | tee -a "$MAIN_LOG"
echo "Generating performance report..." | tee -a "$MAIN_LOG"

cat > "$REPORT" << EOF
# Robot Arm Performance Benchmark Report

**Generated:** $(date -Iseconds)
**Robot Model:** XR-5000
**Raspberry Pi:** $HOSTNAME
**Test Duration:** $(date -d@$SECONDS -u +%H:%M:%S)

---

## Executive Summary

This report presents comprehensive performance benchmarking results including movement speed, position accuracy, and home position repeatability testing.

### Overall Results

| Test Category | Result | Status |
|---------------|--------|--------|
| Speed Test | See detailed results | $([ $analysis_exit_code -eq 0 ] && echo "✓ PASS" || echo "See details") |
| Accuracy Test | See detailed results | $([ $analysis_exit_code -eq 0 ] && echo "✓ PASS" || echo "See details") |
| Repeatability Test | See detailed results | $([ $analysis_exit_code -eq 0 ] && echo "✓ PASS" || echo "See details") |

**Overall Assessment:** $([ $analysis_exit_code -eq 0 ] && echo "✓ PASS - Robot arm meets all specifications" || echo "✗ FAIL - Review detailed results")

---

## Test 1: Movement Speed Benchmarking

### Test Configuration
- **Distances Tested:** 25mm, 50mm, 100mm, 200mm
- **Iterations per Distance:** 10
- **Total Tests:** 40
- **Specification:** Mean speed ≥ 50 mm/s

### Results

Speed statistics are calculated from actual movement timing data. See \`speed-test-results.csv\` for raw data.

**Performance Summary:**
- Comprehensive speed data across multiple distances
- Statistical analysis includes mean, std dev, min, max per distance
- Overall mean speed compared against specification

### Data Files
- Raw data: \`speed-test-results.csv\`
- Format: Distance_mm, Iteration, StartTime, EndTime, DurationSeconds, Speed_mm_per_s

---

## Test 2: Position Accuracy Testing

### Test Configuration
- **Target Position:** (100, 50, 75) mm
- **Iterations:** 100
- **Specifications:**
  - Mean error < 1mm
  - Max error < 3mm

### Results

Position accuracy statistics calculated from 100 movement repetitions to the same target position.

**Error Metrics:**
- Mean Total Error
- Max Total Error
- RMS Error
- Per-Axis Error (X, Y, Z)

### Data Files
- Raw data: \`accuracy-test-results.csv\`
- Format: Iteration, TargetX, TargetY, TargetZ, ActualX, ActualY, ActualZ, ErrorX, ErrorY, ErrorZ, TotalError

---

## Test 3: Repeatability Testing

### Test Configuration
- **Test Position:** Home (0, 0, 100)
- **Iterations:** 50 full cycles
- **Specification:** Standard deviation < 0.5mm per axis

### Results

Repeatability statistics measure variance in returning to home position across 50 cycles.

**Per-Axis Statistics:**
- X-axis: Mean, StdDev, Range
- Y-axis: Mean, StdDev, Range
- Z-axis: Mean, StdDev, Range

### Data Files
- Raw data: \`repeatability-test-results.csv\`
- Format: Iteration, X, Y, Z

---

## Detailed Statistical Analysis

Complete statistical analysis output is available in the test session log.

Run the Python analysis script for detailed breakdowns:
\`\`\`bash
cd $BENCHMARK_DIR
python3 analyze.py
\`\`\`

---

## Test Artifacts

All test data and analysis files are located in:
\`$BENCHMARK_DIR/\`

**Files:**
- \`benchmark-session.log\` - Complete test execution log
- \`speed-test-results.csv\` - Speed test raw data
- \`accuracy-test-results.csv\` - Accuracy test raw data
- \`repeatability-test-results.csv\` - Repeatability test raw data
- \`analyze.py\` - Python statistical analysis script
- \`performance-report.md\` - This report

---

## Recommendations

### If All Tests Pass
1. Document baseline performance in workspace-config.yml
2. Proceed with production validation testing
3. Establish continuous monitoring for performance degradation
4. Schedule quarterly performance validation

### If Tests Fail
1. Review detailed statistical analysis for specific failure modes
2. Address root causes (mechanical, calibration, control issues)
3. Re-run failed test categories after corrections
4. Document performance improvements

### Performance Optimization
- Review movement profiles for speed optimization opportunities
- Consider recalibration if accuracy is borderline
- Investigate any high-variance repeatability results
- Benchmark after any hardware or software changes

---

## Appendix: Test Specifications

| Metric | Specification | Measurement Method |
|--------|---------------|-------------------|
| Mean Speed | ≥ 50 mm/s | Timed movements at 4 distances (10 iterations each) |
| Position Accuracy (Mean) | < 1mm | Euclidean distance error, 100 iterations to same position |
| Position Accuracy (Max) | < 3mm | Maximum error from 100 iterations |
| Repeatability (StdDev) | < 0.5mm per axis | 50 home position cycles, per-axis standard deviation |

---

**Report Generated By:** agent-robotarm-tester v1.0.0
**Benchmark Date:** $(date -Iseconds)
EOF

echo "Performance report generated: $REPORT" | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"

# ============================================================================
# FINAL SUMMARY
# ============================================================================

echo "========================================" | tee -a "$MAIN_LOG"
echo "BENCHMARKING COMPLETE" | tee -a "$MAIN_LOG"
echo "========================================" | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"
echo "All test data saved to: $BENCHMARK_DIR" | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"
echo "Review the following files:" | tee -a "$MAIN_LOG"
echo "  - Performance Report: $REPORT" | tee -a "$MAIN_LOG"
echo "  - Session Log: $MAIN_LOG" | tee -a "$MAIN_LOG"
echo "  - Speed Data: $SPEED_CSV" | tee -a "$MAIN_LOG"
echo "  - Accuracy Data: $ACCURACY_CSV" | tee -a "$MAIN_LOG"
echo "  - Repeatability Data: $REPEATABILITY_CSV" | tee -a "$MAIN_LOG"
echo "" | tee -a "$MAIN_LOG"

if [ $analysis_exit_code -eq 0 ]; then
  echo "✓ RESULT: All performance tests PASSED" | tee -a "$MAIN_LOG"
else
  echo "✗ RESULT: Some performance tests FAILED - review analysis" | tee -a "$MAIN_LOG"
fi

echo "" | tee -a "$MAIN_LOG"
echo "End time: $(date -Iseconds)" | tee -a "$MAIN_LOG"

exit $analysis_exit_code
```

---

## Expected Output

```
=== Robot Arm Performance Benchmarking ===
Start time: 2025-12-06T16:00:00-05:00
Benchmark directory: performance-benchmark-20251206-160000

========================================
TEST 1: MOVEMENT SPEED BENCHMARKING
========================================

Testing movement speed for 25mm distance (10 iterations)...
  Iteration 1: 0.52s (48.08 mm/s)
  Iteration 2: 0.51s (49.02 mm/s)
  ...
  Iteration 10: 0.50s (50.00 mm/s)

Testing movement speed for 50mm distance (10 iterations)...
  Iteration 1: 0.98s (51.02 mm/s)
  ...

[... other distances ...]

Speed testing complete.

========================================
TEST 2: POSITION ACCURACY TESTING
========================================

Target position: (100, 50, 75)
Iterations: 100

  Progress: 20/100 iterations complete
  Progress: 40/100 iterations complete
  ...
  Progress: 100/100 iterations complete

Accuracy testing complete.

========================================
TEST 3: REPEATABILITY TESTING
========================================

Testing home position repeatability (50 cycles)...

  Progress: 10/50 cycles complete
  Progress: 20/50 cycles complete
  ...

Repeatability testing complete.

========================================
GENERATING STATISTICAL ANALYSIS
========================================

============================================================
SPEED TEST ANALYSIS
============================================================

Speed Statistics by Distance:
Distance_mm           Mean   StdDev      Min      Max
         25        48.52     1.23    46.50    50.12
         50        51.23     1.05    49.80    53.01
        100        52.45     0.98    51.20    54.10
        200        53.12     1.15    51.50    55.20

Overall Mean Speed: 51.33 mm/s
Specification: ≥ 50 mm/s
✓ PASS: Speed meets specification

============================================================
ACCURACY TEST ANALYSIS
============================================================

Total Error Statistics:
  Mean Error:   0.782 mm
  Max Error:    2.145 mm
  Min Error:    0.123 mm
  Std Dev:      0.456 mm
  RMS Error:    0.891 mm

Per-Axis Error Statistics:
  X-axis: Mean=0.312mm, Max=1.120mm, StdDev=0.234mm
  Y-axis: Mean=0.289mm, Max=0.987mm, StdDev=0.198mm
  Z-axis: Mean=0.345mm, Max=1.234mm, StdDev=0.276mm

Specification Check:
  Mean Error < 1mm: 0.782 mm ✓ PASS
  Max Error < 3mm:  2.145 mm ✓ PASS

============================================================
REPEATABILITY TEST ANALYSIS
============================================================

Home Position Repeatability:
  X-axis: Mean=0.012mm, StdDev=0.234mm, Range=0.987mm
    Specification (StdDev < 0.5mm): 0.234 mm ✓ PASS
  Y-axis: Mean=-0.008mm, StdDev=0.198mm, Range=0.876mm
    Specification (StdDev < 0.5mm): 0.198 mm ✓ PASS
  Z-axis: Mean=0.015mm, StdDev=0.312mm, Range=1.123mm
    Specification (StdDev < 0.5mm): 0.312 mm ✓ PASS

============================================================
OVERALL PERFORMANCE SUMMARY
============================================================

Test Results:
  Speed Test:         PASS ✓
  Accuracy Test:      PASS ✓
  Repeatability Test: PASS ✓

OVERALL RESULT: ✓ PASS - Robot arm meets all performance specifications

========================================
BENCHMARKING COMPLETE
========================================

All test data saved to: performance-benchmark-20251206-160000

Review the following files:
  - Performance Report: performance-benchmark-20251206-160000/performance-report.md
  - Session Log: performance-benchmark-20251206-160000/benchmark-session.log
  - Speed Data: performance-benchmark-20251206-160000/speed-test-results.csv
  - Accuracy Data: performance-benchmark-20251206-160000/accuracy-test-results.csv
  - Repeatability Data: performance-benchmark-20251206-160000/repeatability-test-results.csv

✓ RESULT: All performance tests PASSED

End time: 2025-12-06T16:15:30-05:00
```

---

## Generated Artifacts

### Benchmark Directory Structure

```
performance-benchmark-20251206-160000/
├── benchmark-session.log          # Complete execution log
├── speed-test-results.csv        # Speed test raw data
├── accuracy-test-results.csv     # Accuracy test raw data
├── repeatability-test-results.csv # Repeatability raw data
├── analyze.py                    # Statistical analysis script
└── performance-report.md         # Formatted report
```

### Data Files

**speed-test-results.csv:**
```csv
Distance_mm,Iteration,StartTime,EndTime,DurationSeconds,Speed_mm_per_s
25,1,2025-12-06T16:00:05-05:00,2025-12-06T16:00:05-05:00,0.52,48.08
25,2,2025-12-06T16:00:06-05:00,2025-12-06T16:00:07-05:00,0.51,49.02
...
```

**accuracy-test-results.csv:**
```csv
Iteration,TargetX,TargetY,TargetZ,ActualX,ActualY,ActualZ,ErrorX,ErrorY,ErrorZ,TotalError
1,100,50,75,100.2,50.1,74.9,0.2,0.1,-0.1,0.245
2,100,50,75,99.8,49.9,75.2,-0.2,-0.1,0.2,0.300
...
```

**repeatability-test-results.csv:**
```csv
Iteration,X,Y,Z
1,0.01,-0.02,0.03
2,-0.01,0.01,0.02
...
```

---

## Usage Instructions

1. **Save the script** as `performance-benchmark.sh`

2. **Make it executable:**
   ```bash
   chmod +x performance-benchmark.sh
   ```

3. **Run the benchmark:**
   ```bash
   ./performance-benchmark.sh
   ```

4. **Monitor progress** (optional, in another terminal):
   ```bash
   tail -f performance-benchmark-*/benchmark-session.log
   ```

5. **Review results:**
   ```bash
   # Read the performance report
   cat performance-benchmark-*/performance-report.md

   # View statistical analysis
   cd performance-benchmark-*/
   python3 analyze.py
   ```

6. **Import data for further analysis:**
   ```python
   import pandas as pd
   speed_df = pd.read_csv('speed-test-results.csv')
   accuracy_df = pd.read_csv('accuracy-test-results.csv')
   # ... custom analysis
   ```

---

## Next Steps Based on Results

### If All Tests Pass ✓
1. **Document baseline** in `workspace-config.yml`:
   ```yaml
   performance_baseline:
     date: "2025-12-06"
     speed_mean: 51.33  # mm/s
     accuracy_mean: 0.782  # mm
     accuracy_max: 2.145  # mm
     repeatability_x_stddev: 0.234  # mm
     repeatability_y_stddev: 0.198  # mm
     repeatability_z_stddev: 0.312  # mm
   ```

2. **Proceed to production validation**
3. **Establish monitoring** for performance degradation
4. **Schedule quarterly re-validation**

### If Tests Fail ✗
1. **Identify failure category** (speed, accuracy, or repeatability)
2. **Review detailed statistics** for patterns
3. **Address root causes:**
   - **Speed**: Check motor performance, reduce acceleration, verify power supply
   - **Accuracy**: Recalibrate, check mechanical play, verify position sensors
   - **Repeatability**: Calibrate home position, check belt tension, verify encoders
4. **Re-run failed tests** after corrections
5. **Document improvements**

---

**Example Generated By:** agent-robotarm-tester v1.0.0
**Date:** 2025-12-06
**Scenario:** Complete performance benchmarking with statistical analysis
