CREATE TABLE orders (
    order_id     INT,
    customer_id  INT,
    order_date   DATE
);

INSERT INTO orders VALUES
(1, 101, '2026-01-01'),
(2, 101, '2026-01-03'),
(3, 101, '2026-01-05'),

(4, 202, '2026-01-02'),
(5, 202, '2026-01-04'),
(6, 202, '2026-01-06');


with prev AS (
  SELECT 
    customer_id,
    order_date,
    COUNT(*) OVER(PARTITION BY customer_id ORDER BY order_date) AS running_order_count 
  FROM orders
)

SELECT 
  *
FROM prev