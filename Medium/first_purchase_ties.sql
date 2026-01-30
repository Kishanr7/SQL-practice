CREATE TABLE orders (
  order_id INT,
  user_id INT,
  order_date DATE,
  amount INT
);

INSERT INTO orders VALUES
(1, 1, '2026-01-20', 100),
(2, 1, '2026-01-22', 150),
(3, 2, '2026-01-21', 200),
(4, 2, '2026-01-21', 50),
(5, 3, '2026-01-23', 300);

with cte_1 AS (
  SELECT 
    order_id,
    user_id,
    order_date,
    amount,
    RANK() OVER(PARTITION BY user_id ORDER BY order_date) AS rnk
  FROM orders
)

SELECT 
  user_id,
  order_id,
  order_date,
  amount
FROM cte_1
WHERE rnk = 1