# Brand Voice Template Library

Reference index for `agent-brand-voice`. Use this file to determine which templates to load for each operating mode.

## Template Index

31 templates across 7 directories. Total library: ~121 KB / ~30,300 tokens.

### assessment/ (3 files)

| File | Size | Tokens | Purpose |
|------|-----:|-------:|---------|
| `discovery-questionnaire.md` | 4,067 B | ~1,020 | 11-section guided interview for voice discovery |
| `reconciliation-workflow.md` | 2,298 B | ~575 | Multi-stakeholder alignment process with sign-off tracker |
| `periodic-review-template.md` | 1,961 B | ~490 | Structured periodic voice audit with drift detection |

### channel-rules/ (7 files)

| File | Size | Tokens | Purpose |
|------|-----:|-------:|---------|
| `customer-docs-rules.md` | 5,557 B | ~1,390 | Technical docs, user guides, API docs, knowledge bases |
| `twitter-rules.md` | 5,028 B | ~1,260 | Twitter/X posts and threads, 280-char format |
| `mailings-rules.md` | 4,740 B | ~1,185 | Email newsletters, campaigns, transactional emails |
| `blog-rules.md` | 4,616 B | ~1,155 | Long-form blog posts and thought leadership |
| `youtube-rules.md` | 4,193 B | ~1,050 | Video scripts, descriptions, titles, thumbnails |
| `instagram-rules.md` | 4,070 B | ~1,020 | Feed posts, carousels, Reels, Stories |
| `linkedin-rules.md` | 3,906 B | ~975 | LinkedIn posts, articles, engagement |

### content-templates/ (6 files)

| File | Size | Tokens | Purpose |
|------|-----:|-------:|---------|
| `intent-capture-template.md` | 4,962 B | ~1,240 | **Mandatory first step**: 4-question intent capture before any content |
| `thread-template.md` | 4,902 B | ~1,225 | Twitter/X thread structure (hook, body, synthesis, CTA) |
| `email-template.md` | 4,445 B | ~1,110 | Email structure (subject, preview, body, CTA, footer) |
| `linkedin-post-template.md` | 3,792 B | ~950 | LinkedIn-specific post structures (lesson, story, framework, hot take) |
| `blog-outline-template.md` | 3,640 B | ~910 | Blog post planning (title options, outline, review checklist) |
| `social-post-template.md` | 3,596 B | ~900 | Generic social post structure (hook, body, CTA) with cross-post notes |

### review-checklists/ (3 files)

| File | Size | Tokens | Purpose |
|------|-----:|-------:|---------|
| `vocabulary-scan-checklist.md` | 5,977 B | ~1,495 | 7-step scan: brand terms, preferred words, jargon, inclusive language |
| `tone-verification-checklist.md` | 5,480 B | ~1,370 | 5-step tone audit: target lookup, scoring, dimension deep dive, boundaries |
| `voice-compliance-checklist.md` | 5,139 B | ~1,285 | 12-point voice audit: principles, tone, vocabulary, intent, authenticity |

### style-references/ (3 files)

| File | Size | Tokens | Purpose |
|------|-----:|-------:|---------|
| `reference-analysis-template.md` | 8,222 B | ~2,055 | Analyze external creator styles with ethical boundaries |
| `extraction-checklist.md` | 7,908 B | ~1,975 | What to extract vs. protect when studying creators |
| `inspiration-library-template.md` | 6,590 B | ~1,650 | Structured storage for extracted principles with attribution |

### voice-profile/ (4 files)

| File | Size | Tokens | Purpose |
|------|-----:|-------:|---------|
| `voice-attributes-template.md` | 2,019 B | ~505 | Spectrum-based voice dimensions with drift warnings |
| `vocabulary-guide-template.md` | 1,845 B | ~460 | Preferred/avoided terms, jargon policy, sentence patterns |
| `tone-matrix-template.md` | 1,717 B | ~430 | Tone settings by context, audience, and channel |
| `principles-template.md` | 1,292 B | ~325 | Core voice principles with do/don't examples |

### workflows/ (5 files)

| File | Size | Tokens | Purpose |
|------|-----:|-------:|---------|
| `creator-analysis-workflow.md` | 2,141 B | ~535 | Analyze writing samples, extract style patterns |
| `voice-evolution-workflow.md` | 2,021 B | ~505 | Periodic voice review and profile update process |
| `initial-assessment-workflow.md` | 1,862 B | ~465 | End-to-end new voice discovery process |
| `content-review-workflow.md` | 1,624 B | ~405 | Audit content against voice profile with scoring |
| `content-generation-workflow.md` | 1,477 B | ~370 | Create on-brand content using voice profile |

---

## Loading Guide by Mode

### Assessor Mode

Discover and document a brand's voice.

**Always load:**
| Template | Why |
|----------|-----|
| `workflows/initial-assessment-workflow.md` | Step-by-step process |
| `assessment/discovery-questionnaire.md` | Interview questions |

