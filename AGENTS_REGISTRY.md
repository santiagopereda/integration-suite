# Agents Registry

Central hub for all specialized Claude Code agents designed for this organization. This registry documents available agents, their capabilities, and how to use them.

## Quick Reference

| Agent ID | Name | Domain | Status | Use When |
|----------|------|--------|--------|----------|
| `agent-sap-businesspartner-integration` | SAP BusinessPartner Integration Process Author | SAP Integration | Production | Documenting BusinessPartner OData API integrations |
| `agent-ansible-automation` | Ansible Automation Development Specialist | DevOps Automation | Production | Creating Ansible playbooks, roles, testing, and automation docs |
| `agent-robotarm-tester` | Raspberry Pi Robot Arm Testing Engineer | Robotics Testing | Production | Testing, validating, debugging robot arms via SSH |
| `agent-git-manager` | Git Repository Manager | Developer Tools | Production | Secure commits with pre-commit scanning, SSH/GitHub integration |
| `agent-provisioner` | Agent Provisioner | Developer Tools | Production | Sync agents, commands, and hooks to other projects |
| `agent-cv-optimizer` | CV Optimizer for Data & AI | Career Development | Production | CV tailoring, interview prep, application tracking for Data/AI roles |
| `agent-project-init` | Project Initialization Specialist | Developer Tools | Production | Initialize new projects with type-appropriate structure and agents |
| `agent-optimizer` | Agent Optimization Specialist | Developer Tools | Production | Analyze and optimize agents using telemetry and structural analysis |

---

## Registered Agents

### 1. agent-sap-businesspartner-integration

**Status**: Production Ready (v1.0.0)

**Category**: SAP Integration

**Description**:
Expert SAP S/4HANA Cloud consultant specializing in BusinessPartner master data integration through OData APIs. Creates comprehensive, accurate Markdown documentation for integration teams implementing robust BusinessPartner data flows.

**Location**: `/agents/agent-sap-businesspartner-integration/`

**Files**:
- `agent.yml` - Agent configuration
- `system-prompt.md` - Complete system prompt (~1500 words)
- `README.md` - Trigger conditions and usage examples
- `test-cases.md` - 6 validation test cases
- `examples/` - Example outputs and usage patterns

**Key Expertise**:
- SAP S/4HANA Cloud OData APIs
- BusinessPartner master data management
- API integration patterns and best practices
- Data sequencing and dependencies
- Error handling and validation rules
- Escalation procedures

**Sub-Entities Covered**:
- BusinessPartnerRole
- BusinessPartnerAddress
- AddressUsage
- AddressPhoneNumber
- AddressEmailAddress
- BPContactToFuncAndDept
- BusinessPartnerTaxNumber
- BusinessPartnerBank
- BuPaIdentification
- BuPaIndustry

**Trigger Conditions**:
- User requests BusinessPartner OData API integration documentation
- User asks for step-by-step procedures (create/update/patch)
- User needs data sequencing and dependency guidance
- User requires SAP S/4HANA Cloud BusinessPartner best practices
- User asks about validation rules, error handling, escalation
- User needs PATCH vs PUT operation clarification

**Output Format**: Markdown documentation with:
- Step-by-step procedures
- Data dependency diagrams (textual)
- Integration best practices
- Error handling guidelines
- Escalation procedures
- Validation rules

**Critical Constraints**:
- Never fabricates SAP functionality
- Acknowledges limitations explicitly
- Uses accurate SAP terminology
- Does not include proprietary content
- Provides accurate entity names and endpoint patterns

**Documentation Structure**:
```
# Title

## Overview
## Data Model & Dependencies
## Step-by-Step Procedures
## Integration Best Practices
## Validation & Data Cleansing
## Error Handling & Troubleshooting
## Escalation Guidelines
## Misuse Prevention
## References
```

**Example Usage**:

```bash
# Complete integration guide
@agent-sap-businesspartner-integration: Create comprehensive documentation
for BusinessPartner creation flow with addresses and tax numbers

# Specific operation
@agent-sap-businesspartner-integration: Document how to update
a BusinessPartner address using PATCH. Explain when to use PATCH vs PUT.

# Best practices
@agent-sap-businesspartner-integration: Document best practices
for bulk BusinessPartner import including error handling and idempotency
```

**Quality Assurance**:
- 6 comprehensive test cases provided
- No fabricated functionality
- Accurate SAP API naming
- Transparent about uncertainties
- Clean Markdown formatting
- Actionable escalation paths

**Maintenance**:
- Quarterly accuracy verification
- Update when SAP releases API changes
- Incorporate team feedback
- Version control generated documentation

**Contact**: Agent Architecture Team

---

### 2. agent-ansible-automation

**Status**: Production Ready (v1.0.0)

**Category**: DevOps Automation

**Description**:
Expert DevOps automation specialist focusing exclusively on Ansible automation development. Creates production-ready Ansible playbooks, roles, tasks, and comprehensive documentation for teams implementing robust, secure, and maintainable infrastructure automation.

