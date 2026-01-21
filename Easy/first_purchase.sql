CREATE TABLE purchases (
    customer_id INT,
    order_id    INT,
    order_date  DATE,
    amount      INT
);

INSERT INTO purchases VALUES
(1, 101, '2026-01-01', 500),
(1, 102, '2026-01-05', 700),
(2, 103, '2026-01-03', 300),
(2, 104, '2026-01-10', 400),
(3, 105, '2026-01-07', 250);


with cte_1 AS (
  SELECT
    customer_id,
    order_id,
    order_date,
    ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date) AS rn 
  FROM purchases
)

SELECT 
  customer_id,
  order_date as first_order_date
FROM cte_1
WHERE rn = 1
