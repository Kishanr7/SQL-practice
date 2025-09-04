-- Write your PostgreSQL query statement below
SELECT
    sell_date,
    COUNT(DISTINCT product) as num_sold,
    STRING_AGG(DISTINCT product, ',' ORDER BY product) as products
FROM activities
GROUP BY sell_date

--  second solution

-- # Write your MySQL query statement below
SELECT 
    sell_date, 
    COUNT(DISTINCT product) AS num_sold, 
    GROUP_CONCAT(DISTINCT product ORDER BY product SEPARATOR ',') AS products 
FROM 
    Activities 
GROUP BY 
    sell_date 
ORDER BY 
    sell_date;