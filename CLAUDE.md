# CLAUDE.md - Agentic Hub Configuration

Central hub for designing, creating, and deploying specialized Claude Code agents.

**Vision**: Track agents deployed to projects, collect feedback, use telemetry to improve agents.

## Quick Reference: Agents

| Agent | Domain | Purpose |
|-------|--------|---------|
| `agent-sap-businesspartner-integration` | SAP/ERP | BusinessPartner OData API documentation |
| `agent-ansible-automation` | DevOps | Ansible playbooks, roles, testing |
| `agent-robotarm-tester` | Robotics | Robot arm validation via SSH |
| `agent-git-manager` | Utility | Secure commits with security scanning |
| `agent-cv-optimizer` | Career | CV tailoring, interview prep for Data/AI |
| `agent-provisioner` | Hub | Sync agents to other projects |
| `agent-project-init` | Hub | Initialize new projects with agents |
| `agent-optimizer` | Hub | Analyze and optimize agents |
| `agent-architect` | Hub | Design new agents |
| `agent-hub-orchestrator` | Hub | Coordinate multi-agent workflows |
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
| `/agent-status` | Hub-wide dashboard | - |
| `/agent-test` | Run validation tests | - |
| `/agent-deploy` | One-command deployment | - |
| `/update_doc` | Update documentation | - |

## Using Agents

**Invoke any agent**:
```bash
@{agent-id}: [Your request]
```

**Examples**:
```bash
@agent-git-manager: Help me commit my changes
@agent-ansible-automation: Create an Nginx deployment role
@agent-cv-optimizer: Tailor my CV for this Spotify job posting
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
├── deployments/                  # Deployment tracking
│   ├── registry.json
│   └── by-project/
│
└── docs/                         # Reference documentation
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

**Agent Count**: 12 (5 meta-agents, 7 deployable)

---

*This hub tracks agents deployed across projects. Use `/agent-status` for dashboard.*
