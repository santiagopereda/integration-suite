# agent-robotarm-tester

**Expert robotics testing engineer specializing in Raspberry Pi-based robot arm validation, debugging, and performance benchmarking via SSH**

## Overview

This agent creates systematic, safe, and comprehensive test workflows for validating robot arm functionality through SSH-based remote testing. It specializes in:

- Progressive workspace boundary discovery with safety-first approach
- Systematic movement validation with automatic status checking
- Error recovery automation with intelligent retry logic
- Performance benchmarking (speed, accuracy, repeatability)
- Calibration sequence verification
- Integration testing (vision systems, conveyor belts, external sensors)
- Comprehensive diagnostic data collection and logging
- Configuration file generation and management

## When to Use This Agent

### ✅ Trigger Conditions

Invoke this agent when:

1. **Workspace Discovery** - You need to discover and document safe operating boundaries for a new robot arm setup
2. **Movement Validation** - You want to test specific movements, sequences, or pick-and-place operations systematically
3. **Debugging Issues** - Your robot arm exhibits inconsistent behavior and you need systematic testing with diagnostic logging
4. **Performance Benchmarking** - You need to validate speed, accuracy, or repeatability before production deployment
5. **Calibration Verification** - You want to verify calibration accuracy or test calibration sequences
6. **Integration Testing** - You're integrating with vision systems, conveyor belts, or other external devices
7. **Error Recovery Testing** - You need to validate error handling and recovery procedures
8. **Production Readiness** - You require comprehensive validation before deploying to production

### ❌ When NOT to Use This Agent

- Writing robot arm firmware or low-level control code (use embedded systems agent)
- Designing mechanical components or kinematics (use CAD/robotics design agent)
- Setting up Raspberry Pi OS or SSH configuration (use Linux system administration agent)
- Implementing robot arm control algorithms (use control systems engineering agent)
- Non-testing tasks (general robot arm operation)

## Usage Examples

### Example 1: Workspace Boundary Discovery

**User Request:**
```
I just set up a new robot arm on my Raspberry Pi. I don't know the safe workspace
boundaries yet. Can you help me discover them systematically and safely?
```

**What the Agent Will Produce:**
- Pre-test safety questionnaire (verify home position, check SSH access)
- Progressive boundary discovery workflow:
  - Start from home position
  - Test each axis incrementally (+10mm, +20mm, +50mm, +100mm, etc.)
  - Status verification after each movement
  - Automatic limit detection
  - Immediate home return on error
- Timestamped test log capturing all movements and responses
- Generated `workspace-config.yml` with discovered limits
- Safe zone recommendations with safety margins
- Visualization data for workspace plotting
- Next steps for validation and production use

**Output Example:**
```bash
# Test Sequence: Workspace Boundary Discovery
# Date: 2025-12-06 14:30:00

# Step 1: Verify home position
ssh pi@robotarm-pi "robot-cli home && robot-cli status"

# Step 2: Test X-axis positive direction
ssh pi@robotarm-pi "robot-cli move x 10 && robot-cli status"
ssh pi@robotarm-pi "robot-cli move x 20 && robot-cli status"
...

# Generated workspace-config.yml with discovered limits
```

### Example 2: Pick-and-Place Sequence Validation

**User Request:**
```
Our pick-and-place sequence works sometimes but fails randomly. I need to
test it 50 times and capture diagnostic data to identify the failure pattern.
```

**What the Agent Will Produce:**
- Comprehensive test sequence (50 iterations)
- Automatic status checking between each movement
- Error detection and automatic recovery (home + retry)
- Detailed diagnostic logging:
  - Timestamp for each command
  - Full command and response capture
  - Success/failure status
  - Error messages and recovery actions
- Failure pattern analysis:
  - Which step fails most often
  - Error type categorization
  - Success rate by test phase
  - Timing correlation analysis
- Recommendations for fixing identified issues
- Updated test sequence with improvements

### Example 3: Performance Benchmarking

**User Request:**
```
I need to benchmark my robot arm before production deployment.
Test movement speed, position accuracy, and repeatability.
```

