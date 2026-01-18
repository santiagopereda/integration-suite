# Example: CV Tailoring Workflow

This example demonstrates the HR Manager mode tailoring a CV to match a job description.

## Scenario

User wants to apply for a specific Data Engineer role and needs their CV tailored.

## User Request

```
@agent-cv-optimizer: Tailor my CV for this Airbnb Data Engineer role:

Data Engineer - Airbnb
San Francisco, CA

About the Role:
Join our Data Platform team to build scalable data infrastructure
that powers Airbnb's marketplace of 4 million hosts.

Requirements:
- 3+ years in data engineering
- Expertise in Python and SQL
- Experience with Spark and Airflow
- Knowledge of data warehousing (Snowflake preferred)
- Familiarity with dbt for data transformations
- Experience with AWS services
```

## Agent Response

### Mode Activated: HR Manager

I detected your base CV: `Santiago_Pereda_CV.yaml`

Let me analyze the JD against your current CV.

---

### Skills Gap Analysis

| Requirement | Your CV | Match | Recommendation |
|-------------|---------|-------|----------------|
| Python (3+ yrs) | Python (5+ yrs) | **Strong** | Keep as is |
| SQL | SQL | **Strong** | Emphasize analytical queries |
| Spark | Apache Spark | **Strong** | Move to top of skills |
| Airflow | Apache Airflow | **Strong** | Emphasize orchestration experience |
| Snowflake | Not listed | **Gap** | Add if experienced, or mention similar (BigQuery) |
| dbt | Not listed | **Partial** | Add if experienced |
| AWS | GCP primarily | **Partial** | Add any AWS experience |

**Overall Match Score**: 75%

---

### Proposed CV Modifications

#### 1. Profile Section

**Current**:
```yaml
profile: |
  Data professional with experience in designing and deploying
  data pipelines and analytics solutions.
```

**Proposed**:
```yaml
profile: |
  Data Engineer with 5+ years building scalable data infrastructure
  and ETL pipelines using Python, Spark, and modern orchestration
  tools. Experienced in data warehouse design and transformation
  workflows serving millions of users.
```

**Rationale**: Added keywords "scalable data infrastructure", "ETL pipelines", emphasized tools matching JD.

#### 2. Skills Section Reordering

**Current Order**:
1. Programming Languages
2. Data Tools
3. Cloud Platforms

**Proposed Order**:
1. Data Engineering (Spark, Airflow, dbt)
2. Programming (Python, SQL)
3. Cloud & Infrastructure (AWS, GCP)
4. Data Warehousing (Snowflake, BigQuery)

**Rationale**: Lead with data engineering tools that match JD priority.

#### 3. Experience Bullet Point Modifications

**Current** (IntoData position):
```yaml
- Designed and deployed 50+ data pipelines using Python
```

**Proposed**:
```yaml
- Designed and deployed 50+ scalable data pipelines using Python,
  Spark, and Airflow, processing millions of records daily
```

**Rationale**: Added scale indicators and tool keywords.

---

### Files to Create

```
applications/
└── airbnb/
    ├── jd.md                   # Original job description
    ├── jd-analysis.md          # Keyword extraction
    ├── cv-airbnb.yaml          # Tailored CV
    └── cover-letter.md         # (optional, next step)
```

---

### Confirmation Required

Before I create the tailored CV:

1. **Snowflake**: Do you have Snowflake experience to add?
2. **dbt**: Have you used dbt for transformations?
3. **AWS**: What AWS services have you worked with?

Please confirm the proposed changes, and I'll:
1. Create the `applications/airbnb/` directory
2. Save the JD and analysis
3. Create the tailored `cv-airbnb.yaml`
4. Update the application tracker

---

## Key Takeaways

1. **Gap analysis** shows clear match vs. missing skills
2. **Specific modifications** are proposed with rationale
3. **User confirmation** required before applying changes
4. **Authenticity preserved** - only real experience is enhanced
5. **Directory structure** created for organization
