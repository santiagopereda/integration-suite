# Improvement Roadmap: [NAME]

**Date**: [DATE]
**Designer**: [NAME]
**Assessment Reference**: [Link]
**Scorecard Reference**: [Link]

---

## Current State Summary

- **Overall Maturity**: Level [X] - [Label]
- **Weighted Score**: [X.X / 5.0]
- **Risk Level**: [Critical / High / Medium / Low]
- **Target Maturity**: Level [Y] - [Label]
- **Timeline**: [X months]

## Gap Analysis

| Dimension | Current | Target | Gap | Priority | Effort |
|-----------|---------|--------|-----|----------|--------|
| Architecture & Design | [X] | [Y] | [+Z] | [Critical/High/Med] | [S/M/L] |
| Data Quality & Governance | [X] | [Y] | [+Z] | | |
| Operational Excellence | [X] | [Y] | [+Z] | | |
| Reliability & Resilience | [X] | [Y] | [+Z] | | |
| Security & Compliance | [X] | [Y] | [+Z] | | |
| Business Impact | [X] | [Y] | [+Z] | | |
| Maintainability & Scalability | [X] | [Y] | [+Z] | | |
| Tool & Platform | [X] | [Y] | [+Z] | | |

---

## Phase 1: Critical Fixes (1-2 weeks)

**Goal**: Address red flags and security vulnerabilities. Reduce risk level.

### Improvements

| # | Dimension | Action | Current -> Target | Effort | Owner |
|---|-----------|--------|-------------------|--------|-------|
| 1.1 | [Dim] | [Specific action] | [X -> Y] | [Hours/Days] | [Team] |

### Success Criteria
- All critical red flags addressed
- Risk level reduced from [X] to [Y]
- No security vulnerabilities remaining

### Rollback Plan
- [How to revert if issues arise]

---

## Phase 2: Quick Wins (2-6 weeks)

**Goal**: Achieve Level 3 (Centralized) on critical dimensions. Build operational foundation.

### Improvements

| # | Dimension | Action | Current -> Target | Effort | Owner |
|---|-----------|--------|-------------------|--------|-------|
| 2.1 | [Dim] | [Specific action] | [X -> Y] | [Days/Weeks] | [Team] |

### Success Criteria
- Critical dimensions (Ops, Reliability, Security) at Level 3+
- Basic observability in place (logs, metrics, alerts)
- Retry and error handling standardized

### Dependencies
- [Phase 1 must be complete]
- [Platform access/licenses required]

---

## Phase 3: Strategic Improvements (1-3 months)

**Goal**: Achieve target maturity. Establish sustainable practices.

### Improvements

| # | Dimension | Action | Current -> Target | Effort | Owner |
|---|-----------|--------|-------------------|--------|-------|
| 3.1 | [Dim] | [Specific action] | [X -> Y] | [Weeks/Months] | [Team] |

### Success Criteria
- All dimensions at target maturity level
- Full observability stack operational
- CI/CD pipeline automated
- Documentation complete

### Dependencies
- [Phase 2 must be complete]
- [Team training on new patterns]

---

## Phase 4: Optimization (3-12 months, ongoing)

**Goal**: Exceed target maturity. Continuous improvement.

### Improvements

| # | Dimension | Action | Current -> Target | Effort | Owner |
|---|-----------|--------|-------------------|--------|-------|
| 4.1 | [Dim] | [Specific action] | [X -> Y] | [Months] | [Team] |

### Success Criteria
- Performance optimized to target SLOs
- Proactive monitoring and alerting
- Chaos engineering in practice
- Knowledge documented and shared

---

## Migration Strategy

### Zero-Downtime Approach
- [How to deploy improvements without service interruption]
- [Parallel run strategy if applicable]

### Rollback Points
- After Phase 1: [How to revert]
- After Phase 2: [How to revert]
- After Phase 3: [How to revert]

### Testing Per Phase
- Phase 1: Verify critical fixes in staging
- Phase 2: Integration tests for new patterns
- Phase 3: Full E2E regression + performance tests

## Resource Requirements

| Phase | Team Size | Skills Needed | Duration | Estimated Cost |
|-------|-----------|--------------|----------|---------------|
| Phase 1 | [X] | [Skills] | [X weeks] | [Low/Med/High] |
| Phase 2 | [X] | [Skills] | [X weeks] | |
| Phase 3 | [X] | [Skills] | [X months] | |
| Phase 4 | [X] | [Skills] | Ongoing | |

## Progress Tracking

### Milestones

| Milestone | Target Date | Status |
|-----------|------------|--------|
| Phase 1 Complete | [Date] | [Not Started / In Progress / Done] |
| Phase 2 Complete | [Date] | |
| Phase 3 Complete | [Date] | |
| Target Maturity Achieved | [Date] | |

### Maturity Progression

| Date | Overall Score | Level | Notes |
|------|-------------|-------|-------|
| [Baseline date] | [X.X] | [Level] | Initial assessment |
| [Phase 1 end] | [X.X] | [Level] | After critical fixes |
| [Phase 2 end] | [X.X] | [Level] | After quick wins |
| [Phase 3 end] | [X.X] | [Level] | Target achieved |

---

## Methodology Notes

### SOLO/PAIR Classification

Every improvement action in this roadmap must be classified for implementability:

- **SOLO**: Implementable directly from this roadmap and existing code/documentation alone
- **PAIR**: Requires a domain owner present - undocumented runtime behavior, live system state dependencies, business rules not in code

Format each action item as: `[Phase X.Y] Action title - [SOLO|PAIR] - Verify: [specific check before implementing]`

When uncertain, default to PAIR. PAIR items attempted as SOLO have a 43% false positive rate.

### Verification-Before-Implementation Gate

Before implementing any improvement action classified as MEDIUM or LOW confidence from the assessment:

1. Verify the finding against actual runtime behavior (not just code/docs)
2. Confirm with domain owner that the gap is real, not a documentation gap
3. If verification changes the finding, update both the roadmap and the scorecard

This gate exists because 43% of static analysis findings are false positives. Implementing "fixes" for non-issues wastes effort and can introduce regressions.

### Security as Feature Work

Security gaps are CRITICAL tier improvements, not strategic or optimization items:
- Missing OAuth, unencrypted channels, exposed credentials = Phase 1 (1-2 weeks)
- Never phase security as "later enhancements" - build it into the critical fixes phase
- Security improvements must block approval if unresolved after Phase 1

---

**Usage**: This roadmap is a living document. Update scores, status, and remediation progress as fixes land. Include sprint/phase assignments so it serves as both a plan and a tracking tool throughout the engagement.
