# Tracked Projects

Projects registered for agent_reflect testimony generation. This file serves as the central registry for all projects that participate in the agent-assisted development feedback loop.

## Active Projects

| Project | Path | Last Testimony | Notes |
|---------|------|----------------|-------|
| Agentic | /home/askeox/Documents/Agentic | 2026-01-23 | Hub repository - agent design and maintenance |
| CV_Generator_Agent | /home/askeox/Documents/CV_Generator_Agent | 2026-01-23 | CV optimization for Data & AI careers |
| GLInet_Be3600 | /home/askeox/Documents/GLInet_Be3600 | 2026-01-23 | Router configuration and automation |
| Survival | /home/askeox/Documents/Survival | 2026-01-23 | Survival game project |
| mirobot | /home/askeox/mirobot | 2026-01-23 | Mirobot robot arm control |
| UniQure | /home/askeox/IntoData/UniQure | 2026-01-23 | UniQure integration project |
| raspberrypi | /home/askeox/IntoData/Internal/Vagrant/rapsberrypi | 2026-01-23 | Raspberry Pi Ansible automation |

---

## Adding a New Project

1. Add a row to the "Active Projects" table above
2. Ensure the project has a `.agent/` knowledge base directory
3. Optionally sync `/agent_reflect` command: `@agent-provisioner: sync /path/to/project`
4. Run: `/agent_reflect /path/to/project` to generate initial testimony

---

## Removing a Project

1. Remove the row from the "Active Projects" table
2. Optionally archive existing testimonies from `.agent/testimony/`

---

## Bulk Reflect

To run agent_reflect on all tracked projects, iterate through this list or use a script:

```bash
# Example: Generate testimonies for all active projects
for project in \
  "/home/askeox/Documents/Agentic" \
  "/home/askeox/Documents/CV_Generator_Agent" \
  "/home/askeox/Documents/GLInet_Be3600" \
  "/home/askeox/Documents/Survival" \
  "/home/askeox/mirobot" \
  "/home/askeox/IntoData/UniQure" \
  "/home/askeox/IntoData/Internal/Vagrant/rapsberrypi"
do
  echo "Reflecting on: $project"
  # Run /agent_reflect $project in Claude Code
done
```

---

## Testimony Archive

All testimonies are stored in two locations:
1. **Project-local**: `{project}/.agent/testimony/`
2. **Central hub**: `/home/askeox/Documents/Agentic/.agent/testimony/`

This dual-write approach ensures:
- Projects have their own historical record
- Cross-project analysis is possible from the central hub

---

## Version History

| Date | Change |
|------|--------|
| 2026-01-23 | Initial tracker created with 6 projects |
