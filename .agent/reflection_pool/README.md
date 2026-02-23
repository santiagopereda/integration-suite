# Reflection Pool

Cross-project learnings and meta-analysis from agent-assisted development projects.

## Purpose

This directory stores synthesized insights from project testimonies, providing:
- Patterns that work across projects
- Anti-patterns to avoid
- Recommendations for future projects
- Quotable insights for quick reference

## Relationship to testimony/

| Directory | Content | Scope |
|-----------|---------|-------|
| `testimony/` | Raw project journey documents | Per-project |
| `reflection_pool/` | Synthesized cross-project learnings | Meta-analysis |

## Contents

### [testimony-analysis-2026-01-23.md](testimony-analysis-2026-01-23.md)
Comprehensive analysis of 6 project testimonies covering:
- Success patterns (10 identified)
- Failure patterns (8 identified)
- Blindspots (8 systematic gaps)
- Recommendations for agent design

### [testimony-analysis-2026-02-21.md](testimony-analysis-2026-02-21.md)
Analysis of 3 new testimonies (Feb 2026 batch) covering:
- Success patterns (5 new: two-phase assessment, phase gates, security as feature work, code-level override, ADRs)
- Failure patterns (3 new: static analysis overconfidence, API documentation trust failure, expression context mismatch)
- Connections to Jan 23 patterns (5 strengthened)
- Updated metrics with quantified values

### [directory-usage-analysis.md](directory-usage-analysis.md)
Analysis of `.agent/` subdirectory actual usage:
- Which folders are actually used
- Project-type-specific recommendations
- When to use which structure

### [value-unlock-index.md](value-unlock-index.md)
Single interventions that produced disproportionate outcomes, indexed by situation type:
- 20 entries across 7 situation categories
- 4 meta-patterns (cross-domain hidden unlocks)
- Quick lookup: "what worked when stuck in situation X?"

### [eureka-moments.md](eureka-moments.md)
Frame-breaking realizations that changed how entire problems were approached:
- 13 entries across 5 domain categories (Runtime, Evidence, Human-Agent, Architecture, Process)
- Each entry: Before state → The realization → Why it generalizes → Trigger
- Read before entering a new domain to pre-arm with the right mental models

### [decision-journal.md](decision-journal.md)
Live record of significant decision forks — written at the decision point, not retrospectively:
- Captures context, visible options, chosen path, reasoning, and reversal condition
- Two sources: live entries (CLAUDE.md rule, written during sessions) + reconstructed entries (agent_reflect Step 11e)
- The only reflection pool file written in real-time during work

### [thinking-patterns.md](thinking-patterns.md)
Domain-independent reasoning heuristics drawn from cross-project interaction patterns:
- 8 patterns (T1–T8): boundary recognition, evidence bias, scope compression, framing, human-agent division, front-loading, work classification, gate-based delivery
- NOT auto-updated by `agent_reflect` — requires deliberate synthesis every 3–4 projects
- Read as pre-commitments before starting any new engagement, not as retrospective explanations

### [key-insights.md](key-insights.md)
Quotable lessons extracted from testimonies:
- One-liner wisdom
- Quick reference for new projects

## Adding New Reflections

When generating new testimony analyses:

1. Run `/agent_reflect` on project(s)
2. Analyze patterns across testimonies
3. Create dated analysis file: `{topic}-{YYYY-MM-DD}.md`
4. Extract key insights to `key-insights.md`
5. Update this README index

## Projects Analyzed (as of 2026-02-21)

| Project | Domain | Key Learning |
|---------|--------|--------------|
| Agentic | Agent hub | Template externalization (51-59% token reduction) |
| CV Generator | Career optimization | Workflow gaps visible only through actual use |
| GL.iNet BE3600 | Router hardening | Defense-in-depth security patterns |
| Mirobot | Agent optimization | Lazy loading pattern |
| Survival | Emergency prep | 3-tier budget optimization |
| UniQure | Enterprise integration | 43% false positive detection rate |
| Vaxxinova Debug | Talend OSGi debugging | Code-level fix (tJavaFlex) when configuration-level approaches fail in OSGi |
| Talend-Reviewer | Integration assessment | Static analysis is preliminary — runtime enrichment changed 4 of 8 scores |
| TMC API MCP Server | MCP server development | Phase gates + security as feature work + 12 API quirks found only in production |

---

**Created**: 2026-01-23
**Last Updated**: 2026-02-21
