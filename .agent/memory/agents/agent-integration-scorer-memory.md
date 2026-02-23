# Agent Memory: agent-integration-scorer

**Last Updated**: 2026-02-20
**Patterns From**: 1 project (Talend-Reviewer)
**Total Patterns**: 3

---

## Scoring Accuracy Patterns

### SCA-001: Verify Weighted Average Calculations Manually
- **Pattern**: Automated weighted average produced 2.41 but manual verification showed 2.17. Rounding and weight application order caused the discrepancy.
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: Always verify weighted average score calculations with manual arithmetic. Check rounding at each step and confirm weight application order matches the rubric.
- **Tags**: integration, scoring-accuracy

### SCA-002: Execution Plans Are a DI Concept Not ESB
- **Pattern**: TMC execution plans orchestrate sequential DI batch job runs. ESB routes are long-running Camel bundles with deploy/start/stop lifecycle. Recommending execution plans for ESB routes is an invalid assessment finding.
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: Distinguish DI and ESB lifecycle models when scoring. DI: schedule/execute via TMC plans. ESB: deploy/start/stop as Camel bundles. Never recommend execution plans for ESB routes.
- **Tags**: talend, scoring-accuracy

---

## Weighting Patterns

### WGT-001: Score Corrections Build Trust Through Transparency
- **Pattern**: Publicly acknowledging the 2.41→2.17 score correction demonstrated analytical rigor. Customers trust consultants who correct themselves over those who present unchecked results.
- **Source**: Talend-Reviewer (2026-02-20)
- **Action**: When a score error is discovered, correct it transparently with before/after comparison. Never hide corrections — they build credibility.
- **Tags**: integration, weighting

---

## Benchmarking Patterns

*No patterns extracted yet.*
