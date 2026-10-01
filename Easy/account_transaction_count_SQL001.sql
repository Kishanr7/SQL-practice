-- SQL001 · Joins and grain
-- Completed: 2026-09-28
-- Dialect: PostgreSQL
-- Output grain: one row per account
-- Requirement: retain accounts that have no transactions and return a count of 0.

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_name VARCHAR(50)
);

CREATE TABLE transactions (
    transaction_id VARCHAR(20),
    account_id INT,
    amount DECIMAL(12, 2),
    source_version INT
);

INSERT INTO accounts VALUES
(1, 'Asha'),
(2, 'Ben'),
(3, 'Chen');

INSERT INTO transactions VALUES
('t1', 1, 10.00, 1),
('t2', 1, 15.00, 1),
('t2', 1, 16.00, 2),
('t3', 2, 5.00, 1),
('t4', NULL, 8.00, 1),
('t5', 999, 9.00, 1);

SELECT
    a.account_id,
    COALESCE(COUNT(t.transaction_id), 0) AS transaction_count
FROM accounts a
LEFT JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY a.account_id
ORDER BY a.account_id;

-- Expected output:
-- account_id | transaction_count
-- 1          | 3
-- 2          | 1
-- 3          | 0

-- Checks covered:
-- 1. Account 3 is retained even with no matching transactions.
-- 2. COUNT(transaction_id) ignores the NULL produced by the LEFT JOIN.
-- 3. Duplicate/revised physical rows are counted separately, per the stated assumption.
-- 4. NULL and unknown account IDs do not create output rows.
