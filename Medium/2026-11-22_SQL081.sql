-- SQL081 · CTEs and recursive queries
-- Completed: 2026-11-22
-- Task: Reconcile expected and actual amounts per account using named CTEs.
-- Validation: Passed
-- Repository: https://github.com/Kishanr7/SQL-practice

with cte as (
  SELECT 
    e.account_id as expected_account_id,
    e.amount as expected_amount,
    a.account_id as actual_account_id,
    a.amount as actual_amount
  FROM actual a LEFT JOIN expected e on e.account_id = a.account_id
)

SELECT 
  actual_account_id as account_id,
  expected_amount,
  actual_amount,
  COALESCE(actual_amount,0)-COALESCE(expected_amount,0) AS difference
from cte
order by account_id