-- SQL031 · Ranking and ordering
-- Completed: 2026-11-16
-- Task: Rank merchants by settled value for each month and currency. Show how ROW_NUMBER, RANK and DENSE_RANK treat ties.
-- Validation: Passed
-- Repository: https://github.com/Kishanr7/SQL-practice

SELECT month_start, currency, merchant_id, settled_value,
  -- add row_number, rank and dense_rank
  ROW_NUMBER() OVER(PARTITION BY currency ORDER BY settled_value DESC) as row_number,
  RANK() OVER(PARTITION BY currency ORDER BY settled_value DESC) as rank,
  DENSE_RANK() OVER(PARTITION BY currency ORDER BY settled_value DESC) as dense_rank
FROM merchant_monthly
ORDER BY month_start, currency, settled_value DESC, merchant_id;