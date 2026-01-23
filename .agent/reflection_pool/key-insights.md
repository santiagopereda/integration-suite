# Key Insights from Project Testimonies

Quotable lessons extracted from 6 project journeys. Use for quick reference when starting new projects.

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
> — All 6 Projects
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

### Avoid This
1. Equipment lists without usage procedures
2. Trusting API documentation without testing
3. Empty template directories
4. Single-point assumptions
5. Deferring route/journey validation
6. Day 2 momentum loss in sprints

---

## Metrics That Matter

| Metric | Why It Works |
|--------|--------------|
| Token reduction % | Quantifies optimization impact |
| False positive rate | Validates verification approach |
| Lines eliminated | Measures maintenance burden reduction |
| Test pass rate | Confirms quality preservation |
| Domain-specific (kcal/EUR, kg) | Enables value optimization |

---

**Extracted From**: 6 project testimonies (2026-01-23)
**Projects**: Agentic, CV Generator, GL.iNet, Mirobot, Survival, UniQure
