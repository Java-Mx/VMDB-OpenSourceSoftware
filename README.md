# VMDB_OSS: Vulnerability Management Database for Open-Source Software

A Structured, Relational Model for Software Supply Chain Security

## Overview

VMDB_OSS is a normalized MySQL-based database system designed to model, store, and analyze security vulnerabilities across open-source software ecosystems. It captures the relationships between projects, packages, CVEs, remediation efforts, and user-driven audit activity, providing a transparent, educational, and operational foundation for vulnerability tracking.

This project is intentionally built to mirror the design discipline taught in MIT database engineering and cybersecurity courses—simple, relational, auditable, and extensible.

### Why VMDB_OSS

- **Educational Foundation**: Built specifically for teaching database design, normalization theory, and practical SQL operations in a security context
- **Real-World Applicability**: Models actual vulnerability management workflows used in enterprise security operations centers
- **Research Ready**: Provides a clean, extensible schema for academic research in software supply chain security
- **Production Principles**: Demonstrates industry best practices for data integrity, audit trails, and operational procedures
- **Minimal Dependencies**: Pure MySQL implementation requires no additional frameworks or external dependencies


## Features

- Third-Normal-Form (3NF) relational schema
- Fully enforced referential integrity through FOREIGN KEYS
- Clean ENUM-driven status tracking
- Realistic, coherent dataset (10 rows per table)
- Analytics-ready SQL VIEW layer
- Operational STORED PROCEDURE layer (Add, Update, Remediate)
- Rich set of example queries and subqueries
- Minimal, portable MySQL-only design
- Suitable for coursework, research prototyping, security analysis, and teaching

### Technical Highlights

- **Constraint-Driven Design**: Uses CHECK constraints and ENUMs to maintain data quality at the database level
- **Temporal Tracking**: Comprehensive timestamp fields enable historical analysis and audit compliance
- **Modular Architecture**: Clear separation between entities and relationships supports future schema evolution
- **Query Performance**: Properly indexed foreign keys and optimized views ensure fast analytical queries
- **Transaction Safety**: All stored procedures use proper transaction boundaries for data consistency


## Project Goals

- Provide a transparent, educational model for understanding software supply chain security
- Track vulnerabilities end-to-end, from discovery to remediation
- Enable instructors and students to demonstrate JOINs, subqueries, views, and stored procedures
- Enable maintainers and analysts to assess project risk using structured relational data
- Serve as a foundation for UI dashboards, automation agents, or ingestion scripts (future extensions)

### Academic Applications

- **Database Courses**: Demonstrates normalization, indexing strategies, and complex query optimization
- **Cybersecurity Programs**: Provides hands-on experience with vulnerability tracking and risk assessment
- **Software Engineering**: Illustrates dependency management and software supply chain concepts
- **Data Analytics**: Enables practice with aggregation, windowing functions, and reporting queries

### Professional Applications

- **Security Teams**: Jump-start internal vulnerability management database implementations
- **DevSecOps**: Foundation for integrating security scanning into CI/CD pipelines
- **Compliance**: Track remediation efforts for audit and regulatory requirements
- **Risk Management**: Quantify and prioritize security debt across project portfolios


## Data Model

VMDB_OSS consists of seven core tables organized into two categories:

### Entity Tables

**Users** — Identity and role metadata

- Stores user credentials, roles (Admin, Analyst, Maintainer, Auditor), and organizational affiliation
- Enables role-based access control patterns in future extensions
- Tracks who performs actions throughout the system

**Projects** — Open-source or internal codebases

- Represents distinct software projects being monitored
- Links to maintainer users and tracks repository metadata
- Serves as the primary aggregation point for vulnerability reporting

**Packages** — OSS components with ecosystems (npm, PyPI, Maven, etc.)

- Catalogs third-party dependencies across multiple package ecosystems
- Stores version information and external references (GitHub, package registries)
- Enables ecosystem-specific analysis and trending

**Vulnerabilities** — CVEs and non-CVE security issues

- Maintains comprehensive vulnerability information including CVE identifiers
- Tracks severity levels (Critical, High, Medium, Low, Informational)
- Stores CVSS scores and detailed descriptions for risk assessment

### Relation and Junction Tables

**Project_Packages** — M:N mapping of projects to packages

- Resolves the many-to-many relationship between projects and their dependencies
- Tracks specific package versions used in each project
- Records when dependencies were added for temporal analysis

**Remediations** — Fix records linking vulnerabilities to project-specific actions

- Documents remediation efforts including patches, workarounds, and upgrades
- Tracks remediation status (Pending, In Progress, Completed, Failed)
- Links specific vulnerabilities to projects and responsible users

**Audit_Log** — Accountability layer tracking user actions

- Maintains comprehensive audit trail of all system modifications
- Records user actions, affected entities, and timestamps
- Supports compliance requirements and incident investigation

