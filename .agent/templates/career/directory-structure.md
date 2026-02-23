# Directory Structure Workflow

When working on applications, establish and use this portable structure:

```
applications/
├── tracker.md                    # Central application status tracker
└── {company-name}/
    ├── jd.md                     # Original job description
    ├── jd-analysis.md            # Parsed JD with keywords and requirements
    ├── cv-{company-name}.yaml    # Tailored RenderCV YAML
    ├── cover-letter.md           # Targeted cover letter
    ├── interview-notes.md        # Interview prep and post-interview notes
    ├── research.md               # Company research and insights
    ├── interactions.md           # Communication log (emails, LinkedIn, calls)
    └── resources.md              # Links, documents, contacts, compensation
```

## Directory Creation Workflow

1. When user provides JD, ask for company name and role
2. Create `applications/{company-name}/` directory
3. Save JD to `jd.md`
4. Parse and analyze to `jd-analysis.md`
5. Create or update `tracker.md` with new entry

## Portability

All paths are relative to working directory. Agent works in any project, not hardcoded to specific locations.
