# /agent_reflect - Project Journey Testimony Generator

Generate comprehensive reflection documents that capture your project's evolution, lessons learned, and insights by analyzing the `.agent/` knowledge base.

## Purpose

This command creates "project journey testimony" documents that synthesize:
- What worked well and why
- What failed and corrections made
- Initial assumptions that needed clarification
- Evolution of thinking (technical, process, architecture)
- Quantitative metrics and outcomes
- Recommendations for future projects

## Quick Reference

| Aspect | Details |
|--------|---------|
| **Invocation** | `/agent_reflect` or `/agent_reflect [project-path]` |
| **Agent Used** | `documentation-specialist` |
| **Data Source** | `.agent/` directory |
| **Output Path (Project)** | `{project}/.agent/testimony/` |
| **Output Path (Central)** | `/home/askeox/Documents/Agentic/.agent/testimony/` |
| **Output Format** | `{project-name}_testimony_{YYYY-MM-DD}.md` |
| **Project Tracker** | `/home/askeox/Documents/Agentic/.agent/tracked-projects.md` |

---

## Input Sources

Read these files from `.agent/` in priority order:

| Priority | File/Directory | Purpose |
|----------|---------------|---------|
| 1 | `injection-history.md` | Chronological audit trail of all changes |
| 2 | `PHASE*_COMPLETE.md` | Milestone narratives with metrics |
| 3 | `metrics/optimization-log.md` | Change history with reasoning |
| 4 | `metrics/*.json` | Quantitative baseline/current data |
| 5 | `telemetry/invocation-log.jsonl` | Agent usage telemetry data |
| 6 | `telemetry/daily/*.json` | Daily aggregated telemetry |
| 7 | `sops/common-mistakes.md` | Documented failures and lessons |
| 8 | `tasks/*/prd.md` | Original requirements and objectives |
| 9 | `README.md` | Project knowledge base overview |

### Graceful Degradation

If `.agent/` directory is missing or minimal:
1. Report what was found
2. Generate testimony from available content
3. Note gaps in the output document
4. Suggest what documentation would enrich future reflections

---

## Testimony Document Template

The generated document follows this structure:

