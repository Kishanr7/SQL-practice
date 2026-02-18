CREATE TABLE sales (
  sale_id INT,
  sale_date DATE,
  customer_id INT,
  amount DECIMAL(10,2)
);

INSERT INTO sales VALUES
(1, '2026-01-01', 1, 100.00),
(2, '2026-01-01', 2, 150.00),
(3, '2026-01-02', 1, 200.00),
(4, '2026-01-03', 3, 250.00),
(5, '2026-01-03', 2, 300.00),
(6, '2026-01-03', 1, 50.00);

WITH cte_1 AS (
  SELECT 
    sale_date,
    SUM(amount) as total_revenue,
    COUNT(*) as number_of_sales,
    AVG(amount) as average_sale_amount
  FROM sales
  GROUP BY sale_date
  ORDER BY sale_date
)


SELECT 
  *
FROM cte_1