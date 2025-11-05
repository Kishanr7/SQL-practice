WITH orders_cte AS (
  SELECT 
    c.city,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(p.paid_amount) AS total_revenue
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id
  AND o.order_date BETWEEN '2025-10-01' AND '2025-10-31'
  LEFT JOIN payments p ON o.order_id = p.order_id
  GROUP BY c.city
)

SELECT 
  city,
  total_orders,
  total_revenue,
  ROUND((total_revenue / total_orders),2) as avg_order_value
FROM
  orders_cte