-- # Write your MySQL query statement below
SELECT
    e.name,
    b.bonus
FROM 
    employee e LEFT JOIN
    bonus b on e.empId = b.empId
WHERE bonus < 1000 or bonus is NULL;