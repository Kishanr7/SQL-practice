-- Write your PostgreSQL query statement below
SELECT
    e2.unique_id,
    e.name
FROM employees e LEFT JOIN
    employeeuni e2 ON e.id = e2.id

-- second solution with right join much faster Write your PostgreSQL query statement below
SELECT
    e2.unique_id,
    e.name
FROM employeeuni e2 RIGHT JOIN
    employees e ON e.id = e2.id