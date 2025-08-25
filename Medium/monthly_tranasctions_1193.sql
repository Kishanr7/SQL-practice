-- # MY solution
WITH aprv_cte AS (
    SELECT
        country,
        COUNT(id) as approved_count,
        SUM(amount) as approved_total_amount,
        TO_CHAR(trans_date, 'YYYY-MM') as month
    FROM transactions
    WHERE state = 'approved'
    GROUP BY country, TO_CHAR(trans_date, 'YYYY-MM')
),

total_trans AS (
    SELECT
        country,
        COUNT(id) as trans_count,
        SUM(amount) as trans_total_amount,
        TO_CHAR(trans_date, 'YYYY-MM') as month
    FROM transactions
    GROUP BY country, TO_CHAR(trans_date, 'YYYY-MM')
)

SELECT 
    t.month,
    t.country,
    t.trans_count,
    COALESCE(a.approved_count, 0) as approved_count,
    t.trans_total_amount,
    COALESCE(a.approved_total_amount, 0) as approved_total_amount
    FROM total_trans t
    LEFT JOIN aprv_cte a
    ON a.country IS NOT DISTINCT FROM t.country and a.month = t.month

-- desired solution works on mysql

SELECT
    LEFT(trans_date, 7) as month,
    country,
    COUNT(id) as trans_count,
    SUM(state='approved') AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM((state='approved')*amount) AS approved_total_amount
FROM
    transactions
GROUP BY
    month, country;

-- another one
SELECT 
    DATE_FORMAT(trans_date ,'%Y-%m') AS month,
    country,
    COUNT(id) AS trans_count,
    SUM(state ='approved') AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(IF(state ='approved',amount,0)) AS approved_total_amount 
FROM Transactions
GROUP BY month, country