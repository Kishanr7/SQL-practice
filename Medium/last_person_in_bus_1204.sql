-- Write your PostgreSQL query statement below
WITH cte AS (
    SELECT
        person_name,
        weight,
        SUM(weight) OVER(ORDER BY turn) as total_weight
    FROM queue
)
SELECT person_name from cte WHERE total_weight <= 1000 ORDER BY total_weight DESC limit 1