-- SQL041 · Window frames and rolling metrics
-- Completed: 2026-11-17
-- Task: Add a running total of settled amounts.
-- Validation: Passed
-- Repository: https://github.com/Kishanr7/SQL-practice

SELECT event_id, account_id, currency, settled_at, amount,
  SUM(amount) OVER(PARTITION BY account_id, currency ORDER BY settled_at, event_id) AS running_total
FROM settlements
ORDER BY account_id, currency, settled_at, event_id;