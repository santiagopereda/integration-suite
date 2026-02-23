# Reference Analysis Template

Framework for analyzing external creators' styles to extract reusable voice principles. This template supports the Analyst mode of agent-brand-voice.

## Ethical Foundation

> **Core Principle**: We analyze creators to learn *techniques and patterns*, never to replicate their unique voice or content. Every analysis must result in abstracted principles that could apply to any brand, not a copy of the source.

### Ethical Boundaries

| Permitted | Prohibited |
|-----------|------------|
| Extracting structural patterns (e.g., "uses short punchy paragraphs") | Copying distinctive phrases or signature expressions |
| Noting tone characteristics (e.g., "conversational authority") | Reproducing unique metaphors or coined terminology |
| Identifying engagement techniques (e.g., "opens with a provocative question") | Claiming original ideas or frameworks as your own |
| Documenting storytelling arc structures | Lifting specific examples, anecdotes, or stories |
| Observing vocabulary register and complexity level | Compiling a "write exactly like X" imitation guide |

### Attribution Requirements

- Every analyzed reference must credit the original creator by name
- Include the source URL or publication where the content was found
- Record the analysis date to establish temporal context
- Note the content type and context (blog, newsletter, social, etc.)
- If principles are later used in generated content, the inspiration library entry must be traceable

---

## Analysis Metadata

| Field | Value |
|-------|-------|
| **Creator Name** | [Full name or known handle] |
| **Platform/Channel** | [Where the content was published] |
| **Content Type** | [Blog / Newsletter / Social / Video script / Other] |
| **Samples Analyzed** | [Number of pieces reviewed, minimum 3] |
| **Sample Date Range** | [Earliest] to [Latest] |
| **Analysis Date** | [YYYY-MM-DD] |
| **Analyst** | [Who performed this analysis] |

---

## What to Analyze

### 1. Tone Characteristics

Evaluate the creator's tone across these dimensions (1-5 scale):

| Dimension | Score (1-5) | Evidence |
|-----------|:-----------:|----------|
| **Formality** (casual ↔ formal) | | [Quote pattern, not exact quote] |
| **Energy** (measured ↔ intense) | | |
| **Warmth** (detached ↔ intimate) | | |
| **Authority** (tentative ↔ commanding) | | |
| **Humor** (serious ↔ playful) | | |

**Tone Summary** (2-3 sentences describing the overall tonal quality):

> [Write a description of the tone *in your own words*, not quoting the creator]

### 2. Structural Patterns

| Element | Observation |
|---------|-------------|
| **Average sentence length** | [Short / Medium / Long / Mixed] |
| **Paragraph length** | [1-2 sentences / 3-4 / 5+ / Varies] |
| **Opening pattern** | [How pieces typically begin: question, statement, story, statistic, etc.] |
| **Closing pattern** | [How pieces typically end: CTA, summary, open question, callback, etc.] |
| **Section structure** | [How the body is organized: chronological, problem-solution, listicle, etc.] |
| **Heading style** | [Frequency, tone of headings, question-based, statement-based] |
| **List vs. prose ratio** | [Heavy lists / Balanced / Prose-dominant] |
| **Transition approach** | [Explicit connectors / Implicit flow / White space breaks] |

### 3. Engagement Techniques

Check all that apply and note the pattern (not specific instances):

- [ ] **Direct address**: Uses "you" to speak to the reader
- [ ] **Rhetorical questions**: Poses questions to create curiosity
- [ ] **Pattern interrupts**: Breaks expected flow to regain attention
- [ ] **Vulnerability/confession**: Shares personal failures or uncertainties
- [ ] **Social proof**: References others' experiences or data
- [ ] **Specificity**: Uses precise numbers, names, details over generalizations
- [ ] **Contrast/juxtaposition**: Places opposing ideas side by side
- [ ] **Callback/recursion**: References earlier points to create cohesion
- [ ] **Sensory language**: Uses concrete, visual, or tactile descriptions
- [ ] **Tempo variation**: Alternates between fast-paced and slow-paced sections

