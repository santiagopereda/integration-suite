# Video Script Outlines

Structured outlines for YouTube videos and presentations.

---

## Video 1: Introduction to Agentic (5 minutes)

### Purpose
Quick overview for newcomers — what is Agentic, why it matters, what you can do with it.

### Audience
Developers and technical professionals exploring AI agent architecture.

---

### Script Outline

**[0:00-0:30] HOOK**

*Visual: Token counter going from 31,000 down to 15,200*

> "What if I told you we reduced AI agent token usage by 51%... in just 6 hours of focused work?
>
> Hi, I'm [Name], and today I'm going to show you how we transformed a simple optimization into an 11-agent ecosystem saving ~2.1 million tokens per year.
>
> This is Agentic."

---

**[0:30-1:30] THE PROBLEM**

*Visual: Agent definition with highlighted bloated sections*

> "Here's the problem we discovered.
>
> When we built AI agents for Claude Code, every invocation loaded 15,000 to 16,000 tokens of content. Documentation templates. Code patterns. Quality checklists.
>
> *Visual: Pie chart showing content breakdown*
>
> Most of this content was used only 30-40% of the time. But it was loaded 100% of the time.
>
> At 31,000 tokens per cycle, costs were compounding fast.
>
> We asked: what if we only loaded what we needed?"

---

**[1:30-3:00] THE SOLUTION**

*Visual: Template externalization diagram*

> "The answer was **template externalization**.
>
> *Visual: Animation showing content moving from agent to template file*
>
> Step one: Identify static content — templates, patterns, checklists.
>
> Step two: Extract to external files in `.agent/templates/`.
>
> Step three: Update the agent to load on-demand using the Read tool.
>
> *Visual: Cost comparison*
>
> The loading cost? About 450 tokens.
> The content avoided? About 8,700 tokens.
> Net savings? Over 8,000 tokens per invocation.
>
> And that's just when you DO need the template. When you don't? Pure savings."

---

**[3:00-4:00] THE RESULTS**

*Visual: Before/after metrics dashboard*

> "Here's what happened:
>
> *Visual: Bar chart animation*
>
> SAP BusinessPartner agent: 58% reduction.
> Ansible Automation agent: 59% reduction.
> Combined cycle savings: 18,200 tokens.
>
> Annual projection at modest usage: 2.1 million tokens saved.
>
> Break-even point: The first invocation.
>
> *Visual: Timeline showing growth*
>
> What started as optimization for 2 agents grew into an 11-agent ecosystem with cross-project learning, telemetry, and automated optimization."

---

**[4:00-5:00] WHAT'S NEXT**

*Visual: Agent catalog overview*

> "Agentic now includes specialized agents for:
> - SAP integration
> - DevOps automation
> - Robotics testing
> - Git workflows with security scanning
> - Career optimization
> - And more.
>
> Plus commands for project initialization, optimization analysis, and documentation.
>
> *Visual: Call to action*
>
> Want to apply this to your agents? The core pattern is simple:
>
> 1. Measure your baseline
> 2. Find embedded content over 100 words
> 3. Extract to templates
> 4. Load on-demand
> 5. Verify with test cases
>
> That's it. 51%+ savings.
>
> Thanks for watching. If you found this useful, like and subscribe for more AI engineering content."

---

## Video 2: Deep Dive - The Optimization Story (15 minutes)

### Purpose
Technical deep dive into how template externalization was discovered and implemented.

### Audience
Engineers and architects who want to understand the methodology and apply it.

---

### Script Outline

**[0:00-1:00] HOOK + CONTEXT**

*Visual: Split screen - bloated vs. lean agent*

> "November 28, 2025. We sat down with two AI agents and one question: why do they cost so much?
>
> Six hours later, we had an answer — and a pattern that would change how we build agents.
>
> This is the story of how we achieved 51-65% token reduction while maintaining 100% functionality."

---

