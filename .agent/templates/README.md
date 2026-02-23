# Agent Templates - Externalized Content

This directory contains templates and static content externalized from agent system prompts to reduce token usage and improve maintainability.

## Purpose

Agent system prompts are loaded on every invocation. By externalizing large static content (templates, examples, checklists) to separate files, we achieve:

- **Token Reduction**: 50-70% reduction in agent prompt size
- **Cost Savings**: ~10,000-11,000 tokens saved per agent invocation
- **Maintainability**: Templates can be updated without changing agent definitions
- **Reusability**: Templates can be shared across multiple agents

## How It Works

### Lazy Loading Pattern

Agents reference templates in their system prompts but don't embed the content. Templates are loaded on-demand using the Read tool only when needed.

**Example**:
```markdown
## Templates Available

Load on-demand using Read tool:
- `.agent/templates/sap/bp-integration-doc.md` - Documentation structure
- `.agent/templates/sap/bp-quality-checklist.md` - Quality validation

**When to Load**:
1. User requests documentation → Load doc template
2. Before delivery → Load quality checklist
```

### Token Economics

**Without Externalization**:
- Agent prompt: ~15,000-16,000 tokens
- Template content: Embedded in every invocation
- Total cost per invocation: ~15,000-16,000 tokens

**With Externalization**:
- Agent prompt: ~5,000-5,300 tokens (67% smaller)
- Template loading cost: ~300-500 tokens per template (when needed)
- Net savings: ~10,000-11,000 tokens per invocation
- ROI: Templates need to be used 30+ times to break even (happens quickly)

## Directory Structure

```
templates/
├── README.md                      ← This file
├── sap/                           ← SAP-specific templates
│   ├── bp-integration-doc.md      ← BusinessPartner documentation template
│   ├── bp-quality-checklist.md    ← Quality validation checklist
│   └── sap-agiloft-context.md     ← Project-specific context (conditional)
├── ansible/                       ← Ansible-specific templates
│   ├── playbook-doc.md            ← Playbook documentation template
│   ├── best-practices.md          ← Ansible best practices guide
│   └── quality-checklist.md       ← Quality assurance checklist
├── cv-optimizer/                  ← CV/Career optimization templates (NEW)
│   ├── tracker-template.md        ← Application tracking format
│   ├── workflow-examples.md       ← Mode-specific workflow examples
│   ├── interactions-template.md   ← Agent coordination patterns
│   └── resources-template.md      ← Career resource links
├── project-init/                  ← Project initialization templates (NEW)
│   ├── folder-structures.md       ← Project type folder structures
│   ├── claude-md-template.md      ← CLAUDE.md template for projects
│   ├── readme-md-template.md      ← README.md template for projects
│   ├── injection-history-template.md ← injection-history.md template
│   └── agent-readme-template.md   ← Agent README template
├── provisioner/                   ← Agent provisioning templates
│   ├── sync-workflow.md           ← Hub-to-target sync workflow
│   ├── sync-back-workflow.md      ← Target-to-hub reverse sync
│   ├── registry-templates.md      ← CLAUDE.md/AGENTS_REGISTRY templates
│   ├── hook-merge-logic.md        ← Hook merging rules
│   └── workflow-examples.md       ← Complete workflow examples
├── integration/                   ← Integration analyst framework templates
│   ├── scoring-rubric.md          ← 8 dimensions x 5 maturity levels
│   ├── assessment-questionnaire.md ← Guided interview questions
│   ├── assessment-document.md     ← Assessment output format
│   ├── scorecard-template.md      ← Scorecard output + radar chart JSON
│   ├── design-document.md         ← Architecture design template
│   ├── improvement-roadmap.md     ← Phased improvement plan template
│   ├── pattern-library.md         ← Integration patterns catalog (7 patterns)
│   ├── design-quality-checklist.md ← Pre-delivery design validation
│   ├── review-checklist.md        ← Structured review framework
│   ├── security-review-checklist.md ← OWASP API Top 10 + security
│   ├── review-report-template.md  ← Review output format
│   ├── anti-patterns.md           ← Anti-pattern library + remediation
│   ├── inventory-document.md      ← Code analysis inventory format
│   ├── extraction-guide.md        ← Universal extraction checklist
│   ├── industry-benchmarks.md     ← Benchmarks by sector/complexity
│   ├── red-flags-library.md       ← Common red flags + remediation
│   ├── customer-summary-template.md ← Customer-facing report format
│   └── platform-parsers/          ← Platform-specific parsing guides
│       ├── workato.md             ← Workato JSON recipe parsing
│       └── talend.md              ← Talend XML/Java job parsing
└── shared/                        ← Cross-agent templates
    ├── output-structure.md        ← General output formatting
    └── markdown-formatting.md     ← Markdown best practices
```

