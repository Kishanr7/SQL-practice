-- Write your PostgreSQL query statement below
SELECT
    p.product_name,
    SUM(unit) as unit
FROM products p JOIN orders o ON p.product_id = o.product_id
WHERE TO_CHAR(o.order_date, 'YYYY-MM') = '2020-02' 
GROUP BY p.product_name
HAVING SUM(unit) >= 100


-- second with date format  Write your MySQL query statement below

SELECT product_name, SUM(unit) AS unit
FROM
    Orders AS o
    JOIN Products AS p ON o.product_id = p.product_id
WHERE DATE_FORMAT(order_date, '%Y-%m') = '2020-02'
GROUP BY o.product_id
HAVING unit >= 100;