**Dominant engagement strategy** (1-2 sentences):

> [Describe the creator's primary method of keeping readers engaged]

### 4. Storytelling Approaches

| Element | Pattern |
|---------|---------|
| **Narrative presence** | [Rare / Occasional / Central to content] |
| **Story type** | [Personal anecdote / Case study / Hypothetical / Historical] |
| **Story placement** | [Opening hook / Embedded illustration / Extended throughline] |
| **Resolution style** | [Clear takeaway / Open-ended / Twist ending] |
| **Character perspective** | [First person / Third person / Reader as protagonist] |

### 5. Vocabulary & Language Register

| Element | Observation |
|---------|-------------|
| **Complexity level** | [Simple / Moderate / Advanced / Mixed by section] |
| **Jargon usage** | [Avoided / Defined when used / Assumed known / Heavy] |
| **Preferred verb style** | [Action-oriented / Descriptive / Analytical] |
| **Modifier density** | [Sparse (few adjectives) / Moderate / Rich (heavily modified)] |
| **Contraction usage** | [Frequent / Occasional / Never] |
| **Sentence variety** | [Uniform / Moderate variety / High variety] |

---

## How to Extract Principles

Follow this process to convert observations into reusable, ethical principles:

### Step 1: Observe (Gather Raw Data)

Fill in the analysis sections above using 3-5 content samples. Focus on *recurring patterns*, not one-off occurrences. A pattern must appear in at least 2 of the samples to be noted.

### Step 2: Abstract (Remove Specifics)

Convert each observation into a general principle. Examples:

| Raw Observation | Abstracted Principle |
|----------------|---------------------|
| "Creator opens every post with a 1-sentence personal confession" | **Hook via vulnerability**: Open with a brief personal admission relevant to the topic |
| "Uses paragraphs of exactly 1-2 sentences throughout" | **Scannable density**: Keep paragraphs to 1-2 sentences for readability |
| "Ends every piece with 'Now go try it'" | **Action-oriented close**: End with a direct, imperative call to action |

### Step 3: Validate (Ethical Check)

For each extracted principle, confirm:

- [ ] The principle describes a *technique*, not a *signature element* unique to this creator
- [ ] Another brand could apply this principle without sounding like a copy
- [ ] No distinctive phrases, coined terms, or proprietary frameworks are included
- [ ] The principle would still make sense without knowing who the source creator is

### Step 4: Contextualize (Map to Use Cases)

For each principle, note:
- **Best suited for**: [Content types or contexts where this works well]
- **Caution**: [When this technique might not fit or could feel inauthentic]
- **Adaptation needed**: [How a brand would need to modify this for their own voice]

---

## Output: Extracted Principles Summary

### Principle 1: [Name]

- **Category**: [Tone / Structure / Engagement / Storytelling / Vocabulary]
- **Description**: [1-2 sentence description of the technique]
- **Application**: [How to apply this in content creation]
- **Source creator**: [Attribution]
- **Ethical validation**: [Passed / Needs review]

### Principle 2: [Name]

*(Repeat for each extracted principle, typically 3-8 per analysis)*

---

## Integration with Analyst Mode

This analysis feeds into the agent-brand-voice Analyst mode:

1. **Input**: Content samples provided by the user
2. **Process**: Analyst applies this template systematically
3. **Output**: Extracted principles stored in the inspiration library (see `inspiration-library-template.md`)
4. **Usage**: Principles available to Generator and Reviewer modes as technique references

## Quality Gate: QG-BV-6 (External Reference Ethics)

This analysis passes QG-BV-6 when:

- [ ] All principles are abstracted (no direct content reproduction)
- [ ] Creator attribution is complete and accurate
- [ ] No signature phrases or coined terminology are captured
- [ ] Ethical validation checklist is completed for every principle
- [ ] Principles are transferable (would work for any brand, not just mimicry)
