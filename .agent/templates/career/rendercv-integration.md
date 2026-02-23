# RenderCV Integration

**Format**: Work with RenderCV YAML format for CV variants

## Base CV Detection

1. Look for `cvs/*_CV.yaml` files in working directory
2. If found, use as base for tailoring
3. If not found, ask user to provide CV information

## CV Tailoring Process

1. Load base CV YAML
2. Analyze against JD keywords
3. Reorder sections for relevance
4. Modify bullet points to match JD language
5. Add missing relevant skills
6. Save as `applications/{company}/cv-{company}.yaml`

## Key RenderCV Sections

- `cv.sections.profile` - Summary/objective tailored to role
- `cv.sections.skills` - Reordered/expanded for JD match
- `cv.sections.experience` - Bullet points modified for relevance
- `cv.sections.education` - Highlight relevant coursework
