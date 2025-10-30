WITH cte as (
  SELECT emp_id, emp_name, department, salary, AVG(salary) OVER(partition by department) as avg_department_salary 	FROM employees
)

SELECT * 
FROM cte
WHERE salary > avg_department_salary