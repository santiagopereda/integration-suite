# .agent/ Directory Usage Analysis

**Analysis Date**: 2026-01-23
**Projects Analyzed**: 6

---

## Actual Usage Matrix

| Directory | Agentic | CV Gen | GL.iNet | Mirobot | Survival | Client-A | Usage Rate |
|-----------|---------|--------|---------|---------|----------|---------|------------|
| **injection-history.md** | Used | Used | Used | Used | Used | Used | **100%** |
| **sops/** | Template | Template | 2 SOPs | Template | Template | 9 SOPs | 33% |
| **system/** | Used | Minimal | Minimal | Used | Template | 8 docs | 50% |
| **tasks/** | Template | Template | Template | Template | Template | 1 task | 17% |
| **templates/** | 13 files | N/A | N/A | 13 files | N/A | N/A | 33% |
| **metrics/** | Used | N/A | N/A | Described* | N/A | N/A | 17% |

*Mirobot: metrics/ described in docs but directory not found

---

## Key Findings

### Universally Used (100%)
- `injection-history.md` - Every project uses this effectively as audit trail

### Conditionally Used (33-50%)
- `sops/` - Only populated when procedures are needed (Client-A: integration, GL.iNet: security)
- `system/` - Used for project-specific schemas, APIs, context

### Rarely Used (17%)
- `tasks/` - 5/6 projects have only README template
- `metrics/` - Only optimization-focused projects

### Project-Specific
- `templates/` - Only agent development projects (Agentic, Mirobot)

---

## Original Design Intent vs. Reality

### What Was Designed

The `.agent/` structure was designed around a **waterfall workflow** assumption:

```
1. Write PRD           → tasks/[feature]/prd.md
2. Create plan         → tasks/[feature]/implementation-plan.md
3. Implement           → (referencing PRD and plan)
4. Create SOP          → sops/[category]/[process].md
5. Log mistakes        → sops/common-mistakes.md
```

**From .agent/README.md**:
> "**Agent Workflow**: Before Implementation: Turn on plan mode and create implementation plan... Store: Save plan to tasks/[feature-name]/implementation-plan.md"

> "**Generated After Tasks**: After completing a task... Ask the implementing agent to generate an SOP"

### What Actually Happens

| Design Assumed | Reality Observed |
|----------------|------------------|
| PRD written before coding | Most work starts without formal requirements |
| Implementation plan created before implementation | Plans emerge during implementation |
| SOP generated after every task | SOPs only created when procedures are truly repeatable |
| Linear workflow | Iterative, exploratory work |
| Formal process | Organic documentation |

### Why The Gap Exists

**1. Waterfall vs. Iterative Reality**

The design assumes you know what you're building before you build it. In practice:
- Requirements emerge through exploration
- Plans change during implementation
- "The task" evolves as you work

**2. SOPs Are Valuable Only When Procedures Repeat**

Projects that used `sops/` (Client-A, GL.iNet) had genuinely repeatable procedures:
- Integration workflows that run daily
- Security configurations that must be exact

Projects that didn't (Survival, CV Generator) were:
- One-time research/planning
- Exploratory work without repeatable patterns

**3. PRDs Add Friction Without Value for Solo/Exploratory Work**

Formal requirements documents help when:
- Multiple people need alignment
- Stakeholders need approval
- Compliance requires documentation

They don't help when:
- You're exploring alone
- Requirements are discovered through work
- Speed matters more than documentation

### The Core Insight

> **`injection-history.md` works at 100% because it's descriptive - it captures what happened.**
>
> **`tasks/` fails at 17% because it's prescriptive - it demands requirements before you know what you're building.**

The successful pattern is **document what you do**, not **document before you do**.

### Should We Enforce `tasks/` and `sops/`?

**Recommendation: No.**

| Argument | Counter-Argument |
|----------|------------------|
| "Consistency across projects" | Empty templates create false consistency |
| "Best practice to have PRDs" | Only if they're actually written and used |
| "SOPs improve quality" | Only if procedures actually repeat |
| "Structure helps new agents" | Empty structure misleads new agents |

**What Actually Works**: The projects that needed structure used it naturally. Client-A created 9 SOPs because integration procedures genuinely needed documentation - not because a template told them to.

### Alternative Approaches

**Option A: Make Optional with Clear Guidance**
```markdown
# tasks/ (Optional)
Use IF your project benefits from formal requirements.
Skip if you're doing exploratory/research work.
```

**Option B: Replace with Lighter Alternatives**
- `tasks/` → `goals.md` (single informal file)
- `sops/` → `procedures/` (created only when needed)

**Option C: Project-Type Templates**
Different starter structures for different project types, rather than one-size-fits-all.

---

## The "Empty Template" Problem

Multiple projects show this pattern:
```
.agent/
├── tasks/
│   └── README.md          # Only file - no actual PRDs
├── sops/
│   └── README.md          # Only file - no actual SOPs
└── system/
    └── README.md          # Only file - no actual docs
```

**Quote from CV Generator testimony**:
> "Features were implemented without formal PRDs"

**Quote from Survival testimony**:
> "No Task PRDs Created - only template exists"
> "No SOPs Created - only template exists"

---

## Usage Patterns by Project Type

### Integration Projects (Client-A, GL.iNet)
**Actually Used**:
- `sops/` - 9 SOPs (Client-A), 2 SOPs (GL.iNet)
- `system/` - Schemas, APIs, workflows

**Could Add**:
- `workflows/` - Integration flow documentation
- `resources/` - SQL, VQL, config files
- `verification/` - Test results, validations

### Optimization Projects (Agentic, Mirobot)
**Actually Used**:
- `templates/` - 13 externalized templates
- `metrics/` - Token baselines and tracking
- `system/` - Context documentation

**Could Add**:
- `baselines/` - Pre-optimization state
- `experiments/` - What was tried

### Research/Planning Projects (Survival, CV Generator)
**Actually Used**:
- Root-level category folders (food/, gear/, medical/)
- `injection-history.md`

**NOT Used**:
- Most `.agent/` subdirectories

**Could Add**:
- `findings/` - Research discoveries
- `hypotheses/` - Assumptions to validate
- `gaps/` - What's still unknown

### Development Projects
**Would Likely Use**:
- `schemas/` - Data models, API contracts
- `testing/` - Test strategies, coverage
- `decisions/` - Architecture decision log
- `debt/` - Technical debt tracking

---

## Recommended Structures

### Minimal Universal (All Projects)
```
.agent/
├── injection-history.md     # Always - 100% usage
├── README.md                # Navigation
└── [project-type-specific]/ # 2-3 relevant folders
```

### For Integration Projects
```
.agent/
├── injection-history.md
├── sops/                    # Procedures (actually used)
├── system/                  # Schemas, APIs
├── workflows/               # Integration flows
└── verification/            # Test results
```

### For Optimization Projects
```
.agent/
├── injection-history.md
├── templates/               # Externalized content
├── metrics/                 # Baselines, tracking
└── experiments/             # What was tried
```

### For Research/Planning Projects
```
.agent/
├── injection-history.md
├── findings/                # Research discoveries
├── hypotheses/              # Assumptions to validate
└── gaps/                    # What's still unknown
```

### For Development Projects
```
.agent/
├── injection-history.md
├── decisions/               # Architecture decisions
├── schemas/                 # Data models
└── testing/                 # Test strategies
```

---

## Recommendations

### 1. Drop Empty Template Pattern
Don't create directories with only README.md. Either:
- Populate them with actual content
- Create them when needed

### 2. Let Project Type Drive Structure
The Survival project's most useful work was in root-level `food/`, `gear/`, `medical/` - NOT in `.agent/`. Structure should follow the work.

### 3. Consider Project Type Declaration
In CLAUDE.md or .agent/README.md:
```yaml
project_type: research  # or: development, integration, optimization
```

### 4. Rename or Remove `tasks/`
Since PRDs aren't being written, consider:
- Renaming to `goals/` or `requirements/`
- Removing entirely
- Making optional based on project type

### 5. `injection-history.md` is Non-Negotiable
100% usage validates this as core value. Always include.

---

## When to Use Each Directory

| Directory | Use When |
|-----------|----------|
| `injection-history.md` | Always |
| `sops/` | Project has repeatable procedures (integration, config) |
| `system/` | Project has schemas, APIs, or context docs |
| `tasks/` | Formal PRD process is actually used |
| `templates/` | Agent optimization, externalized content |
| `metrics/` | Quantitative optimization tracking needed |
| `workflows/` | Integration flows to document |
| `findings/` | Research project with discoveries |
| `decisions/` | Architecture decisions to track |

---

**Analysis Generated By**: Claude Opus 4.5
**Source**: 6 project testimonies usage patterns
