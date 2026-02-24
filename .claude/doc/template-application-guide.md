# Template Application Guide

This guide provides comprehensive instructions for applying universal templates across integrations in the Client-A multi-integration project.

## Overview

The Client-A project uses a template-driven development approach to ensure consistency across all integrations. Universal templates are stored in the `/Templates/` directory and provide the foundation for all integration components.

## Universal Template Usage Pattern

```yaml
Template Application Process:
  1. Identify Required Template: Match template to integration component
  2. Copy Template: Copy from Templates/ to integration location
  3. Customize Placeholders: Replace {integration} variables with specific values
  4. Add Cross-References: Link template-generated files with workflows
  5. Validate Structure: Ensure template follows integration standards

Template-to-Location Mapping:
  - universal-workflow-template.md → Workflow Logic/*.md files
  - universal-sql-template.sql → Resources/SQL/*/*.sql files  
  - universal-api-config-template.md → Resources/APIs/*.md files
  - universal-json-schema-template.json → Resources/Schemas/*.json files
  - integration-overview-template.md → Resources/Documentation/high-level-overview.md
```

## Template Categories

### 1. Workflow Templates
- **File**: `universal-workflow-template.md`
- **Purpose**: Standardized workflow documentation structure
- **Target Location**: `{Integration}/Workflow Logic/`
- **Usage**: Main workflow files and step-specific documentation

### 2. SQL Templates
- **File**: `universal-sql-template.sql`
- **Purpose**: Standardized SQL query structure with common patterns
- **Target Location**: `{Integration}/Resources/SQL/`
- **Usage**: Database extraction, transformation, and synchronization queries

### 3. API Configuration Templates
- **File**: `universal-api-config-template.md`
- **Purpose**: API connection and authentication configuration
- **Target Location**: `{Integration}/Resources/APIs/`
- **Usage**: OAuth2 setup, endpoint configuration, payload examples

### 4. JSON Schema Templates
- **File**: `universal-json-schema-template.json`
- **Purpose**: Data structure definitions and validation schemas
- **Target Location**: `{Integration}/Resources/Schemas/`
- **Usage**: Table structures, API payloads, data validation

### 5. Integration Overview Templates
- **File**: `integration-overview-template.md`
- **Purpose**: Business-focused integration documentation
- **Target Location**: `{Integration}/Resources/Documentation/`
- **Usage**: High-level integration descriptions for stakeholders

## Template Customization Process

### Standard Placeholder Variables

```yaml
Core Variables:
  {Integration-Name}: Full integration name (e.g., "SAP-Agiloft-Interface")
  {source}: Source system name (lowercase, e.g., "sap", "workday")
  {target}: Target system name (lowercase, e.g., "agiloft")
  {integration}: Combined identifier (lowercase, e.g., "sap-agiloft")
  {Source}: Capitalized source system name (e.g., "SAP", "Workday")
  {Target}: Capitalized target system name (e.g., "Agiloft")

Business Context Variables:
  {entity-count}: Number of business entities to process
  {data-direction}: "bidirectional" or "unidirectional"
  {compliance-requirements}: Regulatory requirements (GDPR, SOX, etc.)
  {volume-expectations}: Expected record counts and processing requirements
```

### Customization Examples

#### Example 1: SAP Integration
```yaml
Template Customization for SAP-Agiloft Integration:
  {Integration-Name} → "SAP-Agiloft-Interface"
  {source} → "sap"
  {target} → "agiloft"
  {integration} → "sap-agiloft"
  {Source} → "SAP"
  {Target} → "Agiloft"
  {entity-count} → "3 business entities"
  {data-direction} → "bidirectional"
```

#### Example 2: Workday Integration
```yaml
Template Customization for Workday-Agiloft Integration:
  {Integration-Name} → "Workday-Agiloft-Interface"
  {source} → "workday"
  {target} → "agiloft"
  {integration} → "workday-agiloft"
  {Source} → "Workday"
  {Target} → "Agiloft"
  {entity-count} → "1 primary entity"
  {data-direction} → "unidirectional"
```

## Template Application Workflow

### Step 1: Template Selection
Identify which templates are needed based on integration requirements:

```bash
# List available templates
ls Templates/

# Common template combinations:
# - All integrations need: universal-workflow-template.md, integration-overview-template.md
# - Database integrations add: universal-sql-template.sql, universal-json-schema-template.json
# - API integrations add: universal-api-config-template.md
```

### Step 2: Template Copying
Copy templates to appropriate integration locations:

