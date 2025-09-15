-- # Write your MySQL query statement below
-- MAke a single column of ID by doing a union on requester and accepter_id
-- then select the id and the count of it.
SELECT id, COUNT(*) as num FROM 
(SELECT requester_id as id FROM RequestAccepted
UNION ALL
SELECT accepter_id as id FROM RequestAccepted) ids
GROUP BY id
ORDER BY num DESC
LIMIT 1