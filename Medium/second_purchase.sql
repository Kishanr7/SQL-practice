CREATE TABLE purchases (
    customer_id INT,
    order_id    INT,
    order_date  DATE,
    amount      INT
);

INSERT INTO purchases VALUES
(1, 201, '2026-01-01', 500),
(1, 202, '2026-01-05', 700),
(1, 203, '2026-01-10', 400),
(2, 204, '2026-01-03', 300),
(2, 205, '2026-01-10', 400),
(3, 206, '2026-01-07', 250);

with cte_1 AS (
  SELECT
    customer_id,
    order_id,
    order_date,
    DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_date) AS rn 
  FROM purchases
)

SELECT 
  customer_id,
  order_date as second_order_date
FROM cte_1
WHERE rn = 2