-- # Write your MySQL query statement below
DELETE FROM person
WHERE id NOT IN (
    SELECT minid 
    FROM (
        SELECT email, min(id) as minid
        FROM person
        GROUP BY email
    ) test
);