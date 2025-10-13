-- # Write your MySQL query statement below
SELECT
    query_name,
    ROUND(SUM(rating/position)/COUNT(rating),2) as quality,
    ROUND((SUM(rating < 3)/COUNT(rating))*100, 2) AS poor_query_percentage
FROM
queries
where query_name is not null
group by query_name