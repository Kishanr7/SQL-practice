-- SQL071 · Gaps, islands and sessions
-- Completed: 2026-11-21
-- Task: Number the activity sessions for each account.
-- Validation: Passed
-- Repository: https://github.com/Kishanr7/SQL-practice

WITH gaps AS (
  SELECT 
    event_id,
    account_id,
    event_at,
    previous_event_at,
    EXTRACT(EPOCH FROM (event_at - previous_event_at)) / 60 AS diff_minutes
  FROM (
    SELECT 
      event_id,
      account_id,
      event_at,
      LAG(event_at) OVER(PARTITION BY account_id ORDER BY event_at) as previous_event_at
    FROM activity
  )
  
), 
numbered AS (
  SELECT 
    event_id,
    account_id,
    event_at,
    previous_event_at,
    diff_minutes,
    CASE
      WHEN diff_minutes > 30 THEN 1
      WHEN previous_event_at IS NULL THEN 1
      ELSE 0
    END AS brk_flg
  FROM gaps
)
SELECT event_id,account_id, event_at, SUM(brk_flg) OVER (PARTITION BY account_id ORDER BY event_at) as session_number FROM numbered 