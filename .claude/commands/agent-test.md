# /agent-test Command

Run validation tests for agents to enforce quality gates.

## Invocation

```bash
/agent-test                    # Test all agents with test cases
/agent-test agent-git-manager  # Test specific agent
/agent-test --verbose          # Show detailed output
```

## Workflow

### 1. IDENTIFY Test Cases

Read `agents-registry.json` to find agents with test cases:

```bash
# For each agent where test_cases_count > 0:
jq '.agents[] | select(.metrics.test_cases_count > 0) | {id, test_cases: .location.test_cases}' agents-registry.json
```

### 2. LOAD Test Cases

For each agent, read its test-cases.md file:
- Parse test case format (Input, Expected Behavior, Pass Criteria)
- Extract pass criteria checkboxes

### 3. EVALUATE Structurally

For each test case, perform structural validation:

**Structural Checks**:
- [ ] Agent definition file exists
- [ ] Referenced templates exist (if any)
- [ ] Constraints are present in agent definition
- [ ] Required sections exist (Purpose, Capabilities, Constraints)

**Quality Gate Checks**:
- [ ] QG-2: Fabrication constraints present ("Never fabricates", "Never invents")
- [ ] QG-3: Uncertainty acknowledgment present ("Acknowledges limitations", "transparently states")
- [ ] QG-4: All referenced templates in `location.templates` exist
- [ ] QG-5: Critical constraints match those in registry

### 4. REPORT Results

Output test results:

```markdown
## Agent Test Results

**Timestamp**: 2026-01-25T10:30:00Z
**Agents Tested**: 8
**Total Tests**: 92
**Passed**: 92
**Failed**: 0
**Pass Rate**: 100%

### agent-git-manager (10 tests)
- [x] TC-1: Security scan detects .env files
- [x] TC-2: Blocks commit with detected secrets
- [x] TC-3: Provides override mechanism
...

### agent-sap-businesspartner-integration (6 tests)
- [x] TC-1: Generates complete BP creation flow
...
```

### 5. STORE Results

Save results to `.agent/tests/results/`:

```json
{
  "timestamp": "2026-01-25T10:30:00Z",
  "total_agents": 8,
  "total_tests": 92,
  "passed": 92,
  "failed": 0,
  "pass_rate": 1.0,
  "quality_gates": {
    "QG-1": "passed",
    "QG-2": "passed",
    "QG-3": "passed",
    "QG-4": "passed",
    "QG-5": "passed"
  },
  "agents": [...]
}
```

## Quality Gates Enforced

| Gate | Check | Failure Action |
|------|-------|----------------|
| QG-1 | 100% test pass rate | Block deployment |
| QG-2 | Fabrication constraints present | Block deployment |
| QG-3 | Uncertainty acknowledgment | Block deployment |
| QG-4 | Referenced templates exist | Block deployment |
| QG-5 | Critical constraints intact | Block deployment |

## Output Modes

### Default (Summary)
```
Testing 8 agents...

agent-git-manager: 10/10 passed ✓
agent-sap-businesspartner-integration: 6/6 passed ✓
...

Overall: 92/92 (100%) - All quality gates passed
```

### Verbose
```
Testing agent-git-manager...
  TC-1: Security scan detects .env files
    - Checking: Agent definition exists... ✓
    - Checking: Constraint "Never commit files with detected secrets" present... ✓
    - Result: PASSED
  TC-2: ...
```

## Integration with /optimize

The `/optimize` command calls `/agent-test` automatically:

1. Before optimization: Establish baseline pass rate
2. After optimization: Verify no regressions
3. Block optimization if tests fail

## Error Handling

**No Test Cases Found**:
```
Warning: agent-architect has no test cases (test_cases_count: 0)
Skipping...
```

**Test Case File Missing**:
```
Error: agents/git-manager/test-cases.md not found
Expected at: [path from registry]
```

**Quality Gate Failure**:
```
FAILED: QG-2 Fabrication Constraints
agent-example is missing required constraint pattern.
Expected: "Never fabricates" or equivalent
Found: [none]
```

---

**Version**: 1.0.0
**Last Updated**: 2026-01-25
