# Agents Repository Hub - Creation & Maintenance Guide

This guide provides a step-by-step process for designing, creating, and maintaining specialized Claude Code agents in this repository hub.

## Table of Contents

1. [Overview](#overview)
2. [Agent Anatomy](#agent-anatomy)
3. [Creation Workflow](#creation-workflow)
4. [Best Practices](#best-practices)
5. [Quality Standards](#quality-standards)
6. [Troubleshooting](#troubleshooting)

---

## Overview

This repository is designed as a **centralized agent hub** where specialized agents are created, tested, documented, and made available for use across multiple projects.

### Key Principles

- **Single Responsibility**: Each agent specializes in one domain
- **Accuracy First**: Never fabricate; acknowledge limitations
- **Complete Documentation**: System prompts, test cases, usage guides
- **Quality Gates**: Validation testing before production
- **Version Control**: Track all agent changes
- **Reusability**: Share agents across projects

### When to Create an Agent

Create a new agent when:
- ✅ You have a recurring workflow that could be automated
- ✅ Specialized domain expertise would improve quality/consistency
- ✅ Multiple projects could benefit from the same agent
- ✅ The scope is well-defined and bounded

Don't create an agent when:
- ❌ It's a one-off task
- ❌ Scope is too vague or unbounded
- ❌ A bash script or simple tool suffices
- ❌ You're not sure what the agent should do

---

## Agent Anatomy

### What Is an Agent?

A specialized Claude Code agent is a pre-configured expert with:

1. **Clear Identity** - Who is this agent? (e.g., "SAP S/4HANA consultant")
2. **Domain Expertise** - What specific areas does it excel in?
3. **Operational Boundaries** - What can/can't it do?
4. **Methodology** - How does it approach problems?
5. **Quality Standards** - How do you know the output is good?

### File Structure

The agent lives in Claude Code's configuration directory:

```
.claude/
  agents/
    agent-<id>.md                 # Agent definition (YAML frontmatter + system prompt)

agents/                           # Documentation and references
  agent-<id>/
    ├── README.md                 # Usage guide & triggers
    ├── test-cases.md             # Validation test cases (6+)
    └── examples/                 # Example outputs
        ├── example-1.md
        ├── example-2.md
        └── example-3.md
```

### Required Files

#### 1. .claude/agents/agent-<id>.md

The main agent definition file with YAML frontmatter containing metadata:

```yaml
---
name: agent-unique-id
description: |
  Multi-line description of what this agent does, its expertise, and primary use cases.
  Include trigger conditions and examples showing when to use this agent.

  <example>
  Context: [Scenario context]
  User: "[User request]"
  Assistant: "[How you'll respond]"
  <commentary>[Why this is a good trigger]</commentary>
  </example>

model: sonnet
---
```

After the frontmatter, include the complete system prompt that defines the agent's behavior, expertise, and operational guidelines.

#### 2. agents/agent-<id>/README.md

User-facing guide (500-1000 words):

```markdown
# agent-<id>

**One-line description**

## When to Use This Agent

### ✅ Trigger Conditions
- Condition 1
- Condition 2
- Condition 3

### ❌ When NOT to Use

## Usage Examples

### Example 1: [Scenario]
**User Request:** ...
**What the Agent Will Produce:** ...

### Example 2: [Scenario]
...

## Capabilities

## Output Quality

## Getting Started
```

#### 3. agents/agent-<id>/test-cases.md

6+ validation test cases:

```markdown
# Validation Test Cases: agent-<id>

## Test Case 1: [Scenario]

### Input
[User request]

### Expected Output Validation
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

### Success Criteria
[How do you know it passed?]

## Test Case 2: [Scenario]
...

## Test Results Template
[Provide a template for documenting test results]
```

#### 5. examples/ (Optional)

Real example outputs demonstrating the agent's capabilities.

---

## Creation Workflow

### Phase 1: Requirements Analysis (Before Building)

**Goal**: Understand what the agent should do

Use `@agent-agent-architect` to help with this analysis:

```bash
@agent-agent-architect: Help me design an agent for [domain].
I want it to help with [specific problems]. The target users are [audience].
Here's what I know about scope and constraints: [details]
```

**Deliverables**:
- [ ] Clear agent scope
- [ ] Trigger conditions (4-5 specific scenarios)
- [ ] Target audience identified
- [ ] Success criteria defined
- [ ] Constraints documented

**Example Questions to Answer**:
- What specific problems does this agent solve?
- Who are the target users?
- What's the expected input/output?
- What domains should it NOT cover?
- What standards/guidelines should it follow?

### Phase 2: Agent Specification Design

**Goal**: Create a comprehensive specification

Using the agent-architect, define:

1. **Agent Identity**
   - Name and ID
   - Expertise areas
   - Operational persona

2. **Trigger Conditions** (4-5 specific scenarios)
   - When should teams use this agent?
   - What exact requests trigger invocation?
   - Include realistic examples

3. **Boundaries**
   - What it MUST do
   - What it MUST NOT do
   - How it handles edge cases
   - Uncertainty handling

4. **Methodology**
   - Step-by-step approach
   - Structured outputs
   - Quality gates

5. **Quality Standards**
   - Accuracy criteria
   - Completeness criteria
   - Usability criteria
   - Professional standards

**Deliverables**:
- [ ] Complete agent specification (2-4 pages)
- [ ] Trigger conditions with examples
- [ ] Operational boundaries
- [ ] Quality standards defined

### Phase 3: System Prompt Development

**Goal**: Write the agent's complete system prompt

The system prompt should include:

1. **Role & Expertise** (150-200 words)
   - Clear persona
   - Deep expertise areas
   - Why this agent exists

2. **Responsibilities** (200-300 words)
   - Step-by-step workflow
   - How it approaches problems
   - What it delivers

3. **Critical Constraints** (200-300 words)
   - MUST do / MUST NOT do
   - How to handle uncertainty
   - Limitation acknowledgment

4. **Methodology** (200-400 words)
   - Structured approach
   - Templates/frameworks
   - Quality gates

5. **Communication Style** (100-150 words)
   - Tone
   - Terminology
   - Formality level

**Deliverables**:
- [ ] Complete system prompt (1000-2000 words)
- [ ] Examples of expected outputs
- [ ] Quality checklist
- [ ] Edge case handling

### Phase 4: Configuration & Documentation

**Goal**: Create agent files and documentation

**Create Files**:
1. `agents/agent-<id>/agent.yml` - Configuration
2. `agents/agent-<id>/system-prompt.md` - System prompt
3. `agents/agent-<id>/README.md` - User guide
4. `agents/agent-<id>/test-cases.md` - Test cases

**Documentation Should Include**:
- [ ] Clear trigger conditions
- [ ] Usage examples (3-5 scenarios)
- [ ] Capabilities list
- [ ] Quality standards
- [ ] Getting started guide

**Deliverables**:
- [ ] All configuration files
- [ ] User-facing README
- [ ] Complete documentation

### Phase 5: Test Case Development

**Goal**: Create 6+ validation test cases

Each test case should:

1. **Input**: Clear user request
2. **Expected Output**: Specific validation criteria
3. **Success Criteria**: How to know it passed
4. **Scoring**: Pass/fail assessment

**Test Case Categories** (plan 6+ total):
- Basic operation (core functionality)
- Complex scenario (multiple sub-tasks)
- Edge case (boundary conditions)
- Error handling (what goes wrong)
- Uncertainty (how to handle unknowns)
- Integration (how it works with others)

**Deliverables**:
- [ ] 6+ comprehensive test cases
- [ ] Clear validation criteria
- [ ] Example test results template
- [ ] Acceptance criteria

### Phase 6: Validation & Testing

**Goal**: Ensure agent works as designed

**Pre-Deployment Testing**:
1. Run all test cases
2. Document results
3. Refine system prompt if needed
4. Re-test until passing
5. Get approval from domain expert

**Test Execution**:
```markdown
## Test Execution Log

### Test 1: [Scenario]
Status: [PASS|FAIL]
Evidence: [What made it pass/fail?]
Notes: [Any observations?]

### Test 2: [Scenario]
...

## Overall Assessment
[Is agent production-ready?]
[What refinements are needed?]
```

**Acceptance Criteria**:
- [ ] 100% of test cases pass
- [ ] No fabricated functionality
- [ ] Accurate domain knowledge
- [ ] Clear limitations acknowledged
- [ ] Professional documentation
- [ ] Clean formatting

**Deliverables**:
- [ ] Completed test execution log
- [ ] All test cases passing
- [ ] Approved for production

### Phase 7: Integration & Deployment

**Goal**: Make agent available for use

**Registry Integration**:
1. Add entry to `AGENTS_REGISTRY.md`
2. Update CLAUDE.md if applicable
3. Create GitHub release/version
4. Document in project wiki

**Integration Checklist**:
- [ ] Agent files in `/agents/agent-<id>/`
- [ ] Entry in AGENTS_REGISTRY.md
- [ ] CLAUDE.md updated (if applicable)
- [ ] Version control commits
- [ ] README accessible
- [ ] Examples available
- [ ] Team notified

**Deployment Template**:
```markdown
# Agent Deployment: agent-<id>

**Version**: 1.0.0
**Date**: YYYY-MM-DD
**Status**: Production Ready

## What's Included
- Agent configuration
- System prompt
- User documentation
- Test cases
- Examples

## How to Use
[Quick start guide]

## Test Results
[Summary of validation]

## Known Limitations
[Transparent listing of constraints]
```

**Deliverables**:
- [ ] Agent live in repository
- [ ] Documentation complete
- [ ] Team aware and trained
- [ ] Support plan established

---

## Best Practices

### System Prompt Quality

✅ **Do**:
- Be specific with examples
- Include clear methodology
- Document edge cases
- Acknowledge uncertainties
- Use accurate terminology
- Provide quality checklist

❌ **Don't**:
- Be vague or generic
- Assume context
- Gloss over limitations
- Use wrong terminology
- Skip quality gates
- Make unsupported claims

### Test Case Quality

✅ **Do**:
- Cover core functionality
- Include edge cases
- Test error handling
- Validate uncertainty handling
- Document expectations clearly
- Include success criteria

❌ **Don't**:
- Only test happy paths
- Assume obvious behavior
- Skip negative scenarios
- Make vague assertions
- Test unrelated functionality
- Skip documentation

### Documentation Quality

✅ **Do**:
- Write for the user
- Provide clear examples
- Explain when to use
- Show what to expect
- Make it scannable
- Keep it updated

❌ **Don't**:
- Assume prior knowledge
- Be too technical
- Hide limitations
- Overcomplicate
- Use dense text walls
- Let it get stale

### Team Communication

✅ **Do**:
- Announce new agents
- Provide training
- Share documentation
- Gather feedback
- Report improvements
- Celebrate successes

❌ **Don't**:
- Surprise the team
- Assume adoption
- Ignore feedback
- Neglect maintenance
- Overhype capabilities
- Disappear after launch

---

## Quality Standards

### Accuracy

**Definition**: Agent provides factually correct, up-to-date information

**Validation**:
- Spot-check outputs against authoritative sources
- Verify technical accuracy with domain experts
- Test against real-world scenarios
- Update when standards change

### Completeness

**Definition**: Agent addresses full scope without major gaps

**Validation**:
- All trigger scenarios are handled
- Edge cases are addressed
- Documentation covers all capabilities
- Examples show main use cases

### Usability

**Definition**: Non-experts can understand and use outputs

**Validation**:
- Jargon is explained
- Examples are realistic
- Structure is clear
- Outputs are actionable

### Professional

**Definition**: Outputs meet professional standards

**Validation**:
- Terminology is consistent
- Formatting is clean
- Limitations are transparent
- Tone is appropriate

---

## Troubleshooting

### Common Issues

#### "Agent produces inaccurate information"

**Root Causes**:
- System prompt has incorrect details
- Test cases didn't catch the error
- Domain knowledge was incomplete

**Solution**:
1. Verify accuracy against authoritative source
2. Update system prompt with correct info
3. Create test case to prevent regression
4. Re-run all tests
5. Document fix and retest

#### "Agent outputs are too verbose/vague"

**Root Causes**:
- System prompt lacks specificity
- Communication style not defined
- Examples are too generic

**Solution**:
1. Refine system prompt with examples
2. Add concrete communication guidelines
3. Include realistic examples
4. Update test cases
5. Re-validate

#### "Agent doesn't handle edge cases"

**Root Causes**:
- Edge cases not in system prompt
- Test cases didn't cover scenario
- Boundaries not clearly defined

**Solution**:
1. Identify the edge case
2. Add to system prompt with guidance
3. Create test case
4. Verify handling
5. Document the edge case in README

#### "Agent invocation is unclear"

**Root Causes**:
- Trigger conditions are vague
- README examples aren't realistic
- When/when-not guidance is missing

**Solution**:
1. Clarify trigger conditions
2. Add more usage examples
3. Expand when/when-not section
4. Share with team for feedback
5. Iterate based on confusion patterns

### Maintenance Triggers

**Update the Agent When**:
- Underlying standards/APIs change
- Domain knowledge evolves
- Team reports gaps or inaccuracies
- Test cases fail
- Quarterly review reveals issues

**Deprecate the Agent When**:
- Domain is no longer relevant
- Better replacement exists
- Maintenance burden is high
- Few teams are using it
- Standards fundamentally shift

---

## Templates

### Quick Start: New Agent Checklist

```markdown
# New Agent Checklist: agent-<id>

## Planning
- [ ] Agent purpose is clear
- [ ] Scope is bounded
- [ ] Trigger conditions identified
- [ ] Target users defined
- [ ] Success criteria established

## Development
- [ ] Agent specification complete
- [ ] System prompt written
- [ ] Configuration files created
- [ ] README documented
- [ ] Examples created

## Testing
- [ ] 6+ test cases designed
- [ ] All tests passing
- [ ] Edge cases covered
- [ ] Documentation tested
- [ ] Approval received

## Deployment
- [ ] Agent in /agents/ directory
- [ ] AGENTS_REGISTRY.md updated
- [ ] CLAUDE.md updated (if applicable)
- [ ] Team notified
- [ ] Documentation accessible

## Post-Launch
- [ ] Team feedback gathered
- [ ] Common questions documented
- [ ] Usage patterns tracked
- [ ] Quarterly review scheduled
```

### New Agent PR Template

```markdown
# New Agent: agent-<id>

## Summary
[One paragraph describing the agent]

## Agent Details
- **ID**: agent-<id>
- **Category**: [Domain]
- **Status**: Production
- **Version**: 1.0.0

## What's Included
- [ ] agent.yml configuration
- [ ] system-prompt.md (~X words)
- [ ] README.md with examples
- [ ] test-cases.md (6+ tests)
- [ ] examples/ directory

## Testing
- [ ] All 6+ test cases pass
- [ ] No fabricated functionality
- [ ] Accurate domain knowledge
- [ ] Limitations clearly stated

## Documentation
- [ ] README is complete
- [ ] Usage examples are clear
- [ ] Trigger conditions defined
- [ ] Examples provided

## Team Notification
- [ ] Agent announcement ready
- [ ] Training materials prepared
- [ ] CLAUDE.md references added
```

---

## Related Resources

- **Agent Architect**: `@agent-agent-architect` - Use to design new agents
- **Agent Registry**: `AGENTS_REGISTRY.md` - Central hub of all agents
- **CLAUDE.md**: Project-specific agent configuration
- **Example Agent**: `agents/agent-sap-businesspartner-integration/` - Reference implementation

---

## Summary

### The 7-Phase Agent Creation Process

1. **Requirements Analysis** → Understand what's needed
2. **Specification Design** → Define agent comprehensively
3. **System Prompt Development** → Write the prompt
4. **Configuration & Documentation** → Create files
5. **Test Case Development** → Design validation tests
6. **Validation & Testing** → Run tests, refine
7. **Integration & Deployment** → Launch and support

### Key Principles

- **Start with agent-architect** to clarify requirements
- **Document everything** - system prompt, test cases, usage guide
- **Test thoroughly** - 6+ test cases before production
- **Be transparent** - acknowledge limitations explicitly
- **Keep it bounded** - single domain per agent
- **Maintain continuously** - quarterly reviews, updates as needed

### Success Criteria

✅ Clear, accurate domain expertise
✅ Comprehensive system prompt with examples
✅ Well-defined trigger conditions
✅ Robust test cases (6+)
✅ Professional documentation
✅ Team adoption and feedback
✅ Continuous improvement

---

**Version**: 1.0.0
**Last Updated**: 2025-11-20
**Maintained By**: Agent Architecture Team
