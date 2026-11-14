-- SQL026 · Filtering and subqueries
-- Completed: 2026-11-15
-- Task: Show each customer's latest successful transaction. Keep customers who have never had a successful transaction.
-- Validation: Passed
-- Repository: https://github.com/Kishanr7/SQL-practice

WITH ranked AS (
  -- rank successful transactions per customer
  SELECT 
    transaction_id,
    customer_id,
    status,
    created_at,
    RANK() OVER(partition by customer_id order by created_at DESC) as rn
  FROM transactions
  WHERE status ='SUCCESS'
)
SELECT c.customer_id, r.transaction_id, r.created_at
FROM customers c
LEFT JOIN ranked r ON r.customer_id = c.customer_id AND r.rn = 1
ORDER BY c.customer_id;