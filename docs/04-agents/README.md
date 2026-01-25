# Agent Catalog

All 11 agents in the Agentic ecosystem, organized by category.

---

## Quick Reference

| Agent | Domain | Version | Optimization | Status |
|-------|--------|---------|--------------|--------|
| **Production Agents** |
| agent-sap-businesspartner-integration | SAP/ERP | v1.0.0 | 58% reduced | Production |
| agent-ansible-automation | DevOps | v1.0.0 | 59% reduced | Production |
| agent-robotarm-tester | Robotics | v1.0.0 | Candidate | Production |
| agent-git-manager | Git/Security | v1.0.0 | Candidate | Production |
| agent-provisioner | Agent Hub | v1.0.0 | 43% reduced | Production |
| agent-cv-optimizer | Career | v1.0.0 | Candidate | Production |
| agent-project-init | Initialization | v1.0.0 | Candidate | Production |
| agent-optimizer | Meta/Optimization | v1.0.0 | — | Production |
| **Supporting Agents** |
| agent-architect | Agent Design | — | — | Meta |
| research-assistant | Research | — | — | Support |
| documentation-specialist | Documentation | — | — | Support |

---

## Production Agents (8)

### agent-sap-businesspartner-integration

**Purpose**: SAP S/4HANA Cloud OData API integration expert

**When to Use**:
- Documenting BusinessPartner create/update flows
- Defining sub-entity sequencing (Roles, Addresses, Tax, Bank)
- Clarifying PATCH vs PUT operation semantics
- Establishing validation and error handling

**Key Capabilities**:
- OData API patterns for BP master data
- Sub-entity dependency mapping
- Data validation rules
- Error handling procedures

**Constraint**: Never fabricates SAP functionality; acknowledges uncertainties

**Invoke**:
```
@agent-sap-businesspartner-integration: Document the complete BusinessPartner
creation flow with addresses and tax numbers
```

---

### agent-ansible-automation

**Purpose**: DevOps automation with Ansible

**When to Use**:
- Creating production-ready playbooks and roles
- Implementing testing frameworks (Molecule, ansible-lint)
- Managing secrets with Ansible Vault
- Integrating with cloud providers (AWS, Azure, GCP)

**Key Capabilities**:
- Idempotent task design
- Role directory structure
- Multi-platform support
- Performance optimization

**Constraint**: Never fabricates modules; uses FQCN (ansible.builtin.*)

**Invoke**:
```
@agent-ansible-automation: Create a Django deployment role with
Nginx, Gunicorn, PostgreSQL, and SSL certificates
```

---

### agent-robotarm-tester

**Purpose**: Raspberry Pi robot arm testing via SSH

**When to Use**:
- Discovering workspace boundaries safely
- Validating pick-and-place sequences
- Benchmarking performance (speed, accuracy, repeatability)
- Integration testing with vision systems

**Key Capabilities**:
- Progressive boundary discovery
- Error recovery automation
- Diagnostic data collection
- Calibration verification

**Constraint**: Safety-first — never assumes unknown limits

**Invoke**:
```
@agent-robotarm-tester: Help me discover the workspace boundaries
safely and create a configuration file
```

---

### agent-git-manager

**Purpose**: Secure git workflows with pre-commit security scanning

**When to Use**:
- Committing changes with security assurance
- Pushing to remote repositories
- Troubleshooting SSH authentication
- Integrating with `/update_doc` command

**Key Capabilities**:
- Pre-commit secret detection (.env, API keys, credentials)
- SSH/GitHub authentication
- Conventional commit messages
- PR creation via GitHub CLI

**Constraints**:
- Never force push
- Never amend without explicit request
- Always scan before commit
- Always confirm before push

**Invoke**:
```
@agent-git-manager: Help me commit my changes
@agent-git-manager: Push to GitHub
```

---

### agent-provisioner

**Purpose**: Sync agents from hub to other projects

**When to Use**:
- Listing available agents in the hub
- Comparing versions with target project
- Provisioning selected agents
- Syncing commands and hooks

**Key Capabilities**:
- Version comparison
- Interactive agent selection
- Backup creation before sync
- Hook merging with permission preservation

**Constraint**: Always creates backups; always shows changes first

**Invoke**:
```
@agent-provisioner: list
@agent-provisioner: compare /path/to/project
@agent-provisioner: sync /path/to/project
```

---

### agent-cv-optimizer

**Purpose**: Career coaching for Data & AI roles

**When to Use**:
- Tailoring CV for specific job descriptions
- Identifying skills gaps and blindspots
- Preparing for technical interviews
- Tracking multiple applications

**Operating Modes**:
| Mode | Trigger | Purpose |
|------|---------|---------|
| Career Coach | Career questions | Experience analysis, positioning |
| HR Manager | JD provided | Keyword extraction, CV tailoring |
| Interviewer | Interview mentioned | Question prep, company research |

**Key Capabilities**:
- JD analysis and keyword extraction
- Skills gap scoring
- Cover letter generation
- Application tracker management
- RenderCV format support

