/* Backup raw table before cleaning */
CREATE TABLE hr_employees_backup
AS SELECT * FROM hr_employees;

-- Confirm backup
SELECT COUNT(*) FROM hr_employees_backup


-- Total row count
SELECT COUNT(*) AS total_rows FROM hr_employees;


-- Check missing values across all columns
SELECT
    COUNT(*) - COUNT(Employee_Name) AS missing_employee_name,
    COUNT(*) - COUNT(EmpID) AS missing_empid,
    COUNT(*) - COUNT(PayRate) AS missing_payrate,
    COUNT(*) - COUNT(Position) AS missing_position,
    COUNT(*) - COUNT(DOB) AS missing_dob,
    COUNT(*) - COUNT(Sex) AS missing_sex,
    COUNT(*) - COUNT(MaritalDesc) AS missing_marital,
    COUNT(*) - COUNT(CitizenDesc) AS missing_citizen,
    COUNT(*) - COUNT(HispanicLatino) AS missing_hispanic,
    COUNT(*) - COUNT(RaceDesc) AS missing_race,
    COUNT(*) - COUNT(DateofHire) AS missing_hire_date,
    COUNT(*) - COUNT(DateofTermination) AS missing_termination_date,
    COUNT(*) - COUNT(TermReason) AS missing_term_reason,
    COUNT(*) - COUNT(EmploymentStatus) AS missing_emp_status,
    COUNT(*) - COUNT(Department) AS missing_department,
    COUNT(*) - COUNT(ManagerName) AS missing_manager,
    COUNT(*) - COUNT(RecruitmentSource) AS missing_recruitment,
    COUNT(*) - COUNT(PerformanceScore) AS missing_performance,
    COUNT(*) - COUNT(EngagementSurvey) AS missing_engagement,
    COUNT(*) - COUNT(EmpSatisfaction) AS missing_satisfaction,
    COUNT(*) - COUNT(SpecialProjectsCount) AS missing_special_projects,
    COUNT(*) - COUNT(LastPerformanceReview_Date) AS missing_last_review,
    COUNT(*) - COUNT(DaysLateLast30) AS missing_days_late
FROM hr_employees;


-- Check for duplicate employee IDs
SELECT 
    EmpID,
    COUNT(*) AS duplicate_count
FROM hr_employees
GROUP BY EmpID
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- Check for duplicate employee names
SELECT 
    Employee_Name,
    COUNT(*) AS duplicate_count
FROM hr_employees
GROUP BY Employee_Name
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- Check DOB date formats
SELECT DISTINCT DOB
FROM hr_employees
ORDER BY DOB ASC;

-- Check DateofHire formats
SELECT DISTINCT DateofHire
FROM hr_employees
ORDER BY DateofHire ASC;

-- Check DateofTermination formats
SELECT DISTINCT DateofTermination
FROM hr_employees
WHERE DateofTermination IS NOT NULL
ORDER BY DateofTermination ASC;

-- Check LastPerformanceReview_Date formats
SELECT DISTINCT LastPerformanceReview_Date
FROM hr_employees
ORDER BY LastPerformanceReview_Date ASC;

-- Check Sex column values
SELECT DISTINCT sex, COUNT(*) AS frequency
FROM hr_employees
GROUP BY sex
ORDER BY sex ASC;

-- Check TermReason values
SELECT DISTINCT termreason, COUNT(*) AS frequency
FROM hr_employees
GROUP BY termreason
ORDER BY termreason ASC;

-- Check PerformanceScore values
SELECT DISTINCT performancescore, COUNT(*) AS frequency
FROM hr_employees
GROUP BY performancescore
ORDER BY performancescore ASC;

-- Check EmploymentStatus values
SELECT DISTINCT employmentstatus, COUNT(*) AS frequency
FROM hr_employees
GROUP BY employmentstatus
ORDER BY employmentstatus ASC;

-- Check RecruitmentSource values
SELECT DISTINCT recruitmentsource, COUNT(*) AS frequency
FROM hr_employees
GROUP BY recruitmentsource
ORDER BY recruitmentsource ASC;

-- Check for whitespace in Employee_Name
SELECT COUNT(*) AS whitespace_names
FROM hr_employees
WHERE Employee_Name != TRIM(Employee_Name);

-- Validate PayRate - no negative or zero values
SELECT COUNT(*) AS invalid_payrate
FROM hr_employees
WHERE payrate <= 0;

-- Validate EngagementSurvey - should be between 1 and 5
SELECT COUNT(*) AS invalid_engagement
FROM hr_employees
WHERE engagementsurvey < 1 OR engagementsurvey > 5;

-- Validate EmpSatisfaction - should be between 1 and 5
SELECT COUNT(*) AS invalid_satisfaction
FROM hr_employees
WHERE empsatisfaction < 1 OR empsatisfaction > 5;

-- Validate DaysLateLast30 - should not be negative
SELECT COUNT(*) AS invalid_days_late
FROM hr_employees
WHERE daysLatelast30 < 0;