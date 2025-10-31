WITH spend AS (
  SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    COALESCE(SUM(o.amount), 0) AS total_spend
  FROM customers c
  LEFT JOIN orders o
    ON o.customer_id = c.customer_id
  GROUP BY c.customer_id, c.customer_name, c.city
),
ranked AS (
  SELECT
    city,
    customer_name,
    total_spend,
    DENSE_RANK() OVER (
      PARTITION BY city
      ORDER BY total_spend DESC
    ) AS rank_in_city
  FROM spend
)
SELECT city, customer_name, total_spend, rank_in_city
FROM ranked
WHERE rank_in_city <= 2               -- keep top 2 per city (with ties)
ORDER BY city, rank_in_city, customer_name;