**Location**: `/agents/agent-ansible-automation/`

**Files**:
- `.claude/agents/agent-ansible-automation.md` - Agent definition (Claude Code format)
- `README.md` - Detailed usage guide and trigger conditions
- `test-cases.md` - 12 comprehensive validation test cases
- `examples/` - Complete role, playbook, and testing examples

**Key Expertise**:
- Ansible playbooks, roles, tasks, and handlers
- Ansible Galaxy integration and role reusability
- Inventory management (static INI/YAML, dynamic inventories)
- Variable precedence, organization, and Jinja2 templating
- Idempotency patterns and safe re-execution
- Testing frameworks (ansible-lint, yamllint, molecule)
- Security best practices (Ansible Vault, no_log, secrets management)
- Performance optimization (fact caching, mitogen, execution strategies)
- Cloud provider modules (AWS, Azure, GCP)
- CI/CD pipeline integration

**Core Capabilities**:
- Production-ready playbook and role creation
- Comprehensive error handling (block/rescue/always)
- Multi-platform role development
- Testing framework implementation
- Security and secrets management
- Performance optimization strategies
- Cloud infrastructure automation
- Variable hierarchy design
- Troubleshooting and debugging guidance

**Trigger Conditions**:
- User needs production-ready Ansible playbooks or roles
- User asks for Ansible role structure and best practices
- User requires inventory management guidance
- User needs testing strategies (ansible-lint, molecule, yamllint)
- User asks for security best practices (Ansible Vault, secrets)
- User requests performance optimization
- User needs cloud provider integration (AWS, Azure, GCP)
- User requires troubleshooting and debugging help

**Output Format**:
- Production-ready Ansible code (YAML, Jinja2 templates)
- Comprehensive Markdown documentation
- Testing framework configurations
- Role directory structures
- Variable documentation with types and examples

**Critical Constraints**:
- Never fabricates Ansible modules or parameters
- Acknowledges limitations and uncertainties explicitly
- Uses accurate Ansible terminology (playbook, role, handler)
- References correct module names with FQCN (ansible.builtin.*)
- Provides correct YAML syntax (2-space indentation)
- Warns about deprecated modules and features
- Does not assume undocumented module behavior

**Documentation Structure**:
```markdown
# Title

## Overview
## Requirements
## Role Variables
## Dependencies
## Usage Examples
## Testing
## Idempotency
## Error Handling
## Security Considerations
## Troubleshooting
## Performance Considerations
## References
```

**Example Usage**:

```bash
# Complete role creation
@agent-ansible-automation: Create a complete Ansible role for deploying
a Django application with Nginx, Gunicorn, PostgreSQL, and SSL certificates

# Security guidance
@agent-ansible-automation: Document best practices for managing secrets
in Ansible using Ansible Vault and integration with HashiCorp Vault

# Testing framework
@agent-ansible-automation: Create a molecule testing framework for
testing an Ansible role across multiple OS distributions

# Performance optimization
@agent-ansible-automation: Provide optimization strategies for playbooks
running against 200 servers including fact caching and parallel execution
```

**Quality Assurance**:
- 12 comprehensive test cases including uncertainty acknowledgment
- No fabricated Ansible functionality
- Accurate module names and parameters
- Transparent about limitations
- Idempotency verification
- Security best practices validation
- Performance optimization guidance

**Integration with Knowledge Base**:
- Checks `.agent/system/` for infrastructure documentation
- References `.agent/sops/` for standard automation procedures
- Cross-references `.agent/tasks/` for related implementation plans
- Documents new automation patterns discovered

**Maintenance**:
- Quarterly accuracy verification against Ansible documentation
- Update when Ansible releases new major versions
- Incorporate team feedback on best practices
- Version control all agent configurations

**Contact**: Agent Architecture Team

---

### 3. agent-robotarm-tester

**Status**: Production Ready (v1.0.0)

**Category**: Robotics Testing

**Description**:
Expert robotics testing engineer specializing in Raspberry Pi-based robot arm validation and debugging via SSH. Creates systematic, safe, and comprehensive test workflows that enable teams to validate robot arm functionality, discover operational boundaries, diagnose issues, and ensure reliable performance through remote testing.

**Location**: `/agents/agent-robotarm-tester/`

**Files**:
- `.claude/agents/agent-robotarm-tester.md` - Agent definition (Claude Code format)
- `README.md` - Detailed usage guide and trigger conditions
- `test-cases.md` - 12 comprehensive validation test cases
- `examples/` - Complete test workflows and benchmarking examples

**Key Expertise**:
- Robot arm testing methodologies (movement validation, workspace discovery, calibration)
- Remote testing via SSH (passwordless auth, command execution, error handling)
- Safety-first testing (progressive boundary discovery, automatic recovery)
- Diagnostic data collection (timestamped logs, command-response capture, failure analysis)
- Performance benchmarking (speed tests, accuracy validation, repeatability analysis)
- Error recovery automation (home position return, intelligent retry logic)
- Test sequence design (custom workflows, status checking, conditional execution)
- Integration testing (vision systems, conveyor belts, external sensors)

