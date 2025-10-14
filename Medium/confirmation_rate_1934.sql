-- # Write your MySQL query statement below
SELECT
    s.user_id,
    -- ROUND(COALESCE(SUM(c.action='confirmed'),0)/COUNT(c.user_id),2) as confirmation_rate
    ROUND(COALESCE((SUM(c.action='confirmed')/COUNT(c.user_id)),0),2) as confirmation_rate
FROM
signups s LEFT JOIN
confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id
-- WHERE action = 'confirmed'