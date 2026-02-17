CREATE TABLE customers (
  customer_id INT,
  customer_name VARCHAR(50),
  signup_date DATE
);

INSERT INTO customers VALUES
(1, 'Alice', '2026-01-01'),
(2, 'Bob', '2026-01-03'),
(3, 'Charlie', '2026-01-05');

CREATE TABLE orders (
  order_id INT,
  customer_id INT,
  order_date DATE,
  amount DECIMAL(10,2)
);

INSERT INTO orders VALUES
(1, 1, '2026-01-02', 100.00),
(2, 1, '2026-01-10', 150.00),
(3, 2, '2026-01-04', 200.00),
(4, 2, '2026-01-08', 250.00),
(5, 3, '2026-01-07', 300.00);


WITH cte_1 AS (
  SELECT 
    u.customer_id,
    u.customer_name,
    p.order_date,
    p.amount,
    ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date ASC) as rnk
  FROM customers u JOIN orders p on u.customer_id = p.customer_id
)

SELECT 
  customer_id,
  customer_name,
  order_date as first_order_date,
  amount as first_order_amount
FROM cte_1
WHERE rnk = 1
ORDER BY customer_id