**Core Capabilities**:
- Progressive workspace boundary discovery with safety-first approach
- Systematic movement validation with automatic status checking
- Error recovery automation with intelligent retry logic
- Performance benchmarking (speed, accuracy, repeatability)
- Calibration sequence verification
- Integration testing with external systems
- Comprehensive diagnostic data collection and logging
- Configuration file generation and management

**Trigger Conditions**:
- User needs to discover and document safe operating boundaries for robot arm
- User wants to test specific movements or pick-and-place sequences systematically
- Robot arm exhibits inconsistent behavior requiring diagnostic testing
- User needs to benchmark performance before production deployment
- User wants to verify calibration accuracy or test calibration sequences
- User is integrating with vision systems, conveyor belts, or external devices
- User needs to validate error handling and recovery procedures
- User requires comprehensive validation before production deployment

**Output Format**:
- Complete bash test scripts with SSH remote execution
- Timestamped test session logs in Markdown format
- CSV data files for statistical analysis
- YAML configuration files with discovered workspace limits
- Performance reports with statistical analysis
- Failure pattern analysis and recommendations

**Critical Constraints**:
- Never compromises safety (progressive discovery, automatic recovery, status checks)
- Never assumes unknown workspace limits (helps users discover them)
- Never fabricates robot arm commands or parameters
- Acknowledges when specific hardware details affect testing
- Uses accurate robotics terminology (workspace, home position, limit)
- Transparently states when limits are unknown

**Progressive Discovery Approach**:
Since workspace limits and safe parameters are often unknown:
1. Start Conservative - Use small movements from home position
2. Expand Systematically - Increase range gradually with status checks
3. Document Findings - Record discovered limits in configuration files
4. Warn Proactively - Alert when approaching unexplored areas
5. Build Confidence - Create safe zones based on validated movements

**Test Categories**:
1. **Movement Tests**: Single-axis, multi-axis, coordinated, speed variation
2. **Workspace Discovery**: Boundary exploration, safe zone mapping, limit detection
3. **Calibration Tests**: Home position, end-effector, coordinate transformation
4. **Performance Tests**: Speed, accuracy, repeatability, response time
5. **Recovery Tests**: Error handling, retry logic, escalation, safety validation
6. **Integration Tests**: Vision systems, conveyor belts, sensors, multi-device coordination
7. **Stress Tests**: Extended operation, thermal performance, power consumption
8. **Regression Tests**: Validate previous functionality after changes

**Pre-Defined Test Patterns**:
- `boundary-discovery`: Progressive workspace exploration
- `pick-place-basic`: Simple pick-and-place validation
- `pick-place-vision`: Vision-guided pick-and-place
- `speed-benchmark`: Movement speed testing
- `accuracy-test`: Position accuracy measurement
- `repeatability-test`: 100-cycle repeatability validation
- `calibration-verify`: Calibration sequence validation
- `recovery-test`: Error recovery validation
- `stress-test`: Extended operation reliability
- `integration-vision`: Vision system end-to-end testing
- `integration-conveyor`: Conveyor synchronization testing

**Example Usage**:

```bash
# Workspace boundary discovery
@agent-robotarm-tester: I just set up my robot arm. Help me discover
the workspace boundaries safely and create a configuration file.

# Pick-and-place validation
@agent-robotarm-tester: Test our pick-and-place sequence 50 times
and capture diagnostic data to identify failure patterns.

# Performance benchmarking
@agent-robotarm-tester: Benchmark my robot arm's performance
before production deployment. Test speed, accuracy, and repeatability.

# Vision integration
@agent-robotarm-tester: Test integration with our vision system.
Validate coordinate transformation and pick position accuracy.
```

**Quality Assurance**:
- 12 comprehensive test cases covering all capabilities
- Safety checks in all test sequences
- Automatic error recovery with intelligent retry
- Comprehensive diagnostic logging
- Statistical analysis for performance tests
- Configuration file generation
- Transparent uncertainty acknowledgment

**Advanced Features**:
- Vision system coordinate transformation testing
- Conveyor belt synchronization validation
- Multi-device coordination testing
- Custom test sequence definition (YAML)
- Thermal monitoring integration (if sensors available)
- Integration with external APIs and systems

**Configuration Management**:
Generates and maintains configuration files:
- `workspace-config.yml` - Discovered workspace limits and safe zones
- `calibration-config.yml` - Calibration parameters and offsets
- `performance-baseline.yml` - Baseline performance metrics
- `test-results-[timestamp].yml` - Complete test results

**Safety Guarantees**:
- Never commands movements without status verification
- Always implements automatic error recovery
- Warns when operating in unexplored workspace areas
- Uses conservative defaults until limits are validated
- Prioritizes safety over speed in all test sequences

