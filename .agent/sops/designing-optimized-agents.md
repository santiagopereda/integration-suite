# Designing Optimized Agents

**Purpose**: Guidelines for creating new agents with optimization patterns from the start (design-time optimization).

**Status**: VALIDATED (agent-project-init as exemplar)

**Last Updated**: 2026-02-22

---

## Core Principle

**Design-time optimization > Retrofit optimization**

**Evidence**: agent-project-init was designed with 5 external templates from creation (~6.4K content externalized). Zero optimization effort needed. Retrofitting similar agents took 2.5 hours each for 15-52% reduction.

**ROI**: Design with templates from start = 100% savings on retrofit effort + better separation of concerns.

---

## Quick Checklist

When designing a new agent, ask:

- [ ] Does this agent include document templates, configuration structures, or reference content >100 words?
  - ✅ YES → Externalize to `.agent/templates/{domain}/`
  - ❌ NO → Keep inline

- [ ] Does this agent have workflow procedures or step-by-step guides?
  - ✅ Keep inline (core logic, not reference content)

- [ ] Does this agent have small frequently-accessed tables (<150 words)?
  - ✅ Keep inline (workflow decision data)

- [ ] Will this agent be deployed to multiple projects?
  - ✅ YES → Templates are more valuable (reusable across deployments)

- [ ] Does this agent have low-context reference content (tables, examples, configs)?
  - ✅ YES → High externalization value (clean separation)

---

## Design Patterns

### Pattern 1: Externalize Reference Content

**What to Externalize**:
- Document templates (CLAUDE.md, README.md, etc.)
- Configuration structures (YAML, JSON examples)
- Directory/folder structures
- Code examples and snippets
- Reference tables (if not frequently accessed inline)
- Checklists (if standalone, not embedded in workflow)
- Pattern catalogs

**What NOT to Externalize**:
- Core workflow logic (step-by-step procedures)
- Decision procedures (when to use which approach)
- Agent identity statements (expertise, responsibilities)
- Small frequently-accessed tables (<150 words - workflow decision data)
- Conceptual guidance (philosophy, approach)

**Example from agent-project-init**:

**✅ Externalized**:
- `folder-structures.md` - Project type directory structures (1.7K)
- `claude-md-template.md` - CLAUDE.md document template (1.8K)
- `readme-md-template.md` - README.md document template (885 bytes)
- `agent-readme-template.md` - .agent/README.md template (1.3K)
- `injection-history-template.md` - Initial entry template (749 bytes)

**✅ Kept Inline**:
- 7-step workflow procedure (HOW to initialize projects)
- Project Types table (60 words - classification decision)
- Available Agents table (100 words - provisioning decisions)
- Decision logic (WHEN to use which template)

**Result**: 2,655 tokens agent definition + ~6.4K templates (lazy-loaded)

---

### Pattern 2: Use Lazy Loading

**Approach**: Reference templates on demand, don't load at agent definition read time.

**Format**:
```markdown
Load template from: `.agent/templates/{domain}/{template-name}.md`
```

**Example from agent-project-init**:
```markdown
### Step 5: DOCUMENT

**If creating new CLAUDE.md**:

Load template from: `.agent/templates/project-init/claude-md-template.md`

Fill placeholders: `{project_name}`, `{project_type}`, `{project_goals}`, ...
```

**Benefits**:
- Baseline agent tokens minimized
- Full content loaded only when that step is executed
- Templates can be updated without touching agent definition

---

### Pattern 3: Create Template Index

**Approach**: Include a small table listing all templates for discoverability.

**Format**:
```markdown
## File Templates

Templates are externalized to reduce agent size. Load when needed during Step X.

| Template | Path | When to Load |
|----------|------|--------------|
| Template A | `.agent/templates/domain/a.md` | Step 2: Creating A |
| Template B | `.agent/templates/domain/b.md` | Step 3: Creating B |
```

**Example from agent-project-init** (lines 239-243):
```markdown
## File Templates

| Template | Path | When to Load |
|----------|------|--------------|
| .agent/README.md | `.agent/templates/project-init/agent-readme-template.md` | Step 5: Creating .agent/README.md |
| injection-history.md | `.agent/templates/project-init/injection-history-template.md` | Step 5: Creating initial entry |
```

**Benefits**:
- Users know templates exist
- Clear when each template is needed
- Navigation aid without loading content

