CREATE TABLE purchases (
  purchase_id INT,
  customer_id INT,
  order_date DATE,
  amount INT
);

INSERT INTO purchases (purchase_id, customer_id, order_date, amount) VALUES
(1, 1, '2026-01-05', 100),
(2, 1, '2026-01-10', 200),
(3, 2, '2026-01-03', 150),
(4, 2, '2026-01-20', 300),
(5, 3, '2026-01-08', 400);

with cte_1 AS (
  SELECT
    customer_id,
    order_date,
    amount,
    ROW_NUMBER() OVER(
        PARTITION BY customer_id 
        ORDER BY order_date 
    ) AS rn 
  FROM purchases
)

SELECT customer_id, order_date as first_purchase_date
FROM cte_1 
WHERE rn = 1