**What the Agent Will Produce:**
- **Speed Testing**:
  - Movement time measurement for various distances (10mm, 50mm, 100mm, 200mm)
  - Speed variation testing (slow, medium, fast settings)
  - Acceleration/deceleration profiling
  - Statistical analysis (mean, median, std dev)

- **Accuracy Testing**:
  - Move to target position 100 times
  - Measure actual vs. commanded position
  - Calculate accuracy metrics (mean error, max error, RMS error)
  - Generate accuracy distribution chart data

- **Repeatability Testing**:
  - 100-cycle home → position → home sequence
  - Position variance measurement
  - Repeatability score (ISO 9283 standard)
  - Drift detection over time

- **Comprehensive Report**:
  - Performance summary table
  - Statistical analysis
  - Pass/fail against specifications
  - Recommendations for optimization

### Example 4: Vision System Integration Testing

**User Request:**
```
We're integrating our robot arm with a vision system. I need to test
calibration and validate pick positions from camera coordinates.
```

**What the Agent Will Produce:**
- **Calibration Validation Workflow**:
  - Multi-point calibration pattern testing
  - Camera-to-robot coordinate transformation verification
  - Calibration accuracy measurement
  - Offset validation

- **Pick Position Testing**:
  - Convert camera coordinates to robot coordinates
  - Move to calculated positions
  - Verify actual position matches expected
  - Measure transformation error

- **Integration Test Sequence**:
  - Vision system trigger → coordinate acquisition
  - Coordinate transformation → robot movement
  - Pick operation → verify success
  - Place operation → accuracy validation
  - End-to-end cycle time measurement

- **Diagnostic Logging**:
  - Camera coordinates vs. robot coordinates
  - Transformation matrix validation
  - Position error tracking
  - Success rate by object type/position

### Example 5: Error Recovery Validation

**User Request:**
```
I want to test our error recovery procedures. Simulate failures
and verify the robot returns to a safe state automatically.
```

**What the Agent Will Produce:**
- **Error Injection Test Cases**:
  - Invalid position commands (beyond limits)
  - Communication interruption simulation
  - Unexpected stop commands
  - Timeout scenarios

- **Recovery Validation**:
  - Verify home command execution
  - Confirm safe position reached
  - Test retry logic with exponential backoff
  - Validate maximum retry limits

- **Recovery Success Metrics**:
  - Recovery success rate by error type
  - Time to recover by scenario
  - Retry attempts distribution
  - Escalation trigger validation

- **Safety Validation**:
  - Verify no unexpected movements during recovery
  - Confirm status reporting accuracy
  - Test emergency stop integration
  - Validate collision detection response

## Agent Capabilities

### Testing Methodologies

**Progressive Discovery**:
- Start with conservative movements from known safe positions
- Expand range gradually with status validation
- Document findings in real-time
- Build confidence through systematic exploration
- Generate safe zone configurations

**Systematic Validation**:
- Multi-step test sequences with dependencies
- Automatic status checking between commands
- Conditional execution based on results
- Comprehensive logging of all activities
- Statistical analysis of test results

**Safety-First Approach**:
- Automatic home return on any error
- Status verification before/after movements
- Conservative defaults for unknown parameters
- Warning alerts for unexplored territory
- Emergency stop integration

### Test Categories Covered

1. **Movement Tests**: Single-axis, multi-axis, coordinated, speed variation
2. **Workspace Discovery**: Boundary exploration, safe zone mapping, limit detection
3. **Calibration Tests**: Home position, end-effector, coordinate transformation, multi-point
4. **Performance Tests**: Speed, accuracy, repeatability, response time
5. **Recovery Tests**: Error handling, retry logic, escalation, safety validation
6. **Integration Tests**: Vision systems, conveyor belts, sensors, multi-device coordination
7. **Stress Tests**: Extended operation, thermal performance, power consumption
8. **Regression Tests**: Validate previous functionality after changes

### Pre-Defined Test Patterns

The agent includes ready-to-use test pattern library:

| Pattern Name | Purpose | Use Case |
|--------------|---------|----------|
| `boundary-discovery` | Progressive workspace exploration | New robot arm setup |
| `pick-place-basic` | Simple pick-and-place validation | Basic operation verification |
| `pick-place-vision` | Vision-guided pick-and-place | Vision system integration |
| `speed-benchmark` | Movement speed testing | Performance validation |
| `accuracy-test` | Position accuracy measurement | Quality assurance |
| `repeatability-test` | 100-cycle repeatability validation | Production readiness |
| `calibration-verify` | Calibration sequence validation | After calibration changes |
| `recovery-test` | Error recovery validation | Safety system verification |
| `stress-test` | Extended operation reliability | Long-term stability |
| `integration-vision` | Vision system end-to-end testing | Vision integration |
| `integration-conveyor` | Conveyor synchronization testing | Conveyor integration |

Request patterns by name or customize for specific needs.

### Logging and Reporting

**Timestamped Test Logs** (Markdown format):
- Test configuration and metadata
- Complete command history
- Full response capture
- Status indicators (PASS/FAIL/WARN)
- Timing information
- Error details and recovery actions
- Summary statistics
- Discovered limits and findings
- Recommendations for next steps

**Configuration Files Generated**:
- `workspace-config.yml` - Discovered workspace limits and safe zones
- `calibration-config.yml` - Calibration parameters and offsets
- `performance-baseline.yml` - Baseline performance metrics
- `test-results-[timestamp].yml` - Complete test results

**Report Formats**:
- Markdown reports for human review
- YAML/JSON data for automated analysis
- CSV exports for statistical tools
- Visualization data for plotting tools

## Output Quality

### Safety Guarantees
- **Never commands movements without status verification**
- **Always implements automatic error recovery**
- **Warns when operating in unexplored workspace areas**
- **Uses conservative defaults until limits are validated**
- **Prioritizes safety over speed in all test sequences**

### Accuracy Standards
- **Never fabricates robot arm commands or parameters**
- **Acknowledges when specific hardware details are unknown**
- **Transparently states assumptions and uncertainties**
- **Recommends verification against robot arm documentation**
- **Uses accurate robotics terminology consistently**

### Completeness
- **Comprehensive diagnostic data capture**
- **All test steps documented with timestamps**
- **Complete error and recovery tracking**
- **Statistical analysis for quantitative tests**
- **Actionable recommendations in all outputs**

### Usability
- **Clear step-by-step test procedures**
- **Copy-paste ready SSH commands**
- **Scannable Markdown format**
- **Progressive complexity (simple → advanced)**
- **Examples for all test patterns**

## Integration Constraints

### What This Agent Won't Do
- ❌ Write robot arm firmware or embedded control code
- ❌ Design mechanical components or kinematics
- ❌ Configure Raspberry Pi OS or network settings
- ❌ Implement control algorithms or motion planning
- ❌ Provide robot arm hardware specifications
- ❌ Make assumptions about unknown command syntax

### What This Agent Handles Carefully
- ✓ Unknown workspace limits → Progressive discovery with safety margins
- ✓ Robot arm specific commands → Adapts to user's command syntax
- ✓ SSH authentication → Assumes configured, handles failures gracefully
- ✓ Hardware-specific behavior → Asks for clarification when needed
- ✓ Unknown error conditions → Conservative recovery approach

## SSH Access Requirements

### Prerequisites
- Raspberry Pi with SSH server enabled
- SSH keys configured for passwordless access (recommended)
- Robot arm control CLI available on Raspberry Pi
- Network connectivity between testing machine and Raspberry Pi

### Authentication Handling
- Assumes SSH keys are configured (passwordless)
- Handles authentication failures gracefully
- Provides troubleshooting guidance for connection issues
- Supports custom SSH ports and configurations

### Command Syntax Adaptation
Agent adapts to your robot arm's command syntax. Common patterns:

```bash
# Example command patterns (agent adapts to your system)
robot-cli status
robot-cli home
robot-cli move x 100
robot-cli move x 100 y 50 z 30
robot-cli position
robot-cli limits
```

Provide your command syntax and the agent will use it consistently.

## Configuration File Management

The agent generates and helps maintain configuration files documenting your robot arm's characteristics:

### workspace-config.yml
```yaml
workspace_limits:
  x_axis:
    min: -150  # mm, discovered 2025-12-06
    max: 200   # mm, discovered 2025-12-06
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

safe_zones:
  - name: "pick_zone"
    x_range: [50, 100]
    y_range: [50, 80]
    z_range: [20, 60]
```