---

### Pattern 4: Organize by Domain

**Directory Structure**:
```
.agent/templates/
├── integration/       # Integration-specific templates
├── career/           # Career/CV templates
├── git/              # Git workflow templates
├── project-init/     # Project initialization templates
├── optimization/     # Agent optimization templates
└── robotics/         # Robotics-specific templates
```

**Benefits**:
- Templates grouped by domain/purpose
- Reusable across related agents
- Clear ownership and maintenance

**Example**: agent-project-init uses `project-init/` domain, agent-cv-optimizer uses `career/` domain.

---

### Pattern 5: Keep Core Tables Inline

**Small frequently-accessed tables** (<150 words) that are:
- Used in workflow decision logic
- Referenced multiple times
- Updated frequently (hub awareness, available options)

**Should stay inline** even if they're low-context content.

**Example from agent-project-init**:

**Project Types Table** (60 words, lines 88-94):
```markdown
| Type | Description | Use Cases |
|------|-------------|-----------|
| Integration | APIs, data flows, synchronization | ETL pipelines, API integrations |
| Development | Building software, features | Web apps, CLI tools |
| Research | Exploration, investigation | Spikes, POCs, learning |
| ...
```

**Why inline**: Used in Step 2 (CLASSIFY) for interactive decision. Frequently accessed, small size, core to workflow.

**Contrast**: Heavy folder structures externalized to `folder-structures.md` (larger, standalone reference).

---

## Template Design Guidelines

### Template Structure

```markdown
# {Template Name}

**Purpose**: Brief description of what this template provides

**Usage**: When to use this template (which step/scenario)

**Placeholders** (if applicable):
- `{placeholder_1}`: Description
- `{placeholder_2}`: Description

---

## Template Content

[The actual template content here]

---

**Version**: 1.0
**Last Updated**: YYYY-MM-DD
```

### Template Best Practices

1. **Self-contained**: Templates should be understandable standalone
2. **Clear placeholders**: Use `{descriptive_name}` format for variables
3. **Purpose statement**: Explain why this template exists
4. **Versioning**: Include version and date (for tracking changes)
5. **Examples**: Include usage examples if template is complex

**Example**: `.agent/templates/project-init/claude-md-template.md` has clear `{project_name}`, `{project_type}` placeholders with descriptions.

---

## Content Type Classification

When deciding what to externalize, classify content type:

### Low-Context Content (High externalization value)

**Characteristics**:
- Can be understood standalone
- No surrounding narrative needed
- Reference data, examples, structures

**Examples**:
- Tables and lists
- Code examples (without context)
- Configuration templates
- Directory structures
- API reference data

**Externalization benefit**: **High** (60-80% reduction ratio)

### High-Context Content (Lower externalization value)

**Characteristics**:
- Requires context to understand
- Step-by-step procedures
- Decision workflows
- Conceptual guidance

**Examples**:
- Workflow procedures ("First do X, then do Y because...")
- Decision trees with explanations
- Troubleshooting guides with context
- Conceptual frameworks

**Externalization benefit**: **Lower** (30-40% reduction ratio - needs inline summaries)

**Guideline**: Externalize low-context content, keep high-context inline.

---

## Example: agent-project-init Breakdown

### Agent Definition (2,655 tokens)

**What's Inline**:
- Agent identity and expertise statement
- 7-step workflow procedure (65-233 lines)
- Project Types table (60 words - decision data)
- Available Agents table (100 words - provisioning decisions)
- File Templates index (40 words - navigation)
- Critical constraints and error handling

**What's Externalized** (5 templates, ~6.4K total):
1. folder-structures.md (1.7K) - Project type directory structures
2. claude-md-template.md (1.8K) - CLAUDE.md document template
3. readme-md-template.md (885 bytes) - README.md document template
4. agent-readme-template.md (1.3K) - .agent/README.md template
5. injection-history-template.md (749 bytes) - Initial entry template

### Why This Works

**Separation of Concerns**:
- Agent = workflow logic (HOW to initialize)
- Templates = content artifacts (WHAT to create)

**Maintainability**:
- Update document templates → only touch template files
- Update workflow logic → only touch agent definition
- No interdependency

**Reusability**:
- Templates can be used by other agents
- Templates can be referenced in documentation
- Templates can be provisioned standalone

