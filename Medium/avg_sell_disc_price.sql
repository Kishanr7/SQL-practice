WITH oct_sales AS (
  SELECT
    p.category_id,
    AVG(oi.unit_price) AS avg_selling_price
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  JOIN products p     ON p.product_id = oi.product_id
  WHERE o.order_date BETWEEN '2025-10-01' AND '2025-10-31'
  GROUP BY p.category_id
),
avg_list AS (
  SELECT
    category_id,
    AVG(list_price) AS avg_list_price
  FROM products
  GROUP BY category_id
)
SELECT
  c.category_name,
  a.avg_list_price,
  s.avg_selling_price,
  ROUND(((a.avg_list_price - s.avg_selling_price) / a.avg_list_price) * 100, 2) AS discount_percent
FROM avg_list a
JOIN oct_sales s   ON s.category_id = a.category_id
JOIN categories c  ON c.category_id = a.category_id;
