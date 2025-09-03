-- Write your PostgreSQL query statement below
with max_salary_cte AS (
    SELECT
        departmentId,
        name,
        salary,
        DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary Desc) as rank
    FROM employee
)

SELECT 
    d.name as Department,
    e.name as Employee,
    e.salary
FROM 
    max_salary_cte e JOIN department d on e.departmentId = d.id
WHERE e.rank < 4
ORDER BY e.salary desc