WITH rolling_average AS (
  SELECT 
    region,
    sale_date,
    total_sales,
    AVG(total_sales) OVER(PARTITION BY region ORDER BY sale_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
  FROM daily_sales
)
SELECT 
  region,
  sale_date,
  total_sales,
  moving_avg,
  CASE 
    WHEN total_sales > moving_avg THEN 'Above Avg'
    ELSE 'Below Avg'
  END AS performance_flag
FROM rolling_average;