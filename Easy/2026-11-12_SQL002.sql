-- SQL002 · Joins and grain
-- Completed: 2026-11-12
-- Task: List transactions that cannot match an account. Return transaction_id, account_id and exception_group. Label missing keys NULL_KEY and other unmatched keys UNKNOWN_ACCOUNT. Keep one row per exception transaction, ordered by transaction_id.
-- Validation: Passed
-- Repository: https://github.com/Kishanr7/SQL-practice

SELECT
  t.transaction_id as transaction_id,
  t.account_id as account_id,
  CASE
    WHEN t.account_id IS NULL THEN 'NULL_KEY'
  ELSE 'UNKNOWN_ACCOUNT'
  END AS exception_group
FROM transactions t
LEFT JOIN accounts a ON t.account_id = a.account_id
WHERE a.account_id IS NULL
ORDER BY t.transaction_id;