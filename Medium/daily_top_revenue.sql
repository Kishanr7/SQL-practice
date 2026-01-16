CREATE TABLE product_sales (
    sale_date DATE,
    product   VARCHAR(50),
    revenue   INT
);

INSERT INTO product_sales VALUES
('2026-01-13', 'A', 1200),
('2026-01-13', 'B', 1500),
('2026-01-13', 'C', 1500),

('2026-01-14', 'A', 1800),
('2026-01-14', 'B', 1700),
('2026-01-14', 'C', 1600);

with cte AS (
  SELECT 
    product,
    sale_date,
    revenue,
    RANK() OVER(
          PARTITION BY sale_date
          ORDER BY revenue DESC) AS rnk
  FROM product_sales
)

SELECT 
  sale_date,
  product,
  revenue,
  rnk as rank_in_day
FROM cte
WHERE rnk = 1