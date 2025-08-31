-- # Write your MySQL query statement below
SELECT
    class
FROM(
    SELECT 
        COUNT(student) as total_students,
        class
    FROM 
        courses
    GROUP BY class
    HAVING total_students >= 5
) t

-- second

-- # Write your MySQL query statement below
SELECT 
    class
FROM 
    courses
GROUP BY class
HAVING count(class) >= 5