**[1:00-4:00] PHASE 1: DISCOVERY & EXTERNALIZATION**

*Visual: Code walkthrough of original agent*

> "Let's look at what we were working with.
>
> The Ansible Automation agent: 575 lines, 2,433 words, approximately 16,000 tokens.
>
> *Visual: Highlighted sections*
>
> Here's the breakdown:
> - Core identity and purpose: 200 words
> - Responsibilities: 300 words
> - Constraints: 200 words
> - Methodology: 400 words
>
> And then the embedded content:
> - Documentation template: 400 words
> - Task patterns: 350 words
> - Variable patterns: 280 words
> - Quality checklist: 200 words
>
> *Visual: Usage frequency chart*
>
> The documentation template? Used maybe 30% of the time.
> Task patterns? 40%.
> Quality checklist? Only at the end.
>
> But ALL of this loaded on EVERY invocation.
>
> *Visual: Animation showing extraction*
>
> So we extracted. 12 template files created. All the static content, organized by domain."

---

**[4:00-7:00] THE LAZY LOADING PATTERN**

*Visual: Technical diagram of Read tool flow*

> "Now here's where it gets interesting.
>
> After extraction, the agent needed to know when to load templates.
>
> *Visual: Agent definition snippet*
>
> We added loading instructions:
> - 'When creating playbook documentation, load playbook-doc.md'
> - 'When writing tasks, load task-pattern.yml'
> - 'Before delivering output, load quality-checklist.md'
>
> *Visual: Token economics diagram*
>
> The economics work like this:
>
> Read tool loading cost: approximately 450 tokens per template.
> Template content value: 400-600 words, about 500-800 tokens.
> Content you DON'T load when not needed: 8,700 tokens.
>
> If templates are used 40% of the time:
> - 40% of calls: Load cost of 450, content saved of 8,700 minus 450 = 8,250 saved
> - 60% of calls: Full 8,700 tokens saved
>
> Weighted average savings: massive."

---

**[7:00-10:00] PHASE 2: ARCHITECTURE ALIGNMENT**

*Visual: Gap analysis showing 13% difference*

> "Phase 1 results:
> - SAP BP agent: 58% reduction
> - Ansible agent: 45% reduction
> - Gap: 13%
>
> That gap bothered us. Inconsistent architecture complicates maintenance.
>
> *Visual: List of 7 optimizations*
>
> Phase 2 focused on closing the gap with 7 strategic optimizations:
>
> 1. Externalize best practices — 970 tokens saved
> 2. Consolidate template sections — 470 tokens
> 3. Compress expertise section — 187 tokens
> 4. Streamline responsibilities — 234 tokens
> 5. Condense constraints — 180 tokens
> 6. Tighten workflow example — 160 tokens
> 7. Tighten communication style — 20 tokens
>
> Total: about 2,200 additional tokens saved.
>
> Final result:
> - SAP BP: 58%
> - Ansible: 59%
> - Gap: 1%"

---

**[10:00-13:00] VALIDATION & QUALITY GATES**

*Visual: Test case dashboard*

> "How did we know we didn't break anything?
>
> *Visual: Test case list*
>
> Each agent has 6-12 test cases covering:
> - Core functionality
> - Edge cases
> - Error handling
> - Uncertainty acknowledgment
>
> We ran structural verification against all 12 Ansible test cases.
>
> *Visual: Pass/fail results*
>
> Result: 12 of 12 passed.
>
> The key insight: for pure optimization (compression, externalization) without functional changes, structural verification is sufficient. Runtime testing reserved for new features or quarterly review."

---

**[13:00-15:00] LESSONS & APPLICATION**

*Visual: Summary graphic*

