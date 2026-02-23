# Key Insights from Project Testimonies

Quotable lessons extracted from 9 project journeys. Use for quick reference when starting new projects.

---

## On Workflows & Process

> **"Workflow gaps become visible only through actual use."**
> — CV Generator Agent
>
> *The BrainRocket application revealed a missing recruiter-initiated workflow. Theoretical design misses friction points.*

> **"Documentation during troubleshooting captures the 'why' that post-hoc documentation misses."**
> — GL.iNet BE3600
>
> *Recording the debugging path creates reusable knowledge.*

> **"43% false positive rate validates verification-first approach."**
> — UniQure
>
> *Always verify issues before implementing fixes. Prevented ~4 days unnecessary work.*

> **"Developer walkthrough is non-negotiable — 4 incorrect assumptions corrected in 30 minutes."**
> — Talend-Reviewer
>
> *Agents cannot infer intent from code structure alone. A 30-minute conversation corrects what days of static analysis misses.*

> **"Security findings are feature work, not debt."**
> — TMC API MCP Server
>
> *17 findings → 97 new tests, backward compatible, documented in ADRs. Treat security audits the same as feature sprints.*

> **"Invest in the compounding mechanism, not the individual tools."**
> — Agentic Hub
>
> *agent_reflect grew from v1.0 to v1.6 in 29 days. Each version extends the reach of every future testimony. The return per testimony increases as the tool evolves.*

> **"Wire documentation updates into the tool that produces the source material."**
> — Agentic Hub
>
> *Reflection pool fell behind when updates were manual. Forcing updates in agent_reflect Step 11 made them automatic. The same principle applies to any documentation that depends on another artifact.*

---

## On Budget & Constraints

> **"Budget as optimization parameter, not constraint."**
> — Survival
>
> *3-tier approach (Minimum/Recommended/Premium) enables flexibility without sacrificing safety baselines.*

---

## On Architecture & Design

> **"Travel routers are clients, not servers."**
> — GL.iNet BE3600
>
> *WireGuard server impractical behind hotel NAT. Know your constraints; simplify to two-layer architecture.*

> **"Agent definitions should contain identity, constraints, and workflow; reference content belongs in external templates."**
> — Agentic
>
> *Core insight for 51-59% token reduction through template externalization.*

> **"Defense-in-depth survives single-point failure."**
> — GL.iNet BE3600
>
> *4 independent security layers for SSH. Multiple mechanisms = resilience.*

> **"In OSGi environments, code-level fixes using JDK built-ins are more reliable than configuration."**
> — Vaxxinova Debug
>
> *Bundle isolation means each component embeds its own CXF — you can't override it. Drop to java.net.http.HttpClient.*

> **"Phase gates prevent scope drift more reliably than task lists."**
> — TMC API MCP Server
>
> *MVP → Full Coverage → Integration Tests → Security Hardening. Each gate a formal checkpoint. 39 tools, 390 tests, 2 days.*

> **"Name the retrieval question before building the knowledge store."**
> — Agentic Hub
>
> *Reflection pool expanded from 4 to 8 files by answering: what question does each store answer? One over-broad store degrades all retrieval needs.*

---

## On Documentation

> **"False positives are documentation opportunities."**
> — UniQure
>
> *CRIT-2 "no bidirectional sync" wasn't wrong - it was a documentation gap. Added FAQ sections, naming convention notes.*

> **"Recipes/implementations are source of truth; resource files are reference."**
> — UniQure
>
> *VQL files drifted from actual recipes. Always verify against actual implementations.*

> **"ADRs are institutional memory — they capture 'why' as much as 'what'."**
> — TMC API MCP Server
>
> *5 ADRs captured all technical decisions and prevented revisiting decided questions. Give future contributors the context they need.*

> **"Assessment artifacts should evolve — scores change as remediation happens."**
> — Talend-Reviewer
>
> *Score 2.17 → 2.38 as 7 red flags resolved. Never treat an integration assessment as a snapshot.*

---

## On Validation & Testing

> **"Always test against actual production APIs; don't trust documentation alone."**
> — UniQure
>
> *Only 1 of 7 SAP blocking fields works during creation (contrary to documentation).*