**Integration with Knowledge Base**:
- References `.agent/system/` for robot arm specifications
- Documents test procedures in `.agent/sops/`
- Cross-references `.agent/tasks/` for integration requirements
- Creates SOPs after discovering test patterns

**Maintenance**:
- Quarterly validation of test patterns
- Update when robot arm hardware or software changes
- Incorporate team feedback on testing procedures
- Version control all test configurations

**Contact**: Agent Architecture Team

---

### 4. agent-git-manager

**Status**: Production Ready (v1.0.0)

**Category**: Developer Tools

**Description**:
Expert git repository manager specializing in secure commit workflows with mandatory pre-commit security scanning. Provides intelligent change detection, SSH/GitHub integration, and seamless coordination with documentation workflows.

**Location**: `/agents/agent-git-manager/`

**Files**:
- `.claude/agents/agent-git-manager.md` - Agent definition (Claude Code format)
- `README.md` - Detailed usage guide and trigger conditions
- `test-cases.md` - 10 comprehensive validation test cases
- `examples/` - Complete workflow examples

**Key Expertise**:
- Pre-commit security scanning (file patterns, content detection)
- Git operations (status, diff, add, commit, log, branch, push)
- SSH authentication handling and troubleshooting
- GitHub CLI integration (PR creation, status checks)
- Conventional commit message generation
- Documentation workflow coordination (update_doc integration)

**Core Capabilities**:
- Mandatory pre-commit security scanning for secrets and credentials
- Intelligent commit threshold detection (files, lines, critical files)
- SSH authentication verification and troubleshooting
- Safe push workflow with explicit confirmation
- Branch operations with awareness
- Integration with `/update_doc` command

**Trigger Conditions**:
- User wants to commit changes with security assurance
- User needs to push changes to a remote repository
- User wants to check repository status
- User completed documentation updates with `/update_doc`
- Hook system detects significant file changes
- User needs help with SSH authentication to GitHub

**Output Format**:
- Repository status summaries
- Security scan reports (files scanned, patterns checked, warnings, blocks)
- Conventional commit messages
- SSH diagnostic information
- Push operation previews

**Critical Constraints**:
- **Never** force push to any branch
- **Never** amend commits without explicit user request
- **Never** push to main/master without explicit confirmation
- **Never** commit files with detected secrets without explicit override
- **Always** run security scan before every commit
- **Always** show changes before committing
- **Always** require confirmation for push operations

**Security Scanning**:
Pre-commit scanning detects:

*File Patterns*:
- `.env`, `.env.*`, `*.env` - Environment files
- `*credentials*`, `*secret*`, `*password*` - Credential files
- `*.pem`, `*.key`, `*.p12`, `*.pfx` - Certificates and keys
- `id_rsa`, `id_ed25519`, `*.pub` - SSH keys

*Content Patterns*:
- API keys: `api_key`, `apikey`, `api_secret`
- AWS credentials: `AKIA...`, `aws_secret_access_key`
- GitHub tokens: `ghp_`, `gho_`, `ghu_`, `ghs_`, `ghr_`
- Generic secrets: `password=`, `secret=`, `token=`
- Private keys: `-----BEGIN.*PRIVATE KEY-----`
- Connection strings: `mysql://`, `postgres://`, `mongodb://`

**Example Usage**:

```bash
# Commit workflow
@agent-git-manager: Help me commit my changes

# Repository status
@agent-git-manager: What's the current git status?

# Push changes
@agent-git-manager: Push my commits to GitHub

# After documentation
@agent-git-manager: I just ran /update_doc, commit the changes

# SSH troubleshooting
@agent-git-manager: I can't push, getting permission denied
```

**Quality Assurance**:
- 10 comprehensive test cases covering all capabilities
- Security scanning in all commit workflows
- SSH authentication verification
- Safe push with explicit confirmation
- Transparent uncertainty acknowledgment
- Override mechanism for false positives

**Integration with update_doc**:
- Detects `.agent/` changes and suggests running `/update_doc`
- After `/update_doc` completes, offers to commit documentation changes
- Generates appropriate `docs:` commit messages

**Integration with Knowledge Base**:
- Detects changes in `.agent/` directory
- Suggests documentation updates before commits
- Coordinates with `/update_doc` command
- Generates documentation-aware commit messages

**Maintenance**:
- Quarterly security pattern updates
- Update when git/GitHub APIs change
- Incorporate team feedback on workflows
- Version control all agent configurations

**Contact**: Agent Architecture Team

---

### 5. agent-provisioner

**Status**: Production Ready (v1.0.0)

**Category**: Developer Tools

**Description**:
Expert agent provisioning specialist for syncing agents, commands, and hooks from the Agentic hub to other local projects. Enables safe deployment and updates with version awareness, interactive selection, and proper backup procedures.

**Location**: `/agents/agent-provisioner/`

**Files**:
- `.claude/agents/agent-provisioner.md` - Agent definition (Claude Code format)
- `README.md` - Detailed usage guide and trigger conditions
- `test-cases.md` - 12 validation test cases

