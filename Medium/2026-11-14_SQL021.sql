-- SQL021 · Filtering and subqueries
-- Completed: 2026-11-14
-- Task: Find transactions whose amount is higher than the average for the same account, currency and month.
-- Validation: Passed
-- Repository: https://github.com/Kishanr7/SQL-practice

WITH AVG as (
  SELECT 
    account_id, 
    to_char(posted_at, 'YYYY-MM') AS year_month,
    currency,
    AVG(amount) as average_amount
  FROM transactions 
  GROUP BY account_id, year_month, currency
)

SELECT 
  t.transaction_id, 
  t.account_id, 
  t.currency, 
  t.posted_at, 
  t.amount
FROM transactions t 
JOIN AVG a 
on t.account_id = a.account_id
and t.currency = a.currency
and to_char(t.posted_at, 'YYYY-MM') = a.year_month
WHERE t.amount > a.average_amount
ORDER BY t.transaction_id