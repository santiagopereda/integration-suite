# /project_init - Project Initialization Command

Initialize new projects with type-appropriate structure, documentation, and provisioned agents based on learnings from cross-project testimony analysis.

## Purpose

This command creates optimized project setups by:
- Classifying project type (Integration, Development, Research, Optimization)
- Creating type-appropriate `.agent/` folder structure
- Generating CLAUDE.md and README.md with project-specific content
- Provisioning default and selected agents from the Agentic hub
- Initializing `injection-history.md` audit trail

## Quick Reference

| Aspect | Details |
|--------|---------|
| **Invocation** | `/project_init` or `/project_init [path]` |
| **Agent Used** | `agent-project-init` |
| **Hub Source** | `/home/askeox/Documents/Agentic` |
| **Default Agents** | research-assistant, documentation-specialist, agent-git-manager |
| **Default Commands** | update_doc, agent_reflect |

---

## Usage

### Initialize Current Directory

```bash
/project_init
```

Initializes the current working directory as an agent-enabled project.

### Initialize Specific Path

```bash
/project_init /path/to/project
```

Initializes the specified path. Creates the directory if it doesn't exist.

---

## Workflow

The command triggers a 7-step interactive workflow:

### 1. DISCOVER
- Checks for existing README.md, CLAUDE.md, .agent/
- Reads existing files for context
- Flags existing content for "ask before modify" behavior

### 2. CLASSIFY
User selects project type:

| Type | Description | Structure Created |
|------|-------------|-------------------|
| **Integration** | APIs, data flows, sync | sops/, system/, workflows/ |
| **Development** | Building software | decisions/, schemas/, testing/ |
| **Research** | Exploration, learning | findings/, hypotheses/, gaps/ |
| **Optimization** | Improving existing | templates/, metrics/, experiments/ |
| **Custom** | User-defined | User selects folders |

### 3. DEFINE
Gather project information:
- Project name
- Project goals (1-3 sentences)
- Key resources/technologies
- Known constraints

### 4. STRUCTURE
Creates `.agent/` with:
- `README.md` - Knowledge base overview
- `injection-history.md` - Audit trail (100% usage across all projects)
- Type-specific folders (no empty templates)

### 5. DOCUMENT
Creates or updates:
- `CLAUDE.md` - Project configuration with agents, commands, goals
- `README.md` - Project description and structure

**If files exist**: Shows proposed changes, asks for confirmation.

### 6. PROVISION
Syncs from Agentic hub:

**Default (always included)**:
- `research-assistant.md`
- `documentation-specialist.md`
- `agent-git-manager.md`
- `update_doc.md` command
- `agent_reflect.md` command

**Optional (user selects)**:
- agent-sap-businesspartner-integration
- agent-ansible-automation
- agent-cv-optimizer
- agent-robotarm-tester
- agent-architect
- agent-provisioner

### 7. CONFIRM
Shows summary of all changes, executes only after user approval.

---

## Project Type Structures

### Integration Projects

Best for: API integrations, ETL pipelines, data synchronization

```
.agent/
├── README.md
├── injection-history.md
├── sops/              # Repeatable procedures
├── system/            # Schemas, APIs, mappings
└── workflows/         # Integration flow docs
```

### Development Projects

Best for: Web apps, CLI tools, libraries, features

```
.agent/
├── README.md
├── injection-history.md
├── decisions/         # Architecture Decision Records
├── schemas/           # Data models
└── testing/           # Test strategies
```

### Research Projects

Best for: Spikes, POCs, learning projects, investigations

```
.agent/
├── README.md
├── injection-history.md
├── findings/          # What was discovered
├── hypotheses/        # Assumptions to test
└── gaps/              # What's still unknown
```

### Optimization Projects

Best for: Refactoring, performance tuning, migrations

```
.agent/
├── README.md
├── injection-history.md
├── templates/         # Externalized content
├── metrics/           # Baselines and tracking
└── experiments/       # What was tried
```

---

## Examples

### Example 1: New Research Project

```
User: /project_init /home/user/auth-patterns-research

Agent: I'll initialize a new project at /home/user/auth-patterns-research.

Creating directory: /home/user/auth-patterns-research

What type of project is this?
[ ] Integration - APIs, data flows, synchronization
[ ] Development - Building software, features
[x] Research - Exploration, investigation, learning
[ ] Optimization - Improving existing systems
[ ] Custom - Define your own structure

User: Research

Agent: Great, a research project. Let me gather some details.

What is the project name?
> Authentication Patterns Research

Describe the project goals (1-3 sentences):
> Investigate modern authentication patterns (OAuth, JWT, passkeys) and
> document best practices for enterprise applications.

What key resources/technologies are involved?
> OAuth 2.0, JWT, WebAuthn, OIDC

Any known constraints?
> Must support SSO integration

[Creates structure, shows summary, asks for confirmation]

Initialization complete!
- Created .agent/ with research structure (findings/, hypotheses/, gaps/)
- Created CLAUDE.md with project configuration
- Created README.md with project overview
- Provisioned 3 agents + 2 commands

Next steps:
1. Start documenting findings in .agent/findings/
2. Track assumptions in .agent/hypotheses/
3. Use /update_doc to maintain documentation
```

### Example 2: Existing Project

```
User: /project_init

Agent: Analyzing current directory...

Found existing files:
- README.md (423 lines)
- CLAUDE.md (not found)
- .agent/ (not found)

I'll read README.md for context...

This appears to be a Node.js web application.

What type of project is this?
[x] Development - Building software, features

[Continues workflow, proposes additions to README.md]

CLAUDE.md will be created with:
- Project type: Development
- Available agents section
- Knowledge base reference

README.md changes proposed:
+ ## Project Structure
+ [adds .agent/ and .claude/ documentation]

Apply these changes? [Y/n]
```

---

## Design Principles

This command applies learnings from testimony analysis:

| Principle | Application |
|-----------|-------------|
| **Descriptive over prescriptive** | Only creates folders that will be used based on project type |
| **No empty templates** | Initializes files with real content, not placeholders |
| **injection-history.md always** | 100% usage rate in analyzed projects |
| **Verification mindset** | Reads existing files, proposes changes, asks before modifying |
| **Default sensible** | Pushes common agents by default |

---

## Post-Initialization

After initialization:

1. **Start working** - The structure is ready to use
2. **Update as you go** - Use `/update_doc` to maintain documentation
3. **Track progress** - All changes should update `injection-history.md`
4. **Reflect periodically** - Use `/agent_reflect` to generate journey testimonies

---

## Troubleshooting

### "Permission denied" when creating directory

Ensure you have write permissions to the parent directory, or run with appropriate privileges.

### "Agent not found" during provisioning

The hub may be missing the requested agent. Check:
```bash
ls /home/askeox/Documents/Agentic/.claude/agents/
```

### Existing files not detected

Ensure you're in the correct directory or provide the full path.

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-01-23 | Initial release |

---

**Command Created**: 2026-01-23
**Purpose**: Initialize projects with type-appropriate structure and agents
**Status**: Active