**Load when building profile (Step 4):**
| Template | Why |
|----------|-----|
| `voice-profile/principles-template.md` | Structure for principles |
| `voice-profile/tone-matrix-template.md` | Structure for tone settings |
| `voice-profile/vocabulary-guide-template.md` | Structure for terminology |
| `voice-profile/voice-attributes-template.md` | Structure for dimensions |

**Total token cost:** ~1,485 (start) + ~1,720 (profile build) = ~3,205

---

### Generator Mode

Create content matching an established voice.

**CRITICAL: Load intent capture FIRST, before any drafting.**

**Step 1 — Always load first:**
| Template | Why |
|----------|-----|
| `content-templates/intent-capture-template.md` | **Mandatory**: 4 questions before any content creation |

**Step 2 — Load after intent is captured:**
| Template | Why |
|----------|-----|
| `workflows/content-generation-workflow.md` | Creation process |
| `.agent/system/brand-voice-profile.md` | Active voice profile (required) |

**Step 3 — Load channel rules for the target channel (one of):**
| Channel | Template |
|---------|----------|
| LinkedIn | `channel-rules/linkedin-rules.md` |
| Blog | `channel-rules/blog-rules.md` |
| Twitter/X | `channel-rules/twitter-rules.md` |
| Instagram | `channel-rules/instagram-rules.md` |
| YouTube | `channel-rules/youtube-rules.md` |
| Email | `channel-rules/mailings-rules.md` |
| Documentation | `channel-rules/customer-docs-rules.md` |

**Step 4 — Load content template for the format (one of):**
| Format | Template |
|--------|----------|
| LinkedIn post | `content-templates/linkedin-post-template.md` |
| Blog post | `content-templates/blog-outline-template.md` |
| Twitter/X thread | `content-templates/thread-template.md` |
| Email/newsletter | `content-templates/email-template.md` |
| Generic social post | `content-templates/social-post-template.md` |

**Total token cost:** ~1,240 (intent) + ~370 (workflow) + ~1,050 (avg channel) + ~1,000 (avg content template) + voice profile = ~3,660 + voice profile

---

### Reviewer Mode

Audit content against the voice profile.

**Always load:**
| Template | Why |
|----------|-----|
| `workflows/content-review-workflow.md` | Scoring rubric and process |
| `.agent/system/brand-voice-profile.md` | Active voice profile (required) |
| `review-checklists/voice-compliance-checklist.md` | 12-point voice audit |

**Load based on review depth:**
| Depth | Additional Templates |
|-------|---------------------|
| Standard | Voice compliance checklist only (loaded above) |
| Detailed | Add `review-checklists/tone-verification-checklist.md` |
| Comprehensive | Add both `tone-verification-checklist.md` and `vocabulary-scan-checklist.md` |

**Optionally load channel rules** for the content's target channel to verify channel fit (checklist item #6).

**Total token cost:** ~405 (workflow) + ~1,285 (compliance) = ~1,690 (standard), up to ~4,555 (comprehensive with all checklists + channel rules) + voice profile

---

### Analyst Mode

Study a creator's writing style from samples.

**Always load:**
| Template | Why |
|----------|-----|
| `workflows/creator-analysis-workflow.md` | Analysis process |
| `style-references/reference-analysis-template.md` | Structured analysis framework |
| `style-references/extraction-checklist.md` | Ethical extraction validation |

**Load when storing results:**
| Template | Why |
|----------|-----|
| `style-references/inspiration-library-template.md` | Store extracted principles with attribution |

**Optionally load (for comparison):**
| Template | Why |
|----------|-----|
| `.agent/system/brand-voice-profile.md` | Compare creator style to brand voice |

**Total token cost:** ~535 + ~2,055 + ~1,975 = ~4,565 (analysis), + ~1,650 (storage) = ~6,215 (full) + voice profile if comparing

---

### Reconciler Mode

Align multiple stakeholders on a unified voice.

**Always load:**
| Template | Why |
|----------|-----|
| `assessment/reconciliation-workflow.md` | 5-phase alignment process |

**Load when building unified profile (Phase 4):**
| Template | Why |
|----------|-----|
| `voice-profile/principles-template.md` | Structure for principles |
| `voice-profile/tone-matrix-template.md` | Structure for tone settings |
| `voice-profile/vocabulary-guide-template.md` | Structure for terminology |
| `voice-profile/voice-attributes-template.md` | Structure for dimensions |

**Total token cost:** ~575 (start) + ~1,720 (profile build) = ~2,295

---

### Voice Evolution (cross-mode)

Periodic review and update of existing voice profile.

**Always load:**
| Template | Why |
|----------|-----|
| `workflows/voice-evolution-workflow.md` | Review process |
| `assessment/periodic-review-template.md` | Audit structure |
| `.agent/system/brand-voice-profile.md` | Current profile to evaluate |

**Load for content audit (Step 2):**
| Template | Why |
|----------|-----|
| `review-checklists/voice-compliance-checklist.md` | Score individual content pieces |

**Total token cost:** ~995 (start) + ~1,285 (audit) = ~2,280 + voice profile

