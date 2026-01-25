# CV Optimizer Workflow Examples

Detailed step-by-step workflows for common use cases.

---

## Example 1: Full Application Workflow

**User**: "Here's a JD for a Senior Data Engineer at Airbnb. Help me apply."

**Steps**:
1. Parse JD and create `applications/airbnb/jd.md`
2. Analyze requirements to `applications/airbnb/jd-analysis.md`
3. Run skills gap analysis against user's base CV
4. Create tailored CV: `applications/airbnb/cv-airbnb.yaml`
5. Generate cover letter: `applications/airbnb/cover-letter.md`
6. Add entry to `applications/tracker.md`
7. Offer interview prep when ready

**Key Outputs**:
- JD analysis with keyword extraction
- Skills match score (e.g., 78% match)
- Gap identification with improvement suggestions
- Tailored CV with modified bullet points
- Targeted cover letter highlighting relevant experience

---

## Example 2: Career Coaching Session

**User**: "I'm a software engineer wanting to move to ML Engineering. Help me position myself."

**Steps**:
1. Ask about current tech stack and projects
2. Identify ML-adjacent experience (data processing, APIs, etc.)
3. Find blindspots (missing: ML frameworks, math, MLOps)
4. Create positioning strategy
5. Suggest skill development priorities
6. Recommend entry points (ML-focused projects, courses)

**Key Questions to Ask**:
- What programming languages do you use daily?
- Have you worked with any data pipelines or ETL processes?
- What's your experience with Python data science libraries?
- Have you deployed any models, even simple ones?
- What's your math background (linear algebra, statistics)?

**Typical Blindspots for SWE→MLE**:
- Model evaluation and metrics
- Feature engineering best practices
- MLOps and model deployment
- Statistical thinking and experimental design
- Deep learning fundamentals

---

## Example 3: Interview Preparation

**User**: "I have a system design interview at Meta for a Data Engineer role."

**Steps**:
1. Research Meta's data infrastructure (web search)
2. Identify likely system design topics (data pipelines, real-time processing)
3. Generate 5-10 practice questions
4. Provide framework for answering each
5. Suggest questions to ask interviewer
6. Create `applications/meta/interview-notes.md`

**Typical Meta Data Engineering Topics**:
- Design a data pipeline for Facebook feed ranking
- Build a real-time analytics system for Instagram Stories
- Design a data warehouse for ad performance metrics
- Handle late-arriving data in streaming systems
- Design a feature store for ML models

**STAR Method Template**:
- **Situation**: Set the context (project, team, challenge)
- **Task**: Your specific responsibility
- **Action**: What you did (be specific about YOUR contribution)
- **Result**: Quantified outcome (X% improvement, Y users served)

**Questions to Ask Interviewer**:
- What does a typical project lifecycle look like on this team?
- How does the team balance new development vs. maintenance?
- What data quality challenges does the team face?
- How does this role collaborate with ML engineers?
