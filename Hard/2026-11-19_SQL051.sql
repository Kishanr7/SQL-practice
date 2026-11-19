-- SQL051 · Deduplication and source versions
-- Completed: 2026-11-19
-- Task: Keep the latest version of each transaction and flag conflicts.
-- Validation: Passed
-- Repository: https://github.com/Kishanr7/SQL-practice

WITH latest_version AS (
    SELECT
        transaction_id,
        MAX(source_version) AS latest_version
    FROM deliveries
    GROUP BY transaction_id
),
checked AS (
    SELECT
        transaction_id,
        source_version,
        amount,
        CASE
            WHEN COUNT(*) OVER (
                PARTITION BY transaction_id, source_version
            ) > 1
            THEN 'CONFLICT'
            ELSE 'CANONICAL'
        END AS disposition
    FROM (
        SELECT DISTINCT ON (
            d.transaction_id,
            d.source_version,
            d.payload_hash
        )
            d.transaction_id,
            d.source_version,
            d.amount,
            d.payload_hash
        FROM deliveries d
        JOIN latest_version l
            ON d.transaction_id = l.transaction_id
           AND d.source_version = l.latest_version
        ORDER BY
            d.transaction_id,
            d.source_version,
            d.payload_hash,
            d.amount
    ) deduplicated
)
SELECT * 
FROM checked
ORDER BY transaction_id;