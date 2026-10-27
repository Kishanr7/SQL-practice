-- SQL001 · Joins and grain
-- Completed: 2026-10-27
-- Task: Write one query that lists every account and the number of transactions for it. Accounts with no transactions must still appear with a count of 0.
-- Validation: Passed
-- Repository: https://github.com/Kishanr7/SQL-practice

SELECT
  a.account_id, COALESCE(COUNT(t.transaction_id), 0) as transaction_count
FROM accounts a
LEFT JOIN transactions t ON t.account_id = a.account_id
GROUP BY a.account_id
ORDER BY a.account_id;