-- # Write your MySQL query statement below
SELECT MAX(num) as num
FROM (
    SELECT num
    FROM mynumbers
    GROUP BY num
    HAVING count(num) = 1
) t

-- second solution without subquery

SELECT CASE WHEN COUNT(num) = 1 THEN num ELSE NULL END AS num
FROM MyNumbers
GROUP BY num
ORDER BY num DESC
LIMIT 1;