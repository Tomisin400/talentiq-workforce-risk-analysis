/* ================================================
   ANALYSIS 01 - WORKFORCE OVERVIEW
   Description: High level summary of the
   current workforce
================================================ */

-- Total employees
SELECT COUNT(*) AS total_employees FROM hr_employees;

-- Active vs terminated breakdown
SELECT employmentstatus, COUNT(*) AS count
FROM hr_employees
GROUP BY employmentstatus
ORDER BY count DESC;

-- Gender split
SELECT sex, COUNT(*) AS count
FROM hr_employees
GROUP BY sex;

/* ================================================
   ANALYSIS 02 - ATTRITION RATE
   Description: Calculate overall attrition rate
   and breakdown by type
================================================ */

-- Overall attrition rate
SELECT 
    COUNT(*) AS total_employees,
    SUM(termd) AS total_terminated,
    ROUND(SUM(termd) * 100.0 / COUNT(*), 2) AS attrition_rate_percent
FROM hr_employees;

-- Voluntary vs involuntary attrition
SELECT 
    employmentstatus,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hr_employees), 2) AS percentage
FROM hr_employees
WHERE termd = 1
GROUP BY employmentstatus
ORDER BY count DESC;

/* ================================================
   ANALYSIS 03 - WHY ARE EMPLOYEES LEAVING?
   Description: Top termination reasons
================================================ */

-- Termination reasons ranked
SELECT 
    termreason,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hr_employees WHERE termd = 1), 2) AS percentage
FROM hr_employees
WHERE termd = 1
AND termreason IS NOT NULL
GROUP BY termreason
ORDER BY count DESC;


/* ================================================
   ANALYSIS 04 - ATTRITION BY DEPARTMENT
   Description: Which departments are losing
   the most people?
================================================ */

SELECT 
    department,
    COUNT(*) AS total_employees,
    SUM(termd) AS terminated,
    ROUND(SUM(termd) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_employees
GROUP BY department
ORDER BY attrition_rate DESC;

/* ================================================
   ANALYSIS 05 - ATTRITION BY POSITION
   Description: Which positions have the
   highest turnover?
================================================ */

SELECT 
    position,
    department,
    COUNT(*) AS total_employees,
    SUM(termd) AS terminated,
    ROUND(SUM(termd) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_employees
GROUP BY position, department
HAVING COUNT(*) > 2
ORDER BY attrition_rate DESC;

/* ================================================
   ANALYSIS 06 - ATTRITION TREND BY YEAR
   Description: How has attrition changed
   over the years?
================================================ */

SELECT 
    EXTRACT(YEAR FROM dateoftermination) AS year,
    COUNT(*) AS terminations
FROM hr_employees
WHERE dateoftermination IS NOT NULL
GROUP BY year
ORDER BY year ASC;

/* ================================================
   ANALYSIS 06B - INVESTIGATE 2018 ATTRITION SPIKE
   Description: Dig deeper into what caused
   the massive attrition spike in 2018
================================================ */

-- What were the top reasons people left in 2018?
SELECT 
    termreason,
    COUNT(*) AS count
FROM hr_employees
WHERE EXTRACT(YEAR FROM dateoftermination) = 2018
AND termreason IS NOT NULL
GROUP BY termreason
ORDER BY count DESC;

-- Which departments lost the most people in 2018?
SELECT 
    department,
    COUNT(*) AS terminations
FROM hr_employees
WHERE EXTRACT(YEAR FROM dateoftermination) = 2018
GROUP BY department
ORDER BY terminations DESC;

-- Which positions lost the most people in 2018?
SELECT 
    position,
    COUNT(*) AS terminations
FROM hr_employees
WHERE EXTRACT(YEAR FROM dateoftermination) = 2018
GROUP BY position
ORDER BY terminations DESC;


/* ================================================
   ANALYSIS 06C - EARLY VS LONG-TERM ATTRITION
   Description: Do employees who leave early
   have different reasons than long-term employees?
================================================ */

-- Calculate tenure and categorize employees
SELECT 
    termreason,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM hr_employees
WHERE termd = 1
AND termreason IS NOT NULL
AND (dateoftermination - dateofhire) < 730 -- less than 2 years (730 days)
GROUP BY termreason
ORDER BY count DESC;

-- Long term employees (2+ years) termination reasons
SELECT 
    termreason,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM hr_employees
WHERE termd = 1
AND termreason IS NOT NULL
AND (dateoftermination - dateofhire) >= 730 -- 2 years or more
GROUP BY termreason
ORDER BY count DESC;

/* ================================================
   ANALYSIS 07 - AVERAGE PAY RATE BY GENDER
   Description: Is there a gender pay gap?
================================================ */

SELECT 
    sex,
    COUNT(*) AS total_employees,
    ROUND(AVG(payrate), 2) AS avg_pay_rate,
    ROUND(MIN(payrate), 2) AS min_pay_rate,
    ROUND(MAX(payrate), 2) AS max_pay_rate
FROM hr_employees
GROUP BY sex
ORDER BY avg_pay_rate DESC;

/* ================================================
   ANALYSIS 08 - PAY RATE BY GENDER AND DEPARTMENT
   Description: Check gender pay gap within
   the same department
================================================ */

SELECT 
    department,
    sex,
    COUNT(*) AS employees,
    ROUND(AVG(payrate), 2) AS avg_pay_rate
FROM hr_employees
GROUP BY department, sex
ORDER BY department, sex;

/* ================================================
   ANALYSIS 09 - EMPLOYEES PAID BELOW MINIMUM
   Description: Join salary grid to check if
   employees are paid below their position
   minimum salary range
================================================ */

SELECT 
    e.employee_name,
    e.position,
    e.department,
    e.sex,
    e.payrate,
    s.min_hourly,
    s.mid_hourly,
    s.max_hourly,
    CASE 
        WHEN e.payrate < s.min_hourly THEN 'Below Minimum'
        WHEN e.payrate BETWEEN s.min_hourly AND s.mid_hourly THEN 'Below Mid'
        WHEN e.payrate BETWEEN s.mid_hourly AND s.max_hourly THEN 'Above Mid'
        WHEN e.payrate > s.max_hourly THEN 'Above Maximum'
    END AS pay_position
FROM hr_employees e
JOIN salary_grid s ON LOWER(TRIM(e.position)) = LOWER(TRIM(s.position))
ORDER BY pay_position ASC;

-- Summary of pay positions
SELECT 
    CASE 
        WHEN e.payrate < s.min_hourly THEN 'Below Minimum'
        WHEN e.payrate BETWEEN s.min_hourly AND s.mid_hourly THEN 'Below Mid'
        WHEN e.payrate BETWEEN s.mid_hourly AND s.max_hourly THEN 'Above Mid'
        WHEN e.payrate > s.max_hourly THEN 'Above Maximum'
    END AS pay_position,
    COUNT(*) AS employee_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hr_employees), 2) AS percentage
