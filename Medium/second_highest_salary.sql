-- 1.

SELECT 
    max(salary) as SecondHighestSalary
FROM employee 
WHERE salary NOT IN (SELECT salary FROM employee ORDER BY salary DESC LIMIT 1)

-- 2.

SELECT (
    SELECT DISTINCT SALARY 
    FROM employee
    ORDER BY SALARY DESC
    LIMIT 1
    OFFSET 1
) AS SecondHighestSalary;