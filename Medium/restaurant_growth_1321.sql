SELECT 
    visited_on,
    amount,
    average_amount
FROM  (
    SELECT 
        visited_on,
        SUM(amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
        ROUND(AVG(amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS average_amount
    FROM (
        SELECT 
            visited_on,
            SUM(amount) as amount
        FROM customer
        GROUP BY visited_on
    ) daily
) t 
WHERE visited_on >= (
    SELECT MIN(visited_on) + INTERVAL 6 day FROM customer
)
ORDER BY visited_on