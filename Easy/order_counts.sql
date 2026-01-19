CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(50)
);

CREATE TABLE orders (
    order_id     INT,
    customer_id  INT,
    order_date   DATE
);

INSERT INTO customers VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

INSERT INTO orders VALUES
(101, 1, '2026-01-15'),
(102, 1, '2026-01-16'),
(103, 2, '2026-01-16');

with cte AS (
  SELECT 
    c.customer_id,
    c.customer_name,
    COALESCE(COUNT(o.order_id), 0) AS total_orders 
  FROM customers c 
  LEFT JOIN orders o
  ON c.customer_id = o.customer_id
  GROUP BY c.customer_id, c.customer_name
)

SELECT *
FROM cte