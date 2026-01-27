CREATE TABLE customers (
  customer_id INT,
  customer_name VARCHAR(50)
);

CREATE TABLE purchases (
  purchase_id INT,
  customer_id INT,
  order_date DATE,
  amount INT
);

INSERT INTO customers (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Diana');

INSERT INTO purchases (purchase_id, customer_id, order_date, amount) VALUES
(1, 1, '2026-01-10', 100),
(2, 1, '2026-01-15', 200),
(3, 3, '2026-01-20', 300);

with cte_1 AS (
  SELECT
    c.customer_id,
    p.order_date,
    p.amount
  FROM customers c 
  LEFT JOIN purchases p
  ON c.customer_id = p.customer_id
)

SELECT customer_id
FROM cte_1 
WHERE order_date IS NULL