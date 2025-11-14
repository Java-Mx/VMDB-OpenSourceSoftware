-- ============================================
-- VMDB_OSS: Vulnerability Management Database
-- Version: 1.1
-- Author: Ashwin Chhawaniya
-- Date: November 2025
-- Description: Analytical views for vulnerability tracking
-- ============================================

USE VMDB_OSS;

CREATE VIEW vw_all_vulnerabilities AS
SELECT 
    v.vuln_id,
    v.cve_id,
    p.package_name,
    v.severity,
    v.status,
    v.published_date
FROM Vulnerabilities v
JOIN Packages p ON v.package_id = p.package_id;

CREATE VIEW vw_project_vulnerabilities AS
SELECT 
    pr.project_name,
    pk.package_name,
    v.cve_id,
    v.severity,
    r.status AS remediation_status
FROM Projects pr
JOIN Project_Packages pp ON pr.project_id = pp.project_id
JOIN Packages pk ON pp.package_id = pk.package_id
JOIN Vulnerabilities v ON v.package_id = pk.package_id
LEFT JOIN Remediations r ON r.project_id = pr.project_id AND r.vuln_id = v.vuln_id;

CREATE VIEW vw_project_package_usage AS
SELECT 
    pr.project_name,
    pk.package_name,
    pp.version_used,
    pp.last_scanned
FROM Projects pr
JOIN Project_Packages pp ON pr.project_id = pp.project_id
JOIN Packages pk ON pk.package_id = pp.package_id;

CREATE VIEW vw_package_vuln_count AS
SELECT 
    pk.package_name,
    COUNT(v.vuln_id) AS vulnerability_count
FROM Packages pk
LEFT JOIN Vulnerabilities v ON pk.package_id = v.package_id
GROUP BY pk.package_name;

CREATE VIEW vw_remediation_progress AS
SELECT
    SUM(status='Resolved') AS resolved_total,
    SUM(status='In Progress') AS inprogress_total,
    SUM(status='Pending') AS pending_total
FROM Remediations;

CREATE VIEW vw_critical_vulnerabilities AS
SELECT 
    v.cve_id,
    p.package_name,
    v.summary,
    v.severity,
    v.status
FROM Vulnerabilities v
JOIN Packages p ON v.package_id = p.package_id
WHERE v.severity = 'Critical';
