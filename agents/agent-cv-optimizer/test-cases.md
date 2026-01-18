# Test Cases: agent-cv-optimizer

**Agent**: agent-cv-optimizer
**Version**: 1.0.0
**Last Updated**: 2026-01-18

## Overview

This document contains 12 validation test cases for the `agent-cv-optimizer` agent. These tests verify all three modes (Career Coach, HR Manager, Interviewer), application tracking, and integrations.

## Test Execution Instructions

1. Invoke the agent with the test request
2. Verify the response meets all expected output criteria
3. Check all success criteria boxes
4. Document any failures or unexpected behavior
5. Update this document with results

## Quality Assurance Checklist

Before marking any test as passed:
- [ ] Agent operates in correct mode for request
- [ ] Agent never fabricates experience or skills
- [ ] Agent shows changes before applying
- [ ] Agent creates proper directory structure
- [ ] Agent uses accurate company information (or acknowledges uncertainty)
- [ ] Agent handles errors gracefully

---

## Test Case 1: Career Coach - Experience Mining

### Test Request
```
@agent-cv-optimizer: I've been a software engineer for 4 years working
on backend APIs. I want to transition to data engineering. What
transferable skills should I highlight?
```

### Expected Output Criteria
- [ ] Agent activates Career Coach mode
- [ ] Asks probing questions about current work (data handling, scale, technologies)
- [ ] Identifies transferable skills (SQL, Python, API design, data formats)
- [ ] Suggests how to reframe existing experience
- [ ] Identifies skill gaps for data engineering
- [ ] Provides prioritized learning recommendations

### Success Criteria
Agent extracts relevant transferable skills and provides actionable positioning advice without fabricating experience.

---

## Test Case 2: Career Coach - Blindspot Detection

### Test Request
```
@agent-cv-optimizer: Review my experience and tell me what blindspots
I have for senior data engineer roles. Here's my background: [provide CV summary]
```

### Expected Output Criteria
- [ ] Agent analyzes provided experience
- [ ] Identifies missing skills for senior-level roles
- [ ] Categorizes gaps (technical, soft skills, leadership)
- [ ] Suggests how to address each blindspot
- [ ] Provides honest assessment without discouragement

### Success Criteria
Agent identifies genuine gaps and provides constructive development plan.

---

## Test Case 3: HR Manager - JD Analysis

### Test Request
```
@agent-cv-optimizer: Analyze this job description for keywords and requirements:
[Paste actual Data Engineer JD]
```

### Expected Output Criteria
- [ ] Agent activates HR Manager mode
- [ ] Extracts technical skills (tools, languages, frameworks)
- [ ] Categorizes requirements (required vs. preferred)
- [ ] Identifies ATS keywords
- [ ] Creates `jd-analysis.md` structure
- [ ] Asks for company name to create directory

### Success Criteria
Agent provides comprehensive keyword extraction with clear categorization.

---

## Test Case 4: HR Manager - CV Tailoring

### Test Request
```
@agent-cv-optimizer: Tailor my CV for this Spotify Data Engineer role:
[Paste JD]
```

### Setup
Ensure a base CV YAML file exists in working directory

### Expected Output Criteria
- [ ] Agent detects base CV file
- [ ] Shows current skills/experience vs. JD requirements
- [ ] Suggests specific bullet point modifications
- [ ] Proposes skill section reordering
- [ ] Creates directory structure (`applications/spotify/`)
- [ ] Shows proposed CV changes BEFORE applying
- [ ] Asks for confirmation before saving

### Success Criteria
Agent creates tailored CV that improves JD match while preserving authentic experience.

---

## Test Case 5: HR Manager - Skills Gap Analysis

### Test Request
```
@agent-cv-optimizer: What's my match score for this role and what skills
am I missing? [Paste JD]
```

### Expected Output Criteria
- [ ] Agent calculates match percentage
- [ ] Lists matched skills
- [ ] Lists missing required skills
- [ ] Lists missing preferred skills
- [ ] Provides honest assessment of fit
- [ ] Suggests whether to apply or skill up first

### Success Criteria
Agent provides transparent gap analysis with honest recommendation.

---

## Test Case 6: HR Manager - Cover Letter Generation

### Test Request
```
@agent-cv-optimizer: Write a cover letter for my Airbnb application
```

### Setup
`applications/airbnb/` directory should exist with `jd.md` and tailored CV

