-- TRICK IS to use LEFT JOIN and check for NULL
-- Find the number of customers who have made a visit but have not made any transactions.

SELECT
    customer_id,
    COUNT(v.visit_id) as count_no_trans
FROM visits v
LEFT JOIN transactions t ON v.visit_id = t.visit_id
WHERE t.visit_id IS NULL
GROUP BY customer_id