> **"UCI interface binding doesn't work with Tailscale TUN devices."**
> — GL.iNet BE3600
>
> *Single-point assumptions invalidated by testing. Design for discovered reality.*

> **"Runtime enrichment changed 4 of 8 dimension scores — any static score is preliminary."**
> — Talend-Reviewer
>
> *2.41 (static) corrected to 2.17 after runtime data. 10% swing. Flag static scores explicitly; never present them as final. Recommended flag text: **"Preliminary — Static Analysis Only"**.*

> **"12 API quirks survived all unit tests; only manual testing against production revealed them."**
> — TMC API MCP Server
>
> *Baseline expectation for any API integration: 8-12 behavioral quirks will exist that documentation doesn't mention.*

---

## On Completeness

> **"Equipment without operational procedures = limited readiness."**
> — Survival
>
> *80% category completion but only 50% evacuation readiness. Missing SOPs, checklists, daily routines.*

> **"Validate journey feasibility BEFORE equipment procurement."**
> — Survival
>
> *All gear for 1,400km journey, but no route validation. No point buying gear for an impossible journey.*

---

## On Structure

> **"injection-history.md is non-negotiable."**
> — All 9 Projects
>
> *100% usage rate. Audit trail provides complete project evolution record.*

> **"Empty template sections mislead."**
> — Multiple Projects
>
> *tasks/ and sops/ folders with only README.md create false expectations. Populate or remove.*

---

## Quick Reference: Do This / Avoid This

### Do This
1. Verify before implementing (43% false positive rate)
2. Document as you code (prevents drift)
3. Test assumptions against production
4. Create SOPs while procedures are fresh
5. Use phased approaches with clear objectives
6. Add FAQ sections for complex decisions
7. Export architecture/config before debugging (reveals structural assumptions early)
8. Document experiments as you run them, not afterward
9. Use phase gates for complex multi-phase deliverables

### Avoid This
1. Equipment lists without usage procedures
2. Trusting API documentation without testing
3. Empty template directories
4. Single-point assumptions
5. Deferring route/journey validation
6. Day 2 momentum loss in sprints
7. Treating static analysis scores as final (runtime data changes everything)
8. Trusting unit tests to catch API behavioral quirks (test against real production)

---

## Metrics That Matter

| Metric | Why It Works |
|--------|--------------|
| Token reduction % | Quantifies optimization impact |
| False positive rate | Validates verification approach |
| Lines eliminated | Measures maintenance burden reduction |
| Test pass rate | Confirms quality preservation |
| Domain-specific (kcal/EUR, kg) | Enables value optimization |
| Score swing (static→runtime) | Quantifies static analysis risk (expect 10%+) |
| Red flags resolved % | Tracks remediation velocity over time |
| Security iteration test yield | Validates depth (expect ~50 new tests per iteration) |

---

---

## On Agent Optimization (Campaign 2026-02-22)

> **"Content type drives optimization outcomes more than externalization volume."**
> — Agent Optimization Campaign (Tier 1+2)
>
> *git-manager (75.7% externalization, high-context) achieved 23.2% reduction. cv-optimizer (69% externalization, low-context) achieved 52.5% reduction. Low-context content = 40-60% reduction; high-context content = 20-30% reduction.*

> **"Documentation overhead is fixed (~800-1,600 tokens), not proportional to agent size."**
> — Agent Optimization Campaign
>
> *Template Usage tables + references add same overhead regardless of baseline. Large agents (15K) absorb 11% overhead → 50-60% net reduction. Small agents (3K) absorb 27-50% overhead → 6-23% net reduction.*

> **"Design-time optimization beats retrofit optimization."**
> — agent-project-init discovery
>
> *agent-project-init was designed with 5 external templates from creation (~6.4K externalized). Zero optimization effort needed. Retrofitting similar agents took 2.5 hours each for 15-52% reduction. Design with templates from start = better ROI.*