**Configuration files are:**
- Generated automatically from test results
- Updated as you discover more about your system
- Version controlled with timestamps
- Referenced in future test sequences
- Shared across team members

## Getting Started

### Direct Invocation

```bash
@agent-robotarm-tester: I just set up my robot arm. Help me discover
the workspace boundaries safely and create a configuration file.
```

### Common First Tests

**1. Verify Basic Connectivity:**
```bash
@agent-robotarm-tester: Test if I can connect to my robot arm via SSH
and get status information. Raspberry Pi hostname is robotarm-pi.
```

**2. Discover Workspace Boundaries:**
```bash
@agent-robotarm-tester: Create a comprehensive workspace boundary
discovery test sequence. Start conservatively from home position.
```

**3. Validate Pick-and-Place:**
```bash
@agent-robotarm-tester: Test a simple pick-and-place sequence:
home → pick(50,50,20) → place(-30,60,25) → home. Run 20 times.
```

**4. Benchmark Performance:**
```bash
@agent-robotarm-tester: Run comprehensive performance benchmarks including
speed tests, accuracy validation, and repeatability testing.
```

### In CLAUDE.md

```yaml
agents:
  - name: agent-robotarm-tester
    trigger: "When testing or debugging Raspberry Pi robot arms"
    scope: "Systematic testing, boundary discovery, performance validation, error recovery"
```

### With Other Agents
- **Code Review Agents**: Verify test scripts follow best practices
- **Documentation Agents**: Generate test documentation and reports
- **DevOps Agents**: Integrate test sequences into CI/CD pipelines
- **Data Analysis Agents**: Analyze test result patterns and trends

## Advanced Features

### Vision System Integration
- Camera-to-robot coordinate transformation testing
- Calibration pattern validation (checkerboard, dot patterns)
- Pick position accuracy verification from vision data
- Multi-camera coordinate fusion testing
- Real-time tracking performance validation

### Conveyor Belt Integration
- Synchronization timing tests (trigger delays, tracking)
- Moving target pick validation
- Speed matching verification
- Position prediction accuracy testing
- Throughput measurement

### Multi-Device Coordination
- Dual-arm synchronization testing
- Master-slave coordination validation
- Shared workspace collision avoidance verification
- Handoff operation testing
- Synchronized movement timing validation

### Custom Test Sequences
Users can define custom test sequences in YAML:

```yaml
custom_test:
  name: "My Pick-Place Sequence"
  steps:
    - command: home
      verify: status

    - command: move x 50 y 50 z 20
      verify: position
      tolerance: 2  # mm

    - command: grip close
      verify: grip_status

    - command: move z 100
      verify: position
```

Agent will execute and validate custom sequences.

## Validation Checklist

Before using agent-generated test sequences:
- [ ] SSH access to Raspberry Pi is confirmed working
- [ ] Robot arm control CLI commands are verified
- [ ] Home position is set and safe
- [ ] Test area is clear of obstacles
- [ ] Emergency stop is accessible
- [ ] Logging directory exists and is writable
- [ ] Test sequence steps are understood
- [ ] Safety boundaries are appropriate
- [ ] Recovery procedures are clear
- [ ] Expected results are defined

## Support & Maintenance

### When to Refresh Test Sequences
- Robot arm hardware changes or upgrades
- Calibration is updated or recalibrated
- New workspace boundaries are discovered
- Integration with new external systems
- Performance degradation detected
- Software updates to robot control system

### Continuous Improvement
The agent helps you:
- Build a library of validated test sequences
- Document discovered workspace characteristics
- Track performance trends over time
- Identify failure patterns early
- Optimize testing efficiency
- Share knowledge across team

### Getting Help
For issues or questions:
1. Check test logs for error details
2. Review generated configuration files
3. Consult robot arm hardware documentation
4. Verify SSH connectivity and authentication
5. Contact Agent Architecture Team

**Contact:** Agent Architecture Team
**Version:** 1.0.0
**Last Updated:** 2025-12-06
**Status:** Production Ready
