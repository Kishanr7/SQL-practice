-- Write your PostgreSQL query statement below
SELECT 
    u.user_id as buyer_id,
    u.join_date,
    count(distinct o.order_id) as orders_in_2019
FROM 
    users u LEFT JOIN
    orders o on u.user_id = o.buyer_id and year(o.order_date) = '2019'
GROUP BY u.user_id

-- https://mode.com/sql-tutorial/sql-joins-where-vs-on