## Template Categories

### 1. Documentation Templates

**Purpose**: Standardized documentation structures

**Examples**:
- `sap/bp-integration-doc.md` - BusinessPartner integration guide structure
- `ansible/playbook-doc.md` - Ansible playbook documentation template

**Usage**: Agents load when user requests documentation creation

### 2. Code/Configuration Patterns

**Purpose**: Reusable code examples and configuration patterns

**Examples**:
- `ansible/task-pattern.yml` - Idempotent task examples
- `ansible/vars-pattern.yml` - Variable organization patterns
- `ansible/jinja2-pattern.j2` - Template syntax examples

**Usage**: Agents load when generating code or configuration

### 3. Quality Checklists

**Purpose**: Validation criteria and quality gates

**Examples**:
- `sap/bp-quality-checklist.md` - SAP BP documentation validation
- `ansible/quality-checklist.md` - Ansible code quality criteria

**Usage**: Agents load before delivering output for final validation

### 4. Context Documents

**Purpose**: Project-specific or conditional context

**Examples**:
- `sap/sap-agiloft-context.md` - SAP-Agiloft integration context

**Usage**: Loaded conditionally when specific keywords detected

### 5. Evaluation Frameworks

**Purpose**: Structured assessment, scoring, and review frameworks

**Examples**:
- `integration/scoring-rubric.md` - 8-dimension x 5-level maturity scoring
- `integration/assessment-questionnaire.md` - Guided interview for discovery
- `integration/review-checklist.md` - Design validation framework
- `integration/security-review-checklist.md` - OWASP API Top 10 security review

**Usage**: Integration agents load during assessment, scoring, design, and review phases

### 6. Platform Parsers

**Purpose**: Platform-specific code parsing instructions for workspace export analysis

**Examples**:
- `integration/platform-parsers/workato.md` - Workato JSON recipe structure and extraction
- `integration/platform-parsers/talend.md` - Talend XML/Java job structure and extraction

**Usage**: Analyzer agent loads when parsing code exports from specific platforms

## Using Templates in Agents

### In Agent System Prompts

Reference templates without embedding content:

```markdown
## Responsibilities

When creating BusinessPartner documentation:
1. Clarify scope with user
2. Load template: `.agent/templates/sap/bp-integration-doc.md`
3. Populate template with specific procedures
4. Quality check: `.agent/templates/sap/bp-quality-checklist.md`
```

### Loading Templates

Agents use the Read tool to load templates on-demand:

```markdown
When user requests: "Document BusinessPartner creation flow"

Agent workflow:
1. Use Read tool: `.agent/templates/sap/bp-integration-doc.md`
2. Fill template sections with specific SAP procedures
3. Use Read tool: `.agent/templates/sap/bp-quality-checklist.md`
4. Validate output against checklist
5. Deliver documentation
```

### Conditional Loading

Load templates only when needed:

```markdown
## Template Loading Logic

**Always Load**:
- Documentation template (when creating docs)
- Quality checklist (before delivery)

**Conditional Load**:
- Context files (only when keywords mentioned):
  - "SAP-Agiloft" → Load `.agent/system/sap-agiloft/context.md`
  - "AWS" in Ansible → Load `ansible/cloud-patterns.yml`
```

## Template Best Practices

### Writing Templates

✅ **Do**:
- Include clear section headers
- Provide guidance for each section
- Use placeholders for variable content
- Include examples where helpful
- Keep content focused and concise
- Add token budget annotations (Brief/Standard/Detailed modes)

❌ **Don't**:
- Embed agent-specific logic
- Include dynamic content that changes frequently
- Duplicate content across templates
- Make templates agent-dependent

### Token Budget Annotations

Templates should include guidance for different output modes:

```markdown
# Template Title

<!-- Token Budget Guidelines:
- Brief Mode: Use only relevant sections (500-800 tokens)
- Standard Mode: All sections, concise (1,500-3,000 tokens)
- Detailed Mode: All sections, comprehensive (3,000-6,000 tokens)
-->

## Section 1
<!-- Brief: 100-150 tokens | Standard: 200-300 tokens | Detailed: 400-600 tokens -->
[Content guidance]
```