**Constraint**: Never fabricates experience or company information

**Invoke**:
```
@agent-cv-optimizer: I've been a backend developer for 5 years
and want to move into data engineering. What should I highlight?

@agent-cv-optimizer: Here's a JD for a Senior Data Engineer at Spotify.
Help me tailor my CV and write a cover letter.
```

---

### agent-project-init

**Purpose**: Initialize new projects with appropriate structure

**When to Use**:
- Starting a new project from scratch
- Converting existing directory to agent-enabled
- Setting up .agent/ knowledge base

**Project Types**:
| Type | Description | Folders |
|------|-------------|---------|
| Integration | APIs, data flows | sops/, system/, workflows/ |
| Development | Building software | decisions/, schemas/, testing/ |
| Research | Exploration | findings/, hypotheses/, gaps/ |
| Optimization | Improving existing | templates/, metrics/, experiments/ |

**Default Provisions**:
- Agents: research-assistant, documentation-specialist, agent-git-manager
- Commands: update_doc, agent_reflect

**Invoke**:
```
/project_init                    # Current directory
/project_init /path/to/project   # Specific path
```

---

### agent-optimizer

**Purpose**: Analyze and optimize agents using telemetry data

**When to Use**:
- Identifying optimization opportunities
- Applying proven patterns (template externalization)
- Tracking token efficiency over time
- Generating hub-wide status reports

**5-Phase Workflow**:
1. **MEASURE**: Capture structural + telemetry metrics
2. **ANALYZE**: Apply proven patterns from reflection pool
3. **RECOMMEND**: Generate optimization plan
4. **VALIDATE**: Enforce quality gates
5. **TRACK**: Record before/after metrics

**Optimization Patterns**:
| Pattern | Reduction | When to Apply |
|---------|-----------|---------------|
| Template Externalization | 51-65% | Embedded content > 100 words |
| Lazy Loading | 5% overhead | Templates loaded unconditionally |
| Output Modes | Variable | No verbosity control |
| Section Compression | 15-30% | Similar agent is smaller |

**Invoke**:
```
/optimize                        # Analyze all agents
/optimize agent-git-manager      # Specific agent
/optimize status                 # Hub dashboard
```

---

## Supporting Agents (3)

### agent-architect

**Purpose**: Design new agents and optimize existing ones

**When to Use**:
- Building a new agent from scratch
- Refining agent configuration
- Ensuring best practices and security
- Defining scope and expertise boundaries

**Capabilities**:
- Requirements analysis
- System prompt engineering
- Test case development
- Quality standard definition

**Invoke**:
```
@agent-architect: I need an agent that reviews TypeScript code
for type safety issues
```

---

### research-assistant

**Purpose**: Technical research and investigation

**When to Use**:
- Exploring implementation options
- Comparing technologies
- Understanding new frameworks
- Gathering best practices

**Methodology**:
1. Clarify scope
2. Systematic analysis
3. Practical focus
4. Decision frameworks

**Invoke**:
```
@research-assistant: Should I use PostgreSQL or MongoDB
for my new project?
```

---

### documentation-specialist

**Purpose**: Create and update documentation

**When to Use**:
- Writing user guides
- Creating API documentation
- Documenting architecture decisions
- Updating README files

**Capabilities**:
- Multiple audience writing
- Knowledge base integration
- Timestamp handling
- Quality checks

**Invoke**:
```
@documentation-specialist: Create comprehensive documentation
for the new authentication system
```

---

## Commands (4)

| Command | Purpose | Agent Used |
|---------|---------|------------|
| `/project_init` | Initialize new projects | agent-project-init |
| `/agent_reflect` | Generate project testimonies | documentation-specialist |
| `/optimize` | Analyze agents for optimization | agent-optimizer |
| `/update_doc` | Document changes to knowledge base | documentation-specialist |

---

## Agent Locations

| Agent | Definition | Implementation |
|-------|------------|----------------|
| agent-sap-bp | `.claude/agents/agent-sap-businesspartner-integration.md` | `agents/agent-sap-businesspartner-integration/` |
| agent-ansible | `.claude/agents/agent-ansible-automation.md` | `agents/agent-ansible-automation/` |
| agent-robotarm | `.claude/agents/agent-robotarm-tester.md` | `agents/agent-robotarm-tester/` |
| agent-git-manager | `.claude/agents/agent-git-manager.md` | `agents/agent-git-manager/` |
| agent-provisioner | `.claude/agents/agent-provisioner.md` | `agents/agent-provisioner/` |
| agent-cv-optimizer | `.claude/agents/agent-cv-optimizer.md` | `agents/agent-cv-optimizer/` |
| agent-project-init | `.claude/agents/agent-project-init.md` | — |
| agent-optimizer | `.claude/agents/agent-optimizer.md` | `agents/agent-optimizer/` |

---

**Catalog Version**: 1.0.0
**Last Updated**: 2026-01-25
**Total Agents**: 11 (8 production, 3 supporting)
