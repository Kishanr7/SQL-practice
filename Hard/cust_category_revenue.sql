-- Online SQL Editor to Run SQL Online.
-- Use the editor to create new tables, insert data and all other SQL operations.
-- Re-run safe
WITH cte AS (
  SELECT 
  ca.category_name,
  cu.customer_name,
  SUM(oi.quantity * oi.unit_price) AS customer_category_revenue
  FROM orders o
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN products p ON p.product_id = oi.product_id
  JOIN categories ca ON ca.category_id = p.category_id
  JOIN customers cu ON o.customer_id = cu.customer_id
  WHERE o.order_date BETWEEN '2025-10-01' AND '2025-10-31'
  GROUP BY ca.category_name, cu.customer_name
),

ranked AS (
  SELECT
  *,
  ROW_NUMBER() OVER(PARTITION BY category_name 
                    ORDER BY customer_category_revenue DESC) AS rnk
  FROM cte
)
SELECT category_name, customer_name, customer_category_revenue
FROM ranked
WHERE rnk = 1;