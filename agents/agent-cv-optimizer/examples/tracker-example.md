# Example: Application Tracker Format

This example demonstrates the application tracker file format and usage.

## Tracker File: applications/tracker.md

```markdown
# Application Tracker

Last Updated: 2026-01-18 14:30:00

## Active Applications

| Company | Role | Status | Applied | Last Activity | Next Step | Priority |
|---------|------|--------|---------|---------------|-----------|----------|
| Spotify | Senior Data Engineer | Technical | 2026-01-05 | 2026-01-15 | System design interview Jan 22 | H |
| Airbnb | Staff Data Engineer | Screening | 2026-01-10 | 2026-01-12 | Awaiting recruiter call | H |
| Meta | Data Engineer (ML Infra) | Applied | 2026-01-18 | 2026-01-18 | Waiting for response | M |
| Databricks | Solutions Engineer | Researching | - | 2026-01-17 | Finish cover letter | M |
| Netflix | Senior Data Engineer | Preparing | - | 2026-01-16 | Tailor CV | L |

## Archived Applications

| Company | Role | Final Status | Applied | Outcome Date | Notes |
|---------|------|--------------|---------|--------------|-------|
| Stripe | Data Engineer | Rejected | 2025-12-15 | 2026-01-08 | Made it to final round, feedback: need more payments domain experience |
| Google | Data Engineer L5 | Withdrawn | 2025-12-01 | 2025-12-20 | Withdrew after accepting other offer |

## Status Legend

- **Researching**: Gathering company info, analyzing JD
- **Preparing**: Tailoring CV, writing cover letter
- **Applied**: Application submitted
- **Screening**: Recruiter screen scheduled/completed
- **Technical**: Technical interview stage
- **Onsite/Final**: Final round interviews
- **Offer**: Received offer
- **Negotiating**: Negotiating terms
- **Accepted**: Accepted offer
- **Rejected**: Application rejected
- **Withdrawn**: Withdrew application

## Statistics

- **Total Applications**: 7
- **Active**: 5
- **Archived**: 2
- **Response Rate**: 85% (6/7 received response)
- **Interview Rate**: 71% (5/7 reached interview)
- **Offer Rate**: 0% (pending)

## Weekly Goals

- [ ] Complete Databricks application by Friday
- [ ] Prepare for Spotify system design interview
- [ ] Follow up with Airbnb recruiter if no response by Wednesday
- [ ] Research Netflix team structure

## Notes

**Patterns Observed**:
- Strong response rate from companies where I emphasized streaming experience
- "Staff" level applications require more leadership examples
- GCP experience mentioned prominently gets faster responses

**Feedback from Rejections**:
- Stripe: Need more domain expertise, consider payments-adjacent roles
- Consider adding more ML-adjacent projects to portfolio
```

## Usage Patterns

### Adding a New Application

```
@agent-cv-optimizer: Add Google to my tracker - I just applied for
Data Engineer L5 today
```

Result: New row added with today's date, status "Applied"

### Updating Status

```
@agent-cv-optimizer: Update Spotify to Technical Interview stage
```

Result: Status changed, Last Activity updated

### Archiving

When application reaches final outcome (Accepted, Rejected, Withdrawn):
- Move from Active to Archived section
- Add outcome date and notes

## Key Features

1. **Priority levels** (H/M/L) help focus effort
2. **Next Step** column ensures nothing falls through cracks
3. **Statistics** provide motivation and insights
4. **Notes section** captures learnings for future applications