**Performance**:
- Baseline agent: 2,655 tokens (loaded at session start)
- Templates: 6,400 tokens (loaded only when Step 5 executes)
- 70% of content lazy-loaded

---

## Common Design Mistakes

### ❌ Mistake 1: Embedding Large Templates Inline

**Bad**:
```markdown
## CLAUDE.md Template

Create CLAUDE.md with this content:

# CLAUDE.md - {Project Name}

[300+ lines of template content embedded inline]
```

**Good**:
```markdown
## CLAUDE.md Template

Load template from: `.agent/templates/project-init/claude-md-template.md`

Fill placeholders: `{project_name}`, `{project_type}`, `{project_goals}`
```

**Impact**: Bad approach adds ~1,200 tokens to agent definition. Good approach adds ~30 tokens.

---

### ❌ Mistake 2: Externalizing Core Workflow Logic

**Bad**:
```markdown
## Workflow Steps

Load workflow from: `.agent/templates/agent-name/workflow.md`

Execute steps 1-7 from template.
```

**Good**:
```markdown
## Workflow Steps

### Step 1: DISCOVER
Check the target path for existing files...

### Step 2: CLASSIFY
Ask the user what type of project this is...

[Full workflow inline with decision logic]
```

**Impact**: Bad approach fragments workflow coherence, creates high documentation overhead.

---

### ❌ Mistake 3: Externalizing Small Frequently-Accessed Tables

**Bad**:
```markdown
Available project types:

Load from: `.agent/templates/project-init/project-types.md`
```

**Good**:
```markdown
**Project Types**:

| Type | Description | Use Cases |
|------|-------------|-----------|
| Integration | APIs, data flows | ETL pipelines |
| Development | Building software | Web apps |
| Research | Exploration | Spikes, POCs |
```

**Impact**: Bad approach adds lazy-loading overhead for 60-word table referenced in workflow decision.

---

### ❌ Mistake 4: No Template Index

**Bad**: Agent references templates throughout definition, but no centralized list.

**Good**: Single "File Templates" or "Template Usage" section listing all templates with paths and when to use them.

**Impact**: Bad approach = poor discoverability, users don't know what templates exist.

---

## Design Workflow

### Step 1: Define Agent Scope and Workflow

Start with core workflow logic:
1. What are the main steps?
2. What decisions does the agent make?
3. What are the inputs and outputs?
4. What are the constraints?

**Keep this inline** - it's the agent's identity.

### Step 2: Identify Reference Content

Look for content >100 words that is:
- Document templates
- Configuration examples
- Reference tables (not decision data)
- Code snippets
- Checklists (standalone)

**Mark these for externalization.**

### Step 3: Classify Content Type

For each externalizable section:
- **Low-context** (can be understood standalone)? → High value
- **High-context** (needs surrounding narrative)? → Lower value, consider keeping inline

### Step 4: Create Templates

For each marked section:
1. Create template file: `.agent/templates/{domain}/{name}.md`
2. Add purpose, usage, placeholders
3. Move content from agent to template
4. Add reference in agent: "Load from: `.agent/templates/...`"

### Step 5: Add Template Index

Create "File Templates" or "Template Usage" section:
- Table with template name, path, when to use
- Keep it small (<50 words total)
- Aids discoverability without loading content

### Step 6: Validate Separation

Check that:
- [ ] Agent contains workflow logic + decision procedures
- [ ] Templates contain reference content + structures
- [ ] No duplication between agent and templates
- [ ] All template references have valid paths
- [ ] Template index complete

### Step 7: Test

1. Read agent definition - is workflow clear without loading templates?
2. Load each template - is it self-contained and useful?
3. Execute workflow - are templates loaded at right time?
4. Verify lazy loading - are templates referenced on demand?

---

## ROI Calculation

**Design-time optimization** (agent-project-init):
- Effort: ~1 hour extra during initial design (creating templates)
- Baseline: 2,655 tokens (vs. ~9,000 if templates embedded)
- Savings: ~6,400 tokens (71% reduction achieved from design)
- Retrofit avoided: 0 hours (no optimization campaign needed later)
- **Total ROI**: 1 hour investment saves 2.5 hours retrofit effort

**Retrofit optimization** (typical agent):
- Effort: 2.5 hours (measurement, analysis, implementation, validation)
- Baseline: 3,000-6,000 tokens
- Savings: 15-60% reduction (depending on content type)
- **Total ROI**: 2.5 hours investment for variable savings

