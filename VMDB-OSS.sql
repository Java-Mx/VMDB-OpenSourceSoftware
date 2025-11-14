-- ============================================
-- VMDB_OSS: Vulnerability Management Database
-- Version: 1.1
-- Author: Ashwin Chhawaniya
-- Date: November 2025
-- Description: MySQL schema for open-source vulnerability tracking
-- ============================================

CREATE DATABASE VMDB_OSS;
USE VMDB_OSS;


CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role ENUM('Admin','Maintainer','Analyst') DEFAULT 'Maintainer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    repo_url VARCHAR(255),
    maintainer_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (maintainer_id) REFERENCES Users(user_id)
);


CREATE TABLE Packages (
    package_id INT AUTO_INCREMENT PRIMARY KEY,
    package_name VARCHAR(100) NOT NULL,
    ecosystem ENUM('npm','PyPI','Maven','Go','RubyGems','Other') DEFAULT 'Other',
    latest_version VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Vulnerabilities (
    vuln_id INT AUTO_INCREMENT PRIMARY KEY,
    cve_id VARCHAR(50) UNIQUE,
    package_id INT,
    summary TEXT,
    severity ENUM('Low','Medium','High','Critical'),
    cvss_score DECIMAL(3,1),
    published_date DATE,
    status ENUM('Open','In Progress','Resolved') DEFAULT 'Open',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (package_id) REFERENCES Packages(package_id)
);


CREATE TABLE Project_Packages (
    projpkg_id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT,
    package_id INT,
    version_used VARCHAR(50),
    last_scanned DATE,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id),
    FOREIGN KEY (package_id) REFERENCES Packages(package_id)
);


CREATE TABLE Remediations (
    remediation_id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT,
    vuln_id INT,
    fixed_version VARCHAR(50),
    status ENUM('Pending','In Progress','Resolved') DEFAULT 'Pending',
    date_applied DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id),
    FOREIGN KEY (vuln_id) REFERENCES Vulnerabilities(vuln_id)
);


CREATE TABLE Audit_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(255),
    details TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