### Expected Output Criteria
- [ ] Agent references existing JD and CV
- [ ] Creates targeted cover letter
- [ ] Matches tone to company culture
- [ ] Highlights relevant achievements
- [ ] Saves to `applications/airbnb/cover-letter.md`
- [ ] Does NOT fabricate achievements

### Success Criteria
Cover letter is authentic, targeted, and saved to correct location.

---

## Test Case 7: Interviewer - Company Research

### Test Request
```
@agent-cv-optimizer: Research Databricks for my upcoming interview
```

### Expected Output Criteria
- [ ] Agent activates Interviewer mode
- [ ] Uses web search for company information
- [ ] Finds recent news and developments
- [ ] Identifies company tech stack
- [ ] Researches typical interview process
- [ ] Cites sources for information
- [ ] Acknowledges when information may be outdated

### Success Criteria
Agent provides accurate, sourced company research without fabrication.

---

## Test Case 8: Interviewer - Question Generation

### Test Request
```
@agent-cv-optimizer: Generate interview questions for a Senior Data
Engineer role at Netflix focusing on streaming data
```

### Expected Output Criteria
- [ ] Generates technical questions (system design, coding, data modeling)
- [ ] Generates behavioral questions
- [ ] Questions are relevant to streaming domain
- [ ] Provides answer frameworks/hints
- [ ] Suggests STAR method for behavioral questions
- [ ] Identifies likely deep-dive topics

### Success Criteria
Questions are role-appropriate and include guidance for answering.

---

## Test Case 9: Interviewer - Interview Prep Document

### Test Request
```
@agent-cv-optimizer: Prepare comprehensive interview notes for my
Meta Data Engineer final round next week
```

### Expected Output Criteria
- [ ] Creates `applications/meta/interview-notes.md`
- [ ] Includes company research
- [ ] Lists expected question types
- [ ] Provides answer frameworks
- [ ] Suggests questions to ask interviewer
- [ ] Includes logistics and tips

### Success Criteria
Complete, organized interview preparation document is created.

---

## Test Case 10: Application Tracker - New Entry

### Test Request
```
@agent-cv-optimizer: Add Google to my tracker - I just applied for
Data Engineer L5 today
```

### Expected Output Criteria
- [ ] Creates or updates `applications/tracker.md`
- [ ] Adds Google entry with correct date
- [ ] Sets status to "Applied"
- [ ] Creates `applications/google/` directory if needed
- [ ] Suggests next steps

### Success Criteria
Tracker is updated accurately with new application entry.

---

## Test Case 11: Application Tracker - Status Update

### Test Request
```
@agent-cv-optimizer: Update Spotify to Technical Interview stage -
I have a system design round scheduled for next week
```

### Expected Output Criteria
- [ ] Updates tracker entry for Spotify
- [ ] Changes status to "Technical"
- [ ] Updates last activity date
- [ ] Sets next step with date if provided
- [ ] Offers to create interview prep

### Success Criteria
Tracker reflects accurate status with date tracking.

---

## Test Case 12: Integration - Full Workflow

### Test Request
```
@agent-cv-optimizer: Complete workflow for this Amazon Data Engineer role.
Analyze the JD, tailor my CV, write a cover letter, add to tracker, and
give me interview prep tips.
[Paste JD]
```

### Expected Output Criteria
- [ ] Creates complete directory structure
- [ ] Performs JD analysis
- [ ] Creates tailored CV (with confirmation)
- [ ] Generates cover letter
- [ ] Updates application tracker
- [ ] Provides interview prep overview
- [ ] Asks for confirmation at key steps
- [ ] Offers to invoke research-assistant for deep research

### Success Criteria
Agent orchestrates complete workflow with proper confirmations and file management.

---

## Test Results Log

| Test Case | Date | Tester | Result | Notes |
|-----------|------|--------|--------|-------|
| TC-01 | | | | |
| TC-02 | | | | |
| TC-03 | | | | |
| TC-04 | | | | |
| TC-05 | | | | |
| TC-06 | | | | |
| TC-07 | | | | |
| TC-08 | | | | |
| TC-09 | | | | |
| TC-10 | | | | |
| TC-11 | | | | |
| TC-12 | | | | |

---

## Additional Notes

### Mode Selection
The agent should automatically detect the correct mode:
- JD provided -> HR Manager mode
- Career question -> Career Coach mode
- Interview/company name mentioned -> Interviewer mode
- Tracker update -> Tracking mode

### Edge Cases to Consider
- No base CV file exists
- JD in non-English language
- Company with little public information
- User provides incomplete experience
- Multiple applications to same company
- Status rollback (offer -> rejected)
