# Inspiration Library Template

Structured storage for analyzed creator references and extracted principles. This library enables brands to maintain an ethical, attributed collection of voice techniques learned from external creators.

## Library Metadata

| Field | Value |
|-------|-------|
| **Brand/Project** | [Name of the brand this library serves] |
| **Created** | [YYYY-MM-DD] |
| **Last Updated** | [YYYY-MM-DD] |
| **Total Entries** | [Number] |
| **Total Principles Extracted** | [Number] |

---

## Library Structure

The inspiration library is organized as a collection of entries. Each entry represents one analyzed creator or content source, containing attribution, analysis metadata, and extracted principles.

```
inspiration-library/
  entry-001-[creator-slug].md
  entry-002-[creator-slug].md
  ...
  principles-index.md          # Cross-reference of all principles by category
```

---

## Entry Format

### Entry Header

| Field | Value |
|-------|-------|
| **Entry ID** | [LIB-NNN] |
| **Creator** | [Full name or recognized handle] |
| **Platform** | [Primary platform where content was analyzed] |
| **Creator URL** | [Link to creator's public profile or publication] |
| **Content Type Analyzed** | [Blog / Newsletter / Social / Video script / etc.] |
| **Samples Analyzed** | [Number] |
| **Analysis Date** | [YYYY-MM-DD] |
| **Analyst** | [Who performed the analysis] |
| **Full Analysis** | [Link to completed reference-analysis-template.md, if stored] |

### Creator Context

Brief, factual description of the creator for future reference. This is context, not endorsement.

> **Who**: [1-2 sentences: what the creator is known for, their domain, audience size if relevant]
>
> **Why analyzed**: [1 sentence: what prompted the analysis — e.g., "Client admires their newsletter tone", "Studied for B2B SaaS voice benchmarking"]

### Extracted Principles

List all principles extracted from this creator. Each principle must be abstracted (no direct content).

#### Principle 1: [Name]

| Field | Value |
|-------|-------|
| **Category** | [Tone / Structure / Engagement / Storytelling / Vocabulary] |
| **Description** | [1-2 sentence description of the reusable technique] |
| **Observed Pattern** | [What the creator does, described generically] |
| **Application Guidance** | [How a brand could adapt this technique] |
| **Best For** | [Content types or contexts] |
| **Caution** | [When to avoid or adapt] |
| **Ethical Status** | [Validated — confirms no direct copying] |

#### Principle 2: [Name]

| Field | Value |
|-------|-------|
| **Category** | |
| **Description** | |
| **Observed Pattern** | |
| **Application Guidance** | |
| **Best For** | |
| **Caution** | |
| **Ethical Status** | |

*(Add additional principles as needed. Typical range: 3-8 per entry.)*

### Adaptation Notes

Guidance for applying this creator's principles to a specific brand:

| Brand Voice Attribute | Creator's Position | Adaptation Required |
|-----------------------|-------------------|-------------------|
| [e.g., Formality] | [e.g., Very casual (1/5)] | [e.g., Increase formality to match brand target of 3/5 while keeping the conversational rhythm] |
| [e.g., Authority] | [e.g., Commanding (5/5)] | [e.g., Soften to collaborative tone; use "we" instead of imperative] |

**Key adaptation summary**: [1-2 sentences on the primary adjustments needed to use these principles within the brand's voice without sounding like a copy of the source creator]

### Use Cases

Specific scenarios where this entry's principles are most valuable:

- [ ] [Content type + situation, e.g., "Blog posts introducing complex technical topics"]
- [ ] [Content type + situation, e.g., "Email newsletters aiming for higher open-to-read ratio"]
- [ ] [Content type + situation]

---

## Principles Cross-Reference Index

Maintain this index across all library entries to enable lookup by category or technique.

### By Category

#### Tone Principles

| ID | Principle Name | Source Creator | Entry |
|----|---------------|----------------|-------|
| T-001 | [Name] | [Creator] | [LIB-NNN] |
| T-002 | [Name] | [Creator] | [LIB-NNN] |

#### Structure Principles

| ID | Principle Name | Source Creator | Entry |
|----|---------------|----------------|-------|
| S-001 | [Name] | [Creator] | [LIB-NNN] |

#### Engagement Principles

| ID | Principle Name | Source Creator | Entry |
|----|---------------|----------------|-------|
| E-001 | [Name] | [Creator] | [LIB-NNN] |

#### Storytelling Principles

| ID | Principle Name | Source Creator | Entry |
|----|---------------|----------------|-------|
| ST-001 | [Name] | [Creator] | [LIB-NNN] |

#### Vocabulary Principles

| ID | Principle Name | Source Creator | Entry |
|----|---------------|----------------|-------|
| V-001 | [Name] | [Creator] | [LIB-NNN] |

### By Use Case

| Use Case | Relevant Principles |
|----------|-------------------|
| Blog posts | [T-001, S-003, E-002, ...] |
| Newsletters | [T-002, E-001, ST-001, ...] |
| Social media | [T-003, S-001, E-004, ...] |
| Long-form content | [S-002, ST-002, V-001, ...] |
| Technical documentation | [T-001, S-004, V-002, ...] |

---

## Library Maintenance

### Adding New Entries

1. Complete a `reference-analysis-template.md` for the creator
2. Run the extraction checklist (`extraction-checklist.md`) to validate ethical compliance
3. Create a new entry using the format above
4. Assign the next sequential Entry ID (LIB-NNN)
5. Add extracted principles to the cross-reference index
6. Update library metadata (total entries, total principles, last updated)

### Reviewing Existing Entries

| Schedule | Action |
|----------|--------|
| Per use | Verify the principle still applies to current brand voice targets |
| Quarterly | Review all entries for relevance; archive outdated entries |
| On voice profile change | Re-evaluate adaptation notes against new voice targets |

### Archiving Entries

When an entry is no longer relevant:
- Move to an `archived/` subdirectory
- Remove principles from the active cross-reference index
- Retain for audit trail (never delete — attribution must remain traceable)

---

## Integration with Agent Modes

| Mode | How Library Is Used |
|------|-------------------|
| **Analyst** | Creates new entries after analyzing creator samples |
| **Generator** | Consults principles index when applying specific techniques |
| **Reviewer** | Cross-references content against principles to check for over-reliance on any single source |
| **Assessor** | References library during voice discovery to suggest technique examples |