**Key Expertise**:
- Agent definition management (`.claude/agents/*.md`)
- Command synchronization (`.claude/commands/*.md`)
- Hook configuration merging (`.claude/settings.local.json`)
- Version comparison (file modification dates)
- Safe file operations (backups, conflict resolution)

**Core Capabilities**:
- List all available agents from the hub
- Compare versions between hub and target project
- Interactive agent selection for sync
- Backup creation before overwriting
- Command and hook dependency management
- Hook merging with permission preservation

**Trigger Conditions**:
- User wants to list available agents in the hub
- User needs to compare agents with another project
- User wants to provision agents to a new project
- User needs to update agents in an existing project
- User asks to sync configurations to a target

**Output Format**:
- Formatted tables of agents with versions
- Comparison reports (New, Update, Up to date)
- Sync progress with confirmation prompts
- Backup notifications

**Critical Constraints**:
- **Always** creates backups before overwriting files
- **Always** requires user selection before syncing
- **Always** shows what will change before executing
- **Never** dumps all agents without asking
- **Never** replaces settings.local.json (merges hooks only)
- **Preserves** target's existing permissions

**Commands**:
```bash
# List available agents
@agent-provisioner: list

# Compare with target project
@agent-provisioner: compare /path/to/project

# Sync agents to target
@agent-provisioner: sync /path/to/project
```

**Agent-to-Dependency Map**:

| Agent | Commands | Hooks |
|-------|----------|-------|
| agent-git-manager | update_doc.md | PostToolUse: Edit\|Write\|NotebookEdit |
| agent-sap-bp-integration | - | - |
| agent-ansible-automation | - | - |
| agent-robotarm-tester | - | - |

**Example Usage**:

```bash
# List what's available
@agent-provisioner: list

# Check what needs updating
@agent-provisioner: compare /home/user/my-project

# Sync selected agents
@agent-provisioner: sync /home/user/my-project
# Then select: 1,3 (picks first and third agent)
```

**Quality Assurance**:
- 12 comprehensive test cases
- Interactive selection mandatory
- Backup verification
- Hook merge testing
- Permission preservation validation

**Maintenance**:
- Update when new agents are added to hub
- Keep dependency map current
- Version control agent configurations

**Contact**: Agent Architecture Team

---

### 6. agent-cv-optimizer

**Status**: Production Ready (v1.0.0)

**Category**: Career Development

**Description**:
Expert CV optimization specialist for Data & AI careers, combining career coaching, HR/recruitment expertise, and technical interview knowledge. Provides CV tailoring, interview preparation, and application tracking through three specialized modes.

**Location**: `/agents/agent-cv-optimizer/`

**Files**:
- `.claude/agents/agent-cv-optimizer.md` - Agent definition (Claude Code format)
- `README.md` - Detailed usage guide and trigger conditions
- `test-cases.md` - 12 comprehensive validation test cases
- `examples/` - Complete workflow examples

**Three Operating Modes**:

| Mode | Purpose | When Active |
|------|---------|-------------|
| Career Coach | Experience analysis, blindspot detection, positioning | Career questions, transitions |
| HR Manager | JD analysis, CV tailoring, cover letters | JD provided, tailoring requests |
| Interviewer | Company research, question prep, interview coaching | Interview mentioned |

**Key Expertise**:
- Data & AI career landscape and role variations
- ATS systems and keyword optimization
- RenderCV YAML format integration
- Technical interviewing (system design, coding, ML)
- Career positioning and narrative building
- Company research and culture fit assessment

**Core Capabilities**:
- JD Analysis & Keyword Extraction
- Skills Gap Analysis with match scores
- CV Tailoring for specific job descriptions
- Cover Letter Generation
- Application Tracker management
- Interview question generation
- Company research via web search

**Trigger Conditions**:
- User wants to tailor CV for a Data/AI job posting
- User needs career coaching for Data/AI roles
- User is preparing for a technical interview
- User wants to track multiple job applications
- User needs a cover letter for a specific role
- User wants skills gap analysis

**Output Format**:
- Keyword analysis tables
- Skills gap reports with match scores
- Tailored CV YAML files (RenderCV format)
- Cover letters in Markdown
- Interview preparation documents
- Application tracker in Markdown

**Directory Structure**:
```
applications/
├── tracker.md                    # Central status tracker
└── {company-name}/
    ├── jd.md                     # Job description
    ├── jd-analysis.md            # Keyword extraction
    ├── cv-{company}.yaml         # Tailored RenderCV
    ├── cover-letter.md           # Cover letter
    ├── interview-notes.md        # Interview prep
    └── research.md               # Company research
```

**Critical Constraints**:
- **Never** fabricates company information or skills
- **Never** invents experience not in user's background
- **Always** shows changes before applying
- **Always** preserves authenticity of achievements
- **Transparent** about match quality and fit
- **User control** - confirmation required for changes

