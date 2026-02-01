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

SELECT 
  user_id,
  MIN(order_date) as first_order_date
FROM orders
GROUP BY user_id

