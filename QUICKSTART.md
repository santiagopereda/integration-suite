# Quick Start Guide - Agentic Agent Repository Hub

Welcome to the Agentic project - your centralized hub for designing, creating, and managing specialized Claude Code agents.

## What Is This?

This repository is designed as a **base for creating reusable agents** that can be deployed across multiple projects. Each agent is:

- ✅ Thoroughly documented
- ✅ Validated with test cases
- ✅ Production-ready
- ✅ Versioned and maintained
- ✅ Shareable across projects

## 5-Minute Setup

### 1. Understand the Structure

```
/Agentic
├── agents/                    # All agent implementations
│   └── agent-sap-businesspartner-integration/   # Example agent
│       ├── agent.yml         # Agent metadata
│       ├── system-prompt.md  # Agent personality & behavior
│       ├── README.md         # Usage guide
│       ├── test-cases.md     # Validation tests
│       └── examples/         # Example outputs
├── docs/                      # Generated documentation
│   └── sap-integration/       # Organized by domain
├── AGENTS_REGISTRY.md         # Index of all agents
├── AGENTS_REPOSITORY_GUIDE.md # How to create agents
├── CLAUDE.md                  # Project configuration
└── QUICKSTART.md             # This file
```

### 2. Check Available Agents

**Read**: `AGENTS_REGISTRY.md`

This file lists:
- All available agents
- What they do
- When to use them
- Current status & version

### 3. Use an Agent

**Example**: Creating BusinessPartner documentation

```bash
@agent-sap-businesspartner-integration: Create documentation for
creating a BusinessPartner organization with a default address
```

The agent will produce comprehensive Markdown documentation including:
- Step-by-step procedures
- API endpoints and methods
- Required/optional fields
- Validation rules
- Error handling guidance
- Escalation procedures

## Common Tasks

### Task 1: Use Existing Agent

1. **Find the agent**: Check `AGENTS_REGISTRY.md`
2. **Read the guide**: Check agent's `README.md`
3. **Invoke it**: `@agent-<id>: [Your request]`
4. **Verify output**: Review in sandbox before using

### Task 2: Create New Agent

1. **Plan the agent**: Use `@agent-architect` to help design
2. **Read the guide**: `AGENTS_REPOSITORY_GUIDE.md`
3. **Follow the workflow**: 7-phase creation process
4. **Test thoroughly**: Run provided test cases
5. **Register it**: Add to `AGENTS_REGISTRY.md`

### Task 3: Use This Hub in Another Project

Add to your project's CLAUDE.md:

```yaml
agents:
  - id: agent-sap-businesspartner-integration
    source: /path/to/Agentic/agents/
    version: "1.0.0"
```

Then use normally:
```bash
@agent-sap-businesspartner-integration: [Your request]
```

## Key Documents

| Document | What It Is | Read If... |
|----------|-----------|-----------|
| `AGENTS_REGISTRY.md` | Index of all agents | You want to find/use an agent |
| `AGENTS_REPOSITORY_GUIDE.md` | How to create agents | You're building a new agent |
| `CLAUDE.md` | Project configuration | You want to understand setup |
| `agents/*/README.md` | Agent-specific guide | You want to use a specific agent |
| `agents/*/system-prompt.md` | Agent's personality | You want deep implementation details |
| `agents/*/test-cases.md` | Validation tests | You want to understand validation |

## Current Agents

### agent-sap-businesspartner-integration (v1.0.0)

**What it does**: Creates comprehensive documentation for SAP S/4HANA Cloud BusinessPartner OData API integrations

**Use it for**:
- Creating BusinessPartner step-by-step guides
- Documenting data sequencing and dependencies
- Error handling and validation procedures
- PATCH vs PUT operation guidance
- Escalation guidelines

**Example**:
```bash
@agent-sap-businesspartner-integration: Document how to create
a BusinessPartner with roles, address, and tax numbers. Include
step-by-step procedures and error handling.
```

**Status**: Production Ready ✅

---

## Getting Started Checklist

### To Start Using Agents

- [ ] Read `AGENTS_REGISTRY.md`
- [ ] Find the agent you need
- [ ] Read its README
- [ ] Try invoking it
- [ ] Review the output
- [ ] Verify in sandbox
- [ ] Use with confidence

### To Create a New Agent

- [ ] Read `AGENTS_REPOSITORY_GUIDE.md`
- [ ] Use `@agent-architect` for design help
- [ ] Follow the 7-phase workflow
- [ ] Develop & test your agent
- [ ] Add to registry
- [ ] Share with team

### To Contribute Improvements

- [ ] Try using agents
- [ ] Report issues with specific examples
- [ ] Suggest improvements
- [ ] Provide feedback on accuracy
- [ ] Help document best practices

---

## Key Principles

### For Users

1. **Read the README first** - Understand when to use each agent
2. **Verify outputs** - Always test in sandbox before production
3. **Report issues** - Help improve agents with specific feedback
4. **Acknowledge limitations** - Agents aren't perfect; check important details