**Agent Coordination**:

| Agent | When Used |
|-------|-----------|
| research-assistant | Deep company research, salary data |
| documentation-specialist | Cover letter polish, formatting |
| agent-git-manager | Version control of application materials |

**Example Usage**:

```bash
# Career coaching
@agent-cv-optimizer: I've been a backend developer for 5 years
and want to move into data engineering. What should I highlight?

# CV tailoring
@agent-cv-optimizer: Here's a JD for a Senior Data Engineer at Spotify.
Help me tailor my CV and write a cover letter.

# Interview prep
@agent-cv-optimizer: I have a system design interview at Meta
next week. Help me prepare.

# Application tracking
@agent-cv-optimizer: Add Google to my tracker - just applied today
```

**Quality Assurance**:
- 12 comprehensive test cases covering all modes
- Authenticity verification (no fabricated experience)
- User confirmation before changes
- Match score accuracy validation
- Directory structure verification

**RenderCV Integration**:
- Detects base CV files (`*_CV.yaml`) in working directory
- Creates tailored variants for each application
- Preserves design settings while modifying content
- Supports all RenderCV section types

**Maintenance**:
- Quarterly Data/AI market trend review
- Update interview patterns as companies change
- Incorporate user feedback on effectiveness
- Version control all agent configurations

**Contact**: Agent Architecture Team

---

### 7. agent-project-init

**Status**: Production Ready (v1.0.0)

**Category**: Developer Tools

**Description**:
Project Initialization Specialist that sets up new projects with type-appropriate structure, documentation, and provisioned agents. Applies learnings from cross-project testimony analysis to create optimized project setups.

**Location**: `.claude/agents/agent-project-init.md`

**Command**: `/project_init`

**Key Expertise**:
- Project type classification (Integration, Development, Research, Optimization)
- Type-appropriate .agent/ folder structures
- CLAUDE.md and README.md generation
- Agent and command provisioning from Agentic hub
- Existing file detection and safe modification

**Project Types**:

| Type | Description | Folders Created |
|------|-------------|-----------------|
| Integration | APIs, data flows, sync | sops/, system/, workflows/ |
| Development | Building software | decisions/, schemas/, testing/ |
| Research | Exploration, learning | findings/, hypotheses/, gaps/ |
| Optimization | Improving existing | templates/, metrics/, experiments/ |
| Custom | User-defined | User selects |

**Default Provisions**:
- **Agents**: research-assistant, documentation-specialist, agent-git-manager
- **Commands**: update_doc, agent_reflect

**7-Step Workflow**:
1. **DISCOVER** - Check existing files (README.md, CLAUDE.md, .agent/)
2. **CLASSIFY** - Ask project type
3. **DEFINE** - Gather name, goals, resources, constraints
4. **STRUCTURE** - Create .agent/ with type-appropriate folders
5. **DOCUMENT** - Generate CLAUDE.md and README.md
6. **PROVISION** - Sync agents from hub
7. **CONFIRM** - Execute after user approval

**Trigger Conditions**:
- User runs `/project_init` command
- User wants to start a new project
- User wants to convert existing directory to agent-enabled project
- User asks about project setup or initialization

**Critical Constraints**:
- **Never overwrites** existing files without showing changes first
- **Never modifies** .agent/ without user confirmation
- **Always shows** summary before execution
- Creates only folders that will be used (no empty templates)
- injection-history.md is always created (100% usage in analyzed projects)

**Design Principles** (from testimony analysis):
- Descriptive over prescriptive
- No empty templates
- Verification mindset
- Default sensible, allow override

**Example Usage**:

```bash
# Initialize current directory
/project_init

# Initialize specific path
/project_init /home/user/my-new-project
```

**Quality Assurance**:
- Verifies hub agents exist before provisioning
- Creates backups before modifying existing files
- Reports any provisioning failures clearly
- Validates target path permissions

**Contact**: Agent Architecture Team

---

### 8. agent-optimizer

**Status**: Production Ready (v1.0.0)

**Category**: Developer Tools

**Description**:
Agent Optimization Specialist that analyzes existing agents using structural analysis and telemetry data from cross-project usage to improve token efficiency and answer quality while maintaining 100% test pass rate.

**Location**: `.claude/agents/agent-optimizer.md`

**Command**: `/optimize`

**Key Expertise**:
- Agent token usage measurement and estimation
- Telemetry data interpretation (usage patterns, error rates)
- Proven optimization patterns (template externalization, lazy loading)
- Quality gate enforcement (100% test pass, constraint preservation)
- Cross-project insights from reflection_pool
- Time-series metrics tracking

**5-Phase Workflow**:
1. **MEASURE** - Capture structural + telemetry metrics
2. **ANALYZE** - Apply proven patterns from reflection_pool
3. **RECOMMEND** - Generate optimization plan with estimates
4. **VALIDATE** - Enforce quality gates
5. **TRACK** - Record before/after metrics for time-series

**Optimization Patterns**:

