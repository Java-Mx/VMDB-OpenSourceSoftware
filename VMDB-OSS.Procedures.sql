-- ============================================
-- VMDB_OSS: Vulnerability Management Database
-- Version: 1.1
-- Author: Ashwin Chhawaniya
-- Date: November 2025
-- Description: Stored procedures and functions
-- ============================================

USE VMDB_OSS;

DELIMITER //
CREATE PROCEDURE AddVulnerabilitySimple(
    IN p_cve VARCHAR(50),
    IN p_package_id INT,
    IN p_summary TEXT,
    IN p_severity ENUM('Low','Medium','High','Critical'),
    IN p_cvss DECIMAL(3,1)
)
BEGIN
    INSERT INTO Vulnerabilities (
        cve_id, package_id, summary, severity, cvss_score, published_date
    ) VALUES (
        p_cve, p_package_id, p_summary, p_severity, p_cvss, CURDATE()
    );
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE UpdateVulnerabilityStatus(
    IN p_vuln_id INT,
    IN p_status ENUM('Open','In Progress','Resolved')
)
BEGIN
    UPDATE Vulnerabilities
    SET status = p_status
    WHERE vuln_id = p_vuln_id;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION CountVulnsForPackage(p_package INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Vulnerabilities
    WHERE package_id = p_package;
    RETURN total;
END //
DELIMITER ;
