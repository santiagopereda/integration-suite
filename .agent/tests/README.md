# Agent Test Infrastructure

Automated testing infrastructure for validating agent functionality before deployment.

## Purpose

This test system enables:
- Automated validation of agent test cases
- Quality gate enforcement before optimization
- Regression detection after changes
- Cross-agent test aggregation

## Usage

### Run All Tests
```bash
/agent-test
```

### Test Specific Agent
```bash
/agent-test agent-git-manager
```

### Run with Verbose Output
```bash
/agent-test --verbose
```

## Test Case Format

Each agent's `test-cases.md` follows this structure:

```markdown
## Test Case 1: [Name]

**Input**: [User request]
**Expected Behavior**: [What agent should do]
**Pass Criteria**:
- [ ] Criterion 1
- [ ] Criterion 2
```

## Results Storage

Test results are stored in `results/`:
```
results/
├── latest.json           # Most recent run
├── 2026-01-25T10-30.json # Timestamped results
└── summary.md            # Human-readable summary
```

## Result Schema

```json
{
  "timestamp": "2026-01-25T10:30:00Z",
  "agent_id": "agent-git-manager",
  "total_tests": 10,
  "passed": 10,
  "failed": 0,
  "pass_rate": 1.0,
  "tests": [
    {
      "id": "TC-1",
      "name": "Security scan detects .env files",
      "status": "passed",
      "notes": null
    }
  ]
}
```

## Quality Gates

Tests enforce these quality gates (from agents-registry.json):

| Gate | Requirement | Threshold |
|------|-------------|-----------|
| QG-1 | Test pass rate | 100% |
| QG-2 | Fabrication constraints | Present |
| QG-3 | Uncertainty acknowledgment | Present |
| QG-4 | Referenced templates exist | All files |
| QG-5 | Critical constraints | Intact |
| QG-6 | Quality score | >= 4.0/5 |

## Integration with /optimize

The `/optimize` command uses this test infrastructure:
1. Before optimization: Runs tests to establish baseline
2. After optimization: Validates no regressions
3. Records pass rate in optimization metrics

## Adding Test Cases

1. Add test case to agent's `test-cases.md`
2. Follow the standard format
3. Run `/agent-test [agent-id]` to validate
4. Update agents-registry.json with new test count

---

**Version**: 1.0.0
**Last Updated**: 2026-01-25
