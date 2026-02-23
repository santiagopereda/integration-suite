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
| **Memory Output** | `/home/askeox/Documents/Agentic/.agent/memory/agents/` |
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

### Step 9: Extract Patterns from Testimony

After the testimony is written, extract actionable patterns for agent memory:

1. Read the testimony just generated (from the project-local path)
2. Parse each extractable section:
   - **"What Failed and Corrections Made"** → failure patterns (extract: Initial Assumption, Lesson Learned)
   - **"What Worked Well"** → success patterns (extract: Transferable Insight)
   - **"Lessons Learned"** → technical/process/collaboration patterns
   - **"Initial Assumptions That Needed Clarification"** → assumption-correction patterns (extract: Assumption, Reality)
   - **"Recommendations for Future Projects"** → do/avoid/consider patterns
   - **"Metrics and Outcomes"** → quantitative validation patterns (extract: significant deltas)
3. For each extracted pattern:
   - Assign a category ID (see Pattern ID Convention below)
   - Route to the appropriate agent memory file(s) using the Extraction Routing table
   - Format using the Pattern Template
4. Deduplicate against existing patterns in the target memory file:
   - If same insight already exists from another project, add this project as additional source
   - If genuinely new, append with next sequence number in the category

**Extraction Routing** (content-based keyword matching):

| Keywords in pattern | Route to agent memory |
|---|---|
| parsing, export, workspace, XML, artifact count, recycle bin, call graph | `agent-integration-analyzer` |
| assessment, dimension, methodology, walkthrough, data source, interview | `agent-integration-assessor` |
| score, weighted, maturity, red flag, quick win, benchmark, calculation | `agent-integration-scorer` |
| security, OWASP, review finding, credential, encryption, audit | `agent-integration-reviewer` |
| architecture, pattern, design, improvement, roadmap, migration | `agent-integration-designer` |
| documentation, customer summary, deliverable, template, artifact | `documentation-specialist` |
| pipeline, agent, process, collaboration, verification, first-pass | `_shared-patterns` |

Patterns can route to multiple agents if they span domains.

### Step 10: Write Agent Memory Updates

1. For each agent with new patterns, read its memory file from hub:
   `/home/askeox/Documents/Agentic/.agent/memory/agents/{agent-id}-memory.md`
2. If the file doesn't exist, create it with the Memory File Template (see below)
3. Append new patterns under the appropriate category section
4. Update the header metadata:
   - `Last Updated` → current date
   - `Patterns From` → increment project count, add project name to list
   - `Total Patterns` → increment count
5. Update `_shared-patterns.md` with universal patterns
6. Log pattern extraction summary to console:
   ```
   Pattern extraction complete:
   - [N] patterns extracted from testimony
   - Agents updated: [list of agent-ids]
   - New patterns: [count], Deduplicated: [count]
   ```

### Step 11: Update Reflection Pool

After memory updates complete, update the two reflection pool files that must stay current with every new testimony.

#### 11a. Update `key-insights.md`

File: `/home/askeox/Documents/Agentic/.agent/reflection_pool/key-insights.md`

1. Read the testimony's "What Worked Well" and "Lessons Learned" sections
2. Extract **2–4 quotable insights** that are:
   - Clear and transferable (applies beyond this specific project)
   - Evidence-backed (tied to a concrete outcome or metric in the testimony)
   - Not already present in key-insights.md (check for semantic duplicates, not just string matches)
3. Format each using the standard blockquote format:
   ```markdown
   > **"[Insight as a concise, quotable statement.]"**
   > — [Project Name]
   >
   > *[One sentence of context — what situation produced this insight and why it matters.]*
   ```
4. Assign each to the most relevant section:
   - "On Workflows & Process" — how the work was done
   - "On Architecture & Design" — structural/technical decisions
   - "On Documentation" — recording and communicating work
   - "On Validation & Testing" — confirming correctness
   - "On Completeness" — coverage and readiness
   - "On Structure" — project organization
   - Create a new section only if none of the above fit
5. Append each insight to its section (add after the last existing `>` block in the section, before the `---`)
6. Update the metadata footer:
   - Increment the project count in "Extracted From: N project testimonies"
   - Add the project name to the Projects list if not already present
   - Update "last updated" date

**If no new quotable insights** (testimony confirms existing patterns without adding new ones): add a note to the project name in the footer only — do not force quotes.

#### 11b. Update `directory-usage-analysis.md`

File: `/home/askeox/Documents/Agentic/.agent/reflection_pool/directory-usage-analysis.md`

1. Scan the reflected project's `.agent/` directory:
   ```bash
   ls -la {project}/.agent/
   ```
