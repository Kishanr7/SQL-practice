CREATE TABLE daily_revenue (
    revenue_date DATE,
    product      VARCHAR(50),
    revenue      INT
);

INSERT INTO daily_revenue VALUES
('2026-01-10', 'A', 1000),
('2026-01-11', 'A', 1200),
('2026-01-12', 'A', 1150),
('2026-01-13', 'A', 1400),

('2026-01-10', 'B', 800),
('2026-01-11', 'B', 850),
('2026-01-12', 'B', 900),
('2026-01-13', 'B', 880);


with next AS (
  SELECT 
    product,
    revenue_date,
    revenue,
    LEAD(revenue) OVER(
          PARTITION BY product 
          ORDER BY revenue_date) AS next_day_revenue 
  FROM daily_revenue
)

SELECT 
  product,
  revenue_date,
  revenue,
  next_day_revenue,
  CASE 
    WHEN revenue > next_day_revenue THEN 'DOWN'
    WHEN revenue < next_day_revenue THEN 'UP'
    ELSE 'NO_DATA'
  END AS 'revenue_trend'
FROM next