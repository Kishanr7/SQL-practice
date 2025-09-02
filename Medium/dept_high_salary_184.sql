-- Write your PostgreSQL query statement below
with max_salary_cte AS (
    SELECT
        departmentId,
        name,
        salary,
        RANK() OVER(PARTITION BY departmentId ORDER BY salary Desc) as rank
    FROM employee
)

SELECT 
    d.name as Department,
    e.name as Employee,
    e.salary
FROM 
    max_salary_cte e JOIN department d on e.departmentId = d.id
WHERE e.rank = 1