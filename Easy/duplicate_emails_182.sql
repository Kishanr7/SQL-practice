-- # Write your MySQL query statement below
SELECT email as Email
FROM (
    SELECT email, count(*)
    FROM
    person
    group by email
    having count(*) > 1
) t