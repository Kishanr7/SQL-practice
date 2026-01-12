CREATE TABLE customer_orders (
    order_id     INT,
    customer_id  INT,
    order_date   DATE
);

INSERT INTO customer_orders VALUES
(1, 101, '2026-01-01'),
(2, 101, '2026-01-03'),
(3, 101, '2026-01-05'),
(4, 101, '2026-01-09'),

(5, 202, '2026-01-02'),
(6, 202, '2026-01-04'),
(7, 202, '2026-01-08'),
(8, 202, '2026-01-09');

with prev AS (
  SELECT 
    customer_id,
    order_date,
    COUNT(*) OVER(
          PARTITION BY customer_id 
          ORDER BY order_date
          RANGE BETWEEN INTERVAL '6' DAY PRECEDING AND CURRENT ROW) AS running_order_count 
  FROM customer_orders
)

SELECT 
  *
FROM prev