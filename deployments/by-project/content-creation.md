# Project: content-creation

**Path**: /home/askeox/Documents/content-creation
**Type**: Content Creation Workspace
**First Deployed**: 2026-02-23
**Last Sync**: 2026-02-23

---

## Purpose

Central content workspace for creating all marketing, thought leadership, and brand content across projects using a unified personal brand voice.

---

## Deployed Agents

| Agent | Version | Deployed | Updated |
|-------|---------|----------|---------|
| agent-brand-voice | 1.0.0 | 2026-02-23 | - |

---

## Deployed Commands

| Command | Purpose | Deployed |
|---------|---------|----------|
| communication-reflect | Generate content testimony | 2026-02-23 |

---

## Templates Provisioned

**Brand Voice Templates** (32 files in `.agent/templates/brand-voice/`):

### Assessment
- discovery-questionnaire.md
- reconciliation-workflow.md
- periodic-review-template.md

### Voice Profile
- principles-template.md
- tone-matrix-template.md
- vocabulary-guide-template.md
- voice-attributes-template.md

### Workflows
- initial-assessment-workflow.md
- content-generation-workflow.md
- content-review-workflow.md
- creator-analysis-workflow.md
- voice-evolution-workflow.md

### Content Types (20 format-specific templates)
- Blog posts, LinkedIn posts, emails, documentation, presentations, etc.

---

## System Files Provisioned

| File | Purpose | Status |
|------|---------|--------|
| `.agent/system/brand-voice-profile.md` | Personal brand voice profile (from hub) | Active |
| `.agent/system/content-intent-log.md` | Content creation tracking | Ready |
| `.agent/memory/agents/agent-brand-voice-memory.md` | Agent persistent memory | Initialized |

---

## Telemetry Status

- **Infrastructure**: Provisioned
- **Hooks**: Configured (PostToolUse: Edit/Write/NotebookEdit)
- **Collection**: Active
- **Sync Target**: Agentic hub

---

## Voice Profile

Using personal brand voice profile from Agentic hub (same voice across all projects).

**Voice Profile Location**: `.agent/system/brand-voice-profile.md`
**Last Reviewed**: 2026-02-23 (initial provisioning)
**Next Review**: TBD (recommend quarterly)

---

## Usage Notes

**Agent Invocation**:
```bash
@agent-brand-voice: [Your request]
```

**Common Workflows**:
1. Content Generation: "Create a LinkedIn post about [topic]"
2. Content Review: "Review this draft for brand voice consistency"
3. Voice Analysis: "Analyze these writing samples for voice patterns"

**Command Invocation**:
```bash
/communication-reflect
```

---

## Testimony Status

- [ ] Testimony generated
- [ ] Synced to reflection pool

---

## Notes

Content workspace is NOT a technical project. Focus is on brand-consistent content creation across all domains (marketing, technical documentation, thought leadership, social media).

All content created here should maintain voice consistency with the personal brand profile.
