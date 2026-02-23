# CLAUDE.md - Agentic Hub Configuration

Central hub for designing, creating, and deploying specialized Claude Code agents.

**Vision**: Track agents deployed to projects, collect feedback, use telemetry to improve agents.

## Quick Reference: Agents

| Agent | Domain | Purpose |
|-------|--------|---------|
| `agent-sap-businesspartner-integration` | SAP/ERP | BusinessPartner OData API documentation |
| `agent-ansible-automation` | DevOps | Ansible playbooks, roles, testing |
| `agent-robotarm-tester` | Robotics | Robot arm validation via SSH |
| `agent-cv-optimizer` | Career | CV tailoring, interview prep for Data/AI |
| `agent-brand-voice` | Content | Brand voice discovery, content generation, voice compliance |
| `agent-provisioner` | Hub | Sync agents to other projects |
| `agent-project-init` | Hub | Initialize new projects with agents |
| `agent-optimizer` | Hub | Analyze and optimize agents |
| `agent-architect` | Hub | Design new agents |
| `agent-hub-orchestrator` | Hub | Coordinate multi-agent workflows |
| `agent-integration-analyzer` | Integration | Parse code exports, extract schemas/mappings |
| `agent-integration-assessor` | Integration | Structured integration assessment (8 dimensions) |
| `agent-integration-scorer` | Integration | Maturity scoring with red flags/quick wins |
| `agent-integration-designer` | Integration | Architecture design or improvement roadmap |
| `agent-integration-reviewer` | Integration | Design validation & security review |
| `research-assistant` | Support | Research and information gathering |
| `documentation-specialist` | Support | Documentation generation |

**Full Details**: See `agents-registry.json` for complete agent metadata.

**Agent Files**: All agents in `.claude/agents/{agent-id}.md`

## Quick Reference: Commands

| Command | Purpose | Agent |
|---------|---------|-------|
| `/project_init` | Initialize new projects | agent-project-init |
| `/optimize` | Analyze/optimize agents | agent-optimizer |
| `/agent_reflect` | Generate project testimony | documentation-specialist |
| `/communication-reflect` | Extract content patterns from intent log | agent-brand-voice |
| `/commit-secure` | Secure git commit with scanning | - |
| `/pr-secure` | Secure PR creation with scanning | - |
| `/agent-status` | Hub-wide dashboard | - |
| `/agent-test` | Run validation tests | - |
| `/agent-deploy` | One-command deployment | - |
| `/update_doc` | Update documentation | - |
| `/analyze-integration` | Parse integration code exports | agent-integration-analyzer |
| `/assess-integration` | Full integration assessment lifecycle | agent-integration-assessor |
| `/score-integration` | Quick maturity scoring | agent-integration-scorer |
| `/review-integration` | Design review & validation | agent-integration-reviewer |
| `/summarize-integration` | Customer-facing summary | documentation-specialist |

## Interaction Rules

**Challenge non-best-practice requests**: If a request conflicts with an established best practice, say so before complying. Explain the best practice and the trade-off so an informed decision can be made. If it's a new or ambiguous edge case, flag it and discuss — don't silently apply a rule that may not fit the situation.

**Log significant decision forks proactively**: When a session reaches a genuine fork — multiple viable approaches were considered and one was chosen with explicit reasoning — append an entry to `/home/askeox/Documents/Agentic/.agent/reflection_pool/decision-journal.md` without waiting to be asked. Qualifying signals: alternatives were explicitly compared, trade-offs were stated, or a path was rejected for a specific reason. Not qualifying: trivial implementation choices with one obvious answer. Use the entry format defined in that file. Mark Source as `Live`.

**Customer name anonymization (MANDATORY)**: Never use real customer or company names in any file in this project. All customer references must use anonymized identifiers (e.g., Client-A, Client-B, Integration-Project-1). This applies to all files including testimonies, memory, metrics, agent definitions, documentation, and reflection pool entries. When ingesting new testimony or external content that contains customer names, replace them with the appropriate anonymized identifier before writing. Current mappings are maintained privately and must not appear in this repository.

## Agent Loading Policy

Do NOT proactively read or load agent definition files (`.claude/agents/*.md`) at session start or during initialization. Load an agent's definition only when it is explicitly summoned — by the user referencing it by name, or by the Task tool invoking it. Most sessions use 1–3 agents; loading all 17 upfront wastes context window.

## Using Agents

**Invoke any agent**:
```bash
@{agent-id}: [Your request]
```

**Examples**:
```bash
@agent-ansible-automation: Create an Nginx deployment role
@agent-cv-optimizer: Tailor my CV for this Spotify job posting
@agent-sap-businesspartner-integration: Document BP create workflow
```

**Best Practice**: Read the agent's definition file before complex tasks:
- `.claude/agents/{agent-id}.md` - Full capabilities and constraints

## Hub Architecture