```markdown
# Project Journey Testimony: [Project Name]

**Generated**: [YYYY-MM-DD HH:MM:SS]
**Project Path**: [Absolute path]
**Command Version**: [From Version History table, e.g., 1.1.0]
**Knowledge Base Version**: [From README or injection-history]
**Total Documentation Entries**: [Count from injection-history]

---

## Executive Summary

[2-3 paragraph synthesis of the project's agent-assisted journey, highlighting
the most significant learnings and outcomes]

---

## Timeline of Key Events

### [Phase/Milestone Name]
- **Date**: [Date range]
- **Duration**: [Time spent]
- **Objectives**: [What was attempted]
- **Outcomes**: [What was achieved]
- **Key Decision**: [Most important choice made]

[Repeat for each phase/milestone found in PHASE*_COMPLETE.md or injection-history.md]

---

## What Worked Well

### 1. [Success Category]
**Context**: [Situation that required action]
**Approach**: [What was tried]
**Outcome**: [Result achieved]
**Evidence**: [Quote or metric from .agent/ files]
**Transferable Insight**: [How this applies to other projects]

[Repeat for each significant success identified]

---

## What Failed and Corrections Made

### 1. [Failure Category]
**Initial Assumption**: [What was believed to be true]
**What Happened**: [How reality differed]
**Correction Applied**: [How it was fixed]
**Lesson Learned**: [Insight gained]
**Source**: [File in .agent/ that documents this]

[Repeat for each failure/correction identified]

---

## Initial Assumptions That Needed Clarification

| Assumption | Reality Discovered | When Discovered | Impact on Project |
|------------|-------------------|-----------------|-------------------|
| [What was assumed] | [What was actually true] | [Date/Phase] | [How it affected work] |

---

## Evolution of Thinking

### Technical Evolution
- **Started With**: [Initial technical approach]
- **Pivoted To**: [Changed approach and why]
- **Ended With**: [Final technical state]
- **Key Insight**: [What drove the evolution]

### Process Evolution
- **Started With**: [Initial process/workflow]
- **Pivoted To**: [Changed process and why]
- **Ended With**: [Final process state]
- **Key Insight**: [What drove the evolution]

### Architecture Evolution
- **Started With**: [Initial architecture decisions]
- **Pivoted To**: [Changed architecture and why]
- **Ended With**: [Final architecture state]
- **Key Insight**: [What drove the evolution]

---

## Lessons Learned

### Technical Lessons
1. **[Lesson Title]**: [Detailed explanation with context and evidence]

### Process Lessons
1. **[Lesson Title]**: [Detailed explanation with context and evidence]

### Human-Agent Collaboration Lessons
1. **[Lesson Title]**: [Insights about working effectively with AI agents]

---

## Metrics and Outcomes

### Quantitative Results
| Metric | Baseline | Final | Change | Significance |
|--------|----------|-------|--------|--------------|
| [Metric name] | [Starting value] | [Ending value] | [Delta %] | [Why it matters] |

### Qualitative Outcomes
- [Observation about quality, maintainability, or team effectiveness]

---

## Agent Usage Telemetry

*This section is populated from `.agent/telemetry/` data when available.*

### Agent Usage Summary
| Agent | Invocations | Avg Tokens | Success Rate | Avg Duration |
|-------|-------------|------------|--------------|--------------|
| [agent-id] | [count] | [tokens] | [%] | [ms] |

### Usage Patterns
- **Most Active Agent**: [agent-id] ([X]% of invocations)
- **Total Agent Invocations**: [count]
- **Total Tokens Consumed**: [estimate]
- **Overall Success Rate**: [%]

### Tool Distribution
| Tool | Usage % | Context |
|------|---------|---------|
| [tool-name] | [%] | [typical use case] |

### Quality Signals
- **Task Completion Rate**: [%]
- **User Reverts**: [count] ([%])
- **Error Rate**: [%]

### Telemetry Insights
- [Observation about agent usage patterns]
- [Insight about which agents were most effective]
- [Note about any error patterns detected]

*Note: If telemetry is not available, this section will indicate "Telemetry not enabled" and recommend setup.*

---

## Recommendations for Future Projects

### Do This
1. **[Recommendation]**: [Specific actionable advice based on success]

### Avoid This
1. **[Anti-pattern]**: [What to avoid based on failures]

### Consider This
1. **[Context-dependent recommendation]**: [When and why to apply]

---

## Knowledge Base Audit

### Files Analyzed
| File | Lines | Key Insights Extracted |
|------|-------|----------------------|
| [Path] | [Count] | [Brief summary] |

### Documentation Gaps Identified
- **[Gap]**: [What should have been documented but wasn't]

### Suggested Improvements
- [How to make future reflections richer]

---

## Appendix: Source Excerpts

### Key Entries from injection-history.md
[Chronological list of most significant entries with annotations]

### Phase Completion Highlights
[Key quotes from PHASE*_COMPLETE.md files]

### Metrics Summary
[Raw data from metrics/*.json if available]

---

**Testimony Generated By**: documentation-specialist
**Command Version**: [From Version History table, e.g., 1.1.0]
**Generation Date**: [YYYY-MM-DD HH:MM:SS]
```

---

## Workflow Steps

### Step 1: Discover Knowledge Base

```bash
# Check for .agent/ directory
ls -la .agent/

# If missing, provide guidance and exit gracefully
```

### Step 2: Inventory Available Content

Read and catalog:
1. Count entries in `injection-history.md`
2. List `PHASE*_COMPLETE.md` files
3. Check for `metrics/` directory
4. Check for `sops/common-mistakes.md`
5. Identify `tasks/*/` subdirectories

### Step 3: Extract Timeline Data

From `injection-history.md`:
- Parse date entries `[YYYY-MM-DD]`
- Extract entry types (Knowledge Base, Migration, Enhancement, etc.)
- Note status transitions (Draft -> Complete -> Validated)
- Identify cross-references

