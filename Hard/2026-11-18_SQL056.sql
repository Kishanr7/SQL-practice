-- SQL056 · Deduplication and source versions
-- Completed: 2026-11-18
-- Task: Build a daily count of repeated and conflicting deliveries.
-- Validation: Passed
-- Repository: https://github.com/Kishanr7/SQL-practice


WITH groups AS (
    SELECT
        delivery_date,
        business_key,
        COUNT(*) AS row_count,
        COUNT(DISTINCT payload_hash) AS distinct_hash_count
    FROM deliveries
    GROUP BY delivery_date, business_key
)
SELECT
    delivery_date,
    SUM(
        CASE
            WHEN row_count > 1 AND distinct_hash_count = 1
            THEN 1 ELSE 0
        END
    ) AS duplicate_groups,
    SUM(
        CASE
            WHEN distinct_hash_count > 1
            THEN 1 ELSE 0
        END
    ) AS conflicting_keys
FROM groups
GROUP BY delivery_date
ORDER BY delivery_date;
