# SECURITY POLICY

## SUPPORTED VERSIONS
The VMDB_OSS project currently supports security updates and issue handling for
the latest stable release of the database schema and associated SQL components.

Security-related modifications are accepted for:

- Schema definitions
- Stored procedures
- Views and subqueries
- Documentation describing vulnerability handling

Older versions may continue to work but are not actively maintained.

## REPORTING A VULNERABILITY
If you discover a security vulnerability, please report it responsibly.

To report an issue:

1. Contact the project maintainer directly:
   - Name: Ashwin Chhawaniya
   - Email: ashwinchhawaniya2@gmail.com

2. Provide a detailed description including:
   - Affected SQL components (tables, procedures, views, triggers)
   - Steps to reproduce the issue
   - Potential impact on data integrity or confidentiality
   - Suggested remediation, if applicable

3. Please allow reasonable time for investigation and resolution before
public disclosure.

## DISCLOSURE POLICY
- Valid reports will receive acknowledgment within 72 hours.
- Security fixes will be applied in the next scheduled update.
- Critical issues may result in a hotfix release.
- Researchers will be credited unless anonymity is requested.

## BEST PRACTICES FOR USERS
- Maintain database backups before testing changes.
- Do not expose the database to untrusted networks.
- Restrict write access to authorized users only.
- Review stored procedures before deployment in production.
