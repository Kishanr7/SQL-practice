SELECT 
c.customer_name,
c.city,
COALESCE(COUNT(distinct o.order_id),0) AS oct_order_count, 
COALESCE(SUM(p.paid_amount),0) AS oct_total_paid
FROM
customers c 
LEFT JOIN orders o ON c.customer_id = o.customer_id
AND o.order_date BETWEEN '2025-10-01' AND '2025-10-31'
LEFT JOIN payments p ON p.order_id = o.order_id
GROUP BY customer_name, city