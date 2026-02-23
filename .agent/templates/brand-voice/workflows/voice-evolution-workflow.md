# Voice Evolution Workflow

Process for periodically reviewing and evolving the brand voice profile.

## Prerequisites

- Existing voice profile at `.agent/system/brand-voice-profile.md`
- Access to recent content (10-20 pieces across channels)
- Stakeholder availability for feedback

## Trigger Conditions

Run this workflow when:
- Scheduled review date reached (set in voice profile)
- Significant market or audience shift
- Brand repositioning or strategy change
- New channel launch
- Consistent voice drift detected in reviews
- Stakeholder change (new CMO, new content team)

## Workflow Steps

### Step 1: Gather Data
1. Load current voice profile
2. Load `assessment/periodic-review-template.md`
3. Collect 10-20 recent content pieces across channels
4. Gather audience metrics (engagement, sentiment if available)
5. Collect content team feedback

### Step 2: Content Audit
1. Run Reviewer mode on each content piece
2. Record scores in periodic review template
3. Calculate average voice score and trend vs. previous review
4. Identify systematic drift patterns

### Step 3: Context Assessment
1. Review competitive landscape changes
2. Assess audience evolution (new segments, changed expectations)
3. Check brand strategy alignment
4. Note new channels or content formats

### Step 4: Gap Analysis

| Profile Element | Current | Observed | Gap | Action Needed |
|----------------|---------|----------|-----|---------------|
| [Principle] | [Defined] | [Practiced] | [Drift direction] | [Update profile / Retrain team] |

### Step 5: Propose Updates
1. Draft specific profile changes with rationale
2. Categorize: Minor adjustment vs. significant shift
3. For significant shifts: require stakeholder approval via reconciliation
4. For minor adjustments: document and apply

### Step 6: Implement
1. Update `.agent/system/brand-voice-profile.md`
2. Version the profile (increment version number)
3. Document changes in profile's revision history
4. Communicate changes to content team
5. Set next review date
