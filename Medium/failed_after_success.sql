CREATE TABLE pipeline_runs (
  run_id INT,
  pipeline_id INT,
  run_ts TIMESTAMP,
  status VARCHAR(20)
);

INSERT INTO pipeline_runs VALUES
(1, 101, '2026-01-28 09:00:00', 'SUCCESS'),
(2, 101, '2026-01-28 09:05:00', 'SUCCESS'),
(3, 101, '2026-01-28 09:10:00', 'FAILED'),
(4, 101, '2026-01-28 09:15:00', 'FAILED'),
(5, 202, '2026-01-28 09:00:00', 'FAILED'),
(6, 202, '2026-01-28 09:05:00', 'SUCCESS'),
(7, 202, '2026-01-28 09:10:00', 'FAILED'),
(8, 303, '2026-01-28 09:00:00', 'SUCCESS'),
(9, 303, '2026-01-28 09:05:00', 'SUCCESS');

with cte_1 AS (
  SELECT
    run_id,
    pipeline_id,
    run_ts,
    status,
    LAG(status) OVER(PARTITION BY pipeline_id ORDER BY run_ts) AS prev_status
  FROM pipeline_runs
),

cte_2 AS (
  SELECT 
    pipeline_id,
    run_id,
    run_ts,
    status,
    prev_status
  FROM cte_1 
  WHERE prev_status = 'SUCCESS' AND status = 'FAILED'
)

SELECT 
  pipeline_id,
  run_id,
  run_ts
FROM cte_2

