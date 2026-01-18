# Example: Interview Preparation Workflow

This example demonstrates the Interviewer mode preparing for a technical interview.

## Scenario

User has an upcoming system design interview at a major tech company.

## User Request

```
@agent-cv-optimizer: I have a system design interview at Meta for
a Data Engineer role next week. Help me prepare.
```

## Agent Response

### Mode Activated: Interviewer

I'll research Meta and prepare comprehensive interview notes for you.

---

## Interview Preparation: Meta Data Engineer

### Company Overview

**Meta (formerly Facebook)**
- Global tech company focused on social connections and metaverse
- Engineering culture: "Move fast with stable infrastructure"
- Data scale: Billions of users, petabytes of data daily

### Data Engineering at Meta

**Tech Stack** (from web research):
- **Processing**: Apache Spark, Presto, internal tools
- **Storage**: Data warehouse (Hive), HDFS, Scuba (real-time)
- **Orchestration**: Dataswarm (internal Airflow-like)
- **Languages**: Python, SQL, some Hack/PHP for pipelines

**Key Focus Areas**:
- Real-time data pipelines at massive scale
- Privacy-compliant data processing (GDPR, CCPA)
- ML feature pipelines for recommendations
- Cross-platform data integration

---

### System Design Questions to Prepare

#### 1. Design a Real-Time Analytics Dashboard
**Focus**: Event ingestion, aggregation, low-latency queries
**Key components**: Kafka, stream processing, time-series DB, caching

#### 2. Design a Data Pipeline for User Activity
**Focus**: ETL at scale, schema evolution, data quality
**Key components**: Batch processing, data validation, monitoring

#### 3. Design a Feature Store for ML Models
**Focus**: Online/offline serving, feature freshness, versioning
**Key components**: Key-value store, batch compute, serving layer

#### 4. Design a Privacy-Compliant Data Deletion System
**Focus**: GDPR right-to-erasure, cascading deletes, audit trails
**Key components**: Event sourcing, metadata tracking, verification

---

### Technical Deep-Dive Topics

Expect follow-up questions on:
- **Scalability**: How does your design handle 10x, 100x growth?
- **Fault tolerance**: What happens when components fail?
- **Data quality**: How do you ensure data correctness?
- **Latency vs. throughput**: Trade-offs in your design
- **Cost optimization**: How would you reduce cloud costs?

---

### Behavioral Questions (STAR Method)

#### "Tell me about a time you dealt with a data quality issue"
**Situation**: Describe the context and stakes
**Task**: What was your responsibility?
**Action**: What specific steps did you take?
**Result**: Quantify the outcome

#### "Describe a project where you had to influence without authority"
Focus on: Cross-team collaboration, stakeholder management

#### "Tell me about a technical decision you disagreed with"
Show: Respectful disagreement, data-driven advocacy, commitment after decision

---

### Questions to Ask the Interviewer

1. "What's the biggest data challenge your team is currently facing?"
2. "How does the team balance real-time vs. batch processing needs?"
3. "What does the on-call rotation look like for data engineers?"
4. "How do you handle schema evolution across dependent systems?"
5. "What's the typical project timeline from idea to production?"

---

### Logistics & Tips

**Interview Format** (typical Meta loop):
- Phone screen (45 min)
- Technical phone (coding/SQL)
- Virtual onsite (4-5 rounds):
  - 2x System Design
  - 1x Coding (SQL or Python)
  - 1x Behavioral
  - 1x Team match

**Meta-Specific Tips**:
- Emphasize impact and scale in your examples
- Show ownership mindset ("I did X" not "we did X")
- Be ready to discuss privacy implications of designs
- Prepare for open-ended problems with multiple valid solutions

---

### Created Files

- `applications/meta/interview-notes.md` - This preparation document
- `applications/meta/research.md` - Company research details

---

## Key Takeaways

1. **Company research** uses web search for accurate, current info
2. **Questions generated** are role and company-specific
3. **STAR framework** provided for behavioral questions
4. **Practical tips** based on known interview patterns
5. **Files created** for future reference
