# Value Unlock Index

Single interventions that produced disproportionate outcomes, extracted from 9 project testimonies.

**How to use**: Find your current situation in the index below. Each entry answers: "what one action produced outsized results from this exact situation?"

**Last Updated**: 2026-02-21 | **Projects**: 10 | **Entries**: 21

---

## Quick Lookup by Situation

| You are... | Go to |
|------------|-------|
| Stuck — something doesn't work despite correct-looking config | [Blocked](#blocked--something-isnt-working) |
| About to implement fixes or changes | [Before Implementing](#before-implementing) |
| About to score, assess, or make a final judgment | [Before Finalizing a Score or Assessment](#before-finalizing-a-score-or-assessment) |
| Starting a complex project without a clear frame | [Starting Complex Work](#starting-complex-work) |
| Drowning in scope or issue lists | [Scope Is Overwhelming](#scope-is-overwhelming) |
| Token cost, overhead, or maintenance is too high | [Reducing Cost or Overhead](#reducing-cost-or-overhead) |
| A single mechanism is failing and has no fallback | [Single Point of Failure](#single-point-of-failure) |

---

## Blocked — Something Isn't Working

### SSH via Tailscale: "Connection refused" despite correct ACLs
**Intervention**: Add `tailscale0` interface to a firewall zone (`lan`). OpenWRT's default `input='REJECT'` silently blocks interfaces not in any zone — the interface/zone/traffic chain is mandatory.
**Outcome**: SSH immediately functional. Documented for all future OpenWRT/Tailscale setups.
**Project**: GL.iNet BE3600 (2026-01)

---

### HTTP PATCH silently becoming POST in Talend
**Intervention**: Replace `tRESTClient` with `tJavaFlex` using `java.net.http.HttpClient` (Java 17 JDK built-in). Bypasses the bundle-embedded CXF entirely — OSGi isolation means config-level fixes cannot reach it.
**Outcome**: PATCH sent correctly to Business Central. 8 days of failed alternative approaches unblocked.
**Project**: Client-B Debug (2026-02)

---

### Ansible deployment failing with Python compatibility errors
**Intervention**: Pin Python to a specific version via `pyenv` (3.9.18). Replace unreliable `which pyenv` detection with `ansible.builtin.stat` for non-interactive shell execution.
**Outcome**: 69 tasks, 0 failures. Documented constraints prevent future Ansible role reuse failures.
**Project**: Raspberry Pi / Mirobot (2025-11)

---

### SAP OData write operations failing with CSRF token errors
**Intervention**: Split single-action into two: Action 1 fetches CSRF token + captures `Set-Cookie` header as JSON array. Action 2 receives token + cookies as inputs and sends `Cookie` header.
**Outcome**: All SAP write operations validated against production. 380-line reusable SDK connector created.
**Project**: Client-A (2025-12)

---

## Before Implementing

### Issues identified, fixes planned
**Intervention**: Verify each issue against actual code/behavior before writing a single line of fix. Use recipe exports, screenshots, platform feature documentation.
**Outcome**: 43% of planned fixes were false positives (6 of 14). ~4 days of unnecessary work prevented.
**Project**: Client-A (2026-01)

---

### Effort estimate feels large before you've looked closely
**Intervention**: Audit the actual scope first — read the real artifacts, not the issue title. CRIT-2 "No Bidirectional Sync" sounded like a major fix; audit revealed it was a documentation gap.
**Outcome**: Estimated 5 days → completed in 1 day (80% reduction). Same outcome: clarity achieved.
**Project**: Client-A (2026-01)

---

### API integration designed from documentation alone
**Intervention**: Test every field/behavior against actual production API before finalizing design. Build a field availability matrix with real error messages.
**Outcome**: Discovered only 1 of 7 documented SAP blocking fields works during entity creation. Prevented a design that would have failed in production.
**Project**: Client-A (2025-11)

---

## Before Finalizing a Score or Assessment

### Static analysis complete, assessment score ready to present
**Intervention**: Run a developer walkthrough before finalizing. Present your findings and ask the domain owner to confirm or correct them.
**Outcome**: 4 of 4 architectural assumptions were wrong. Corrected in 30 minutes vs. days of inference.
**Project**: Talend-Reviewer (2026-02)

---

### Score calculated from static analysis only
**Intervention**: Enrich with runtime data (logs, monitoring, execution history) before presenting any score. Mark static-only scores explicitly as "Preliminary — Static Analysis Only."
**Outcome**: Score corrected from 2.41 to 2.17 (10% swing). 4 of 8 dimension scores changed after runtime enrichment.
**Project**: Talend-Reviewer (2026-02)

---

## Starting Complex Work

### Starting a job search or application campaign from scratch
**Intervention**: Front-load career documentation before the first application: 30-second pitch, core value proposition, 7 STAR stories, portfolio gaps. Takes 2 days upfront.
**Outcome**: Per-application turnaround dropped from ~2 hours to ~30 minutes. All applications draw from pre-built narratives.
**Project**: CV Generator Agent (2026-01)

---

### Starting emergency or survival planning
**Intervention**: Define a phased consumption model before listing any supplies. Phases determine what you need — supplies without phases produce the wrong list.
**Outcome**: 3-stage model (Frozen → Basement → Cycling) became the organizing principle for the entire project: 33 recipes, 3 gear tiers, weight/calorie constraints per stage.
**Project**: Survival (2026-01)

---

### Starting to debug a complex multi-component system
**Intervention**: Export the full architecture/config before debugging. Understanding component boundaries (e.g., Runtime vs. Remote Engine dual-JVM) determines which debug paths are even possible.
**Outcome**: Architecture export revealed OSGi bundle isolation, eliminating 3 of 4 planned debug paths before trying them.
**Project**: Client-B Debug (2026-02)

---

### Starting a complex multi-deliverable project
**Intervention**: Define formal phase gates before starting. Each phase has a single objective and a completion check before the next begins. Never run phases in parallel.
**Outcome**: 39 MCP tools, 4 resources, 390 tests delivered in 2 days. Security hardening was a distinct phase — no regression loops.
**Project**: TMC API MCP Server (2026-02)

---

## Scope Is Overwhelming

### Long issue list, unclear where to start
**Intervention**: Verify all issues before triaging by severity. False positives are common (43% observed). Severity labels on unverified issues waste prioritization effort.
**Outcome**: Eliminated 6 of 14 CRITICAL/HIGH issues as false positives before any implementation began.
**Project**: Client-A (2026-01)

---

### Documentation spread across many files with duplication
**Intervention**: Identify all files covering the same topic, consolidate into one SOP with clear procedures, delete the rest.
**Outcome**: RESOURCE_INDEX guidance: 3 files (~900 lines) → 1 SOP (175 lines), 80% reduction. 13 duplicate files eliminated across the project.
**Project**: Client-A (2025-11)

---

## Reducing Cost or Overhead

### Agent token consumption too high per invocation
**Intervention**: Externalize all static reference content (templates, examples, checklists) to `.agent/templates/`. Agents load only what's needed via the Read tool.
**Outcome**: 51–59% token reduction. SAP agent: 15,000 → 6,300 tokens. Ansible agent: 16,000 → 6,543 tokens. Zero functionality loss.
**Projects**: Agentic Hub, Mirobot (2025-11)

---

### Security work keeps growing without clear boundaries
**Intervention**: Treat each security audit pass as a formal feature sprint: findings → fixes → tests → ADR → backward compatibility check. One pass, one set of changes, then ship.
**Outcome**: 3 iterations, 17 findings, 97 new tests. Each iteration fully backward compatible. No regression loops.
**Project**: TMC API MCP Server (2026-02)

### Documentation index falling behind despite intent to maintain it
**Intervention**: Make updates mandatory in the tool that produces the source material (agent_reflect Step 11). If documentation depends on an artifact, the tool that writes the artifact must also write the documentation — not rely on manual schedules.
**Outcome**: Reflection pool stays current automatically on every agent_reflect run. Zero drift possible regardless of workload.
**Project**: Agentic Hub (2026-02)

---

## Single Point of Failure

### One security mechanism failing, no alternative
**Intervention**: Stop trying to fix the failing mechanism. Implement 4 independent layers instead — each must independently prevent unauthorized access. Single-point fixes are fragile by design.
**Outcome**: Tailscale ACLs + firewall zone + source IP rules + SSH key-only auth. Any single layer failing = 3 remaining intact.
**Project**: GL.iNet BE3600 (2026-01)

---

### One framework blocking a required operation
**Intervention**: Identify the boundary the framework cannot cross (OSGi bundle, CXF classloader, Python version). Go below it using JDK primitives or explicit version pinning.
**Outcome**: Applied in Client-B (CXF → HttpClient) and Raspberry Pi (system Python → pyenv). Both unblocked immediately.
**Projects**: Client-B Debug, Raspberry Pi (2026-02, 2025-11)

---

### Application workflow missing a required entry point
**Intervention**: When a real use case fails to fit the workflow, add the entry point the same day. Don't defer.
**Outcome**: Recruiter-initiated outreach path added immediately after discovering the gap. Second application used it successfully.
**Project**: CV Generator Agent (2026-01)

---

## Meta-Patterns: Hidden Unlocks

Four patterns appear across multiple situations and domains. These are the structural unlocks — recognizing them changes what you do, not just how you do it.

### M1: Verify Before You Implement

The same intervention type prevented wasted work across four projects in four different domains:
- Client-A: 43% of issues were false positives
- Talend-Reviewer: 4 architectural assumptions were wrong
- Client-A (CRIT-2): effort estimate was 5× too high
- Client-A (API fields): documentation was wrong about which fields worked

**Signal that you need this**: You have a list of things to fix, or a plan to implement, but haven't tested the assumptions yet.

---

### M2: Architectural Reframe Changes Everything Downstream

One conceptual pivot restructured the entire project:
- Survival: 3-stage consumption model → organized 33 recipes, gear, electronics, medical around it
- Agentic: template externalization → 51% token reduction, changed agent design permanently
- CV Generator: intent taxonomy (Target/Practice/Exploratory) → changed how every application was evaluated

**Signal that you need this**: You're building on a framework that feels arbitrary or produces constant exceptions.

---

### M3: When the Framework Path Is Blocked, Go Below It

Across three projects, configuration-level fixes failed due to runtime isolation:
- GL.iNet: UCI interface binding blocked by Tailscale TUN → moved to firewall zones
- Client-B: tRESTClient blocked by OSGi CXF → moved to java.net.http.HttpClient
- Raspberry Pi: system Python blocked by version constraints → moved to pyenv

**Signal that you need this**: You've tried 2–3 configuration approaches and all fail with the same class of error.

---

### M4: Audit Actual Scope Before Estimating Effort

Two cases where auditing before estimating changed the trajectory:
- Client-A CRIT-2: reading the actual artifacts first revealed 80% less work than estimated
- Client-A false positives: verifying against code first eliminated 43% of the issue list

**Signal that you need this**: Your effort estimate came from reading issue titles or summaries, not the actual artifacts.

---

## Adding New Entries

When a new testimony produces a value unlock moment, add it using this format:

```markdown
### [Situation title — specific enough to match when you're in it]
**Intervention**: [What was done — specific and actionable, not a category]
**Outcome**: [What resulted — quantified if possible]
**Project**: [Name] ([YYYY-MM])
```

Assign it to the closest existing situation category. Create a new category only if none fit.

After adding entries, review the Meta-Patterns section — new entries may strengthen existing patterns or reveal new ones.

---

**Sources**: 9 project testimonies (Jan–Feb 2026)
**Updated by**: `agent_reflect` Step 11 (per-testimony) + manual synthesis (meta-patterns)