> "Six hours. Two agents. 51-65% reduction.
>
> *Visual: Key lessons list*
>
> What we learned:
>
> 1. Agent definitions should contain identity, constraints, workflow. Reference content belongs in templates.
>
> 2. Lazy loading has minimal overhead — 450 tokens to save 8,700.
>
> 3. Consistency matters — Phase 2 was worth it for architecture alignment.
>
> 4. Structural validation works for optimization.
>
> 5. Measure everything — baseline metrics make ROI provable.
>
> *Visual: Call to action*
>
> How to apply this yourself:
>
> 1. Measure your agent's baseline
> 2. Identify embedded content over 100 words
> 3. Extract to `.agent/templates/`
> 4. Add loading instructions to agent
> 5. Run test cases
> 6. Measure new baseline
>
> The pattern is simple. The savings are real. The ROI is immediate."

---

## Video 3: Agent Showcase (10 minutes)

### Purpose
Demonstrate the agents in the Agentic ecosystem with practical examples.

### Audience
Users who want to see what the agents can do.

---

### Script Outline

**[0:00-1:00] INTRO**

> "Agentic includes 11 specialized agents across multiple domains. Today I'm going to show you some of them in action."

**[1:00-3:00] agent-git-manager Demo**

*Visual: Terminal/IDE showing commit workflow*

> "First up: agent-git-manager.
>
> This agent handles git workflows with pre-commit security scanning.
>
> *Demo: User types '@agent-git-manager: commit my changes'*
>
> Watch what happens:
> - Scans for secrets (.env files, API keys, credentials)
> - Shows changes to be committed
> - Generates conventional commit message
> - Asks for confirmation before commit
>
> No more accidentally committing credentials."

**[3:00-5:00] agent-cv-optimizer Demo**

*Visual: JD analysis and CV tailoring workflow*

> "Next: agent-cv-optimizer for Data & AI careers.
>
> Three modes: Career Coach, HR Manager, Interviewer.
>
> *Demo: User provides job description*
>
> The HR Manager mode:
> - Extracts keywords from JD
> - Identifies required skills
> - Scores your CV against requirements
> - Suggests specific improvements"

**[5:00-7:00] agent-provisioner Demo**

*Visual: Syncing agents to another project*

> "agent-provisioner lets you deploy agents from the hub to any project.
>
> *Demo: @agent-provisioner: sync /path/to/project*
>
> It:
> - Compares versions between hub and target
> - Shows what will change
> - Lets you select which agents to sync
> - Creates backups before overwriting
> - Merges hooks without breaking existing permissions"

**[7:00-9:00] /optimize Command Demo**

*Visual: Agent analysis output*

> "The /optimize command analyzes agents for optimization opportunities.
>
> *Demo: /optimize status*
>
> You get a dashboard showing:
> - Current token usage per agent
> - Optimization status
> - Recommended patterns to apply
> - Priority ranking"

**[9:00-10:00] WRAP UP**

> "11 agents. 4 commands. All designed to work together.
>
> The best part? You can provision any of these to your own projects with a single command."

---

## Presentation Deck Outline

### For Internal Knowledge Sharing (20 slides)

1. **Title**: Agentic — Agent Hub for Claude Code
2. **The Problem**: Token bloat in agent definitions
3. **Numbers**: 31,000 tokens per cycle baseline
4. **The Insight**: Static vs. dynamic content
5. **The Pattern**: Template externalization
6. **How It Works**: Diagram
7. **Phase 1 Results**: 51% reduction
8. **Phase 2 Results**: Architecture alignment
9. **The Ecosystem**: 11 agents overview
10. **Production Agents**: Brief descriptions
11. **Commands**: project_init, optimize, etc.
12. **Cross-Project Learning**: Testimony system
13. **Success Patterns**: Top 5
14. **Failure Patterns**: Top 5
15. **Metrics Dashboard**: Current state
16. **Annual Impact**: ~2.1M tokens
17. **How to Use**: Quick start
18. **How to Contribute**: Adding agents
19. **Q&A**
20. **Resources**: Links to docs

---

**Version**: 1.0.0
**Last Updated**: 2026-01-25
**Formats**: YouTube, internal presentations, conference talks
