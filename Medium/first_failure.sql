WITH status_with_prev AS (
  SELECT
    run_id,
    pipeline_id,
    run_ts,
    status,
    LAG(status) OVER (
      PARTITION BY pipeline_id
      ORDER BY run_ts
    ) AS prev_status
  FROM pipeline_runs
),

failed_after_success AS (
  SELECT
    run_id,
    pipeline_id,
    run_ts,
    status
  FROM status_with_prev
  WHERE status = 'FAILED'
    AND prev_status = 'SUCCESS'
),

first_failure_per_pipeline AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY pipeline_id
      ORDER BY run_ts
    ) AS rn
  FROM failed_after_success
)

SELECT
  run_id,
  pipeline_id,
  run_ts,
  status
FROM first_failure_per_pipeline
WHERE rn = 1;