> **"Low-context threshold (40%) predicts cost-effectiveness."**
> — Decision Tree Validation (8 agents)
>
> *Agents with <40% low-context content (tables, examples) have high documentation overhead that reduces net savings below acceptable ROI. git-manager (25% low-context) optimized for pattern validation. hub-orchestrator (25% low-context) correctly skipped as redundant.*

> **"Optimize first instance of pattern for learning, skip subsequent instances."**
> — Tier 2 Selective Optimization
>
> *git-manager optimized to validate high-context pattern (23.2% reduction). hub-orchestrator skipped because pattern already validated. First optimization has learning value beyond token savings.*

### Optimization Patterns (PAT-01 through PAT-05)

**PAT-01: Template Externalization** (Validated - 51-65% reduction for low-context content)
- **Trigger**: Embedded content >100 words (examples, templates, checklists, reference tables)
- **Action**: Extract to `.agent/templates/{domain}/{name}.md`, reference via lazy loading
- **Content Type Classification**:
  - **Low-context** (tables, examples, configs): 60-80% reduction ratio → **40-60% net reduction**
  - **High-context** (workflows, procedures): 30-40% reduction ratio → **20-30% net reduction**
- **Threshold**: Agents with <40% low-context content not cost-effective (high documentation overhead)
- **Result**: Agent contains only identity + workflow + template references
- **Proven**: SAP (58%), Ansible (59%), cv-optimizer (52.5%), git-manager (23.2%)

**PAT-02: Lazy Loading** (Validated - 5% overhead elimination)
- **Trigger**: After PAT-01 template externalization
- **Action**: Reference templates on demand, not at session start
- **Pattern**: "See `.agent/templates/{domain}/{template}.md` for details"
- **Result**: Baseline agent tokens reduced, full content loaded only when needed
- **CLI Note**: Currently auto-loads all agents (limitation), but still provides 40-60% savings

**PAT-03: Output Modes** (Validated - user verbosity control)
- **Trigger**: Agents with varying user needs (quick vs detailed responses)
- **Action**: Add Brief/Standard/Detailed modes with clear output format differences
- **Result**: Users control verbosity, agent handles all modes with same core logic
- **Proven**: Implemented across multiple agents

**PAT-04: Section Compression** (Validated - 15-30% reduction for specific sections)
- **Trigger**: Redundant examples, verbose explanations, unconsolidated lists
- **Action**: Consolidate examples, use bullet lists vs paragraphs, eliminate redundancy
- **Result**: Improved clarity + reduced tokens
- **Caution**: Don't compress at cost of usability

**PAT-05: Verification-First Constraints** (Validated - prevents fabrication)
- **Trigger**: All agents that reference external content or make claims
- **Action**: Add explicit constraints: "Never fabricate", "Verify before claiming", "Acknowledge uncertainty"
- **Result**: Quality gate enforcement prevents hallucination
- **Critical**: Must be preserved during optimization (QG-2, QG-3, QG-5)

### Agent Optimization Decision Tree (Quick Reference)

```
Should I optimize this agent?
│
├─ In "Already Optimized" registry? → SKIP
├─ Baseline <2,000 tokens? → SKIP (overhead > savings)
├─ Externalization <15%? → SKIP (not enough content)
│
├─ Content Type Classification:
│  ├─ >60% LOW-CONTEXT (tables, examples) → OPTIMIZE (expect 40-60%)
│  ├─ >60% HIGH-CONTEXT (workflows, procedures):
│  │  └─ Low-context % of agent ≥40%? → OPTIMIZE (expect 20-30%)
│  │  └─ Low-context % of agent <40%? → SKIP (low ROI)
│  └─ MIXED (40-60% each) → OPTIMIZE if low-context ≥40%
│
└─ Exception: First instance of new pattern → OPTIMIZE (learning value)
```

**See**: `.agent/sops/agent-optimization-decision-tree.md` for full framework

---

**Extracted From**: 11 project testimonies + Agent Optimization Campaign (last updated 2026-02-22)
**Projects**: Agentic (×3), CV Generator, GL.iNet, Mirobot, Survival, UniQure + Vaxxinova Debug, Talend-Reviewer, TMC API MCP Server, Agent Optimization Campaign (Tier 1+2)