| Pattern | Expected Reduction | When to Apply |
|---------|-------------------|---------------|
| Template Externalization | 51-65% | Embedded content > 100 words |
| Lazy Loading | 5% overhead | Templates loaded unconditionally |
| Output Modes | Control | No verbosity options |
| Section Compression | 15-30% | Similar agent is smaller |

**Quality Gates**:
- QG-1: 100% test pass rate maintained
- QG-2: No fabrication constraints removed
- QG-3: Uncertainty acknowledgment preserved
- QG-4: All referenced templates exist
- QG-5: Critical constraints intact

**Data Sources**:
- `.agent/metrics/` - Token usage, optimization logs
- `.agent/telemetry/` - Cross-project usage data
- `.agent/reflection_pool/` - Proven patterns and insights

**Trigger Conditions**:
- User wants to analyze agents for optimization
- User wants to apply proven patterns to agents
- User wants to track token efficiency over time
- User runs `/optimize` command

**Example Usage**:

```bash
# Analyze all agents
/optimize

# Optimize specific agent
/optimize agent-git-manager

# View hub-wide status
/optimize status

# Preview without recording
/optimize --dry-run
```

**Critical Constraints**:
- **Never applies** optimizations without quality gate validation
- **Never removes** fabrication prevention constraints
- **Always preserves** uncertainty acknowledgment
- **Always records** before/after metrics
- Uses only proven patterns from testimony analysis

**Documentation**:
- User Guide: `agents/agent-optimizer/README.md`
- Test Cases: `agents/agent-optimizer/test-cases.md`

**Contact**: Agent Architecture Team

---

## Repository Structure

```
/.claude/agents/
  agent-ansible-automation.md          # Ansible automation agent definition
  agent-sap-businesspartner-integration.md  # SAP BP integration agent
  agent-robotarm-tester.md             # Robot arm testing agent definition
  agent-git-manager.md                 # Git repository manager agent definition
  agent-provisioner.md                 # Agent provisioning agent definition
  agent-cv-optimizer.md                # CV optimization agent definition
  agent-project-init.md               # Project initialization agent definition
  agent-optimizer.md                  # Agent optimization specialist definition

/agents/
  /agent-sap-businesspartner-integration/
    agent.yml                  # Agent configuration
    system-prompt.md           # Complete system prompt
    README.md                  # Usage guide and trigger conditions
    test-cases.md             # 6 validation test cases
    examples/                 # Example outputs
      - example-create-flow.md
      - example-patch-vs-put.md
      - example-error-handling.md

  /agent-ansible-automation/
    README.md                  # Usage guide and trigger conditions
    test-cases.md             # 12 validation test cases
    examples/                 # Example implementations
      - webserver-role-example.md
      - playbook-example.md
      - molecule-test-example.md

  /agent-robotarm-tester/
    README.md                  # Usage guide and trigger conditions
    test-cases.md             # 12 validation test cases
    examples/                 # Example test workflows
      - workspace-discovery-example.md
      - pick-place-validation-example.md
      - performance-benchmark-example.md

  /agent-git-manager/
    README.md                  # Usage guide and trigger conditions
    test-cases.md             # 10 validation test cases
    examples/                 # Example workflows
      - commit-workflow-example.md
      - security-scan-example.md
      - ssh-github-example.md
      - documentation-workflow-example.md

  /agent-provisioner/
    README.md                  # Usage guide and trigger conditions
    test-cases.md             # 12 validation test cases

  /agent-cv-optimizer/
    README.md                  # Usage guide and trigger conditions
    test-cases.md             # 12 validation test cases
    examples/                 # Example workflows
      - jd-analysis-example.md
      - cv-tailoring-example.md
      - interview-prep-example.md
      - tracker-example.md

  /agent-optimizer/
    README.md                  # Usage guide and trigger conditions
    test-cases.md             # 12 validation test cases
    examples/                 # Example workflows (optional)

/docs/sap-integration/businesspartner/
  # Generated documentation by agents
  - bp-create-flow.md
  - bp-update-patterns.md
  - bp-sub-entities.md
  - bp-error-handling.md
  - bp-best-practices.md

AGENTS_REGISTRY.md             # This file - central registry
AGENTS_REPOSITORY_GUIDE.md     # Guide for creating new agents
```

---

## How to Use This Registry

### 1. Finding the Right Agent

Use the Quick Reference table or search by:
- **Domain**: What area does the agent specialize in?
- **Status**: Is the agent production-ready?
- **Use Case**: What problem are you trying to solve?

### 2. Invoking an Agent

```bash
# Syntax
@agent-<id>: [Your request]

# Example
@agent-sap-businesspartner-integration: Document the create flow
for BusinessPartner with address and tax numbers
```

### 3. Integration in CLAUDE.md

Reference agents in your project's CLAUDE.md:

```yaml
agents:
  - id: agent-sap-businesspartner-integration
    trigger: "When documenting BusinessPartner OData API integrations"
    scope: "Creating procedures, best practices, error handling guides"
```

