# Workflow Examples

## Sync Workflow Example

User: `@agent-provisioner: sync /home/user/my-project`

1. Verify target exists: `ls /home/user/my-project`
2. Run comparison (read hub and target agents)
3. Display results:
   ```
   Comparison: Hub vs /home/user/my-project
   | Agent | Hub | Target | Status |
   |-------|-----|--------|--------|
   | agent-git-manager | 2026-01-18 | (none) | New |
   | agent-sap-bp | 2026-01-18 | 2025-11-20 | Update available |
   | agent-ansible | 2026-01-18 | 2026-01-18 | Up to date |
   | agent-robotarm | 2026-01-18 | (none) | New |

   Related dependencies:
   - update_doc.md command (for agent-git-manager)
   - PostToolUse hook (for agent-git-manager)

   Select agents to sync (comma-separated numbers, "all", or "none"):
   1. agent-git-manager (New) + command + hook
   2. agent-sap-bp-integration (Update)
   3. agent-robotarm-tester (New)
   >
   ```
4. Wait for user selection
5. Create backups if needed
6. Copy selected agents
7. Copy related commands
8. Merge hooks
9. Report results

## Sync-Back Workflow Example

User: `@agent-provisioner: sync-back /home/user/my-project`

1. Verify target exists: `ls /home/user/my-project/.claude/agents/`
2. Run reverse comparison (target agents vs hub agents)
3. Display results:
   ```
   Reverse Sync: /home/user/my-project → Hub
   | Agent | Target Date | Hub Date | Status |
   |-------|-------------|----------|--------|
   | agent-cv-optimizer | 2026-01-23 | 2026-01-18 | Update available |
   | agent-git-manager | 2026-01-18 | 2026-01-18 | Up to date |
   | research-assistant | 2026-01-18 | (typo: reaeach-assistant) | New/Fix |

   Select agents to sync back to hub (comma-separated numbers, "all", or "none"):
   1. agent-cv-optimizer (Update)
   2. research-assistant (New/Fix - will also remove typo file)
   >
   ```
4. Wait for user selection
5. Create backups of hub files being overwritten
6. Copy selected agents from target to hub
7. If typo correction selected, remove the misspelled file
8. Report results:
   ```
   Sync Back Complete:
   ✓ Backed up: agent-cv-optimizer.md.bak
   ✓ Updated agent-cv-optimizer.md
   ✓ Added research-assistant.md
   ✓ Removed reaeach-assistant.md (typo)

   2 agents synced back to hub.
   ```

## Register Workflow Example

User: `@agent-provisioner: register`

1. Scan `.claude/agents/*.md` for all agent files
2. Read CLAUDE.md, extract agent IDs from "Available Agents" section
3. Read AGENTS_REGISTRY.md, extract agent IDs from "Quick Reference" table
4. Display audit results:
   ```
   Registry Audit:
   | Agent | In .claude/agents/ | In CLAUDE.md | In AGENTS_REGISTRY.md |
   |-------|-------------------|--------------|----------------------|
   | agent-git-manager | ✓ | ✓ | ✓ |
   | agent-cv-optimizer | ✓ | ✓ | ✓ |
   | agent-new-feature | ✓ | ✗ | ✗ |
   | research-assistant | ✓ | ✗ | ✗ |

   Undocumented agents found: 2

   Select agents to register (comma-separated numbers, "all", or "none"):
   1. agent-new-feature
   2. research-assistant
   >
   ```
5. User selects: "all"
6. For each selected agent:
   - Read agent file
   - Extract name, description, model from frontmatter
   - Extract expertise, responsibilities from body
   - Generate CLAUDE.md entry
   - Generate AGENTS_REGISTRY.md entries
7. Update both files
8. Report results:
   ```
   Registry Update Complete:
   ✓ Added agent-new-feature to CLAUDE.md (Available Agents section)
   ✓ Added agent-new-feature to AGENTS_REGISTRY.md (Quick Reference + Detailed)
   ✓ Added research-assistant to CLAUDE.md (Available Agents section)
   ✓ Added research-assistant to AGENTS_REGISTRY.md (Quick Reference + Detailed)

   2 agents registered. Documentation updated.

   Next steps:
   - Review the generated entries in CLAUDE.md and AGENTS_REGISTRY.md
   - Add any missing details (test cases, examples folder)
   - Commit the documentation changes
   ```
