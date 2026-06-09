-- Load HR employees data
COPY hr_employees
FROM 'C:/tmp/HRDataset_v13 (2).csv'
DELIMITER ','
CSV HEADER;

-- Load salary grid data
COPY salary_grid
FROM 'C:/tmp/salary_grid-1 (2).csv'
DELIMITER ','
CSV HEADER;

-- Check row counts
SELECT COUNT(*) AS hr_employees_count FROM hr_employees;
SELECT COUNT(*) AS salary_grid_count FROM salary_grid;
