-- # Write your MySQL query statement below
-- Algorithm Explanation:
-- Problem: Find managers and their reporting statistics (count of reports and average age of reports)
-- Current Approach using CTE:
-- 1. CTE aggregates data for each manager (reports_to) - counts reports and calculates average age
-- 2. Main query joins CTE with employees table to get manager names
-- 3. Results are ordered by employee_id

WITH CTE AS (
    SELECT 
        reports_to as employee_id,           -- Manager's employee_id
        COUNT(employee_id) as reports_count, -- Count of direct reports
        ROUND(AVG(age)) as age              -- Average age of direct reports
    FROM employees
    WHERE reports_to IS NOT NULL           -- Only employees who have managers
    GROUP BY reports_to                    -- Group by manager
)
SELECT 
    c.employee_id,      -- Manager's ID
    e.name,             -- Manager's name
    c.reports_count,    -- Number of direct reports
    c.age as average_age -- Average age of direct reports
FROM CTE c 
JOIN employees e ON c.employee_id = e.employee_id  -- Get manager details
ORDER BY e.employee_id