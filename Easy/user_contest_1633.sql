-- Write your PostgreSQL query statement below
SELECT 
    contest_id, 
    ROUND(COUNT(DISTINCT user_id) * 100.0 / (SELECT COUNT(*) FROM users), 2) as percentage
FROM register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC;