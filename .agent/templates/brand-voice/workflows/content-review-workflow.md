# Content Review Workflow

Process for auditing content against the documented voice profile.

## Prerequisites

- Voice profile exists at `.agent/system/brand-voice-profile.md`
- Content to review (text, URL, or file path)

## Workflow Steps

### Step 1: Load Profile
1. Read `.agent/system/brand-voice-profile.md`
2. Identify expected tone settings for content's channel/audience/context
3. Prepare scoring criteria from profile dimensions

### Step 2: Dimensional Analysis

Score each dimension on 1-10 scale:

| Dimension | Score | Evidence |
|-----------|:-----:|----------|
| Principle adherence | | Specific lines that follow or violate |
| Tone accuracy | | Compare against matrix target |
| Vocabulary compliance | | Preferred/avoided words found |
| Attribute alignment | | Measured vs. target position |
| Consistency | | Internal consistency within the piece |

### Step 3: Line-Level Feedback

For each issue found:
- **Line/section**: Where the issue is
- **Issue**: What's wrong (e.g., "tone too formal for blog channel")
- **Profile reference**: Which profile element it violates
- **Suggestion**: Specific rewrite

### Step 4: Overall Assessment

1. Calculate composite voice score (average of dimensions)
2. Classify: Strong (8-10), Acceptable (5-7), Needs Revision (1-4)
3. List top 3 strengths
4. List top 3 improvements needed
5. Provide priority order for revisions

### Step 5: Deliver

Output format:
- Overall score and classification
- Dimension scores table
- Top findings (strengths + improvements)
- Line-level feedback (if detailed mode)
- Quick-fix suggestions for highest-impact improvements
