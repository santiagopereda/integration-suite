# Integration Creation Guide

This guide provides the complete workflow for creating new integrations in the UniQure multi-integration project.

## Overview

When creating new integrations, follow this **standardized process** using the Exact-Agiloft-Interface as the template model. Each integration follows a consistent structure to ensure maintainability and scalability.

## Integration Creation Workflow

### Step 1: Integration Assessment & Planning

```yaml
Planning Phase:
  1. Define integration scope: Source system → Target system
  2. Identify business entities: Number of databases/entities to process
  3. Determine data flow direction: Unidirectional vs bidirectional
  4. Map business processes: What workflows are needed
  5. Review template compatibility: Which universal templates apply

Assessment Questions:
  - What is the source ERP/business system?
  - What is the target vendor/management system?
  - How many business entities need processing?
  - What is the expected data volume?
  - Are there regulatory/compliance requirements?
```

### Step 2: Create Integration Directory Structure

Use the **Standardized Integration Template** based on Exact-Agiloft-Interface:

```bash
# Create new integration directory
mkdir -p "{Integration-Name}-Interface"
cd "{Integration-Name}-Interface"

# Create standard Resources subdirectories (based on Exact-Agiloft-Interface model)
mkdir -p "Resources/APIs"
mkdir -p "Resources/Database" 
mkdir -p "Resources/Documentation"
mkdir -p "Resources/SQL/workflow-{source}-to-{target}"
mkdir -p "Resources/SQL/workflow-{target}-to-{source}"  
mkdir -p "Resources/SQL/workflow-{source}-sync-{target}-id"
mkdir -p "Resources/Schemas"
mkdir -p "Resources/Scripts"
mkdir -p "Resources/XML"
mkdir -p "Resources/Data"
mkdir -p "Resources/Images"
mkdir -p "Resources/Lookup Table"
mkdir -p "Resources/Improvements"
mkdir -p "Resources/SDK Connector"
mkdir -p "Resources/Data Mapping"

# Create standard Workflow Logic structure
mkdir -p "Workflow Logic/workflow-{integration}-main"
mkdir -p "Workflow Logic/workflow-{integration}-main/workflow-{source}-to-{target}"
mkdir -p "Workflow Logic/workflow-{integration}-main/workflow-{target}-to-{source}"
mkdir -p "Workflow Logic/workflow-{integration}-main/workflow-{source}-sync-{target}-id"
```

### Step 3: Apply Universal Templates

Copy and customize universal templates from `/Templates/` directory:

```bash
# Copy universal templates to appropriate locations
cp "../../Templates/universal-api-config-template.md" "Resources/APIs/{target}-connection-config.md"
cp "../../Templates/universal-workflow-template.md" "Workflow Logic/workflow-{integration}-main.md"
cp "../../Templates/universal-sql-template.sql" "Resources/SQL/workflow-{source}-to-{target}/{Source}RetrieveRecords.sql"
cp "../../Templates/universal-json-schema-template.json" "Resources/Schemas/{source}_{table}_schema.json"

# Create integration-specific documentation
cp "../../Templates/integration-overview-template.md" "Resources/Documentation/high-level-overview.md"
```

### Step 4: Customize Templates for New Integration

Replace template placeholders with integration-specific values:

```yaml
Template Customization:
  - {Integration-Name}: e.g., "SAP-Agiloft", "Workday-Agiloft"
  - {source}: Source system name (e.g., "SAP", "Workday") 
  - {target}: Target system name (e.g., "Agiloft")
  - {integration}: Full integration identifier (e.g., "sap-agiloft")
  - {Source}: Capitalized source system name
  - {Target}: Capitalized target system name
```

### Step 5: Establish Cross-Reference Infrastructure

Create essential index and reference files:

```bash
# Create README files for each major directory
echo "# {Integration-Name} Resources" > Resources/README.md
echo "# {Integration-Name} Workflow Logic" > "Workflow Logic/README.md"

# Create RESOURCE_INDEX.md for cross-reference tracking
cp "../Exact-Agiloft-Interface/Resources/RESOURCE_INDEX.md" "Resources/RESOURCE_INDEX.md"
# Customize for new integration

# Create database entity mapping (if applicable)
cp "../Exact-Agiloft-Interface/Resources/Database/database-entity-mapping.md" "Resources/Database/database-entity-mapping.md"
```

## Standardized Integration Template

### Complete Directory Structure (Required for All Integrations)

