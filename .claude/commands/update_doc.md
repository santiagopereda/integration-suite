# Documentation Update Command

**Purpose**: Guide for agents on how to create and update documentation within the centralized knowledge base.

---

## Quick Reference

This guide helps agents understand:
- Where documentation lives (`.agent/` knowledge base)
- How to initialize documentation for the first time
- How to update existing documentation
- Best practices for consolidation and avoiding duplication

**Related Documentation**: See [CLAUDE.md - Knowledge Base & Agent Context](../CLAUDE.md#knowledge-base--agent-context) for the overall structure.

---

## Knowledge Base Structure

The project maintains a centralized knowledge base at `.agent/` with three main sections:

```
.agent/
├── README.md                    ← Overview & navigation
├── injection-history.md         ← Audit trail of additions
├── tasks/                       ← PRDs & Implementation Plans
│   └── README.md               ← How to create PRDs
├── system/                      ← Schemas, APIs, Integrations
│   └── README.md               ← How to document systems
└── sops/                        ← Standard Operating Procedures
    ├── README.md               ← How to create SOPs
    └── templates/
        └── sop-template.md     ← Ready-to-use template
```

**Key Principle**: Each section's README.md is the source of truth for understanding what belongs there and how to contribute.

---

## First-Time Documentation Initialization

When creating new documentation for the first time, follow this workflow:

### Step 1: Read Existing Documentation

Before creating anything new:
- [ ] Read `.agent/README.md` to understand the overall structure
- [ ] Read the relevant section's README.md:
  - For tasks: `.agent/tasks/README.md`
  - For system docs: `.agent/system/README.md`
  - For procedures: `.agent/sops/README.md`
- [ ] Browse what already exists in that section
- [ ] Check `.agent/injection-history.md` for what's been added recently

### Step 2: Determine the Right Location

Ask yourself:
- **Is this a requirement or feature plan?** → `.agent/tasks/`
- **Is this a schema, API, integration, or system info?** → `.agent/system/`
- **Is this a repeatable procedure or best practice?** → `.agent/sops/`

### Step 3: Check for Consolidation Opportunities

Before creating a new file:
- [ ] Look for related documentation that already exists
- [ ] Check if you should consolidate with existing content instead of creating new files
- [ ] Identify overlapping information that should be merged
- [ ] Find documentation that should be linked rather than duplicated

**Example**: If documenting an API, check if schemas it uses are already documented, and link to them rather than replicating information.

### Step 4: Create or Update Documentation

- Use appropriate format (Markdown)
- Reference existing files where applicable
- Include cross-references at the end
- Use clear hierarchy and structure

### Step 5: Update Injection History

Add an entry to `.agent/injection-history.md` following the template:

```markdown
### 2025-MM-DD - [Type]: [Title]
- **Added By**: [Your Name/Agent ID]
- **Location**: `.agent/[section]/[document].md`
- **Purpose**: [Brief description of why this was added]
- **Links**: [References to related documents]
- **Status**: Complete
```

---

## Updating Existing Documentation

When asked to update or improve documentation:

### Step 1: Read Current Documentation

- [ ] Read the document you're updating
- [ ] Check the related README.md for context
- [ ] Review cross-references to understand relationships
- [ ] Look at `.agent/injection-history.md` for recent changes

### Step 2: Identify What Needs Updating

- [ ] Outdated information
- [ ] Missing details or examples
- [ ] Broken or stale cross-references
- [ ] Overlapping content that should be consolidated

### Step 3: Make Consolidation Decisions

**Consolidate When**:
- Same information appears in multiple documents
- Content is better served as a single source of truth
- Related concepts are artificially separated

**Link Instead of Duplicate When**:
- Information is comprehensive in one place
- Document would benefit from reference context
- Maintaining multiple copies creates maintenance burden

**Keep Separate When**:
- Information serves different audiences
- Different levels of detail are appropriate
- Context requires independent explanation

### Step 4: Update the Documentation

- Make changes to reflect reality (not enforce formats)
- Update cross-references
- Ensure links are accurate
- Maintain consistent formatting with the existing doc

### Step 5: Update Injection History

Add or update the entry in `.agent/injection-history.md`:

```markdown
### 2025-MM-DD - Update: [Document Name]
- **Modified By**: [Your Name/Agent ID]
- **Location**: `.agent/[section]/[document].md`
- **Changes**: [List what was updated and why]
- **Consolidation**: [Any files merged or content moved]
- **Status**: Complete
```

---

## Core Principles

### 1. Documentation Reflects Reality

- Document what actually exists, not what "should" exist
- Avoid imposing format standards unless explicitly requested
- Represent the project as it is now
- Update documentation when reality changes

### 2. Consolidate to Avoid Duplication

- One source of truth per concept
- Link to information rather than replicate
- Merge overlapping documentation
- Use cross-references for relationships

### 3. README.md is Source of Truth

Each section has a README.md that explains:
- What belongs in that section
- How to structure new documents
- What cross-references are needed
- Best practices for that type of documentation

Always consult the section's README.md before creating new documentation.

### 4. Cross-Reference Everything

- Link to related documents
- Include "see also" sections
- Maintain bidirectional references
- Update references when documents change

### 5. Simple Over Perfect

- Clear and practical documentation beats comprehensive formatting
- Focus on what readers need to know
- Include examples
- Link to detailed information elsewhere

---

## Common Scenarios

### Scenario 1: Adding New API Documentation

**What to do**:
1. Read `.agent/system/README.md` to understand API docs structure
2. Check if any related schemas are already documented
3. Create `api-name.md` in `.agent/system/apis/`
4. Include: overview, endpoints, authentication, examples, error handling
5. Link to related schemas in `.agent/system/schemas/`
6. Update `.agent/injection-history.md`

**Example cross-reference**:
```markdown
## Related Schemas
- [BusinessPartner Schema](../schemas/businesspartner.md)
- [Address Schema](../schemas/address.md)
```

### Scenario 2: Documenting a Data Schema

**What to do**:
1. Read `.agent/system/README.md` for schema structure
2. Check if any APIs use this schema
3. Create `entity-name.md` in `.agent/system/schemas/`
4. Include: overview, fields, relationships, validation rules, examples
5. Link to APIs that use this schema
6. Link from system integration docs if applicable
7. Update `.agent/injection-history.md`

### Scenario 3: Creating SOP from Completed Work

**What to do**:
1. Read `.agent/sops/README.md` and the template
2. Use `.agent/sops/templates/sop-template.md` as starting point
3. Copy template to `.agent/sops/[category]/[process-name].md`
4. Fill in all sections with specific details
5. Include common mistakes learned
6. Add validation checklist
7. Link to related system docs
8. Update `.agent/injection-history.md`

### Scenario 4: Consolidating Overlapping Documentation

**What to do**:
1. Identify all documents with overlapping content
2. Decide which should be the primary reference
3. Update primary document with comprehensive information
4. Replace duplicate sections with links to primary document
5. Update all cross-references
6. Update `.agent/injection-history.md` to note consolidation
7. Document what was consolidated and why

**Example entry**:
```markdown
### 2025-MM-DD - Consolidation: API Authentication
- **Modified By**: documentation-specialist
- **Location**: `.agent/system/apis/authentication.md` (primary)
- **Changes**: Consolidated duplicate auth docs from multiple API files
- **Consolidated Files**:
  - Removed from sap-businesspartner-api.md (now links)
  - Removed from agiloft-api.md (now links)
- **Status**: Complete
```

### Scenario 5: Fixing Outdated References

**What to do**:
1. Identify all documents referencing the outdated information
2. Update the source document with current information
3. Fix all links and references
4. Verify links work
5. Update `.agent/injection-history.md` to note the fix

---

## Workflow Checklist

Use this checklist when creating or updating documentation:

**Before You Start**:
- [ ] Read the relevant section's README.md
- [ ] Check what already exists in that section
- [ ] Review `.agent/injection-history.md` for recent additions
- [ ] Look for consolidation opportunities

**During Creation/Update**:
- [ ] Follow the structure documented in section README.md
- [ ] Include practical examples
- [ ] Add clear cross-references
- [ ] Link to related documents
- [ ] Verify all references are accurate
- [ ] Check for duplicate information

**After Completion**:
- [ ] Read your documentation as if you're new to it
- [ ] Verify all links work
- [ ] Check cross-references are bidirectional
- [ ] Update `.agent/injection-history.md`
- [ ] Ensure no overlapping documentation exists
- [ ] Confirm documentation reflects current reality

---

## Consolidation Examples

### Example 1: API Documentation Consolidation

**Before**:
```
.agent/system/apis/
├── sap-businesspartner-api.md
│   ├── Overview
│   ├── Authentication (detailed)
│   ├── Endpoints
│   └── Error Handling
└── agiloft-api.md
    ├── Overview
    ├── Authentication (similar to SAP) ← DUPLICATE
    ├── Endpoints
    └── Error Handling
```

**After**:
```
.agent/system/apis/
├── authentication.md              ← PRIMARY: consolidated auth
├── sap-businesspartner-api.md
│   ├── Overview
│   ├── Authentication → [link to authentication.md]
│   ├── Endpoints
│   └── Error Handling
└── agiloft-api.md
    ├── Overview
    ├── Authentication → [link to authentication.md]
    ├── Endpoints
    └── Error Handling
```

### Example 2: Schema Documentation Link

**Instead of duplicating**:
```markdown
## Address Schema
Field | Type | Required
address | string | yes
city | string | yes
country | string | yes
postal_code | string | yes
```

**Reference existing documentation**:
```markdown
## Related Schemas
- [Address Schema Details](.../schemas/address.md)

See the Address Schema documentation for complete field specifications,
validation rules, and examples.
```

---

## Important Reminders

1. **Don't Enforce Formats**: Document reality as it exists, not a hypothetical ideal structure
2. **Avoid Duplication**: Consolidate when multiple files contain the same information
3. **Link Generously**: Use cross-references to connect related information
4. **Keep README.md Current**: Section README files should reflect what actually exists
5. **Update History**: Always log changes in `.agent/injection-history.md`
6. **Verify Links**: Make sure all references point to actual documents
7. **Be Practical**: Focus on what readers need, not perfect organization

---

## Quick Links

- **Knowledge Base Home**: `.agent/README.md`
- **Tasks Guide**: `.agent/tasks/README.md`
- **System Guide**: `.agent/system/README.md`
- **SOPs Guide**: `.agent/sops/README.md`
- **SOP Template**: `.agent/sops/templates/sop-template.md`
- **Injection History**: `.agent/injection-history.md`
- **Main Configuration**: `CLAUDE.md` (Knowledge Base section)

---

## Post-Update: Commit Workflow

After completing documentation updates, invoke `@agent-git-manager` to commit changes safely.

### Automatic Workflow

When `/update_doc` completes, the following workflow is recommended:

1. **Documentation changes are ready** - Files in `.agent/` have been created/updated
2. **Invoke git manager** - Run `@agent-git-manager` or simply ask to commit
3. **Security scan runs** - Agent scans documentation for any sensitive content
4. **Commit message generated** - Agent creates appropriate `docs:` commit message
5. **User confirms** - Commit executes only after explicit confirmation

### Example

After completing documentation updates:

```
User: I just finished running /update_doc

Agent (git-manager):
Documentation updated. Let me help you commit these changes.

[Runs security scan on .agent/ files]

Security Scan Results:
- Files scanned: 3
- Patterns checked: 15
- Warnings: 0
- Blocks: 0

Suggested commit message:
docs: update knowledge base documentation

- Update/create documentation in .agent/
- Update injection-history.md with changes

Shall I proceed with this commit? [Y/n]
```

### Why This Integration Matters

1. **Security**: Documentation files are scanned before commit
2. **Consistency**: Proper conventional commit messages for docs
3. **Audit trail**: injection-history.md changes are included
4. **Workflow**: Seamless transition from documentation to version control

### Related Agent

See `@agent-git-manager` for:
- Pre-commit security scanning
- Conventional commit message generation
- SSH/GitHub integration
- Push workflow with confirmation

---

**Version**: 1.1.0
**Created**: 2025-11-21
**Updated**: 2025-01-18
**Purpose**: Guide agents on documentation creation and updates
**Status**: Active