Each table uses simple, intentional structure (INT, VARCHAR, ENUM, DATE, TIMESTAMP) to maintain clarity and reproducibility.

## Relational Design Principles

**Third Normal Form (3NF)** — Eliminates redundancy, update anomalies, and inconsistencies

- Every non-key attribute depends on the key, the whole key, and nothing but the key
- Prevents data duplication and maintains consistency across updates
- Simplifies maintenance and reduces storage overhead

**Foreign Keys** — Maintains strict referential integrity across all entity relationships

- Cascading deletes prevent orphaned records
- Enforces valid references between related entities
- Provides automatic index creation for join performance

**ENUM Constraints** — Controls domain values for roles, severity, remediation states, and ecosystems

- Guarantees valid values at the database level
- Self-documenting schema with explicit allowed values
- Prevents application-layer validation errors

**Time-Based Fields** — TIMESTAMP and DATE capture historical context for audits and scans

- Automatic timestamp updates for modification tracking
- Enables time-series analysis of vulnerability trends
- Supports audit compliance and incident response

**Separation of Concerns** — Entity tables store nouns; relation tables store verbs

- Clear distinction between what things are and how they relate
- Supports flexible querying patterns
- Enables independent evolution of entities and relationships

### Normalization Benefits

- **Data Integrity**: Single source of truth for each fact eliminates conflicting information
- **Update Efficiency**: Changes to shared data require modification in only one location
- **Query Flexibility**: Well-normalized schemas support unanticipated query patterns
- **Storage Optimization**: Elimination of redundancy reduces database size and backup time

## Installation

### Requirements

- MySQL Server 8.0+
- MySQL Workbench / DBeaver / CLI client
- CREATE DATABASE privileges

### Setup

Run the provided SQL script:

```bash
mysql -u <user> -p < vmdb_oss_full.sql
```

The script performs:

- Database creation
- Table definitions
- Foreign-key establishment
- Sample data insertion (10 rows per table)
- View creation
- Stored procedure creation

### Post-Installation Verification

After running the installation script, verify the database structure:

- **Table Count**: Should show 7 core tables (Users, Projects, Packages, Vulnerabilities, Project_Packages, Remediations, Audit_Log)
- **Row Counts**: Each table should contain exactly 10 sample records
- **View Count**: Should show 7+ analytical views
- **Procedure Count**: Should show 3 operational stored procedures
- **Foreign Keys**: All relationship tables should have properly defined foreign key constraints

## Usage

### Verify Installation

```sql
USE VMDB_OSS;
SELECT * FROM Users;
SELECT * FROM Packages;
SELECT * FROM vw_project_vulnerabilities;
SELECT * FROM vw_remediation_progress;
```

### Run a Stored Procedure

```sql
CALL AddVulnerabilitySimple(
    'CVE-2025-55555', 
    2, 
    'Example new vulnerability...', 
    'High', 
    7.8
);
```

### Typical Analysis Queries

- Identify vulnerable projects
- Count unresolved vulnerabilities
- Compute package risk trends
- Generate management dashboards
- Track remediation progress over time

### Advanced Query Patterns

- **Aggregation Queries**: Count vulnerabilities by severity, ecosystem, or project
- **Temporal Analysis**: Track vulnerability introduction and remediation over time
- **Risk Scoring**: Calculate project risk based on vulnerability count and severity
- **Dependency Analysis**: Identify packages used across multiple projects
- **Performance Tracking**: Measure mean time to remediation by team or project

## View Layer

The analytic layer includes, but is not limited to:

- `vw_package_vuln_count`
- `vw_project_risk_level`
- `vw_project_package_usage`
- `vw_recent_vulnerabilities`
- `vw_severity_distribution`
- `vw_remediation_progress`
- `vw_project_maintainers`

These views abstract JOIN logic and support BI dashboards or application integrations.

### View Design Philosophy

- **Abstraction**: Hide complex JOIN operations behind simple SELECT statements
- **Performance**: Pre-defined views can be indexed and optimized by the query planner
- **Consistency**: Standardize business logic calculations across all applications
- **Simplicity**: Enable non-technical stakeholders to query data without writing SQL
- **Reusability**: Common analytical patterns become reusable components

### Sample View Use Cases

- **Executive Dashboards**: `vw_severity_distribution` provides quick risk overview for leadership
- **Team Metrics**: `vw_remediation_progress` tracks security team performance
- **Dependency Audits**: `vw_project_package_usage` identifies widespread vulnerable dependencies
- **Alert Systems**: `vw_recent_vulnerabilities` powers notification systems for new threats
- **Compliance Reports**: `vw_project_risk_level` generates risk assessments for auditors

## Stored Procedures

Clean, minimal operational procedures:

- `AddVulnerabilitySimple`
- `UpdateVulnerabilityStatus`
- `AddRemediation`

All procedures enforce business rules and standardize system operations.

### Procedure Design Benefits