FROM hr_employees e
JOIN salary_grid s ON LOWER(TRIM(e.position)) = LOWER(TRIM(s.position))
GROUP BY pay_position
ORDER BY employee_count DESC;

-- Who is being paid below minimum?
SELECT 
    e.employee_name,
    e.position,
    e.department,
    e.sex,
    e.payrate,
    s.min_hourly,
    s.min_hourly - e.payrate AS shortfall
FROM hr_employees e
JOIN salary_grid s ON LOWER(TRIM(e.position)) = LOWER(TRIM(s.position))
WHERE e.payrate < s.min_hourly
ORDER BY shortfall DESC;

/* ================================================
   ANALYSIS 10 - PAY RATE BY PERFORMANCE SCORE
   Description: Are high performers being
   rewarded with better pay?
================================================ */

SELECT 
    performancescore,
    COUNT(*) AS employees,
    ROUND(AVG(payrate), 2) AS avg_pay_rate,
    ROUND(MIN(payrate), 2) AS min_pay,
    ROUND(MAX(payrate), 2) AS max_pay
FROM hr_employees
GROUP BY performancescore
ORDER BY avg_pay_rate DESC;

/* ================================================
   ANALYSIS 10B - PAY BAND COMPLIANCE BY POSITION
   Description: Are employees in each position
   earning within their correct salary band?
================================================ */

SELECT 
    e.position,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN e.payrate < s.min_hourly THEN 1 ELSE 0 END) AS below_minimum,
    SUM(CASE WHEN e.payrate BETWEEN s.min_hourly AND s.max_hourly THEN 1 ELSE 0 END) AS within_band,
    SUM(CASE WHEN e.payrate > s.max_hourly THEN 1 ELSE 0 END) AS above_maximum
FROM hr_employees e
JOIN salary_grid s ON LOWER(TRIM(e.position)) = LOWER(TRIM(s.position))
GROUP BY e.position
ORDER BY below_minimum DESC;


/* ================================================
   ANALYSIS 11 - ENGAGEMENT & SATISFACTION
   Description: Overall engagement and
   satisfaction levels
================================================ */

