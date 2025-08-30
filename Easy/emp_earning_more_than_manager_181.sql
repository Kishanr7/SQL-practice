-- first try
SELECT 
    e1.name as Employee
FROM
employee e1 JOIN
employee e2 on e2.id = e1.managerId
where e1.salary > e2.salary