**Conclusion**: Design-time optimization is **150% more efficient** (1 hour vs 2.5 hours for same or better outcome).

---

## Template Organization Examples

### Example 1: Single-Domain Agent

**Agent**: agent-robotarm-tester
**Templates**: 4 files in `.agent/templates/robotics/`
- test-session-log-format.md
- error-recovery-workflow.md
- ssh-command-patterns.md
- workspace-config-template.yml

**Pattern**: All templates in single domain folder (agent-specific).

### Example 2: Multi-Domain Agent

**Agent**: agent-project-init
**Templates**: 5 files in `.agent/templates/project-init/`
- folder-structures.md (for all project types)
- claude-md-template.md (reusable across agents)
- readme-md-template.md (reusable across agents)
- agent-readme-template.md (reusable)
- injection-history-template.md (reusable)

**Pattern**: Some templates agent-specific (`folder-structures.md`), others reusable (`claude-md-template.md`).

### Example 3: Shared Templates

**Scenario**: Multiple agents need same CLAUDE.md template

**Option A**: Duplicate template in each domain
- `.agent/templates/project-init/claude-md-template.md`
- `.agent/templates/integration/claude-md-template.md`

**Option B**: Create shared domain
- `.agent/templates/shared/claude-md-template.md`

**Recommendation**: Option A for now (simpler), Option B if 3+ agents share exact same template.

---

## Checklist for New Agents

When creating a new agent, complete this checklist:

**Design Phase**:
- [ ] Defined core workflow and decision logic
- [ ] Identified reference content >100 words
- [ ] Classified content type (low-context vs high-context)
- [ ] Decided what to externalize (based on content type)
- [ ] Chose template domain (create new or use existing)

**Implementation Phase**:
- [ ] Created template files in `.agent/templates/{domain}/`
- [ ] Added purpose, usage, placeholders to each template
- [ ] Referenced templates in agent using "Load from:" pattern
- [ ] Created Template Index section in agent
- [ ] Kept workflow logic inline (not externalized)
- [ ] Kept small decision tables inline (<150 words)

**Validation Phase**:
- [ ] Agent definition <5,000 tokens (if possible)
- [ ] All template paths valid and readable
- [ ] Templates self-contained (understandable standalone)
- [ ] No duplication between agent and templates
- [ ] Workflow readable without loading templates
- [ ] Quality gates applicable (fabrication prevention, constraints)

**Documentation Phase**:
- [ ] Added agent to `.agent/metrics/already-optimized-registry.md` (if using 3+ templates)
- [ ] Documented template usage in agent README (if exists)
- [ ] Verified templates appear in hub template library

---

## Success Metrics

**Agent qualifies as "Designed Optimized" if**:

1. ✅ Uses 3+ external templates
2. ✅ >30% of content externalized
3. ✅ Follows lazy loading pattern
4. ✅ Core workflow logic remains inline
5. ✅ Template Index section exists

**Add to Already Optimized Registry** if meets criteria.

---

## Reference Examples

**Exemplary**:
- agent-project-init (5 templates, 2,655 tokens agent, ~6.4K externalized)

**Good**:
- agent-cv-optimizer (6 templates, 1,654 tokens agent after retrofit optimization)
- agent-git-manager (4 templates, 2,013 tokens agent after retrofit optimization)

**Needs Design-Time Optimization**:
- agent-hub-orchestrator (0 templates, workflow-heavy but could externalize workflow templates)
- Future agents without external templates

---

## Future Enhancements

**Potential improvements** as more agents are designed:

1. **Template Generator**: Tool to create template skeleton with purpose/usage/placeholders
2. **Template Validator**: Check that all agent-referenced templates exist
3. **Template Catalog**: Hub-wide view of all templates with usage stats
4. **Cross-Agent Templates**: Identify templates usable by multiple agents

---

**Status**: VALIDATED (agent-project-init exemplar, campaign evidence)

**Use this guide when designing new agents to avoid retrofit optimization effort later.**

**See Also**:
- `.agent/metrics/already-optimized-registry.md` - Recognized exemplary agents
- `.agent/sops/agent-optimization-decision-tree.md` - When to optimize existing agents
- `.agent/reflection_pool/key-insights.md` - Campaign learnings (PAT-01 through PAT-05)