- **Encapsulation**: Complex business logic hidden behind simple interfaces
- **Validation**: Input parameters validated before database modifications
- **Atomicity**: Operations wrapped in transactions ensure all-or-nothing execution
- **Auditing**: Automatic audit log entries for all state changes
- **Consistency**: Standardized operations prevent ad-hoc SQL errors

### When to Use Procedures

- **Batch Operations**: Processing multiple related records atomically
- **Complex Validation**: Business rules too complex for CHECK constraints
- **Audit Requirements**: Operations requiring automatic audit trail generation
- **Performance**: Reducing round-trips for multi-step operations
- **Security**: Limiting direct table access while providing controlled operations

## Example Workflows

### Daily Scan Ingestion

1. Add new package version
2. Insert or update Project_Packages
3. Insert vulnerability via procedure
4. Create remediation record
5. Log audit entry

This workflow demonstrates how external vulnerability scanners can integrate with VMDB_OSS:

- **Scanner Output**: Parse tool output (e.g., npm audit, OWASP Dependency-Check)
- **Package Resolution**: Match detected packages to database records or create new entries
- **Version Tracking**: Update Project_Packages with detected versions
- **Vulnerability Creation**: Use AddVulnerabilitySimple for new CVEs
- **Notification**: Query views to generate alerts for critical findings

### Patch Lifecycle

1. Analyst identifies a fix
2. Maintainer updates dependency
3. Procedure updates remediation status
4. Audit entry created
5. Vulnerability disappears from active dashboards

This workflow tracks the complete remediation process:

- **Discovery**: Analyst reviews vw_project_vulnerabilities for actionable items
- **Assignment**: Remediation record created and assigned to maintainer
- **Implementation**: Maintainer upgrades package version in project
- **Verification**: UpdateVulnerabilityStatus marks remediation as completed
- **Reporting**: Audit_Log provides compliance evidence of fix timeline

### Management Reporting

1. Query severity distribution
2. View unresolved "Critical" issues
3. List maintainers with highest open risk
4. Examine remediation throughput

This workflow supports executive decision-making:

- **Risk Overview**: Aggregate views show organization-wide vulnerability posture
- **Priority Setting**: Critical and High severity issues identified for immediate action
- **Resource Allocation**: Maintainer workload analysis informs staffing decisions
- **Performance Metrics**: Historical remediation data tracks security team effectiveness

### Compliance Audit

1. Generate historical audit reports from Audit_Log
2. Demonstrate remediation timeline for specific CVEs
3. Show evidence of proper access controls and user accountability
4. Export data for external auditor review

This workflow satisfies regulatory requirements:

- **Traceability**: Every change tracked with user, timestamp, and action type
- **Evidence**: Audit_Log provides immutable record for compliance officers
- **Reporting**: Views and queries generate required compliance documentation
- **Access Control**: User roles and audit trails demonstrate proper governance

## Future Extensions

- Automated ingestion from NVD / OSV
- SBOM (CycloneDX / SPDX) import and parsing
- Risk scoring model integration
- Web-based dashboard (Flask / FastAPI / React)
- GitHub integration (Dependabot, CI pipelines)
- Multi-tenant model for organization-level data segregation
- RBAC and row-level permissions
- Docker and CI/CD deployment pipelines

### Automation Opportunities

- **API Integrations**: Connect to National Vulnerability Database (NVD) for automatic CVE updates
- **Scanner Plugins**: Direct integration with SAST/DAST/SCA scanning tools
- **Webhook Notifications**: Real-time alerts when critical vulnerabilities detected
- **Scheduled Reports**: Automated weekly/monthly security posture summaries
- **Dependency Updates**: Automatic remediation record creation when packages updated

### Scalability Enhancements

- **Read Replicas**: Deploy read-only database copies for reporting workloads
- **Partitioning**: Time-based partitioning of Audit_Log and Vulnerabilities tables
- **Caching Layer**: Redis integration for frequently accessed analytical queries
- **Batch Processing**: Queue-based ingestion for high-volume vulnerability feeds
- **Archival Strategy**: Move historical data to cold storage after defined retention period

### User Experience Improvements

- **Web Dashboard**: Interactive visualizations of vulnerability trends and remediation progress
- **Mobile App**: On-the-go access for security analysts and maintainers
- **Notification System**: Email/Slack alerts for newly discovered critical vulnerabilities
- **Search Interface**: Full-text search across vulnerability descriptions and remediation notes
- **Export Functions**: Generate PDF/CSV reports for stakeholder distribution

## License

This project is provided under an open academic license style. You may use, modify, or extend this work for educational, research, or organizational purposes.

## Citation

If you use VMDB_OSS in coursework, research, or teaching materials, please cite:

```
Ashwin Chhawaniya (2025).
VMDB_OSS: Vulnerability Management Database for Open-Source Software.
```
## Contact

For issues, enhancements, or academic collaboration:

**Author:** Ashwin Chhawaniya  
**Version:** 1.1  
**Date:** November 2025
