-- Write your PostgreSQL query statement below
SELECT employee_id FROM employees where employee_id not in (SELECT employee_id from salaries)
UNION
SELECT employee_id FROM salaries where employee_id not in (SELECT employee_id from employees)
ORDER BY employee_id