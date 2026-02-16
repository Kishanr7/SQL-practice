CREATE TABLE orders (
  order_id INT,
  user_id INT,
  order_date DATE,
  amount DECIMAL(10,2)
);

INSERT INTO orders VALUES
(1, 1, '2026-02-01', 120.00),
(2, 2, '2026-02-01', 200.00),
(3, 3, '2026-02-01', 200.00),
(4, 1, '2026-02-02', 150.00),
(5, 2, '2026-02-02', 180.00),
(6, 1, '2026-02-03', 90.00),
(7, 3, '2026-02-03', 300.00);

WITH cte_1 AS (
    SELECT 
      order_id,
      user_id,
      order_date,
      amount,
      RANK() OVER(PARTITION BY order_date ORDER BY amount DESC) as rnk
    FROM orders
)
SELECT
  order_date,
  user_id,
  amount,
  rnk
FROM cte_1
WHERE rnk = 1