### For Creators

1. **Be accurate** - Never fabricate functionality
2. **Be transparent** - Call out uncertainties
3. **Test thoroughly** - Include comprehensive test cases
4. **Document completely** - Clear system prompt + user guide + examples

---

## Common Questions

### Q: How do I use an agent?

**A**: Invoke it with `@agent-<id>: [Your request]`

See specific agent's README for trigger conditions and examples.

### Q: How do I create a new agent?

**A**: Follow the workflow in `AGENTS_REPOSITORY_GUIDE.md`

Use `@agent-architect` to help design the agent.

### Q: How do I know if an agent is production-ready?

**A**: Check `AGENTS_REGISTRY.md` for status:
- **Production** = Ready to use
- **Beta** = Testing feedback welcome
- **Deprecated** = Don't use; see replacement

### Q: What if an agent produces inaccurate information?

**A**:
1. Report it with specific examples
2. Check the agent's limitations in README
3. Verify in official documentation
4. Provide feedback to Agent Architecture Team

### Q: Can I use agents from this hub in other projects?

**A**: Yes! Reference the agent in your project's CLAUDE.md and invoke normally.

---

## What's Next?

### If You're a User

1. Browse `AGENTS_REGISTRY.md`
2. Pick an agent relevant to your task
3. Read its README
4. Try it out
5. Provide feedback

### If You're a Creator

1. Read `AGENTS_REPOSITORY_GUIDE.md`
2. Use `@agent-architect` for help
3. Follow the 7-phase workflow
4. Build and test your agent
5. Register and deploy

### If You're a Maintainer

1. Understand the quality standards
2. Review agents quarterly
3. Update when standards/APIs change
4. Gather and incorporate feedback
5. Keep AGENTS_REGISTRY.md current

---

## Support

### Need Help?

1. **Check the README** for the specific agent
2. **Review AGENTS_REPOSITORY_GUIDE.md** for creation help
3. **Consult AGENTS_REGISTRY.md** for agent overview
4. **Ask Agent Architecture Team** for complex issues

### Found an Issue?

1. Document it with specific examples
2. Include agent ID, request, and output
3. Explain what you expected vs. what happened
4. Report to Agent Architecture Team

### Have Ideas?

1. Describe what problem you're trying to solve
2. Outline what an agent would need to do
3. Share any use cases or examples
4. Submit to Agent Architecture Team

---

## Directory Map

Need to find something? Here's where things are:

```
/Agentic/
├── QUICKSTART.md              ← You are here
├── AGENTS_REGISTRY.md         ← Start here: see all agents
├── AGENTS_REPOSITORY_GUIDE.md ← Read before creating agents
├── CLAUDE.md                  ← Project configuration
│
├── agents/                    ← All agent implementations
│   └── agent-sap-businesspartner-integration/
│       ├── agent.yml          ← Agent config
│       ├── system-prompt.md   ← Agent personality
│       ├── README.md          ← Usage guide
│       ├── test-cases.md      ← Validation tests
│       └── examples/          ← Example outputs
│
├── docs/                      ← Generated documentation
│   └── sap-integration/
│       └── businesspartner/   ← BP documentation by agent
│
└── README.md                  ← Project overview
```

---

## Examples

### Example 1: Use agent-sap-businesspartner-integration

**Goal**: Document BusinessPartner creation with address

**Command**:
```bash
@agent-sap-businesspartner-integration: Create step-by-step documentation
for creating a BusinessPartner organization with a default address,
including required fields, validation rules, and error handling.
```

**Output**: Comprehensive Markdown guide with API endpoints, request bodies, validation rules, error codes, and escalation guidelines.

### Example 2: Create a new agent

**Goal**: Build agent for SAP S/4HANA API documentation

**Process**:
1. Read `AGENTS_REPOSITORY_GUIDE.md`
2. Use `@agent-architect` to design:
   ```bash
   @agent-architect: Help me design an agent for documenting
   SAP S/4HANA Cloud OData APIs. I want it to...
   ```
3. Follow 7-phase workflow to build agent
4. Test with 6+ test cases
5. Add to AGENTS_REGISTRY.md
6. Deploy and share

---

## Success Checklist

### Getting Started ✓

- [ ] You've read this QUICKSTART.md
- [ ] You've explored AGENTS_REGISTRY.md
- [ ] You understand the directory structure
- [ ] You know how to invoke an agent

### Using Agents ✓

- [ ] You've tried `@agent-sap-businesspartner-integration`
- [ ] You understand when to use each agent
- [ ] You know how to verify outputs
- [ ] You can integrate agents in your projects

### Ready to Create ✓

- [ ] You've read AGENTS_REPOSITORY_GUIDE.md
- [ ] You've used `@agent-architect` for design
- [ ] You understand the 7-phase workflow
- [ ] You're ready to build your first agent

---

**Version**: 1.0.0
**Last Updated**: 2025-11-20
**Status**: Active

**Next Step**: Open `AGENTS_REGISTRY.md` to explore available agents!