```bash
# Navigate to integration directory
cd "{Integration-Name}-Interface"

# Copy and rename templates
cp "../Templates/universal-workflow-template.md" "Workflow Logic/workflow-{integration}-main.md"
cp "../Templates/universal-api-config-template.md" "Resources/APIs/{target}-connection-config.md"
cp "../Templates/universal-sql-template.sql" "Resources/SQL/workflow-{source}-to-{target}/{Source}RetrieveRecords.sql"
cp "../Templates/universal-json-schema-template.json" "Resources/Schemas/{source}_{table}_schema.json"
cp "../Templates/integration-overview-template.md" "Resources/Documentation/high-level-overview.md"
```

### Step 3: Variable Replacement
Replace all placeholder variables with integration-specific values:

```bash
# Use sed for bulk replacement (Linux/Mac)
find . -name "*.md" -exec sed -i 's/{Integration-Name}/SAP-Agiloft-Interface/g' {} \;
find . -name "*.md" -exec sed -i 's/{source}/sap/g' {} \;
find . -name "*.md" -exec sed -i 's/{target}/agiloft/g' {} \;
find . -name "*.md" -exec sed -i 's/{integration}/sap-agiloft/g' {} \;
find . -name "*.md" -exec sed -i 's/{Source}/SAP/g' {} \;
find . -name "*.md" -exec sed -i 's/{Target}/Agiloft/g' {} \;
```

### Step 4: Content Customization
Add integration-specific content to each template:

1. **Business Context**: Update business logic, entity structures, compliance requirements
2. **Technical Details**: Add specific API endpoints, database schemas, field mappings
3. **Cross-References**: Establish links between template files and other integration components
4. **Validation Rules**: Add integration-specific validation and error handling requirements

### Step 5: Cross-Reference Integration
Link template-generated files with other integration components:

1. **Update RESOURCE_INDEX.md**: Add all new files to the cross-reference matrix
2. **Add "Used By" Sections**: Link resource files to workflows that use them
3. **Create Bidirectional Links**: Ensure navigation works in both directions
4. **Validate Links**: Test all internal links and references

## Template Validation Checklist

### Pre-Application Validation
```yaml
Before Applying Templates:
  ✓ Integration directory structure exists
  ✓ Required subdirectories created
  ✓ Template files exist in Templates/ directory
  ✓ Integration naming convention defined
  ✓ Business requirements documented
```

### Post-Application Validation
```yaml
After Applying Templates:
  ✓ No placeholder variables remain ({source}, {target}, etc.)
  ✓ File names follow integration naming conventions
  ✓ Cross-references established between files
  ✓ Business context properly customized
  ✓ Technical specifications complete
  ✓ Links functional and accurate
```

## Template Maintenance

### Universal Template Updates
When universal templates are updated, existing integrations should be assessed for compatibility:

```yaml
Template Update Impact Assessment:
  1. Breaking Changes: Require manual migration of existing integrations
  2. Enhancement Changes: Optional adoption, evaluate benefits vs. effort
  3. Bug Fixes: Should be applied to all integrations using affected templates
  4. New Features: Evaluate applicability to existing integrations
```

### Integration-Specific Template Modifications
While templates provide a baseline, integration-specific modifications are expected:

```yaml
Acceptable Modifications:
  ✓ Additional business logic sections
  ✓ Integration-specific validation rules
  ✓ Enhanced error handling procedures
  ✓ Additional cross-references and links
  ✓ Compliance-specific requirements

Discouraged Modifications:
  ✗ Removing standard template sections
  ✗ Changing core structure or organization
  ✗ Breaking naming conventions
  ✗ Removing cross-reference infrastructure
```

## Template Troubleshooting

### Common Issues

#### Issue 1: Missing Placeholder Replacements
**Symptoms**: Files contain {source}, {target}, or other placeholder variables
**Solution**: Run comprehensive search and replace operation

#### Issue 2: Broken Cross-References
**Symptoms**: Links between files don't work or point to incorrect locations
**Solution**: Update RESOURCE_INDEX.md and validate all internal links

#### Issue 3: Inconsistent Naming
**Symptoms**: File names don't follow integration naming conventions
**Solution**: Rename files to match standardized patterns

#### Issue 4: Incomplete Customization
**Symptoms**: Template content not adapted to integration requirements
**Solution**: Review business requirements and customize template content accordingly

## Related Documentation

- [Integration Creation Guide](integration-creation-guide.md) - Complete integration creation workflow
- [Quality Assurance Standards](quality-assurance-standards.md) - Validation and assessment procedures
- [Development Standards](../CLAUDE.md#development-standards--cross-referencing-system) - Core development guidelines