### Step 4: Extract Success Patterns

Look for:
- Positive outcomes in PHASE*_COMPLETE.md "What Worked" sections
- Metrics improvements (before/after comparisons)
- Completed objectives with "100%" or positive language
- Entries marked as "Validated"

### Step 5: Extract Failure Patterns

Look for:
- "Correction" or "Fix" entries in injection-history.md
- Phase 2 documents (often address Phase 1 shortcomings)
- `sops/common-mistakes.md` entries
- Rollback or revert mentions in optimization-log.md

### Step 6: Synthesize Evolution

Trace how approaches changed:
- Compare early vs. late injection-history entries
- Note architecture changes between phases
- Identify process improvements documented

### Step 6.5: Extract Telemetry Data

If `.agent/telemetry/` exists:
1. Parse `invocation-log.jsonl` for all events
2. Aggregate by agent_id:
   - Count invocations per agent
   - Calculate average tokens
   - Compute success rate
   - Calculate average duration
3. Determine tool distribution
4. Extract quality signals (task completion, reverts)
5. Identify patterns and insights

If telemetry not available:
- Note "Telemetry not enabled" in output
- Recommend enabling via `@agent-provisioner: sync`

**Telemetry Aggregation Query**:
```bash
# Count invocations by agent
jq -s 'group_by(.agent_id) | map({agent: .[0].agent_id, count: length})' invocation-log.jsonl

# Calculate success rate
jq -s '[.[] | .status] | group_by(.) | map({status: .[0], count: length})' invocation-log.jsonl
```

### Step 7: Generate Testimony

Using `documentation-specialist`:
- Get current command version from Version History table (e.g., 1.1.0)
- Apply the testimony template
- Include **Command Version** in header metadata and footer
- Fill each section with extracted insights
- Maintain objectivity (report what's documented, don't fabricate)
- Note gaps where information wasn't available

### Step 8: Write Output (Dual-Write)

1. Get current timestamp: `date +"%Y-%m-%d %H:%M:%S"`
2. Derive project name from directory (lowercase, hyphens for spaces)
3. Create testimony filename: `{project-name}_testimony_{YYYY-MM-DD}.md`
4. **Write to project-local**:
   - Create directory if needed: `mkdir -p {project}/.agent/testimony/`
   - Write file: `{project}/.agent/testimony/{filename}`
5. **Write to central hub**:
   - Write file: `/home/askeox/Documents/Agentic/.agent/testimony/{filename}`
6. **Update project tracker** (optional):
   - If project is listed in `/home/askeox/Documents/Agentic/.agent/tracked-projects.md`
   - Update the "Last Testimony" date for that project
7. Confirm success with both paths

---

## Integration with documentation-specialist

This command delegates to `documentation-specialist` for testimony generation.

### Why documentation-specialist?

1. **Universally Available**: Present in all properly configured projects
2. **Synthesis Expertise**: Designed for combining technical information
3. **Knowledge Base Aware**: Already understands `.agent/` structure
4. **Consistent Quality**: Produces well-structured documentation

### Delegation Pattern

```
/agent_reflect
    |
    +-> Command gathers data from .agent/
    |
    +-> Command prepares context summary:
    |   - Timeline overview
    |   - Key files found
    |   - Entry counts and types
    |
    +-> documentation-specialist generates:
        - Narrative synthesis
        - Template population
        - Quality assurance
```

### Context to Provide

When delegating, include:
- Project name and path
- List of files read and their sizes
- Summary of entry types found
- Any notable gaps or limitations
- Desired output path

---

## Output Conventions

### File Naming

```
{project-name}_testimony_{YYYY-MM-DD}.md
```

**Rules**:
- Project name: Derived from directory, lowercase, hyphens for spaces
- Date: ISO format (YYYY-MM-DD)
- Extension: Always `.md`

**Examples**:
- `agentic_testimony_2026-01-23.md`
- `cv-generator-agent_testimony_2026-01-23.md`
- `sap-integration-project_testimony_2026-01-23.md`

