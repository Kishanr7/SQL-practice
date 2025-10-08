-- # Write your MySQL query statement below

-- Algorithm Explanation:
-- Problem: Find employees who earn less than $30,000 and whose manager is not in the employees table
-- Logic:
-- 1. Use LEFT JOIN to connect employees with their managers based on manager_id = employee_id
-- 2. Filter for employees with salary < 30000
-- 3. Filter for cases where the manager doesn't exist (e2.employee_id IS NULL)
-- 4. Ensure the employee actually has a manager assigned (e1.manager_id IS NOT NULL)
-- 5. This combination finds employees who have a manager_id but that manager is missing from the table

SELECT
    -- e1.employee_id, e1.manager_id, e2.employee_id, e2.manager_id
    e1.employee_id as employee_id
    -- manager_id as employee_id
FROM
    -- e1 represents the employee, e2 represents their potential manager
    employees e1 LEFT JOIN employees e2 on e1.manager_id = e2.employee_id
WHERE 
    e1.salary < 30000 AND           -- Employee earns less than $30,000
    e2.employee_id is NULL AND      -- Manager doesn't exist in employees table (LEFT JOIN result is NULL)
    e1.manager_id is NOT NULL       -- Employee has a manager assigned (not a top-level employee)
ORDER BY e1.employee_id