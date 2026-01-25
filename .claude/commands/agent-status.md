# /agent-status Command

Hub-wide dashboard showing all agents and their deployment status.

## Invocation

```bash
/agent-status                    # Full dashboard
/agent-status agent-git-manager  # Specific agent details
/agent-status --deployments      # Focus on deployment info
/agent-status --metrics          # Focus on metrics
```

## Data Sources

1. `agents-registry.json` - Agent definitions and metrics
2. `deployments/registry.json` - Deployment tracking
3. `.agent/telemetry/` - Usage telemetry (if available)
4. `.agent/reflection_pool/` - Cross-project insights

## Workflow

### 1. LOAD Registry Data

```bash
# Read main registry
cat agents-registry.json

# Read deployment registry
cat deployments/registry.json
```

### 2. AGGREGATE Metrics

For each agent, compile:
- Version and status
- Token usage (baseline, optimized, reduction)
- Test case count and pass rate
- Deployment count
- Quality score (if available)

### 3. DISPLAY Dashboard

## Output Format

### Full Dashboard (Default)

```markdown
# Agentic Hub Status

**Hub Version**: 2.0.0
**Registry Version**: 2.0.0
**Last Updated**: 2026-01-25
**Total Agents**: 11 (4 meta, 7 deployable)

## Meta-Agents (Hub Management)

| Agent | Version | Status | Tests | Last Used |
|-------|---------|--------|-------|-----------|
| agent-provisioner | 1.0.0 | Production | 12/12 ✓ | Today |
| agent-optimizer | 1.0.0 | Production | 12/12 ✓ | Today |
| agent-architect | 1.0.0 | Production | - | - |
| agent-project-init | 1.0.0 | Production | - | - |

## Deployable Agents

| Agent | Version | Optimization | Tests | Deployments | Quality |
|-------|---------|--------------|-------|-------------|---------|
| agent-sap-bp | 1.0.0 | 58% reduced | 6/6 ✓ | 0 | - |
| agent-ansible | 1.0.0 | 59% reduced | 12/12 ✓ | 0 | - |
| agent-robotarm | 1.0.0 | candidate | 12/12 ✓ | 0 | - |
| agent-git-manager | 1.0.0 | candidate | 10/10 ✓ | 0 | - |
| agent-cv-optimizer | 1.0.0 | candidate | 12/12 ✓ | 0 | - |
| research-assistant | 1.0.0 | - | - | 0 | - |
| documentation-specialist | 1.0.0 | - | - | 0 | - |

## Deployment Summary

| Metric | Value |
|--------|-------|
| Total Projects | 0 |
| Total Deployments | 0 |
| Testimonies Collected | 0 |
| Most Deployed Agent | - |

## Quality Gates Status

| Gate | Status | Details |
|------|--------|---------|
| QG-1: Test Pass Rate | ✓ | 100% (92/92) |
| QG-2: Fabrication Constraints | ✓ | All present |
| QG-3: Uncertainty Acknowledgment | ✓ | All present |
| QG-4: Template Existence | ✓ | All exist |
| QG-5: Critical Constraints | ✓ | All intact |
| QG-6: Quality Score | - | No feedback yet |
```

### Specific Agent (e.g., `/agent-status agent-git-manager`)

```markdown
# Agent: agent-git-manager

## Overview

| Field | Value |
|-------|-------|
| ID | agent-git-manager |
| Name | Git Repository Manager |
| Version | 1.0.0 |
| Status | Production |
| Category | utility |
| Domain | Developer Tools |

## Description

Expert git repository manager specializing in secure commit workflows
with mandatory pre-commit security scanning, SSH/GitHub integration,
and documentation workflow coordination.

## Metrics

| Metric | Value |
|--------|-------|
| Token Usage (Baseline) | - |
| Token Usage (Optimized) | - |
| Optimization Reduction | candidate |
| Test Cases | 10 |
| Test Pass Rate | 100% |
| Invocations (30d) | 0 |
| Quality Score | - |

## Dependencies

**Commands**: update_doc.md
**Hooks**: PostToolUse: Edit|Write|NotebookEdit
**Templates**: None

## Constraints

- Never force push to any branch
- Never amend without explicit request
- Always run security scan before commit
- Always require confirmation for push

## Deployments

No deployments recorded.

## Files

- Definition: agents/git-manager/agent.md
- Test Cases: agents/git-manager/test-cases.md
- Examples: agents/git-manager/examples/
```

### Deployments Focus (`/agent-status --deployments`)

```markdown
# Deployment Status

## Projects Using Hub Agents

| Project | Agents | Last Sync | Testimony |
|---------|--------|-----------|-----------|
| (none) | | | |

## Deployment History

| Date | Project | Agent | Action | Version |
|------|---------|-------|--------|---------|
| (none) | | | | |

## Statistics

- Total Projects: 0
- Total Deployments: 0
- Most Deployed: -
- Testimonies Collected: 0
```

### Metrics Focus (`/agent-status --metrics`)

```markdown
# Agent Metrics Summary

## Token Efficiency

| Agent | Baseline | Optimized | Reduction |
|-------|----------|-----------|-----------|
| agent-sap-bp | 15,000 | 6,300 | 58% |
| agent-ansible | 16,000 | 6,493 | 59% |
| agent-provisioner | - | - | 43% |
| Others | - | - | candidate |

## Hub-Wide Statistics

- Total Agents: 11
- Optimized Agents: 3
- Optimization Candidates: 4
- Total Token Savings: ~15,200 tokens per cycle

## Test Coverage

| Agent | Test Cases | Pass Rate |
|-------|------------|-----------|
| agent-git-manager | 10 | 100% |
| agent-sap-bp | 6 | 100% |
| agent-ansible | 12 | 100% |
| agent-robotarm | 12 | 100% |
| agent-provisioner | 12 | 100% |
| agent-cv-optimizer | 12 | 100% |
| agent-optimizer | 12 | 100% |

**Total**: 76 test cases, 100% pass rate
```

## Error Handling

**Registry Not Found**:
```
Error: agents-registry.json not found
Run from hub root directory or check file existence.
```

**Deployment Registry Not Found**:
```
Warning: deployments/registry.json not found
Deployment tracking not initialized.
Run: mkdir -p deployments && echo '{}' > deployments/registry.json
```

---

**Version**: 1.0.0
**Last Updated**: 2026-01-25