### Output Directories (Dual-Write)

Testimonies are written to **two locations**:

**1. Project-Local** (for project-specific context):
```
{project}/.agent/testimony/
+-- {project-name}_testimony_2026-01-23.md
```

**2. Central Hub** (for cross-project analysis):
```
/home/askeox/Documents/Agentic/.agent/testimony/
+-- agentic_testimony_2026-01-23.md
+-- cv-generator-agent_testimony_2026-01-23.md
+-- glinet-be3600_testimony_2026-01-23.md
+-- mirobot_testimony_2026-01-23.md
+-- survival_testimony_2026-01-23.md
+-- uniqure_testimony_2026-01-23.md
```

This dual-write approach ensures:
- Projects have their own historical record accessible locally
- Cross-project analysis is possible from the central hub
- Testimonies inform agent improvements in the Agentic hub

### Versioning

If regenerating same day:
- First: `project_testimony_2026-01-23.md`
- Second: `project_testimony_2026-01-23_v2.md`
- Third: `project_testimony_2026-01-23_v3.md`

---

## Examples

### Example 1: Invoking for Current Project

```
User: /agent_reflect

Assistant: I will analyze the .agent/ knowledge base and generate a comprehensive
project journey testimony document.

[Reads .agent/ files, extracts insights, generates testimony]

Result: Testimonies generated at:
- Project: ./.agent/testimony/agentic_testimony_2026-01-23.md
- Central: /home/askeox/Documents/Agentic/.agent/testimony/agentic_testimony_2026-01-23.md

### Example 2: Specific Project Path

```
User: /agent_reflect /home/askeox/Documents/CV_Generator_Agent

Assistant: I will analyze the .agent/ knowledge base at the specified path
and generate a project journey testimony.

[Reads CV_Generator_Agent/.agent/ files]

Result: Testimonies generated at:
- Project: /home/askeox/Documents/CV_Generator_Agent/.agent/testimony/cv-generator-agent_testimony_2026-01-23.md
- Central: /home/askeox/Documents/Agentic/.agent/testimony/cv-generator-agent_testimony_2026-01-23.md

---

## Best Practices

### Objectivity
- Report only what is documented in .agent/ files
- Never fabricate events or outcomes
- Clearly mark gaps where documentation is missing
- Use direct quotes when possible for evidence

### Completeness
- Read all priority files before synthesizing
- Check for phase completion documents
- Include metrics if available
- Note what documentation would improve future reflections

### Consistency
- Use the template structure exactly
- Apply consistent date formatting (YYYY-MM-DD)
- Use consistent naming conventions for outputs
- Maintain professional, objective tone

### When to Regenerate
- After significant project milestones
- When .agent/ documentation has been substantially updated
- Before project handoff or retrospectives
- Quarterly for ongoing projects

---

## Cross-Project Analysis

After generating testimonies for multiple projects, you can synthesize patterns:

### Process
1. Run `/agent_reflect` on each project
2. Collect all testimonies in the output directory
3. Request cross-project analysis:
   ```
   User: Analyze the testimonies in /home/askeox/Documents/Agentic/.agent/testimony/ and create a cross-project synthesis
   ```

### Cross-Project Output Structure
```markdown
# Cross-Project Analysis: Agent-Assisted Development

**Projects Analyzed**: [List]
**Date Range**: [Earliest to Latest]

## Universal Patterns
- [Patterns found across 3+ projects]

## Project-Specific Successes
- [Unique wins per project]

## Common Failure Modes
- [Patterns that failed multiple times]

## Recommendations
- [Synthesized guidance for new projects]
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-01-23 | Initial release |
| 1.1.0 | 2026-01-23 | Dual-write: project-local + central hub; added project tracker |
| 1.2.0 | 2026-01-24 | Added telemetry integration: Agent Usage Telemetry section with quantitative metrics |

---

**Command Created**: 2026-01-23
**Purpose**: Generate project journey testimonies for cross-project learning
**Status**: Active