2. For each tracked directory type, classify as:
   - **Used** — directory exists AND contains files beyond README.md
   - **Template** — directory exists but contains ONLY README.md
   - **N/A** — directory does not exist
3. Add the project as a new column to the Usage Matrix table
4. Recalculate usage rates (%) for each directory type:
   - Rate = (count of "Used" entries) / (total projects in matrix) × 100
5. Update the "Projects Analyzed: N" count in the file header
6. If the project type (integration, development, research, optimization) is represented for the first time: update the relevant "Usage Patterns by Project Type" section to confirm or correct the hypothesized pattern with actual evidence

**Do not** rewrite the analysis text — only update the matrix data and project count. The analysis text is updated manually when patterns shift.

#### 11c. Update `value-unlock-index.md`

File: `/home/askeox/Documents/Agentic/.agent/reflection_pool/value-unlock-index.md`

1. Read the testimony's "What Worked Well," "What Failed and Corrections Made," and "Lessons Learned" sections
2. Identify moments where **one action produced a disproportionate outcome** — a blocker removed, a wrong assumption corrected, a significant effort saved, or a framework established that changed everything downstream
3. For each qualifying moment, check if it fits an existing situation category in the index:
   - If yes: add the entry under that category
   - If no: create a new situation category only if it's clearly distinct from existing ones
4. Format each entry:
   ```markdown
   ### [Situation title — specific enough to match when you're in it]
   **Intervention**: [What was done — specific and actionable, not a category label]
   **Outcome**: [What resulted — quantified if possible]
   **Project**: [Name] ([YYYY-MM])
   ```
5. After adding entries, check the Meta-Patterns section — does the new entry strengthen an existing meta-pattern or suggest a new one? Update M1–M4 sources list if applicable.
6. Update the header: increment entry count and update "Last Updated" date

**If no qualifying unlock moment** (testimony documents steady progress without a single high-leverage pivot): skip this update. Not every project has a value unlock; don't force entries.

#### 11d. Update `eureka-moments.md`

File: `/home/askeox/Documents/Agentic/.agent/reflection_pool/eureka-moments.md`

1. Read the testimony's "What Failed and Corrections Made," "Evolution of Thinking," and "Lessons Learned" sections
2. Identify moments where **a wrong mental model was replaced by a correct one** — a realization that changed how the entire problem was framed, not just what action was taken. Three signals:
   - There is a clear **Before** state (a wrong assumption that was actively in use)
   - A specific **trigger** forced the realization (not gradual learning — a moment)
   - The new understanding **generalizes** beyond the specific technology or project
3. For each qualifying moment, check the "Why it generalizes" fields in existing entries:
   - If a new entry strengthens an existing entry: add the new project as a source in that entry, don't create a duplicate
   - If genuinely new: add under the closest domain category
4. Format:
   ```markdown
   ### [Insight title — what the new mental model is, stated positively]

   **Before**: [The wrong assumption that was actively in use]
   **The realization**: [The specific understanding that replaced it]
   **Why it generalizes**: [What other domains or situations this applies to]
   **Trigger**: [What evidence or event forced the realization]
   **Projects**: [Name] ([YYYY-MM])
   ```
5. Update the header: increment entry count and update "Last Updated" date

**If no qualifying eureka moment** (testimony shows steady learning without a frame-breaking realization): skip this update. Eureka moments are rare — most testimonies will have 0–1.

#### 11e. Update `decision-journal.md`

File: `/home/askeox/Documents/Agentic/.agent/reflection_pool/decision-journal.md`

1. Read the testimony's "Timeline of Key Events," "Evolution of Thinking," and "What Failed and Corrections Made" sections
2. Identify **1–3 significant decision forks** — moments where multiple approaches were viable, one was chosen, and the reasoning is documented. Qualifying signals:
   - Alternatives were explicitly compared before a path was selected
   - A design choice could have gone a different direction (architecture, scope, tool selection)
   - A path was abandoned after being tried, with a stated reason for switching
3. For each qualifying fork, reconstruct the entry as accurately as the testimony allows:
   ```markdown
   ## [Decision label — verb + noun, specific enough to find later]
   **Context**: [1-2 sentences — what was being built and what created the fork]
   **Options**: A) [option] / B) [option] / C) [option if applicable]
   **Chosen**: [A/B/C] — [primary reason in one sentence]
   **Reasoning**: [Why this over the alternatives — 2-3 sentences]
   **Reversal condition**: [What evidence or constraint change would justify switching]
   **Date**: YYYY-MM-DD | **Project**: [name] | **Source**: Reconstructed
   ```
4. Append entries before the file's footer section
5. Update the `Entries` count in the file header

**If no qualifying fork** (project followed a single clear path throughout): skip this update. Not every project has a documented decision fork.

