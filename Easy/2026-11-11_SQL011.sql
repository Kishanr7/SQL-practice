-- SQL011 · Aggregation and nulls
-- Completed: 2026-11-11
-- Task: Calculate each day's settled amount by currency. Keep NULL amounts separate from real zero amounts.
-- Validation: Passed
-- Repository: https://github.com/Kishanr7/SQL-practice

SELECT settled_on, currency,
	SUM(amount) as settled_total, 
	COUNT(CASE WHEN amount IS NULL THEN 1 ELSE NULL END) as null_amount_rows
FROM settlements
GROUP BY settled_on, currency
ORDER BY settled_on, currency;