---

## Template Dependency Map

```
Assessor Mode
  └─ initial-assessment-workflow.md
       ├─ discovery-questionnaire.md (Step 2)
       └─ voice-profile/* (Step 4: all 4 templates)
              └─ OUTPUT: .agent/system/brand-voice-profile.md

Generator Mode
  └─ intent-capture-template.md ★ LOAD FIRST ★
       ├─ content-generation-workflow.md
       ├─ INPUT: .agent/system/brand-voice-profile.md
       ├─ channel-rules/{channel}-rules.md (one, based on intent)
       └─ content-templates/{format}-template.md (one, based on intent)

Reviewer Mode
  └─ content-review-workflow.md
       ├─ INPUT: .agent/system/brand-voice-profile.md
       ├─ review-checklists/voice-compliance-checklist.md (always)
       ├─ review-checklists/tone-verification-checklist.md (detailed)
       ├─ review-checklists/vocabulary-scan-checklist.md (comprehensive)
       └─ channel-rules/{channel}-rules.md (optional, for channel fit)

Analyst Mode
  └─ creator-analysis-workflow.md
       ├─ style-references/reference-analysis-template.md
       ├─ style-references/extraction-checklist.md
       ├─ style-references/inspiration-library-template.md (for storing results)
       └─ OPTIONAL INPUT: .agent/system/brand-voice-profile.md

Reconciler Mode
  └─ reconciliation-workflow.md
       └─ voice-profile/* (Phase 4: all 4 templates)
              └─ OUTPUT: .agent/system/brand-voice-profile.md

Voice Evolution
  └─ voice-evolution-workflow.md
       ├─ periodic-review-template.md (Step 2)
       ├─ review-checklists/voice-compliance-checklist.md (content audit)
       ├─ INPUT: .agent/system/brand-voice-profile.md
       └─ OUTPUT: updated .agent/system/brand-voice-profile.md
```

## Token Cost Summary

| Mode | Min Tokens | Max Tokens | Notes |
|------|----------:|----------:|-------|
| Assessor | ~1,485 | ~3,205 | Max when building full profile |
| Generator | ~3,660 | ~3,660 | Plus voice profile; intent + workflow + 1 channel + 1 content template |
| Reviewer | ~1,690 | ~4,555 | Standard vs. comprehensive with all checklists + channel rules |
| Analyst | ~4,565 | ~6,215 | Max when storing to inspiration library |
| Reconciler | ~575 | ~2,295 | Max when building unified profile |
| Voice Evolution | ~995 | ~2,280 | Max when running content audit with checklist |

All modes also load the agent definition (~1,500 tokens) and voice profile when it exists (varies by brand).

## Directory Structure

```
.agent/templates/brand-voice/
├── README.md                              # This file
├── assessment/
│   ├── discovery-questionnaire.md         # 11-section interview
│   ├── reconciliation-workflow.md         # Stakeholder alignment
│   └── periodic-review-template.md        # Voice audit structure
├── channel-rules/
│   ├── blog-rules.md                      # Long-form blog content
│   ├── customer-docs-rules.md             # Technical documentation
│   ├── instagram-rules.md                 # Instagram posts, carousels, Reels
│   ├── linkedin-rules.md                  # LinkedIn posts and articles
│   ├── mailings-rules.md                  # Email newsletters and campaigns
│   ├── twitter-rules.md                   # Twitter/X posts and threads
│   └── youtube-rules.md                   # YouTube videos and descriptions
├── content-templates/
│   ├── intent-capture-template.md         # ★ Mandatory first step for all content
│   ├── blog-outline-template.md           # Blog post planning and structure
│   ├── email-template.md                  # Email structure and formatting
│   ├── linkedin-post-template.md          # LinkedIn-specific post formats
│   ├── social-post-template.md            # Generic social post (cross-platform)
│   └── thread-template.md                 # Twitter/X thread structure
├── review-checklists/
│   ├── voice-compliance-checklist.md      # 12-point voice audit
│   ├── tone-verification-checklist.md     # 4-dimension tone scoring
│   └── vocabulary-scan-checklist.md       # 7-step vocabulary scan
├── style-references/
│   ├── reference-analysis-template.md     # External creator analysis framework
│   ├── extraction-checklist.md            # Ethical extraction validation
│   └── inspiration-library-template.md    # Principle storage with attribution
├── voice-profile/
│   ├── principles-template.md             # Core principles
│   ├── tone-matrix-template.md            # Tone by context/audience/channel
│   ├── vocabulary-guide-template.md       # Preferred/avoided terminology
│   └── voice-attributes-template.md       # Spectrum-based dimensions
└── workflows/
    ├── initial-assessment-workflow.md      # New voice discovery
    ├── content-generation-workflow.md      # On-brand content creation
    ├── content-review-workflow.md          # Content audit with scoring
    ├── creator-analysis-workflow.md        # Writing style extraction
    └── voice-evolution-workflow.md         # Periodic review/update
```
