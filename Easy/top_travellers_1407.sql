# Write your MySQL query statement below
with total_travel as (
    SELECT 
        user_id,
        sum(distance) as travelled_distance  
    FROM rides
    GROUP BY user_id
)

select u.name, COALESCE(t.travelled_distance,0) AS travelled_distance 
from users u LEFT JOIN total_travel t ON u.id = t.user_id 
order by t.travelled_distance  desc, u.name asc