```
Agentic/                          # The Hub
├── CLAUDE.md                     # This file (config)
├── agents-registry.json          # Machine-readable registry
│
├── .claude/
│   ├── agents/                   # Agent definitions
│   └── commands/                 # Command definitions
│
├── .agent/
│   ├── injection-history.md      # Documentation audit trail
│   ├── reflection_pool/          # Cross-project insights
│   ├── metrics/                  # Usage analytics
│   ├── telemetry/                # OTEL integration
│   ├── memory/                   # Agent persistent memory
│   └── tests/                    # Validation infrastructure
│
├── agents/                       # Agent documentation + examples
│   └── {agent-name}/
│       ├── README.md
│       ├── test-cases.md
│       └── examples/
│
├── plugins/                      # Distributable plugin packages
│   └── integration-suite/        # git subtree → own repo
│       ├── .claude-plugin/       # Plugin manifest
│       ├── agents/               # 5 integration agents
│       ├── commands/             # 5 integration commands
│       ├── templates/            # 19 templates (source of truth)
│       ├── hooks/                # SessionStart auto-copy
│       ├── skills/               # Manual setup fallback
│       └── scripts/              # setup + hub sync
│
├── deployments/                  # Deployment tracking
│   ├── registry.json
│   └── by-project/
│
└── docs/                         # Reference documentation
```

### Plugin Subtree Workflow

The `plugins/integration-suite/` directory is managed as a git subtree and pushed to its own repo for distribution:

```bash
# Initial push to remote repo
git subtree push --prefix=plugins/integration-suite origin-plugin main

# Pull upstream changes back
git subtree pull --prefix=plugins/integration-suite origin-plugin main

# Sync hub changes to plugin
bash plugins/integration-suite/scripts/sync-from-hub.sh

# Local testing
claude --plugin-dir plugins/integration-suite
```

## Quality Gates

All agents must pass before deployment:

| Gate | Requirement |
|------|-------------|
| QG-1 | 100% test pass rate |
| QG-2 | No fabrication constraints removed |
| QG-3 | Uncertainty acknowledgment preserved |
| QG-4 | All referenced templates exist |
| QG-5 | Critical constraints intact |
| QG-6 | Quality score >= 4.0/5 (from feedback) |

**Run tests**: `/agent-test {agent-id}`

## Knowledge Base

The `.agent/` directory is the knowledge base for all agents:

| Folder | Purpose |
|--------|---------|
| `tasks/` | PRDs, implementation plans |
| `system/` | Schemas, APIs, integrations |
| `sops/` | Standard operating procedures |
| `metrics/` | Usage data, optimization logs |
| `telemetry/` | OTEL metrics collection |
| `reflection_pool/` | Cross-project insights |

**Details**: See `.agent/README.md`

## Telemetry & Feedback

**OTEL Telemetry** (automated):
```bash
# Start collector
cd .agent/telemetry/otel && docker compose up -d

# Enable in shell
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export OTEL_EXPORTER_OTLP_ENDPOINT="http://localhost:4317"
```

**User Feedback** (after agent use):
```bash
.agent/telemetry/hooks/feedback_capture.sh {agent-id} {rating-1-5} "comment"
```

## Provisioning Agents

**To another project**:
```bash
@agent-provisioner: sync /path/to/project
```

**Interactive workflow**:
1. Compare versions between hub and target
2. Select agents to sync
3. Backup existing files
4. Copy agents, commands, merge hooks
5. Update deployment registry

## Creating New Agents

1. **Design**: `@agent-architect: I need an agent for...`
2. **Create**: Add `.claude/agents/{agent-id}.md`
3. **Test**: Create `agents/{agent-id}/test-cases.md`
4. **Register**: Update `agents-registry.json`
5. **Validate**: `/agent-test {agent-id}`

**Guide**: See `AGENTS_REPOSITORY_GUIDE.md` for full workflow.

## Maintenance

| Schedule | Tasks |
|----------|-------|
| **Weekly** | Review telemetry, address feedback |
| **Monthly** | `/optimize` analysis, update agents |
| **Quarterly** | Full validation, accuracy review |

## Support

**Get help**:
1. Check agent definition: `.claude/agents/{agent-id}.md`
2. Check agent docs: `agents/{agent-id}/README.md`
3. Check registry: `agents-registry.json`

**Report issues**:
- Agent ID, request, expected vs actual output

## Document References

| Document | Purpose |
|----------|---------|
| `agents-registry.json` | Machine-readable agent registry |
| `AGENTS_REPOSITORY_GUIDE.md` | How to create agents |
| `.agent/README.md` | Knowledge base guide |
| `deployments/README.md` | Deployment tracking |
| `.agent/telemetry/otel/README.md` | Telemetry setup |

## Status

**Hub Version**: 2.1.0
**Registry Version**: 2.1.0
**Last Updated**: 2026-01-25

**Agent Count**: 17 (5 meta-agents, 12 deployable)

---

*This hub tracks agents deployed across projects. Use `/agent-status` for dashboard.*
