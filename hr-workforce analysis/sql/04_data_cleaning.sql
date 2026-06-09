/* ================================================
   CLEAN ISSUE 13 - DROP REDUNDANT COLUMNS
   Description: Remove ID columns and location
   columns that are not needed for analysis
================================================ */

ALTER TABLE hr_employees DROP COLUMN marriedid;
ALTER TABLE hr_employees DROP COLUMN maritalstatusid;
ALTER TABLE hr_employees DROP COLUMN genderid;
ALTER TABLE hr_employees DROP COLUMN empstatusid;
ALTER TABLE hr_employees DROP COLUMN deptid;
ALTER TABLE hr_employees DROP COLUMN perfscoreid;
ALTER TABLE hr_employees DROP COLUMN positionid;
ALTER TABLE hr_employees DROP COLUMN managerid;
ALTER TABLE hr_employees DROP COLUMN state;
ALTER TABLE hr_employees DROP COLUMN zip;

-- Confirm remaining columns
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'hr_employees'
ORDER BY ordinal_position;

/* ================================================
   CLEAN ISSUE 12 - TRIM WHITESPACE FROM NAMES
   Description: Remove leading and trailing
   spaces from Employee_Name column
================================================ */

UPDATE hr_employees
SET employee_name = TRIM(employee_name);

-- Confirm no more whitespace
SELECT COUNT(*) AS whitespace_remaining
FROM hr_employees
WHERE employee_name != TRIM(employee_name);

/* ================================================
   CLEAN ISSUE 01 - REFORMAT EMPLOYEE NAMES
   Description: Convert names from Last, First
   format to First Last format
================================================ */

UPDATE hr_employees
SET employee_name = 
    TRIM(SPLIT_PART(employee_name, ',', 2)) 
    || ' ' ||
    TRIM(SPLIT_PART(employee_name, ',', 1));

-- Confirm name format is now correct
SELECT employee_name
FROM hr_employees
LIMIT 10;

/* ================================================
   CLEAN ISSUE 03 - STANDARDIZE SEX COLUMN
   Description: Convert M/F to Male/Female
================================================ */

UPDATE hr_employees SET sex = 'Female' WHERE sex = 'F';
UPDATE hr_employees SET sex = 'Male' WHERE sex = 'M';

-- Confirm sex column is now standardized
SELECT DISTINCT sex, COUNT(*) AS frequency
FROM hr_employees
GROUP BY sex;

-- Increase sex column size first
ALTER TABLE hr_employees
ALTER COLUMN sex TYPE VARCHAR(10);
-- Force update using LIKE
UPDATE hr_employees
SET sex = 'Male'
WHERE TRIM(sex) = 'M';

SELECT * FROM hr_employees;

/* ================================================
   CLEAN ISSUE 06 & 07 - CLEAN TERMREASON COLUMN
   Description: Set N/A values to NULL, fix blank
   to Unknown and standardize casing
================================================ */

-- Set N/A values to NULL for active employees
UPDATE hr_employees
SET termreason = NULL
WHERE termreason IN ('N/A - still employed', 'N/A - Has not started yet');

-- Fix blank termreason to Unknown
UPDATE hr_employees
SET termreason = 'Unknown'
WHERE termreason IS NULL AND termd = 1;

-- Standardize casing to proper case
UPDATE hr_employees
SET termreason = INITCAP(termreason)
WHERE termreason IS NOT NULL;

-- Confirm
SELECT DISTINCT termreason, COUNT(*) AS frequency
FROM hr_employees
GROUP BY termreason
ORDER BY termreason ASC;

/* ================================================
   CLEAN ISSUE 02 - STANDARDIZE DATE COLUMNS
   Description: Convert all date columns to
   YYYY-MM-DD format and add clean date columns
================================================ */

-- Add new clean date columns
ALTER TABLE hr_employees ADD COLUMN clean_dob DATE;
ALTER TABLE hr_employees ADD COLUMN clean_hire_date DATE;
ALTER TABLE hr_employees ADD COLUMN clean_termination_date DATE;
ALTER TABLE hr_employees ADD COLUMN clean_last_review_date DATE;

