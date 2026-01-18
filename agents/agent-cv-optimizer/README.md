# agent-cv-optimizer

**Version**: 1.0.0
**Status**: Production
**Agent Type**: Career Optimization for Data & AI Roles

## Overview

The `agent-cv-optimizer` is a comprehensive career assistant for Data & AI professionals, providing CV tailoring, interview preparation, and application tracking through three specialized modes: Career Coach, HR Manager, and Interviewer.

**Key differentiator**: Combines career coaching wisdom, recruiter perspective, and technical interview expertise in a single agent with organized application tracking.

## When to Use This Agent

### Trigger Conditions

- You want to tailor your CV for a specific Data/AI job posting
- You need career coaching to identify strengths and blindspots
- You're preparing for a technical or behavioral interview
- You want to track multiple job applications systematically
- You need a cover letter for a specific role
- You want skills gap analysis for a target role

### When NOT to Use

- For non-Data/AI roles (use a general career agent)
- For resume design/formatting only (use RenderCV directly)
- For salary negotiation (specialized negotiation needed)
- For contract/legal review (consult professionals)

## Three Operating Modes

### 1. Career Coach Mode

**Purpose**: Strategic career guidance and experience positioning

**Invoke When**:
- Transitioning into Data/AI from another field
- Unsure how to present your experience
- Looking for career direction
- Want to identify skill gaps

**Example**:
```
@agent-cv-optimizer: I've been a backend developer for 5 years
and want to move into data engineering. What should I highlight?
```

### 2. HR Manager Mode

**Purpose**: CV tailoring and ATS optimization

**Invoke When**:
- You have a specific job description
- Need to optimize for ATS screening
- Want keyword analysis and matching
- Need a targeted cover letter

**Example**:
```
@agent-cv-optimizer: Here's a JD for a Senior Data Engineer at
Spotify. Help me tailor my CV and write a cover letter.
```

### 3. Interviewer Mode

**Purpose**: Interview preparation and practice

**Invoke When**:
- You have an upcoming interview
- Want company-specific preparation
- Need practice questions
- Want to understand likely focus areas

**Example**:
```
@agent-cv-optimizer: I have a system design interview at Meta
next week. Help me prepare.
```

## Output Modes

| Mode | When to Use | What You Get |
|------|-------------|--------------|
| Brief | Quick questions | 2-3 key recommendations |
| Standard | Most requests | Full analysis, templates |
| Detailed | Deep preparation | Web research, comprehensive docs |

Request a mode explicitly: "Give me a detailed analysis..." or "Quick advice on..."

## Directory Structure

The agent creates an organized structure for each application:

```
applications/
├── tracker.md                    # Central status tracker
└── spotify/
    ├── jd.md                     # Job description
    ├── jd-analysis.md            # Keyword and requirements analysis
    ├── cv-spotify.yaml           # Tailored RenderCV
    ├── cover-letter.md           # Targeted cover letter
    ├── interview-notes.md        # Prep and post-interview notes
    └── research.md               # Company research
```

## RenderCV Integration

The agent works with RenderCV YAML format:
- Detects base CV files (`*_CV.yaml`) in working directory
- Creates tailored variants for each application
- Preserves RenderCV design settings
- Modifies content sections for JD matching

## Application Tracker

Central file (`applications/tracker.md`) tracks all applications:
- Status progression (Researching -> Applied -> Interview -> Offer)
- Next steps and deadlines
- Priority levels
- Success statistics

## Agent Coordination

Works with other agents in the hub:

| Agent | When Used |
|-------|-----------|
| research-assistant | Deep company research, salary data |
| documentation-specialist | Cover letter polish, formatting |
| agent-git-manager | Version control of application materials |

## Common Commands

```bash
# Career coaching
@agent-cv-optimizer: Review my experience and suggest how to
position myself for ML Engineer roles

# JD analysis and CV tailoring
@agent-cv-optimizer: Analyze this JD and tailor my CV:
[paste JD]

# Interview prep
@agent-cv-optimizer: Prepare me for a technical interview at
{company} for {role}

# Application tracking
@agent-cv-optimizer: Add {company} to my tracker - just applied today

# Skills gap analysis
@agent-cv-optimizer: What skills am I missing for this senior
role? [paste JD]

# Cover letter
@agent-cv-optimizer: Write a cover letter for my {company} application
```

## Quality Standards

The agent adheres to:
- **Accuracy**: Never fabricates company info or skills
- **Authenticity**: Enhances real experience, never invents
- **Transparency**: Shows all changes before applying
- **Honesty**: Flags poor matches rather than forcing fit

## Portability

This agent is fully portable:
- No hardcoded paths
- Works in any project directory
- Creates relative directory structures
- Compatible with any RenderCV setup

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-01-18 | Initial release with three modes, tracking, RenderCV integration |

## Support & Feedback

Report issues to the Agent Architecture Team with:
- Agent ID: `agent-cv-optimizer`
- Your request
- Expected behavior
- Actual behavior
- Mode used (Coach/HR/Interviewer)