-- Overall scores
SELECT 
    ROUND(AVG(engagementsurvey), 2) AS avg_engagement,
    ROUND(AVG(empsatisfaction), 2) AS avg_satisfaction,
    ROUND(MIN(engagementsurvey), 2) AS min_engagement,
    ROUND(MAX(engagementsurvey), 2) AS max_engagement
FROM hr_employees;

-- Engagement and satisfaction by department
SELECT 
    department,
    ROUND(AVG(engagementsurvey), 2) AS avg_engagement,
    ROUND(AVG(empsatisfaction), 2) AS avg_satisfaction,
    COUNT(*) AS employees
FROM hr_employees
GROUP BY department
ORDER BY avg_engagement ASC;

/* ================================================
   ANALYSIS 12 - BURNOUT INDICATORS
   Description: Days late and special projects
   as burnout signals
================================================ */

-- Days late by department
SELECT 
    department,
    ROUND(AVG(daysLatelast30), 2) AS avg_days_late,
    MAX(daysLatelast30) AS max_days_late,
    COUNT(*) AS employees
FROM hr_employees
GROUP BY department
ORDER BY avg_days_late DESC;

-- Special projects count by department
SELECT 
    department,
    ROUND(AVG(specialprojectscount), 2) AS avg_projects,
    MAX(specialprojectscount) AS max_projects,
    COUNT(*) AS employees
FROM hr_employees
GROUP BY department
ORDER BY avg_projects DESC;


/* ================================================
   ANALYSIS 12B - BURNOUT DEEP DIVE
   Description: Investigating burnout signals
   through engagement, days late and projects
================================================ */

-- Is there a relationship between days late and attrition?
SELECT 
    termd,
    ROUND(AVG(daysLatelast30), 2) AS avg_days_late,
    COUNT(*) AS employees
FROM hr_employees
GROUP BY termd
ORDER BY termd ASC;

-- Which department has lowest engagement AND highest attrition?
SELECT 
    department,
    ROUND(AVG(engagementsurvey), 2) AS avg_engagement,
    ROUND(SUM(termd) * 100.0 / COUNT(*), 2) AS attrition_rate,
    COUNT(*) AS employees
FROM hr_employees
GROUP BY department
ORDER BY avg_engagement ASC;

-- Do employees with more special projects show lower satisfaction?
SELECT 
    CASE 
        WHEN specialprojectscount = 0 THEN '0 Projects'
        WHEN specialprojectscount BETWEEN 1 AND 3 THEN '1-3 Projects'
        WHEN specialprojectscount BETWEEN 4 AND 6 THEN '4-6 Projects'
        WHEN specialprojectscount > 6 THEN '7+ Projects'
    END AS project_load,
    COUNT(*) AS employees,
    ROUND(AVG(empsatisfaction), 2) AS avg_satisfaction,
    ROUND(AVG(engagementsurvey), 2) AS avg_engagement
FROM hr_employees
GROUP BY project_load
ORDER BY avg_satisfaction DESC;

/* ================================================
   ANALYSIS 13 - MANAGER EFFECTIVENESS
   Description: Which managers have the highest
   turnover on their teams?
================================================ */

SELECT 
    managername,
    COUNT(*) AS total_team_size,
    SUM(termd) AS terminations,
    ROUND(SUM(termd) * 100.0 / COUNT(*), 2) AS turnover_rate,
    ROUND(AVG(engagementsurvey), 2) AS avg_engagement,
    ROUND(AVG(empsatisfaction), 2) AS avg_satisfaction
FROM hr_employees
GROUP BY managername
HAVING COUNT(*) > 2
ORDER BY turnover_rate DESC
LIMIT 10;

/* ================================================
   ANALYSIS 14 - RECRUITMENT SOURCE EFFECTIVENESS
   Description: Which recruitment sources produce
   employees who stay the longest?
================================================ */

SELECT 
    recruitmentsource,
    COUNT(*) AS total_hired,
    SUM(termd) AS terminated,
    ROUND(SUM(termd) * 100.0 / COUNT(*), 2) AS attrition_rate,
    ROUND(AVG(engagementsurvey), 2) AS avg_engagement,
    ROUND(AVG(empsatisfaction), 2) AS avg_satisfaction
FROM hr_employees
GROUP BY recruitmentsource
ORDER BY attrition_rate ASC;

/* ================================================
   EXPORT CLEANED HR DATASET
   Description: Export cleaned table to CSV
================================================ */

COPY hr_employees
TO 'C:/tmp/hr_employees_cleaned.csv'
DELIMITER ','
CSV HEADER;