```
{Integration-Name}-Interface/
├── 📚 Resources/                           # Integration-specific resource library
│   ├── 📋 RESOURCE_INDEX.md                # Mandatory: Complete resource cross-reference matrix
│   ├── 🗄️ Database/                        # Database configuration & entity management  
│   │   ├── README.md                       # Database configuration index
│   │   ├── dev-database-config.md          # Development environment configuration
│   │   ├── prod-database-config.md         # Production environment configuration
│   │   ├── database-entity-mapping.md      # Business entity hierarchy & processing
│   │   └── network-architecture.md         # Infrastructure & security model
│   ├── 🔗 APIs/                            # Target system API integration
│   │   ├── README.md                       # API resources documentation
│   │   ├── {target}-connection-config.md   # Complete OAuth2/API configuration
│   │   ├── {target}_api_create.json        # Creation payload format examples
│   │   ├── {target}_api_update.json        # Update payload format examples
│   │   └── {target}_api_response.json      # API response examples
│   ├── 🗃️ SQL/                             # Database queries organized by workflow
│   │   ├── README.md                       # SQL resources documentation
│   │   ├── workflow-{source}-to-{target}/  # Source → Target queries
│   │   ├── workflow-{target}-to-{source}/  # Target → Source queries (if bidirectional)
│   │   └── workflow-{source}-sync-{target}-id/ # ID synchronization queries
│   ├── 📐 Schemas/                         # Data structure definitions
│   │   ├── README.md                       # Schema resources documentation
│   │   ├── {source}_{table}_schema.json    # Source system table structures
│   │   └── {target}_{object}_schema.json   # Target system object structures
│   ├── 📄 Scripts/                         # Automation and processing scripts
│   ├── 🏷️ XML/                             # Integration templates (if applicable)
│   ├── 📊 Data/                            # Sample data, exports, test data
│   ├── 🖼️ Images/                          # Screenshots, diagrams, flowcharts
│   ├── 📚 Documentation/                   # Integration-specific documentation
│   │   ├── high-level-overview.md          # Business-focused integration overview
│   │   └── {future-system}-migration-strategy.md # Migration planning docs
│   ├── 🔍 Lookup Table/                    # Configuration management
│   ├── 🚀 Improvements/                    # Project analysis & enhancements
│   ├── 🛠️ SDK Connector/                   # Development tools
│   └── 📈 Data Mapping/                    # Field mapping documentation
│
└── 🔄 Workflow Logic/                      # Integration-specific workflow documentation
    ├── 📋 README.md                        # Workflow index with resource tracking matrix
    ├── 🎛️ workflow-{integration}-main.md    # Main orchestrator workflow
    └── workflow-{integration}-main/        # Detailed workflow implementation
        ├── 📤 workflow-{source}-to-{target}/ # Source → Target synchronization
        │   ├── workflow-{source}-to-{target}.md # Main workflow documentation
        │   ├── {source}-retrieve-records.md     # Data extraction processes
        │   ├── {target}-search-{objects}.md     # Target system data retrieval
        │   ├── {target}-create-{objects}.md     # New record creation
        │   └── {target}-update-{objects}.md     # Record update processes
        ├── 📥 workflow-{target}-to-{source}/ # Target → Source synchronization (if bidirectional)
        └── 🔗 workflow-{source}-sync-{target}-id/ # ID synchronization workflows
```

### Mandatory Files for Each Integration

```yaml
Core Configuration Files (Must Exist):
  - Resources/RESOURCE_INDEX.md: Cross-reference matrix
  - Resources/APIs/{target}-connection-config.md: API configuration
  - Resources/Database/database-entity-mapping.md: Entity management
  - Workflow Logic/README.md: Workflow overview
  - Workflow Logic/workflow-{integration}-main.md: Main orchestrator

Documentation Files (Highly Recommended):
  - Resources/Documentation/high-level-overview.md: Business overview
  - Resources/README.md: Integration resource guide
  - Each workflow subdirectory needs main workflow .md file

Template-Based Files (Copy from Templates/):
  - Universal templates applied to integration context
  - Customized with integration-specific naming and logic
  - Cross-referenced with integration workflows
```

## Integration-Specific Customizations

```yaml
Required Customizations:
  System Names:
    - Replace {source} with actual source system (e.g., "SAP", "Workday")
    - Replace {target} with actual target system (e.g., "Agiloft") 
    - Replace {integration} with combined name (e.g., "sap-agiloft")
  
  Business Context:
    - Entity structure: Number and types of business entities
    - Data volume: Expected record counts and processing requirements
    - Compliance: Regulatory requirements (GDPR, SOX, etc.)
    - Architecture: On-premise vs cloud, security models
  
  Technical Details:
    - API endpoints and authentication methods
    - Database schemas and connection patterns
    - Field mappings between systems
    - Error handling and monitoring requirements
```

## Future Integration Examples

New integrations should follow the same pattern:

```
SAP-Agiloft-Interface/          # Future SAP integration
├── Resources/                  # SAP-specific resources
└── Workflow Logic/            # SAP-specific workflows

Workday-Agiloft-Interface/     # Future HR integration
├── Resources/                 # Workday-specific resources
└── Workflow Logic/           # Workday-specific workflows
```

## Related Documentation

- [Template Application Guide](template-application-guide.md) - Detailed template usage patterns
- [Quality Assurance Standards](quality-assurance-standards.md) - Assessment and validation procedures
- [Development Standards](../CLAUDE.md#development-standards--cross-referencing-system) - Core development guidelines