### 4. Validation

Before using agent outputs:
- Review generated documentation for accuracy
- Verify SAP API endpoints match your target version
- Test procedures in a sandbox environment
- Validate against SAP API Business Hub

---

## Agent Creation Workflow

For creating new agents, follow this process:

1. **Requirements Analysis**: Clarify domain, scope, and use cases
2. **Specification Design**: Create comprehensive agent specification
3. **System Prompt Development**: Write detailed system prompt
4. **Configuration**: Create agent configuration files
5. **Testing**: Implement and run validation test cases
6. **Documentation**: Create README and usage guide
7. **Registry Entry**: Add to AGENTS_REGISTRY.md
8. **Deployment**: Move to production and update CLAUDE.md

See `AGENTS_REPOSITORY_GUIDE.md` for detailed process.

---

## Agent Roadmap

### Current (Q1 2026)
- [x] `agent-sap-businesspartner-integration` (v1.0.0) - Production
- [x] `agent-ansible-automation` (v1.0.0) - Production
- [x] `agent-robotarm-tester` (v1.0.0) - Production
- [x] `agent-git-manager` (v1.0.0) - Production
- [x] `agent-provisioner` (v1.0.0) - Production
- [x] `agent-cv-optimizer` (v1.0.0) - Production

### Planned

Potential future agents for this repository:

- `agent-sap-code-reviewer` - Code review for SAP ABAP
- `agent-sap-api-testing` - Test case generation for SAP OData APIs
- `agent-sap-architecture-designer` - SAP integration architecture
- `agent-data-pipeline-builder` - ETL/ELT pipeline documentation
- `agent-security-auditor` - Security review for integrations
- `agent-performance-analyzer` - Integration performance optimization

---

## Best Practices

### For Agent Users

✅ **Do**:
- Read agent README before using
- Verify outputs in sandbox before production use
- Report inaccuracies to Agent Architecture Team
- Use agents proactively when relevant to your task

❌ **Don't**:
- Assume agent outputs are production-ready without review
- Ignore agent limitations and uncertainties
- Use agents for purposes outside their defined scope
- Bypass validation and testing

### For Agent Maintainers

✅ **Do**:
- Keep system prompts accurate and up-to-date
- Test agents quarterly
- Document limitations transparently
- Incorporate team feedback
- Version control all agent files

❌ **Don't**:
- Fabricate functionality
- Include proprietary content verbatim
- Make unsupported claims about accuracy
- Skip validation test cases
- Leave uncertainties undocumented

---

## Quality Standards

All agents in this registry meet these standards:

| Criterion | Requirement | Validation |
|-----------|-------------|-----------|
| **Accuracy** | No fabricated functionality | Spec review + spot-checking |
| **Transparency** | Clear limitations | System prompt review |
| **Completeness** | Full scope coverage | Test case validation |
| **Usability** | Actionable outputs | Team feedback |
| **Professional** | Proper terminology | Domain expert review |
| **Maintainable** | Clear documentation | Spec + README clarity |

---

## Support & Feedback

### Reporting Issues

Found an issue with an agent?

1. **Verify** the issue is reproducible
2. **Document** the specific request and unexpected behavior
3. **Check** if it's agent behavior or expected limitation
4. **Report** to Agent Architecture Team with details

### Requesting New Agents

Want an agent for a specific domain?

1. **Describe** the problem you're trying to solve
2. **Define** the scope and key capabilities needed
3. **Identify** success criteria and expected outputs
4. **Submit** request to Agent Architecture Team

### Contributing

Agents are maintained by the Agent Architecture Team. To contribute:

1. Suggest improvements with specific examples
2. Test agent outputs in your workflows
3. Provide feedback on accuracy and usability
4. Report issues or gaps discovered

---

## Administration

### Version Control

All agent files are version-controlled:
- Agent configurations versioned with semantic versioning
- System prompts updated when APIs/standards change
- Test cases maintained alongside agent specs
- AGENTS_REGISTRY.md updated with each new agent

### Release Process

1. Agent specification approved
2. System prompt reviewed
3. Test cases pass validation
4. Documentation complete
5. AGENTS_REGISTRY.md updated
6. Deployment to production

### Deprecation

Agents may be deprecated if:
- Core domain is no longer relevant
- API or standard significantly changes
- Replacement agent provides better functionality
- Maintenance burden exceeds value

Deprecation process:
1. Announce 60-day deprecation window
2. Document replacement strategy
3. Update registry with migration guide
4. Archive agent after deprecation window

---

## Related Documents

- `AGENTS_REPOSITORY_GUIDE.md` - Step-by-step guide for creating new agents
- `CLAUDE.md` - Project-specific agent configuration
- `agents/agent-sap-businesspartner-integration/README.md` - Agent-specific guide

---

**Registry Version**: 1.3.0
**Last Updated**: 2026-01-18
**Maintained By**: Agent Architecture Team
**Status**: Active