**Note**: Entries marked `Reconstructed` have lower fidelity than live entries written during sessions. The `Source` field tracks this distinction.

#### 11f. Log Reflection Pool Summary

After all updates, output:
```
Reflection pool updated:
- key-insights.md: [N] new insights added to [section names]
- directory-usage-analysis.md: [project] added to matrix ([used dirs] used, [template dirs] template)
- value-unlock-index.md: [N] new entries added to [situation categories] / no qualifying unlock moments
- eureka-moments.md: [N] new entries added / [N] existing entries strengthened / no qualifying moments
- decision-journal.md: [N] new entries added (Reconstructed) / no qualifying forks
- Note: Cross-project testimony-analysis files are updated in batches — run manually when 3+ new testimonies accumulate
```

---

## Pattern Format Specification

### Pattern Template

Each extracted pattern follows this structure:

```markdown
### [ID]: [Title]
- **Pattern**: [What was observed — 1-2 sentences]
- **Source**: [Project name] ([YYYY-MM-DD])
- **Action**: [What the agent should do about it — imperative]
- **Tags**: [platform], [category]
```

### Pattern ID Convention

3-letter category prefix + 3-digit sequence number.

| Agent | Prefix | Category |
|-------|--------|----------|
| analyzer | `EXT-` | Extraction |
| analyzer | `PRS-` | Parsing |
| analyzer | `INV-` | Inventory |
| assessor | `ASM-` | Assessment methodology |
| assessor | `DIM-` | Dimension-specific |
| assessor | `SRC-` | Data sources |
| scorer | `SCA-` | Scoring accuracy |
| scorer | `WGT-` | Weighting |
| scorer | `BNC-` | Benchmarking |
| reviewer | `SEC-` | Security |
| reviewer | `DRV-` | Design review |
| reviewer | `APT-` | Anti-patterns |
| designer | `ARC-` | Architecture |
| designer | `PAT-` | Patterns |
| designer | `IMP-` | Improvement roadmap |
| documentation | `DOC-` | Documentation |
| documentation | `TMY-` | Testimony |
| documentation | `DLV-` | Deliverables |
| _shared | `UNI-` | Universal |

### Memory File Template

```markdown
# Agent Memory: [agent-id]

**Last Updated**: [YYYY-MM-DD]
**Patterns From**: [N] projects ([comma-separated project names])
**Total Patterns**: [count]

---

## [Category Name]

### [ID]: [Title]
- **Pattern**: [observation]
- **Source**: [project] ([date])
- **Action**: [what to do]
- **Tags**: [platform], [category]

---
```

### Deduplication Rules

1. **Same insight, new project**: Add project as additional source
   ```
   - **Source**: Talend-Reviewer (2026-02-20), UniQure (2026-01-23)
   ```
2. **Refined insight**: Update the Pattern and Action text, keep all sources
3. **Genuinely new**: Append with next sequence number in category

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
    +-> Steps 1-7: Gather data from .agent/, synthesize
    |
    +-> Step 8: Dual-write testimony (project-local + central hub)
    |
    +-> Step 9: Extract patterns from testimony
    |   - Parse sections for transferable insights
    |   - Route patterns to agent memory files by content keywords
    |   - Deduplicate against existing patterns
    |
    +-> Step 10: Write agent memory updates
    |   - Update per-agent memory files in hub
    |   - Update _shared-patterns.md for universal patterns
    |   - Log extraction summary
    |
    +-> Step 11: Update reflection pool (enforced on every run)
        - key-insights.md: 2-4 new quotable insights extracted and appended
        - directory-usage-analysis.md: project added to usage matrix, rates recalculated
        - value-unlock-index.md: high-leverage interventions added by situation type
        - eureka-moments.md: frame-breaking realizations added or existing entries strengthened
        - decision-journal.md: significant decision forks reconstructed from testimony
        - Log what was updated (value unlocks, eureka, and decisions skipped if no qualifying moments)
        - Note: testimony-analysis files are batched manually (not per-run)
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
| 1.3.0 | 2026-02-20 | Pattern extraction: auto-extracts patterns from testimony to per-agent memory files in hub |
| 1.4.0 | 2026-02-21 | Reflection pool enforcement: Step 11 updates key-insights.md and directory-usage-analysis.md on every run |
| 1.5.0 | 2026-02-21 | Extended Step 11: value-unlock-index.md (situation→intervention) and eureka-moments.md (mental model shifts) |
| 1.6.0 | 2026-02-21 | Step 11e: decision-journal.md (reconstructed decision forks from testimony); live entries via CLAUDE.md rule |

---

**Command Created**: 2026-01-23
**Purpose**: Generate project journey testimonies for cross-project learning
**Status**: Active
