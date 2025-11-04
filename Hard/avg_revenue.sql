WITH oct_sales AS (
  SELECT
    p.category_id,
    SUM(oi.quantity * oi.unit_price) as category_revenue
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p     ON p.product_id = oi.product_id
  WHERE o.order_date BETWEEN '2025-10-01' AND '2025-10-31'
  GROUP BY p.category_id
),

product_revenue AS (
  SELECT
    oi.product_id,
    AVG(oi.unit_price) AS avg_selling_price,
    SUM(oi.quantity * oi.unit_price) as product_revenue
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.order_date BETWEEN '2025-10-01' AND '2025-10-31'
  GROUP BY oi.product_id
)

SELECT
  c.category_name,
  DENSE_RANK() OVER(PARTITION BY c.category_name ORDER BY pr.product_revenue DESC) as product_rank_in_category,
  p.product_name,
  pr.product_revenue,
  s.category_revenue,
  ROUND((pr.product_revenue / s.category_revenue) * 100,2),
  pr.avg_selling_price,
  p.list_price,
  ROUND(((p.list_price - pr.avg_selling_price) / p.list_price) * 100, 2) AS avg_discount_pct
FROM oct_sales s 
JOIN categories c ON c.category_id = s.category_id
JOIN products p ON c.category_id = p.category_id
JOIN product_revenue pr  ON p.product_id = pr.product_id;