### Maintaining Templates

**When to Update**:
- Standards change (SAP API updates, Ansible best practices)
- User feedback indicates improvement needed
- New patterns emerge from agent usage
- Errors or inaccuracies discovered

**Version Control**:
- Document changes in `.agent/metrics/optimization-log.md`
- Test agents after template updates
- Notify relevant teams of significant changes

## Performance Metrics

### Baseline (Before Externalization)

**SAP BusinessPartner Agent**:
- Prompt size: 2,249 words / ~15,000 tokens
- Embedded content: 1,220 words (templates, checklists, context)

**Ansible Automation Agent**:
- Prompt size: 2,433 words / ~16,000 tokens
- Embedded content: 1,690 words (templates, patterns, checklists)

### Target (After Externalization)

**SAP BusinessPartner Agent**:
- Prompt size: ~750 words / ~5,000 tokens (67% reduction)
- Template loading: ~500-800 tokens (when needed)
- Net savings: ~9,500-10,000 tokens per invocation

**Ansible Automation Agent**:
- Prompt size: ~800 words / ~5,300 tokens (67% reduction)
- Template loading: ~500-800 tokens (when needed)
- Net savings: ~10,500-11,000 tokens per invocation

### ROI Calculation

**Monthly Usage** (estimated 100 invocations per agent):
- SAP BP: 10,000 tokens × 100 = 1,000,000 tokens saved/month
- Ansible: 11,000 tokens × 100 = 1,100,000 tokens saved/month
- **Total**: ~2.1M tokens saved/month

**Break-Even Analysis**:
- Template loading overhead: ~500 tokens per invocation
- Savings per invocation: ~10,000 tokens
- Break-even: 1 invocation (immediate ROI)

## Creating New Templates

### 1. Identify Externalizable Content

Look for:
- Static documentation structures
- Reusable code patterns
- Quality checklists
- Reference materials
- Examples and samples

### 2. Extract to Appropriate Directory

```bash
# SAP-specific → templates/sap/
# Ansible-specific → templates/ansible/
# Cross-agent → templates/shared/
```

### 3. Update Agent System Prompt

Replace embedded content with template reference:

**Before**:
```markdown
Use this documentation structure:
[300 lines of template embedded]
```

**After**:
```markdown
Load template from: `.agent/templates/sap/bp-integration-doc.md`
```

### 4. Test Template Loading

Verify agent can load and use template correctly:
- Agent invokes Read tool successfully
- Template content integrates properly
- Output quality maintained
- Token savings achieved

### 5. Document in Optimization Log

Record externalization in `.agent/metrics/optimization-log.md`:
```markdown
### 2025-11-28: SAP BP Template Externalization
- Extracted bp-integration-doc.md (400 words)
- Extracted bp-quality-checklist.md (120 words)
- Reduced agent prompt: 2,249 → 750 words (67%)
- Token savings: ~10,000 per invocation
```

## Troubleshooting

### Template Not Loading

**Symptoms**: Agent cannot find or read template

**Solutions**:
- Verify file path is correct and absolute
- Check file permissions (should be readable)
- Ensure template exists at specified location
- Review agent system prompt for correct path

### Output Quality Degraded

**Symptoms**: Agent outputs lower quality after externalization

**Solutions**:
- Verify template content is complete
- Check agent system prompt references templates correctly
- Ensure agent knows when to load templates
- Test with original embedded version for comparison

### Token Savings Not Realized

**Symptoms**: Token usage still high after externalization

**Solutions**:
- Verify agent prompt was actually reduced
- Check agent isn't loading templates unnecessarily
- Ensure templates aren't too large themselves
- Review baseline metrics for accuracy

## Related Documentation

- **Optimization Log**: `.agent/metrics/optimization-log.md` - Track all changes
- **Baseline Metrics**: `.agent/metrics/token-usage-baseline.json` - Original measurements
- **Agent Definitions**: `.claude/agents/` - Refactored agent prompts
- **Performance Guide**: `.agent/system/tools/optimization-guide.md` - Best practices

---

**Created**: 2025-11-28
**Updated**: 2026-02-14
**Version**: 1.2.0
**Maintained By**: Agent Architecture Team
