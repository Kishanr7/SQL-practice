CREATE TABLE daily_product_revenue (
    revenue_date DATE,
    product      VARCHAR(50),
    revenue      INT
);

INSERT INTO daily_product_revenue VALUES
('2026-01-13', 'A', 1200),
('2026-01-14', 'A', 1500),
('2026-01-15', 'A', 1400),
('2026-01-16', 'A', 1700),

('2026-01-13', 'B', 900),
('2026-01-14', 'B', 900),
('2026-01-15', 'B', 1100),
('2026-01-16', 'B', 1000);

with cte AS (
  SELECT 
    product,
    revenue_date,
    revenue,
    LAG(revenue, 1) OVER(
          PARTITION BY product
          ORDER BY revenue_date) AS prev_day_revenue 
  FROM daily_product_revenue
)

SELECT 
  product,
  revenue,
  revenue_date,
  prev_day_revenue,
  CASE 
    WHEN revenue < prev_day_revenue THEN 'DOWN'
    WHEN revenue > prev_day_revenue THEN 'UP'
    WHEN revenue = prev_day_revenue THEN 'NO_CHANGE'
    ELSE 'NO_DATA'
  END AS 'revenue_change_flag'
FROM cte