# Example: JD Analysis Workflow

This example demonstrates the HR Manager mode analyzing a job description.

## Scenario

User found a Data Engineer position and wants keyword analysis.

## User Request

```
@agent-cv-optimizer: Analyze this job description for keywords:

Senior Data Engineer - Spotify
Location: Stockholm, Sweden

About the Role:
We're looking for a Senior Data Engineer to join our Data Platform team.
You'll build and maintain data pipelines that power recommendations for
350 million users.

Requirements:
- 5+ years experience in data engineering
- Strong proficiency in Python and SQL
- Experience with Apache Spark and/or Flink
- Knowledge of Kafka for real-time streaming
- Experience with cloud platforms (GCP preferred)
- Familiarity with data modeling and warehousing
- Experience with workflow orchestration (Airflow)

Nice to have:
- Experience with Terraform or similar IaC
- Familiarity with dbt for transformations
- Knowledge of Kubernetes
- Experience in music or media industry
```

## Agent Response

### Mode Activated: HR Manager

I'll analyze this JD and extract key information for your application.

### JD Analysis: Spotify Senior Data Engineer

**Company**: Spotify
**Role**: Senior Data Engineer
**Team**: Data Platform
**Location**: Stockholm, Sweden

---

#### Required Technical Skills

| Skill | Keyword Forms | Priority |
|-------|--------------|----------|
| Python | Python, Python programming | **Required** |
| SQL | SQL, SQL queries | **Required** |
| Apache Spark | Spark, PySpark, Apache Spark | **Required** |
| Apache Flink | Flink | **Required** |
| Kafka | Kafka, Apache Kafka, real-time streaming | **Required** |
| GCP | Google Cloud Platform, GCP, cloud platforms | **Required** |
| Data Modeling | data modeling, warehousing | **Required** |
| Airflow | Apache Airflow, workflow orchestration | **Required** |

#### Preferred Skills

| Skill | Keyword Forms | Priority |
|-------|--------------|----------|
| Terraform | Terraform, IaC, Infrastructure as Code | **Preferred** |
| dbt | dbt, data build tool, transformations | **Preferred** |
| Kubernetes | Kubernetes, K8s | **Preferred** |
| Domain Experience | music, media, entertainment | **Preferred** |

#### Experience Requirements
- **Years**: 5+ years
- **Level**: Senior
- **Scale Indicators**: "350 million users" - mention scale in your experience

#### Hidden Keywords (implied)
- Data pipelines
- ETL/ELT
- Big data
- Distributed systems
- Recommendations/ML (downstream consumer)

---

### ATS Optimization Notes

1. **Must include in CV**: Python, SQL, Spark, Kafka, GCP, Airflow
2. **Should include if applicable**: Flink, dbt, Terraform, Kubernetes
3. **Scale keywords**: Include user counts, data volumes, throughput
4. **Domain reference**: Any media/streaming experience is valuable

---

### Next Steps

Shall I:
1. Create the `applications/spotify/` directory and save this analysis?
2. Proceed to skills gap analysis against your CV?
3. Start tailoring your CV for this role?

---

## Key Takeaways

1. **Keyword extraction** identifies both explicit and implicit requirements
2. **Categorization** helps prioritize what to emphasize
3. **ATS optimization** notes guide CV modifications
4. **User control** - agent asks before proceeding to next steps
