# Thinking Patterns

Reasoning heuristics that emerged from working across 9 projects — not what was learned in each project, but how thinking about problems has evolved. These are domain-independent. The project examples are evidence, not the point.

**How to use**: Read at the start of any new engagement, not after getting stuck. These are pre-commitments about how to reason, not retrospective explanations.

**Update cadence**: This file is not updated per-testimony. Update after every 3–4 new projects or when a pattern is meaningfully challenged or refined by new experience.

**Last Updated**: 2026-02-21 | **Patterns**: 8

---

## T1: Stop when the same error class repeats

**The pattern**: When 2–3 different approaches all produce structurally identical failures, you are not debugging an implementation problem. You have hit a boundary — an isolation layer, an architectural constraint, or a wrong frame. More approaches will not help. Stop, find the boundary, and decide whether to work within it or go below it.

**When to apply**: You catch yourself varying the same approach for the third time. The error messages look different on the surface but fail for the same underlying reason.

**What it prevents**: Losing days to variations of a fundamentally blocked path.

**Evidence**: Client-B (3 config-level fixes all hit OSGi bundle isolation), GL.iNet (2 UCI approaches hit TUN device boundary), Raspberry Pi (multiple Python attempts hit version incompatibility).

---

## T2: Indirect evidence has predictable bias — know which direction

**The pattern**: Every indirect source of information has a characteristic error direction. API documentation overstates what works. Static analysis overstates what runs. Issue titles overstate severity. Your mental model overstates what you can configure. Knowing the bias direction tells you where to apply skepticism before you've seen any evidence of error.

**When to apply**: You're about to make a decision based on documentation, code analysis, an issue list, or your own initial read of a system. Before acting, ask: which way does this source tend to be wrong?

**What it prevents**: Designing integrations that fail in production, implementing fixes for problems that don't exist, finalizing assessments that runtime data would correct.

**Evidence**: Client-A (only 1 of 7 SAP fields worked; docs said all worked), TMC (12 API quirks survived unit tests), Talend-Reviewer (static score off by 10%; 4 of 8 dimensions changed after runtime), Client-A (43% of issues were false positives).

---

## T3: Compress before you execute

**The pattern**: When a task list, issue backlog, or scope feels large, the first action is elimination — not prioritization, not sequencing, not execution. Verify that each item actually exists as described. False items waste effort regardless of how efficiently you execute them.

**When to apply**: You have a list of things to fix, implement, or address that feels overwhelming or where the effort seems disproportionate to the problem. Before starting any item, ask: does this item actually exist as described?

**What it prevents**: Implementing fixes for false positives, over-investing in issues that are documentation gaps rather than real problems.

**Evidence**: Client-A (6 of 14 CRITICAL issues eliminated before implementation; 4 days saved), Client-A CRIT-2 (5-day estimate compressed to 1 day after scoping the real work).

---

## T4: The frame determines what solutions are possible

**The pattern**: When a problem resists all solutions you can think of, the problem is usually framed wrong — not unsolvable. A wrong frame makes the problem appear harder than it is; a correct frame makes the solution obvious. Before trying more solutions, test the frame.

**When to apply**: You've tried several reasonable approaches and none worked. The problem feels fundamental rather than fixable. You're explaining why something can't be done.

**What it prevents**: Solving the wrong problem efficiently, building architectures with structural impossibilities baked in.

**Evidence**: GL.iNet (designing WireGuard server on NAT-blocked router; frame shift to client-only collapsed the problem), Survival (static kit design produced wrong answers for all 3 emergency phases; frame shift to phased consumption made every decision straightforward).

---

## T5: Humans hold the WHY; artifacts hold the WHAT

**The pattern**: Code, documentation, and configuration tell you what was built. Only the person who built it knows why — what constraint it was responding to, what was deliberately left simple, what was meant to be temporary. Any assessment or recommendation that relies only on artifacts is operating on incomplete evidence. One conversation provides what no artifact can.

**When to apply**: You're assessing a live system, preparing a recommendation, or trying to understand intent behind a design choice. Before finalizing anything, identify whether you've accessed the WHY or only the WHAT.

