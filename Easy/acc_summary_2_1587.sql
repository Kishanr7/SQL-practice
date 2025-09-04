-- Write your PostgreSQL query statement below
SELECT 
    u.name,
    SUM(t.amount) as balance
FROM users u JOIN
    transactions t ON u.account = t.account
GROUP BY u.name
HAVING SUM(t.amount) > 10000