-- Clean DOB
UPDATE hr_employees
SET clean_dob = TO_DATE(dob, 'MM/DD/YYYY')
WHERE dob ~ '^\d{1,2}/\d{1,2}/\d{4}$';

UPDATE hr_employees
SET clean_dob = TO_DATE('20' || SPLIT_PART(dob, '/', 3) ||  '-' ||  SPLIT_PART(dob, '/', 1) || '-' || SPLIT_PART(dob, '/', 2), 'YYYY-MM-DD')
WHERE dob ~ '^\d{1,2}/\d{1,2}/\d{2}$';

-- Clean DateofHire
UPDATE hr_employees
SET clean_hire_date = TO_DATE(dateofhire, 'MM/DD/YYYY')
WHERE dateofhire ~ '^\d{1,2}/\d{1,2}/\d{4}$';

-- Clean DateofTermination
UPDATE hr_employees
SET clean_termination_date = TO_DATE(dateoftermination, 'MM/DD/YYYY')
WHERE dateoftermination ~ '^\d{1,2}/\d{1,2}/\d{4}$';

UPDATE hr_employees
SET clean_termination_date = TO_DATE('20' ||  SPLIT_PART(dateoftermination, '/', 3) ||  '-' || SPLIT_PART(dateoftermination, '/', 1) ||  '-' || SPLIT_PART(dateoftermination, '/', 2), 'YYYY-MM-DD')
WHERE dateoftermination ~ '^\d{1,2}/\d{1,2}/\d{2}$';

-- Clean LastPerformanceReview_Date
UPDATE hr_employees
SET clean_last_review_date = TO_DATE(lastperformancereview_date, 'MM/DD/YYYY')
WHERE lastperformancereview_date ~ '^\d{1,2}/\d{1,2}/\d{4}$';


-- Fix DOB 2 digit years - should be 19xx not 20xx
UPDATE hr_employees
SET clean_dob = TO_DATE('19' ||  SPLIT_PART(dob, '/', 3) ||  '-' || 
    LPAD(SPLIT_PART(dob, '/', 1), 2, '0') ||  '-' ||
    LPAD(SPLIT_PART(dob, '/', 2), 2, '0'), 'YYYY-MM-DD')
WHERE dob ~ '^\d{1,2}/\d{1,2}/\d{2}$';


-- Confirm all 4 clean date columns
SELECT 
    dob, clean_dob,
    dateofhire, clean_hire_date,
    dateoftermination, clean_termination_date,
    lastperformancereview_date, clean_last_review_date
FROM hr_employees
LIMIT 10;

-- Drop old messy date columns
ALTER TABLE hr_employees DROP COLUMN dob;
ALTER TABLE hr_employees DROP COLUMN dateofhire;
ALTER TABLE hr_employees DROP COLUMN dateoftermination;
ALTER TABLE hr_employees DROP COLUMN lastperformancereview_date;

-- Rename clean columns
ALTER TABLE hr_employees RENAME COLUMN clean_dob TO dob;
ALTER TABLE hr_employees RENAME COLUMN clean_hire_date TO dateofhire;
ALTER TABLE hr_employees RENAME COLUMN clean_termination_date TO dateoftermination;
ALTER TABLE hr_employees RENAME COLUMN clean_last_review_date TO lastperformancereview_date;

-- Confirm
SELECT dob, dateofhire, dateoftermination, lastperformancereview_date
FROM hr_employees
LIMIT 5;

/* ================================================
   FINAL CHECK - CONFIRM CLEANED DATASET
   Description: Verify all cleaning steps
   are complete
================================================ */

-- Final row count
SELECT COUNT(*) AS total_rows FROM hr_employees;

-- Final column count
SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name = 'hr_employees';

-- Check sex column is clean
SELECT DISTINCT sex FROM hr_employees;

-- Check termreason is clean
SELECT DISTINCT termreason 
FROM hr_employees 
WHERE termreason IS NOT NULL
ORDER BY termreason ASC;

-- Check dates are all proper format
SELECT dob, dateofhire, dateoftermination, lastperformancereview_date
FROM hr_employees
LIMIT 5;

-- Check employee names are clean
SELECT employee_name
FROM hr_employees
LIMIT 5;