**What it prevents**: Wrong recommendations based on plausible-but-incorrect inferences from code structure.

**Evidence**: Talend-Reviewer (4 architectural assumptions corrected in 30 minutes; all were wrong from static analysis alone), Client-A (intent behind "no bidirectional sync" was documentation gap, not false claim — discoverable only by asking).

---

## T6: Front-load the model before execution

**The pattern**: Any work that will repeat — applications, assessments, reviews, debugging sessions — benefits from one upfront investment in the methodology, positioning, or framework before starting the first instance. The upfront cost is paid once; it reduces the cost of every subsequent instance.

**When to apply**: You're about to start the first item in a series of similar tasks. Before starting, ask: what is the repeating part of this work? Can I build that once now instead of rebuilding it partially each time?

**What it prevents**: Repeated ramp-up cost, inconsistent outputs across instances, decisions made without a consistent evaluative frame.

**Evidence**: CV Generator (2 days of positioning docs before first application; per-application time dropped from 2 hours to 30 minutes), Talend-Reviewer (assessment methodology established before first dimension; consistent scoring across 8 dimensions).

---

## T7: How work is classified determines its quality

**The pattern**: The label on a piece of work determines how it gets treated — how much testing it receives, whether decisions are documented, whether backward compatibility is considered. Work labeled "debt" or "cleanup" gets rushed. Work labeled "feature" gets designed, tested, and documented. The content doesn't change; the classification changes the process.

**When to apply**: You're about to start a piece of work that doesn't fit neatly into "feature" or "bugfix" — security hardening, refactoring, documentation, migration. Before starting, decide whether it gets feature-quality treatment or cleanup-quality treatment. Be explicit about it.

**What it prevents**: Undertested security changes, undocumented architectural decisions, regressions introduced during "quick" cleanups.

**Evidence**: TMC (3 security hardening iterations; each produced ADRs, backward compatibility, 30+ new tests per iteration — treated as features throughout).

---

## T8: Gates enforce done; lists allow deferral

**The pattern**: A task list answers "what needs to be done." A phase gate answers "what must be true before we advance." Lists allow the second layer to begin before the first layer is complete — the second layer then inherits the first layer's unfinished problems. Gates prevent this. For any work with layers that depend on each other, define completion criteria for each layer before starting.

**When to apply**: You're managing a deliverable with layers (core → coverage → testing → security, or design → build → review → deploy). Before starting the second layer, ask: is the first layer done by the gate's definition, or just mostly done?

**What it prevents**: Regression loops where later-phase problems require reworking earlier phases, scope drift where the second layer compensates for the first layer's shortcuts.

**Evidence**: TMC (39 tools in 2 days across 4 formal phases; security hardening was its own phase — no regression into earlier phases because each gate was enforced before advancing).

---

## Adding New Patterns

A thinking pattern qualifies when:
1. It is **domain-independent** — it applies to debugging, planning, assessment, development, and everyday decisions, not just one of these
2. It emerged from **repeated experience across multiple projects** — not a single lesson from one project (those go in `eureka-moments.md`)
3. It describes **how to reason**, not **what was found** — it changes the approach, not just the conclusion
4. It is **violated at cost** — projects where this pattern wasn't applied produced measurable worse outcomes

Format:
```markdown
## T[N]: [Pattern name — a reasoning rule, present tense, actionable]

**The pattern**: [Abstract description — second person, no project references]
**When to apply**: [The signal that this pattern is needed]
**What it prevents**: [The failure mode without this pattern]
**Evidence**: [Brief project references — 1-2 lines, footnote role not center]
```

Update this file manually after 3–4 new testimonies accumulate, or when a new project meaningfully challenges an existing pattern. Do not update per-testimony — these patterns need cross-project validation before they qualify.

---

**Sources**: 9 project testimonies (Jan–Feb 2026), cross-project interaction patterns
**Not auto-updated by `agent_reflect`** — requires deliberate synthesis across multiple projects
