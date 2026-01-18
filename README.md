# Agentic - Agent Repository Hub

A centralized hub for designing, creating, and maintaining reusable specialized Claude Code agents.

## Quick Start

### Use an Existing Agent

```bash
# Find available agents
See: AGENTS_REGISTRY.md

# Invoke an agent
@agent-sap-businesspartner-integration: Create documentation for BusinessPartner creation
@agent-git-manager: Help me commit my changes
```

### Create a New Agent

1. Read `AGENTS_REPOSITORY_GUIDE.md` (7-phase workflow)
2. Use `@agent-architect` for design help
3. Create agent definition in `.claude/agents/`
4. Add documentation in `agents/<agent-name>/`
5. Register in `AGENTS_REGISTRY.md` and `CLAUDE.md`

---

## Available Agents

| Agent | Purpose | Status |
|-------|---------|--------|
| `agent-sap-businesspartner-integration` | SAP S/4HANA BusinessPartner OData API documentation | Production |
| `agent-ansible-automation` | Ansible playbooks, roles, and automation | Production |
| `agent-robotarm-tester` | Raspberry Pi robot arm testing via SSH | Production |
| `agent-git-manager` | Secure git workflow with pre-commit scanning | Production |

See `AGENTS_REGISTRY.md` for full details.

---

## Project Structure

```
Agentic/
├── .claude/agents/           # Agent definitions (Claude Code reads these)
│   ├── agent-sap-businesspartner-integration.md
│   ├── agent-ansible-automation.md
│   ├── agent-robotarm-tester.md
│   └── agent-git-manager.md
│
├── agents/                   # Agent documentation & test cases
│   ├── agent-sap-businesspartner-integration/
│   ├── agent-ansible-automation/
│   ├── agent-robotarm-tester/
│   └── agent-git-manager/
│
├── .agent/                   # Knowledge base for agents
│   ├── tasks/               # PRDs & implementation plans
│   ├── system/              # Schemas, APIs, integrations
│   └── sops/                # Standard operating procedures
│
├── docs/                     # Generated documentation
│
├── README.md                 # This file
├── CLAUDE.md                 # Claude Code configuration
├── AGENTS_REGISTRY.md        # Central agent index
└── AGENTS_REPOSITORY_GUIDE.md # How to create agents
```

---

## Documentation

| Document | Purpose |
|----------|---------|
| **CLAUDE.md** | Claude Code configuration, agent definitions, workflows |
| **AGENTS_REGISTRY.md** | Central index of all agents with details |
| **AGENTS_REPOSITORY_GUIDE.md** | 7-phase workflow for creating new agents |
| **agents/*/README.md** | Agent-specific usage guides |
| **.agent/README.md** | Knowledge base overview |

---

## How to Use

### For Agent Users

1. Check `AGENTS_REGISTRY.md` for available agents
2. Read the agent's `README.md` in `agents/<agent-name>/`
3. Invoke: `@agent-<id>: [your request]`
4. Verify output before using in production

### For Agent Creators

1. Read `AGENTS_REPOSITORY_GUIDE.md` for the full workflow
2. Use `@agent-architect` to help design your agent
3. Follow the 7-phase creation process
4. Test with comprehensive test cases
5. Register in `AGENTS_REGISTRY.md` and `CLAUDE.md`

### For Knowledge Contributors

1. Read `.agent/README.md` for structure
2. Add PRDs to `.agent/tasks/`
3. Add schemas/APIs to `.agent/system/`
4. Add procedures to `.agent/sops/`
5. Log additions in `.agent/injection-history.md`

---

## Quality Standards

All agents meet these standards:

- **Accurate** - Never fabricates functionality
- **Transparent** - Acknowledges uncertainties
- **Complete** - Full scope coverage with examples
- **Tested** - Comprehensive validation test cases
- **Documented** - Usage guides and trigger conditions

---

## Contributing

### Report Issues

1. Document with specific examples
2. Include: agent ID, request, actual vs expected output
3. Report to Agent Architecture Team

### Suggest New Agents

1. Describe the problem to solve
2. Define scope and requirements
3. Identify use cases
4. Submit to Agent Architecture Team

---

## Status

**Version**: 1.2.0
**Agents**: 4 production
**Last Updated**: 2026-01-18
**Status**: Active
