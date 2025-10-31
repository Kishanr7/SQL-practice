-- Online SQL Editor to Run SQL Online.
-- Use the editor to create new tables, insert data and all other SQL operations.
  
  -- Customers

WITH latest AS (
  SELECT 
    customer_id, 
    MAX(order_date) AS max_date
  FROM orders
  GROUP BY customer_id
)
SELECT 
  c.customer_name,
  c.city,
  o.order_id,
  o.order_date,
  o.amount
FROM customers c
LEFT JOIN latest l 
  ON l.customer_id = c.customer_id
LEFT JOIN orders o 
  ON o.customer_id = c.customer_id AND o.order_date = l.max_date;
