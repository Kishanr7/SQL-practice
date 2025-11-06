
WITH cte AS (
  SELECT
    c.city,
    pr.product_name,
    coalesce(ROUND(SUM(oi.quantity*oi.unit_price),2),0) AS product_revenue,
    ROW_NUMBER() OVER (partition BY c.city ORDER BY ROUND(SUM(oi.quantity*oi.unit_price),2) DESC) as rnk
  FROM
    customers c 
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    AND o.order_date BETWEEN '2025-10-01' and '2025-10-31'
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    LEFT JOIN products pr ON pr.product_id = oi.product_id
  GROUP BY c.city,pr.product_name
)

SELECT * FROM cte WHERE rnk = 1;