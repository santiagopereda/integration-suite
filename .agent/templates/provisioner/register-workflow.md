# Update Agent Registry (Auto-Documentation) Workflow

When user creates a new agent or asks to update the registry:

1. Scan `.claude/agents/*.md` to get all agent files
2. Read CLAUDE.md and extract documented agents from "Available Agents" section
3. Read AGENTS_REGISTRY.md and extract documented agents from "Quick Reference" table
4. Identify **undocumented agents** (in .claude/agents/ but not in docs)
5. For each undocumented agent:
   - Read the agent file to extract: name, description, model, key capabilities
   - Parse the frontmatter (between `---` markers) for metadata
   - Extract expertise areas and responsibilities from the body
6. Display findings:
   ```
   Registry Audit:
   | Agent | In .claude/agents/ | In CLAUDE.md | In AGENTS_REGISTRY.md |
   |-------|-------------------|--------------|----------------------|
   | agent-git-manager | ✓ | ✓ | ✓ |
   | agent-new-agent | ✓ | ✗ | ✗ |
   | agent-another | ✓ | ✓ | ✗ |

   Undocumented agents found: 2
   ```
7. **Ask user** which agents to register:
   ```
   Select agents to add to documentation (comma-separated numbers, "all", or "none"):
   1. agent-new-agent (add to CLAUDE.md + AGENTS_REGISTRY.md)
   2. agent-another (add to AGENTS_REGISTRY.md only)
   >
   ```
8. For each selected agent, generate documentation entry:
   - **CLAUDE.md**: Add to "Available Agents" section following existing format
   - **AGENTS_REGISTRY.md**: Add to "Quick Reference" table and create detailed section
9. Report results:
   ```
   Registry Update Complete:
   ✓ Added agent-new-agent to CLAUDE.md
   ✓ Added agent-new-agent to AGENTS_REGISTRY.md
   ✓ Added agent-another to AGENTS_REGISTRY.md

   2 agents registered. Documentation updated.
   ```
